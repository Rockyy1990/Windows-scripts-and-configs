@echo off

set BACKUP_DIR=C:\registry_backup
set DATE_STR=%date:~6,4%-%date:~3,2%-%date:~0,2%
set BACKUP_FILE=%BACKUP_DIR%\registry_backup_%DATE_STR%.reg

if not exist "%BACKUP_DIR%" (
    mkdir "%BACKUP_DIR%"
)

echo Creating Registry-Backups...

reg export HKLM "%BACKUP_DIR%\HKLM_%DATE_STR%.reg" /y
reg export HKCU "%BACKUP_DIR%\HKCU_%DATE_STR%.reg" /y
reg export HKCR "%BACKUP_DIR%\HKCR_%DATE_STR%.reg" /y
reg export HKU "%BACKUP_DIR%\HKU_%DATE_STR%.reg" /y
reg export HKCC "%BACKUP_DIR%\HKCC_%DATE_STR%.reg" /y

echo All Registry-Hives are saved into Folder: %BACKUP_DIR%

pause
