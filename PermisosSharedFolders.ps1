Get-SmbShare | Where-Object {$_.Name -like "*$*"} | Get-SmbShareAccess | Where-Object {$_.AccountName -eq "Everyone"} | ForEach-Object {  
    Revoke-SmbShareAccess -name $_.name -AccountName $_.AccountName -Force}  
Get-SmbShare | Where-Object {$_.Name -like "*$*"} | Get-SmbShareAccess | Where-Object {$_.AccountName -eq "DELOROCR\Domain Admins"} | ForEach-Object {  
    Grant-SmbShareAccess -name $_.name -AccountName $_.AccountName -Force}  
Get-SmbShare | Where-Object { $_.Name -notlike "*$*" } | Remove-SmbShare
