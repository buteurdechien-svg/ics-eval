import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { getAdminSession } from "@/lib/admin-auth";
import { QuestionSchema } from "@/lib/schemas";

// GET: list all questions with options and categories
export async function GET(request: NextRequest) {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const db = createServerClient();
  const url = request.nextUrl;
  const categoryCode = url.searchParams.get("category");
  const page = parseInt(url.searchParams.get("page") ?? "1", 10);
  const perPage = parseInt(url.searchParams.get("perPage") ?? "20", 10);

  let query = db
    .from("questions")
    .select(
      "id, enonce, difficulte, actif, created_at, question_categories(code, nom), answer_options(id, texte, est_correcte, sort_order)",
      { count: "exact" }
    )
    .order("created_at", { ascending: false })
    .range((page - 1) * perPage, page * perPage - 1);

  if (categoryCode) {
    // Filter by category code via subquery
    const { data: cat } = await db
      .from("question_categories")
      .select("id")
      .eq("code", categoryCode)
      .single();
    if (cat) {
      query = query.eq("category_id", cat.id);
    }
  }

  const { data, count, error } = await query;

  if (error) {
    console.error("Questions list error:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }

  return NextResponse.json({
    questions: (data ?? []).map((q) => ({
      id: q.id,
      enonce: q.enonce,
      difficulte: q.difficulte,
      actif: q.actif,
      createdAt: q.created_at,
      categorie: q.question_categories,
      options: q.answer_options,
    })),
    total: count ?? 0,
    page,
    perPage,
  });
}

// POST: create a new question with options
export async function POST(request: NextRequest) {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

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

  // Insert question
  const { data: question, error: qError } = await db
    .from("questions")
    .insert({
      category_id: categoryId,
      enonce,
      explication,
      difficulte,
      actif,
    })
    .select("id")
    .single();

  if (qError || !question) {
    console.error("Question insert error:", qError);
    return NextResponse.json({ error: "Erreur création question" }, { status: 500 });
  }

  // Insert options
  const optionsToInsert = options.map((o, i) => ({
    question_id: question.id,
    texte: o.texte,
    est_correcte: o.estCorrecte,
    sort_order: i + 1,
  }));

  const { error: oError } = await db
    .from("answer_options")
    .insert(optionsToInsert);

  if (oError) {
    console.error("Options insert error:", oError);
    // Rollback question
    await db.from("questions").delete().eq("id", question.id);
    return NextResponse.json({ error: "Erreur création options" }, { status: 500 });
  }

  // Audit log
  await db.from("admin_audit_logs").insert({
    admin_email: admin.email,
    action: "create_question",
    details: { questionId: question.id, enonce: enonce.substring(0, 80) },
  });

  return NextResponse.json({ id: question.id }, { status: 201 });
}
