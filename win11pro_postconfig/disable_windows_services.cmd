@echo off

echo Disable various windows services..

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


echo All services are disabled.
pause
