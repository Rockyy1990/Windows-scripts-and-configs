@echo off

echo. 
echo Dieses script erstellt aus dem installierten Windows System ein install.wim Image.
echo Bei Problemen kann /compress:fast verwendet werden. (Auf kosten höheren Speicherbedarfs)
echo Pfad zur install.wim: C:\Images\install.wim
echo.

pause

REM Erstelle ein WIM-Image von installierten Windows System
mkdir D:\Images
dism /capture-image /imagefile:D:\install.wim /capturedir:C:\ /name:"Windows Image" /compress:maximum /checkintegrity /verify /bootable

echo.
echo Das install.wim Image wurde erfolgreich erstellt und überprüft.
pause
