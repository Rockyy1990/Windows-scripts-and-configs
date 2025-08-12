@echo off

echo. 
echo Windows restore health script. (With dism and chkdsk)
echo.
pause

rem # Standard commands to run on Windows systems that are having issues and bugs
rem # /startcomponentcleanup cleans WinSxS directory

DISM /Online /Cleanup-Image /RestoreHealth
dism /online /cleanup-image /startcomponentcleanup

sfc /scannow

chkdsk c: /sdcleanup /offlinescanandfix
chkdsk c: /f /r /x /b

PAUSE
