@Echo Off
Title Reg Converter v1.2 & Color 1A
cd %systemroot%\system32
call :IsAdmin

Reg.exe delete "HKCR\.txt" /f
Reg.exe add "HKCR\.txt" /v "PerceivedType" /t REG_SZ /d "text" /f
Reg.exe add "HKCR\.txt" /ve /t REG_SZ /d "txtfile" /f
Reg.exe add "HKCR\.txt" /v "Content Type" /t REG_SZ /d "text/plain" /f
Reg.exe add "HKCR\.txt\PersistentHandler" /ve /t REG_SZ /d "{5e941d80-bf96-11cd-b579-08002b30bfeb}" /f
Reg.exe add "HKCR\.txt\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\system32\notepad.exe,-470" /f
Reg.exe add "HKCR\.txt\ShellNew" /v "NullFile" /t REG_SZ /d "" /f
Reg.exe delete "HKCR\txtfile" /f
Reg.exe add "HKCR\txtfile" /v "EditFlags" /t REG_DWORD /d "65536" /f
Reg.exe add "HKCR\txtfile" /ve /t REG_SZ /d "Text Document" /f
Reg.exe add "HKCR\txtfile" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\system32\notepad.exe,-470" /f
Reg.exe add "HKCR\txtfile\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\imageres.dll,-102" /f
Reg.exe add "HKCR\txtfile\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\NOTEPAD.EXE %%1" /f
Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 Pause & Exit
)
Cls
goto:eof
