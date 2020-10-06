$occPath="C:\Program Files (x86)\Electronic Arts\Ultima Online Classic\client.exe"
$occInstaller="http://web.cdn.eamythic.com/us/uo/installers/20120309/UOClassicSetup_7_0_24_0.exe"
$occExe="UOClassicSetup_7_0_24_0.exe"
$dlLoc="C:\UO"
#$dlLoc="C:\Temp"

$cuoUrl="https://github.com/andreakarasho/ClassicUO/releases/download/0.1.5.000/ClassicUO-beta-0-1-5-000-release.zip"
$cuoFile="ClassicUO-beta-0-1-5-000-release.zip"
$cuoJsonUrl="https://raw.githubusercontent.com/ifeelrobbed/uoscripts/main/uogo/settings.json"

$caUrl="https://github.com/Reetus/ClassicAssist/releases/download/0.3.90.233/ClassicAssist.zip"
$caFile="ClassicAssist.zip"

New-Item -ItemType directory -Path $dlLoc

if (Test-Path $occPath -PathType Leaf) {
	Write-Host "`nClassic Client found at $occPath"}
else {
	Write-Host "`nClassic Client not found!" -ForegroundColor red
	Write-Host "`n`nPlease download and install `n$occInstaller `n`nThen run this script again.`n`n"
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
