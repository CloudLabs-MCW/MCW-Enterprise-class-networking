Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension-wgweb2.txt -Append
[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls" 

#Import Common Functions
$path = pwd
$path=$path.Path
$commonscriptpath = "$path" + "\cloudlabs-common\cloudlabs-windows-functions.ps1"
. $commonscriptpath

WindowsServerCommon
sleep 10

# Define variables
$SiteName = "CloudShop"
$SitePath = "C:\inetpub\wwwroot\$SiteName"
$GitHubRepo = "https://raw.githubusercontent.com/CloudLabs-MCW/MCW-Enterprise-class-networking/prod/Hands-on%20lab"
$IndexFile = "$GitHubRepo/index.html"
$StylesFile = "$GitHubRepo/styles.css"

# Ensure IIS is installed
Write-Host "Installing IIS..." -ForegroundColor Green
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Create the website folder
Write-Host "Creating website directory..." -ForegroundColor Green
New-Item -Path $SitePath -ItemType Directory -Force

# Download index.html and styles.css from GitHub
Write-Host "Downloading web files..." -ForegroundColor Green
Invoke-WebRequest -Uri $IndexFile -OutFile "$SitePath\index.html"
Invoke-WebRequest -Uri $StylesFile -OutFile "$SitePath\styles.css"

# Update index.html with server name
$ServerName = $env:COMPUTERNAME
(Get-Content "$SitePath\index.html") -replace "running on <span id=`"server-name`"></span>", "running on <span style='font-weight:bold; background:white; color:#6ab0de; padding:5px 10px; border-radius:5px;'>$ServerName</span>" | Set-Content "$SitePath\index.html"

# Configure IIS website
Write-Host "Configuring IIS site..." -ForegroundColor Green
New-WebSite -Name $SiteName -PhysicalPath $SitePath -Port 80

# Restart IIS to apply changes
Write-Host "Restarting IIS..." -ForegroundColor Green
Restart-Service W3SVC

Write-Host "Deployment completed! Visit http://localhost to view the site." -ForegroundColor Cyan
