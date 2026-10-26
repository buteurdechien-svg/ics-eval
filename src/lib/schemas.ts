import { z } from "zod";

// ── Candidate registration ──
export const RegisterSchema = z.object({
  nom: z
    .string()
    .trim()
    .min(1, "Le nom est requis")
    .max(100, "100 caractères maximum"),
  prenom: z
    .string()
    .trim()
    .min(1, "Le prénom est requis")
    .max(100, "100 caractères maximum"),
  email: z
    .string()
    .trim()
    .toLowerCase()
    .email("Adresse e-mail invalide")
    .max(254, "Adresse e-mail trop longue"),
});
export type RegisterInput = z.infer<typeof RegisterSchema>;

// ── Answer submission ──
export const AnswerSchema = z.object({
  attemptId: z.string().uuid(),
  questionId: z.string().uuid(),
  selectedOptionId: z.string().uuid(),
});
export type AnswerInput = z.infer<typeof AnswerSchema>;

// ── Proctoring event ──
export const ProctorEventSchema = z.object({
  attemptId: z.string().uuid(),
  eventType: z.enum(["blur", "visibilitychange", "focus_loss"]),
});
export type ProctorEventInput = z.infer<typeof ProctorEventSchema>;

// ── Admin login ──
export const AdminLoginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

// ── Question CRUD ──
export const QuestionSchema = z.object({
  enonce: z.string().min(10, "L'énoncé doit faire au moins 10 caractères"),
  categoryId: z.string().uuid(),
  difficulte: z.enum(["facile", "intermediaire", "avance"]),
  explication: z.string().min(5),
  actif: z.boolean().default(true),
  options: z
    .array(
      z.object({
        texte: z.string().min(1),
        estCorrecte: z.boolean(),
      })
    )
    .length(4, "Exactement 4 propositions requises")
    .refine(
      (opts) => opts.filter((o) => o.estCorrecte).length === 1,
      "Exactement une bonne réponse requise"
    ),
});
export type QuestionInput = z.infer<typeof QuestionSchema>;

// ── Settings ──
export const SettingsSchema = z.object({
  seuilReussite: z.number().int().min(1).max(100).optional(),
  whatsappLink: z.string().url().optional().or(z.literal("")),
  dureeMinutes: z.number().int().min(5).max(120).optional(),
  nbQuestions: z.number().int().min(5).max(50).optional(),
});
