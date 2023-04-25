# Enable SMB2 protocol
Set-SmbServerConfiguration -EnableSMB2Protocol $true
# Disable SMB1 protocol
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
Set-SmbServerConfiguration -EnableSMB1Protocol $false
# Regedit
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SMB1" -Type DWORD -Value 0

###lan man workstation edit just smb2##
sc.exe qc lanmanworkstation
sc.exe config lanmanworkstation depend= bowser/mrxsmb20/nsi
sc.exe config mrxsmb10 start= disabled
sc.exe config lanmanworkstation depend= bowser/mrxsmb10/mrxsmb20/nsi
sc.exe config mrxsmb20 start= auto

###########Restart PC Remember
