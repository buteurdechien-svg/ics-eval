-- ═══════════════════════════════════════════════════════════
--  Script de remplacement des questions
--  À exécuter dans le SQL Editor de Supabase
--  1. Supprime toutes les anciennes questions et réponses
--  2. Insère les 104 nouvelles questions niveau débutant
-- ═══════════════════════════════════════════════════════════

-- Supprimer les anciennes données (les FK CASCADE devraient gérer les answer_options)
DELETE FROM answer_options;
DELETE FROM questions;

-- Insérer les nouvelles questions
DO $$
DECLARE
  cat_reseaux UUID;
  cat_vuln UUID;
  cat_meth UUID;
  cat_ia UUID;
  q_id UUID;
BEGIN
  SELECT id INTO cat_reseaux FROM question_categories WHERE code = 'reseaux';
  SELECT id INTO cat_vuln FROM question_categories WHERE code = 'vulnerabilites';
  SELECT id INTO cat_meth FROM question_categories WHERE code = 'methodologie';
  SELECT id INTO cat_ia FROM question_categories WHERE code = 'ia_ethique';

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 1 : Réseaux et fondamentaux Web (26 questions)
  -- ═══════════════════════════════════════════════════════

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "HTTP" ?', 'HTTP signifie HyperText Transfer Protocol. C''est le protocole utilisé pour transférer les pages web entre un serveur et un navigateur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'HyperText Transfer Protocol', true, 1),
    (q_id, 'High Technology Transfer Program', false, 2),
    (q_id, 'HyperText Transmission Port', false, 3),
    (q_id, 'Home Tool Transfer Protocol', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''une adresse IP ?', 'Une adresse IP (Internet Protocol) est un numéro unique attribué à chaque appareil connecté à un réseau.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un numéro unique qui identifie un appareil sur un réseau', true, 1),
    (q_id, 'Le nom d''un site web', false, 2),
    (q_id, 'Un mot de passe pour accéder à Internet', false, 3),
    (q_id, 'Un logiciel de navigation web', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le "S" dans "HTTPS" ?', 'Le "S" signifie Secure (sécurisé). HTTPS chiffre les données échangées entre le navigateur et le serveur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Secure (sécurisé)', true, 1),
    (q_id, 'Speed (vitesse)', false, 2),
    (q_id, 'Server (serveur)', false, 3),
    (q_id, 'System (système)', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel est le rôle d''un serveur DNS ?', 'Le DNS traduit les noms de domaine (comme google.com) en adresses IP.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Traduire les noms de domaine en adresses IP', true, 1),
    (q_id, 'Stocker les fichiers des sites web', false, 2),
    (q_id, 'Protéger contre les virus', false, 3),
    (q_id, 'Envoyer des e-mails', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un port en informatique réseau ?', 'Un port est un numéro qui identifie un service ou une application sur un appareil.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un numéro qui identifie un service sur un appareil', true, 1),
    (q_id, 'Un câble qui relie deux ordinateurs', false, 2),
    (q_id, 'Un type de virus informatique', false, 3),
    (q_id, 'Un logiciel de sécurité', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel port est utilisé par défaut par le protocole HTTP ?', 'Le port 80 est le port standard pour HTTP.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, '80', true, 1),
    (q_id, '443', false, 2),
    (q_id, '22', false, 3),
    (q_id, '8080', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "URL" ?', 'URL signifie Uniform Resource Locator. C''est l''adresse complète d''une page web.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Uniform Resource Locator', true, 1),
    (q_id, 'Universal Remote Link', false, 2),
    (q_id, 'Unique Reference Language', false, 3),
    (q_id, 'User Registration Login', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un navigateur web ?', 'Un navigateur web est un logiciel qui permet d''accéder aux sites Internet. Exemples : Chrome, Firefox, Safari.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un logiciel qui permet d''afficher les sites web', true, 1),
    (q_id, 'Un câble réseau', false, 2),
    (q_id, 'Un système d''exploitation', false, 3),
    (q_id, 'Un serveur de base de données', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle est la différence principale entre TCP et UDP ?', 'TCP vérifie que les données arrivent correctement. UDP envoie les données sans vérification (plus rapide mais pas garanti).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'TCP est fiable et vérifie la réception, UDP est plus rapide mais sans garantie', true, 1),
    (q_id, 'TCP est plus rapide que UDP', false, 2),
    (q_id, 'UDP est plus sécurisé que TCP', false, 3),
    (q_id, 'Il n''y a aucune différence', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "LAN" ?', 'LAN signifie Local Area Network (réseau local).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Local Area Network', true, 1),
    (q_id, 'Large Access Network', false, 2),
    (q_id, 'Link And Node', false, 3),
    (q_id, 'Login Authentication Name', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un pare-feu (firewall) ?', 'Un pare-feu filtre le trafic réseau entrant et sortant selon des règles définies.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un système qui filtre le trafic réseau pour bloquer les accès non autorisés', true, 1),
    (q_id, 'Un antivirus', false, 2),
    (q_id, 'Un câble réseau spécial', false, 3),
    (q_id, 'Un navigateur web sécurisé', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "VPN" ?', 'VPN signifie Virtual Private Network (réseau privé virtuel).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Virtual Private Network', true, 1),
    (q_id, 'Very Protected Network', false, 2),
    (q_id, 'Virtual Public Node', false, 3),
    (q_id, 'Verified Personal Name', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un cookie dans un navigateur web ?', 'Un cookie est un petit fichier texte stocké par le navigateur pour mémoriser des informations.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un petit fichier stocké par le navigateur pour mémoriser des informations', true, 1),
    (q_id, 'Un virus informatique', false, 2),
    (q_id, 'Un type de mot de passe', false, 3),
    (q_id, 'Une extension du navigateur', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle est la fonction d''un serveur web ?', 'Un serveur web stocke les fichiers d''un site et les envoie aux navigateurs via HTTP/HTTPS.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Stocker et envoyer les pages web aux navigateurs', true, 1),
    (q_id, 'Protéger contre les virus', false, 2),
    (q_id, 'Créer des adresses e-mail', false, 3),
    (q_id, 'Gérer les mots de passe des utilisateurs', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie "Wi-Fi" ?', 'Wi-Fi est une technologie de réseau sans fil utilisant des ondes radio.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une technologie de connexion réseau sans fil', true, 1),
    (q_id, 'Un type de câble réseau', false, 2),
    (q_id, 'Un protocole de sécurité', false, 3),
    (q_id, 'Un logiciel antivirus', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce que le protocole FTP ?', 'FTP (File Transfer Protocol) est un protocole de transfert de fichiers.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un protocole de transfert de fichiers', true, 1),
    (q_id, 'Un pare-feu', false, 2),
    (q_id, 'Un type de virus', false, 3),
    (q_id, 'Un navigateur web', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''une adresse MAC ?', 'Une adresse MAC est un identifiant unique attribué à la carte réseau de chaque appareil.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un identifiant unique de la carte réseau d''un appareil', true, 1),
    (q_id, 'L''adresse d''un ordinateur Apple Mac', false, 2),
    (q_id, 'Un mot de passe réseau', false, 3),
    (q_id, 'Une adresse e-mail spéciale', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que fait la commande "ping" ?', 'La commande ping vérifie si un appareil est joignable sur le réseau.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Vérifier si un appareil est joignable sur le réseau', true, 1),
    (q_id, 'Télécharger un fichier', false, 2),
    (q_id, 'Supprimer un virus', false, 3),
    (q_id, 'Créer un nouveau réseau', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "SSH" ?', 'SSH signifie Secure Shell. C''est un protocole de connexion à distance sécurisée.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Secure Shell', true, 1),
    (q_id, 'Super Safe Hosting', false, 2),
    (q_id, 'System Security Hub', false, 3),
    (q_id, 'Server Share Host', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un proxy ?', 'Un proxy est un serveur intermédiaire entre l''utilisateur et Internet.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un serveur intermédiaire entre l''utilisateur et Internet', true, 1),
    (q_id, 'Un type de virus', false, 2),
    (q_id, 'Un câble réseau', false, 3),
    (q_id, 'Un système d''exploitation', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle est la différence entre HTTP et HTTPS ?', 'HTTPS chiffre les données avec TLS/SSL, HTTP ne les chiffre pas.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'HTTPS chiffre les données, HTTP ne les chiffre pas', true, 1),
    (q_id, 'HTTPS est plus lent que HTTP', false, 2),
    (q_id, 'HTTP est plus sécurisé que HTTPS', false, 3),
    (q_id, 'Il n''y a aucune différence', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "API" ?', 'API signifie Application Programming Interface.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Application Programming Interface', true, 1),
    (q_id, 'Advanced Protection Internet', false, 2),
    (q_id, 'Automatic Program Installation', false, 3),
    (q_id, 'Active Port Identification', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce que le protocole DHCP ?', 'DHCP attribue automatiquement une adresse IP aux appareils qui se connectent au réseau.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un protocole qui attribue automatiquement des adresses IP', true, 1),
    (q_id, 'Un protocole de transfert de fichiers', false, 2),
    (q_id, 'Un protocole de messagerie', false, 3),
    (q_id, 'Un protocole de chiffrement', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un nom de domaine ?', 'Un nom de domaine est l''adresse lisible d''un site web (comme google.com).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Le nom lisible d''un site web, comme google.com', true, 1),
    (q_id, 'Le mot de passe d''un site web', false, 2),
    (q_id, 'L''adresse IP d''un serveur', false, 3),
    (q_id, 'Le nom du propriétaire d''un site', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le chiffrement des données ?', 'Le chiffrement transforme les données en format illisible sans la clé de déchiffrement.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Transformer les données pour les rendre illisibles sans la clé', true, 1),
    (q_id, 'Compresser les données pour gagner de l''espace', false, 2),
    (q_id, 'Supprimer les données définitivement', false, 3),
    (q_id, 'Copier les données sur un autre serveur', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''une requête GET en HTTP ?', 'Une requête GET demande au serveur de renvoyer une ressource (comme une page web).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une demande pour récupérer des données depuis un serveur', true, 1),
    (q_id, 'Une demande pour supprimer un fichier', false, 2),
    (q_id, 'Une demande pour modifier un mot de passe', false, 3),
    (q_id, 'Une demande pour créer un nouveau compte', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 2 : Vulnérabilités Web (36 questions)
  -- ═══════════════════════════════════════════════════════

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une vulnérabilité informatique ?', 'Une vulnérabilité est une faiblesse dans un système qui peut être exploitée par un attaquant.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une faiblesse qui peut être exploitée par un attaquant', true, 1), (q_id, 'Un logiciel de protection', false, 2), (q_id, 'Un type de pare-feu', false, 3), (q_id, 'Une mise à jour de sécurité', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le phishing (hameçonnage) ?', 'Le phishing est une arnaque qui consiste à se faire passer pour un organisme de confiance pour voler des informations.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une arnaque par faux e-mails ou sites pour voler des informations', true, 1), (q_id, 'Un logiciel antivirus', false, 2), (q_id, 'Une technique de chiffrement', false, 3), (q_id, 'Un protocole réseau', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un malware ?', 'Un malware est un programme conçu pour endommager ou prendre le contrôle d''un système.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un logiciel malveillant conçu pour nuire', true, 1), (q_id, 'Un logiciel de mise à jour', false, 2), (q_id, 'Un outil de développement web', false, 3), (q_id, 'Un type de réseau', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un ransomware ?', 'Un ransomware chiffre les fichiers de la victime et demande une rançon.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un malware qui chiffre les fichiers et demande une rançon', true, 1), (q_id, 'Un logiciel de sauvegarde', false, 2), (q_id, 'Un antivirus gratuit', false, 3), (q_id, 'Un pare-feu avancé', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une injection SQL ?', 'Une injection SQL insère du code malveillant dans un formulaire pour manipuler la base de données.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Insérer du code malveillant dans un formulaire pour attaquer la base de données', true, 1), (q_id, 'Installer un logiciel de base de données', false, 2), (q_id, 'Créer une sauvegarde de base de données', false, 3), (q_id, 'Mettre à jour un serveur SQL', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le XSS (Cross-Site Scripting) ?', 'Le XSS injecte du code JavaScript malveillant dans une page web.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Injecter du code JavaScript malveillant dans une page web', true, 1), (q_id, 'Créer un site web', false, 2), (q_id, 'Scanner un réseau', false, 3), (q_id, 'Chiffrer des données', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un mot de passe fort ?', 'Un mot de passe fort est long (12+ caractères), combine majuscules, minuscules, chiffres et caractères spéciaux.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un mot de passe long avec des majuscules, chiffres et caractères spéciaux', true, 1), (q_id, 'Un mot de passe de 4 chiffres', false, 2), (q_id, 'Le nom de son animal de compagnie', false, 3), (q_id, 'Le mot "password" en majuscules', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque par force brute ?', 'Essayer toutes les combinaisons possibles de mots de passe jusqu''à trouver le bon.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Essayer toutes les combinaisons possibles de mots de passe', true, 1), (q_id, 'Casser physiquement un ordinateur', false, 2), (q_id, 'Envoyer beaucoup d''e-mails', false, 3), (q_id, 'Couper le courant d''un serveur', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque DDoS ?', 'DDoS submerge un serveur avec un grand nombre de requêtes pour le rendre indisponible.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Submerger un serveur de requêtes pour le rendre indisponible', true, 1), (q_id, 'Voler des mots de passe', false, 2), (q_id, 'Chiffrer les fichiers d''un serveur', false, 3), (q_id, 'Installer un virus sur un ordinateur', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce que l''ingénierie sociale ?', 'L''ingénierie sociale manipule des personnes pour qu''elles révèlent des informations confidentielles.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Manipuler des personnes pour obtenir des informations confidentielles', true, 1), (q_id, 'Construire des réseaux sociaux', false, 2), (q_id, 'Programmer des robots', false, 3), (q_id, 'Concevoir des sites web', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un virus informatique ?', 'Un virus est un programme malveillant qui se propage en s''attachant à d''autres fichiers.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un programme malveillant qui se propage en s''attachant à des fichiers', true, 1), (q_id, 'Un bug dans un logiciel', false, 2), (q_id, 'Un problème matériel', false, 3), (q_id, 'Une panne de réseau', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un cheval de Troie (trojan) ?', 'Un cheval de Troie est un malware déguisé en programme légitime.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un malware déguisé en logiciel légitime', true, 1), (q_id, 'Un antivirus', false, 2), (q_id, 'Un outil de développement', false, 3), (q_id, 'Un protocole de sécurité', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce que l''authentification à deux facteurs (2FA) ?', 'Le 2FA ajoute une deuxième vérification en plus du mot de passe.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une sécurité qui demande deux preuves d''identité différentes', true, 1), (q_id, 'Utiliser deux mots de passe différents', false, 2), (q_id, 'Se connecter depuis deux appareils', false, 3), (q_id, 'Avoir deux comptes sur le même site', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Que signifie le sigle "CVE" ?', 'CVE signifie Common Vulnerabilities and Exposures.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Common Vulnerabilities and Exposures', true, 1), (q_id, 'Computer Virus Encryption', false, 2), (q_id, 'Certified Virtual Environment', false, 3), (q_id, 'Central Verification Engine', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un keylogger ?', 'Un keylogger enregistre tout ce que tu tapes au clavier.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un programme qui enregistre les frappes du clavier', true, 1), (q_id, 'Un type de clavier sécurisé', false, 2), (q_id, 'Un raccourci clavier', false, 3), (q_id, 'Un logiciel de frappe rapide', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un exploit ?', 'Un exploit est un programme qui tire parti d''une vulnérabilité pour compromettre un système.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un programme qui exploite une faille de sécurité', true, 1), (q_id, 'Un logiciel de protection', false, 2), (q_id, 'Un type de réseau', false, 3), (q_id, 'Un langage de programmation', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Pourquoi les mises à jour logicielles sont-elles importantes pour la sécurité ?', 'Les mises à jour corrigent les vulnérabilités découvertes dans les logiciels.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Elles corrigent les failles de sécurité connues', true, 1), (q_id, 'Elles rendent l''ordinateur plus rapide', false, 2), (q_id, 'Elles changent le design du logiciel', false, 3), (q_id, 'Elles ne servent à rien', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un spam ?', 'Le spam est un message non sollicité envoyé en masse.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un message non sollicité envoyé en masse', true, 1), (q_id, 'Un message chiffré', false, 2), (q_id, 'Un e-mail urgent du gouvernement', false, 3), (q_id, 'Un type de virus', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une faille zero-day ?', 'Une faille zero-day est une vulnérabilité inconnue de l''éditeur du logiciel.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une vulnérabilité inconnue de l''éditeur, pas encore corrigée', true, 1), (q_id, 'Une faille qui ne dure qu''un jour', false, 2), (q_id, 'Un virus très ancien', false, 3), (q_id, 'Une mise à jour du jour zéro', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le spoofing ?', 'Le spoofing consiste à usurper l''identité de quelqu''un ou d''un système.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Usurper l''identité de quelqu''un ou d''un système', true, 1), (q_id, 'Accélérer un réseau', false, 2), (q_id, 'Chiffrer des fichiers', false, 3), (q_id, 'Installer un antivirus', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un botnet ?', 'Un botnet est un réseau d''ordinateurs infectés contrôlés à distance par un pirate.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un réseau d''ordinateurs infectés contrôlés par un pirate', true, 1), (q_id, 'Un réseau de robots physiques', false, 2), (q_id, 'Un logiciel de chat automatique', false, 3), (q_id, 'Un réseau Wi-Fi public', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Pourquoi ne faut-il pas utiliser le même mot de passe partout ?', 'Si un compte est compromis, l''attaquant peut accéder à tous les autres comptes.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Si un compte est compromis, tous les autres le sont aussi', true, 1), (q_id, 'C''est plus facile à retenir', false, 2), (q_id, 'Cela ralentit l''ordinateur', false, 3), (q_id, 'Les sites web ne l''autorisent pas', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un certificat SSL/TLS ?', 'Un certificat SSL/TLS authentifie un site web et chiffre les communications.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un certificat qui authentifie un site web et chiffre les communications', true, 1), (q_id, 'Un diplôme en informatique', false, 2), (q_id, 'Un type de pare-feu', false, 3), (q_id, 'Un logiciel antivirus', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un spyware ?', 'Un spyware surveille secrètement l''activité de l''utilisateur.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un logiciel espion qui surveille l''activité de l''utilisateur', true, 1), (q_id, 'Un logiciel de surveillance parentale autorisé', false, 2), (q_id, 'Un outil de développement', false, 3), (q_id, 'Un navigateur web sécurisé', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque Man-in-the-Middle (MITM) ?', 'Un pirate se place entre deux personnes qui communiquent, interceptant les messages.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Intercepter les communications entre deux parties', true, 1), (q_id, 'Pirater un serveur web', false, 2), (q_id, 'Envoyer des virus par e-mail', false, 3), (q_id, 'Deviner un mot de passe', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un antivirus ?', 'Un antivirus détecte, bloque et supprime les malwares.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un logiciel qui détecte et supprime les malwares', true, 1), (q_id, 'Un pare-feu réseau', false, 2), (q_id, 'Un outil de chiffrement', false, 3), (q_id, 'Un navigateur web', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le CSRF (Cross-Site Request Forgery) ?', 'Le CSRF force un utilisateur connecté à exécuter une action non voulue sur un site.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Forcer un utilisateur connecté à effectuer une action à son insu', true, 1), (q_id, 'Créer un faux site web', false, 2), (q_id, 'Voler un mot de passe', false, 3), (q_id, 'Scanner un réseau', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Que sont les données personnelles ?', 'Les données personnelles sont toute information qui permet d''identifier une personne.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Toute information qui permet d''identifier une personne', true, 1), (q_id, 'Uniquement le nom et prénom', false, 2), (q_id, 'Les fichiers sur un ordinateur', false, 3), (q_id, 'Les messages envoyés sur les réseaux sociaux', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un ver informatique (worm) ?', 'Un ver se propage automatiquement d''un ordinateur à l''autre via le réseau.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un malware qui se propage tout seul via le réseau', true, 1), (q_id, 'Un virus qui détruit les fichiers', false, 2), (q_id, 'Un programme de diagnostic réseau', false, 3), (q_id, 'Un outil de sauvegarde', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un hash (empreinte numérique) ?', 'Un hash est une chaîne de caractères unique générée à partir de données.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une empreinte unique calculée à partir de données', true, 1), (q_id, 'Un mot de passe chiffré', false, 2), (q_id, 'Un type de virus', false, 3), (q_id, 'Un protocole réseau', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Pourquoi un Wi-Fi public est-il risqué ?', 'Sur un Wi-Fi public non sécurisé, un attaquant peut intercepter les données.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Les données peuvent être interceptées par un attaquant', true, 1), (q_id, 'La connexion est trop lente', false, 2), (q_id, 'Il consomme plus de batterie', false, 3), (q_id, 'Il n''y a aucun risque', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le vishing ?', 'Le vishing est une arnaque téléphonique pour obtenir des informations confidentielles.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une arnaque téléphonique pour voler des informations', true, 1), (q_id, 'Un appel de confirmation de commande', false, 2), (q_id, 'Une technique de chiffrement vocal', false, 3), (q_id, 'Un protocole VoIP', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un adware ?', 'Un adware affiche des publicités indésirables.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un logiciel qui affiche des publicités indésirables', true, 1), (q_id, 'Un bloqueur de publicités', false, 2), (q_id, 'Un outil de marketing', false, 3), (q_id, 'Un navigateur web', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une backdoor (porte dérobée) ?', 'Une backdoor est un accès secret qui contourne la sécurité normale.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un accès secret qui contourne la sécurité normale', true, 1), (q_id, 'Une sauvegarde de sécurité', false, 2), (q_id, 'Une porte de sortie d''urgence du réseau', false, 3), (q_id, 'Un pare-feu secondaire', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le credential stuffing ?', 'Le credential stuffing réutilise des identifiants volés pour accéder à d''autres comptes.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Réutiliser des identifiants volés pour accéder à d''autres comptes', true, 1), (q_id, 'Créer de faux comptes', false, 2), (q_id, 'Deviner un mot de passe', false, 3), (q_id, 'Chiffrer des identifiants', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une fuite de données (data breach) ?', 'Une fuite de données est un accès non autorisé à des informations confidentielles.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un accès non autorisé à des données confidentielles', true, 1), (q_id, 'Une panne de serveur', false, 2), (q_id, 'Une sauvegarde ratée', false, 3), (q_id, 'Un problème de connexion Internet', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 3 : Méthodologie du Pentest (26 questions)
  -- ═══════════════════════════════════════════════════════

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un test d''intrusion (pentest) ?', 'Un pentest est une simulation d''attaque autorisée pour trouver les vulnérabilités.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une simulation d''attaque autorisée pour trouver les failles', true, 1), (q_id, 'Une attaque illégale contre un système', false, 2), (q_id, 'L''installation d''un antivirus', false, 3), (q_id, 'La configuration d''un pare-feu', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Quelle est la première étape d''un pentest ?', 'La reconnaissance (collecte d''informations) est la première étape.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'La reconnaissance (collecte d''informations)', true, 1), (q_id, 'L''exploitation des failles', false, 2), (q_id, 'La rédaction du rapport', false, 3), (q_id, 'L''installation d''outils', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un hacker éthique (white hat) ?', 'Un hacker éthique teste la sécurité de manière légale et autorisée.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un expert qui teste la sécurité de manière légale et autorisée', true, 1), (q_id, 'Un pirate qui vole des données', false, 2), (q_id, 'Un développeur web', false, 3), (q_id, 'Un administrateur réseau', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un black hat ?', 'Un black hat est un pirate malveillant qui agit de manière illégale.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un pirate qui agit de manière illégale et malveillante', true, 1), (q_id, 'Un expert en sécurité légal', false, 2), (q_id, 'Un type de chapeau', false, 3), (q_id, 'Un logiciel de hacking', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un scope dans un pentest ?', 'Le scope définit les limites et le périmètre autorisé du test.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Les limites et le périmètre autorisé du test', true, 1), (q_id, 'Un outil de scan', false, 2), (q_id, 'Un type de vulnérabilité', false, 3), (q_id, 'Un rapport final', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Pourquoi un pentest nécessite-t-il une autorisation écrite ?', 'Sans autorisation, tester la sécurité d''un système est illégal.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Sans autorisation, c''est considéré comme du piratage illégal', true, 1), (q_id, 'C''est juste une formalité administrative', false, 2), (q_id, 'Pour que le client paie la facture', false, 3), (q_id, 'Ce n''est pas obligatoire', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que Nmap ?', 'Nmap est un outil de scan réseau pour découvrir les ports et services.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un outil de scan réseau pour découvrir les ports et services', true, 1), (q_id, 'Un navigateur web sécurisé', false, 2), (q_id, 'Un système d''exploitation', false, 3), (q_id, 'Un antivirus', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que Kali Linux ?', 'Kali Linux est un système d''exploitation dédié aux tests de sécurité.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un système d''exploitation dédié aux tests de sécurité', true, 1), (q_id, 'Un antivirus', false, 2), (q_id, 'Un navigateur web', false, 3), (q_id, 'Un service cloud', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que la reconnaissance passive ?', 'Collecter des informations sur une cible sans interagir directement avec elle.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Collecter des informations sans toucher directement le système cible', true, 1), (q_id, 'Scanner les ports d''un serveur', false, 2), (q_id, 'Exploiter une faille', false, 3), (q_id, 'Installer un logiciel espion', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un rapport de pentest ?', 'Un rapport de pentest détaille les failles trouvées et comment les corriger.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un document détaillant les failles trouvées et comment les corriger', true, 1), (q_id, 'Un logiciel de scan', false, 2), (q_id, 'Un contrat entre le pentester et le client', false, 3), (q_id, 'Un plan de réseau', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Que signifie "OWASP" ?', 'OWASP signifie Open Web Application Security Project.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Open Web Application Security Project', true, 1), (q_id, 'Online Web Attack Security Platform', false, 2), (q_id, 'Official Windows Application Security Policy', false, 3), (q_id, 'Open Wireless Access Security Protocol', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un scan de ports ?', 'Vérifier quels ports sont ouverts sur un serveur.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Vérifier quels ports sont ouverts sur un serveur', true, 1), (q_id, 'Installer un pare-feu', false, 2), (q_id, 'Créer un nouveau port réseau', false, 3), (q_id, 'Désactiver les ports USB', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que Burp Suite ?', 'Burp Suite est un outil pour intercepter et analyser les requêtes web.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un outil pour intercepter et analyser les requêtes web', true, 1), (q_id, 'Un antivirus', false, 2), (q_id, 'Un système d''exploitation', false, 3), (q_id, 'Un service de messagerie', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un pentest en boîte noire (black box) ?', 'Le testeur n''a aucune information préalable sur le système.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un test où le pentester n''a aucune information sur le système', true, 1), (q_id, 'Un test avec un accès complet au code source', false, 2), (q_id, 'Un test uniquement sur les serveurs physiques', false, 3), (q_id, 'Un test effectué de nuit', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un pentest en boîte blanche (white box) ?', 'Le testeur a accès à toutes les informations : code source, architecture, identifiants.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un test où le pentester a un accès complet aux informations du système', true, 1), (q_id, 'Un test sans aucune information', false, 2), (q_id, 'Un test uniquement sur les pages web blanches', false, 3), (q_id, 'Un test réalisé par un white hat uniquement', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que le WHOIS ?', 'WHOIS permet de rechercher les informations d''enregistrement d''un nom de domaine.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un service pour consulter les informations d''un nom de domaine', true, 1), (q_id, 'Un moteur de recherche', false, 2), (q_id, 'Un réseau social', false, 3), (q_id, 'Un outil de piratage', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que l''escalade de privilèges ?', 'Obtenir des droits d''accès supérieurs à ceux qu''on avait initialement.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Obtenir des droits d''accès plus élevés que prévu', true, 1), (q_id, 'Monter dans la hiérarchie d''une entreprise', false, 2), (q_id, 'Augmenter la vitesse du réseau', false, 3), (q_id, 'Ajouter des utilisateurs au système', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un scanner de vulnérabilités ?', 'Un outil qui recherche automatiquement les failles connues dans un système.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un outil qui recherche automatiquement les failles connues', true, 1), (q_id, 'Un antivirus', false, 2), (q_id, 'Un scanner physique de documents', false, 3), (q_id, 'Un outil de développement web', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que la surface d''attaque ?', 'L''ensemble des points d''entrée qu''un attaquant pourrait utiliser.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'L''ensemble des points d''entrée potentiels pour un attaquant', true, 1), (q_id, 'La taille du disque dur', false, 2), (q_id, 'Le nombre d''employés d''une entreprise', false, 3), (q_id, 'La zone géographique du serveur', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un grey hat ?', 'Un hacker qui agit sans autorisation mais sans intention malveillante.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un hacker qui agit sans autorisation mais sans intention malveillante', true, 1), (q_id, 'Un débutant en sécurité', false, 2), (q_id, 'Un expert certifié', false, 3), (q_id, 'Un employé du gouvernement', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un pentest en boîte grise (grey box) ?', 'Le testeur a des informations partielles sur le système.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un test avec des informations partielles sur le système', true, 1), (q_id, 'Un test sans aucune information', false, 2), (q_id, 'Un test avec toutes les informations', false, 3), (q_id, 'Un test réalisé en zone grise légale', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que Metasploit ?', 'Metasploit est un framework de pentest avec des exploits intégrés.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un framework de pentest avec des exploits intégrés', true, 1), (q_id, 'Un système d''exploitation', false, 2), (q_id, 'Un serveur web', false, 3), (q_id, 'Un logiciel de bureautique', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un payload en cybersécurité ?', 'Le code qui s''exécute après l''exploitation d''une faille.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Le code qui s''exécute après l''exploitation d''une faille', true, 1), (q_id, 'Le poids d''un fichier', false, 2), (q_id, 'Un type de réseau', false, 3), (q_id, 'Un format de données', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce que le Google Dorking ?', 'Utiliser des recherches Google avancées pour trouver des informations exposées.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Utiliser des recherches Google avancées pour trouver des infos exposées', true, 1), (q_id, 'Pirater le moteur de recherche Google', false, 2), (q_id, 'Créer un faux Google', false, 3), (q_id, 'Bloquer les résultats Google', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Pourquoi documente-t-on chaque étape d''un pentest ?', 'Pour prouver les résultats et aider le client à corriger les failles.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Pour prouver les résultats et aider le client à corriger les failles', true, 1), (q_id, 'Ce n''est pas nécessaire', false, 2), (q_id, 'Pour impressionner le client', false, 3), (q_id, 'Uniquement pour des raisons juridiques', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un bug bounty ?', 'Un programme de récompenses pour la découverte de failles.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un programme de récompenses pour la découverte de failles', true, 1), (q_id, 'Un virus informatique', false, 2), (q_id, 'Un concours de programmation', false, 3), (q_id, 'Une assurance cybersécurité', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 4 : IA et Éthique (16 questions)
  -- ═══════════════════════════════════════════════════════

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Que signifie "IA" (Intelligence Artificielle) ?', 'L''IA désigne des programmes capables de réaliser des tâches nécessitant normalement l''intelligence humaine.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Des programmes capables de réaliser des tâches nécessitant l''intelligence humaine', true, 1), (q_id, 'Des robots physiques uniquement', false, 2), (q_id, 'Internet Avancé', false, 3), (q_id, 'Un type de réseau informatique', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Comment l''IA peut-elle aider en cybersécurité ?', 'L''IA peut détecter des comportements anormaux et des menaces automatiquement.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Détecter des menaces et comportements anormaux automatiquement', true, 1), (q_id, 'Remplacer complètement les experts en sécurité', false, 2), (q_id, 'Créer des virus plus puissants', false, 3), (q_id, 'L''IA n''est pas utile en cybersécurité', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce que l''éthique en cybersécurité ?', 'Les règles morales qui guident le comportement des professionnels de la sécurité.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Les règles morales qui guident le comportement des professionnels de la sécurité', true, 1), (q_id, 'Les lois sur Internet uniquement', false, 2), (q_id, 'Un outil de pentest', false, 3), (q_id, 'Un type de chiffrement', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Pourquoi est-il important de respecter la vie privée en cybersécurité ?', 'Un professionnel a souvent accès à des données sensibles et doit respecter la confiance.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Car on a accès à des données sensibles et il faut respecter la confiance', true, 1), (q_id, 'Ce n''est pas important si on est autorisé', false, 2), (q_id, 'Uniquement pour éviter des amendes', false, 3), (q_id, 'La vie privée n''existe pas sur Internet', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce qu''un deepfake ?', 'Un deepfake est un faux contenu réaliste généré par l''IA.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Un faux contenu réaliste généré par l''IA', true, 1), (q_id, 'Un réseau profond (deep web)', false, 2), (q_id, 'Un type de chiffrement avancé', false, 3), (q_id, 'Un antivirus basé sur l''IA', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Les pirates peuvent-ils utiliser l''IA pour attaquer ?', 'Oui, l''IA peut automatiser des attaques et créer du phishing plus convaincant.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Oui, pour créer des attaques plus sophistiquées et automatisées', true, 1), (q_id, 'Non, l''IA ne peut pas être utilisée pour attaquer', false, 2), (q_id, 'Uniquement les gouvernements peuvent utiliser l''IA', false, 3), (q_id, 'L''IA empêche automatiquement les attaques', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce que le RGPD ?', 'Le RGPD est une loi européenne sur la protection des données personnelles.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une loi européenne sur la protection des données personnelles', true, 1), (q_id, 'Un protocole réseau', false, 2), (q_id, 'Un outil de piratage', false, 3), (q_id, 'Un type de chiffrement', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce que le dark web ?', 'Le dark web est une partie cachée d''Internet accessible via des outils spéciaux comme Tor.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Une partie cachée d''Internet accessible via des outils spéciaux', true, 1), (q_id, 'Un site web avec un thème sombre', false, 2), (q_id, 'Internet quand il y a une panne', false, 3), (q_id, 'Un réseau réservé aux hackers', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce que la divulgation responsable ?', 'Signaler une faille au propriétaire et attendre sa correction avant publication.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Signaler une faille au propriétaire et attendre sa correction avant publication', true, 1), (q_id, 'Publier la faille immédiatement sur les réseaux sociaux', false, 2), (q_id, 'Vendre la faille au plus offrant', false, 3), (q_id, 'Ignorer la faille', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce que le machine learning ?', 'Des programmes qui apprennent à partir de données sans être programmés pour chaque tâche.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Des programmes qui apprennent à partir de données', true, 1), (q_id, 'Des machines qui apprennent à marcher', false, 2), (q_id, 'Un cours en ligne sur les machines', false, 3), (q_id, 'La réparation automatique d''ordinateurs', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Pourquoi un pentester doit-il agir dans les limites du scope ?', 'Dépasser le scope est illégal et peut endommager des systèmes non autorisés.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Dépasser le scope est illégal et peut endommager des systèmes non autorisés', true, 1), (q_id, 'Le scope n''est qu''une suggestion', false, 2), (q_id, 'On peut dépasser le scope si on trouve quelque chose d''intéressant', false, 3), (q_id, 'Le scope ne concerne que les débutants', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce que la confidentialité en cybersécurité ?', 'Garantir que les informations ne sont accessibles qu''aux personnes autorisées.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Garantir que les informations ne sont accessibles qu''aux personnes autorisées', true, 1), (q_id, 'Garder un secret personnel', false, 2), (q_id, 'Cacher l''existence d''un réseau', false, 3), (q_id, 'Supprimer toutes les données après utilisation', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Que signifie le sigle "CIA" en cybersécurité ?', 'Confidentialité, Intégrité, Disponibilité — les trois piliers de la sécurité de l''information.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Confidentialité, Intégrité, Disponibilité', true, 1), (q_id, 'Central Intelligence Agency uniquement', false, 2), (q_id, 'Computer Internet Access', false, 3), (q_id, 'Certified Information Analyst', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce que l''intégrité des données ?', 'La garantie que les données n''ont pas été modifiées sans autorisation.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'La garantie que les données n''ont pas été modifiées sans autorisation', true, 1), (q_id, 'La vitesse de transfert des données', false, 2), (q_id, 'La quantité de données stockées', false, 3), (q_id, 'Le nombre de copies de sauvegarde', false, 4);

  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES (gen_random_uuid(), cat_ia, 'Qu''est-ce que la disponibilité en cybersécurité ?', 'Garantir que les systèmes sont accessibles quand les utilisateurs en ont besoin.', 'facile') RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES (q_id, 'Garantir que les systèmes sont accessibles quand on en a besoin', true, 1), (q_id, 'Avoir Internet 24h/24', false, 2), (q_id, 'Rendre toutes les données publiques', false, 3), (q_id, 'Avoir un ordinateur portable', false, 4);

END $$;
