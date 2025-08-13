@echo off
:Menu
cls
echo =====================================================
echo      DISM Systemreinigung u. Reparatur
echo =====================================================
echo Wähle eine Option:
echo 1. System-Image prüfen (Health Scan)
echo 2. System-Image reparieren (RestoreHealth)
echo 3. System-Image mit Source reparieren
echo 4. Komponenten speichern und cleanup
echo 5. Windows Update-Cache löschen
echo 6. Beenden
echo =====================================================
set /p choice=Gib deine Wahl ein (1-6): 

if "%choice%"=="1" goto CheckHealth
if "%choice%"=="2" goto RepairHealth
if "%choice%"=="3" goto RepairWithSource
if "%choice%"=="4" goto CleanupComponentStore
if "%choice%"=="5" goto ResetWindowsUpdate
if "%choice%"=="6" goto End
goto Menu

:CheckHealth
echo Prüfen des System-Images...
dism /Online /Cleanup-Image /CheckHealth
pause
goto Menu

:RepairHealth
echo Reparieren des System-Images...
dism /Online /Cleanup-Image /RestoreHealth
pause
goto Menu

:RepairWithSource
set /p sourcePath=Bitte gib den Pfad zum Reparatur-Source an (z.B. E:\Sources\install.wim): 
echo Reparieren mit Source...
dism /Online /Cleanup-Image /RestoreHealth /Source:%sourcePath% /LimitAccess
pause
goto Menu

:CleanupComponentStore
echo Komponenten-Store bereinigen...
dism /Online /Cleanup-Image /StartComponentCleanup
pause
goto Menu

:ResetWindowsUpdate
echo Windows Update-Cache wird gelöscht...
net stop wuauserv
net stop bits
rd /s /q %windir%\SoftwareDistribution
net start wuauserv
net start bits
echo Windows Update-Cache wurde gelöscht.
pause
goto Menu

:End
echo Programm beendet. Drücke eine beliebige Taste zum Schließen.
pause
exit
