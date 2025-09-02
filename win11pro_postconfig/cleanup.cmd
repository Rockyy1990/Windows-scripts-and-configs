@echo off

echo.
echo Install and config are complete.
pause

echo Cleaning Windows update files...
dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase /Quiet
echo Cleaned Windows update files successfully.

echo -- Deleting Temp files
del /s /f /q c:\windows\temp\*.*
del /s /f /q C:\WINDOWS\Prefetch


rem echo -- Run Wise Disk Cleaner
rem start "" /wait "%ProgramFiles(x86)%\Wise\Wise Disk Cleaner\WiseDiskCleaner.exe" -a -all

rem echo -- Run Wise Registry Cleaner
rem start "" /wait "%ProgramFiles(x86)%\Wise\Wise Registry Cleaner\WiseRegCleaner.exe" -a -all

