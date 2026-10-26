"use client";

import { useEffect, useState, useCallback } from "react";
import { useRouter } from "next/navigation";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

interface Candidate {
  id: string;
  nom: string;
  prenom: string;
  email: string;
  createdAt: string;
  attempts: {
    id: string;
    status: string;
    pourcentage: number | null;
    admis: boolean | null;
    bonnes_reponses: number | null;
    total_questions: number | null;
    started_at: string;
  }[];
}

export default function CandidatesPage() {
  const router = useRouter();
  const [candidates, setCandidates] = useState<Candidate[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState("");
  const [searchInput, setSearchInput] = useState("");
  const [loading, setLoading] = useState(true);

  const perPage = 20;

  const fetchCandidates = useCallback(async () => {
    setLoading(true);
    const params = new URLSearchParams({
      page: String(page),
      perPage: String(perPage),
    });
    if (search) params.set("search", search);

    const res = await fetch(`/api/admin/candidates?${params}`);
    if (res.status === 401) {
      router.push("/admin/login");
      return;
    }
    const data = await res.json();
    setCandidates(data.candidates ?? []);
    setTotal(data.total ?? 0);
    setLoading(false);
  }, [page, search, router]);

  useEffect(() => {
    fetchCandidates();
  }, [fetchCandidates]);

  function handleSearch() {
    setSearch(searchInput);
    setPage(1);
  }

  async function handleExport() {
    const res = await fetch("/api/admin/export?format=csv");
    if (!res.ok) return;
    const blob = await res.blob();
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = `resultats_ics_eval_${new Date().toISOString().slice(0, 10)}.csv`;
    a.click();
    URL.revokeObjectURL(url);
  }

  const totalPages = Math.ceil(total / perPage);

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-semibold text-text-primary">
            Candidats
          </h1>
          <p className="text-sm text-text-secondary mt-1">
            {total} candidat{total > 1 ? "s" : ""} inscrits
          </p>
        </div>
        <Button variant="secondary" onClick={handleExport}>
          Exporter CSV
        </Button>
      </div>

      {/* Search */}
      <div className="flex items-center gap-3">
        <div className="flex-1 max-w-sm">
          <Input
            value={searchInput}
            onChange={(e) => setSearchInput(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && handleSearch()}
            placeholder="Rechercher par nom, prénom ou email…"
          />
        </div>
        <Button variant="secondary" onClick={handleSearch}>
          Rechercher
        </Button>
      </div>

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
                    Candidat
                  </th>
                  <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide hidden sm:table-cell">
                    Email
                  </th>
                  <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                    Dernier test
                  </th>
                  <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                    Résultat
                  </th>
                  <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide hidden md:table-cell">
                    Inscription
                  </th>
                </tr>
              </thead>
              <tbody>
                {candidates.map((c) => {
                  const lastAttempt = c.attempts?.[0];
                  return (
                    <tr
                      key={c.id}
                      className="border-b border-border-muted last:border-0 hover:bg-bg-overlay/50 transition-colors cursor-pointer"
                      onClick={() => router.push(`/admin/candidates/${c.id}`)}
                    >
                      <td className="px-5 py-3">
                        <p className="font-medium text-text-primary">
                          {c.prenom} {c.nom}
                        </p>
                        <p className="text-xs text-text-muted sm:hidden">
                          {c.email}
                        </p>
                      </td>
                      <td className="px-5 py-3 text-text-secondary hidden sm:table-cell">
                        {c.email}
                      </td>
                      <td className="px-5 py-3">
                        {lastAttempt?.status === "soumis" ? (
                          <span className="font-mono font-semibold text-text-primary">
                            {lastAttempt.pourcentage}%
                            <span className="text-text-muted font-normal ml-1">
                              ({lastAttempt.bonnes_reponses}/
                              {lastAttempt.total_questions})
                            </span>
                          </span>
                        ) : lastAttempt ? (
                          <span className="text-text-muted text-xs">
                            En cours
                          </span>
                        ) : (
                          <span className="text-text-muted text-xs">—</span>
                        )}
                      </td>
                      <td className="px-5 py-3">
                        {lastAttempt?.admis != null ? (
                          <Badge
                            variant={
                              lastAttempt.admis ? "phosphor" : "signal"
                            }
                          >
                            {lastAttempt.admis ? "Admis" : "Non admis"}
                          </Badge>
                        ) : (
                          <span className="text-text-muted text-xs">—</span>
                        )}
                      </td>
                      <td className="px-5 py-3 text-text-secondary hidden md:table-cell">
                        {new Date(c.createdAt).toLocaleDateString("fr-FR", {
                          day: "2-digit",
                          month: "short",
                          year: "numeric",
                          timeZone: "Africa/Abidjan",
                        })}
                      </td>
                    </tr>
                  );
                })}
                {candidates.length === 0 && (
                  <tr>
                    <td
                      colSpan={5}
                      className="px-5 py-8 text-center text-text-muted"
                    >
                      Aucun candidat trouvé
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>

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
