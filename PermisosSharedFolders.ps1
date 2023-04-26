Get-SmbShare | Where-Object {$_.Name -like "*$*"} | ForEach-Object {
    $shareName = $_.Name
    $acl = Get-Acl $_.Path
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("DELOROCR\Domain Admins","FullControl","Allow")
    $acl.SetAccessRule($rule)
    $sec = $acl.GetSecurityDescriptorSddlForm("All")
    Set-SmbShareAccess -Name $shareName -AccessRight Full -AccessControlType Allow -AccountName "DELOROCR\Domain Admins" -CimSession (Get-CimSession) -SecurityDescriptorSddl $sec
}
Get-SmbShare | Where-Object { $_.Name -notlike "*$*" } | Remove-SmbShare
