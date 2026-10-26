"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { QuestionForm } from "@/components/admin/question-form";

export default function NewQuestionPage() {
  const router = useRouter();
  const [categories, setCategories] = useState<
    { id: string; code: string; nom: string }[]
  >([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch("/api/admin/categories")
      .then((r) => {
        if (r.status === 401) {
          router.push("/admin/login");
          return null;
        }
        return r.json();
      })
      .then((data) => {
        if (data?.categories) setCategories(data.categories);
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [router]);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-32">
        <div className="w-6 h-6 border-2 border-electric border-t-transparent rounded-full animate-spin" />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold text-text-primary">
          Nouvelle question
        </h1>
        <p className="text-sm text-text-secondary mt-1">
          Ajouter une question à la banque
        </p>
      </div>
      <QuestionForm categories={categories} />
    </div>
  );
}
