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
echo -- Update Winget:
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$v = winget -v; if ([version]($v.TrimStart('v')) -lt [version]'1.7.0') { Write-Output 'Old winget version detected, upgrading...'; Set-Location $env:USERPROFILE; Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile 'winget.msixbundle'; Add-AppPackage -ForceApplicationShutdown .\winget.msixbundle; Remove-Item .\winget.msixbundle } else { Write-Output 'Winget is already up to date, skipping upgrade.' }"
echo -- Installing these apps: 
echo -- Mozilla.Firefox 7zip.7zip Valve.Steam PuTTY.PuTTY Microsoft.VCRedist.2015+.x64 AIMP.AIMP Gyan.FFmpeg VideoLAN.VLC Discord.Discord Mozilla.Thunderbird Microsoft.DotNet.DesktopRuntime.8 Notepad++.Notepad++
taskkill /f /im explorer.exe && start explorer.exe && start cmd /k "winget install Mozilla.Firefox 7zip.7zip Valve.Steam PuTTY.PuTTY Microsoft.VCRedist.2015+.x64 AIMP.AIMP Gyan.FFmpeg VideoLAN.VLC Discord.Discord Mozilla.Thunderbird Microsoft.DotNet.DesktopRuntime.8 Notepad++.Notepad++ --accept-source-agreements --accept-package-agreements --force"
:: Pause the script
pause
:: Restore previous environment
endlocal
:: Exit the script
taskkill /f /im explorer.exe & start explorer & exit /b 0