
Import-Module ActiveDirectory
$users = Get-ADUser -Filter *
foreach ($user in $users)
{
Set-ADUser -Identity $user -Clear "HomeMDB"
Set-ADUser -Identity $user -Clear "HomeMTA"
Set-ADUser -Identity $user -Clear "msExchALObjectVersion"
Set-ADUser -Identity $user -Clear "msExchHomeServerName"
Set-ADUser -Identity $user -Clear "msExchMailboxGuid"
Set-ADUser -Identity $user -Clear "msExchPoliciesIncluded"
Set-ADUser -Identity $user -Clear "msExchUserAccountControl"
Set-ADUser -Identity $user -Clear "proxyAddresses"
Set-ADUser -Identity $user -Clear "legacyExchangeDN"
}