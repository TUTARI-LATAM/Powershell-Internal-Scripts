Connect-AzureAD
Connect-MsolService
$useradd = Get-AzureADUser | where {$_.UserPrincipalName -like "*"} | where {$_.UserType -like "Member"}
$users = $useradd.UserPrincipalName
foreach($user in $users){
Set-MsolUserPassword -UserPrincipalName $user -ForceChangePassword:$true -ForceChangePasswordOnly:$true}

