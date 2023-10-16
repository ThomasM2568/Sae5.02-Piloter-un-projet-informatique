$CSVFile = "C:\BDD-Script\UtilisateursQualite.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8
$CSVTeam = "C:\BDD-Script\GroupesQualite.csv"
$CSVTeamData = Import-CSV -Path $CSVTeam -Delimiter ";" -Encoding UTF8

New-ADOrganizationalUnit -Name "QUALITE" -Path "DC=GSB,DC=COM" -ProtectedFromAccidentalDeletion $false # Protected a supprimer lors de la vraie mise en place
New-ADGroup -Name "EQUIPES" -Path "OU=QUALITE,DC=GSB,DC=COM" -GroupScope Global

New-Item -Path "C:\" -Name "PERSO" -ItemType "Directory" -Force
New-Item -Path "C:\" -Name "EQUIPES" -ItemType "Directory" -Force

foreach ($GroupeQualite in $CSVTeamData) {
    $GroupeQualiteNom = $GroupeQualite.groupe
    New-ADGroup -Name "$GroupeQualiteNom" -GroupScope Global -Path "OU=QUALITE,DC=GSB,DC=COM"
    Add-ADGroupMember -Identity "CN=EQUIPES,OU=QUALITE,DC=GSB,DC=COM" -Members "$GroupeQualiteNom"
    New-Item -Path "C:\EQUIPES\" -Name "$GroupeQualiteNom" -ItemType "Directory" -Force

    $acl = Get-ACL -Path "C:\EQUIPES\$GroupeQualiteNom"
    $acl.SetAccessRuleProtection($true, $false)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrateur", "FullControl", "Allow")
    $acl.AddAccessRule($AccessRule)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("EQUIPES", "ReadAndExecute", "Allow")
    $acl.AddAccessRule($AccessRule)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$GroupeQualiteNom", "Modify", "Allow")
    $acl.AddAccessRule($AccessRule)
    $acl | Set-Acl -Path "C:\EQUIPES\$GroupeQualiteNom"
}

New-SmbShare -Name "EQUIPES" -Path "C:\EQUIPES\" -FullAccess "Everyone"
New-SmbShare -Name "PERSO" -Path "C:\PERSO\" -FullAccess "Everyone"

foreach ($UtilisateursQualite in $CSVData) {
    $Prenom = $UtilisateursQualite.Prenom
    $Nom = $UtilisateursQualite.Nom
    $Equipe = $UtilisateursQualite.Equipe

    New-ADUser -Name "$Nom" -Path "OU=QUALITE,DC=GSB,DC=COM" -Enabled $true -AccountPassword (ConvertTo-SecureString -AsPlainText "Secret123" -Force) -DisplayName "$Prenom $Nom" -GivenName "$Prenom" -Surname "$Nom" -HomeDrive "M:" -HomeDirectory "\\LABANU\PERSO\$Nom" -ScriptPath "loginQualite.bat" -AccountExpirationDate ((Get-Date).AddMonths(6))

    Add-ADGroupMember -Identity "CN=$Equipe,OU=QUALITE,DC=GSB,DC=COM" -Members "$Nom"

    New-Item -Path "C:\PERSO\" -Name "$Nom" -ItemType "Directory" -Force
    $acl = Get-ACL -Path "C:\PERSO\$Nom"
    $acl.SetAccessRuleProtection($true, $false)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrateur", "FullControl", "Allow")
    $acl.AddAccessRule($AccessRule)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$Nom", "Modify", "Allow")
    $acl.AddAccessRule($AccessRule)
    $acl | Set-Acl -Path "C:\PERSO\$Nom"
}