@echo off

echo ---------------------------------------------------------------
echo    Deep System Cleaning
echo ---------------------------------------------------------------

echo Deleting temporary files...
del /q /s /f "%TEMP%\*"
rd /s /q "%TEMP%\*"
echo Deleted temporary files successfully.

echo Cleaning Windows update files...
dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase /Quiet
echo Cleaned Windows update files successfully.

echo Cleaning registry...
reg delete "HKCU\Software\Temp" /f
reg delete "HKLM\Software\Temp" /f
echo Cleaned registry successfully.

echo ---------------------------------------------------------------
echo    Deep system cleaning completed.
echo ---------------------------------------------------------------