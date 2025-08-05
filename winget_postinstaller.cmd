@echo off

echo.
echo Install additional programs over winget (Windows Package Manager)
echo Check internet connection before start this script!
echo.

echo This script installs:
echo ------------------------
echo Discord
echo Putty
echo Rufus (USB Tool)
echo WPU (Wise Program Uninstaller)
:: echo Vivaldi Browser
:: echo Firefox Browser
echo SMPlayer
echo Steam Gaming Platform
echo yt-dlp
echo ffmpeg (shared)
echo HandBrake (Video converter)
echo NoMachine RDP
echo qBittorrent
echo NETworkManager
echo -----------------------
echo.

pause

:: Check if winget is installed
where /q winget
if %errorLevel% == 0 (
    echo winget is already installed.
) else (
    echo winget is not installed. Installing winget...
    powershell -Command "Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile $env:TEMP\winget-cli.appxbundle -UseBasicParsing"
    powershell -Command "Add-AppxPackage $env:TEMP\winget-cli.appxbundle"
    echo winget has been installed.
)


echo Installing Discord...
winget install -e --id Discord.Discord -h
echo Discord installation completed.
taskkill /IM "Update.exe" /f
taskkill /IM "Discord.exe" /f

echo Installing Putty...
winget install -e --id PuTTY.PuTTY
echo Putty installation completed.

echo Installing Rufus...
winget install -e --id Rufus.Rufus -h
echo Rufus installation completed.

echo Installing WPU...
winget install -e --id WiseCleaner.WiseProgramUninstaller
echo WPU installation completed.

:: echo Installing Vivaldi Browser...
:: winget install -e --id Vivaldi.Vivaldi
:: echo Vivaldi installation completed.

:: echo Installing Firefox Browser...
:: winget install --id=Mozilla.Firefox -e
:: echo Firefox Browser installation completed.

echo Installing SMPlayer...
winget install -e --id SMPlayer.SMPlayer
echo SMPlayer installation completed.

echo Installing Steam Gaming Platform...
winget install -e --id Valve.Steam
echo Steam Gaming Platform installation completed.

echo Installing yt-dlp...
winget install -e --id yt-dlp.yt-dlp
echo yt-dlp install is complete.

echo Installing ffmpeg (shared)...
winget install -e --id Gyan.FFmpeg.Shared
echo ffmpeg (shared) install is complete.

echo Installing HandBrake...
winget install -e --id HandBrake.HandBrake
echo install HandBrake is now complete.

echo Installing NoMachine RDP...
winget install -e --id NoMachine.NoMachine
echo install NoMachine RDP is complete.

echo Installing qBittorrent...
winget install -e --id qBittorrent.qBittorrent
echo install qBittorrent is complete.

echo Installing NETworkManager...
winget install -e --id BornToBeRoot.NETworkManager
echo install NETworkManager is complete.

echo additional runtimes
winget install -e --id=Microsoft.VCRedist.2012.x86 
winget install -e --id=Microsoft.VCRedist.2012.x64 
winget install -e --id=Microsoft.VCRedist.2013.x86 
winget install -e --id=Microsoft.VCRedist.2013.x64 

echo Upgrade all packages..
winget upgrade --all --force

echo.
echo All programs and runtimes are installed.
echo.

exit /b



