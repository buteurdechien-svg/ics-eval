"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { Badge } from "@/components/ui/badge";

interface Stats {
  totalCandidates: number;
  totalAttempts: number;
  submittedAttempts: number;
  totalQuestions: number;
  admisCount: number;
  moyenne: number;
  passRate: number;
  domainStats: { code: string; nom: string }[];
  recentAttempts: {
    id: string;
    pourcentage: number;
    bonnesReponses: number;
    totalQuestions: number;
    admis: boolean;
    startedAt: string;
    candidat: { nom: string; prenom: string; email: string } | null;
  }[];
}

export default function AdminDashboardPage() {
  const router = useRouter();
  const [stats, setStats] = useState<Stats | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch("/api/admin/stats")
      .then((r) => {
        if (r.status === 401) {
          router.push("/admin/login");
          return null;
        }
        return r.json();
      })
      .then((data) => {
        if (data) setStats(data);
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [router]);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="w-6 h-6 border-2 border-electric border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  if (!stats) return null;

  const kpis = [
    {
      label: "Candidats inscrits",
      value: stats.totalCandidates,
      color: "text-electric",
      bgColor: "bg-electric/10",
    },
    {
      label: "Tests soumis",
      value: stats.submittedAttempts,
      color: "text-iris",
      bgColor: "bg-iris/10",
    },
    {
      label: "Taux de réussite",
      value: `${stats.passRate}%`,
      color: "text-phosphor",
      bgColor: "bg-phosphor/10",
    },
    {
      label: "Moyenne générale",
      value: `${stats.moyenne}%`,
      color: "text-amber",
      bgColor: "bg-amber/10",
    },
  ];

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-2xl font-semibold text-text-primary">
          Tableau de bord
        </h1>
        <p className="text-sm text-text-secondary mt-1">
          Vue d'ensemble de la plateforme d'évaluation
        </p>
      </div>

      {/* KPI cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {kpis.map((kpi) => (
          <div key={kpi.label} className="card p-5">
            <p className="text-xs font-medium text-text-muted uppercase tracking-wide">
              {kpi.label}
            </p>
            <p className={`text-3xl font-bold mt-2 ${kpi.color}`}>
              {kpi.value}
            </p>
          </div>
        ))}
      </div>

      {/* Secondary stats */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div className="card p-5">
          <p className="text-xs font-medium text-text-muted uppercase tracking-wide">
            Questions actives
          </p>
          <p className="text-2xl font-bold text-text-primary mt-2">
            {stats.totalQuestions}
          </p>
        </div>
        <div className="card p-5">
          <p className="text-xs font-medium text-text-muted uppercase tracking-wide">
            Admis
          </p>
          <p className="text-2xl font-bold text-phosphor mt-2">
            {stats.admisCount}
          </p>
        </div>
        <div className="card p-5">
          <p className="text-xs font-medium text-text-muted uppercase tracking-wide">
            Domaines
          </p>
          <p className="text-2xl font-bold text-text-primary mt-2">
            {stats.domainStats.length}
          </p>
        </div>
      </div>

      {/* Recent attempts table */}
      <div className="card overflow-hidden">
        <div className="px-5 py-4 border-b border-border-default">
          <h2 className="text-base font-semibold text-text-primary">
            Dernières tentatives
          </h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="border-b border-border-muted">
                <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                  Candidat
                </th>
                <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                  Score
                </th>
                <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                  Résultat
                </th>
                <th className="text-left px-5 py-3 text-xs font-medium text-text-muted uppercase tracking-wide">
                  Date
                </th>
              </tr>
            </thead>
            <tbody>
              {stats.recentAttempts.map((a) => (
                <tr
                  key={a.id}
                  className="border-b border-border-muted last:border-0 hover:bg-bg-overlay/50 transition-colors"
                >
                  <td className="px-5 py-3">
                    <p className="font-medium text-text-primary">
                      {a.candidat
                        ? `${a.candidat.prenom} ${a.candidat.nom}`
                        : "—"}
                    </p>
                    <p className="text-xs text-text-muted">
                      {a.candidat?.email}
                    </p>
                  </td>
                  <td className="px-5 py-3">
                    <span className="font-mono font-semibold text-text-primary">
                      {a.pourcentage}%
                    </span>
                    <span className="text-text-muted ml-1">
                      ({a.bonnesReponses}/{a.totalQuestions})
                    </span>
                  </td>
                  <td className="px-5 py-3">
                    <Badge variant={a.admis ? "phosphor" : "signal"}>
                      {a.admis ? "Admis" : "Non admis"}
                    </Badge>
                  </td>
                  <td className="px-5 py-3 text-text-secondary">
                    {new Date(a.startedAt).toLocaleDateString("fr-FR", {
                      day: "2-digit",
                      month: "short",
                      year: "numeric",
                      hour: "2-digit",
                      minute: "2-digit",
                      timeZone: "Africa/Abidjan",
                    })}
                  </td>
                </tr>
              ))}
              {stats.recentAttempts.length === 0 && (
                <tr>
                  <td
                    colSpan={4}
                    className="px-5 py-8 text-center text-text-muted"
                  >
                    Aucune tentative pour le moment
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
