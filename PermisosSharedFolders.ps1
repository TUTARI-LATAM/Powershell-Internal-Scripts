Get-SmbShare | Where-Object {$_.Name -like "*$*"} | ForEach-Object {
    $shareName = $_.Name
    Set-SmbShare -Name $shareName -FolderParameter $_.Path -FullAccess "DELOROCR\Domain Admins"
}
Get-SmbShare | Where-Object { $_.Name -notlike "*$*" } | Remove-SmbShare
