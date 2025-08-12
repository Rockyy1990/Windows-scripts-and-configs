@echo off
echo Willkommen zum interaktiven DiskPart Skript
echo Bitte folge den Anweisungen sorgfältig.
echo.

:main_menu
echo Bitte wähle eine Option:
echo 1. Zeige alle Laufwerke
echo 2. Wähle Laufwerk zum Bearbeiten
echo 3. Beenden
set /p choice=Gib deine Wahl ein (1-3): 

if "%choice%"=="1" goto list_disks
if "%choice%"=="2" goto select_disk
if "%choice%"=="3" goto end
echo Ungültige Eingabe, bitte versuche es erneut.
pause
goto main_menu

:list_disks
echo Zeige alle Laufwerke:
echo.
diskpart /s list_disks.txt
pause
goto main_menu

:select_disk
set /p disk_number=Bitte gib die Nummer des Laufwerks ein, das du bearbeiten möchtest: 

echo Du hast Laufwerk %disk_number% gewählt.
echo.

echo Möchtest du das Laufwerk löschen? (j/n)
set /p delete_confirm=Antwort: 
if /i "%delete_confirm%"=="j" (
    echo Lösche Laufwerk %disk_number%...
    echo select disk %disk_number% > temp_diskpart.txt
    echo clean >> temp_diskpart.txt
    diskpart /s temp_diskpart.txt
    del temp_diskpart.txt
    echo Laufwerk gelöscht.
)

echo Möchtest du eine Partition erstellen? (j/n)
set /p partition_confirm=Antwort: 
if /i "%partition_confirm%"=="j" (
    set /p size=Gib die Größe der Partition in MB ein: 
    echo select disk %disk_number% > temp_diskpart.txt
    echo create partition primary size=%size% >> temp_diskpart.txt
    echo format fs=ntfs quick >> temp_diskpart.txt
    echo assign >> temp_diskpart.txt
    diskpart /s temp_diskpart.txt
    del temp_diskpart.txt
    echo Partition erstellt und formatiert.
)

pause
goto main_menu

:end
echo Programm beendet. Auf Wiedersehen!
pause
