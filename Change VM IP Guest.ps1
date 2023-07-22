# Reemplaza "NombreDeTuVMGuest" con el nombre de tu máquina virtual
$vmGuest = Get-VM -Name "NombreDeTuVMGuest"
$networkAdapter = Get-VMNetworkAdapter -VMName $vmGuest.Name

# Reemplaza los valores con la nueva configuración de IP
$ipAddress = "NUEVA_DIRECCION_IP"
$subnetMask = "MASCARA_DE_SUBRED"
$gateway = "PUERTA_DE_ENLACE"

# Configurar la nueva dirección IP en la interfaz de red de la VM Guest
New-NetIPAddress -InterfaceIndex $networkAdapter.InterfaceIndex -IPAddress $ipAddress -PrefixLength $subnetMask
Set-NetIPInterface -InterfaceIndex $networkAdapter.InterfaceIndex -DefaultGateway $gateway

# Verificar la configuración de IP de la interfaz de red de la VM Guest
Get-NetIPAddress -InterfaceIndex $networkAdapter.InterfaceIndex

# Verificar la configuración de la puerta de enlace
Get-NetIPInterface -InterfaceIndex $networkAdapter.InterfaceIndex
