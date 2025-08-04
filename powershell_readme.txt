Hier sind die wichtigsten PowerShell-Befehle, die du für ein Windows-Postinstall-Skript verwenden kannst. 
Diese Befehle helfen bei der Automatisierung von Aufgaben wie Systemkonfiguration, Softwareinstallation, Benutzerverwaltung und mehr.

### Grundlegende PowerShell-Befehle für ein Postinstall-Skript

#### 1. **Systeminformationen abrufen**
```powershell
# Systeminformationen anzeigen
Get-ComputerInfo
# Hardware-Informationen
Get-WmiObject Win32_ComputerSystem
```

#### 2. **Windows-Dienste verwalten**
```powershell
# Dienst starten
Start-Service -Name "Dienstname"

# Dienst stoppen
Stop-Service -Name "Dienstname"

# Dienststatus prüfen
Get-Service -Name "Dienstname"
```

#### 3. **Softwareinstallation automatisieren**
Zum Beispiel, um eine MSI-Datei zu installieren:
```powershell
Start-Process msiexec.exe -ArgumentList "/i `C:\Pfad\zu\installer.msi` /quiet /norestart" -Wait
```

Oder EXE-Installer:
```powershell
Start-Process "C:\Pfad\zu\installer.exe" -ArgumentList "/silent" -Wait
```

#### 4. **Benutzer und Gruppen verwalten**
```powershell
# Neuen Benutzer erstellen
New-LocalUser -Name "Benutzername" -Password (ConvertTo-SecureString "Passwort" -AsPlainText -Force)

# Benutzer zu Gruppe hinzufügen
Add-LocalGroupMember -Group "Administrators" -Member "Benutzername"
```

#### 5. **Dateien und Ordner verwalten**
```powershell
# Ordner erstellen
New-Item -Path "C:\Pfad\zu\Ordner" -ItemType Directory

# Datei kopieren
Copy-Item -Path "C:\Quelle\datei.txt" -Destination "C:\Ziel\datei.txt"

# Datei löschen
Remove-Item -Path "C:\Pfad\zu\datei.txt"
```

#### 6. **Registry ändern**
```powershell
# Wert in der Registry setzen
Set-ItemProperty -Path "HKLM:\Software\MeinUnternehmen" -Name "MeinWert" -Value "NeuerWert"
```

#### 7. **Netzwerk konfigurieren**
```powershell
# IP-Adresse konfigurieren
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress "192.168.1.100" -PrefixLength 24 -DefaultGateway "192.168.1.1"

# DNS-Server setzen
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("8.8.8.8","8.8.4.4")
```

#### 8. **Updates installieren**
```powershell
# Windows Update starten (über PSWindowsUpdate Modul)
Install-Module PSWindowsUpdate -Force
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install -AutoReboot
```

#### 9. **Autostart-Einträge verwalten**
```powershell
# Programm zum Autostart hinzufügen
$ShortcutPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\MeinProgramm.lnk"
$TargetPath = "C:\Pfad\zu\MeinProgramm.exe"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $TargetPath
$Shortcut.Save()
```

#### 10. **Automatisierung und Planung**
```powershell
# Aufgabenplanung erstellen
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File C:\Pfad\zu\Script.ps1"
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName "MeinPostinstallTask" -Action $action -Trigger $trigger -RunLevel Highest
```

---

### Hinweise für ein Windows-Postinstall-Script
- Das Skript sollte möglichst fehlerrobust sein, z.B. mit Try/Catch-Blöcken.
- Stelle sicher, dass das Skript mit Administratorrechten ausgeführt wird.
- Du kannst das Skript als `.ps1` Datei speichern und über GPO, SCCM oder andere Deployment-Tools ausrollen.
- Für eine automatische Ausführung nach der Installation kannst du das Skript in den Autostart-Ordner legen oder eine geplante Aufgabe erstellen.

