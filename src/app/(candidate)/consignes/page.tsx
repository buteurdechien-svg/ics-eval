"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";

export default function ConsignesPage() {
  const router = useRouter();
  const [confirmed, setConfirmed] = useState(false);
  const [attemptId, setAttemptId] = useState<string | null>(null);

  useEffect(() => {
    const id = sessionStorage.getItem("ics_attempt_id");
    if (!id) {
      router.replace("/");
      return;
    }
    setAttemptId(id);
  }, [router]);

  const handleStart = () => {
    if (confirmed && attemptId) {
      router.push("/test");
    }
  };

  if (!attemptId) return null;

  return (
    <div className="min-h-dvh flex items-center justify-center px-4 py-12">
      <main className="w-full max-w-lg space-y-6">
        <div className="space-y-2">
          <h1 className="text-xl font-bold text-text-primary">
            Consignes avant le test
          </h1>
          <p className="text-sm text-text-secondary">
            Lis attentivement avant de commencer.
          </p>
        </div>

        <div className="card p-6 space-y-4 text-sm text-text-secondary leading-relaxed">
          <p>
            Avant de commencer, assure-toi d'être dans un environnement calme
            et de ranger les documents ou appareils non autorisés.
          </p>
          <p>
            Cette évaluation comporte <strong className="text-text-primary">25 questions</strong> et
            dure <strong className="text-text-primary">25 minutes</strong>.
            Les changements d'onglet ou la perte de visibilité de la page
            peuvent être détectés et enregistrés comme événements de
            surveillance.
          </p>
          <p>
            Aucune caméra ni aucun enregistrement vidéo ne seront utilisés.
          </p>
          <p>
            Une fois le temps écoulé, le test sera soumis automatiquement.
            Réponds honnêtement afin que tes résultats reflètent ton niveau réel
            et permettent d'identifier les compétences à renforcer.
          </p>
        </div>

        <label className="flex items-start gap-3 cursor-pointer group">
          <input
            type="checkbox"
            checked={confirmed}
            onChange={(e) => setConfirmed(e.target.checked)}
            className="mt-0.5 w-4 h-4 rounded border-border-default bg-bg-raised
              text-electric focus:ring-electric/40 focus:ring-2 focus:ring-offset-0
              cursor-pointer"
          />
          <span className="text-sm text-text-secondary group-hover:text-text-primary transition-colors">
            J'ai lu et compris les consignes. Je suis prêt à commencer
            l'évaluation.
          </span>
        </label>

        <Button onClick={handleStart} disabled={!confirmed} className="w-full">
          Démarrer le test
        </Button>
      </main>
    </div>
  );
}
