@echo off
setlocal enabledelayedexpansion

echo Suche nach .reg Dateien im aktuellen Ordner...

for %%f in (*.reg) do (
    echo Importiere %%f...
    reg import "%%f"
    if errorlevel 1 (
        echo Fehler beim Importieren von %%f
    ) else (
        echo %%f erfolgreich importiert.
    )
)

echo Alle gefundenen .reg Dateien wurden verarbeitet.
pause
