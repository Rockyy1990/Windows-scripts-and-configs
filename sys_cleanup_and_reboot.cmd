@echo off

echo Cleaning Windows update files...
dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase /Quiet
echo Cleaned Windows update files successfully.

echo -- Deleting Temp files
del /s /f /q c:\windows\temp\*.*
del /s /f /q C:\WINDOWS\Prefetch

defrag /C /O
powershell "Optimize-Volume -DriveLetter C -ReTrim -Verbose"

:: Notify user and wait 4 seconds
echo The system will reboot in 4 seconds...
timeout /t 4

REM Reboot the system
shutdown /r /t 0