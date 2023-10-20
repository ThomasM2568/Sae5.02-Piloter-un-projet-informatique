# SAÉ 5.02 Piloter un projet informatique
## Kyllian Cuevas, Arnaud Kastner, Alexandre Berot-Armand, Thomas Mirbey
# ----------------------------------------------

# Le projet consiste à sécuriser au mieux le système informatique d’un hôpital. En effet, les hôpitaux sont souvent la cible d’attaque cyber consistant à rançonner l’établissement en lui bloquant son système informatique et en supprimant les données 
# médicales #et administratives. La conséquence grave est d’interrompre les soins et d’empêcher les opérations urgentes, en effaçant l’accès aux dossiers médicaux contenant principalement des analyses biologiques, l’imagerie médicale, la consultation des
# traitements et #les conclusions et analyses des spécialistes.
# Les données médicales volées ont une valeur financière importante à la revente sur le black market.

# Informations sur le projet :
# Tâches à Réaliser

## Architecture Réseau Sécurisée
- Construction d’une architecture réseau sécurisée avec 3 espaces distincts : direction, administration de l’hôpital, gestion des données médicales.

## Authentification et Accès
- Mise en place du standard 802.1X pour sécuriser l'accès au réseau filaire et sans fil.
- Authentification centralisée avec Radius pour gérer les droits d'accès des utilisateurs.

## Contrôle d'Accès
- Accès restreint à la salle d'opération aux personnels médicaux pendant les opérations.
- Accès autorisé aux personnels d'entretien en dehors des opérations médicales.

## Bases de Données
- Création de deux bases de données distinctes pour les personnels et les patients sur des serveurs dédiés.

## Serveur de Direction
- Mise en place d'un serveur dédié pour la direction.

## Sauvegarde des Données
- Sauvegarde régulière des données sur les serveurs pour permettre une restauration efficace en cas de perte de données sur le serveur principal.

## Réinstallation Automatisée
- Mise en place d'une procédure de réinstallation automatisée d'un serveur pour réactiver un serveur dont le système est effacé ou inutilisable.

## Rôles des Serveurs
- Mise en place d'une procédure d'échange des rôles entre le serveur principal et le serveur de secours en cas de défaillance du serveur principal.

## VPN
- Mise en place d'un VPN avec l'autre hôpital pour permettre l'échange de données médicales.
- Création de procédures de consultation des données médicales à échanger.

## Documentation
- Documentation complète de l'ensemble des tâches pour permettre à tout le personnel du service informatique/réseau d'accomplir ces tâches.

## Utilisation de GitHub
- Utilisation de GitHub pour créer la base de données et sauvegarder les configurations du réseau.

## Validation Préalable
- Validation de l'architecture sur GNS3 avant de déployer en réel.

# Matériels à Disposition
- 2 switches Cisco Catalyst C34/5XX
- 1 borne WiFi Linksys WRT54G
- 1 routeur Cisco 1841/1900 pour gérer les accès et les droits entre services
- 4 serveurs : direction, administration, médical, VPN (ou box Cisco)
- Quelques postes clients 802.1X et un ordinateur portable 802.1X
- Un smartphone Android avec 802.1X

Ces tâches sont cruciales pour la mise en place d'un réseau sécurisé à l'hôpital et pour garantir la confidentialité des données médicales.

# -------------------------------------------

# Rôles

## Utilisateurs
- Accès au Serveur Web avec la possibilité d'ajouter des données dans les tables ou d'en retirer.

## Administrateur Base de Données
- Accès RWX à la Base de données.

## Administrateur Réseau
- Accès RWX aux Routeurs et Switchs.
- Accès RWX au Serveur MQTT.

## Administrateur Sécurité
- Accès RWX à Radius.
- Accès RWX au Pare-feu.

## Administrateur Système
- Accès RWX à Active Directory.
- Accès RWX au Serveur de Stockage.
- Accès RWX au Serveur Web.

## Développeur
- Accès RWX à Active Directory.
- Accès RWX au Serveur MQTT.
- Accès RWX au Serveur Web.

## Patient
## Secrétaire / Accueil
## Personnel Médical
## Chef d'hôpital

# Fiche Mots de Passe Sécurisés
- Au moins une majuscule, un chiffre et un caractère spécial.
- Au moins 8 caractères.

# Applications
- Github: Sauvegarde de Scripts et Documentation -> Centralisation et versionnage.
- Discord: Échange et travail collaboratif -> Centralisation et travail à distance.
- Google Drive, Trello, Lucidchart et Figma: Travail collaboratif.
- Mobaxterm: Connexion aux équipements.
- Apache, MariaDB, Zabbix, Mosquitto.
- Python, Powershell, Ansible.
- PHP, MariaDB.

# Scripts

- Site web (PHP MariaDB)
- Serveur MQTT (Python).
- Contrôle d'accès carte (Arduino et Python).
- Capteurs de températures (Arduino).
- Capteurs de présence (Arduino).
- Automatisation des dépôts Github (Python).
- Automatisation Import/Export BDD (Python).
- Automatisation des tests de sécurité, redondances, etc. (Ansible).
- Automatisation des configurations Cisco (Ansible).

- Powershell
  - DHCP.
  - AD.
  - DNS.
  - Dépôt Github automatique (Python).
  - Import Export BDD et copie NAS (Python).
  - Backup fichiers (Powershell).

