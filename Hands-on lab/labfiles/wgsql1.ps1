Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension-wgsql-1.txt -Append
[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls" 

# Download the database backup file from the GitHub repo
Invoke-WebRequest 'https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak' -OutFile 'C:\AdventureWorks2017.bak'

# Define database variables
$ServerName = $env:ComputerName
#$DatabaseName = 'WideWorldImporters'
$SqlMiUser = 'demouser'
$PasswordPlainText = 'demo@pass123'
$PasswordSecure = ConvertTo-SecureString $PasswordPlainText -AsPlainText -Force
$PasswordSecure.MakeReadOnly()
$Creds = New-Object System.Management.Automation.PSCredential $SqlMiUser, $PasswordSecure
$Password = $Creds.GetNetworkCredential().Password

# Restore the Adventuerworks database using the downloaded backup file
function Restore-SqlDatabase1 {
    $bakFileName = 'C:\AdventureWorks2017.bak'

    $RestoreCmd = "

  RESTORE DATABASE [AdventureWorks2017]
  FILE = N'AdventureWorks2017'
  FROM DISK = N'C:\AdventureWorks2017.bak'
  WITH 
    FILE = 1, NOUNLOAD, STATS = 10,
    MOVE N'AdventureWorks2017'
    TO N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AdventureWorks2017.mdf',
    MOVE N'AdventureWorks2017_log'
    TO N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Log\AdventureWorks2017_log.ldf'"

    Invoke-SqlCmd -Query $RestoreCmd -QueryTimeout 3600 -Username $SqlMiUser -Password $Password -ServerInstance $ServerName
    Start-Sleep -Seconds 30
}

# Restore the Adventuerworks datasbase
Restore-SqlDatabase1

Start-Sleep -Seconds 30

# Restart the MSSQLSERVER service.
Stop-Service -Name 'MSSQLSERVER' -Force
Start-Service -Name 'MSSQLSERVER'

# Enable the Service Broker functionality on the database
Enable-ServiceBroker
