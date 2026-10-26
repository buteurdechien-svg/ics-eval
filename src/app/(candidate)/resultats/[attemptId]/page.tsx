"use client";

import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";

interface DomainResult {
  nom: string;
  bonnesReponses: number;
  totalQuestions: number;
  pourcentage: number;
  competencesAmeliorer: string[];
  recommandations: string[];
}

interface ResultData {
  candidat: { nom: string; prenom: string };
  attempt: {
    id: string;
    pourcentage: number;
    bonnesReponses: number;
    totalQuestions: number;
    appreciation: string;
    admis: boolean;
    domaines: DomainResult[];
    pointsForts: string[];
    pointsFaibles: string[];
    dureeSecondes: number;
  };
  whatsappLink?: string;
}

export default function ResultatsPage() {
  const params = useParams();
  const attemptId = params.attemptId as string;
  const [data, setData] = useState<ResultData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    // Verify this is the user's own attempt
    const storedAttemptId = sessionStorage.getItem("ics_attempt_id");

    fetch(`/api/attempt/submit`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ attemptId }),
    }).catch(() => {});

    fetch(`/api/pv/${attemptId}?format=json`, {
      headers: storedAttemptId === attemptId
        ? { "x-attempt-token": storedAttemptId }
        : {},
    })
      .then((r) => {
        if (!r.ok) throw new Error("Accès non autorisé");
        return r.json();
      })
      .then(setData)
      .catch(() => setError("Impossible de charger les résultats."))
      .finally(() => setLoading(false));
  }, [attemptId]);

  if (loading) {
    return (
      <div className="min-h-dvh flex items-center justify-center">
        <p className="text-text-muted text-sm">Chargement des résultats…</p>
      </div>
    );
  }

  if (error || !data) {
    return (
      <div className="min-h-dvh flex items-center justify-center">
        <p className="text-signal text-sm">{error || "Résultats introuvables."}</p>
      </div>
    );
  }

  const { candidat, attempt } = data;
  const formatDuration = (s: number) => {
    const m = Math.floor(s / 60);
    const sec = s % 60;
    return `${m} min ${sec.toString().padStart(2, "0")} s`;
  };

  return (
    <div className="min-h-dvh px-4 py-8">
      <main className="max-w-xl mx-auto space-y-6">
        {/* Status banner */}
        <div
          className={`card p-6 text-center space-y-2 border ${
            attempt.admis ? "border-phosphor/30" : "border-signal/30"
          }`}
        >
          <Badge variant={attempt.admis ? "phosphor" : "signal"}>
            {attempt.admis ? "Admis au seuil" : "Seuil non atteint"}
          </Badge>
          <h1 className="text-xl font-bold text-text-primary">
            {candidat.prenom} {candidat.nom}
          </h1>
          <div className="text-4xl font-bold font-mono text-text-primary">
            {attempt.pourcentage}%
          </div>
          <p className="text-sm text-text-secondary">
            {attempt.bonnesReponses}/{attempt.totalQuestions} bonnes réponses
            — {formatDuration(attempt.dureeSecondes)}
          </p>
          <p className="text-sm text-text-secondary">
            {attempt.appreciation}
          </p>
        </div>

        {/* Message */}
        <div className="card p-5 text-sm text-text-secondary leading-relaxed space-y-3">
          {attempt.admis ? (
            <>
              <p>
                Félicitations ! Tu as atteint le seuil requis pour accéder à la
                prochaine étape de la formation.
              </p>
              <p>
                Télécharge ton procès-verbal et prends le temps d'étudier les
                compétences pour lesquelles ton score est le plus faible.
              </p>
              <p className="text-xs text-text-muted">
                Ton résultat ne signifie pas que tu maîtrises déjà le pentest
                web en pratique : il constitue une évaluation de tes
                connaissances théoriques.
              </p>
            </>
          ) : (
            <>
              <p>Merci d'avoir participé à cette évaluation.</p>
              <p>
                Ton résultat indique que certaines bases doivent encore être
                consolidées avant la prochaine formation. Consulte ton
                procès-verbal, révise les domaines où ton score est le plus
                faible et prépare-toi pour la prochaine session.
              </p>
            </>
          )}
        </div>

        {/* Domain breakdown */}
        <div className="card p-5 space-y-4">
          <h2 className="text-sm font-semibold text-text-primary">
            Résultats par domaine
          </h2>
          {attempt.domaines.map((d) => {
            const variant =
              d.pourcentage < 0
                ? "muted"
                : d.pourcentage >= 70
                ? "phosphor"
                : d.pourcentage >= 50
                ? "amber"
                : "signal";
            return (
              <div key={d.nom} className="space-y-2">
                <div className="flex items-center justify-between">
                  <span className="text-sm text-text-primary">{d.nom}</span>
                  <span className="text-xs font-mono text-text-secondary">
                    {d.pourcentage < 0
                      ? "Non évalué"
                      : `${d.bonnesReponses}/${d.totalQuestions}`}
                  </span>
                </div>
                {d.pourcentage >= 0 && (
                  <Progress
                    value={d.pourcentage}
                    variant={variant as "phosphor" | "amber" | "signal"}
                    height="sm"
                  />
                )}
                {d.recommandations.length > 0 && (
                  <ul className="text-xs text-text-muted space-y-0.5 pl-3">
                    {d.recommandations.map((r, i) => (
                      <li key={i}>— {r}</li>
                    ))}
                  </ul>
                )}
              </div>
            );
          })}
        </div>

        {/* Points forts / faibles */}
        <div className="grid grid-cols-2 gap-3">
          <div className="card p-4 space-y-2">
            <h3 className="text-xs font-semibold text-phosphor">Points forts</h3>
            {attempt.pointsForts.length > 0 ? (
              <ul className="text-xs text-text-secondary space-y-1">
                {attempt.pointsForts.map((p) => (
                  <li key={p}>— {p}</li>
                ))}
              </ul>
            ) : (
              <p className="text-xs text-text-muted">Aucun domaine au-dessus de 70%</p>
            )}
          </div>
          <div className="card p-4 space-y-2">
            <h3 className="text-xs font-semibold text-signal">À renforcer</h3>
            {attempt.pointsFaibles.length > 0 ? (
              <ul className="text-xs text-text-secondary space-y-1">
                {attempt.pointsFaibles.map((p) => (
                  <li key={p}>— {p}</li>
                ))}
              </ul>
            ) : (
              <p className="text-xs text-text-muted">Tous les domaines au-dessus de 50%</p>
            )}
          </div>
        </div>

        {/* Actions */}
        <div className="space-y-3">
          <a href={`/api/pv/${attemptId}`} download>
            <Button className="w-full">
              Télécharger le procès-verbal (PDF)
            </Button>
          </a>

          {attempt.admis && data.whatsappLink && (
            <a
              href={data.whatsappLink}
              target="_blank"
              rel="noopener noreferrer"
            >
              <Button variant="secondary" className="w-full mt-3">
                Rejoindre le groupe WhatsApp
              </Button>
            </a>
          )}
        </div>

        <p className="text-[10px] text-text-muted text-center leading-relaxed">
          Cette évaluation est théorique et de niveau débutant. Elle ne
          constitue pas une certification professionnelle.
        </p>
      </main>
    </div>
  );
}
