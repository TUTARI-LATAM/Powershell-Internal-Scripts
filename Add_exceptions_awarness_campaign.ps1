Install-Module ExchangeOnlineManagement
Connect-ExchangeOnline

#Agregar remitentes seguros para cada usuario
Get-Mailbox -ResultSize Unlimited | Set-MailboxJunkEmailConfiguration -TrustedSendersAndDomains "pishing.tutari.net","noreply@pishing.tutari.net"
