Get-SmbShare | Where-Object {$_.Name -like "*$*"} | Get-SmbShareAccess | Where-Object {$_.AccountName -eq "Everyone"} | ForEach-Object {  
    Revoke-SmbShareAccess -name $_.name -AccountName $_.AccountName -Force}  
Get-SmbShare | ForEach-Object { Grant-SmbShareAccess -Name $_.Name -AccountName "DELOROCR\Domain Admins" -AccessRight Full -Force }
Get-SmbShare | Where-Object { $_.Name -notlike "*$*" } | Remove-SmbShare
