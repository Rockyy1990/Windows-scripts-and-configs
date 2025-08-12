@echo off

echo Microsoft Edge wird deinstalliert...

:: Überprüfen, ob das Skript mit Administratorrechten ausgeführt wird
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Bitte das Skript als Administrator ausführen.
    pause
    exit /b
)

winget remove microsoft.edge

echo Deinstallation abgeschlossen.
pause
