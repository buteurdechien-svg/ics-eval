import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";

export async function GET(request: NextRequest) {
  try {
    const attemptId = request.nextUrl.searchParams.get("attemptId");
    if (!attemptId) {
      return NextResponse.json({ error: "attemptId requis" }, { status: 400 });
    }

    const db = createServerClient();

    // Get attempt
    const { data: attempt } = await db
      .from("attempts")
      .select("id, expires_at, status, candidate_id")
      .eq("id", attemptId)
      .single();

    if (!attempt) {
      return NextResponse.json({ error: "Tentative introuvable" }, { status: 404 });
    }

    // Check if expired
    const now = new Date();
    const expires = new Date(attempt.expires_at);
    if (now > expires || attempt.status === "expire") {
      return NextResponse.json({ error: "Tentative expirée" }, { status: 410 });
    }
    if (attempt.status === "soumis") {
      return NextResponse.json({ error: "Tentative déjà soumise" }, { status: 410 });
    }

    // Get the 25 questions for this attempt, with their options
    const { data: aqRows } = await db
      .from("attempt_questions")
      .select("question_id, sort_order")
      .eq("attempt_id", attemptId)
      .order("sort_order", { ascending: true });

    if (!aqRows?.length) {
      return NextResponse.json({ error: "Aucune question trouvée" }, { status: 500 });
    }

    const questionIds = aqRows.map((r) => r.question_id);

    // Get question texts (NOT the correct answer)
    const { data: questions } = await db
      .from("questions")
      .select("id, enonce")
      .in("id", questionIds);

    // Get options (NOT exposing est_correcte)
    const { data: options } = await db
      .from("answer_options")
      .select("id, question_id, texte, sort_order")
      .in("question_id", questionIds)
      .order("sort_order", { ascending: true });

    // Build response — shuffle option order per question (Fisher-Yates)
    const optionsByQuestion = new Map<string, typeof options>();
    for (const opt of options ?? []) {
      const list = optionsByQuestion.get(opt.question_id) ?? [];
      list.push(opt);
      optionsByQuestion.set(opt.question_id, list);
    }

    // Shuffle options within each question
    for (const [, opts] of optionsByQuestion) {
      if (!opts) continue;
      for (let i = opts.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [opts[i]!, opts[j]!] = [opts[j]!, opts[i]!];
      }
    }

    const questionMap = new Map(questions?.map((q) => [q.id, q]) ?? []);
    const sortedQuestions = aqRows.map((aq) => {
      const q = questionMap.get(aq.question_id);
      return {
        id: aq.question_id,
        enonce: q?.enonce ?? "",
        sortOrder: aq.sort_order,
        options: (optionsByQuestion.get(aq.question_id) ?? []).map((o) => ({
          id: o.id,
          texte: o.texte,
        })),
      };
    });

    // Get previously saved answers (for page refresh resilience)
    const { data: savedAnswers } = await db
      .from("attempt_answers")
      .select("question_id, selected_option_id")
      .eq("attempt_id", attemptId);

    return NextResponse.json({
      expiresAt: attempt.expires_at,
      questions: sortedQuestions,
      savedAnswers: (savedAnswers ?? []).map((sa) => ({
        questionId: sa.question_id,
        selectedOptionId: sa.selected_option_id,
      })),
    });
  } catch (err) {
    console.error("Attempt start error:", err);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
