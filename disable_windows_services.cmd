@echo off

echo Deaktiviere Windows Insider Service...
sc config "wisvc" start= disabled
sc stop "wisvc"

echo Deaktiviere Windows Search Service...
sc config "WSearch" start= disabled
sc stop "WSearch"

echo Deaktiviere Windows Error Reporting Service...
sc config "WerSvc" start= disabled
sc stop "WerSvc"

echo Deaktiviere Bitlocker Service...
sc config "BDESVC" start= disabled
sc stop "BDESVC"

echo Deaktiviere Windows Biometrie Service..
sc config "WbioSrvc" start= disabled
sc stop "WbioSrvc"

echo Deaktiviere Jugendschutz Service..
sc config "WpcMonSvc" start= disabled
sc stop "WpcMonSvc"

echo Disabling Prefetch
sc stop sysmain
sc config sysmain start=disabled

echo Alle Dienste wurden deaktiviert.
pause
