#Conexión a Azure Active Directory
Connect-AzureAD

#Obtener todos los usuarios de la organización
$users = Get-AzureADUser -All $true | Select-Object UserPrincipalName

#Agregar remitentes seguros para cada usuario
foreach ($user in $users) {
    Set-MailboxJunkEmailConfiguration -Identity $user.UserPrincipalName -TrustedSendersAndDomains @{Add="pishing.tutari.net","noreply@pishing.tutari.net"}
}


Get-Mailbox -ResultSize Unlimited | Set-MailboxJunkEmailConfiguration -TrustedSendersAndDomains "pishing.tutari.net","noreply@pishing.tutari.net"
