###Remember Install Active Directory Module###

$users= Get-ADUser -Filter * -SearchBase 'OU=Disabled,DC=TEST,DC=local' 
foreach ($user in $users)
{
Set-ADUser -Identity $user -Clear "proxyAddresses"
Set-ADUser -Identity $user -Clear "mail"
############Hide Account From GAL ###############
#####Using Custom Attribute##########
Set-ADUser -Identity $user -Clear "msDS-cloudExtensionAttribute1"
Set-ADObject $user -replace @{msExchHideFromAddressLists=$true}
Set-ADUser $user -Add @{'msDS-cloudExtensionAttribute1' = "HideFromGAL"}
}