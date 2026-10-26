import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { getAdminSession } from "@/lib/admin-auth";
import { SettingsSchema } from "@/lib/schemas";

// GET: read all settings
export async function GET() {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const db = createServerClient();
  const { data, error } = await db
    .from("app_settings")
    .select("key, value");

  if (error) {
    console.error("Settings read error:", error);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }

  // Convert rows to a key-value object
  const settings: Record<string, string> = {};
  for (const row of data ?? []) {
    settings[row.key] = row.value;
  }

  return NextResponse.json({
    seuilReussite: parseInt(settings.seuil_reussite ?? "65", 10),
    whatsappLink: settings.whatsapp_link ?? "",
    dureeMinutes: parseInt(settings.duree_minutes ?? "25", 10),
    nbQuestions: parseInt(settings.nb_questions ?? "25", 10),
  });
}

// PUT: update settings
export async function PUT(request: NextRequest) {
  const admin = await getAdminSession();
  if (!admin) {
    return NextResponse.json({ error: "Non autorisé" }, { status: 401 });
  }

  const body = await request.json();
  const parsed = SettingsSchema.safeParse(body);

  if (!parsed.success) {
    return NextResponse.json(
      { error: "Données invalides", details: parsed.error.flatten() },
      { status: 400 }
    );
  }

  const db = createServerClient();
  const updates: { key: string; value: string }[] = [];

  if (parsed.data.seuilReussite !== undefined) {
    updates.push({
      key: "seuil_reussite",
      value: String(parsed.data.seuilReussite),
    });
  }
  if (parsed.data.whatsappLink !== undefined) {
    updates.push({
      key: "whatsapp_link",
      value: parsed.data.whatsappLink,
    });
  }
  if (parsed.data.dureeMinutes !== undefined) {
    updates.push({
      key: "duree_minutes",
      value: String(parsed.data.dureeMinutes),
    });
  }
  if (parsed.data.nbQuestions !== undefined) {
    updates.push({
      key: "nb_questions",
      value: String(parsed.data.nbQuestions),
    });
  }

  // Upsert each setting
  for (const { key, value } of updates) {
    const { error } = await db
      .from("app_settings")
      .upsert({ key, value }, { onConflict: "key" });

    if (error) {
      console.error(`Settings update error for ${key}:`, error);
      return NextResponse.json(
        { error: `Erreur mise à jour: ${key}` },
        { status: 500 }
      );
    }
  }

  // Audit log
  await db.from("admin_audit_logs").insert({
    admin_email: admin.email,
    action: "update_settings",
    details: parsed.data,
  });

  return NextResponse.json({ success: true });
}
