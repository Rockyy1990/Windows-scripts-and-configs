@echo off
setlocal

rem -- Pfade zu den Installationsdateien -- 
rem Annahme: Die Dateien sind im selben Ordner wie diese CMD-Datei

set "current_dir=%~dp0"

rem -- Installiere eine EXE-Datei -- 
rem Beispiel: programm1.exe
if exist "%current_dir%programm1.exe" (
    echo Starte Installation von programm1.exe...
    start /wait "" "%current_dir%programm1.exe" /silent /install
    echo Installation von programm1.exe abgeschlossen.
) else (
    echo programm1.exe nicht gefunden!
)

rem -- Installiere eine MSI-Datei -- 
rem Beispiel: programm2.msi
if exist "%current_dir%programm2.msi" (
    echo Starte Installation von programm2.msi...
    msiexec /i "%current_dir%programm2.msi" /quiet /qn /norestart
    echo Installation von programm2.msi abgeschlossen.
) else (
    echo programm2.msi nicht gefunden!
)

echo Alle Installationen abgeschlossen.
pause
