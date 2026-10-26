"use client";

import { useState, type FormEvent } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

interface OptionData {
  texte: string;
  estCorrecte: boolean;
}

interface QuestionFormProps {
  initialData?: {
    enonce: string;
    categoryId: string;
    difficulte: string;
    explication: string;
    actif: boolean;
    options: OptionData[];
  };
  categories: { id: string; code: string; nom: string }[];
  questionId?: string;
}

export function QuestionForm({
  initialData,
  categories,
  questionId,
}: QuestionFormProps) {
  const router = useRouter();
  const isEdit = !!questionId;

  const [enonce, setEnonce] = useState(initialData?.enonce ?? "");
  const [categoryId, setCategoryId] = useState(initialData?.categoryId ?? "");
  const [difficulte, setDifficulte] = useState(
    initialData?.difficulte ?? "intermediaire"
  );
  const [explication, setExplication] = useState(
    initialData?.explication ?? ""
  );
  const [actif, setActif] = useState(initialData?.actif ?? true);
  const [options, setOptions] = useState<OptionData[]>(
    initialData?.options ?? [
      { texte: "", estCorrecte: true },
      { texte: "", estCorrecte: false },
      { texte: "", estCorrecte: false },
      { texte: "", estCorrecte: false },
    ]
  );
  const [error, setError] = useState("");
  const [saving, setSaving] = useState(false);

  function updateOption(index: number, field: keyof OptionData, value: string | boolean) {
    setOptions((prev) =>
      prev.map((o, i) => {
        if (i !== index) {
          // If setting this one as correct, unset others
          if (field === "estCorrecte" && value === true) {
            return { ...o, estCorrecte: false };
          }
          return o;
        }
        return { ...o, [field]: value };
      })
    );
  }

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setError("");

    // Validate at least one correct
    const correctCount = options.filter((o) => o.estCorrecte).length;
    if (correctCount !== 1) {
      setError("Sélectionnez exactement une bonne réponse.");
      return;
    }

    setSaving(true);

    try {
      const body = { enonce, categoryId, difficulte, explication, actif, options };
      const url = isEdit
        ? `/api/admin/questions/${questionId}`
        : "/api/admin/questions";
      const method = isEdit ? "PUT" : "POST";

      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });

      if (!res.ok) {
        const data = await res.json();
        setError(data.error ?? "Erreur lors de l'enregistrement");
        return;
      }

      router.push("/admin/questions");
      router.refresh();
    } catch {
      setError("Erreur réseau. Réessayez.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-6 max-w-3xl">
      {/* Enonce */}
      <div>
        <label className="block text-sm font-medium text-text-secondary mb-1.5">
          Énoncé de la question
        </label>
        <textarea
          value={enonce}
          onChange={(e) => setEnonce(e.target.value)}
          rows={3}
          required
          className="w-full bg-bg-surface border border-border-default rounded-md px-3 py-2 text-sm text-text-primary placeholder:text-text-muted focus:outline-none focus:ring-2 focus:ring-electric resize-y"
          placeholder="Quelle est la commande pour…"
        />
      </div>

      {/* Category + Difficulty */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium text-text-secondary mb-1.5">
            Domaine
          </label>
          <select
            value={categoryId}
            onChange={(e) => setCategoryId(e.target.value)}
            required
            className="w-full bg-bg-surface border border-border-default rounded-md px-3 py-2 text-sm text-text-primary focus:outline-none focus:ring-2 focus:ring-electric"
          >
            <option value="">Sélectionner…</option>
            {categories.map((c) => (
              <option key={c.id} value={c.id}>
                {c.nom}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-sm font-medium text-text-secondary mb-1.5">
            Difficulté
          </label>
          <select
            value={difficulte}
            onChange={(e) => setDifficulte(e.target.value)}
            className="w-full bg-bg-surface border border-border-default rounded-md px-3 py-2 text-sm text-text-primary focus:outline-none focus:ring-2 focus:ring-electric"
          >
            <option value="facile">Facile</option>
            <option value="intermediaire">Intermédiaire</option>
            <option value="avance">Avancé</option>
          </select>
        </div>
      </div>

      {/* Options */}
      <div>
        <label className="block text-sm font-medium text-text-secondary mb-3">
          Propositions (cochez la bonne réponse)
        </label>
        <div className="space-y-3">
          {options.map((opt, i) => (
            <div key={i} className="flex items-start gap-3">
              <label className="flex items-center gap-2 pt-2.5 cursor-pointer">
                <input
                  type="radio"
                  name="correctOption"
                  checked={opt.estCorrecte}
                  onChange={() => updateOption(i, "estCorrecte", true)}
                  className="w-4 h-4 accent-phosphor"
                />
                <span className="text-sm font-mono text-text-muted w-5">
                  {String.fromCharCode(65 + i)}.
                </span>
              </label>
              <Input
                value={opt.texte}
                onChange={(e) => updateOption(i, "texte", e.target.value)}
                required
                placeholder={`Proposition ${String.fromCharCode(65 + i)}`}
                className="flex-1"
              />
            </div>
          ))}
        </div>
      </div>

      {/* Explication */}
      <div>
        <label className="block text-sm font-medium text-text-secondary mb-1.5">
          Explication de la bonne réponse
        </label>
        <textarea
          value={explication}
          onChange={(e) => setExplication(e.target.value)}
          rows={2}
          required
          className="w-full bg-bg-surface border border-border-default rounded-md px-3 py-2 text-sm text-text-primary placeholder:text-text-muted focus:outline-none focus:ring-2 focus:ring-electric resize-y"
          placeholder="La bonne réponse est… parce que…"
        />
      </div>

      {/* Active toggle */}
      <label className="flex items-center gap-3 cursor-pointer">
        <input
          type="checkbox"
          checked={actif}
          onChange={(e) => setActif(e.target.checked)}
          className="w-4 h-4 rounded accent-electric"
        />
        <span className="text-sm text-text-secondary">Question active</span>
      </label>

      {error && (
        <div className="rounded-md bg-signal/10 border border-signal/20 px-4 py-3 text-sm text-signal">
          {error}
        </div>
      )}

      <div className="flex items-center gap-3">
        <Button type="submit" disabled={saving}>
          {saving
            ? "Enregistrement…"
            : isEdit
              ? "Mettre à jour"
              : "Créer la question"}
        </Button>
        <button
          type="button"
          onClick={() => router.push("/admin/questions")}
          className="px-4 py-2 text-sm text-text-secondary hover:text-text-primary transition-colors"
        >
          Annuler
        </button>
      </div>
    </form>
  );
}
