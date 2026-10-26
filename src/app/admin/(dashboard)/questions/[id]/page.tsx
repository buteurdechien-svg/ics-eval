"use client";

import { useEffect, useState } from "react";
import { useRouter, useParams } from "next/navigation";
import { QuestionForm } from "@/components/admin/question-form";

export default function EditQuestionPage() {
  const router = useRouter();
  const params = useParams<{ id: string }>();
  const [categories, setCategories] = useState<
    { id: string; code: string; nom: string }[]
  >([]);
  const [questionData, setQuestionData] = useState<{
    enonce: string;
    categoryId: string;
    difficulte: string;
    explication: string;
    actif: boolean;
    options: { texte: string; estCorrecte: boolean }[];
  } | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      fetch(`/api/admin/questions/${params.id}`).then((r) => {
        if (r.status === 401) {
          router.push("/admin/login");
          return null;
        }
        return r.json();
      }),
      fetch("/api/admin/categories").then((r) => r.json()),
    ])
      .then(([question, cats]) => {
        if (question && !question.error) {
          setQuestionData({
            enonce: question.enonce,
            categoryId: question.categoryId,
            difficulte: question.difficulte,
            explication: question.explication ?? "",
            actif: question.actif,
            options: (question.options ?? [])
              .sort((a: { sort_order: number }, b: { sort_order: number }) => a.sort_order - b.sort_order)
              .map((o: { texte: string; est_correcte: boolean }) => ({
                texte: o.texte,
                estCorrecte: o.est_correcte,
              })),
          });
        }
        if (cats?.categories) setCategories(cats.categories);
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

  if (!questionData) {
    return (
      <div className="text-center py-12 text-text-muted">
        Question introuvable
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold text-text-primary">
          Modifier la question
        </h1>
        <p className="text-sm text-text-secondary mt-1">
          Éditer les détails et propositions
        </p>
      </div>
      <QuestionForm
        initialData={questionData}
        categories={categories}
        questionId={params.id}
      />
    </div>
  );
}
