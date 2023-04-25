# Enable SMB2 protocol
Set-SmbServerConfiguration -EnableSMB2Protocol $true


# Disable SMB1 protocol
Set-SmbServerConfiguration -EnableSMB1Protocol $false


#
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SMB1" -Type DWORD -Value 0



sc.exe qc lanmanworkstation
sc.exe config lanmanworkstation depend= bowser/mrxsmb10/mrxsmb20/nsi
sc.exe config mrxsmb20 start= auto
