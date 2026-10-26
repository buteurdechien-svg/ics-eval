"use client";

import { useState, useEffect, useCallback, useRef } from "react";
import { useRouter } from "next/navigation";
import { Timer } from "@/components/candidate/timer";
import { Button } from "@/components/ui/button";

interface Question {
  id: string;
  enonce: string;
  sortOrder: number;
  options: { id: string; texte: string }[];
}

export default function TestPage() {
  const router = useRouter();
  const [attemptId, setAttemptId] = useState<string | null>(null);
  const [expiresAt, setExpiresAt] = useState<string>("");
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIdx, setCurrentIdx] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [tabWarning, setTabWarning] = useState(false);
  const tabWarningCount = useRef(0);
  const hasSubmitted = useRef(false);

  // Load attempt data
  useEffect(() => {
    const id = sessionStorage.getItem("ics_attempt_id");
    if (!id) {
      router.replace("/");
      return;
    }
    setAttemptId(id);

    fetch(`/api/attempt/start?attemptId=${id}`)
      .then((r) => r.json())
      .then((data) => {
        if (data.error) {
          router.replace("/");
          return;
        }
        setExpiresAt(data.expiresAt);
        setQuestions(data.questions);
        // Restore previously saved answers
        if (data.savedAnswers) {
          const restored: Record<string, string> = {};
          for (const sa of data.savedAnswers) {
            restored[sa.questionId] = sa.selectedOptionId;
          }
          setAnswers(restored);
        }
        setLoading(false);
      })
      .catch(() => router.replace("/"));
  }, [router]);

  // Proctoring: detect tab changes
  useEffect(() => {
    if (!attemptId) return;

    const handleVisibility = () => {
      if (document.visibilityState === "hidden") {
        tabWarningCount.current++;
        setTabWarning(true);
        // Report to server
        fetch("/api/attempt/proctor", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            attemptId,
            eventType: "visibilitychange",
          }),
        }).catch(() => {});
        // Auto-hide warning after 4s
        setTimeout(() => setTabWarning(false), 4000);
      }
    };

    const handleBlur = () => {
      fetch("/api/attempt/proctor", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          attemptId,
          eventType: "blur",
        }),
      }).catch(() => {});
    };

    document.addEventListener("visibilitychange", handleVisibility);
    window.addEventListener("blur", handleBlur);
    return () => {
      document.removeEventListener("visibilitychange", handleVisibility);
      window.removeEventListener("blur", handleBlur);
    };
  }, [attemptId]);

  // Save answer to server
  const saveAnswer = useCallback(
    async (questionId: string, optionId: string) => {
      if (!attemptId) return;
      await fetch("/api/attempt/answer", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          attemptId,
          questionId,
          selectedOptionId: optionId,
        }),
      }).catch(() => {});
    },
    [attemptId]
  );

  const handleSelect = (questionId: string, optionId: string) => {
    setAnswers((prev) => ({ ...prev, [questionId]: optionId }));
    saveAnswer(questionId, optionId);
  };

  const handleSubmit = useCallback(async () => {
    if (hasSubmitted.current || !attemptId) return;
    hasSubmitted.current = true;
    setSubmitting(true);

    try {
      const res = await fetch("/api/attempt/submit", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ attemptId }),
      });
      const data = await res.json();
      if (data.attemptId) {
        router.push(`/resultats/${data.attemptId}`);
      }
    } catch {
      hasSubmitted.current = false;
      setSubmitting(false);
    }
  }, [attemptId, router]);

  if (loading) {
    return (
      <div className="min-h-dvh flex items-center justify-center">
        <div className="text-text-muted text-sm">Chargement du test…</div>
      </div>
    );
  }

  const q = questions[currentIdx];
  const answeredCount = Object.keys(answers).length;
  const progressPct = Math.round((answeredCount / questions.length) * 100);

  return (
    <div className="min-h-dvh flex flex-col">
      {/* Tab warning overlay */}
      {tabWarning && (
        <div className="fixed inset-0 z-50 bg-signal/10 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="card border-signal/30 p-6 max-w-sm text-center space-y-2">
            <p className="text-signal font-semibold">
              Changement d'onglet détecté
            </p>
            <p className="text-sm text-text-secondary">
              Cet événement a été enregistré ({tabWarningCount.current} fois).
              Reste sur cette page.
            </p>
          </div>
        </div>
      )}

      {/* Top bar: timer + progress */}
      <header className="sticky top-0 z-40 bg-bg-deep/95 backdrop-blur border-b border-border-muted">
        <div className="max-w-2xl mx-auto px-4 py-3 flex items-center justify-between">
          <div className="flex items-center gap-4">
            <span className="text-xs text-text-muted">
              Question {currentIdx + 1}/{questions.length}
            </span>
            <div className="w-24 h-1.5 bg-bg-overlay rounded-full overflow-hidden">
              <div
                className="h-full bg-electric rounded-full transition-[width] duration-300"
                style={{ width: `${progressPct}%` }}
              />
            </div>
            <span className="text-xs text-text-muted font-mono">
              {answeredCount}/{questions.length}
            </span>
          </div>
          <Timer expiresAt={expiresAt} onExpire={handleSubmit} />
        </div>
      </header>

      {/* Question */}
      <main className="flex-1 flex items-start justify-center px-4 py-8">
        <div className="w-full max-w-xl space-y-6">
          <div className="space-y-3">
            <p className="text-base font-medium text-text-primary leading-relaxed">
              {q.enonce}
            </p>
          </div>

          {/* Options */}
          <div className="space-y-2">
            {q.options.map((opt) => {
              const selected = answers[q.id] === opt.id;
              return (
                <button
                  key={opt.id}
                  onClick={() => handleSelect(q.id, opt.id)}
                  className={`
                    w-full text-left px-4 py-3 rounded-[var(--radius-lg)] border
                    transition-all duration-150 text-sm leading-relaxed
                    ${
                      selected
                        ? "bg-electric/10 border-electric/40 text-text-primary"
                        : "bg-bg-surface border-border-default text-text-secondary hover:border-border-default hover:bg-bg-raised"
                    }
                  `}
                  aria-pressed={selected}
                >
                  {opt.texte}
                </button>
              );
            })}
          </div>

          {/* Navigation */}
          <div className="flex items-center justify-between pt-4">
            <Button
              variant="ghost"
              size="sm"
              onClick={() => setCurrentIdx((i) => Math.max(0, i - 1))}
              disabled={currentIdx === 0}
            >
              Précédente
            </Button>

            {/* Question dots for quick nav */}
            <div className="flex flex-wrap gap-1 max-w-[200px] justify-center">
              {questions.map((qq, idx) => (
                <button
                  key={qq.id}
                  onClick={() => setCurrentIdx(idx)}
                  className={`
                    w-6 h-6 rounded-[var(--radius-sm)] text-[10px] font-medium
                    transition-colors duration-100
                    ${
                      idx === currentIdx
                        ? "bg-electric text-white"
                        : answers[qq.id]
                        ? "bg-electric/20 text-electric"
                        : "bg-bg-overlay text-text-muted hover:bg-bg-raised"
                    }
                  `}
                  aria-label={`Question ${idx + 1}${answers[qq.id] ? " (répondue)" : ""}`}
                >
                  {idx + 1}
                </button>
              ))}
            </div>

            {currentIdx < questions.length - 1 ? (
              <Button
                variant="ghost"
                size="sm"
                onClick={() =>
                  setCurrentIdx((i) => Math.min(questions.length - 1, i + 1))
                }
              >
                Suivante
              </Button>
            ) : (
              <Button
                size="sm"
                onClick={handleSubmit}
                loading={submitting}
                disabled={submitting}
              >
                Soumettre
              </Button>
            )}
          </div>
        </div>
      </main>
    </div>
  );
}
