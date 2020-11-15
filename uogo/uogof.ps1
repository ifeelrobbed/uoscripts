$ocuPath="F:\Program Files (x86)\Electronic Arts\Ultima Online Classic\UO.exe"
$occPath="F:\Program Files (x86)\Electronic Arts\Ultima Online Classic\client.exe"
$occInstaller="http://web.cdn.eamythic.com/us/uo/installers/20120309/UOClassicSetup_7_0_24_0.exe"
$occExe="UOClassicSetup_7_0_24_0.exe"
$dlLoc="F:\UO"
#$dlLoc="F:\Temp"

$cuoUrl="https://github.com/andreakarasho/ClassicUO/releases/download/0.1.6.1/ClassicUO-beta-0-1-6-1-release.zip"
$cuoFile="ClassicUO-beta-0-1-6-1-release.zip"
$cuoJsonUrl="https://raw.githubusercontent.com/ifeelrobbed/uoscripts/main/uogo/settings.json"

$caUrl="https://github.com/Reetus/ClassicAssist/releases/download/0.3.129.240/ClassicAssist.zip"
$caFile="ClassicAssist.zip"

$mapUrl="https://github.com/ifeelrobbed/uoscripts/raw/main/uogo/maps/map.zip"
$mapFile="map.zip"

Write-Host "*****************************************************************************************" -ForegroundColor yellow
Write-Host "This script will do the following:" -ForegroundColor yellow
Write-Host "Check if you have the official UO Classic Client installed and updated." -ForegroundColor yellow
Write-Host "If not, it will prompt you on how to download and install." -ForegroundColor yellow
Write-Host "If so, it will then:" -ForegroundColor yellow
Write-Host "Download and install the ClassicUO client to bring UO closer to 2020 rather than 1999." -ForegroundColor yellow
Write-Host "Configure ClassicUO client to connect to the ProjectArcturus shard." -ForegroundColor yellow
Write-Host "Download and install ClassicAssist to allow powerful macro creation and misc options." -ForegroundColor yellow
Write-Host "Download and install world map data so towns, shops, dungeons, etc are marked on the map." -ForegroundColor yellow
Write-Host "*****************************************************************************************" -ForegroundColor yellow

if (-not (Test-Path $dlLoc -PathType Container)) {
	Write-Host "Creating download directory $dlLoc"
	New-Item -ItemType directory -Path $dlLoc | Out-Null
	}
	else {
		Write-Host "$dlLoc already exists"
	}
if (Test-Path $occPath -PathType Leaf) {
	Write-Host "`nClassic Client found at $occPath"}
	elseif ((Test-Path $ocuPath -PathType Leaf) -and (-not(Test-Path $occPath -PathType Leaf))) {
		Write-Host "`nClassic Client found but not updated!" -ForegroundColor red
		Write-Host "`n`nPlease run the offical UO client:`n$ocuPath `nLet it finish updating. Then run this script again.`n`n" -ForegroundColor red
		
		Start-Sleep -s 10
		
		ii "F:\Program Files (x86)\Electronic Arts\Ultima Online Classic"		
		
		exit}
	else {
		Write-Host "`nClassic Client not found!" -ForegroundColor red
		Write-Host "`n`nPlease download and install `n$occInstaller `n`nOnce installed, run: `n$ocuPath `n`nand let it finish updating. Once updated, close the update window and run this script again.`n`n" -ForegroundColor red
		exit}

$cuoLoc="$dlLoc\$cuoFile"
Write-Host "Downloading ClassicUO client to $cuoLoc"	
Invoke-WebRequest -Uri $cuoUrl -OutFile $cuoLoc

$caLoc="$dlLoc\$caFile"
Write-Host "Downloading ClassicAssist to $caLoc"	
Invoke-WebRequest -Uri $caUrl -OutFile $caLoc

Write-Host "Extracting ClassicUO client to $dlLoc\ClassicUO\"
Expand-Archive -Path $cuoLoc -DestinationPath "$dlLoc\ClassicUO\" -Force

Write-Host "Extracting ClassicAssist to $dlLoc\ClassicAssist\"
Expand-Archive -Path $caLoc -DestinationPath "$dlLoc\ClassicAssist\" -Force

$cuoJsonLoc="$dlLoc\ClassicUO\settings.json"
Write-Host "Downloading settings file"
Invoke-WebRequest -Uri $cuoJsonUrl -OutFile $cuoJsonLoc

$mapLoc="$dlLoc\$mapFile"
Write-Host "Downloading map files"
Invoke-WebRequest -Uri $mapUrl -OutFile $mapLoc

Write-Host "Extracting Map data to $dlLoc\ClassicUO\Data\Client\"
Expand-Archive -Path $mapLoc -DestinationPath "$dlLoc\ClassicUO\Data\Client\" -Force

$cuoExe="$dlLoc\ClassicUO\ClassicUO.exe"

Write-Host "Creating Desktop shortcut for ClassicUO"
$desktop=[environment]::getfolderpath("Desktop")
$shortCut="$desktop\ClassicUO.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($shortCut)
$Shortcut.TargetPath = $cuoExe
$Shortcut.Save()

Write-Host "**********************************************************************************************************************" -ForegroundColor green
Write-Host "Install complete!`nYou may now launch the game and connect to the ProjectArcturus shard via the ClassicUO Desktop shortcut or by running:`n$cuoExe" -ForegroundColor green
Write-Host "**********************************************************************************************************************" -ForegroundColor green

