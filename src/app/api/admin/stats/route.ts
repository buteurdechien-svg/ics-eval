import { NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { getAdminSession } from "@/lib/admin-auth";

export async function GET() {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const db = createServerClient();

  // Parallel queries
  const [
    { count: totalCandidates },
    { count: totalAttempts },
    { count: submittedAttempts },
    { data: admisCount },
    { data: avgScore },
    { data: recentAttempts },
    { count: totalQuestions },
    { data: domainStats },
  ] = await Promise.all([
    db.from("candidates").select("*", { count: "exact", head: true }),
    db.from("attempts").select("*", { count: "exact", head: true }),
    db
      .from("attempts")
      .select("*", { count: "exact", head: true })
      .eq("status", "soumis"),
    db
      .from("attempts")
      .select("admis")
      .eq("status", "soumis")
      .eq("admis", true),
    db
      .from("attempts")
      .select("pourcentage")
      .eq("status", "soumis")
      .not("pourcentage", "is", null),
    db
      .from("attempts")
      .select(
        "id, pourcentage, bonnes_reponses, total_questions, admis, started_at, candidates(nom, prenom, email)"
      )
      .eq("status", "soumis")
      .order("started_at", { ascending: false })
      .limit(10),
    db
      .from("questions")
      .select("*", { count: "exact", head: true })
      .eq("actif", true),
    db.from("question_categories").select("code, nom"),
  ]);

  // Calculate average score
  const scores = (avgScore ?? []).map((a) => Number(a.pourcentage));
  const moyenne =
    scores.length > 0
      ? Math.round(scores.reduce((s, v) => s + v, 0) / scores.length)
      : 0;

  // Calculate pass rate
  const passRate =
    submittedAttempts && submittedAttempts > 0
      ? Math.round(((admisCount?.length ?? 0) / submittedAttempts) * 100)
      : 0;

  return NextResponse.json({
    totalCandidates: totalCandidates ?? 0,
    totalAttempts: totalAttempts ?? 0,
    submittedAttempts: submittedAttempts ?? 0,
    totalQuestions: totalQuestions ?? 0,
    admisCount: admisCount?.length ?? 0,
    moyenne,
    passRate,
    domainStats: domainStats ?? [],
    recentAttempts: (recentAttempts ?? []).map((a) => ({
      id: a.id,
      pourcentage: a.pourcentage,
      bonnesReponses: a.bonnes_reponses,
      totalQuestions: a.total_questions,
      admis: a.admis,
      startedAt: a.started_at,
      candidat: a.candidates,
    })),
  });
}
