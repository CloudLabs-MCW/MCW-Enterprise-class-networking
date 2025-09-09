# Start transcript to log the script execution
Start-Transcript -Path C:\WindowsAzure\Logs\DownloadAndUploadAdventureWorks.txt -Append

# Set security protocol
[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Create directories for storing the downloaded files
New-Item -ItemType directory -Path C:\LabFiles\AdventureWorks -Force

# Download the AdventureWorks sample database
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak", "C:\LabFiles\AdventureWorks\AdventureWorks2017.bak")
$WebClient.DownloadFile("https://raw.githubusercontent.com/CloudLabs-MCW/MCW-Enterprise-class-networking/refs/heads/prod/Hands-on%20lab/labfiles/wgsql-logontask.ps1", "C:\LabFiles\logontask.ps1")


Install-PackageProvider -NuGet -MinimunVersion 2.8.5.201 -Force

$WebClient = New-Object System.Net.WebClient 
# Installing Nuget Manually
$WebClient.DownloadFile("https://experienceazure.blob.core.windows.net/templates/faiad-april-2025/english/assets/Microsoft.PackageManagement.NuGetProvider.dll","C:\Program Files\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll")

Install-Module -Name SqlServer -Force -AllowClobber
#Enable Autologon
$AutoLogonRegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $AutoLogonRegPath -Name "AutoAdminLogon" -Value "1" -type String 
Set-ItemProperty -Path $AutoLogonRegPath -Name "DefaultUsername" -Value "$($env:ComputerName)\demouser" -type String  
Set-ItemProperty -Path $AutoLogonRegPath -Name "DefaultPassword" -Value "demo@pass123" -type String
Set-ItemProperty -Path $AutoLogonRegPath -Name "AutoLogonCount" -Value "1" -type DWord


# Scheduled Task to Run PostConfig.ps1 screen on logon
$Trigger= New-ScheduledTaskTrigger -AtLogOn
$User= "$($env:ComputerName)\demouser" 
$Action= New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe" -Argument "-executionPolicy Unrestricted -File C:\LabFiles\logontask.ps1"
Register-ScheduledTask -TaskName "logon-task" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Force

Stop-Transcript
Restart-Computer -Force
