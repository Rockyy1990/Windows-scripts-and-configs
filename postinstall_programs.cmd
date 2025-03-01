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
echo -- Installing Chocolatey:
powershell -command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
echo -- Refresh environment: 
call "%ProgramData%\chocolatey\bin\RefreshEnv.cmd"
echo -- Installing these apps: 
echo -- amd-ryzen-chipset firefox steam qbittorrent aimp libreoffice-fresh dotnet notepadplusplus
taskkill /f /im explorer.exe && start explorer.exe && start cmd /k "choco install amd-ryzen-chipset firefox thunderbird 7zip steam vcredist140 qbittorrent backupper-standard partition-assistant-standard aimp discord libreoffice-fresh dotnet notepadplusplus -y --force --ignorepackageexitcodes"
:: Pause the script
pause
:: Restore previous environment
endlocal
:: Exit the script
taskkill /f /im explorer.exe & start explorer & exit /b 0