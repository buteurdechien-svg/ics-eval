-- ═══════════════════════════════════════════════════════════
--  ICS Eval — Banque de 104 questions NIVEAU DÉBUTANT
--  Questions de base : définitions, significations, vocabulaire
--  Répartition : Réseaux 26, Vulnérabilités 36, Méthodologie 26, IA/Éthique 16
-- ═══════════════════════════════════════════════════════════

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

  -- R1
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "HTTP" ?', 'HTTP signifie HyperText Transfer Protocol. C''est le protocole utilisé pour transférer les pages web entre un serveur et un navigateur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'HyperText Transfer Protocol', true, 1),
    (q_id, 'High Technology Transfer Program', false, 2),
    (q_id, 'HyperText Transmission Port', false, 3),
    (q_id, 'Home Tool Transfer Protocol', false, 4);

  -- R2
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''une adresse IP ?', 'Une adresse IP (Internet Protocol) est un numéro unique attribué à chaque appareil connecté à un réseau. Elle permet d''identifier et de localiser un appareil sur Internet ou un réseau local.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un numéro unique qui identifie un appareil sur un réseau', true, 1),
    (q_id, 'Le nom d''un site web', false, 2),
    (q_id, 'Un mot de passe pour accéder à Internet', false, 3),
    (q_id, 'Un logiciel de navigation web', false, 4);

  -- R3
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le "S" dans "HTTPS" ?', 'Le "S" signifie Secure (sécurisé). HTTPS chiffre les données échangées entre le navigateur et le serveur grâce au protocole TLS/SSL, ce qui protège contre l''espionnage.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Secure (sécurisé)', true, 1),
    (q_id, 'Speed (vitesse)', false, 2),
    (q_id, 'Server (serveur)', false, 3),
    (q_id, 'System (système)', false, 4);

  -- R4
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel est le rôle d''un serveur DNS ?', 'Le DNS (Domain Name System) traduit les noms de domaine (comme google.com) en adresses IP. C''est comme un annuaire téléphonique d''Internet.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Traduire les noms de domaine en adresses IP', true, 1),
    (q_id, 'Stocker les fichiers des sites web', false, 2),
    (q_id, 'Protéger contre les virus', false, 3),
    (q_id, 'Envoyer des e-mails', false, 4);

  -- R5
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un port en informatique réseau ?', 'Un port est un numéro qui identifie un service ou une application sur un appareil. Par exemple, le port 80 est utilisé par HTTP et le port 443 par HTTPS.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un numéro qui identifie un service sur un appareil', true, 1),
    (q_id, 'Un câble qui relie deux ordinateurs', false, 2),
    (q_id, 'Un type de virus informatique', false, 3),
    (q_id, 'Un logiciel de sécurité', false, 4);

  -- R6
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel port est utilisé par défaut par le protocole HTTP ?', 'Le port 80 est le port standard pour HTTP. Le port 443 est pour HTTPS, le port 22 pour SSH et le port 21 pour FTP.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, '80', true, 1),
    (q_id, '443', false, 2),
    (q_id, '22', false, 3),
    (q_id, '8080', false, 4);

  -- R7
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "URL" ?', 'URL signifie Uniform Resource Locator. C''est l''adresse complète d''une page web, par exemple https://www.example.com/page.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Uniform Resource Locator', true, 1),
    (q_id, 'Universal Remote Link', false, 2),
    (q_id, 'Unique Reference Language', false, 3),
    (q_id, 'User Registration Login', false, 4);

  -- R8
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un navigateur web ?', 'Un navigateur web est un logiciel qui permet d''accéder aux sites Internet. Exemples : Chrome, Firefox, Safari, Edge.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un logiciel qui permet d''afficher les sites web', true, 1),
    (q_id, 'Un câble réseau', false, 2),
    (q_id, 'Un système d''exploitation', false, 3),
    (q_id, 'Un serveur de base de données', false, 4);

  -- R9
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle est la différence principale entre TCP et UDP ?', 'TCP vérifie que les données arrivent correctement (fiable mais plus lent). UDP envoie les données sans vérification (plus rapide mais pas garanti).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'TCP est fiable et vérifie la réception, UDP est plus rapide mais sans garantie', true, 1),
    (q_id, 'TCP est plus rapide que UDP', false, 2),
    (q_id, 'UDP est plus sécurisé que TCP', false, 3),
    (q_id, 'Il n''y a aucune différence', false, 4);

  -- R10
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "LAN" ?', 'LAN signifie Local Area Network (réseau local). C''est un réseau qui connecte des appareils dans une zone limitée, comme un bureau ou une maison.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Local Area Network', true, 1),
    (q_id, 'Large Access Network', false, 2),
    (q_id, 'Link And Node', false, 3),
    (q_id, 'Login Authentication Name', false, 4);

  -- R11
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un pare-feu (firewall) ?', 'Un pare-feu est un dispositif de sécurité qui filtre le trafic réseau entrant et sortant selon des règles définies. Il protège un réseau contre les accès non autorisés.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un système qui filtre le trafic réseau pour bloquer les accès non autorisés', true, 1),
    (q_id, 'Un antivirus', false, 2),
    (q_id, 'Un câble réseau spécial', false, 3),
    (q_id, 'Un navigateur web sécurisé', false, 4);

  -- R12
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "VPN" ?', 'VPN signifie Virtual Private Network (réseau privé virtuel). Il crée un tunnel chiffré entre ton appareil et un serveur distant pour protéger tes données.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Virtual Private Network', true, 1),
    (q_id, 'Very Protected Network', false, 2),
    (q_id, 'Virtual Public Node', false, 3),
    (q_id, 'Verified Personal Name', false, 4);

  -- R13
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un cookie dans un navigateur web ?', 'Un cookie est un petit fichier texte stocké par le navigateur. Il permet aux sites de se souvenir de toi (connexion, préférences, panier d''achat).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un petit fichier stocké par le navigateur pour mémoriser des informations', true, 1),
    (q_id, 'Un virus informatique', false, 2),
    (q_id, 'Un type de mot de passe', false, 3),
    (q_id, 'Une extension du navigateur', false, 4);

  -- R14
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle est la fonction d''un serveur web ?', 'Un serveur web est un ordinateur qui stocke les fichiers d''un site web et les envoie aux navigateurs qui les demandent via le protocole HTTP/HTTPS.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Stocker et envoyer les pages web aux navigateurs', true, 1),
    (q_id, 'Protéger contre les virus', false, 2),
    (q_id, 'Créer des adresses e-mail', false, 3),
    (q_id, 'Gérer les mots de passe des utilisateurs', false, 4);

  -- R15
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie "Wi-Fi" ?', 'Wi-Fi est une technologie de réseau sans fil qui permet aux appareils de se connecter à Internet ou entre eux sans câble, en utilisant des ondes radio.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une technologie de connexion réseau sans fil', true, 1),
    (q_id, 'Un type de câble réseau', false, 2),
    (q_id, 'Un protocole de sécurité', false, 3),
    (q_id, 'Un logiciel antivirus', false, 4);

  -- R16
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce que le protocole FTP ?', 'FTP (File Transfer Protocol) est un protocole utilisé pour transférer des fichiers entre un client et un serveur. Il utilise le port 21 par défaut.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un protocole de transfert de fichiers', true, 1),
    (q_id, 'Un pare-feu', false, 2),
    (q_id, 'Un type de virus', false, 3),
    (q_id, 'Un navigateur web', false, 4);

  -- R17
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''une adresse MAC ?', 'Une adresse MAC (Media Access Control) est un identifiant unique attribué à la carte réseau de chaque appareil. Elle est fixée par le fabricant.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un identifiant unique de la carte réseau d''un appareil', true, 1),
    (q_id, 'L''adresse d''un ordinateur Apple Mac', false, 2),
    (q_id, 'Un mot de passe réseau', false, 3),
    (q_id, 'Une adresse e-mail spéciale', false, 4);

  -- R18
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que fait la commande "ping" ?', 'La commande ping envoie un petit message à un autre appareil sur le réseau pour vérifier s''il est joignable et mesurer le temps de réponse.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Vérifier si un appareil est joignable sur le réseau', true, 1),
    (q_id, 'Télécharger un fichier', false, 2),
    (q_id, 'Supprimer un virus', false, 3),
    (q_id, 'Créer un nouveau réseau', false, 4);

  -- R19
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "SSH" ?', 'SSH signifie Secure Shell. C''est un protocole qui permet de se connecter à distance à un ordinateur de manière sécurisée (chiffrée). Il utilise le port 22.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Secure Shell', true, 1),
    (q_id, 'Super Safe Hosting', false, 2),
    (q_id, 'System Security Hub', false, 3),
    (q_id, 'Server Share Host', false, 4);

  -- R20
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un proxy ?', 'Un proxy est un serveur intermédiaire entre ton ordinateur et Internet. Il peut filtrer le trafic, cacher ton adresse IP ou accélérer la navigation grâce au cache.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un serveur intermédiaire entre l''utilisateur et Internet', true, 1),
    (q_id, 'Un type de virus', false, 2),
    (q_id, 'Un câble réseau', false, 3),
    (q_id, 'Un système d''exploitation', false, 4);

  -- R21
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle est la différence entre HTTP et HTTPS ?', 'HTTPS est la version sécurisée de HTTP. Les données sont chiffrées avec TLS/SSL, ce qui empêche quelqu''un d''intercepter et lire les informations échangées.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'HTTPS chiffre les données, HTTP ne les chiffre pas', true, 1),
    (q_id, 'HTTPS est plus lent que HTTP', false, 2),
    (q_id, 'HTTP est plus sécurisé que HTTPS', false, 3),
    (q_id, 'Il n''y a aucune différence', false, 4);

  -- R22
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le sigle "API" ?', 'API signifie Application Programming Interface. C''est un ensemble de règles qui permet à deux applications de communiquer entre elles.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Application Programming Interface', true, 1),
    (q_id, 'Advanced Protection Internet', false, 2),
    (q_id, 'Automatic Program Installation', false, 3),
    (q_id, 'Active Port Identification', false, 4);

  -- R23
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce que le protocole DHCP ?', 'DHCP (Dynamic Host Configuration Protocol) attribue automatiquement une adresse IP aux appareils qui se connectent au réseau, sans configuration manuelle.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un protocole qui attribue automatiquement des adresses IP', true, 1),
    (q_id, 'Un protocole de transfert de fichiers', false, 2),
    (q_id, 'Un protocole de messagerie', false, 3),
    (q_id, 'Un protocole de chiffrement', false, 4);

  -- R24
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un nom de domaine ?', 'Un nom de domaine est l''adresse lisible d''un site web (comme google.com). Le DNS le traduit en adresse IP pour que l''ordinateur puisse trouver le serveur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Le nom lisible d''un site web, comme google.com', true, 1),
    (q_id, 'Le mot de passe d''un site web', false, 2),
    (q_id, 'L''adresse IP d''un serveur', false, 3),
    (q_id, 'Le nom du propriétaire d''un site', false, 4);

  -- R25
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le chiffrement des données ?', 'Le chiffrement transforme les données en un format illisible pour quiconque ne possède pas la clé de déchiffrement. Cela protège la confidentialité des informations.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Transformer les données pour les rendre illisibles sans la clé', true, 1),
    (q_id, 'Compresser les données pour gagner de l''espace', false, 2),
    (q_id, 'Supprimer les données définitivement', false, 3),
    (q_id, 'Copier les données sur un autre serveur', false, 4);

  -- R26
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''une requête GET en HTTP ?', 'Une requête GET demande au serveur de renvoyer une ressource (comme une page web). Les paramètres sont visibles dans l''URL. Elle ne modifie pas les données du serveur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une demande pour récupérer des données depuis un serveur', true, 1),
    (q_id, 'Une demande pour supprimer un fichier', false, 2),
    (q_id, 'Une demande pour modifier un mot de passe', false, 3),
    (q_id, 'Une demande pour créer un nouveau compte', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 2 : Vulnérabilités Web (36 questions)
  -- ═══════════════════════════════════════════════════════

  -- V1
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une vulnérabilité informatique ?', 'Une vulnérabilité est une faiblesse dans un système, un logiciel ou un réseau qui peut être exploitée par un attaquant pour causer des dommages ou accéder à des données.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une faiblesse qui peut être exploitée par un attaquant', true, 1),
    (q_id, 'Un logiciel de protection', false, 2),
    (q_id, 'Un type de pare-feu', false, 3),
    (q_id, 'Une mise à jour de sécurité', false, 4);

  -- V2
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le phishing (hameçonnage) ?', 'Le phishing est une technique d''arnaque qui consiste à se faire passer pour un organisme de confiance (banque, entreprise) pour voler des informations personnelles via de faux e-mails ou sites web.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une arnaque par faux e-mails ou sites pour voler des informations', true, 1),
    (q_id, 'Un logiciel antivirus', false, 2),
    (q_id, 'Une technique de chiffrement', false, 3),
    (q_id, 'Un protocole réseau', false, 4);

  -- V3
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un malware ?', 'Un malware (logiciel malveillant) est un programme conçu pour endommager, perturber ou prendre le contrôle d''un système. Exemples : virus, vers, trojans, ransomwares.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un logiciel malveillant conçu pour nuire', true, 1),
    (q_id, 'Un logiciel de mise à jour', false, 2),
    (q_id, 'Un outil de développement web', false, 3),
    (q_id, 'Un type de réseau', false, 4);

  -- V4
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un ransomware ?', 'Un ransomware est un malware qui chiffre les fichiers de la victime et demande une rançon (souvent en cryptomonnaie) pour les déchiffrer.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un malware qui chiffre les fichiers et demande une rançon', true, 1),
    (q_id, 'Un logiciel de sauvegarde', false, 2),
    (q_id, 'Un antivirus gratuit', false, 3),
    (q_id, 'Un pare-feu avancé', false, 4);

  -- V5
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une injection SQL ?', 'Une injection SQL est une attaque où un pirate insère du code SQL malveillant dans un formulaire web pour manipuler la base de données (lire, modifier ou supprimer des données).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Insérer du code malveillant dans un formulaire pour attaquer la base de données', true, 1),
    (q_id, 'Installer un logiciel de base de données', false, 2),
    (q_id, 'Créer une sauvegarde de base de données', false, 3),
    (q_id, 'Mettre à jour un serveur SQL', false, 4);

  -- V6
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le XSS (Cross-Site Scripting) ?', 'Le XSS est une attaque où un pirate injecte du code JavaScript malveillant dans une page web. Quand d''autres utilisateurs visitent la page, le script s''exécute dans leur navigateur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Injecter du code JavaScript malveillant dans une page web', true, 1),
    (q_id, 'Créer un site web', false, 2),
    (q_id, 'Scanner un réseau', false, 3),
    (q_id, 'Chiffrer des données', false, 4);

  -- V7
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un mot de passe fort ?', 'Un mot de passe fort est long (12+ caractères), combine majuscules, minuscules, chiffres et caractères spéciaux, et n''est pas un mot du dictionnaire.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un mot de passe long avec des majuscules, chiffres et caractères spéciaux', true, 1),
    (q_id, 'Un mot de passe de 4 chiffres', false, 2),
    (q_id, 'Le nom de son animal de compagnie', false, 3),
    (q_id, 'Le mot "password" en majuscules', false, 4);

  -- V8
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque par force brute ?', 'Une attaque par force brute consiste à essayer toutes les combinaisons possibles de mots de passe jusqu''à trouver le bon. C''est pourquoi les mots de passe longs sont importants.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Essayer toutes les combinaisons possibles de mots de passe', true, 1),
    (q_id, 'Casser physiquement un ordinateur', false, 2),
    (q_id, 'Envoyer beaucoup d''e-mails', false, 3),
    (q_id, 'Couper le courant d''un serveur', false, 4);

  -- V9
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque DDoS ?', 'DDoS (Distributed Denial of Service) consiste à submerger un serveur avec un très grand nombre de requêtes pour le rendre indisponible aux utilisateurs légitimes.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Submerger un serveur de requêtes pour le rendre indisponible', true, 1),
    (q_id, 'Voler des mots de passe', false, 2),
    (q_id, 'Chiffrer les fichiers d''un serveur', false, 3),
    (q_id, 'Installer un virus sur un ordinateur', false, 4);

  -- V10
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que l''ingénierie sociale ?', 'L''ingénierie sociale est l''art de manipuler des personnes pour qu''elles révèlent des informations confidentielles. Elle exploite la confiance humaine plutôt que les failles techniques.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Manipuler des personnes pour obtenir des informations confidentielles', true, 1),
    (q_id, 'Construire des réseaux sociaux', false, 2),
    (q_id, 'Programmer des robots', false, 3),
    (q_id, 'Concevoir des sites web', false, 4);

  -- V11
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un virus informatique ?', 'Un virus est un programme malveillant qui se propage en s''attachant à d''autres fichiers ou programmes. Il s''active quand l''utilisateur exécute le fichier infecté.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un programme malveillant qui se propage en s''attachant à des fichiers', true, 1),
    (q_id, 'Un bug dans un logiciel', false, 2),
    (q_id, 'Un problème matériel', false, 3),
    (q_id, 'Une panne de réseau', false, 4);

  -- V12
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un cheval de Troie (trojan) ?', 'Un cheval de Troie est un malware déguisé en programme légitime. L''utilisateur l''installe volontairement en pensant que c''est un logiciel utile, mais il contient du code malveillant.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un malware déguisé en logiciel légitime', true, 1),
    (q_id, 'Un antivirus', false, 2),
    (q_id, 'Un outil de développement', false, 3),
    (q_id, 'Un protocole de sécurité', false, 4);

  -- V13
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que l''authentification à deux facteurs (2FA) ?', 'Le 2FA ajoute une deuxième vérification en plus du mot de passe : un code SMS, une application d''authentification ou une clé physique. Même si le mot de passe est volé, le compte reste protégé.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une sécurité qui demande deux preuves d''identité différentes', true, 1),
    (q_id, 'Utiliser deux mots de passe différents', false, 2),
    (q_id, 'Se connecter depuis deux appareils', false, 3),
    (q_id, 'Avoir deux comptes sur le même site', false, 4);

  -- V14
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Que signifie le sigle "CVE" ?', 'CVE signifie Common Vulnerabilities and Exposures. C''est un système de référence qui donne un identifiant unique à chaque vulnérabilité connue (ex: CVE-2024-1234).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Common Vulnerabilities and Exposures', true, 1),
    (q_id, 'Computer Virus Encryption', false, 2),
    (q_id, 'Certified Virtual Environment', false, 3),
    (q_id, 'Central Verification Engine', false, 4);

  -- V15
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un keylogger ?', 'Un keylogger est un logiciel ou matériel espion qui enregistre tout ce que tu tapes au clavier (mots de passe, messages, numéros de carte) pour l''envoyer à un pirate.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un programme qui enregistre les frappes du clavier', true, 1),
    (q_id, 'Un type de clavier sécurisé', false, 2),
    (q_id, 'Un raccourci clavier', false, 3),
    (q_id, 'Un logiciel de frappe rapide', false, 4);

  -- V16
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un exploit ?', 'Un exploit est un programme ou une technique qui tire parti d''une vulnérabilité pour compromettre un système. C''est l''outil concret utilisé pour exploiter une faille.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un programme qui exploite une faille de sécurité', true, 1),
    (q_id, 'Un logiciel de protection', false, 2),
    (q_id, 'Un type de réseau', false, 3),
    (q_id, 'Un langage de programmation', false, 4);

  -- V17
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Pourquoi les mises à jour logicielles sont-elles importantes pour la sécurité ?', 'Les mises à jour corrigent les vulnérabilités découvertes dans les logiciels. Sans mises à jour, les failles connues restent ouvertes et exploitables par les attaquants.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Elles corrigent les failles de sécurité connues', true, 1),
    (q_id, 'Elles rendent l''ordinateur plus rapide', false, 2),
    (q_id, 'Elles changent le design du logiciel', false, 3),
    (q_id, 'Elles ne servent à rien', false, 4);

  -- V18
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un spam ?', 'Le spam est un message non sollicité envoyé en masse, généralement par e-mail. Il peut contenir de la publicité, des arnaques ou des liens vers des malwares.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un message non sollicité envoyé en masse', true, 1),
    (q_id, 'Un message chiffré', false, 2),
    (q_id, 'Un e-mail urgent du gouvernement', false, 3),
    (q_id, 'Un type de virus', false, 4);

  -- V19
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une faille zero-day ?', 'Une faille zero-day est une vulnérabilité inconnue de l''éditeur du logiciel. Elle est appelée "zero-day" car l''éditeur a eu zéro jour pour la corriger quand elle est exploitée.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une vulnérabilité inconnue de l''éditeur, pas encore corrigée', true, 1),
    (q_id, 'Une faille qui ne dure qu''un jour', false, 2),
    (q_id, 'Un virus très ancien', false, 3),
    (q_id, 'Une mise à jour du jour zéro', false, 4);

  -- V20
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le spoofing ?', 'Le spoofing consiste à se faire passer pour quelqu''un ou quelque chose d''autre (fausse adresse IP, faux e-mail, faux site) pour tromper la victime.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Usurper l''identité de quelqu''un ou d''un système', true, 1),
    (q_id, 'Accélérer un réseau', false, 2),
    (q_id, 'Chiffrer des fichiers', false, 3),
    (q_id, 'Installer un antivirus', false, 4);

  -- V21
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un botnet ?', 'Un botnet est un réseau d''ordinateurs infectés (zombies) contrôlés à distance par un pirate. Ils servent souvent à lancer des attaques DDoS ou envoyer du spam.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un réseau d''ordinateurs infectés contrôlés par un pirate', true, 1),
    (q_id, 'Un réseau de robots physiques', false, 2),
    (q_id, 'Un logiciel de chat automatique', false, 3),
    (q_id, 'Un réseau Wi-Fi public', false, 4);

  -- V22
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Pourquoi ne faut-il pas utiliser le même mot de passe partout ?', 'Si un site est piraté et ton mot de passe est volé, l''attaquant peut l''essayer sur tous tes autres comptes. C''est ce qu''on appelle le "credential stuffing".', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Si un compte est compromis, tous les autres le sont aussi', true, 1),
    (q_id, 'C''est plus facile à retenir', false, 2),
    (q_id, 'Cela ralentit l''ordinateur', false, 3),
    (q_id, 'Les sites web ne l''autorisent pas', false, 4);

  -- V23
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un certificat SSL/TLS ?', 'Un certificat SSL/TLS est un fichier numérique qui prouve l''identité d''un site web et permet le chiffrement des données. Le cadenas dans la barre d''adresse indique sa présence.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un certificat qui authentifie un site web et chiffre les communications', true, 1),
    (q_id, 'Un diplôme en informatique', false, 2),
    (q_id, 'Un type de pare-feu', false, 3),
    (q_id, 'Un logiciel antivirus', false, 4);

  -- V24
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un spyware ?', 'Un spyware (logiciel espion) est un malware qui surveille secrètement l''activité de l''utilisateur : sites visités, mots de passe tapés, fichiers consultés.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un logiciel espion qui surveille l''activité de l''utilisateur', true, 1),
    (q_id, 'Un logiciel de surveillance parentale autorisé', false, 2),
    (q_id, 'Un outil de développement', false, 3),
    (q_id, 'Un navigateur web sécurisé', false, 4);

  -- V25
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque Man-in-the-Middle (MITM) ?', 'Une attaque MITM se produit quand un pirate se place entre deux personnes qui communiquent, interceptant et pouvant modifier les messages échangés sans que les victimes le sachent.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Intercepter les communications entre deux parties', true, 1),
    (q_id, 'Pirater un serveur web', false, 2),
    (q_id, 'Envoyer des virus par e-mail', false, 3),
    (q_id, 'Deviner un mot de passe', false, 4);

  -- V26
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un antivirus ?', 'Un antivirus est un logiciel de sécurité qui détecte, bloque et supprime les malwares (virus, trojans, spywares, etc.) sur un ordinateur ou un appareil mobile.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un logiciel qui détecte et supprime les malwares', true, 1),
    (q_id, 'Un pare-feu réseau', false, 2),
    (q_id, 'Un outil de chiffrement', false, 3),
    (q_id, 'Un navigateur web', false, 4);

  -- V27
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le CSRF (Cross-Site Request Forgery) ?', 'Le CSRF est une attaque qui force un utilisateur connecté à exécuter une action non voulue sur un site (comme un virement) en cliquant sur un lien piégé.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Forcer un utilisateur connecté à effectuer une action à son insu', true, 1),
    (q_id, 'Créer un faux site web', false, 2),
    (q_id, 'Voler un mot de passe', false, 3),
    (q_id, 'Scanner un réseau', false, 4);

  -- V28
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Que sont les données personnelles ?', 'Les données personnelles sont toute information qui permet d''identifier une personne : nom, adresse, e-mail, numéro de téléphone, adresse IP, photo, etc.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Toute information qui permet d''identifier une personne', true, 1),
    (q_id, 'Uniquement le nom et prénom', false, 2),
    (q_id, 'Les fichiers sur un ordinateur', false, 3),
    (q_id, 'Les messages envoyés sur les réseaux sociaux', false, 4);

  -- V29
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un ver informatique (worm) ?', 'Un ver est un malware qui se propage automatiquement d''un ordinateur à l''autre via le réseau, sans avoir besoin d''un fichier hôte ni d''action de l''utilisateur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un malware qui se propage tout seul via le réseau', true, 1),
    (q_id, 'Un virus qui détruit les fichiers', false, 2),
    (q_id, 'Un programme de diagnostic réseau', false, 3),
    (q_id, 'Un outil de sauvegarde', false, 4);

  -- V30
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un hash (empreinte numérique) ?', 'Un hash est une chaîne de caractères unique générée à partir de données. Il permet de vérifier l''intégrité d''un fichier ou de stocker des mots de passe de manière sécurisée.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une empreinte unique calculée à partir de données', true, 1),
    (q_id, 'Un mot de passe chiffré', false, 2),
    (q_id, 'Un type de virus', false, 3),
    (q_id, 'Un protocole réseau', false, 4);

  -- V31
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Pourquoi un Wi-Fi public est-il risqué ?', 'Sur un Wi-Fi public non sécurisé, un attaquant peut intercepter les données qui circulent (mots de passe, e-mails). Il est conseillé d''utiliser un VPN sur les réseaux publics.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Les données peuvent être interceptées par un attaquant', true, 1),
    (q_id, 'La connexion est trop lente', false, 2),
    (q_id, 'Il consomme plus de batterie', false, 3),
    (q_id, 'Il n''y a aucun risque', false, 4);

  -- V32
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le social engineering par téléphone (vishing) ?', 'Le vishing (voice phishing) est une arnaque téléphonique où l''attaquant se fait passer pour une banque, un support technique, etc., pour obtenir des informations confidentielles.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une arnaque téléphonique pour voler des informations', true, 1),
    (q_id, 'Un appel de confirmation de commande', false, 2),
    (q_id, 'Une technique de chiffrement vocal', false, 3),
    (q_id, 'Un protocole VoIP', false, 4);

  -- V33
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un adware ?', 'Un adware est un logiciel qui affiche des publicités indésirables, souvent sous forme de pop-ups. Il peut aussi collecter des données de navigation pour cibler les pubs.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un logiciel qui affiche des publicités indésirables', true, 1),
    (q_id, 'Un bloqueur de publicités', false, 2),
    (q_id, 'Un outil de marketing', false, 3),
    (q_id, 'Un navigateur web', false, 4);

  -- V34
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une backdoor (porte dérobée) ?', 'Une backdoor est un accès secret à un système qui contourne les mécanismes de sécurité normaux. Un pirate peut l''installer pour revenir facilement plus tard.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un accès secret qui contourne la sécurité normale', true, 1),
    (q_id, 'Une sauvegarde de sécurité', false, 2),
    (q_id, 'Une porte de sortie d''urgence du réseau', false, 3),
    (q_id, 'Un pare-feu secondaire', false, 4);

  -- V35
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le credential stuffing ?', 'Le credential stuffing consiste à utiliser des identifiants volés sur un site (lors d''une fuite) pour essayer de se connecter automatiquement à d''autres sites.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Réutiliser des identifiants volés pour accéder à d''autres comptes', true, 1),
    (q_id, 'Créer de faux comptes', false, 2),
    (q_id, 'Deviner un mot de passe', false, 3),
    (q_id, 'Chiffrer des identifiants', false, 4);

  -- V36
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une fuite de données (data breach) ?', 'Une fuite de données se produit quand des informations confidentielles (mots de passe, données personnelles) sont accédées ou volées par des personnes non autorisées.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un accès non autorisé à des données confidentielles', true, 1),
    (q_id, 'Une panne de serveur', false, 2),
    (q_id, 'Une sauvegarde ratée', false, 3),
    (q_id, 'Un problème de connexion Internet', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 3 : Méthodologie du Pentest (26 questions)
  -- ═══════════════════════════════════════════════════════

  -- M1
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un test d''intrusion (pentest) ?', 'Un pentest est une simulation d''attaque autorisée contre un système informatique pour trouver ses vulnérabilités avant qu''un vrai pirate ne les exploite.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une simulation d''attaque autorisée pour trouver les failles', true, 1),
    (q_id, 'Une attaque illégale contre un système', false, 2),
    (q_id, 'L''installation d''un antivirus', false, 3),
    (q_id, 'La configuration d''un pare-feu', false, 4);

  -- M2
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quelle est la première étape d''un pentest ?', 'La reconnaissance (ou collecte d''informations) est la première étape. On rassemble un maximum d''informations sur la cible avant de passer à l''action.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'La reconnaissance (collecte d''informations)', true, 1),
    (q_id, 'L''exploitation des failles', false, 2),
    (q_id, 'La rédaction du rapport', false, 3),
    (q_id, 'L''installation d''outils', false, 4);

  -- M3
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un hacker éthique (white hat) ?', 'Un hacker éthique est un expert en sécurité qui utilise ses compétences pour trouver et signaler les failles de sécurité de manière légale et autorisée.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un expert qui teste la sécurité de manière légale et autorisée', true, 1),
    (q_id, 'Un pirate qui vole des données', false, 2),
    (q_id, 'Un développeur web', false, 3),
    (q_id, 'Un administrateur réseau', false, 4);

  -- M4
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un black hat ?', 'Un black hat est un pirate informatique malveillant qui exploite les failles de sécurité de manière illégale pour son propre profit ou pour causer des dommages.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un pirate qui agit de manière illégale et malveillante', true, 1),
    (q_id, 'Un expert en sécurité légal', false, 2),
    (q_id, 'Un type de chapeau', false, 3),
    (q_id, 'Un logiciel de hacking', false, 4);

  -- M5
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un scope dans un pentest ?', 'Le scope définit les limites du test : quels systèmes, applications ou réseaux peuvent être testés, et lesquels sont interdits. Il est défini avant le début du test.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Les limites et le périmètre autorisé du test', true, 1),
    (q_id, 'Un outil de scan', false, 2),
    (q_id, 'Un type de vulnérabilité', false, 3),
    (q_id, 'Un rapport final', false, 4);

  -- M6
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Pourquoi un pentest nécessite-t-il une autorisation écrite ?', 'Sans autorisation, tester la sécurité d''un système est illégal (piratage). L''autorisation écrite protège le pentester et définit ce qui est permis.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Sans autorisation, c''est considéré comme du piratage illégal', true, 1),
    (q_id, 'C''est juste une formalité administrative', false, 2),
    (q_id, 'Pour que le client paie la facture', false, 3),
    (q_id, 'Ce n''est pas obligatoire', false, 4);

  -- M7
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que Nmap ?', 'Nmap (Network Mapper) est un outil gratuit de scan réseau. Il permet de découvrir les appareils sur un réseau, les ports ouverts et les services qui y tournent.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un outil de scan réseau pour découvrir les ports et services', true, 1),
    (q_id, 'Un navigateur web sécurisé', false, 2),
    (q_id, 'Un système d''exploitation', false, 3),
    (q_id, 'Un antivirus', false, 4);

  -- M8
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que Kali Linux ?', 'Kali Linux est un système d''exploitation basé sur Linux, conçu pour les tests de sécurité. Il contient des centaines d''outils de pentest préinstallés.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un système d''exploitation dédié aux tests de sécurité', true, 1),
    (q_id, 'Un antivirus', false, 2),
    (q_id, 'Un navigateur web', false, 3),
    (q_id, 'Un service cloud', false, 4);

  -- M9
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que la reconnaissance passive ?', 'La reconnaissance passive consiste à collecter des informations sur une cible sans interagir directement avec elle : recherche Google, WHOIS, réseaux sociaux, etc.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Collecter des informations sans toucher directement le système cible', true, 1),
    (q_id, 'Scanner les ports d''un serveur', false, 2),
    (q_id, 'Exploiter une faille', false, 3),
    (q_id, 'Installer un logiciel espion', false, 4);

  -- M10
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un rapport de pentest ?', 'Un rapport de pentest est un document qui détaille les vulnérabilités trouvées, leur niveau de gravité, les preuves et les recommandations pour les corriger.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un document détaillant les failles trouvées et comment les corriger', true, 1),
    (q_id, 'Un logiciel de scan', false, 2),
    (q_id, 'Un contrat entre le pentester et le client', false, 3),
    (q_id, 'Un plan de réseau', false, 4);

  -- M11
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Que signifie "OWASP" ?', 'OWASP signifie Open Web Application Security Project. C''est une organisation qui publie des guides et un classement des 10 vulnérabilités web les plus courantes (OWASP Top 10).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Open Web Application Security Project', true, 1),
    (q_id, 'Online Web Attack Security Platform', false, 2),
    (q_id, 'Official Windows Application Security Policy', false, 3),
    (q_id, 'Open Wireless Access Security Protocol', false, 4);

  -- M12
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un scan de ports ?', 'Un scan de ports consiste à vérifier quels ports sont ouverts sur un serveur. Chaque port ouvert correspond potentiellement à un service qui peut être vulnérable.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Vérifier quels ports sont ouverts sur un serveur', true, 1),
    (q_id, 'Installer un pare-feu', false, 2),
    (q_id, 'Créer un nouveau port réseau', false, 3),
    (q_id, 'Désactiver les ports USB', false, 4);

  -- M13
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que Burp Suite ?', 'Burp Suite est un outil de test de sécurité web. Il permet d''intercepter, d''analyser et de modifier les requêtes HTTP entre le navigateur et le serveur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un outil pour intercepter et analyser les requêtes web', true, 1),
    (q_id, 'Un antivirus', false, 2),
    (q_id, 'Un système d''exploitation', false, 3),
    (q_id, 'Un service de messagerie', false, 4);

  -- M14
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un pentest en boîte noire (black box) ?', 'En pentest boîte noire, le testeur n''a aucune information préalable sur le système. Il agit comme un attaquant externe qui découvre tout par lui-même.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un test où le pentester n''a aucune information sur le système', true, 1),
    (q_id, 'Un test avec un accès complet au code source', false, 2),
    (q_id, 'Un test uniquement sur les serveurs physiques', false, 3),
    (q_id, 'Un test effectué de nuit', false, 4);

  -- M15
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un pentest en boîte blanche (white box) ?', 'En pentest boîte blanche, le testeur a accès à toutes les informations : code source, architecture, identifiants. Cela permet un test plus approfondi.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un test où le pentester a un accès complet aux informations du système', true, 1),
    (q_id, 'Un test sans aucune information', false, 2),
    (q_id, 'Un test uniquement sur les pages web blanches', false, 3),
    (q_id, 'Un test réalisé par un white hat uniquement', false, 4);

  -- M16
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que le WHOIS ?', 'WHOIS est un service qui permet de rechercher les informations d''enregistrement d''un nom de domaine : propriétaire, date de création, serveurs DNS, etc.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un service pour consulter les informations d''un nom de domaine', true, 1),
    (q_id, 'Un moteur de recherche', false, 2),
    (q_id, 'Un réseau social', false, 3),
    (q_id, 'Un outil de piratage', false, 4);

  -- M17
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que l''escalade de privilèges ?', 'L''escalade de privilèges est une technique où un attaquant obtient des droits d''accès supérieurs à ceux qu''il avait initialement, par exemple passer d''utilisateur simple à administrateur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Obtenir des droits d''accès plus élevés que prévu', true, 1),
    (q_id, 'Monter dans la hiérarchie d''une entreprise', false, 2),
    (q_id, 'Augmenter la vitesse du réseau', false, 3),
    (q_id, 'Ajouter des utilisateurs au système', false, 4);

  -- M18
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un scanner de vulnérabilités ?', 'Un scanner de vulnérabilités est un outil automatique qui analyse un système pour identifier les failles de sécurité connues. Exemples : Nessus, OpenVAS.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un outil qui recherche automatiquement les failles connues', true, 1),
    (q_id, 'Un antivirus', false, 2),
    (q_id, 'Un scanner physique de documents', false, 3),
    (q_id, 'Un outil de développement web', false, 4);

  -- M19
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que la surface d''attaque ?', 'La surface d''attaque est l''ensemble des points d''entrée qu''un attaquant pourrait utiliser : ports ouverts, formulaires web, API, applications exposées sur Internet.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''ensemble des points d''entrée potentiels pour un attaquant', true, 1),
    (q_id, 'La taille du disque dur', false, 2),
    (q_id, 'Le nombre d''employés d''une entreprise', false, 3),
    (q_id, 'La zone géographique du serveur', false, 4);

  -- M20
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un grey hat ?', 'Un grey hat est un hacker qui se situe entre le white hat et le black hat. Il peut trouver des failles sans autorisation mais les signale ensuite au lieu de les exploiter.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un hacker qui agit sans autorisation mais sans intention malveillante', true, 1),
    (q_id, 'Un débutant en sécurité', false, 2),
    (q_id, 'Un expert certifié', false, 3),
    (q_id, 'Un employé du gouvernement', false, 4);

  -- M21
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un pentest en boîte grise (grey box) ?', 'En pentest boîte grise, le testeur a des informations partielles sur le système (par exemple des identifiants utilisateur), simulant un attaquant interne ou un utilisateur malveillant.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un test avec des informations partielles sur le système', true, 1),
    (q_id, 'Un test sans aucune information', false, 2),
    (q_id, 'Un test avec toutes les informations', false, 3),
    (q_id, 'Un test réalisé en zone grise légale', false, 4);

  -- M22
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que Metasploit ?', 'Metasploit est un framework (outil) de pentest très populaire. Il contient une base de données d''exploits et de payloads pour tester les vulnérabilités des systèmes.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un framework de pentest avec des exploits intégrés', true, 1),
    (q_id, 'Un système d''exploitation', false, 2),
    (q_id, 'Un serveur web', false, 3),
    (q_id, 'Un logiciel de bureautique', false, 4);

  -- M23
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un payload en cybersécurité ?', 'Un payload est le code malveillant qui s''exécute sur le système de la victime après l''exploitation d''une faille. Il peut ouvrir un accès distant, voler des données, etc.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Le code qui s''exécute après l''exploitation d''une faille', true, 1),
    (q_id, 'Le poids d''un fichier', false, 2),
    (q_id, 'Un type de réseau', false, 3),
    (q_id, 'Un format de données', false, 4);

  -- M24
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que le Google Dorking ?', 'Le Google Dorking utilise des opérateurs de recherche avancés dans Google pour trouver des informations sensibles exposées accidentellement : fichiers, pages d''admin, mots de passe.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Utiliser des recherches Google avancées pour trouver des infos exposées', true, 1),
    (q_id, 'Pirater le moteur de recherche Google', false, 2),
    (q_id, 'Créer un faux Google', false, 3),
    (q_id, 'Bloquer les résultats Google', false, 4);

  -- M25
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Pourquoi documente-t-on chaque étape d''un pentest ?', 'Documenter permet de prouver ce qui a été trouvé, de reproduire les résultats, et de fournir au client un rapport clair avec des recommandations pour corriger les failles.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Pour prouver les résultats et aider le client à corriger les failles', true, 1),
    (q_id, 'Ce n''est pas nécessaire', false, 2),
    (q_id, 'Pour impressionner le client', false, 3),
    (q_id, 'Uniquement pour des raisons juridiques', false, 4);

  -- M26
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un bug bounty ?', 'Un bug bounty est un programme où une entreprise offre des récompenses financières aux hackers éthiques qui trouvent et signalent des vulnérabilités dans ses systèmes.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un programme de récompenses pour la découverte de failles', true, 1),
    (q_id, 'Un virus informatique', false, 2),
    (q_id, 'Un concours de programmation', false, 3),
    (q_id, 'Une assurance cybersécurité', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 4 : IA et Éthique en cybersécurité (16 questions)
  -- ═══════════════════════════════════════════════════════

  -- IA1
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Que signifie "IA" (Intelligence Artificielle) ?', 'L''intelligence artificielle désigne des programmes informatiques capables de réaliser des tâches qui nécessitent normalement l''intelligence humaine : reconnaissance d''images, traduction, décision.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Des programmes capables de réaliser des tâches nécessitant l''intelligence humaine', true, 1),
    (q_id, 'Des robots physiques uniquement', false, 2),
    (q_id, 'Internet Avancé', false, 3),
    (q_id, 'Un type de réseau informatique', false, 4);

  -- IA2
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Comment l''IA peut-elle aider en cybersécurité ?', 'L''IA peut détecter des comportements anormaux sur un réseau, identifier des malwares inconnus, analyser des logs en masse et réagir plus vite que les humains face aux menaces.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Détecter des menaces et comportements anormaux automatiquement', true, 1),
    (q_id, 'Remplacer complètement les experts en sécurité', false, 2),
    (q_id, 'Créer des virus plus puissants', false, 3),
    (q_id, 'L''IA n''est pas utile en cybersécurité', false, 4);

  -- IA3
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que l''éthique en cybersécurité ?', 'L''éthique en cybersécurité concerne les règles morales qui guident le comportement des professionnels : respecter la loi, protéger la vie privée, ne pas abuser de ses accès.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Les règles morales qui guident le comportement des professionnels de la sécurité', true, 1),
    (q_id, 'Les lois sur Internet uniquement', false, 2),
    (q_id, 'Un outil de pentest', false, 3),
    (q_id, 'Un type de chiffrement', false, 4);

  -- IA4
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Pourquoi est-il important de respecter la vie privée en cybersécurité ?', 'Un professionnel de la cybersécurité a souvent accès à des données sensibles. Abuser de cet accès viole la confiance, la loi et peut causer de graves préjudices aux personnes.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Car on a accès à des données sensibles et il faut respecter la confiance', true, 1),
    (q_id, 'Ce n''est pas important si on est autorisé', false, 2),
    (q_id, 'Uniquement pour éviter des amendes', false, 3),
    (q_id, 'La vie privée n''existe pas sur Internet', false, 4);

  -- IA5
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce qu''un deepfake ?', 'Un deepfake est un contenu (vidéo, audio, image) généré ou modifié par l''IA pour faire croire qu''une personne dit ou fait quelque chose qu''elle n''a jamais fait.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un faux contenu réaliste généré par l''IA', true, 1),
    (q_id, 'Un réseau profond (deep web)', false, 2),
    (q_id, 'Un type de chiffrement avancé', false, 3),
    (q_id, 'Un antivirus basé sur l''IA', false, 4);

  -- IA6
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Les pirates peuvent-ils utiliser l''IA pour attaquer ?', 'Oui, l''IA peut être utilisée pour automatiser des attaques, créer des phishing plus convaincants, générer des deepfakes ou trouver des vulnérabilités plus rapidement.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Oui, pour créer des attaques plus sophistiquées et automatisées', true, 1),
    (q_id, 'Non, l''IA ne peut pas être utilisée pour attaquer', false, 2),
    (q_id, 'Uniquement les gouvernements peuvent utiliser l''IA', false, 3),
    (q_id, 'L''IA empêche automatiquement les attaques', false, 4);

  -- IA7
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que le RGPD ?', 'Le RGPD (Règlement Général sur la Protection des Données) est une loi européenne qui protège les données personnelles des citoyens et impose des obligations aux entreprises.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une loi européenne sur la protection des données personnelles', true, 1),
    (q_id, 'Un protocole réseau', false, 2),
    (q_id, 'Un outil de piratage', false, 3),
    (q_id, 'Un type de chiffrement', false, 4);

  -- IA8
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que le dark web ?', 'Le dark web est une partie cachée d''Internet accessible uniquement via des logiciels spéciaux comme Tor. Il contient des contenus légaux et illégaux.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une partie cachée d''Internet accessible via des outils spéciaux', true, 1),
    (q_id, 'Un site web avec un thème sombre', false, 2),
    (q_id, 'Internet quand il y a une panne', false, 3),
    (q_id, 'Un réseau réservé aux hackers', false, 4);

  -- IA9
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que la divulgation responsable (responsible disclosure) ?', 'La divulgation responsable consiste à signaler une faille de sécurité au propriétaire du système et à lui laisser le temps de la corriger avant de la rendre publique.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Signaler une faille au propriétaire et attendre sa correction avant publication', true, 1),
    (q_id, 'Publier la faille immédiatement sur les réseaux sociaux', false, 2),
    (q_id, 'Vendre la faille au plus offrant', false, 3),
    (q_id, 'Ignorer la faille', false, 4);

  -- IA10
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que le machine learning ?', 'Le machine learning (apprentissage automatique) est une branche de l''IA où les programmes apprennent à partir de données, sans être explicitement programmés pour chaque tâche.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Des programmes qui apprennent à partir de données', true, 1),
    (q_id, 'Des machines qui apprennent à marcher', false, 2),
    (q_id, 'Un cours en ligne sur les machines', false, 3),
    (q_id, 'La réparation automatique d''ordinateurs', false, 4);

  -- IA11
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Pourquoi un pentester doit-il agir dans les limites du scope ?', 'Dépasser le scope est illégal et non éthique. Cela pourrait endommager des systèmes non autorisés et violer la confiance du client.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Dépasser le scope est illégal et peut endommager des systèmes non autorisés', true, 1),
    (q_id, 'Le scope n''est qu''une suggestion', false, 2),
    (q_id, 'On peut dépasser le scope si on trouve quelque chose d''intéressant', false, 3),
    (q_id, 'Le scope ne concerne que les débutants', false, 4);

  -- IA12
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que la confidentialité en cybersécurité ?', 'La confidentialité garantit que les informations ne sont accessibles qu''aux personnes autorisées. C''est un des trois piliers de la sécurité avec l''intégrité et la disponibilité (CIA).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Garantir que les informations ne sont accessibles qu''aux personnes autorisées', true, 1),
    (q_id, 'Garder un secret personnel', false, 2),
    (q_id, 'Cacher l''existence d''un réseau', false, 3),
    (q_id, 'Supprimer toutes les données après utilisation', false, 4);

  -- IA13
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Que signifie le sigle "CIA" en cybersécurité ?', 'CIA signifie Confidentiality, Integrity, Availability (Confidentialité, Intégrité, Disponibilité). Ce sont les trois piliers fondamentaux de la sécurité de l''information.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Confidentialité, Intégrité, Disponibilité', true, 1),
    (q_id, 'Central Intelligence Agency uniquement', false, 2),
    (q_id, 'Computer Internet Access', false, 3),
    (q_id, 'Certified Information Analyst', false, 4);

  -- IA14
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Comment un chatbot IA peut-il être utilisé dans le phishing ?', 'Un attaquant peut utiliser un chatbot IA pour créer des e-mails de phishing personnalisés et convaincants, rédigés sans fautes et adaptés à chaque victime.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Pour créer des e-mails de phishing personnalisés et convaincants', true, 1),
    (q_id, 'Les chatbots ne peuvent pas être utilisés pour le phishing', false, 2),
    (q_id, 'Pour bloquer automatiquement les tentatives de phishing', false, 3),
    (q_id, 'Pour envoyer des spams publicitaires', false, 4);

  -- IA15
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que l''intégrité des données ?', 'L''intégrité garantit que les données n''ont pas été modifiées ou altérées de manière non autorisée. On vérifie l''intégrité avec des hash (empreintes numériques).', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'La garantie que les données n''ont pas été modifiées sans autorisation', true, 1),
    (q_id, 'La vitesse de transfert des données', false, 2),
    (q_id, 'La quantité de données stockées', false, 3),
    (q_id, 'Le nombre de copies de sauvegarde', false, 4);

  -- IA16
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que la disponibilité en cybersécurité ?', 'La disponibilité garantit que les systèmes et données sont accessibles quand les utilisateurs autorisés en ont besoin. Une attaque DDoS est un exemple d''atteinte à la disponibilité.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Garantir que les systèmes sont accessibles quand on en a besoin', true, 1),
    (q_id, 'Avoir Internet 24h/24', false, 2),
    (q_id, 'Rendre toutes les données publiques', false, 3),
    (q_id, 'Avoir un ordinateur portable', false, 4);

END $$;
