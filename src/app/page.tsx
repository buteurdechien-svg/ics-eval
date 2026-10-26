"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

export default function Home() {
  const router = useRouter();
  const [form, setForm] = useState({ nom: "", prenom: "", email: "" });
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [loading, setLoading] = useState(false);
  const [serverError, setServerError] = useState("");

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
    setErrors((prev) => ({ ...prev, [e.target.name]: "" }));
    setServerError("");
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setServerError("");

    try {
      const res = await fetch("/api/register", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });
      const data = await res.json();

      if (!res.ok) {
        if (data.errors) {
          const fieldErrors: Record<string, string> = {};
          for (const err of data.errors) {
            if (err.path?.[0]) fieldErrors[err.path[0]] = err.message;
          }
          setErrors(fieldErrors);
        } else {
          setServerError(data.message ?? "Une erreur est survenue.");
        }
        return;
      }

      // Store candidateId + attemptId in sessionStorage then redirect
      sessionStorage.setItem("ics_candidate_id", data.candidateId);
      sessionStorage.setItem("ics_attempt_id", data.attemptId);
      router.push("/consignes");
    } catch {
      setServerError("Impossible de contacter le serveur. Réessayez.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-dvh flex flex-col items-center justify-center px-4 py-12">
      {/* Background subtle grid */}
      <div
        className="fixed inset-0 pointer-events-none opacity-[0.03]"
        style={{
          backgroundImage:
            "linear-gradient(var(--color-border-default) 1px, transparent 1px), linear-gradient(90deg, var(--color-border-default) 1px, transparent 1px)",
          backgroundSize: "40px 40px",
        }}
      />

      <main className="relative w-full max-w-md space-y-8">
        {/* Header */}
        <div className="space-y-3">
          <div className="flex items-center gap-3 mb-6">
            <div className="w-10 h-10 rounded-[var(--radius-md)] bg-electric/15 flex items-center justify-center">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" className="text-electric">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" />
              </svg>
            </div>
            <span className="text-sm font-medium text-text-secondary tracking-wide">
              Ivoire Cyber Shield
            </span>
          </div>

          <h1 className="text-2xl font-bold leading-tight text-text-primary">
            Évaluation pré-formation
          </h1>
          <p className="text-sm text-text-secondary leading-relaxed max-w-sm">
            Teste tes connaissances avant la formation
            « Initiation au Pentest Web avec l'Intelligence Artificielle ».
          </p>
        </div>

        {/* Info cards */}
        <div className="grid grid-cols-3 gap-3">
          <div className="card p-3 text-center">
            <div className="text-lg font-bold font-mono text-electric">25</div>
            <div className="text-xs text-text-muted mt-0.5">questions</div>
          </div>
          <div className="card p-3 text-center">
            <div className="text-lg font-bold font-mono text-iris">25</div>
            <div className="text-xs text-text-muted mt-0.5">minutes</div>
          </div>
          <div className="card p-3 text-center">
            <div className="text-lg font-bold font-mono text-phosphor">65%</div>
            <div className="text-xs text-text-muted mt-0.5">seuil requis</div>
          </div>
        </div>

        {/* Registration form */}
        <form onSubmit={handleSubmit} className="card p-6 space-y-4">
          <p className="text-sm font-medium text-text-primary mb-1">Identification</p>

          <Input
            label="Nom"
            name="nom"
            placeholder="Ex : Koné"
            value={form.nom}
            onChange={handleChange}
            error={errors.nom}
            required
            autoComplete="family-name"
          />
          <Input
            label="Prénom"
            name="prenom"
            placeholder="Ex : Aminata"
            value={form.prenom}
            onChange={handleChange}
            error={errors.prenom}
            required
            autoComplete="given-name"
          />
          <Input
            label="Adresse e-mail"
            name="email"
            type="email"
            placeholder="aminata@exemple.ci"
            value={form.email}
            onChange={handleChange}
            error={errors.email}
            required
            autoComplete="email"
          />

          {serverError && (
            <p className="text-sm text-signal bg-signal/10 border border-signal/20 rounded-[var(--radius-md)] px-3 py-2" role="alert">
              {serverError}
            </p>
          )}

          <Button type="submit" loading={loading} className="w-full">
            Commencer l'évaluation
          </Button>
        </form>

        <p className="text-xs text-text-muted text-center">
          Les données collectées sont utilisées uniquement pour l'évaluation.
        </p>
      </main>
    </div>
  );
}
