@echo off

:: Change Networkinterface-Name ( "Ethernet" or "LAN-Verbindung")
set INTERFACE_NAME="Ethernet"

rem # Disables MTU Discovery, which auto sets MTU value randomly based on traffic, never enable
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "0" /f


netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent

netsh interface ipv4 set dns name=%INTERFACE_NAME% static 192.168.10.14 primary
netsh interface ipv4 add dns name=%INTERFACE_NAME% 1.1.1.1 index=2

:: TCP/IP-Parameter (TCP Window Scaling, Timestamps, etc.)
netsh int tcp set global autotuninglevel=normal
netsh interface ipv4 set global taskoffload=enabled

echo.
echo Network settings complete.
echo.

pause
