Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension-wgweb1.txt -Append
[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls" 

#Import Common Functions
$path = pwd
$path=$path.Path
$commonscriptpath = "$path" + "\cloudlabs-common\cloudlabs-windows-functions.ps1"
. $commonscriptpath

# Define variables
$sitePath = "C:\inetpub\wwwroot\CloudShop"
$repoUrl = "https://raw.githubusercontent.com/CloudLabs-MCW/MCW-Enterprise-class-networking/prod/Hands-on%20lab"

# Install IIS if not already installed
Write-Host "Installing IIS..." -ForegroundColor Green
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Create a new folder for the website
if (-Not (Test-Path $sitePath)) {
    New-Item -ItemType Directory -Path $sitePath
}

# Download index.html and styles.css from GitHub
Write-Host "Downloading web files from GitHub..." -ForegroundColor Green
Invoke-WebRequest "$repoUrl/index.html" -OutFile "$sitePath\index.html"
Invoke-WebRequest "$repoUrl/styles.css" -OutFile "$sitePath\styles.css"

# Configure IIS to serve the website
Write-Host "Configuring IIS site..." -ForegroundColor Green
Import-Module WebAdministration
if (-Not (Get-Website -Name "CloudShop" -ErrorAction SilentlyContinue)) {
    New-WebSite -Name "CloudShop" -Port 80 -PhysicalPath $sitePath
}

# Restart IIS to apply changes
Write-Host "Restarting IIS..." -ForegroundColor Green
iisreset

Write-Host "Deployment Complete!"
