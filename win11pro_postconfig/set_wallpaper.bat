@echo off
setlocal

REM Pfad zur Wallpaper-Datei im aktuellen Ordner
set "wallpaper=%~dp0wallpaper.jpg"

REM Zielpfad auf C:\
set "destination=C:\wallpaper.jpg"

REM Registry-Schlüssel für den Desktop-Hintergrund
set "registryKey=HKCU\Control Panel\Desktop"
set "wallpaperValue=Wallpaper"

REM Überprüfen, ob die Quelldatei existiert
if not exist "%wallpaper%" (
    echo Die Datei "%wallpaper%" wurde nicht gefunden.
    goto :end
)

REM Kopieren der Wallpaper-Datei nach C:\
copy /Y "%wallpaper%" "%destination%"
if errorlevel 1 (
    echo Fehler beim Kopieren der Datei nach C:\
    goto :end
)

REM Registry-Eintrag setzen, um den neuen Wallpaper zu verwenden
reg add "%registryKey%" /v "%wallpaperValue%" /t REG_SZ /d "%destination%" /f

REM Desktop aktualisieren
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo Das Wallpaper wurde erfolgreich gesetzt.
:end
