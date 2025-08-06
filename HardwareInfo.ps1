# Hardware-Informationen mit WMI in PowerShell

# CPU-Informationen
Write-Output "CPU-Informationen:"
Get-CimInstance Win32_Processor | Select-Object Name, Manufacturer, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed | Format-List
Write-Output "`n------------------------------`n"

# Arbeitsspeicher (RAM)
Write-Output "Arbeitsspeicher (RAM):"
Get-CimInstance Win32_PhysicalMemory | `
Select-Object Capacity, Speed, Manufacturer, PartNumber | `
Format-Table -AutoSize
Write-Output "`n------------------------------`n"

# Festplatten
Write-Output "Festplatten:"
Get-CimInstance Win32_DiskDrive | `
Select-Object Model, SerialNumber, Size, InterfaceType | `
Format-Table -AutoSize
Write-Output "`n------------------------------`n"

# Netzwerkkarten
Write-Output "Netzwerkkarten:"
Get-CimInstance Win32_NetworkAdapterConfiguration | `
Where-Object { $_.IPEnabled -eq $true } | `
Select-Object Description, MACAddress, IPAddress, DefaultIPGateway | `
Format-List
Read-Host -Prompt "Press any key to close"