"use client";

import { useEffect, useState } from "react";
import { useRouter, useParams } from "next/navigation";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";

interface CandidateDetail {
  candidat: {
    id: string;
    nom: string;
    prenom: string;
    email: string;
    createdAt: string;
  };
  attempts: {
    id: string;
    status: string;
    pourcentage: number | null;
    bonnes_reponses: number | null;
    total_questions: number | null;
    admis: boolean | null;
    appreciation: string | null;
    duree_secondes: number | null;
    started_at: string;
    submitted_at: string | null;
    proctoringEvents: {
      event_type: string;
      created_at: string;
    }[];
  }[];
}

export default function CandidateDetailPage() {
  const router = useRouter();
  const params = useParams<{ id: string }>();
  const [data, setData] = useState<CandidateDetail | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`/api/admin/candidates/${params.id}`)
      .then((r) => {
        if (r.status === 401) {
          router.push("/admin/login");
          return null;
        }
        return r.json();
      })
      .then((d) => {
        if (d && !d.error) setData(d);
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [params.id, router]);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-32">
        <div className="w-6 h-6 border-2 border-electric border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (!data) {
    return (
      <div className="text-center py-12 text-text-muted">
        Candidat introuvable
      </div>
    );
  }

  const { candidat, attempts } = data;

  return (
    <div className="space-y-8">
      <div className="flex items-start justify-between">
        <div>
          <button
            onClick={() => router.push("/admin/candidates")}
            className="text-xs text-text-muted hover:text-text-secondary mb-2 flex items-center gap-1"
          >
            ← Retour aux candidats
          </button>
          <h1 className="text-2xl font-semibold text-text-primary">
            {candidat.prenom} {candidat.nom}
          </h1>
          <p className="text-sm text-text-secondary mt-1">{candidat.email}</p>
          <p className="text-xs text-text-muted mt-1">
            Inscrit le{" "}
            {new Date(candidat.createdAt).toLocaleDateString("fr-FR", {
              day: "2-digit",
              month: "long",
              year: "numeric",
              timeZone: "Africa/Abidjan",
            })}
          </p>
        </div>
      </div>

      {/* Attempts */}
      <div className="space-y-4">
        <h2 className="text-lg font-semibold text-text-primary">
          Tentatives ({attempts.length})
        </h2>

        {attempts.length === 0 && (
          <p className="text-text-muted text-sm">Aucune tentative</p>
        )}

        {attempts.map((a) => (
          <div key={a.id} className="card p-5 space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
              <div className="flex items-center gap-3">
                {a.admis != null && (
                  <Badge variant={a.admis ? "phosphor" : "signal"}>
                    {a.admis ? "Admis" : "Non admis"}
                  </Badge>
                )}
                {a.status !== "soumis" && (
                  <Badge variant="amber">{a.status}</Badge>
                )}
                {a.pourcentage != null && (
                  <span className="font-mono text-lg font-bold text-text-primary">
                    {a.pourcentage}%
                  </span>
                )}
              </div>
              <div className="text-xs text-text-muted space-y-0.5">
                <p>
                  Début :{" "}
                  {new Date(a.started_at).toLocaleString("fr-FR", {
                    timeZone: "Africa/Abidjan",
                  })}
                </p>
                {a.submitted_at && (
                  <p>
                    Soumis :{" "}
                    {new Date(a.submitted_at).toLocaleString("fr-FR", {
                      timeZone: "Africa/Abidjan",
                    })}
                  </p>
                )}
              </div>
            </div>

            {/* Stats row */}
            {a.status === "soumis" && (
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
                <div>
                  <p className="text-xs text-text-muted">Score</p>
                  <p className="text-sm font-semibold text-text-primary">
                    {a.bonnes_reponses}/{a.total_questions}
                  </p>
                </div>
                <div>
                  <p className="text-xs text-text-muted">Durée</p>
                  <p className="text-sm font-semibold text-text-primary">
                    {a.duree_secondes != null
                      ? `${Math.floor(a.duree_secondes / 60)}min ${a.duree_secondes % 60}s`
                      : "—"}
                  </p>
                </div>
                <div>
                  <p className="text-xs text-text-muted">Appréciation</p>
                  <p className="text-sm text-text-primary">
                    {a.appreciation ?? "—"}
                  </p>
                </div>
                <div>
                  <p className="text-xs text-text-muted">Alertes proctoring</p>
                  <p className="text-sm font-semibold text-text-primary">
                    {a.proctoringEvents.length}
                  </p>
                </div>
              </div>
            )}

            {/* Proctoring events */}
            {a.proctoringEvents.length > 0 && (
              <details className="text-xs">
                <summary className="text-text-muted cursor-pointer hover:text-text-secondary">
                  Voir les événements de proctoring (
                  {a.proctoringEvents.length})
                </summary>
                <div className="mt-2 space-y-1 pl-3 border-l-2 border-border-default">
                  {a.proctoringEvents.map((evt, i) => (
                    <p key={i} className="text-text-secondary">
                      <span className="text-text-muted">
                        {new Date(evt.created_at).toLocaleTimeString("fr-FR", {
                          timeZone: "Africa/Abidjan",
                        })}
                      </span>{" "}
                      — {evt.event_type}
                    </p>
                  ))}
                </div>
              </details>
            )}

            {/* PV link */}
            {a.status === "soumis" && (
              <div className="pt-2 border-t border-border-muted">
                <Button
                  variant="secondary"
                  onClick={() => window.open(`/api/pv/${a.id}`, "_blank")}
                >
                  Télécharger le PV (PDF)
                </Button>
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
