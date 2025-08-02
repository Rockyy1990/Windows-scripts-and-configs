@echo off

echo Setze Windows Update auf manuelle Suche, Download und Installation...

REM Windows Update auf manuell stellen (keine automatischen Downloads)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f

REM Optional: Benachrichtigung bei Updates aktivieren (falls noch nicht)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /t REG_DWORD /d 1 /f

REM Deaktiviert die Lieferungsoptimierung für Windows Update

REM Registry-Pfad für Delivery Optimization
set "regPath=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization"

REM Setze den Wert auf 0 (deaktiviert)
reg add "%regPath%" /v DODownloadMode /t REG_DWORD /d 0 /f

echo Einstellungen wurden übernommen.
pause
