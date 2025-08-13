rem # Change computer name and Hostname

reg add "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v "ComputerName" /t REG_SZ /d "win11pro" /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v "ComputerName" /t REG_SZ /d "win11pro" /f

reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "Hostname" /t REG_SZ /d "win11pro" /f

reg add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d "win11pro" /f

PAUSE
