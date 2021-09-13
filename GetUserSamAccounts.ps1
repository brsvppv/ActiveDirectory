#Get-ADUser -LDAPFilter "(!userAccountControl:1.2.840.113556.1.4.803:=2)" -pr * ` | Select-Object samaccountname `  | Format-Table -AutoSize | export-csv c:\Export\user_dump.csv -NoTypeInformation
#Get-ADUser -LDAPFilter "(!userAccountControl:1.2.840.113556.1.4.803:=2)" -pr * ` | select samaccountname `  | ConvertTo-HTML | Out-File C:\Export\Test.htm

$ADUsers = Get-ADUser -Filter * -SearchBase "DC=TVBG" -Properties *
write-host $ADUsers
$W = 'Write-Host'
foreach ($ADUser in $ADUsers){
write-host "First Name: " $ADUser.GivenName
write-host "Last Name: "$ADUser.Surname
write-host "Full Name: "$ADUser.DisplayName
Write-host "UserName: " $ADUser.SamAccountName
write-host "Domain Name: "$ADUser.UserPrincipalName
Write-host "EMail: "$ADUser.EmailAddress
Write-Host "Department: "$ADUser.Department
Write-host "Description: " $ADUser.Description
Write-host "~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green

} 