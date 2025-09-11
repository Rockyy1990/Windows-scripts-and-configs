@echo off

echo.
echo Disable various windows services..
echo.

echo Disable Windows Insider Service...
sc config "wisvc" start= disabled
sc stop "wisvc"

echo Disable Windows Search Service...
sc config "WSearch" start= disabled
sc stop "WSearch"

echo Disable Windows Error Reporting Service...
sc config "WerSvc" start= disabled
sc stop "WerSvc"

echo Disable Bitlocker Service...
sc config "BDESVC" start= disabled
sc stop "BDESVC"

echo Disable Windows Biometrie Service..
sc config "WbioSrvc" start= disabled
sc stop "WbioSrvc"

echo Deaktiviere Jugendschutz Service..
sc config "WpcMonSvc" start= disabled
sc stop "WpcMonSvc"

echo Disabling Prefetch
sc stop sysmain
sc config sysmain start=disabled

echo Disable online ms acc login service..
sc stop "wlidsvc"
sc config "wlidsvc" start=disabled


sc config BITS start= delayed-auto
sc config UsoSvc start= delayed-auto
sc config VSS start= demand
sc config Spooler start= demand
sc config TrkWks start= disabled
sc config XblAuthManager start= disabled
sc config XblGameSave start= disabled
sc config XboxGipSvc start= disabled
sc config XboxNetApiSvc start= disabled
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /Disable


echo All done.
pause
