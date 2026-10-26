import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { ProctorEventSchema } from "@/lib/schemas";

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = ProctorEventSchema.safeParse(body);

    if (!parsed.success) {
      return NextResponse.json({ error: "Données invalides" }, { status: 400 });
    }

    const db = createServerClient();

    const { error } = await db.from("proctoring_events").insert({
      attempt_id: parsed.data.attemptId,
      event_type: parsed.data.eventType,
      event_data: {
        timestamp: new Date().toISOString(),
        userAgent: request.headers.get("user-agent"),
      },
    });

    if (error) throw error;

    return NextResponse.json({ logged: true });
  } catch (err) {
    console.error("Proctor event error:", err);
    return NextResponse.json({ error: "Erreur serveur" }, { status: 500 });
  }
}
