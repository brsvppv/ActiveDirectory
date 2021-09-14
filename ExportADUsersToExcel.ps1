Function ExportADUsersToExcel{
   
    Write-host "Input Domain Prefix"
    Write-Host "Example: " -ForegroundColor Yellow -NoNewline; Write-Host "DomainName" -ForegroundColor Green  -NoNewline;  Write-Host ".com" 
    $DC =(Read-Host Domain Name)
    Write-host "Input Domain Suffix"
    Write-Host "Example: " -ForegroundColor Yellow -NoNewline; Write-Host "Domain." -NoNewline; Write-Host "com" -ForegroundColor Green
    $DCEXT = (Read-Host Domain Suffix)
    
    ### Split if domain is only 2 parts.
    #$ADDC = (Read-Host Domain Name)
    #$ADDC =$ADDC.Split(".")
    #$DC = $ADDC[0]
    #$DCEXT = $ADDC[1]

    $Excel = New-Object -ComObject Excel.Application
    $Excel.Visible = $true
    $Workbook = $excel.Workbooks.Add()
    $Sheets = $workbook.Worksheets
         
    $CurrentWorkSheet = $Sheets.Add()
    $CurrentWorkSheet.Name = $env:USERDNSDOMAIN
    
    $lineNo = 1
    
    # Create Headers
    $currentWorkSheet.Cells.Item($lineNo, 1) = "GivenName"
    $currentWorkSheet.Cells.Item($lineNo, 2) = "Surname"
    $currentWorkSheet.Cells.Item($lineNo, 3) = "DisplayName"
    $currentWorkSheet.Cells.Item($lineNo, 4) = "SamAccountName"
    $currentWorkSheet.Cells.Item($lineNo, 5) = "UserPrincipalName"
    $currentWorkSheet.Cells.Item($lineNo, 6) = "EmailAddress"
    $currentWorkSheet.Cells.Item($lineNo, 7) = "Department"
    $currentWorkSheet.Cells.Item($lineNo, 8) = "Description"
    
    $format = $currentWorkSheet.UsedRange
    $format.Font.Bold = "True"
    
    $ADUsers = Get-ADUser -Filter * -SearchBase "DC=$DC, DC=$DCEXT" -Properties *

    foreach ($ADUser in $ADUsers){
        $LineNo++
        $currentWorkSheet.Cells.Item($lineNo, 1) = $ADUser.GivenName
        $currentWorkSheet.Cells.Item($lineNo, 2) = $ADUser.Surname
        $currentWorkSheet.Cells.Item($lineNo, 3) = $ADUser.DisplayName
        $currentWorkSheet.Cells.Item($lineNo, 4) = $ADUser.SamAccountName
        $currentWorkSheet.Cells.Item($lineNo, 5) = $ADUser.UserPrincipalName
        $currentWorkSheet.Cells.Item($lineNo, 6) = $ADUser.EmailAddress
        $currentWorkSheet.Cells.Item($lineNo, 7) = $ADUser.Department
        $currentWorkSheet.Cells.Item($lineNo, 8) = $ADUser.Description
        $currentWorkSheet.Cells.Item($lineNo, 8) = $ADUser.Enabled
    }
}
ExportADUsersToExcel