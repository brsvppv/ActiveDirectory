Import-Module ActiveDirectory

$file = "C:\SourceDirectroy\users.csv"
Write-host "Input Domain Prefix"
Write-Host "Example: " -ForegroundColor Yellow -NoNewline; Write-Host "DomainName" -ForegroundColor Green  -NoNewline;  Write-Host ".com" 
$DC =(Read-Host Domain Name)
Write-host "Input Domain Suffix"
Write-Host "Example: " -ForegroundColor Yellow -NoNewline; Write-Host "Domain." -NoNewline; Write-Host "com" -ForegroundColor Green
$DCEXT = (Read-Host Domain Suffix)

$targetDN = "CN=Users,DC=$DC,DC=$DCEXT" 
$importedUsers = Import-Csv $file

foreach ($user in $importedUsers)
{
    $user.AccountPassword = ConvertTo-SecureString $user.AccountPassword -AsPlainText -Force
    $user.Enabled = [System.Boolean]::Parse($user.Enabled)
    $user | New-ADUser -Path $targetDN
}
