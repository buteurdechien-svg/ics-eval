import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { getAdminSession } from "@/lib/admin-auth";

export async function GET(request: NextRequest) {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const db = createServerClient();
  const url = request.nextUrl;
  const page = parseInt(url.searchParams.get("page") ?? "1", 10);
  const perPage = parseInt(url.searchParams.get("perPage") ?? "20", 10);
  const search = url.searchParams.get("search") ?? "";

  let query = db
    .from("candidates")
    .select(
      "id, nom, prenom, email, created_at, attempts(id, status, pourcentage, admis, bonnes_reponses, total_questions, started_at)",
      { count: "exact" }
    )
    .order("created_at", { ascending: false })
    .range((page - 1) * perPage, page * perPage - 1);

  if (search) {
    query = query.or(
      `nom.ilike.%${search}%,prenom.ilike.%${search}%,email.ilike.%${search}%`
    );
  }

  const { data, count, error } = await query;

  if (error) {
    console.error("Candidates list error:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }

  return NextResponse.json({
    candidates: (data ?? []).map((c) => ({
      id: c.id,
      nom: c.nom,
      prenom: c.prenom,
      email: c.email,
      createdAt: c.created_at,
      attempts: c.attempts,
    })),
    total: count ?? 0,
    page,
    perPage,
  });
}
