:: WinScript 
@echo off
:: Check if the script is running as admin
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    color 4
    echo This script requires administrator privileges.
    echo Please run WinScript as an administrator.
    pause
    exit
)
:: Admin privileges confirmed, continue execution
setlocal EnableExtensions DisableDelayedExpansion
echo -- Running Disk Clean-up
cleanmgr /verylowdisk /sagerun:5
echo -- Deleting Temp files
del /s /f /q c:\windows\temp\*.*
del /s /f /q C:\WINDOWS\Prefetch
echo -- Clearing Browser History
del /q /s "%LocalAppData%\Google\Chrome\User Data\Default\History"
del /q /s "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*.*"
del /q /s "%LocalAppData%\Google\Chrome\User Data\Default\Cookies"
del /q /s "%LocalAppData%\Microsoft\Edge\User Data\Default\History"
del /q /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*.*"
del /q /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Cookies"
del /q /s "%APPDATA%\Mozilla\Firefox\Profiles\*.default\places.sqlite"
del /q /s "%APPDATA%\Mozilla\Firefox\Profiles\*.default\cache2\entries\*.*"
del /q /s "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\History"
del /q /s "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Cache\*.*"
del /q /s "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Cookies"
:: Pause the script
pause
:: Restore previous environment
endlocal
:: Exit the script
taskkill /f /im explorer.exe & start explorer & exit /b 0