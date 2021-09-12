$FirstName = (Read-Host First Name)
$LastName = (Read-Host Last Name)
$UserName = (Read-Host Windows Username)
$Department = (Read-Host Department)
$Description = (Read-Host  Account Description)

$systemName = $firstName + " " + $lastName
$logonName = $userName + "@" + $env:USERDNSDOMAIN 
$userMail =  $userName + "@" + "$env:USERDNSDOMAIN"

New-ADUser -Name $systemName -DisplayName $systemName -GivenName $FirstName -Surname $LastName -SamAccountName $UserName -UserPrincipalName $logonName -Department $Department -EmailAddress $userMail -Description $Description -AccountPassword(Read-Host  -AsSecureString "Account Password") -PassThru | Enable-ADAccount 

