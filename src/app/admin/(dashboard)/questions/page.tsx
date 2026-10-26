"use client";

import { useEffect, useState, useCallback } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

interface Question {
  id: string;
  enonce: string;
  difficulte: string;
  actif: boolean;
  createdAt: string;
  categorie: { code: string; nom: string } | null;
  options: { id: string; texte: string; est_correcte: boolean }[];
}

const DIFFICULTY_MAP: Record<string, { label: string; variant: "muted" | "amber" | "signal" }> = {
  facile: { label: "Facile", variant: "muted" },
  intermediaire: { label: "Intermédiaire", variant: "amber" },
  avance: { label: "Avancé", variant: "signal" },
};

export default function QuestionsPage() {
  const router = useRouter();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [category, setCategory] = useState("");
  const [loading, setLoading] = useState(true);
  const [expandedId, setExpandedId] = useState<string | null>(null);

  const perPage = 15;

  const fetchQuestions = useCallback(async () => {
    setLoading(true);
    const params = new URLSearchParams({
      page: String(page),
      perPage: String(perPage),
    });
    if (category) params.set("category", category);

    const res = await fetch(`/api/admin/questions?${params}`);
    if (res.status === 401) {
      router.push("/admin/login");
      return;
    }
    const data = await res.json();
    setQuestions(data.questions ?? []);
    setTotal(data.total ?? 0);
    setLoading(false);
  }, [page, category, router]);

  useEffect(() => {
    fetchQuestions();
  }, [fetchQuestions]);

  async function handleDeactivate(id: string) {
    if (!confirm("Désactiver cette question ?")) return;
    await fetch(`/api/admin/questions/${id}`, { method: "DELETE" });
    fetchQuestions();
  }

  const totalPages = Math.ceil(total / perPage);

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-semibold text-text-primary">
            Banque de questions
          </h1>
          <p className="text-sm text-text-secondary mt-1">
            {total} question{total > 1 ? "s" : ""} au total
          </p>
        </div>
        <Button onClick={() => router.push("/admin/questions/new")}>
          + Nouvelle question
        </Button>
      </div>

      {/* Filters */}
      <div className="flex items-center gap-3">
        <select
          value={category}
          onChange={(e) => {
            setCategory(e.target.value);
            setPage(1);
          }}
          className="bg-bg-surface border border-border-default rounded-md px-3 py-2 text-sm text-text-primary focus:outline-none focus:ring-2 focus:ring-electric"
        >
          <option value="">Tous les domaines</option>
          <option value="reseaux">Réseaux</option>
          <option value="vulnerabilites">Vulnérabilités</option>
          <option value="methodologie">Méthodologie</option>
          <option value="ia_ethique">IA / Éthique</option>
        </select>
      </div>

      {/* Table */}
      {loading ? (
        <div className="flex items-center justify-center h-32">
          <div className="w-6 h-6 border-2 border-electric border-t-transparent rounded-full animate-spin" />
        </div>
      ) : (
        <div className="card overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-border-muted">
                  <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                    Énoncé
                  </th>
                  <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide hidden md:table-cell">
                    Domaine
                  </th>
                  <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide hidden sm:table-cell">
                    Difficulté
                  </th>
                  <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                    Statut
                  </th>
                  <th className="text-right px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                    Actions
                  </th>
                </tr>
              </thead>
              <tbody>
                {questions.map((q) => {
                  const diff = DIFFICULTY_MAP[q.difficulte] ?? {
                    label: q.difficulte,
                    variant: "default" as const,
                  };
                  const expanded = expandedId === q.id;

                  return (
                    <tr
                      key={q.id}
                      className="border-b border-border-muted last:border-0"
                    >
                      <td className="px-5 py-3">
                        <button
                          onClick={() =>
                            setExpandedId(expanded ? null : q.id)
                          }
                          className="text-left hover:text-electric transition-colors"
                        >
                          <p className="text-text-primary font-medium line-clamp-2">
                            {q.enonce}
                          </p>
                        </button>
                        {expanded && (
                          <div className="mt-3 space-y-1.5 pl-3 border-l-2 border-border-default">
                            {q.options.map((o, i) => (
                              <p
                                key={o.id}
                                className={`text-xs ${
                                  o.est_correcte
                                    ? "text-phosphor font-semibold"
                                    : "text-text-secondary"
                                }`}
                              >
                                {String.fromCharCode(65 + i)}. {o.texte}
                                {o.est_correcte && " ✓"}
                              </p>
                            ))}
                          </div>
                        )}
                      </td>
                      <td className="px-5 py-3 hidden md:table-cell">
                        <span className="text-text-secondary text-xs">
                          {q.categorie?.nom ?? "—"}
                        </span>
                      </td>
                      <td className="px-5 py-3 hidden sm:table-cell">
                        <Badge variant={diff.variant}>{diff.label}</Badge>
                      </td>
                      <td className="px-5 py-3">
                        <Badge variant={q.actif ? "phosphor" : "muted"}>
                          {q.actif ? "Active" : "Inactive"}
                        </Badge>
                      </td>
                      <td className="px-5 py-3 text-right">
                        <div className="flex items-center justify-end gap-2">
                          <button
                            onClick={() =>
                              router.push(`/admin/questions/${q.id}`)
                            }
                            className="text-xs text-electric hover:underline"
                          >
                            Modifier
                          </button>
                          {q.actif && (
                            <button
                              onClick={() => handleDeactivate(q.id)}
                              className="text-xs text-signal hover:underline"
                            >
                              Désactiver
                            </button>
                          )}
                        </div>
                      </td>
                    </tr>
                  );
                })}
                {questions.length === 0 && (
                  <tr>
                    <td
                      colSpan={5}
                      className="px-5 py-8 text-center text-text-muted"
                    >
                      Aucune question trouvée
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>

          {/* Pagination */}
          {totalPages > 1 && (
            <div className="flex items-center justify-between px-5 py-3 border-t border-border-default">
              <p className="text-xs text-text-muted">
                Page {page} sur {totalPages}
              </p>
              <div className="flex gap-2">
                <button
                  onClick={() => setPage((p) => Math.max(1, p - 1))}
                  disabled={page === 1}
                  className="px-3 py-1.5 text-xs rounded-md bg-bg-overlay text-text-secondary hover:text-text-primary disabled:opacity-40 transition-colors"
                >
                  Précédent
                </button>
                <button
                  onClick={() => setPage((p) => Math.min(totalPages, p + 1))}
                  disabled={page === totalPages}
                  className="px-3 py-1.5 text-xs rounded-md bg-bg-overlay text-text-secondary hover:text-text-primary disabled:opacity-40 transition-colors"
                >
                  Suivant
                </button>
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
