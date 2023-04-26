# Comprueba si SMB2 está habilitado
$smb2Enabled = Get-SmbServerConfiguration | Select-Object -ExpandProperty EnableSMB2Protocol

# Si SMB2 ya está habilitado, no hagas nada
if ($smb2Enabled) {
    Write-Host "SMB2 ya está habilitado. No se requiere ninguna acción."
}
else {
    # Habilitar SMB2
    Set-SmbServerConfiguration -EnableSMB2Protocol $true
    Write-Host "SMB2 habilitado correctamente."
}

# Comprueba si SMB1 está deshabilitado
$smb1Enabled = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol | Select-Object -ExpandProperty State

# Si SMB1 ya está deshabilitado, no hagas nada
if ($smb1Enabled -eq "Disabled") {
    Write-Host "SMB1 ya está deshabilitado. No se requiere ninguna acción."
}
else {
    # Deshabilitar SMB1
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -norestart
    Set-SmbServerConfiguration -EnableSMB1Protocol $false
    Write-Host "SMB1 deshabilitado correctamente."
}

# Comprueba si el valor de registro SMB1 es igual a 0
$smb1RegistryValue = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SMB1" | Select-Object -ExpandProperty SMB1

# Si el valor de registro SMB1 ya es igual a 0, no hagas nada
if ($smb1RegistryValue -eq 0) {
    Write-Host "El valor de registro SMB1 ya es igual a 0. No se requiere ninguna acción."
}
else {
    # Establecer el valor de registro SMB1 en 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SMB1" -Type DWORD -Value 0
    Write-Host "El valor de registro SMB1 se estableció correctamente en 0."
}

# Lista de dependencias permitidas
$allowedDependencies = @("bowser", "mrxsmb20", "nsi")

# Comprueba si el servicio LanmanWorkstation está configurado correctamente
$lanmanWorkstation = Get-Service LanmanWorkstation
$lanmanWorkstationConfig = $lanmanWorkstation | Select-Object -ExpandProperty StartType
$lanmanWorkstationDependencies = $lanmanWorkstation.DependentServices | Select-Object -ExpandProperty Name

# Comprueba si las dependencias del servicio LanmanWorkstation son correctas
if ($lanmanWorkstationConfig -eq "Auto" -and $lanmanWorkstationDependencies -eq $allowedDependencies) {
    Write-Host "El servicio LanmanWorkstation ya está configurado correctamente. No se requiere ninguna acción."
}
else {
    # Configurar el servicio LanmanWorkstation correctamente
    sc.exe config lanmanworkstation depend= bowser/mrxsmb20/nsi
    sc.exe config mrxsmb20 start= auto
    Write-Host "El servicio LanmanWorkstation se configuró correctamente."
}

