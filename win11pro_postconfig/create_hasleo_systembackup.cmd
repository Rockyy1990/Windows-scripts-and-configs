@echo off

echo.
echo Hasleo backup service config..
echo.

sc config "HasleoBackupSuiteService" start= demand
sc config "HasleoImageMountService" start= demand
net start "HasleoBackupSuiteService"
net start "HasleoImageMountService"

echo.
echo Creating a System Backup
echo.

start "" /wait "C:\Program Files\Hasleo\Hasleo Backup Suite\bin\BackupMainUI.exe"

echo System Backup is complete.

pause

