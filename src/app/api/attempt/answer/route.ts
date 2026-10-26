import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { AnswerSchema } from "@/lib/schemas";
import { validateAttempt } from "@/lib/attempt";

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = AnswerSchema.safeParse(body);

    if (!parsed.success) {
      return NextResponse.json({ error: "Données invalides" }, { status: 400 });
    }

    const { attemptId, questionId, selectedOptionId } = parsed.data;

    // Validate attempt is still active
    const { valid, reason } = await validateAttempt(attemptId);
    if (!valid) {
      return NextResponse.json({ error: reason }, { status: 410 });
    }

    const db = createServerClient();

    // Verify the question belongs to this attempt
    const { data: aq } = await db
      .from("attempt_questions")
      .select("id")
      .eq("attempt_id", attemptId)
      .eq("question_id", questionId)
      .single();

    if (!aq) {
      return NextResponse.json(
        { error: "Question non associée à cette tentative" },
        { status: 400 }
      );
    }

    // Verify the option belongs to this question
    const { data: option } = await db
      .from("answer_options")
      .select("id, est_correcte")
      .eq("id", selectedOptionId)
      .eq("question_id", questionId)
      .single();

    if (!option) {
      return NextResponse.json(
        { error: "Option invalide pour cette question" },
        { status: 400 }
      );
    }

    // Upsert answer (allow changing answer before submission)
    const { error } = await db
      .from("attempt_answers")
      .upsert(
        {
          attempt_id: attemptId,
          question_id: questionId,
          selected_option_id: selectedOptionId,
          est_correcte: option.est_correcte,
          answered_at: new Date().toISOString(),
        },
        { onConflict: "attempt_id,question_id" }
      );

    if (error) throw error;

    return NextResponse.json({ saved: true });
  } catch (err) {
    console.error("Answer save error:", err);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
