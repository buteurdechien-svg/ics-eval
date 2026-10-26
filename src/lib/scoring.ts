/**
 * Moteur de correction déterministe.
 * Aucune IA n'est utilisée — les réponses sont comparées aux clés stockées en base.
 */

export interface DomainResult {
  nom: string;
  bonnesReponses: number;
  totalQuestions: number;
  pourcentage: number;
  competencesAmeliorer: string[];
  recommandations: string[];
}

export interface ScoringResult {
  scoreGlobal: number;
  bonnesReponsesTotal: number;
  totalQuestions: number;
  pourcentageGlobal: number;
  appreciation: string;
  admis: boolean;
  domaines: DomainResult[];
  pointsForts: string[];
  pointsFaibles: string[];
}

/** Catégorie OWASP / domaine de compétence */
export const DOMAINES = [
  { id: "reseaux", nom: "Réseaux et fondamentaux Web", poids: 0.25 },
  { id: "vulnerabilites", nom: "Vulnérabilités Web", poids: 0.35 },
  { id: "methodologie", nom: "Méthodologie et outils", poids: 0.25 },
  { id: "ia_ethique", nom: "IA, éthique et sécurité", poids: 0.15 },
] as const;

/**
 * Répartition des 25 questions selon les pondérations.
 * 25 × 0.25 = 6.25 → 6, 25 × 0.35 = 8.75 → 9, 25 × 0.25 = 6.25 → 6, 25 × 0.15 = 3.75 → 4
 * Total = 6 + 9 + 6 + 4 = 25 ✓
 */
export const REPARTITION: Record<string, number> = {
  reseaux: 6,
  vulnerabilites: 9,
  methodologie: 6,
  ia_ethique: 4,
};

const SEUIL_REUSSITE = 65; // %
const BONNES_REPONSES_MINIMUM = 17; // sur 25

export function getAppreciation(pourcentage: number): string {
  if (pourcentage <= 40) return "Débutant — bases à acquérir";
  if (pourcentage <= 55) return "Débutant en progression";
  if (pourcentage < 80) return "Bonnes connaissances fondamentales";
  return "Très bonne maîtrise théorique du niveau débutant";
}

interface QuestionResult {
  questionId: string;
  domaineId: string;
  domaineName: string;
  correct: boolean;
}

export function computeScore(
  results: QuestionResult[],
  seuilPourcentage = SEUIL_REUSSITE,
  seuilBonnesReponses = BONNES_REPONSES_MINIMUM
): ScoringResult {
  const totalQuestions = results.length;
  const bonnesReponsesTotal = results.filter((r) => r.correct).length;
  const pourcentageGlobal =
    totalQuestions > 0
      ? Math.round((bonnesReponsesTotal / totalQuestions) * 100)
      : 0;

  // Résultats par domaine
  const domainesMap = new Map<string, { correct: number; total: number; nom: string }>();
  for (const r of results) {
    const entry = domainesMap.get(r.domaineId) ?? { correct: 0, total: 0, nom: r.domaineName };
    if (r.correct) entry.correct++;
    entry.total++;
    domainesMap.set(r.domaineId, entry);
  }

  const domaines: DomainResult[] = DOMAINES.map((d) => {
    const entry = domainesMap.get(d.id);
    if (!entry || entry.total === 0) {
      return {
        nom: d.nom,
        bonnesReponses: 0,
        totalQuestions: 0,
        pourcentage: -1, // signifie « Non évalué »
        competencesAmeliorer: [],
        recommandations: ["Ce domaine n'a pas été évalué dans cette tentative."],
      };
    }
    const pct = Math.round((entry.correct / entry.total) * 100);
    return {
      nom: d.nom,
      bonnesReponses: entry.correct,
      totalQuestions: entry.total,
      pourcentage: pct,
      competencesAmeliorer: pct < 60 ? getCompetencesAmeliorer(d.id) : [],
      recommandations: getRecommandations(d.id, pct),
    };
  });

  const pointsForts = domaines
    .filter((d) => d.pourcentage >= 70)
    .map((d) => d.nom);
  const pointsFaibles = domaines
    .filter((d) => d.pourcentage >= 0 && d.pourcentage < 50)
    .map((d) => d.nom);

  const admis =
    pourcentageGlobal >= seuilPourcentage &&
    bonnesReponsesTotal >= seuilBonnesReponses;

  return {
    scoreGlobal: bonnesReponsesTotal,
    bonnesReponsesTotal,
    totalQuestions,
    pourcentageGlobal,
    appreciation: getAppreciation(pourcentageGlobal),
    admis,
    domaines,
    pointsForts,
    pointsFaibles,
  };
}

function getCompetencesAmeliorer(domaineId: string): string[] {
  const map: Record<string, string[]> = {
    reseaux: [
      "Protocoles HTTP/HTTPS et DNS",
      "Modèle OSI et TCP/IP",
      "Cookies et gestion des sessions",
    ],
    vulnerabilites: [
      "Injections SQL",
      "Cross-Site Scripting (XSS)",
      "IDOR et contrôle d'accès",
      "Top 10 OWASP",
    ],
    methodologie: [
      "Phases d'un test d'intrusion",
      "Utilisation de Burp Suite",
      "Reconnaissance avec Nmap",
      "Rédaction de rapport",
    ],
    ia_ethique: [
      "Limites de l'IA générative en cybersécurité",
      "Cadre légal et éthique du pentest",
      "Validation humaine des résultats IA",
    ],
  };
  return map[domaineId] ?? [];
}

function getRecommandations(domaineId: string, pourcentage: number): string[] {
  if (pourcentage >= 80)
    return ["Très bon niveau — continuez à approfondir par la pratique."];
  if (pourcentage >= 60)
    return [
      "Bon niveau de base. Révisez les points manqués pour consolider.",
    ];

  const map: Record<string, string[]> = {
    reseaux: [
      "Révisez les fondamentaux TCP/IP et HTTP.",
      "Pratiquez l'analyse de requêtes avec les outils de développement du navigateur.",
    ],
    vulnerabilites: [
      "Étudiez le Top 10 OWASP 2025 en détail.",
      "Pratiquez sur des labs comme DVWA ou les exercices ICS.",
    ],
    methodologie: [
      "Familiarisez-vous avec la méthodologie PTES.",
      "Pratiquez Burp Suite et Nmap sur des environnements autorisés.",
    ],
    ia_ethique: [
      "Relisez les principes éthiques du test d'intrusion.",
      "Comprenez les limites et biais des outils IA en cybersécurité.",
    ],
  };
  return map[domaineId] ?? ["Révisez ce domaine avant la formation."];
}
