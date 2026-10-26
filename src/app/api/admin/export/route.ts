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
  const format = url.searchParams.get("format") ?? "csv";

  if (format !== "csv") {
    return NextResponse.json(
      { error: "Format non supporté. Utilisez csv." },
      { status: 400 }
    );
  }

  // Fetch all submitted attempts with candidate info
  const { data: attempts, error } = await db
    .from("attempts")
    .select(
      "id, status, pourcentage, bonnes_reponses, total_questions, admis, appreciation, duree_secondes, started_at, submitted_at, candidates(nom, prenom, email)"
    )
    .eq("status", "soumis")
    .order("submitted_at", { ascending: false });

  if (error) {
    console.error("Export error:", error);
    return NextResponse.json({ error: "Erreur export" }, { status: 500 });
  }

  // Build CSV
  const headers = [
    "Nom",
    "Prénom",
    "Email",
    "Score (%)",
    "Bonnes réponses",
    "Total questions",
    "Admis",
    "Appréciation",
    "Durée (s)",
    "Date de passage",
    "ID tentative",
  ];

  const escapeCSV = (val: string) => {
    if (val.includes(",") || val.includes('"') || val.includes("\n")) {
      return `"${val.replace(/"/g, '""')}"`;
    }
    return val;
  };

  const rows = (attempts ?? []).map((a) => {
    const c = a.candidates as unknown as { nom: string; prenom: string; email: string } | null;
    return [
      escapeCSV(c?.nom ?? ""),
      escapeCSV(c?.prenom ?? ""),
      escapeCSV(c?.email ?? ""),
      String(a.pourcentage ?? 0),
      String(a.bonnes_reponses ?? 0),
      String(a.total_questions ?? 0),
      a.admis ? "OUI" : "NON",
      escapeCSV(a.appreciation ?? ""),
      String(a.duree_secondes ?? ""),
      a.submitted_at ?? "",
      a.id,
    ].join(",");
  });

  const csv = "﻿" + [headers.join(","), ...rows].join("\n");

  // Audit log
  await db.from("admin_audit_logs").insert({
    admin_email: admin.email,
    action: "export_csv",
    details: { count: rows.length },
  });

  return new NextResponse(csv, {
    status: 200,
    headers: {
      "Content-Type": "text/csv; charset=utf-8",
      "Content-Disposition": `attachment; filename="resultats_ics_eval_${new Date().toISOString().slice(0, 10)}.csv"`,
    },
  });
}
