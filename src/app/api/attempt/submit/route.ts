import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { validateAttempt } from "@/lib/attempt";
import { computeScore, DOMAINES } from "@/lib/scoring";

export async function POST(request: NextRequest) {
  try {
    const { attemptId } = await request.json();
    if (!attemptId) {
      return NextResponse.json({ error: "attemptId requis" }, { status: 400 });
    }

    const db = createServerClient();

    // Check attempt validity (allow expired — auto-submit on expiry)
    const { data: attempt } = await db
      .from("attempts")
      .select("*")
      .eq("id", attemptId)
      .single();

    if (!attempt) {
      return NextResponse.json({ error: "Tentative introuvable" }, { status: 404 });
    }

    // Prevent double submission
    if (attempt.status === "soumis") {
      return NextResponse.json({ attemptId, alreadySubmitted: true });
    }

    // Get the answers with their question info
    const { data: aqRows } = await db
      .from("attempt_questions")
      .select("question_id")
      .eq("attempt_id", attemptId);

    const questionIds = aqRows?.map((r) => r.question_id) ?? [];

    // Get question categories
    const { data: questions } = await db
      .from("questions")
      .select("id, category_id")
      .in("id", questionIds);

    const { data: categories } = await db
      .from("question_categories")
      .select("id, code, nom");

    const catMap = new Map(categories?.map((c) => [c.id, c]) ?? []);

    // Get saved answers
    const { data: answers } = await db
      .from("attempt_answers")
      .select("question_id, est_correcte")
      .eq("attempt_id", attemptId);

    const answerMap = new Map(answers?.map((a) => [a.question_id, a.est_correcte]) ?? []);

    // Build results array
    const results = (questions ?? []).map((q) => {
      const cat = catMap.get(q.category_id);
      return {
        questionId: q.id,
        domaineId: cat?.code ?? "unknown",
        domaineName: cat?.nom ?? "Inconnu",
        correct: answerMap.get(q.id) === true,
      };
    });

    // Get scoring settings
    const { data: settings } = await db
      .from("app_settings")
      .select("key, value")
      .in("key", ["seuil_reussite"]);
    const seuil = parseInt(
      settings?.find((s) => s.key === "seuil_reussite")?.value ?? "65",
      10
    );
    const seuilBonnes = Math.ceil((seuil / 100) * attempt.total_questions);

    const scoring = computeScore(results, seuil, seuilBonnes);

    // Calculate duration
    const startedAt = new Date(attempt.started_at);
    const now = new Date();
    const dureeSecondes = Math.floor((now.getTime() - startedAt.getTime()) / 1000);

    // Update attempt
    const { error: updateError } = await db
      .from("attempts")
      .update({
        submitted_at: now.toISOString(),
        score_global: scoring.scoreGlobal,
        bonnes_reponses: scoring.bonnesReponsesTotal,
        pourcentage: scoring.pourcentageGlobal,
        appreciation: scoring.appreciation,
        admis: scoring.admis,
        domaines_json: scoring.domaines,
        points_forts: scoring.pointsForts,
        points_faibles: scoring.pointsFaibles,
        duree_secondes: dureeSecondes,
        status: "soumis",
      })
      .eq("id", attemptId);

    if (updateError) throw updateError;

    return NextResponse.json({ attemptId });
  } catch (err) {
    console.error("Submit error:", err);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
