-- ═══════════════════════════════════════════════════════════
--  ICS Eval — Banque de 104 questions
--  Répartition : Réseaux 26, Vulnérabilités 36, Méthodologie 26, IA/Éthique 16
-- ═══════════════════════════════════════════════════════════

-- Helper: on récupère les IDs des catégories
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
    (gen_random_uuid(), cat_reseaux, 'Quel protocole de la couche transport assure une livraison fiable et ordonnée des données ?', 'TCP (Transmission Control Protocol) utilise un mécanisme de connexion en trois étapes (SYN, SYN-ACK, ACK) et des accusés de réception pour garantir la livraison fiable et ordonnée des segments.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'TCP', true, 1),
    (q_id, 'UDP', false, 2),
    (q_id, 'ICMP', false, 3),
    (q_id, 'ARP', false, 4);

  -- R2
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel est le port par défaut du protocole HTTPS ?', 'HTTPS utilise le port 443 par défaut. HTTP utilise le port 80, FTP le port 21 et SSH le port 22.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, '443', true, 1),
    (q_id, '80', false, 2),
    (q_id, '8080', false, 3),
    (q_id, '8443', false, 4);

  -- R3
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle méthode HTTP est utilisée pour soumettre des données dans un formulaire web de manière sécurisée ?', 'POST envoie les données dans le corps de la requête, contrairement à GET qui les place dans l''URL et les expose dans l''historique, les logs serveur et la barre d''adresse.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'POST', true, 1),
    (q_id, 'GET', false, 2),
    (q_id, 'HEAD', false, 3),
    (q_id, 'OPTIONS', false, 4);

  -- R4
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Que signifie le code de statut HTTP 403 ?', '403 Forbidden indique que le serveur a compris la requête mais refuse de l''autoriser. Contrairement à 401 (non authentifié), l''authentification ne changera rien.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Accès interdit', true, 1),
    (q_id, 'Page non trouvée', false, 2),
    (q_id, 'Erreur serveur interne', false, 3),
    (q_id, 'Redirection permanente', false, 4);

  -- R5
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel en-tête HTTP est utilisé pour indiquer le type de contenu envoyé dans la réponse ?', 'L''en-tête Content-Type informe le client du type MIME du contenu de la réponse (ex : text/html, application/json), ce qui détermine comment le navigateur interprète les données.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Content-Type', true, 1),
    (q_id, 'Accept', false, 2),
    (q_id, 'Authorization', false, 3),
    (q_id, 'Cache-Control', false, 4);

  -- R6
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel protocole est utilisé pour résoudre un nom de domaine en adresse IP ?', 'Le DNS (Domain Name System) traduit les noms de domaine lisibles par l''humain en adresses IP utilisables par les machines, fonctionnant principalement sur le port 53.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'DNS', true, 1),
    (q_id, 'DHCP', false, 2),
    (q_id, 'ARP', false, 3),
    (q_id, 'NTP', false, 4);

  -- R7
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Dans le modèle OSI, à quelle couche appartient le protocole HTTP ?', 'HTTP est un protocole de la couche Application (couche 7) du modèle OSI. Il s''appuie sur TCP (couche 4) pour le transport des données.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Couche 7 – Application', true, 1),
    (q_id, 'Couche 4 – Transport', false, 2),
    (q_id, 'Couche 3 – Réseau', false, 3),
    (q_id, 'Couche 6 – Présentation', false, 4);

  -- R8
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel en-tête HTTP permet de mettre en cache une réponse côté client pendant une durée définie ?', 'Cache-Control avec la directive max-age permet de définir la durée de mise en cache côté client. Expires est plus ancien et moins flexible.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Cache-Control', true, 1),
    (q_id, 'Pragma', false, 2),
    (q_id, 'ETag', false, 3),
    (q_id, 'X-Cache', false, 4);

  -- R9
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle est la différence principale entre HTTP/1.1 et HTTP/2 ?', 'HTTP/2 introduit le multiplexage, permettant d''envoyer plusieurs requêtes et réponses simultanément sur une seule connexion TCP, éliminant le blocage head-of-line de HTTP/1.1.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'HTTP/2 supporte le multiplexage de requêtes sur une connexion', true, 1),
    (q_id, 'HTTP/2 utilise UDP au lieu de TCP', false, 2),
    (q_id, 'HTTP/2 supprime les en-têtes de requête', false, 3),
    (q_id, 'HTTP/2 ne supporte pas le chiffrement TLS', false, 4);

  -- R10
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel est le rôle d''un certificat TLS dans une connexion HTTPS ?', 'Un certificat TLS authentifie l''identité du serveur auprès du client et permet l''établissement d''un canal chiffré via un échange de clés, protégeant les données en transit.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Authentifier le serveur et permettre le chiffrement des données', true, 1),
    (q_id, 'Accélérer le chargement des pages web', false, 2),
    (q_id, 'Bloquer les requêtes malveillantes', false, 3),
    (q_id, 'Compresser les données transmises', false, 4);

  -- R11
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''un cookie de session HTTP ?', 'Un cookie de session est un petit fichier stocké par le navigateur qui contient un identifiant de session. Le serveur l''utilise pour reconnaître l''utilisateur entre les requêtes, car HTTP est sans état.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un identifiant temporaire stocké par le navigateur pour maintenir l''état de connexion', true, 1),
    (q_id, 'Un fichier exécutable téléchargé par le serveur', false, 2),
    (q_id, 'Un en-tête HTTP pour la compression des données', false, 3),
    (q_id, 'Un certificat de sécurité pour le chiffrement', false, 4);

  -- R12
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel outil en ligne de commande est couramment utilisé pour effectuer des requêtes HTTP ?', 'curl (client URL) est un outil en ligne de commande pour transférer des données avec des URL. Il supporte HTTP, HTTPS, FTP et de nombreux autres protocoles.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'curl', true, 1),
    (q_id, 'ping', false, 2),
    (q_id, 'traceroute', false, 3),
    (q_id, 'netstat', false, 4);

  -- R13
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle adresse IP est réservée pour désigner la machine locale (loopback) ?', 'L''adresse 127.0.0.1 est l''adresse de bouclage (loopback) IPv4. Toute donnée envoyée à cette adresse ne quitte jamais la machine et revient à l''émetteur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, '127.0.0.1', true, 1),
    (q_id, '192.168.0.1', false, 2),
    (q_id, '10.0.0.1', false, 3),
    (q_id, '0.0.0.0', false, 4);

  -- R14
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel mécanisme CORS permet au navigateur de vérifier si une requête cross-origin est autorisée ?', 'La requête preflight est un OPTIONS envoyé par le navigateur avant une requête cross-origin « complexe » pour vérifier si le serveur autorise l''origine, les méthodes et les en-têtes demandés.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'La requête preflight (OPTIONS)', true, 1),
    (q_id, 'L''en-tête Referer', false, 2),
    (q_id, 'Le cookie de session', false, 3),
    (q_id, 'Le jeton CSRF', false, 4);

  -- R15
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel protocole sécurise la couche transport pour HTTPS ?', 'TLS (Transport Layer Security) est le protocole qui chiffre les communications entre le navigateur et le serveur. SSL est son prédécesseur obsolète.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'TLS', true, 1),
    (q_id, 'SSH', false, 2),
    (q_id, 'IPSec', false, 3),
    (q_id, 'WPA2', false, 4);

  -- R16
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle commande permet d''afficher la table de routage d''un système Linux ?', 'La commande « ip route » (ou son ancêtre « route -n ») affiche la table de routage du noyau Linux, montrant les passerelles et les interfaces réseau utilisées.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'ip route', true, 1),
    (q_id, 'ifconfig', false, 2),
    (q_id, 'netstat -a', false, 3),
    (q_id, 'arp -a', false, 4);

  -- R17
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel en-tête HTTP est utilisé pour transmettre les informations d''authentification ?', 'L''en-tête Authorization transporte les identifiants d''authentification (token Bearer, Basic Auth, etc.) dans chaque requête nécessitant une authentification.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Authorization', true, 1),
    (q_id, 'Cookie', false, 2),
    (q_id, 'X-Auth-Token', false, 3),
    (q_id, 'WWW-Authenticate', false, 4);

  -- R18
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce que le Same-Origin Policy (SOP) dans un navigateur ?', 'La SOP est un mécanisme de sécurité du navigateur qui empêche un script d''une origine (schéma + domaine + port) d''accéder aux ressources d''une autre origine, limitant ainsi les attaques cross-site.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une politique de sécurité qui restreint les interactions entre origines différentes', true, 1),
    (q_id, 'Un pare-feu intégré au navigateur', false, 2),
    (q_id, 'Un mécanisme de cache des ressources web', false, 3),
    (q_id, 'Un protocole de chiffrement des cookies', false, 4);

  -- R19
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel code de statut HTTP indique qu''une ressource a été déplacée de façon permanente ?', 'Le code 301 (Moved Permanently) indique que la ressource a été déplacée définitivement vers une nouvelle URL. Le navigateur met à jour ses signets et les moteurs de recherche transfèrent le référencement.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, '301', true, 1),
    (q_id, '302', false, 2),
    (q_id, '404', false, 3),
    (q_id, '200', false, 4);

  -- R20
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel est le rôle d''un proxy inverse (reverse proxy) ?', 'Un reverse proxy se place devant un ou plusieurs serveurs web pour distribuer le trafic, gérer le TLS, mettre en cache les réponses et masquer l''architecture interne.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Recevoir les requêtes des clients et les transmettre aux serveurs internes', true, 1),
    (q_id, 'Masquer l''adresse IP du client', false, 2),
    (q_id, 'Chiffrer les fichiers stockés sur le serveur', false, 3),
    (q_id, 'Bloquer tous les ports sauf le port 80', false, 4);

  -- R21
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle méthode HTTP est idempotente et utilisée pour supprimer une ressource ?', 'DELETE est la méthode HTTP standard pour demander la suppression d''une ressource. Elle est idempotente : appeler DELETE plusieurs fois produit le même résultat.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'DELETE', true, 1),
    (q_id, 'POST', false, 2),
    (q_id, 'PATCH', false, 3),
    (q_id, 'PUT', false, 4);

  -- R22
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Qu''est-ce qu''une requête WebSocket comparée à HTTP ?', 'WebSocket établit une connexion bidirectionnelle persistante entre le client et le serveur, permettant l''envoi de messages dans les deux sens sans nouvelle requête, contrairement au modèle requête-réponse de HTTP.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un protocole bidirectionnel persistant au-dessus de TCP', true, 1),
    (q_id, 'Une version plus rapide de HTTP/2', false, 2),
    (q_id, 'Un protocole utilisé uniquement pour le streaming vidéo', false, 3),
    (q_id, 'Un mécanisme de mise en cache côté serveur', false, 4);

  -- R23
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel outil permet de capturer et d''analyser le trafic réseau en temps réel ?', 'Wireshark est un analyseur de protocoles réseau open source qui capture et affiche les paquets en temps réel, permettant d''inspecter les échanges à tous les niveaux du modèle OSI.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Wireshark', true, 1),
    (q_id, 'Nmap', false, 2),
    (q_id, 'Metasploit', false, 3),
    (q_id, 'John the Ripper', false, 4);

  -- R24
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quelle est la plage d''adresses IP privées de classe C ?', 'La plage 192.168.0.0 à 192.168.255.255 (192.168.0.0/16) est réservée aux réseaux privés de classe C, couramment utilisée dans les réseaux locaux domestiques et d''entreprise.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, '192.168.0.0 – 192.168.255.255', true, 1),
    (q_id, '10.0.0.0 – 10.255.255.255', false, 2),
    (q_id, '172.16.0.0 – 172.31.255.255', false, 3),
    (q_id, '169.254.0.0 – 169.254.255.255', false, 4);

  -- R25
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel en-tête HTTP permet d''empêcher le navigateur d''interpréter le contenu différemment du Content-Type déclaré ?', 'X-Content-Type-Options: nosniff empêche le navigateur de faire du MIME sniffing, c''est-à-dire de deviner le type de contenu au lieu de respecter le Content-Type déclaré, ce qui peut prévenir certaines attaques XSS.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'X-Content-Type-Options', true, 1),
    (q_id, 'Strict-Transport-Security', false, 2),
    (q_id, 'Content-Security-Policy', false, 3),
    (q_id, 'X-Frame-Options', false, 4);

  -- R26
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_reseaux, 'Quel type d''enregistrement DNS associe un nom de domaine à une adresse IPv4 ?', 'L''enregistrement A (Address) mappe un nom de domaine vers une adresse IPv4. L''enregistrement AAAA est pour IPv6, CNAME est un alias, et MX désigne les serveurs de messagerie.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'A', true, 1),
    (q_id, 'CNAME', false, 2),
    (q_id, 'MX', false, 3),
    (q_id, 'TXT', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 2 : Vulnérabilités Web (36 questions)
  -- ═══════════════════════════════════════════════════════

  -- V1
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une injection SQL ?', 'L''injection SQL consiste à insérer du code SQL malveillant dans les entrées utilisateur d''une application web, exploitant un manque de validation pour manipuler la base de données sous-jacente.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''insertion de code SQL malveillant via les entrées utilisateur', true, 1),
    (q_id, 'Le vol de cookies de session', false, 2),
    (q_id, 'L''envoi de requêtes depuis un autre site', false, 3),
    (q_id, 'La modification des en-têtes HTTP', false, 4);

  -- V2
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quelle payload basique permet de tester une injection SQL dans un champ de connexion ?', 'La payload '' OR 1=1 -- transforme la requête SQL pour que la condition soit toujours vraie, contournant ainsi l''authentification. Le double tiret commente le reste de la requête.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, ''' OR 1=1 --', true, 1),
    (q_id, '<script>alert(1)</script>', false, 2),
    (q_id, '../../../etc/passwd', false, 3),
    (q_id, '{{7*7}}', false, 4);

  -- V3
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le Cross-Site Scripting (XSS) ?', 'Le XSS est une vulnérabilité qui permet à un attaquant d''injecter du code JavaScript malveillant dans une page web consultée par d''autres utilisateurs, compromettant leur session ou leurs données.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''injection de scripts malveillants dans des pages web consultées par d''autres', true, 1),
    (q_id, 'L''interception de paquets réseau', false, 2),
    (q_id, 'La modification du code source du serveur', false, 3),
    (q_id, 'L''accès non autorisé à la base de données', false, 4);

  -- V4
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quelle est la différence entre XSS stocké et XSS réfléchi ?', 'Le XSS stocké est enregistré en base de données et s''exécute à chaque affichage de la page. Le XSS réfléchi est transmis via l''URL ou un paramètre et s''exécute uniquement quand la victime clique sur un lien malveillant.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Le XSS stocké persiste en base de données, le réfléchi est transmis via les paramètres de requête', true, 1),
    (q_id, 'Le XSS stocké est plus facile à détecter', false, 2),
    (q_id, 'Le XSS réfléchi nécessite un accès au serveur', false, 3),
    (q_id, 'Il n''y a aucune différence technique', false, 4);

  -- V5
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque CSRF (Cross-Site Request Forgery) ?', 'Le CSRF force un utilisateur authentifié à exécuter involontairement une action sur un site en exploitant sa session active, via un lien ou un formulaire masqué sur un site malveillant.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Forcer un utilisateur authentifié à effectuer une action involontaire', true, 1),
    (q_id, 'Injecter du JavaScript dans une page web', false, 2),
    (q_id, 'Intercepter les communications chiffrées', false, 3),
    (q_id, 'Deviner le mot de passe d''un utilisateur par brute force', false, 4);

  -- V6
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quelle protection principale permet de contrer les attaques CSRF ?', 'Un jeton anti-CSRF est une valeur unique et imprévisible générée par le serveur, incluse dans chaque formulaire. Le serveur vérifie sa présence à chaque soumission, empêchant les requêtes falsifiées.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un jeton anti-CSRF (token unique par formulaire)', true, 1),
    (q_id, 'Le chiffrement des mots de passe en base', false, 2),
    (q_id, 'Un pare-feu applicatif (WAF)', false, 3),
    (q_id, 'La validation du User-Agent', false, 4);

  -- V7
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une IDOR (Insecure Direct Object Reference) ?', 'L''IDOR survient quand une application expose des identifiants d''objets internes (ex : /user/42) sans vérifier que l''utilisateur a le droit d''accéder à cette ressource, permettant à un attaquant de consulter ou modifier les données d''autres utilisateurs.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''accès à des ressources d''autres utilisateurs en modifiant un identifiant dans l''URL', true, 1),
    (q_id, 'L''injection de commandes système via l''URL', false, 2),
    (q_id, 'Le contournement du HTTPS', false, 3),
    (q_id, 'L''envoi de requêtes massives pour surcharger le serveur', false, 4);

  -- V8
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Comment prévenir les injections SQL de manière efficace ?', 'Les requêtes paramétrées (prepared statements) séparent le code SQL des données utilisateur, empêchant l''interprétation des entrées comme du code SQL. C''est la protection la plus efficace.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Utiliser des requêtes paramétrées (prepared statements)', true, 1),
    (q_id, 'Limiter la longueur des champs de formulaire', false, 2),
    (q_id, 'Masquer les messages d''erreur SQL', false, 3),
    (q_id, 'Utiliser uniquement la méthode POST', false, 4);

  -- V9
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le path traversal (traversée de répertoire) ?', 'Le path traversal exploite un manque de validation des chemins de fichier pour accéder à des fichiers en dehors du répertoire prévu, en utilisant des séquences comme ../ pour remonter dans l''arborescence.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''accès à des fichiers hors du répertoire prévu via des séquences ../', true, 1),
    (q_id, 'Le scan de tous les ports d''un serveur', false, 2),
    (q_id, 'La modification des permissions de fichiers', false, 3),
    (q_id, 'L''injection de chemins dans les requêtes DNS', false, 4);

  -- V10
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel en-tête HTTP aide à prévenir les attaques XSS en contrôlant les sources de contenu autorisées ?', 'Content-Security-Policy (CSP) permet de spécifier les sources autorisées de scripts, styles, images, etc. En restreignant les sources, il bloque l''exécution de scripts injectés par un attaquant.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Content-Security-Policy', true, 1),
    (q_id, 'X-Frame-Options', false, 2),
    (q_id, 'Referrer-Policy', false, 3),
    (q_id, 'Access-Control-Allow-Origin', false, 4);

  -- V11
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel attribut de cookie empêche son accès via JavaScript ?', 'L''attribut HttpOnly empêche les scripts côté client (JavaScript) d''accéder au cookie, ce qui protège contre le vol de cookies via des attaques XSS.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'HttpOnly', true, 1),
    (q_id, 'Secure', false, 2),
    (q_id, 'SameSite', false, 3),
    (q_id, 'Path', false, 4);

  -- V12
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque par injection de commande (command injection) ?', 'L''injection de commande exploite une application qui exécute des commandes système à partir d''entrées utilisateur non validées, permettant à l''attaquant d''exécuter des commandes arbitraires sur le serveur.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''exécution de commandes système via des entrées utilisateur non filtrées', true, 1),
    (q_id, 'L''envoi de commandes SQL malveillantes', false, 2),
    (q_id, 'La prise de contrôle d''un navigateur à distance', false, 3),
    (q_id, 'L''injection de scripts dans un email', false, 4);

  -- V13
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le SSRF (Server-Side Request Forgery) ?', 'Le SSRF amène le serveur à effectuer des requêtes vers des ressources internes ou externes choisies par l''attaquant, pouvant exposer des services internes normalement inaccessibles depuis l''extérieur.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Forcer le serveur à effectuer des requêtes vers des ressources choisies par l''attaquant', true, 1),
    (q_id, 'Intercepter les requêtes entre deux serveurs', false, 2),
    (q_id, 'Usurper l''identité d''un serveur DNS', false, 3),
    (q_id, 'Modifier les réponses d''un serveur proxy', false, 4);

  -- V14
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel type de faille permet d''uploader un fichier malveillant sur un serveur ?', 'L''upload non restreint permet de téléverser un fichier exécutable (ex : un webshell PHP) en contournant les validations côté client et en exploitant l''absence de contrôle du type de fichier côté serveur.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Unrestricted File Upload', true, 1),
    (q_id, 'Path Traversal', false, 2),
    (q_id, 'Open Redirect', false, 3),
    (q_id, 'Broken Authentication', false, 4);

  -- V15
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''un Open Redirect ?', 'Un Open Redirect est une vulnérabilité qui permet de rediriger un utilisateur vers un site arbitraire via un paramètre d''URL, exploitant la confiance envers le domaine légitime pour du phishing.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une redirection vers un site externe contrôlé par l''attaquant via un paramètre d''URL', true, 1),
    (q_id, 'Un port ouvert sur un serveur mal configuré', false, 2),
    (q_id, 'Une session qui reste ouverte indéfiniment', false, 3),
    (q_id, 'Un formulaire qui accepte tous les types de fichiers', false, 4);

  -- V16
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel est le risque principal d''un stockage de mot de passe en texte clair ?', 'Si un attaquant accède à la base de données, il obtient directement tous les mots de passe. Le hachage avec sel (bcrypt, Argon2) rend les mots de passe inutilisables même en cas de fuite.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'En cas de fuite de la base, tous les mots de passe sont immédiatement compromis', true, 1),
    (q_id, 'Les mots de passe prennent trop de place en base', false, 2),
    (q_id, 'L''application sera plus lente', false, 3),
    (q_id, 'Les utilisateurs ne pourront pas changer leur mot de passe', false, 4);

  -- V17
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le clickjacking ?', 'Le clickjacking superpose une page invisible (iframe) au-dessus d''une page visible, amenant l''utilisateur à cliquer sur des éléments cachés, comme un bouton de transfert bancaire.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Piéger l''utilisateur en masquant un élément cliquable sous un contenu visible', true, 1),
    (q_id, 'Enregistrer les frappes clavier de l''utilisateur', false, 2),
    (q_id, 'Intercepter les clics pour les rediriger vers un autre serveur', false, 3),
    (q_id, 'Simuler des clics automatiques via un bot', false, 4);

  -- V18
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quelle vulnérabilité est exploitée quand l''application affiche des messages d''erreur détaillés contenant des informations sensibles ?', 'La divulgation d''informations via les messages d''erreur peut révéler la structure de la base, les chemins de fichiers, les versions des logiciels, facilitant l''exploitation d''autres vulnérabilités.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Information Disclosure (divulgation d''informations)', true, 1),
    (q_id, 'Buffer Overflow', false, 2),
    (q_id, 'Race Condition', false, 3),
    (q_id, 'Broken Access Control', false, 4);

  -- V19
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel type de XSS s''exécute uniquement côté client, sans que le serveur ne traite la payload ?', 'Le XSS basé sur le DOM (DOM-based XSS) manipule le DOM via JavaScript côté client sans que la payload ne soit envoyée au serveur, la rendant invisible aux protections côté serveur.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'XSS basé sur le DOM (DOM-based)', true, 1),
    (q_id, 'XSS stocké', false, 2),
    (q_id, 'XSS réfléchi', false, 3),
    (q_id, 'XSS universel', false, 4);

  -- V20
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une injection SQL en aveugle (blind SQL injection) ?', 'En injection SQL aveugle, l''attaquant n''obtient pas directement les données dans la réponse mais déduit les informations en observant les différences de comportement (temps de réponse, messages d''erreur) de l''application.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une injection où les résultats sont déduits par le comportement de l''application', true, 1),
    (q_id, 'Une injection qui fonctionne sans connexion internet', false, 2),
    (q_id, 'Une injection qui cible uniquement les utilisateurs non authentifiés', false, 3),
    (q_id, 'Une injection qui se déclenche après un délai programmé', false, 4);

  -- V21
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel attribut de cookie limite l''envoi du cookie aux requêtes provenant du même site ?', 'L''attribut SameSite restreint l''envoi du cookie aux requêtes provenant du même site. La valeur « Strict » bloque tous les envois cross-site, « Lax » les autorise uniquement pour les navigations de premier niveau.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'SameSite', true, 1),
    (q_id, 'HttpOnly', false, 2),
    (q_id, 'Secure', false, 3),
    (q_id, 'Domain', false, 4);

  -- V22
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel est le risque d''utiliser eval() avec des données utilisateur en JavaScript ?', 'eval() exécute une chaîne de caractères comme du code JavaScript. Si elle contient des données utilisateur non validées, un attaquant peut y injecter du code arbitraire qui sera exécuté dans le contexte de la page.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Exécution de code arbitraire injecté par l''attaquant', true, 1),
    (q_id, 'Ralentissement des performances du navigateur', false, 2),
    (q_id, 'Corruption de la base de données', false, 3),
    (q_id, 'Blocage du moteur de rendu CSS', false, 4);

  -- V23
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que la désérialisation non sécurisée ?', 'La désérialisation non sécurisée transforme des données sérialisées non fiables en objets. Un attaquant peut manipuler ces données pour exécuter du code arbitraire, modifier la logique applicative ou provoquer un déni de service.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'La transformation de données malveillantes en objets pouvant exécuter du code', true, 1),
    (q_id, 'Le chiffrement incorrect des données en transit', false, 2),
    (q_id, 'La suppression accidentelle de données en base', false, 3),
    (q_id, 'Le stockage de données dans un format incompatible', false, 4);

  -- V24
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel est le risque d''un JWT (JSON Web Token) signé avec un algorithme faible comme « none » ?', 'Si le serveur accepte l''algorithme « none », un attaquant peut forger un JWT valide sans signature, modifiant les claims (rôle admin, identité) et contournant l''authentification.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un attaquant peut forger un token sans signature et usurper une identité', true, 1),
    (q_id, 'Le token expirera plus rapidement', false, 2),
    (q_id, 'Les données du token ne seront pas chiffrées', false, 3),
    (q_id, 'Le serveur refusera automatiquement le token', false, 4);

  -- V25
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le Broken Access Control selon l''OWASP Top 10 ?', 'Le Broken Access Control regroupe les failles où les restrictions d''accès ne sont pas correctement appliquées, permettant à des utilisateurs d''effectuer des actions au-delà de leurs permissions (IDOR, élévation de privilèges, etc.).', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Les contrôles d''accès ne sont pas correctement appliqués, permettant des actions non autorisées', true, 1),
    (q_id, 'Les mots de passe ne sont pas assez complexes', false, 2),
    (q_id, 'Le serveur ne chiffre pas les communications', false, 3),
    (q_id, 'Les logs ne sont pas correctement configurés', false, 4);

  -- V26
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel est le rôle de l''en-tête X-Frame-Options ?', 'X-Frame-Options empêche une page d''être chargée dans un iframe, une frame ou un object, protégeant ainsi contre le clickjacking. Les valeurs possibles sont DENY et SAMEORIGIN.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Empêcher le chargement de la page dans un iframe pour contrer le clickjacking', true, 1),
    (q_id, 'Définir les origines autorisées pour les requêtes CORS', false, 2),
    (q_id, 'Activer le mode strict de HTTPS', false, 3),
    (q_id, 'Limiter le nombre de requêtes par seconde', false, 4);

  -- V27
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce qu''une attaque de type Mass Assignment ?', 'Le Mass Assignment survient quand une application accepte tous les champs d''une requête pour mettre à jour un objet, permettant à un attaquant de modifier des champs protégés (rôle, statut) en les ajoutant à la requête.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Modifier des champs non prévus en injectant des paramètres supplémentaires dans la requête', true, 1),
    (q_id, 'Envoyer massivement des requêtes pour saturer le serveur', false, 2),
    (q_id, 'Assigner de multiples rôles à un seul utilisateur', false, 3),
    (q_id, 'Insérer des valeurs en masse dans la base de données', false, 4);

  -- V28
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel est le principal danger de l''inclusion de fichier distant (Remote File Inclusion — RFI) ?', 'Le RFI permet à un attaquant de faire inclure et exécuter un fichier hébergé sur un serveur distant, ce qui peut conduire à l''exécution de code arbitraire sur le serveur vulnérable.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''exécution de code distant sur le serveur vulnérable', true, 1),
    (q_id, 'La saturation de la bande passante', false, 2),
    (q_id, 'La modification des fichiers de configuration DNS', false, 3),
    (q_id, 'Le déchiffrement des communications TLS', false, 4);

  -- V29
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Comment l''attribut Secure d''un cookie protège-t-il les données ?', 'L''attribut Secure indique au navigateur de n''envoyer le cookie que sur des connexions HTTPS, empêchant sa transmission en clair sur HTTP et le protégeant contre l''interception.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Le cookie n''est envoyé que sur des connexions HTTPS', true, 1),
    (q_id, 'Le cookie est chiffré côté client', false, 2),
    (q_id, 'Le cookie ne peut pas être lu par JavaScript', false, 3),
    (q_id, 'Le cookie expire automatiquement après 30 minutes', false, 4);

  -- V30
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel type de vulnérabilité l''OWASP classe en première position dans son Top 10 2021 ?', 'Depuis 2021, le Broken Access Control occupe la première position du Top 10 OWASP, reflétant la prévalence des failles de contrôle d''accès dans les applications web modernes.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Broken Access Control', true, 1),
    (q_id, 'Injection', false, 2),
    (q_id, 'Cross-Site Scripting', false, 3),
    (q_id, 'Security Misconfiguration', false, 4);

  -- V31
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que l''injection de template côté serveur (SSTI) ?', 'La SSTI exploite les moteurs de templates (Jinja2, Twig, Freemarker…) quand des entrées utilisateur sont intégrées directement dans un template. L''attaquant peut exécuter du code serveur via des expressions comme {{7*7}}.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''injection de code dans un moteur de template côté serveur', true, 1),
    (q_id, 'La modification des templates HTML côté client', false, 2),
    (q_id, 'L''injection de CSS malveillant dans un fichier de style', false, 3),
    (q_id, 'Le remplacement des templates par des pages de phishing', false, 4);

  -- V32
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel mécanisme de sécurité HTTP force le navigateur à n''utiliser que des connexions HTTPS ?', 'HSTS (HTTP Strict Transport Security) indique au navigateur, via l''en-tête Strict-Transport-Security, de n''accéder au site qu''en HTTPS pendant une durée définie, bloquant le downgrade vers HTTP.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'HSTS (HTTP Strict Transport Security)', true, 1),
    (q_id, 'CSP (Content Security Policy)', false, 2),
    (q_id, 'CORS (Cross-Origin Resource Sharing)', false, 3),
    (q_id, 'OCSP (Online Certificate Status Protocol)', false, 4);

  -- V33
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que le session fixation ?', 'Le session fixation consiste à fixer un identifiant de session avant l''authentification de la victime. Une fois authentifiée, l''attaquant utilise le même identifiant pour accéder au compte de la victime.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Fixer un identifiant de session connu avant l''authentification de la victime', true, 1),
    (q_id, 'Bloquer la session d''un utilisateur par déni de service', false, 2),
    (q_id, 'Prolonger indéfiniment la durée d''une session', false, 3),
    (q_id, 'Dupliquer une session active vers un autre navigateur', false, 4);

  -- V34
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel est le danger principal d''une API REST sans limitation de débit (rate limiting) ?', 'Sans rate limiting, un attaquant peut envoyer un nombre illimité de requêtes, permettant le brute force de mots de passe, l''énumération de ressources, le scraping de données et le déni de service.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Permettre le brute force, l''énumération et le déni de service', true, 1),
    (q_id, 'Empêcher le mise en cache des réponses', false, 2),
    (q_id, 'Ralentir les utilisateurs légitimes', false, 3),
    (q_id, 'Augmenter la taille des logs serveur', false, 4);

  -- V35
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Qu''est-ce que l''injection NoSQL ?', 'L''injection NoSQL cible les bases de données non relationnelles (MongoDB, CouchDB) en injectant des opérateurs de requête (ex : $gt, $ne) dans les paramètres, contournant l''authentification ou exfiltrant des données.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'L''injection d''opérateurs de requête dans une base de données non relationnelle', true, 1),
    (q_id, 'L''injection SQL dans une base MongoDB', false, 2),
    (q_id, 'Le refus de se connecter à une base SQL', false, 3),
    (q_id, 'La suppression de la base de données sans commande SQL', false, 4);

  -- V36
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_vuln, 'Quel est le risque d''une mauvaise configuration des en-têtes CORS avec Access-Control-Allow-Origin: * ?', 'Autoriser toutes les origines (*) permet à n''importe quel site de faire des requêtes vers l''API depuis le navigateur d''un utilisateur, exposant potentiellement les données sensibles de l''utilisateur authentifié.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'N''importe quel site peut accéder aux données de l''API depuis le navigateur de l''utilisateur', true, 1),
    (q_id, 'Le serveur sera ralenti par trop de requêtes', false, 2),
    (q_id, 'Les cookies ne seront plus envoyés', false, 3),
    (q_id, 'Le certificat TLS sera invalidé', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 3 : Méthodologie et outils (26 questions)
  -- ═══════════════════════════════════════════════════════

  -- M1
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quelle est la première phase d''un test de pénétration selon la méthodologie standard ?', 'La reconnaissance (ou information gathering) est la première étape. Elle consiste à collecter un maximum d''informations sur la cible (domaines, IP, technologies, employés) avant toute tentative d''exploitation.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Reconnaissance et collecte d''informations', true, 1),
    (q_id, 'Exploitation des vulnérabilités', false, 2),
    (q_id, 'Rapport final', false, 3),
    (q_id, 'Maintien d''accès', false, 4);

  -- M2
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel outil est principalement utilisé pour intercepter et modifier les requêtes HTTP entre le navigateur et le serveur ?', 'Burp Suite est un proxy d''interception qui permet de capturer, analyser et modifier les requêtes et réponses HTTP en temps réel, outil incontournable du pentest web.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Burp Suite', true, 1),
    (q_id, 'Nmap', false, 2),
    (q_id, 'Wireshark', false, 3),
    (q_id, 'Metasploit', false, 4);

  -- M3
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'À quoi sert l''outil Nmap dans un test de pénétration ?', 'Nmap (Network Mapper) est un scanner de ports et de services réseau. Il identifie les ports ouverts, les services actifs et leurs versions, et peut détecter le système d''exploitation.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Scanner les ports ouverts, les services et le système d''exploitation d''une cible', true, 1),
    (q_id, 'Exploiter les vulnérabilités découvertes', false, 2),
    (q_id, 'Générer des rapports de pentest', false, 3),
    (q_id, 'Chiffrer les communications réseau', false, 4);

  -- M4
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quelle est la différence entre un test de pénétration en boîte noire et en boîte blanche ?', 'En boîte noire, le pentester n''a aucune information interne sur la cible (comme un attaquant externe). En boîte blanche, il a accès au code source, à l''architecture et aux identifiants, permettant un audit plus approfondi.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Boîte noire : aucune information interne ; boîte blanche : accès complet au code et à l''infrastructure', true, 1),
    (q_id, 'Boîte noire : test automatisé ; boîte blanche : test manuel', false, 2),
    (q_id, 'Boîte noire : réseau interne ; boîte blanche : réseau externe', false, 3),
    (q_id, 'Il n''y a pas de différence significative', false, 4);

  -- M5
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel module de Burp Suite est utilisé pour modifier automatiquement les requêtes et tester des payloads en série ?', 'L''Intruder de Burp Suite permet de configurer des attaques automatisées en remplaçant des paramètres par des listes de payloads, utile pour le fuzzing, le brute force et l''injection.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Intruder', true, 1),
    (q_id, 'Repeater', false, 2),
    (q_id, 'Decoder', false, 3),
    (q_id, 'Comparer', false, 4);

  -- M6
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que la reconnaissance passive ?', 'La reconnaissance passive consiste à collecter des informations sur la cible sans interagir directement avec ses systèmes (OSINT, archives web, DNS public, réseaux sociaux), ne laissant aucune trace.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Collecter des informations sans interagir directement avec les systèmes de la cible', true, 1),
    (q_id, 'Scanner les ports de la cible discrètement', false, 2),
    (q_id, 'Exploiter des vulnérabilités sans être détecté', false, 3),
    (q_id, 'Attendre que la cible expose des vulnérabilités', false, 4);

  -- M7
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel outil automatisé est spécialisé dans la détection et l''exploitation des injections SQL ?', 'sqlmap est un outil open source qui automatise la détection et l''exploitation des injections SQL. Il supporte divers SGBD, peut extraire des données, accéder au système de fichiers et exécuter des commandes.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'sqlmap', true, 1),
    (q_id, 'Nikto', false, 2),
    (q_id, 'Dirb', false, 3),
    (q_id, 'Hydra', false, 4);

  -- M8
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'À quoi sert l''outil Dirb (ou Dirbuster/Gobuster) ?', 'Ces outils de brute force de répertoires tentent de découvrir des fichiers et dossiers cachés sur un serveur web en testant une liste de noms courants, révélant des pages d''administration, des backups ou des fichiers sensibles.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Découvrir des fichiers et répertoires cachés sur un serveur web', true, 1),
    (q_id, 'Scanner les vulnérabilités réseau', false, 2),
    (q_id, 'Intercepter les requêtes HTTP', false, 3),
    (q_id, 'Cracker les mots de passe hashés', false, 4);

  -- M9
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel outil est utilisé pour effectuer des attaques par brute force sur des services d''authentification ?', 'Hydra est un outil de brute force en ligne qui supporte de nombreux protocoles (HTTP, FTP, SSH, SMTP, etc.) pour tester des combinaisons identifiant/mot de passe sur des services d''authentification.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Hydra', true, 1),
    (q_id, 'John the Ripper', false, 2),
    (q_id, 'Hashcat', false, 3),
    (q_id, 'Aircrack-ng', false, 4);

  -- M10
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que le module Repeater dans Burp Suite ?', 'Le Repeater permet de renvoyer manuellement une requête HTTP modifiée et d''observer la réponse, idéal pour affiner une payload d''exploitation ou tester des variantes sans relancer une attaque complète.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un outil pour renvoyer et modifier manuellement des requêtes HTTP', true, 1),
    (q_id, 'Un scanner automatique de vulnérabilités', false, 2),
    (q_id, 'Un outil de décodage d''encodages', false, 3),
    (q_id, 'Un module de génération de rapports', false, 4);

  -- M11
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que le CVSS (Common Vulnerability Scoring System) ?', 'Le CVSS est un système de notation standardisé qui évalue la gravité des vulnérabilités de sécurité sur une échelle de 0 à 10, en tenant compte de facteurs comme le vecteur d''attaque, la complexité et l''impact.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un système de notation standardisé de la gravité des vulnérabilités (0 à 10)', true, 1),
    (q_id, 'Un logiciel de scan de vulnérabilités', false, 2),
    (q_id, 'Un protocole de communication sécurisé', false, 3),
    (q_id, 'Une certification en cybersécurité', false, 4);

  -- M12
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel référentiel est largement utilisé pour classer les vulnérabilités web les plus critiques ?', 'L''OWASP Top 10 est un document de sensibilisation qui liste les dix risques de sécurité les plus critiques pour les applications web, mis à jour régulièrement pour refléter les menaces actuelles.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'OWASP Top 10', true, 1),
    (q_id, 'NIST Framework', false, 2),
    (q_id, 'ISO 27001', false, 3),
    (q_id, 'PCI DSS', false, 4);

  -- M13
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Que contient un rapport de test de pénétration professionnel ?', 'Un rapport complet inclut un résumé exécutif, la méthodologie utilisée, les vulnérabilités classées par criticité avec les preuves d''exploitation (PoC), et les recommandations de remédiation.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Résumé exécutif, méthodologie, vulnérabilités avec preuves et recommandations', true, 1),
    (q_id, 'Uniquement la liste des outils utilisés', false, 2),
    (q_id, 'Le code source complet de l''application', false, 3),
    (q_id, 'Les mots de passe découverts en texte clair', false, 4);

  -- M14
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quelle commande Nmap effectue un scan SYN furtif (stealth) ?', 'Le scan SYN (-sS) envoie un paquet SYN sans terminer le handshake TCP (pas d''ACK final), ce qui le rend moins susceptible d''être enregistré dans les logs par rapport à un scan connect (-sT).', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'nmap -sS', true, 1),
    (q_id, 'nmap -sT', false, 2),
    (q_id, 'nmap -sV', false, 3),
    (q_id, 'nmap -O', false, 4);

  -- M15
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que le fuzzing dans le contexte du test de sécurité ?', 'Le fuzzing consiste à envoyer des données aléatoires, invalides ou inattendues aux entrées d''une application pour provoquer des comportements imprévus, crashes ou révéler des vulnérabilités.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Envoyer des données aléatoires ou malformées pour découvrir des bugs et vulnérabilités', true, 1),
    (q_id, 'Rendre le code source illisible pour protéger la propriété intellectuelle', false, 2),
    (q_id, 'Brouiller les communications réseau pour éviter l''interception', false, 3),
    (q_id, 'Analyser la logique métier de l''application', false, 4);

  -- M16
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel outil est utilisé pour l''analyse statique des dépendances d''un projet afin de trouver des vulnérabilités connues ?', 'Des outils comme npm audit, Snyk ou OWASP Dependency-Check analysent les bibliothèques utilisées dans un projet et les comparent aux bases de données de vulnérabilités connues (CVE).', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'OWASP Dependency-Check ou npm audit', true, 1),
    (q_id, 'Burp Suite', false, 2),
    (q_id, 'Wireshark', false, 3),
    (q_id, 'Metasploit', false, 4);

  -- M17
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un CVE (Common Vulnerabilities and Exposures) ?', 'Un CVE est un identifiant unique (ex : CVE-2021-44228) attribué à une vulnérabilité de sécurité connue, permettant de la référencer de manière standardisée dans la communauté.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un identifiant unique pour une vulnérabilité de sécurité connue', true, 1),
    (q_id, 'Un type de virus informatique', false, 2),
    (q_id, 'Un certificat de validation de sécurité', false, 3),
    (q_id, 'Un outil de scan de vulnérabilités', false, 4);

  -- M18
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel est le rôle d''un WAF (Web Application Firewall) ?', 'Un WAF analyse et filtre le trafic HTTP entre les clients et l''application web, détectant et bloquant les attaques courantes (injection SQL, XSS, etc.) en temps réel selon des règles prédéfinies.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Filtrer le trafic HTTP pour bloquer les attaques web courantes', true, 1),
    (q_id, 'Chiffrer les données en base de données', false, 2),
    (q_id, 'Gérer les certificats TLS du serveur', false, 3),
    (q_id, 'Scanner les ports ouverts du réseau', false, 4);

  -- M19
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que la méthodologie PTES (Penetration Testing Execution Standard) ?', 'PTES est un standard qui définit 7 phases pour un test de pénétration : pré-engagement, collecte de renseignements, modélisation des menaces, analyse de vulnérabilités, exploitation, post-exploitation, rapport.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un standard en 7 phases couvrant le cycle complet d''un test de pénétration', true, 1),
    (q_id, 'Un outil de scan de vulnérabilités réseau', false, 2),
    (q_id, 'Un programme de certification pour les pentesters', false, 3),
    (q_id, 'Un protocole de chiffrement des rapports de pentest', false, 4);

  -- M20
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel est l''intérêt d''utiliser une wordlist personnalisée lors d''un test de pénétration ?', 'Une wordlist personnalisée contient des termes spécifiques à la cible (noms de produits, jargon interne, conventions de nommage) et augmente les chances de découvrir des chemins, identifiants ou mots de passe pertinents.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Cibler des termes spécifiques à l''environnement de la cible pour améliorer les résultats', true, 1),
    (q_id, 'Réduire le temps d''exécution du scan', false, 2),
    (q_id, 'Éviter les faux positifs', false, 3),
    (q_id, 'Se conformer aux exigences légales', false, 4);

  -- M21
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce que le Google Dorking dans le cadre de la reconnaissance ?', 'Le Google Dorking utilise des opérateurs de recherche avancés (site:, filetype:, intitle:, inurl:) pour trouver des informations sensibles indexées par Google : fichiers exposés, pages de login, répertoires ouverts.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Utiliser des opérateurs de recherche avancés Google pour trouver des informations sensibles', true, 1),
    (q_id, 'Pirater les serveurs de Google', false, 2),
    (q_id, 'Scanner les résultats de recherche pour des vulnérabilités', false, 3),
    (q_id, 'Modifier les résultats de recherche Google', false, 4);

  -- M22
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel outil de Kali Linux est spécialisé dans l''énumération des sous-domaines ?', 'Sublist3r est un outil Python qui énumère les sous-domaines d''un domaine cible en interrogeant plusieurs moteurs de recherche, des bases DNS et des sources OSINT.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Sublist3r', true, 1),
    (q_id, 'Aircrack-ng', false, 2),
    (q_id, 'BeEF', false, 3),
    (q_id, 'Maltego', false, 4);

  -- M23
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel est le rôle de Nikto dans un test de sécurité web ?', 'Nikto est un scanner de vulnérabilités web open source qui identifie les fichiers dangereux, les configurations incorrectes, les logiciels obsolètes et les problèmes de sécurité courants sur un serveur web.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Scanner un serveur web à la recherche de vulnérabilités et configurations dangereuses', true, 1),
    (q_id, 'Intercepter les requêtes HTTP', false, 2),
    (q_id, 'Effectuer des attaques de brute force', false, 3),
    (q_id, 'Analyser le trafic réseau', false, 4);

  -- M24
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un scope dans un engagement de test de pénétration ?', 'Le scope définit précisément ce qui est autorisé et interdit dans le test : les systèmes ciblés, les adresses IP, les types d''attaques permises, les plages horaires et les limitations, formalisé dans un contrat.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Le périmètre qui délimite les cibles, méthodes et restrictions autorisées', true, 1),
    (q_id, 'L''outil principal utilisé pendant le test', false, 2),
    (q_id, 'Le budget alloué au test', false, 3),
    (q_id, 'La durée maximale du test', false, 4);

  -- M25
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Quel est l''avantage d''un test de pénétration en boîte grise ?', 'Le test en boîte grise combine le réalisme de la boîte noire avec l''efficacité de la boîte blanche : le pentester dispose d''informations partielles (identifiants, documentation limitée), simulant un attaquant ayant un accès initial.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Combiner réalisme et efficacité avec un accès partiel aux informations de la cible', true, 1),
    (q_id, 'Tester uniquement les vulnérabilités réseau', false, 2),
    (q_id, 'Éliminer le besoin d''un contrat de périmètre', false, 3),
    (q_id, 'Automatiser entièrement le processus de test', false, 4);

  -- M26
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_meth, 'Qu''est-ce qu''un webshell ?', 'Un webshell est un script malveillant (PHP, ASP, JSP…) déposé sur un serveur web qui fournit une interface de commande à distance, permettant à l''attaquant d''exécuter des commandes système via le navigateur.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un script déposé sur un serveur web qui permet l''exécution de commandes à distance', true, 1),
    (q_id, 'Un navigateur web sécurisé pour les pentesters', false, 2),
    (q_id, 'Un terminal virtuel intégré au navigateur', false, 3),
    (q_id, 'Un pare-feu applicatif en ligne de commande', false, 4);

  -- ═══════════════════════════════════════════════════════
  --  DOMAINE 4 : IA, éthique et sécurité (16 questions)
  -- ═══════════════════════════════════════════════════════

  -- I1
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que le pentesting éthique (ethical hacking) ?', 'Le pentesting éthique consiste à tester la sécurité d''un système avec l''autorisation écrite du propriétaire, dans le but d''identifier et corriger les vulnérabilités avant qu''un attaquant malveillant ne les exploite.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Tester la sécurité d''un système avec l''autorisation du propriétaire pour en améliorer la protection', true, 1),
    (q_id, 'Pirater des systèmes pour en tirer un profit financier', false, 2),
    (q_id, 'Utiliser des outils automatisés sans comprendre leur fonctionnement', false, 3),
    (q_id, 'Publier les vulnérabilités découvertes sans prévenir le propriétaire', false, 4);

  -- I2
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Quel document juridique encadre un test de pénétration autorisé ?', 'L''autorisation de test (ou lettre de mission / convention de test) est un contrat signé entre le pentester et le client qui définit le périmètre, les conditions et dégage la responsabilité juridique du testeur.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Une autorisation de test signée (lettre de mission / convention)', true, 1),
    (q_id, 'Un simple accord verbal', false, 2),
    (q_id, 'La politique de confidentialité du site web', false, 3),
    (q_id, 'Les conditions générales d''utilisation', false, 4);

  -- I3
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Comment l''IA peut-elle être utilisée de manière bénéfique en cybersécurité ?', 'L''IA peut analyser de vastes volumes de données de logs, détecter des anomalies et des menaces en temps réel, automatiser la réponse aux incidents et identifier des patterns d''attaque invisibles pour un analyste humain.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Détecter des anomalies et des menaces en temps réel dans de grands volumes de données', true, 1),
    (q_id, 'Remplacer complètement les experts en sécurité', false, 2),
    (q_id, 'Créer des virus plus efficaces', false, 3),
    (q_id, 'Contourner automatiquement les pare-feux', false, 4);

  -- I4
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Quel est le risque principal de l''utilisation de l''IA générative pour créer des emails de phishing ?', 'L''IA générative peut produire des emails de phishing convaincants, personnalisés et sans fautes d''orthographe, rendant la détection par les utilisateurs beaucoup plus difficile que les tentatives artisanales.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Des emails de phishing plus convaincants, personnalisés et difficiles à détecter', true, 1),
    (q_id, 'Des emails envoyés plus rapidement', false, 2),
    (q_id, 'Des emails qui contournent les antivirus', false, 3),
    (q_id, 'Des emails qui se suppriment automatiquement', false, 4);

  -- I5
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que la divulgation responsable (responsible disclosure) ?', 'La divulgation responsable consiste à signaler une vulnérabilité découverte au propriétaire du système et à lui laisser un délai raisonnable pour corriger avant toute publication, protégeant ainsi les utilisateurs.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Signaler la vulnérabilité au propriétaire et attendre un correctif avant publication', true, 1),
    (q_id, 'Publier immédiatement la vulnérabilité sur les réseaux sociaux', false, 2),
    (q_id, 'Vendre la vulnérabilité au plus offrant', false, 3),
    (q_id, 'Garder la vulnérabilité secrète indéfiniment', false, 4);

  -- I6
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce qu''un programme de bug bounty ?', 'Un bug bounty est un programme officiel par lequel une organisation récompense financièrement les chercheurs en sécurité qui découvrent et signalent des vulnérabilités dans ses systèmes, dans un cadre défini.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Un programme de récompenses pour les chercheurs qui signalent des vulnérabilités', true, 1),
    (q_id, 'Un concours de programmation', false, 2),
    (q_id, 'Une assurance contre les cyberattaques', false, 3),
    (q_id, 'Un logiciel de détection de bugs', false, 4);

  -- I7
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Quel cadre réglementaire européen protège les données personnelles des citoyens ?', 'Le RGPD (Règlement Général sur la Protection des Données) impose des obligations strictes sur la collecte, le traitement et la conservation des données personnelles, avec des sanctions pouvant atteindre 4% du CA mondial.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Le RGPD (Règlement Général sur la Protection des Données)', true, 1),
    (q_id, 'La directive NIS2', false, 2),
    (q_id, 'Le standard PCI DSS', false, 3),
    (q_id, 'La norme ISO 27001', false, 4);

  -- I8
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce qu''une attaque adversariale contre un modèle d''IA ?', 'Une attaque adversariale consiste à modifier subtilement les données d''entrée d''un modèle d''IA pour le tromper et produire une sortie erronée, comme ajouter du bruit invisible à une image pour fausser sa classification.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Modifier subtilement les entrées pour tromper le modèle et obtenir une sortie erronée', true, 1),
    (q_id, 'Attaquer le serveur hébergeant le modèle d''IA', false, 2),
    (q_id, 'Voler le code source du modèle', false, 3),
    (q_id, 'Saturer le modèle avec trop de requêtes', false, 4);

  -- I9
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Pourquoi est-il important de ne pas accéder à un système informatique sans autorisation, même pour y chercher des failles ?', 'L''accès non autorisé à un système informatique est un délit pénal dans la plupart des pays (en France : article 323-1 du Code pénal), même sans intention malveillante et même si des vulnérabilités sont effectivement trouvées.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'C''est un délit pénal, même sans intention malveillante', true, 1),
    (q_id, 'Parce que le système pourrait être endommagé accidentellement', false, 2),
    (q_id, 'Parce que cela consomme trop de bande passante', false, 3),
    (q_id, 'Parce que les outils utilisés pourraient être défectueux', false, 4);

  -- I10
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que le prompt injection dans le contexte des LLM (Large Language Models) ?', 'Le prompt injection consiste à injecter des instructions malveillantes dans les entrées d''un LLM pour détourner son comportement prévu, contourner ses restrictions ou lui faire révéler des informations sensibles.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Injecter des instructions malveillantes pour détourner le comportement d''un LLM', true, 1),
    (q_id, 'Poser trop de questions à un chatbot', false, 2),
    (q_id, 'Modifier le code source d''un modèle d''IA', false, 3),
    (q_id, 'Entraîner un modèle avec des données corrompues', false, 4);

  -- I11
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Quel est le principe du « moindre privilège » en sécurité informatique ?', 'Le principe du moindre privilège stipule qu''un utilisateur ou un processus ne doit disposer que des droits strictement nécessaires à l''accomplissement de sa tâche, minimisant l''impact en cas de compromission.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'N''accorder que les droits strictement nécessaires à chaque utilisateur ou processus', true, 1),
    (q_id, 'Donner tous les droits aux administrateurs uniquement', false, 2),
    (q_id, 'Limiter le nombre d''utilisateurs sur un système', false, 3),
    (q_id, 'Désactiver tous les services non essentiels', false, 4);

  -- I12
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Comment l''IA peut-elle aider à automatiser la détection de vulnérabilités dans le code source ?', 'L''IA peut analyser le code source pour détecter des patterns vulnérables (injections, mauvaises pratiques cryptographiques) et des anomalies que les analyseurs statiques traditionnels basés sur des règles ne détectent pas.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'En détectant des patterns vulnérables et des anomalies dans le code via l''apprentissage automatique', true, 1),
    (q_id, 'En réécrivant automatiquement le code de manière sécurisée', false, 2),
    (q_id, 'En supprimant les lignes de code dangereuses', false, 3),
    (q_id, 'En empêchant les développeurs de commettre des erreurs', false, 4);

  -- I13
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que l''ingénierie sociale (social engineering) ?', 'L''ingénierie sociale manipule psychologiquement les personnes pour obtenir des informations confidentielles ou un accès non autorisé, exploitant la confiance, l''urgence ou l''autorité plutôt que des failles techniques.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Manipuler des personnes pour obtenir des informations ou un accès en exploitant des biais psychologiques', true, 1),
    (q_id, 'Utiliser des outils sociaux (réseaux) pour scanner des vulnérabilités', false, 2),
    (q_id, 'Concevoir des systèmes informatiques ergonomiques', false, 3),
    (q_id, 'Automatiser les interactions entre les utilisateurs et le système', false, 4);

  -- I14
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Quel risque l''IA pose-t-elle en termes de deepfakes pour la cybersécurité ?', 'Les deepfakes générés par l''IA peuvent être utilisés pour usurper l''identité de dirigeants dans des fraudes au virement (arnaque au président), contourner l''authentification biométrique ou propager de la désinformation.', 'intermediaire')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Usurper des identités pour des fraudes et contourner l''authentification biométrique', true, 1),
    (q_id, 'Ralentir les systèmes de surveillance', false, 2),
    (q_id, 'Bloquer les caméras de sécurité', false, 3),
    (q_id, 'Saturer les réseaux avec de fausses images', false, 4);

  -- I15
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Qu''est-ce que le data poisoning dans le contexte de l''IA ?', 'Le data poisoning consiste à introduire des données malveillantes dans le jeu d''entraînement d''un modèle d''IA pour corrompre son apprentissage et le faire produire des résultats incorrects ou biaisés.', 'avance')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'Introduire des données malveillantes dans l''entraînement pour corrompre le modèle', true, 1),
    (q_id, 'Voler les données d''entraînement d''un modèle', false, 2),
    (q_id, 'Empoisonner le cache DNS d''un serveur d''IA', false, 3),
    (q_id, 'Supprimer les données d''entraînement d''un modèle', false, 4);

  -- I16
  INSERT INTO questions (id, category_id, enonce, explication, difficulte) VALUES
    (gen_random_uuid(), cat_ia, 'Quel principe éthique implique que les résultats d''un test de pénétration doivent rester confidentiels ?', 'La confidentialité des résultats est un principe éthique fondamental : les vulnérabilités découvertes ne doivent être partagées qu''avec le client et les parties autorisées, jamais divulguées publiquement sans accord.', 'facile')
    RETURNING id INTO q_id;
  INSERT INTO answer_options (question_id, texte, est_correcte, sort_order) VALUES
    (q_id, 'La confidentialité et le secret professionnel', true, 1),
    (q_id, 'La transparence totale', false, 2),
    (q_id, 'La liberté d''expression', false, 3),
    (q_id, 'Le droit à l''information', false, 4);

END $$;
