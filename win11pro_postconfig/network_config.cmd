@echo off

echo.
echo ..Network settings..
echo IPv4: 192.168.10.14 , DNS: 192.168.10.14
echo This must be changed to the right values based on your router settings
echo DNS can be set to 1.1.1.1 or 8.8.8.8 if you dont wont use the default router dns
echo.
pause

rem Change Networkinterface-Name ( "Ethernet" or "LAN")
set INTERFACE_NAME="Ethernet"

rem Disables MTU Discovery, which auto sets MTU value randomly based on traffic, never enable
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "0" /f


netsh interface ipv4 set subinterface %INTERFACE_NAME%  mtu=1500 store=persistent

netsh interface ip set address name=%INTERFACE_NAME% static 192.168.10.12 255.255.255.0 192.168.10.10

netsh interface ipv4 set dns name=%INTERFACE_NAME% static 192.168.10.14 primary
netsh interface ipv4 add dns name=%INTERFACE_NAME% 1.1.1.1 index=2

rem TCP/IP-Parameter (TCP Window Scaling, Timestamps, etc.)
netsh int tcp set global autotuninglevel=normal
netsh interface ipv4 set global taskoffload=enabled

echo.
echo Network settings complete.
echo.

pause
