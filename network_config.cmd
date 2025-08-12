@echo off

:: Netzwerkinterface-Name anpassen (z.B. "Ethernet" oder "LAN-Verbindung")
set INTERFACE_NAME="Ethernet"

echo Netzwerk-Optimierungen werden angewendet...

netsh interface ipv4 set dns name=%INTERFACE_NAME% static 192.168.10.14 primary
netsh interface ipv4 add dns name=%INTERFACE_NAME% 1.1.1.1 index=2

:: TCP/IP-Parameter optimieren (wie z.B. TCP Window Scaling, Timestamps, etc.)
netsh int tcp set global autotuninglevel=normal
netsh interface ipv4 set global taskoffload=enabled

echo.
echo Netzwerk-Optimierungen wurden angewendet.
echo.

pause
