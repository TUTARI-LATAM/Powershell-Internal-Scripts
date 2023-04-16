# Import the AD Module
Import-Module ActiveDirectory

# List all accounts which are already disabled on your AD
Search-ADAccount -AccountDisabled | Select-Object Name, DistinguishedName

# Move all disabled AD users from others OU to the disabled users OU
Search-ADAccount -AccountDisabled | Where {$_.DistinguishedName -notlike “*OU=Deshabilitados*”} | Move-ADObject -TargetPath “OU=Deshabilitados,DC=TEST,DC=local”

# Now, disable all users in that disabled users OU either they are already disabled or not
Get-ADUser -Filter {Enabled -eq $True} -SearchBase “OU=Deshabilitados,DC=TEST,DC=local” | Disable-ADAccount