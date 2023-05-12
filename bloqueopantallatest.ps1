# The Script sets custom background Images for the Desktop and the Lock Screen by leveraging the new feature of PersonalizationCSP that is only available in 

#the Windows 10 v1703 aka Creators Update and later build versions #

# Note: The Image File names can be anything you wish, however the Image resolution that I have been using for my environment was 3840X2160 (not sure if 

#that matters though) #

# Applicable only for Windows 10 v1703 and later build versions #

# Script also assumes that you have alreadt copied over the Desktop and LockScreen Images to the C:\OEMFiles\ folder and are named as Desktop.jpg and LockScreen.jpg respectively #

$ImageUrl = "https://www.formu1a.uno/wp-content/uploads/2023/03/XPB_1196003_HiRes-scaled.jpg"
####Unica Variable a Modificar###
###imagen jpg obligatoria desde un servidor web###



#Variable
$FolderPath= "C:\PantallaBloqueo"
 
#Check if Folder exists
If(!(Test-Path -Path $FolderPath))
{
    #powershell create directory
    New-Item -ItemType Directory -Path $FolderPath
    Write-Host "New folder created successfully!" -f Green
}
Else
{
  Write-Host "Folder already exists!" -f Yellow
}


$ImageFileName = "bg_globe_01.jpg"
$DownloadDirectory = "C:\PantallaBloqueo"
$BingImageFullPath = Join-Path $DownloadDirectory $ImageFileName
# Ruta de la carpeta de destino local
$carpetaDestino = "C:\PantallaBloqueo"
# Verifica si la carpeta de destino existe
if (!(Test-Path $carpetaDestino)) {
    # Crea la carpeta de destino si no existe
    New-Item -ItemType Directory -Path $carpetaDestino | Out-Null
}

Invoke-WebRequest -UseBasicParsing -Uri $ImageUrl -OutFile $BingImageFullPath

 


$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"

$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"
$LockScreenPath = "LockScreenImagePath"
$LockScreenStatus = "LockScreenImageStatus"
$LockScreenUrl = "LockScreenImageUrl"

$StatusValue = "1"
$LockScreenImageValue = "C:\PantallaBloqueo\bg_globe_01.jpg"  #Change as per your needs

IF(!(Test-Path $RegKeyPath))

  {

    New-Item -Path $RegKeyPath -Force | Out-Null

    New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
    New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
    New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
    
    }

 ELSE {

        New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $Statusvalue -PropertyType DWORD -Force | Out-Null
        New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $value -PropertyType DWORD -Force | Out-Null
        New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
        New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
    }