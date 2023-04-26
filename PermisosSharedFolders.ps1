Get-SmbShare | Where-Object {$_.Name -like "*$*"} | ForEach-Object {
    Set-SmbShare -Name $_.Name -FullAccess "DELOROCR\Domain Admins"
}
Get-SmbShare | Where-Object { $_.Name -notlike "*$*" } | Remove-SmbShare
