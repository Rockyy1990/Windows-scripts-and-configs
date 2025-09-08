@echo off

echo.
echo Windows Sandbox settings--
echo.
pause

Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Sandbox" /v "AllowVideoInput" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Sandbox" /v "AllowVGPU" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Sandbox" /v "AllowPrinterRedirection" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Sandbox" /v "AllowNetworking" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Sandbox" /v "AllowClipboardRedirection" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Sandbox" /v "AllowAudioInput" /t REG_DWORD /d "0" /f