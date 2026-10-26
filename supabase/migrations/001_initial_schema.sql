-- ═══════════════════════════════════════════════════════════
--  ICS Eval — Schéma initial
--  Plateforme d'évaluation Pentest Web
-- ═══════════════════════════════════════════════════════════

-- Domaines / catégories de questions
CREATE TABLE question_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(30) NOT NULL UNIQUE,
  nom VARCHAR(120) NOT NULL,
  poids NUMERIC(4,2) NOT NULL DEFAULT 0.25,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Questions
CREATE TABLE questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category_id UUID NOT NULL REFERENCES question_categories(id) ON DELETE RESTRICT,
  enonce TEXT NOT NULL,
  explication TEXT NOT NULL,
  difficulte VARCHAR(20) NOT NULL CHECK (difficulte IN ('facile', 'intermediaire', 'avance')),
  actif BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_questions_category ON questions(category_id);
CREATE INDEX idx_questions_actif ON questions(actif) WHERE actif = true;

-- Options de réponse (4 par question)
CREATE TABLE answer_options (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  texte TEXT NOT NULL,
  est_correcte BOOLEAN NOT NULL DEFAULT false,
  sort_order SMALLINT NOT NULL DEFAULT 0
);
CREATE INDEX idx_options_question ON answer_options(question_id);

-- Candidats
CREATE TABLE candidates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  email VARCHAR(254) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_candidates_email ON candidates(email);

-- Tentatives
CREATE TABLE attempts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID NOT NULL REFERENCES candidates(id) ON DELETE CASCADE,
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at TIMESTAMPTZ NOT NULL,
  submitted_at TIMESTAMPTZ,
  score_global INT,
  bonnes_reponses INT,
  total_questions INT NOT NULL DEFAULT 25,
  pourcentage NUMERIC(5,2),
  appreciation VARCHAR(100),
  admis BOOLEAN,
  domaines_json JSONB,
  points_forts TEXT[],
  points_faibles TEXT[],
  duree_secondes INT,
  ip_address INET,
  user_agent TEXT,
  status VARCHAR(20) NOT NULL DEFAULT 'en_cours' CHECK (status IN ('en_cours', 'soumis', 'expire')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_attempts_candidate ON attempts(candidate_id);
CREATE INDEX idx_attempts_status ON attempts(status);

-- Questions d'une tentative (les 25 sélectionnées, dans l'ordre affiché)
CREATE TABLE attempt_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id UUID NOT NULL REFERENCES attempts(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE RESTRICT,
  sort_order SMALLINT NOT NULL,
  UNIQUE (attempt_id, question_id)
);
CREATE INDEX idx_aq_attempt ON attempt_questions(attempt_id);

-- Réponses du candidat
CREATE TABLE attempt_answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id UUID NOT NULL REFERENCES attempts(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE RESTRICT,
  selected_option_id UUID REFERENCES answer_options(id) ON DELETE SET NULL,
  est_correcte BOOLEAN,
  answered_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (attempt_id, question_id)
);
CREATE INDEX idx_aa_attempt ON attempt_answers(attempt_id);

-- Événements de surveillance
CREATE TABLE proctoring_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id UUID NOT NULL REFERENCES attempts(id) ON DELETE CASCADE,
  event_type VARCHAR(30) NOT NULL,
  event_data JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_proctor_attempt ON proctoring_events(attempt_id);

-- Journal d'audit admin
CREATE TABLE admin_audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  admin_email VARCHAR(254),
  action VARCHAR(100) NOT NULL,
  target_type VARCHAR(50),
  target_id UUID,
  details JSONB,
  ip_address INET,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_audit_created ON admin_audit_logs(created_at DESC);

-- Configuration de l'application
CREATE TABLE app_settings (
  key VARCHAR(60) PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Valeurs par défaut
INSERT INTO app_settings (key, value) VALUES
  ('seuil_reussite', '65'),
  ('duree_minutes', '25'),
  ('nb_questions', '25'),
  ('whatsapp_link', '');

-- Insérer les catégories
INSERT INTO question_categories (code, nom, poids) VALUES
  ('reseaux', 'Réseaux et fondamentaux Web', 0.25),
  ('vulnerabilites', 'Vulnérabilités Web', 0.35),
  ('methodologie', 'Méthodologie et outils', 0.25),
  ('ia_ethique', 'IA, éthique et sécurité', 0.15);
