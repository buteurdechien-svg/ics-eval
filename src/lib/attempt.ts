import { createServerClient } from "./supabase-server";
import { REPARTITION } from "./scoring";

/**
 * Sélectionne aléatoirement les questions pour une tentative,
 * en respectant la répartition par domaine.
 */
export async function selectQuestions(): Promise<
  { questionId: string; sortOrder: number }[]
> {
  const db = createServerClient();

  // Récupérer les catégories
  const { data: categories } = await db
    .from("question_categories")
    .select("id, code");

  if (!categories?.length) throw new Error("Aucune catégorie trouvée");

  const catMap = new Map(categories.map((c) => [c.code, c.id]));
  const selected: { questionId: string; sortOrder: number }[] = [];
  let sortOrder = 0;

  for (const [domaineCode, nbQuestions] of Object.entries(REPARTITION)) {
    const categoryId = catMap.get(domaineCode);
    if (!categoryId) continue;

    // Récupérer toutes les questions actives de ce domaine
    const { data: questions } = await db
      .from("questions")
      .select("id")
      .eq("category_id", categoryId)
      .eq("actif", true);

    if (!questions?.length) continue;

    // Mélanger et prendre les N premières (Fisher-Yates)
    const shuffled = [...questions];
    for (let i = shuffled.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
    }

    const picked = shuffled.slice(0, nbQuestions);
    for (const q of picked) {
      selected.push({ questionId: q.id, sortOrder: sortOrder++ });
    }
  }

  // Mélanger l'ordre global des questions
  for (let i = selected.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [selected[i], selected[j]] = [selected[j], selected[i]];
  }
  // Réassigner sortOrder après le mélange global
  selected.forEach((s, idx) => (s.sortOrder = idx));

  return selected;
}

/**
 * Vérifie qu'une tentative est encore en cours (pas expirée, pas soumise).
 */
export async function validateAttempt(attemptId: string) {
  const db = createServerClient();
  const { data: attempt } = await db
    .from("attempts")
    .select("*")
    .eq("id", attemptId)
    .single();

  if (!attempt) return { valid: false, reason: "Tentative introuvable" };
  if (attempt.status === "soumis")
    return { valid: false, reason: "Tentative déjà soumise" };

  const now = new Date();
  const expires = new Date(attempt.expires_at);
  if (now > expires) {
    // Marquer comme expirée si ce n'est pas déjà fait
    if (attempt.status !== "expire") {
      await db
        .from("attempts")
        .update({ status: "expire" })
        .eq("id", attemptId);
    }
    return { valid: false, reason: "Le temps est écoulé" };
  }

  return { valid: true, attempt };
}
