# Enable SMB2 protocol
Set-SmbServerConfiguration -EnableSMB2Protocol $true
Set-SmbClientConfiguration -EnableSMB2Protocol $true

# Disable SMB1 protocol
Set-SmbServerConfiguration -EnableSMB1Protocol $false
Set-SmbClientConfiguration -EnableSMB1Protocol $false

#
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SMB1" -Type DWORD -Value 0
Get-SmbConnection

