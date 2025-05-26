💼 Script PowerShell – Création d’un utilisateur Active Directory avec interface graphique
Ce script PowerShell permet de créer un utilisateur dans Active Directory via une interface graphique conviviale, avec sélection des groupes, définition du mot de passe, et affectation à une unité d'organisation (OU) spécifique.

✨ Fonctionnalités
Interface Windows Forms pour la saisie :
-  Prénom
 - Nom
 - Mot de passe (masqué)
-  Choix du type d'utilisateur (Admin / Collaborateur)
 - Sélection de groupes Active Directory (via liste à cocher)
 - Génération automatique d’un nom d’utilisateur unique
 - Création de l’utilisateur dans Active Directory
 - Ajout aux groupes sélectionnés
 - Formatage automatique du nom (NOM) et prénom (Prénom)
 - Compatibilité : Windows PowerShell avec le module ActiveDirectory

📋 Prérequis
Windows avec PowerShell ≥ 5.1
Module ActiveDirectory installé
Droits administratifs sur le domaine Active Directory

🧰 Utilisation
Ouvrez PowerShell en mode administrateur
Exécutez le script .ps1
Remplissez les champs demandés dans la fenêtre
Cliquez sur OK
L'utilisateur est automatiquement créé avec les informations saisies

🖼️ Aperçu de l'interface
Le formulaire propose :
Une zone de saisie pour le prénom, le nom et le mot de passe
Une case à cocher "OU USERS" (collaborateur)
Une liste de groupes prédéfinis à cocher
Un bouton de validation
Un label discret "XEFI" en signature

⚠️ À personnaliser
Remplacez DC=XXX,DC=LOCAL par votre propre structure de domaine
Adaptez l’OU si vous utilisez des chemins différents
Vérifiez ou mettez à jour la liste des groupes selon vos besoins


