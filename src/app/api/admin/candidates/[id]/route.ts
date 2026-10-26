import { NextRequest, NextResponse } from "next/server";
import { createServerClient } from "@/lib/supabase-server";
import { getAdminSession } from "@/lib/admin-auth";

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

  const { data: candidate } = await db
    .from("candidates")
    .select("id, nom, prenom, email, created_at")
    .eq("id", id)
    .single();

  if (!candidate) {
    return NextResponse.json({ error: "Candidat introuvable" }, { status: 404 });
  }

  // Get all attempts with proctoring events
  const { data: attempts } = await db
    .from("attempts")
    .select(
      "id, status, pourcentage, bonnes_reponses, total_questions, admis, appreciation, domaines_json, points_forts, points_faibles, duree_secondes, started_at, submitted_at, expires_at"
    )
    .eq("candidate_id", id)
    .order("started_at", { ascending: false });

  // Get proctoring events for all attempts
  const attemptIds = (attempts ?? []).map((a) => a.id);
  const { data: proctoringEvents } = attemptIds.length
    ? await db
        .from("proctoring_events")
        .select("attempt_id, event_type, event_data, created_at")
        .in("attempt_id", attemptIds)
        .order("created_at", { ascending: true })
    : { data: [] };

  // Group proctoring events by attempt
  const eventsByAttempt = new Map<string, typeof proctoringEvents>();
  for (const evt of proctoringEvents ?? []) {
    const list = eventsByAttempt.get(evt.attempt_id) ?? [];
    list.push(evt);
    eventsByAttempt.set(evt.attempt_id, list);
  }

  return NextResponse.json({
    candidat: {
      id: candidate.id,
      nom: candidate.nom,
      prenom: candidate.prenom,
      email: candidate.email,
      createdAt: candidate.created_at,
    },
    attempts: (attempts ?? []).map((a) => ({
      ...a,
      proctoringEvents: eventsByAttempt.get(a.id) ?? [],
    })),
  });
}
