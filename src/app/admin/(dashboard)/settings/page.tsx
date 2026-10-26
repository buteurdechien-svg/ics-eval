"use client";

import { useEffect, useState, type FormEvent } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

interface Settings {
  seuilReussite: number;
  whatsappLink: string;
  dureeMinutes: number;
  nbQuestions: number;
}

export default function SettingsPage() {
  const router = useRouter();
  const [settings, setSettings] = useState<Settings>({
    seuilReussite: 65,
    whatsappLink: "",
    dureeMinutes: 25,
    nbQuestions: 25,
  });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState("");

  useEffect(() => {
    fetch("/api/admin/settings")
      .then((r) => {
        if (r.status === 401) {
          router.push("/admin/login");
          return null;
        }
        return r.json();
      })
      .then((data) => {
        if (data && !data.error) setSettings(data);
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [router]);

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setMessage("");
    setSaving(true);

    try {
      const res = await fetch("/api/admin/settings", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(settings),
      });

      if (res.ok) {
        setMessage("Paramètres enregistrés avec succès.");
      } else {
        const data = await res.json();
        setMessage(data.error ?? "Erreur lors de l'enregistrement");
      }
    } catch {
      setMessage("Erreur réseau. Réessayez.");
    } finally {
      setSaving(false);
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-32">
        <div className="w-6 h-6 border-2 border-electric border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-2xl font-semibold text-text-primary">
          Paramètres
        </h1>
        <p className="text-sm text-text-secondary mt-1">
          Configuration générale de la plateforme
        </p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-6 max-w-xl">
        <div className="card p-6 space-y-5">
          <h2 className="text-base font-semibold text-text-primary border-b border-border-default pb-3">
            Évaluation
          </h2>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <Input
              label="Seuil de réussite (%)"
              type="number"
              min={1}
              max={100}
              value={settings.seuilReussite}
              onChange={(e) =>
                setSettings((s) => ({
                  ...s,
                  seuilReussite: parseInt(e.target.value, 10) || 0,
                }))
              }
            />
            <Input
              label="Nombre de questions"
              type="number"
              min={5}
              max={50}
              value={settings.nbQuestions}
              onChange={(e) =>
                setSettings((s) => ({
                  ...s,
                  nbQuestions: parseInt(e.target.value, 10) || 0,
                }))
              }
            />
          </div>

          <Input
            label="Durée du test (minutes)"
            type="number"
            min={5}
            max={120}
            value={settings.dureeMinutes}
            onChange={(e) =>
              setSettings((s) => ({
                ...s,
                dureeMinutes: parseInt(e.target.value, 10) || 0,
              }))
            }
          />
        </div>

        <div className="card p-6 space-y-5">
          <h2 className="text-base font-semibold text-text-primary border-b border-border-default pb-3">
            Communication
          </h2>

          <Input
            label="Lien WhatsApp (groupe ou contact)"
            type="url"
            value={settings.whatsappLink}
            onChange={(e) =>
              setSettings((s) => ({ ...s, whatsappLink: e.target.value }))
            }
            placeholder="https://chat.whatsapp.com/…"
          />
          <p className="text-xs text-text-muted -mt-3">
            Ce lien sera affiché aux candidats admis sur leur page de
            résultats.
          </p>
        </div>

        {message && (
          <div
            className={`rounded-md px-4 py-3 text-sm ${
              message.includes("succès")
                ? "bg-phosphor/10 border border-phosphor/20 text-phosphor"
                : "bg-signal/10 border border-signal/20 text-signal"
            }`}
          >
            {message}
          </div>
        )}

        <Button type="submit" disabled={saving}>
          {saving ? "Enregistrement…" : "Enregistrer les paramètres"}
        </Button>
      </form>
    </div>
  );
}
