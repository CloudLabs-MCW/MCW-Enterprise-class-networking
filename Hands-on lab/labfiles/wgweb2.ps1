# Install IIS if not already installed
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Write-Host "IIS installed successfully."

# Ensure the wwwroot folder exists
$wwwrootPath = "C:\inetpub\wwwroot"
if (!(Test-Path $wwwrootPath)) {
    New-Item -Path $wwwrootPath -ItemType Directory -Force
    Write-Host "Created missing wwwroot folder."
}

# Create the IIS Welcome Page with Custom Content
$customHTML = @"
<html>
<head>
    <title>CloudShop Demo</title>
    <style>
        body {
            background-color: blue;
            color: white;
            text-align: center;
            font-family: Arial, sans-serif;
            padding-top: 20%;
        }
        h1 {
            font-size: 36px;
        }
    </style>
</head>
<body>
    <h1>CloudShop Demo - Products - running on WGWEB2</h1>
</body>
</html>
"@

Set-Content -Path "$wwwrootPath\iisstart.htm" -Value $customHTML -Force
Write-Host "IIS Welcome Page updated successfully."

# Restart IIS to Apply Changes
iisreset
Write-Host "IIS restarted successfully."
