Start-Transcript -Path C:\WindowsAzure\Logs\logontasklogs.txt -Append

Import-Module SqlServer
$databaseName = "AdventureWorks2017"
$backupFilePath = "C:\LabFiles\AdventureWorks\AdventureWorks2017.bak"

$username = "demouser"
$password = "demo@pass123"
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($username, $securePassword)


# Restore the database from the downloaded backup file
$restorePath = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA"
Restore-SqlDatabase -ServerInstance "WGSQL1" -Database "AdventureWorks2017" -BackupFile "C:\LabFiles\AdventureWorks\AdventureWorks2017.bak" -RelocateFile @(
    @{LogicalFileName = "AdventureWorks2017"; PhysicalFileName = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2017.mdf"},
    @{LogicalFileName = "AdventureWorks2017_log"; PhysicalFileName = "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2017.ldf"}
) -ReplaceDatabase -SqlCredential $cred

# Output message
Write-Output "AdventureWorks2017 database has been successfully downloaded and restored to SQL Server."

Stop-Transcript
