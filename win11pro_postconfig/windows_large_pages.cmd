@echo off

echo # Enable Large Pages for these programs
echo # Add your programs to list
echo # https://forums.guru3d.com/threads/performance-boost-for-most-games.389072/

rem # Use Large Pages
reg add "HKLM\SYSTEM" /v "UseLargePages" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "UseLargePages" /t REG_DWORD /d "1" /f

rem # 0xffffffff = Large Page Support Disabled
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargePageMinimum" /t REG_DWORD /d "0" /f

rem reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f
rem reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cs2.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f
rem reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\hl.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f
rem reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\hl2.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f
rem reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svencoop.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f
rem reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dllhost.exe" /v "UseLargePages" /t REG_DWORD /d "1" /f

PAUSE
