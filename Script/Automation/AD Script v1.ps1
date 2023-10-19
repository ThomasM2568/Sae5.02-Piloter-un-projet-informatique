$CSVFile = "C:\BDD-Script\add_personnel.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter "," -Encoding UTF8

New-ADOrganizationalUnit -Name "CLINIQUE" -Path "DC=AKAT,DC=FR" -ProtectedFromAccidentalDeletion $false # Protected a supprimer lors de la vraie mise en place
New-ADGroup -Name "EQUIPES" -Path "OU=CLINIQUE,DC=AKAT,DC=FR" -GroupScope Global

New-Item -Path "C:\" -Name "PERSO" -ItemType "Directory" -Force
New-Item -Path "C:\" -Name "EQUIPES" -ItemType "Directory" -Force

foreach ($add_personnel in $CSVData) {
    $EquipesPersonnel = $add_personnel.occupation
    New-ADGroup -Name "$EquipesPersonnel" -GroupScope Global -Path "OU=CLINIQUE,DC=AKAT,DC=FR"
    Add-ADGroupMember -Identity "CN=EQUIPES,OU=CLINIQUE,DC=AKAT,DC=FR" -Members "$EquipesPersonnel"
    New-Item -Path "C:\EQUIPES\" -Name "$EquipesPersonnel" -ItemType "Directory" -Force

    $acl = Get-ACL -Path "C:\EQUIPES\$EquipesPersonnel"
    $acl.SetAccessRuleProtection($true, $false)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrateur", "FullControl", "Allow")
    $acl.AddAccessRule($AccessRule)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("EQUIPES", "ReadAndExecute", "Allow")
    $acl.AddAccessRule($AccessRule)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$EquipesPersonnel", "Modify", "Allow")
    $acl.AddAccessRule($AccessRule)
    $acl | Set-Acl -Path "C:\EQUIPES\$EquipesPersonnel"
}

New-SmbShare -Name "EQUIPES" -Path "C:\EQUIPES\" -FullAccess "Everyone"
New-SmbShare -Name "PERSO" -Path "C:\PERSO\" -FullAccess "Everyone"

foreach ($add_personnel in $CSVData) {
    $Prenom = $add_personnel.Prenom
    $Nom = $add_personnel.Nom
    $Equipe = $add_personnel.Occupation

    New-ADUser -Name "$Nom" -Path "OU=CLINIQUE,DC=AKAT,DC=FR" -Enabled $true -AccountPassword (ConvertTo-SecureString -AsPlainText "Secret123" -Force) -DisplayName "$Prenom $Nom" -GivenName "$Prenom" -Surname "$Nom" -HomeDrive "M:" -HomeDirectory "\\LABANU\PERSO\$Nom" -ScriptPath "loginQualite.bat" -AccountExpirationDate ((Get-Date).AddMonths(6))

    Add-ADGroupMember -Identity "CN=$Equipe,OU=CLINIQUE,DC=AKAT,DC=FR" -Members "$Nom"

    New-Item -Path "C:\PERSO\" -Name "$Nom" -ItemType "Directory" -Force
    $acl = Get-ACL -Path "C:\PERSO\$Nom"
    $acl.SetAccessRuleProtection($true, $false)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrateur", "FullControl", "Allow")
    $acl.AddAccessRule($AccessRule)
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$Nom", "Modify", "Allow")
    $acl.AddAccessRule($AccessRule)
    $acl | Set-Acl -Path "C:\PERSO\$Nom"
}
