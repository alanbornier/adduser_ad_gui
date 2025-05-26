Add-Type -AssemblyName System.Windows.Forms

# Fonction pour afficher un formulaire pour la saisie des informations de l'utilisateur
function Show-UserForm {
    $form = New-Object Windows.Forms.Form
    $form.Text = "Création d'utilisateur - Client CRINEX"
    $form.Width = 450
    $form.Height = 450
    $form.StartPosition = "CenterScreen"

    # Labels et champs pour le prénom
    $labelPrenom = New-Object Windows.Forms.Label
    $labelPrenom.Text = "Prénom:"
    $labelPrenom.Location = New-Object Drawing.Point(10,20)
    $form.Controls.Add($labelPrenom)

    $textBoxPrenom = New-Object Windows.Forms.TextBox
    $textBoxPrenom.Location = New-Object Drawing.Point(150,20)
    $form.Controls.Add($textBoxPrenom)

    # Labels et champs pour le nom
    $labelNom = New-Object Windows.Forms.Label
    $labelNom.Text = "Nom:"
    $labelNom.Location = New-Object Drawing.Point(10,60)
    $form.Controls.Add($labelNom)

    $textBoxNom = New-Object Windows.Forms.TextBox
    $textBoxNom.Location = New-Object Drawing.Point(150,60)
    $form.Controls.Add($textBoxNom)

    # Labels et champs pour le mot de passe
    $labelPassword = New-Object Windows.Forms.Label
    $labelPassword.Text = "Mot de passe:"
    $labelPassword.Location = New-Object Drawing.Point(10,100)
    $form.Controls.Add($labelPassword)

    $textBoxPassword = New-Object Windows.Forms.TextBox
    $textBoxPassword.Location = New-Object Drawing.Point(150,100)
    $textBoxPassword.PasswordChar = '*'  # Cache le mot de passe
    $form.Controls.Add($textBoxPassword)

    # Case à cocher pour choisir le type d'utilisateur
    

    $checkBoxCollaborateur = New-Object Windows.Forms.CheckBox
    $checkBoxCollaborateur.Text = "OU USERS"
    $checkBoxCollaborateur.Location = New-Object Drawing.Point(150,140)
    $form.Controls.Add($checkBoxCollaborateur)

    # Liste de sélection des groupes
    $labelGroups = New-Object Windows.Forms.Label
    $labelGroups.Text = "Sélectionnez les groupes:"
    $labelGroups.Location = New-Object Drawing.Point(10,220)
    $form.Controls.Add($labelGroups)

    $listGroups = New-Object Windows.Forms.CheckedListBox
    $listGroups.Items.AddRange(@(
    "GRP_RDS //Obligatoire pour RDS",
    "GRP_DIRECTION",
    "GRP_LUCETANNECLAIRE",
    "GRP_GIMENEZPRO",
    "GRP_DENTAIRE_RW",
    "GRP_DENTAIRE_RO",
    "GRP_CTD_RO",
    "GRP_CTD_RW",
    "GRP_COMPTA_RW",
    "GRP_COMPTA_RO",
    "GRP_SHAREHOLDER",
    "GRP_PHARMA",
    "GRP_DIR_RH",
    "GRP_DIR_ADMIN",
    "GRP_DENTAL",
    "GRP_DENT_DEL",
    "GRP_DENT_ADMIN",
    "GRP_ALL",
    "GRP_ACCOUNT",    
    "MA_MATERIEL_PROMO_RO",
    "MA_MATERIEL_PROMO_RW",
    "MA_SITE_INTERNET_RO",
    "MA_SITE_INTERNET_RW",
    "MA_PACKAGING_RO",
    "MA_PACKAGING_RW",
    "DQ_PROCEDURES_RO",
    "DQ_PROCEDURES_RW",
    "DQ_ANNEXES_RW",
    "DQ_ANNEXES_RO",
    "DQ_DOCUMENTS_RO",
    "DQ_DOCUMENTS_RW",
    "SQ_PROCEDURES_RO",
    "SQ_PROCEDURES_RW",
    "SQ_AQPRODUITS_RO",
    "SQ_AQPRODUITS_RW",
    "SQ_AQSYSTEME_RW",
    "SQ_AQSYSTEME_RO",
    "SQ_DONNEESDOMP_RO",
    "SQ_DONNEESDOMP_RW",
    "SQ_POLITIQUEQUALITE_RW",
    "SQ_POLITIQUEQUALITE_RO",
    "PH_INSPECTION_RO",
    "PH_INSPECTION_RW",
    "PH_ETATS_DES_LIEUX_RO",
    "PH_ETATS_DES_LIEUX_RW",
    "PH_AUTORISATION_RO",
    "PH_AUTORISATION_RW",
    "PH_R&D_RW",
    "PH_R&D_RO",
    "PH_PV_RW",
    "PH_PV_RO",
    "PH_PRIX_RO",
    "PH_PRIX_RW",
    "PH_AMM_RO",
    "PH_AMM_RW",
    "PH_MARCHESPUBLICS_RO",
    "PH_MARCHESPUBLICS_RW"))
    $listGroups.Location = New-Object Drawing.Point(10,250)
    $listGroups.Size = New-Object Drawing.Size(400,100)
    $form.Controls.Add($listGroups)

    # Bouton OK
    $buttonOk = New-Object Windows.Forms.Button
    $buttonOk.Text = "OK"
    $buttonOk.Location = New-Object Drawing.Point(150,370)
    $buttonOk.Add_Click({
        $form.Close()
    })
    $form.Controls.Add($buttonOk)

    # Ajout du label "Créé par XEFI"
    $labelCreator = New-Object Windows.Forms.Label
    $labelCreator.Text = "XEFI"
    $labelCreator.AutoSize = $true
    $labelCreator.Location = New-Object Drawing.Point(300,375)
    $form.Controls.Add($labelCreator)

    # Affiche le formulaire
    $form.ShowDialog() | Out-Null

    # Renvoie les données saisies
    return @{
        Prenom = $textBoxPrenom.Text
        Nom = $textBoxNom.Text
        Password = $textBoxPassword.Text
        Admin = $checkBoxAdmin.Checked
        Collaborateur = $checkBoxCollaborateur.Checked
        SelectedGroups = $listGroups.CheckedItems
    }
}

# Fonction pour formater le prénom (première lettre en majuscule, le reste en minuscule)
function Format-Prenom {
    param (
        [string]$prenom
    )
    return ($prenom.Substring(0,1).ToUpper() + $prenom.Substring(1).ToLower())
}

# Fonction pour formater le nom (tout en majuscules)
function Format-Nom {
    param (
        [string]$nom
    )
    return $nom.ToUpper()
}

# Fonction pour générer un nom d'utilisateur unique
function Generate-UniqueUserName {
    param (
        [string]$prenom,
        [string]$nom
    )
    $nomUtilisateurBase = ($prenom + "." + $nom).ToLower()
    $nomUtilisateur = $nomUtilisateurBase
    $counter = 1

    # Vérifie si le nom d'utilisateur existe déjà
    while (Get-ADUser -Filter {SamAccountName -eq $nomUtilisateur}) {
        $nomUtilisateur = "$nomUtilisateurBase$counter"
        $counter++
    }

    return $nomUtilisateur
}

# Appel de la fonction pour afficher la fenêtre de saisie et récupérer les données
$userData = Show-UserForm

# Formate le prénom et le nom
$prenom = Format-Prenom $userData.Prenom
$nom = Format-Nom $userData.Nom

# Génération d'un nom d'utilisateur unique
$nomUtilisateur = Generate-UniqueUserName $prenom $nom

# Nom complet pour l'Active Directory
$nomComplet = "$prenom $nom"

# Conversion du mot de passe en chaîne sécurisée
$motDePasse = ConvertTo-SecureString $userData.Password -AsPlainText -Force

# Détermine l'OU en fonction du type d'utilisateur sélectionné
if ($userData.Admin) {
    $ou = "OU=Admin,OU=UTILISATEURS,DC=CRINEXLAB,DC=LOCAL"
}
elseif ($userData.Collaborateur) {
    $ou = "OU=Users,OU=UTILISATEURS,DC=CRINEXLAB,DC=LOCAL"
}

else {
    Write-Host "Aucun type d'utilisateur sélectionné, création annulée."
    exit
}

# Création de l'utilisateur dans Active Directory avec le nom complet et DisplayName
New-ADUser -Name $nomComplet `
           -GivenName $prenom `
           -Surname $nom `
           -SamAccountName $nomUtilisateur `
           -UserPrincipalName "$nomUtilisateur@crinexlab.local" `
           -DisplayName $nomComplet `
           -Path $ou `
           -AccountPassword $motDePasse `
           -Enabled $true

# Ajout de l'utilisateur aux groupes sélectionnés
foreach ($group in $userData.SelectedGroups) {
    Add-ADGroupMember -Identity $group -Members $nomUtilisateur
    Write-Host "L'utilisateur a été ajouté au groupe $group"
}

Write-Host "Création et configuration de l'utilisateur terminées."
