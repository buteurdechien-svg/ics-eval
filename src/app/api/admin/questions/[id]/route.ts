import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { getAdminSession } from "@/lib/admin-auth";
import { QuestionSchema } from "@/lib/schemas";

// GET: single question with options
export async function GET(
  _request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const { id } = await params;
  const db = createServerClient();

  const { data: question } = await db
    .from("questions")
    .select(
      "id, enonce, explication, difficulte, actif, category_id, created_at, question_categories(code, nom), answer_options(id, texte, est_correcte, sort_order)"
    )
    .eq("id", id)
    .single();

  if (!question) {
    return NextResponse.json({ error: "Question introuvable" }, { status: 404 });
  }

  return NextResponse.json({
    id: question.id,
    enonce: question.enonce,
    explication: question.explication,
    difficulte: question.difficulte,
    actif: question.actif,
    categoryId: question.category_id,
    categorie: question.question_categories,
    options: question.answer_options,
    createdAt: question.created_at,
  });
}

// PUT: update question and its options
export async function PUT(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const { id } = await params;
  const body = await request.json();
  const parsed = QuestionSchema.safeParse(body);

  if (!parsed.success) {
    return NextResponse.json(
      { error: "Données invalides", details: parsed.error.flatten() },
      { status: 400 }
    );
  }

  const db = createServerClient();
  const { enonce, categoryId, difficulte, explication, actif, options } =
    parsed.data;

  // Update question
  const { error: qError } = await db
    .from("questions")
    .update({
      category_id: categoryId,
      enonce,
      explication,
      difficulte,
      actif,
    })
    .eq("id", id);

  if (qError) {
    console.error("Question update error:", qError);
    return NextResponse.json({ error: "Erreur mise à jour" }, { status: 500 });
  }

  // Replace options: delete old ones, insert new
  await db.from("answer_options").delete().eq("question_id", id);
  const optionsToInsert = options.map((o, i) => ({
    question_id: id,
    texte: o.texte,
    est_correcte: o.estCorrecte,
    sort_order: i + 1,
  }));
  await db.from("answer_options").insert(optionsToInsert);

  // Audit
  await db.from("admin_audit_logs").insert({
    admin_email: admin.email,
    action: "update_question",
    details: { questionId: id },
  });

  return NextResponse.json({ success: true });
}

// DELETE: deactivate (soft delete)
export async function DELETE(
  _request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const { id } = await params;
  const db = createServerClient();

  const { error } = await db
    .from("questions")
    .update({ actif: false })
    .eq("id", id);

  if (error) {
    return NextResponse.json({ error: "Erreur suppression" }, { status: 500 });
  }

  await db.from("admin_audit_logs").insert({
    admin_email: admin.email,
    action: "deactivate_question",
    details: { questionId: id },
  });

  return NextResponse.json({ success: true });
}
