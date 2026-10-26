import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { RegisterSchema } from "@/lib/schemas";
import { selectQuestions } from "@/lib/attempt";

// Simple in-memory rate limiter (per IP, 5 registrations per minute)
const rateLimitMap = new Map<string, { count: number; resetAt: number }>();

function checkRateLimit(ip: string): boolean {
  const now = Date.now();
  const entry = rateLimitMap.get(ip);
  if (!entry || now > entry.resetAt) {
    rateLimitMap.set(ip, { count: 1, resetAt: now + 60_000 });
    return true;
  }
  entry.count++;
  return entry.count <= 5;
}

export async function POST(request: NextRequest) {
  try {
    const ip =
      request.headers.get("x-forwarded-for")?.split(",")[0]?.trim() ??
      "unknown";

    if (!checkRateLimit(ip)) {
      return NextResponse.json(
        { message: "Trop de tentatives. Réessayez dans une minute." },
        { status: 429 }
      );
    }

    const body = await request.json();
    const parsed = RegisterSchema.safeParse(body);

    if (!parsed.success) {
      return NextResponse.json(
        { errors: parsed.error.issues },
        { status: 400 }
      );
    }

    const { nom, prenom, email } = parsed.data;
    const db = createServerClient();

    // Chercher ou créer le candidat
    let { data: candidate } = await db
      .from("candidates")
      .select("id")
      .eq("email", email)
      .single();

    if (!candidate) {
      const { data: newCandidate, error } = await db
        .from("candidates")
        .insert({ nom, prenom, email })
        .select("id")
        .single();
      if (error) throw error;
      candidate = newCandidate;
    }

    // Récupérer les paramètres
    const { data: settings } = await db
      .from("app_settings")
      .select("key, value")
      .in("key", ["duree_minutes", "nb_questions"]);
    const settingsMap = new Map(settings?.map((s) => [s.key, s.value]) ?? []);
    const dureeMinutes = parseInt(settingsMap.get("duree_minutes") ?? "25", 10);

    // Créer la tentative
    const expiresAt = new Date(Date.now() + dureeMinutes * 60 * 1000);
    const { data: attempt, error: attemptError } = await db
      .from("attempts")
      .insert({
        candidate_id: candidate!.id,
        expires_at: expiresAt.toISOString(),
        total_questions: 25,
        ip_address: ip,
        user_agent: request.headers.get("user-agent") ?? "",
      })
      .select("id")
      .single();

    if (attemptError) throw attemptError;

    // Sélectionner et enregistrer les questions
    const questions = await selectQuestions();
    const aqRows = questions.map((q) => ({
      attempt_id: attempt!.id,
      question_id: q.questionId,
      sort_order: q.sortOrder,
    }));

    const { error: aqError } = await db
      .from("attempt_questions")
      .insert(aqRows);
    if (aqError) throw aqError;

    return NextResponse.json({
      candidateId: candidate!.id,
      attemptId: attempt!.id,
      expiresAt: expiresAt.toISOString(),
    });
  } catch (err) {
    console.error("Registration error:", err);
    return NextResponse.json(
      { message: "Erreur serveur. Réessayez." },
      { status: 500 }
    );
  }
}
