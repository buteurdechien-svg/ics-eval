import { NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { getAdminSession } from "@/lib/admin-auth";

export async function GET() {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const db = createServerClient();
  const { data } = await db
    .from("question_categories")
    .select("id, code, nom")
    .order("nom");

  return NextResponse.json({ categories: data ?? [] });
}
