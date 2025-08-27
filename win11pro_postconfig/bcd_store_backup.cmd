@echo off
setlocal

:: Define the backup filename with date for uniqueness
set "backupDir=%~dp0Backup"
set "timestamp=%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%"
set "timestamp=%timestamp: =0%"  :: Replace spaces with zeros for hour

:: Create backup directory if it doesn't exist
if not exist "%backupDir%" (
    mkdir "%backupDir%"
)

set "backupFile=%backupDir%\bcd_backup_%timestamp%.bak"

echo Backing up BCD to "%backupFile%"...
bcdedit /export "%backupFile%"

if %errorlevel% equ 0 (
    echo Backup successful.
) else (
    echo Backup failed.
)

pause
endlocal
