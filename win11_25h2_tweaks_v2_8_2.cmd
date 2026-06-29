@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul

:: ============================================================
:: Windows 11 Pro 25H2 - System Tweaks (v2.8.2)
:: Requires: Administrator privileges
:: ============================================================

:: ANSI via prompt-trick (VT100 nativ ab Win10 1511 / Win11)
for /f %%a in ('"prompt $E & for %%b in (1) do rem"') do set "ESC=%%a"
set "G=%ESC%[92m"
set "Y=%ESC%[93m"
set "R=%ESC%[91m"
set "C=%ESC%[96m"
set "Z=%ESC%[0m"

:: --- Fehler-Counter (wird am Ende ausgegeben) ---------------
set /a ERR_TOTAL=0
set "ERR_LIST="

:: :fail <label> -- Subroutine am Skript-Ende (nach goto :EOF im Hauptfluss)

:: ============================================================
:: Admin-Check via fltmc (kernel-level)
:: --elevated muss Teil des cmd /k Strings sein, nicht separates Argument.
:: Korrekt: cmd /k ""skript.cmd" --elevated" -> ein Befehl mit Argument.
:: ============================================================
fltmc >nul 2>&1
if !errorlevel! neq 0 (
    if "%~1"=="--elevated" (
        echo %R%[FEHLER] Admin-Rechte konnten nicht erlangt werden.%Z%
        echo         Starte das Skript manuell per Rechtsklick "Als Administrator ausfuehren".
        pause
        goto :EOF
    )
    echo %C%[INFO]%Z% Fordere Administratorrechte an...
    where wt.exe >nul 2>&1
    if !errorlevel! equ 0 (
        powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$s='%~f0'; Start-Process wt.exe -ArgumentList @('--','cmd','/k',('"' + $s + '" --elevated')) -Verb RunAs"
    ) else (
        powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$s='%~f0'; Start-Process cmd.exe -ArgumentList ('/k "' + $s + '" --elevated') -Verb RunAs"
    )
    echo %Y%[INFO]%Z% UAC-Abfrage bestaetigen - Skript laeuft im Admin-Terminal weiter.
    goto :EOF
)

title Windows 11 Pro 25H2 Tweaks v2.8.2
echo.
echo %C% Windows 11 Pro 25H2 - System Optimizer v2.8.2%Z%
echo.

:: ============================================================
:: Registry-Backup (alle betroffenen Hives)
:: ============================================================
echo %C%[*]%Z% Erstelle Registry-Backup...
:: PowerShell fuer Zeitstempel (wmic in Win11 25H2 entfernt)
for /f "usebackq" %%t in (`powershell -NoProfile -Command "Get-Date -Format yyyyMMdd_HHmmss"`) do set "_dt=%%t"
set "BACKUP_DIR=%USERPROFILE%\Desktop\RegBackup_!_dt!"
md "!BACKUP_DIR!" >nul 2>&1
:: "HKCU\Control Panel" wuerden den Loop-Token fuer-in() spalten)
reg export "HKLM\SOFTWARE\Microsoft"       "!BACKUP_DIR!\HKLM_SOFTWARE_Microsoft.reg"       /y >nul 2>&1
reg export "HKLM\SOFTWARE\Policies"        "!BACKUP_DIR!\HKLM_SOFTWARE_Policies.reg"        /y >nul 2>&1
reg export "HKLM\SYSTEM\CurrentControlSet" "!BACKUP_DIR!\HKLM_SYSTEM_CurrentControlSet.reg" /y >nul 2>&1
reg export "HKCU\Software"                  "!BACKUP_DIR!\HKCU_Software.reg"                 /y >nul 2>&1
reg export "HKCU\Control Panel"             "!BACKUP_DIR!\HKCU_ControlPanel.reg"             /y >nul 2>&1
reg export "HKCU\System"                    "!BACKUP_DIR!\HKCU_System.reg"                   /y >nul 2>&1
reg export "HKU\.DEFAULT\Control Panel"    "!BACKUP_DIR!\HKU_DEFAULT_ControlPanel.reg"      /y >nul 2>&1
echo   %G%[OK]%Z% Backup unter: !BACKUP_DIR!
echo   %Y%[HINWEIS]%Z% Rollback: reg import "<datei>.reg" als Admin

:: ============================================================
:: 1. Windows Terminal im Kontextmenue
:: ============================================================
echo %C%[*]%Z% [01] Terminal-Kontextmenue...
reg add "HKLM\SOFTWARE\Classes\Directory\Background\shell\TerminalAdmin" /v "MUIVerb" /t REG_SZ /d "Terminal hier als Admin oeffnen" /f >nul 2>&1 || call :fail 01-term-bg-verb
reg add "HKLM\SOFTWARE\Classes\Directory\Background\shell\TerminalAdmin" /v "Icon" /t REG_SZ /d "wt.exe,0" /f >nul 2>&1 || call :fail 01-term-bg-icon
reg add "HKLM\SOFTWARE\Classes\Directory\Background\shell\TerminalAdmin" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1 || call :fail 01-term-bg-lua
reg add "HKLM\SOFTWARE\Classes\Directory\Background\shell\TerminalAdmin\command" /ve /t REG_SZ /d "powershell.exe -WindowStyle Hidden -Command \"Start-Process wt.exe -ArgumentList '-d \"%%V\"' -Verb RunAs\"" /f >nul 2>&1 || call :fail 01-term-bg-cmd
reg add "HKLM\SOFTWARE\Classes\Directory\shell\TerminalAdmin" /v "MUIVerb" /t REG_SZ /d "Terminal hier als Admin oeffnen" /f >nul 2>&1 || call :fail 01-term-dir-verb
reg add "HKLM\SOFTWARE\Classes\Directory\shell\TerminalAdmin" /v "Icon" /t REG_SZ /d "wt.exe,0" /f >nul 2>&1 || call :fail 01-term-dir-icon
reg add "HKLM\SOFTWARE\Classes\Directory\shell\TerminalAdmin" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1 || call :fail 01-term-dir-lua
reg add "HKLM\SOFTWARE\Classes\Directory\shell\TerminalAdmin\command" /ve /t REG_SZ /d "powershell.exe -WindowStyle Hidden -Command \"Start-Process wt.exe -ArgumentList '-d \"%%1\"' -Verb RunAs\"" /f >nul 2>&1 || call :fail 01-term-dir-cmd
echo   %G%[OK]%Z% Terminal-Kontextmenue gesetzt.

:: ============================================================
:: 2. Explorer-Tweaks
:: ============================================================
echo %C%[*]%Z% [02] Explorer-Tweaks...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 02-launch-to
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 02-no-recent
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 02-no-frequent
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowCloudFiles" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 02-no-cloud
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 02-show-ext
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 02-sep-proc
echo   %G%[OK]%Z% Explorer-Tweaks gesetzt.

:: ============================================================
:: 3. Galerie aus Explorer entfernen (CLSID e88865ea)
:: ============================================================
echo %C%[*]%Z% [03] Galerie aus Explorer entfernen...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 03-gal-pin
echo   %G%[OK]%Z% Galerie entfernt.

:: ============================================================
:: 4. OneDrive aus Explorer entfernen (CLSID 018D5C66)
:: ============================================================
echo %C%[*]%Z% [04] OneDrive aus Explorer entfernen...
reg add "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 04-od-x64
reg add "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 04-od-x86
echo   %G%[OK]%Z% OneDrive aus Navigation entfernt.

:: ============================================================
:: 5. "Loeschen" im Kontextmenue (kein Papierkorb)
::    BUG v2.8: || (echo ... %%1 & pause) zeigte literal "%1"
::    da cmd /c STRING kein Parameter-Substitution macht.
::    FIX v2.8.2: Fehler-Fallback entfernt. del/rd allein,
::    cmd-Fenster schliesst sich nach Ausfuehrung automatisch.
::    \"%%1\" -> "%1" in Registry -> Leerzeichen in Pfaden korrekt.
:: ============================================================
echo %C%[*]%Z% [05] Kontextmenue "Loeschen"...
reg add "HKCU\Software\Classes\*\shell\Delete" /ve /t REG_SZ /d "Loeschen" /f >nul 2>&1 || call :fail 05-del-file-verb
reg add "HKCU\Software\Classes\*\shell\Delete" /v "Icon" /t REG_SZ /d "shell32.dll,-240" /f >nul 2>&1 || call :fail 05-del-file-icon
reg add "HKCU\Software\Classes\*\shell\Delete\command" /ve /t REG_SZ /d "cmd.exe /c del /f /q \"%%1\"" /f >nul 2>&1 || call :fail 05-del-file-cmd
reg add "HKCU\Software\Classes\Directory\shell\Delete" /ve /t REG_SZ /d "Loeschen" /f >nul 2>&1 || call :fail 05-del-dir-verb
reg add "HKCU\Software\Classes\Directory\shell\Delete" /v "Icon" /t REG_SZ /d "shell32.dll,-240" /f >nul 2>&1 || call :fail 05-del-dir-icon
reg add "HKCU\Software\Classes\Directory\shell\Delete\command" /ve /t REG_SZ /d "cmd.exe /c rd /s /q \"%%1\"" /f >nul 2>&1 || call :fail 05-del-dir-cmd
echo   %Y%[HINWEIS]%Z% "Loeschen" aktiv - kein Papierkorb.

:: ============================================================
:: 6. Spotlight-Overlay deaktivieren
:: ============================================================
echo %C%[*]%Z% [06] Spotlight-Overlay...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06-rot-screen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06-rot-overlay
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06-sub-338387
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06-sub-338388
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06-cdm-allow
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06-cdm-sub
echo   %G%[OK]%Z% Spotlight-Overlay deaktiviert.

:: ============================================================
:: 6b. Windows-Werbung und App-Vorschlaege deaktivieren
::     DisableWindowsConsumerFeatures: verhindert Store-Kacheln,
::     App-Vorschlaege und Consumer-Features (wichtigster Key).
::     SilentInstalledAppsEnabled: kein Bloatware nach Updates.
::     OemPreInstalledApps/PreInstalledApps: kein App-Reinstall.
::     ShowSyncProviderNotifications: Explorer-OneDrive-Banner.
::     AdvertisingInfo: App-uebergreifende Werbe-ID deaktivieren.
::     TailoredExperiences: keine personalisierten Angebote.
:: ============================================================
echo %C%[*]%Z% [06b] Windows-Werbung und App-Vorschlaege...
:: Wichtigster Policy-Key: Consumer-Features system-weit abschalten
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 06b-consumer-feat
:: ContentDeliveryManager: Bloatware, Vorschlaege, automatische App-Installation
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-silent-apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-oem-apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-pre-apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-pre-apps-ever
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-sys-suggest
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-soft-landing
:: SubscribedContent: Tipps, App-Vorschlaege Startmenue, Spotlight-Feature-Content, Store-Suche
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-sub-tips
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-sub-store
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-sub-suggest
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-sub-spotlight
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-sub-timeline
:: Explorer-Banner und Werbe-ID
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-sync-notif
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 06b-adv-id-pol
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-adv-id-hkcu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 06b-tailored
echo   %G%[OK]%Z% Windows-Werbung, App-Vorschlaege, Consumer-Features und Werbe-ID deaktiviert.

:: ============================================================
:: 7. Laufwerk C: umbenennen
::    label.exe setzt errorlevel nicht zuverlaessig -> best-effort
:: ============================================================
echo %C%[*]%Z% [07] Laufwerk C: umbenennen zu "Windows"...
label C: Windows
if !errorlevel! neq 0 (
    echo   %Y%[WARNUNG]%Z% Umbenennung fehlgeschlagen.
) else (
    echo   %G%[OK]%Z% Laufwerk C: heisst jetzt "Windows".
)

:: ============================================================
:: 8. Telemetrie deaktivieren
::    AllowTelemetry=0 = Security only (Win11 Pro unterstuetzt Wert 0)
:: ============================================================
echo %C%[*]%Z% [08] Telemetrie deaktivieren...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 08-tel-pol
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 08-tel-cur
reg add "HKCU\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 08-tel-hkcu
net stop DiagTrack /y >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1 || call :fail 08-diagtrack-dis
:: dmwappushservice: Trigger-Start-Dienst, läuft auf Frischinstall nie -> net stop schlägt immer fehl -> nur sc config
sc config dmwappushservice start= disabled >nul 2>&1 || call :fail 08-dmwapp-dis
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 08-autologger
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1 || call :fail 08-task-appraiser
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1 || call :fail 08-task-pdupdate
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1 || call :fail 08-task-ceip
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1 || call :fail 08-task-diskdiag
:: Kanalname in 25H2 verifiziert: "Microsoft-Windows-Application-Experience/Program-Telemetry" existiert
wevtutil sl "Microsoft-Windows-Application-Experience/Program-Telemetry" /e:false >nul 2>&1 || call :fail 08-wevt-appexp
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f >nul 2>&1 || call :fail 08-spynet-consent
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 08-spynet-report
echo   %G%[OK]%Z% Telemetrie deaktiviert.

:: ============================================================
:: 9. Neueste CLR erzwingen
:: ============================================================
echo %C%[*]%Z% [09] CLR: Erzwinge neueste Version...
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework" /v "OnlyUseLatestCLR" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 09-clr-x64
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework" /v "OnlyUseLatestCLR" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 09-clr-x86
:: v2.0.50727-Keys existieren nur wenn .NET 3.5 (optionales Feature) installiert -> kein :fail
reg add "HKLM\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /v "OnlyUseLatestCLR" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727" /v "OnlyUseLatestCLR" /t REG_DWORD /d 1 /f >nul 2>&1
echo   %G%[OK]%Z% CLR auf neueste Version gesetzt.

:: ============================================================
:: 10. Bluetooth optimieren
::     bthserv/BluetoothUserService: nur vorhanden wenn BT-Adapter installiert.
::     Frischinstall ohne BT -> sc config schlägt fehl -> kein :fail (erwartet).
::     BluetoothUserService: Template-Dienst (_XXXXX Suffix für Instanzen)
::     -> sc config greift nur auf Template, nicht auf laufende Instanz.
:: ============================================================
echo %C%[*]%Z% [10] Bluetooth optimieren...
sc config bthserv start= auto >nul 2>&1
sc config BluetoothUserService start= auto >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters" /v "DisableAbsoluteVolume" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 10-abs-vol
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters" /v "FastConnectNumRetries" /t REG_DWORD /d 3 /f >nul 2>&1 || call :fail 10-fast-retry
:: Set-NetAdapterPowerManagement: korrekt; Disable-NetAdapterPowerManagement existiert nicht
powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand RwBlAHQALQBOAGUAdABBAGQAYQBwAHQAZQByACAAfAAgAFcAaABlAHIAZQAtAE8AYgBqAGUAYwB0ACAAewAgACQAXwAuAEkAbgB0AGUAcgBmAGEAYwBlAEQAZQBzAGMAcgBpAHAAdABpAG8AbgAgAC0AbQBhAHQAYwBoACAAJwBCAGwAdQBlAHQAbwBvAHQAaAAnACAAfQAgAHwAIABGAG8AcgBFAGEAYwBoAC0ATwBiAGoAZQBjAHQAIAB7ACAAdAByAHkAIAB7ACAAUwBlAHQALQBOAGUAdABBAGQAYQBwAHQAZQByAFAAbwB3AGUAcgBNAGEAbgBhAGcAZQBtAGUAbgB0ACAALQBOAGEAbQBlACAAJABfAC4ATgBhAG0AZQAgAC0AQQByAHAATwBmAGYAbABvAGEAZAAgAEQAaQBzAGEAYgBsAGUAZAAgAC0ATgBTAE8AZgBmAGwAbwBhAGQAIABEAGkAcwBhAGIAbABlAGQAIAAtAFcAYQBrAGUATwBuAE0AYQBnAGkAYwBQAGEAYwBrAGUAdAAgAEQAaQBzAGEAYgBsAGUAZAAgAC0AVwBhAGsAZQBPAG4AUABhAHQAdABlAHIAbgAgAEQAaQBzAGEAYgBsAGUAZAAgAC0ARQByAHIAbwByAEEAYwB0AGkAbwBuACAAUwBpAGwAZQBuAHQAbAB5AEMAbwBuAHQAaQBuAHUAZQAgAH0AIABjAGEAdABjAGgAIAB7AH0AIAB9AA== >nul 2>&1 || call :fail 10-bt-power-mgmt
echo   %G%[OK]%Z% Bluetooth optimiert.

:: ============================================================
:: 11. Hintergrunddienste konfigurieren
::     WbioSrvc: deaktiviert Fingerabdruck/Gesicht, NICHT PIN
::     (PIN nutzt NgcCtnrSvc/TPM). Nur setzen wenn biometrie-los.
::     WerSvc/SysMain/Spooler: Manual statt Disabled -> bei Bedarf
::     startbar (Crash-Reporting, Print-to-PDF).
:: ============================================================
echo %C%[*]%Z% [11] Hintergrunddienste konfigurieren...
:: WerSvc/RemoteRegistry: auf Frischinstall bereits gestoppt -> net stop schlägt legitim fehl -> kein :fail
net stop WerSvc /y >nul 2>&1
sc config WerSvc start= demand >nul 2>&1 || call :fail 11-wer-dis
net stop WbioSrvc /y >nul 2>&1 || call :fail 11-wbio-stop
sc config WbioSrvc start= disabled >nul 2>&1 || call :fail 11-wbio-dis
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 11-wbio-pol
sc config SysMain start= demand >nul 2>&1 || call :fail 11-sysmain
net stop RemoteRegistry /y >nul 2>&1
sc config RemoteRegistry start= disabled >nul 2>&1 || call :fail 11-remreg-dis
sc config Spooler start= demand >nul 2>&1 || call :fail 11-spooler
echo   %Y%[HINWEIS]%Z% WbioSrvc (Windows Hello Biometrie) deaktiviert. PIN bleibt funktionsfaehig.
echo   %G%[OK]%Z% WerSvc, SysMain, Spooler auf Manual - RemoteRegistry deaktiviert.

:: ============================================================
:: 12. Performance und Audio-Latenzen
::     Win32PrioritySeparation 0x26 = kurze variable Intervalle, 2x Vordergrundboost
::     Games-Task: GPU Priority=8, Priority=6, Scheduling=High
:: ============================================================
echo %C%[*]%Z% [12] Performance und Audio-Latenzen...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1 || call :fail 12-prio-sep
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1 || call :fail 12-net-throttle
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 12-sys-resp
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1 || call :fail 12-audio-sched
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1 || call :fail 12-audio-sfio
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1 || call :fail 12-audio-prio
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1 || call :fail 12-games-sched
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1 || call :fail 12-games-sfio
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1 || call :fail 12-games-prio
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1 || call :fail 12-games-gpu
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1 || call :fail 12-games-bg
echo   %G%[OK]%Z% Performance, Audio- und Games-Latenz gesetzt.

:: ============================================================
:: 13. SMB
::     sc config mrxsmb10 entfernt: DISM deaktiviert den Treiber
::     vollstaendig, sc config waere danach wirkungslos.
::     AllowInsecureGuestAuth=1: Gastzugriff fuer NAS/Drucker im LAN
:: ============================================================
echo %C%[*]%Z% [13] SMB konfigurieren...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 13-smb1-reg
dism /online /disable-feature /featurename:SMB1Protocol /norestart /quiet >nul 2>&1 || call :fail 13-smb1-dism
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" /v "AllowInsecureGuestAuth" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 13-guest-auth
echo   %G%[OK]%Z% SMBv1 deaktiviert, Gast-Auth erlaubt.

:: ============================================================
:: 14. Login-Bildschirm
:: ============================================================
echo %C%[*]%Z% [14] Login-Bildschirm...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 14-no-lockscreen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableAcrylicOnLaunch" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 14-no-acrylic
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableLogonBackgroundImage" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 14-no-bg-image
echo   %G%[OK]%Z% Lockscreen und Blur deaktiviert.

:: ============================================================
:: 15. Pro-Tweaks (Bing, NTFS, Shutdown-Timeouts)
:: ============================================================
echo %C%[*]%Z% [15] Pro-Tweaks...
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 15-no-search-sugg
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 15-no-bing
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 15-ntfs-8dot3
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 15-ntfs-lastaccess
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 15-no-news
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "2000" /f >nul 2>&1 || call :fail 15-hung-app
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f >nul 2>&1 || call :fail 15-kill-app
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f >nul 2>&1 || call :fail 15-kill-svc
echo   %G%[OK]%Z% Pro-Tweaks angewendet.

:: ============================================================
:: 16. Visuelle Effekte reduzieren
::     UserPreferencesMask 90 12 03 80 10 00 00 00 = Performance-Modus
:: ============================================================
echo %C%[*]%Z% [16] Visuelle Effekte...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1 || call :fail 16-vfx-setting
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul 2>&1 || call :fail 16-min-animate
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9012038010000000 /f >nul 2>&1 || call :fail 16-user-pref-mask
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 16-no-transparency
echo   %G%[OK]%Z% Animationen und Transparenz reduziert.

:: ============================================================
:: 17. CPU-Mitigations: Retpoline aktivieren
::     FeatureSettingsOverride 0x48 = Retpoline(bit6) + SSB-Mitigation aus(bit3)
::     Spectre v2 + Meltdown bleiben aktiv (Mask=3)
:: ============================================================
echo %C%[*]%Z% [17] CPU-Mitigations (Retpoline)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 72 /f >nul 2>&1 || call :fail 17-retpoline
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >nul 2>&1 || call :fail 17-retpoline-mask
echo   %Y%[HINWEIS]%Z% Retpoline aktiv - Spectre v2 geschuetzt, SSB-Mitigation deaktiviert.

:: ============================================================
:: 18. TCP/IP-Stack (Pi-hole-kompatibel)
::     MaxCacheTtl: GELOESCHT (Pi-hole cached selbst; TTL=1 war
::     Hauptursache fuer Ladeverspaetung bei CDN-lastigen Seiten).
::     DoHPolicy: GELOESCHT -> Windows-Default (Allow=2).
::     Pi-hole ist kein DoH-Endpunkt; Policy=1/3 bricht Internet.
::     MaxNegativeCacheTtl=0: Pi-hole antwortet mit 0.0.0.0 (kein
::     NXDOMAIN) -> negativer Cache sinnlos.
::     LLMNR (UDP/5355) und mDNS (UDP/5353) deaktiviert.
::     DisableSmartNameResolution=1: sperrt LLMNR/mDNS-Fallback.
::     NetBIOS NodeType=2 (P-Node): kein Broadcast, nur Unicast.
:: ============================================================
echo %C%[*]%Z% [18] Netzwerk-Stack (Pi-hole-kompatibel)...
netsh int tcp set global autotuninglevel=normal >nul 2>&1 || call :fail 18-tcp-autotune
netsh int tcp set global rss=enabled >nul 2>&1 || call :fail 18-tcp-rss
netsh int tcp set global ecncapability=enabled >nul 2>&1 || call :fail 18-tcp-ecn
netsh int tcp set global initialrto=2000 >nul 2>&1 || call :fail 18-tcp-rto
netsh interface teredo set state disabled >nul 2>&1 || call :fail 18-teredo-off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 18-no-llmnr
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "EnableMDNS" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 18-no-mdns
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "DisableSmartNameResolution" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 18-no-smartname
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheTtl" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxNegativeCacheTtl" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 18-neg-cache-ttl
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "ServerPriorityTimeLimit" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 18-srv-prio-limit
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "DoHPolicy" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NodeType" /t REG_DWORD /d 2 /f >nul 2>&1 || call :fail 18-netbios-pnode
echo   %G%[OK]%Z% TCP/IP-Stack optimiert (Pi-hole-kompatibel).

:: ============================================================
:: 19. Sicherheits-Haertung
:: ============================================================
echo %C%[*]%Z% [19] Sicherheits-Haertung...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul 2>&1 || call :fail 19-no-autorun-hklm
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul 2>&1 || call :fail 19-no-autorun-hkcu
reg add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 19-no-wsh
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /v "WpadOverride" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 19-wpad-override
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "AutoDetect" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 19-wpad-autodetect
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "LmCompatibilityLevel" /t REG_DWORD /d 5 /f >nul 2>&1 || call :fail 19-ntlmv2
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Printers" /v "RegisterSpoolerRemoteRpcEndPoint" /t REG_DWORD /d 2 /f >nul 2>&1 || call :fail 19-spooler-rpc
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 19-no-websearch
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 19-no-conn-search
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 19-no-conn-metered
:: ASR-Regeln: Erfordert Defender Echtzeitschutz; bei Drittanbieter-AV wirkungslos
powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand dAByAHkAIAB7ACAAQQBkAGQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0AQQB0AHQAYQBjAGsAUwB1AHIAZgBhAGMAZQBSAGUAZAB1AGMAdABpAG8AbgBSAHUAbABlAHMAXwBJAGQAcwAgAEQANABGADkANAAwAEEAQgAtADQAMAAxAEIALQA0AEUARgBDAC0AQQBBAEQAQwAtAEEARAA1AEYAMwBDADUAMAA2ADgAOABBACwAMwBCADUANwA2ADgANgA5AC0AQQA0AEUAQwAtADQANQAyADkALQA4ADUAMwA2AC0AQgA4ADAAQQA3ADcANgA5AEUAOAA5ADkALAA1AEIARQBCADcARQBGAEUALQBGAEQAOQBBAC0ANAA1ADUANgAtADgAMAAxAEQALQAyADcANQBFADUARgBGAEMAMAA0AEMAQwAgAC0AQQB0AHQAYQBjAGsAUwB1AHIAZgBhAGMAZQBSAGUAZAB1AGMAdABpAG8AbgBSAHUAbABlAHMAXwBBAGMAdABpAG8AbgBzACAARQBuAGEAYgBsAGUAZAAsAEUAbgBhAGIAbABlAGQALABFAG4AYQBiAGwAZQBkACAALQBFAHIAcgBvAHIAQQBjAHQAaQBvAG4AIABTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlACAAfQAgAGMAYQB0AGMAaAAgAHsAfQA= >nul 2>&1 || call :fail 19-asr-rules
echo   %G%[OK]%Z% Sicherheits-Haertung angewendet.

:: ============================================================
:: 20. Windows Update: kein Zwangs-Neustart, LAN-P2P, keine Treiber
:: ============================================================
echo %C%[*]%Z% [20] Windows Update-Verhalten...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 20-no-autoreboot
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursStart" /t REG_DWORD /d 6 /f >nul 2>&1 || call :fail 20-active-start
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ActiveHoursEnd" /t REG_DWORD /d 23 /f >nul 2>&1 || call :fail 20-active-end
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 20-do-lan-only
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 20-no-wu-drivers
echo   %G%[OK]%Z% Update konfiguriert (kein Zwangs-Reboot, LAN-only P2P, keine Treiber).

:: ============================================================
:: 21. Memory Management
::     DisablePagingExecutive=1: Kernel im RAM halten (ab 8 GB RAM)
:: ============================================================
echo %C%[*]%Z% [21] Memory Management...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 21-no-clear-pf
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 21-no-large-cache
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 21-no-page-exec
echo   %Y%[HINWEIS]%Z% DisablePagingExecutive aktiv - empfohlen ab 8 GB RAM.

:: ============================================================
:: 22. Energieplan: Ultimative Leistung
::     /duplicatescheme parst letztes Token -> locale-unabhaengig.
::     Fallback via /list wenn Schema bereits existiert.
:: ============================================================
echo %C%[*]%Z% [22] Energieplan: Ultimative Leistung...
set "ULTIMATE_GUID="
for /f "tokens=*" %%a in ('powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2^>nul') do (
    for %%b in (%%a) do set "ULTIMATE_GUID=%%b"
)
if not defined ULTIMATE_GUID (
    :: /list output: "Energiesparplan: GUID  (Name)" -> Token 2 nach ":" = GUID + Rest
    :: Innerer for /f tokens=1: erstes Wort = die GUID
    for /f "tokens=2 delims=:" %%a in ('powercfg /list 2^>nul ^| findstr /i "e9a42b02"') do (
        for /f "tokens=1" %%b in ("%%a") do set "ULTIMATE_GUID=%%b"
    )
)
if defined ULTIMATE_GUID (
    powercfg /setactive !ULTIMATE_GUID! >nul 2>&1
    echo   %G%[OK]%Z% Ultimativer Leistungsplan aktiviert.
) else (
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
    echo   %Y%[HINWEIS]%Z% Ultimativer Plan nicht verfuegbar - Hohe Leistung aktiviert.
)

:: ============================================================
:: 23. Prefetch/ReadyBoot (SSD-Erkennung via CIM)
::     Fix v2.6.8 -> v2.7: .Substring(0,1) statt (0,2) -> sauberer Laufwerksbuchstabe.
::     -First 1 + explizites DeviceId-eq-diskNum verhindert Array-Vergleich.
:: ============================================================
echo %C%[*]%Z% [23] Prefetch/ReadyBoot (SSD-Erkennung)...
powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand JABiAG8AbwB0AEwAZQB0AHQAZQByACAAPQAgACgARwBlAHQALQBDAGkAbQBJAG4AcwB0AGEAbgBjAGUAIABXAGkAbgAzADIAXwBCAG8AbwB0AEMAbwBuAGYAaQBnAHUAcgBhAHQAaQBvAG4AKQAuAEIAbwBvAHQARABpAHIAZQBjAHQAbwByAHkALgBTAHUAYgBzAHQAcgBpAG4AZwAoADAALAAxACkAOwAgACQAZABpAHMAawBOAHUAbQAgAD0AIAAoAEcAZQB0AC0AUABhAHIAdABpAHQAaQBvAG4AIAB8ACAAVwBoAGUAcgBlAC0ATwBiAGoAZQBjAHQAIAB7ACAAJABfAC4ARAByAGkAdgBlAEwAZQB0AHQAZQByACAALQBlAHEAIAAkAGIAbwBvAHQATABlAHQAdABlAHIAIAB9ACAAfAAgAEcAZQB0AC0ARABpAHMAawAgAHwAIABTAGUAbABlAGMAdAAtAE8AYgBqAGUAYwB0ACAALQBFAHgAcABhAG4AZABQAHIAbwBwAGUAcgB0AHkAIABOAHUAbQBiAGUAcgAgAC0ARgBpAHIAcwB0ACAAMQApADsAIAAkAGQAaQBzAGsAIAA9ACAARwBlAHQALQBQAGgAeQBzAGkAYwBhAGwARABpAHMAawAgAHwAIABXAGgAZQByAGUALQBPAGIAagBlAGMAdAAgAHsAIAAkAF8ALgBEAGUAdgBpAGMAZQBJAGQAIAAtAGUAcQAgACQAZABpAHMAawBOAHUAbQAgAH0AOwAgAGkAZgAgACgAJABkAGkAcwBrACAALQBhAG4AZAAgACQAZABpAHMAawAuAE0AZQBkAGkAYQBUAHkAcABlACAALQBlAHEAIAAnAFMAUwBEACcAKQAgAHsAIAAkAHAAIAA9ACAAJwBIAEsATABNADoAXABTAFkAUwBUAEUATQBcAEMAdQByAHIAZQBuAHQAQwBvAG4AdAByAG8AbABTAGUAdABcAEMAbwBuAHQAcgBvAGwAXABTAGUAcwBzAGkAbwBuACAATQBhAG4AYQBnAGUAcgBcAE0AZQBtAG8AcgB5ACAATQBhAG4AYQBnAGUAbQBlAG4AdABcAFAAcgBlAGYAZQB0AGMAaABQAGEAcgBhAG0AZQB0AGUAcgBzACcAOwAgAFMAZQB0AC0ASQB0AGUAbQBQAHIAbwBwAGUAcgB0AHkAIAAkAHAAIABFAG4AYQBiAGwAZQBQAHIAZQBmAGUAdABjAGgAZQByACAAMAA7ACAAUwBlAHQALQBJAHQAZQBtAFAAcgBvAHAAZQByAHQAeQAgACQAcAAgAEUAbgBhAGIAbABlAFMAdQBwAGUAcgBmAGUAdABjAGgAIAAwACAAfQA= >nul 2>&1 || call :fail 23-prefetch-ssd
echo   %G%[OK]%Z% Prefetch: SSD-Erkennung und Anpassung ausgefuehrt.

:: ============================================================
:: 24. Cortana, Copilot und Windows-AI deaktivieren
::     SearchUI-Task in 25H2 nicht mehr vorhanden -> schtasks
::     schlaegt still fehl, kein Problem.
::     Recall: Feature-on-Demand in 25H2, standardmaessig NICHT
::     installiert. AllowRecallEnablement=0 sperrt Policy dauerhaft.
::     RemoveMicrosoftCopilotApp (ab KB5083769): greift nur wenn
::     App 28 Tage ungenutzt -> zusaetzlich zu UI/Policy-Sperren.
:: ============================================================
echo %C%[*]%Z% [24] Cortana, Copilot und Windows-AI...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 24-no-cortana
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 24-no-copilot-btn
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-copilot-pol-hklm
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-copilot-pol-hkcu
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-no-ai-analysis
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "AllowRecallEnablement" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 24-no-recall
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableClickToDo" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-no-click-to-do
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableCocreator" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-no-cocreator
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableImageCreator" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-no-imgcreator
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableGenerativeFill" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-no-genfill
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v "RemoveMicrosoftCopilotApp" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-rm-copilot-hkcu
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "RemoveMicrosoftCopilotApp" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 24-rm-copilot-hklm
echo   %G%[OK]%Z% Cortana, Copilot, Recall, ClickToDo, Paint-AI deaktiviert.

:: ============================================================
:: 25. Taskleiste bereinigen
::     SearchboxTaskbarMode: 0=aus, 1=Icon, 2=Suchfeld, 3=Vollfeld
:: ============================================================
echo %C%[*]%Z% [25] Taskleiste bereinigen...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 25-no-meet-now
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 25-no-task-view
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 25-no-widgets
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 25-search-icon
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceButtonDesiredVisibility" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 25-no-pen-btn
echo   %G%[OK]%Z% Taskleiste bereinigt.

:: ============================================================
:: 26. Hardware-accelerated GPU Scheduling (HAGS)
::     HwSchMode=2: HAGS aktiv. Erfordert WDDM 2.7+ Treiber.
:: ============================================================
echo %C%[*]%Z% [26] Hardware GPU Scheduling (HAGS)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1 || call :fail 26-hags
echo   %G%[OK]%Z% HAGS aktiviert (WDDM 2.7+ erforderlich, greift nach Neustart).

:: ============================================================
:: 27. Xbox Game DVR / Game Bar deaktivieren
::     XblGameSave/XboxNetApiSvc: abhängig von Gaming Services AppX-Paket.
::     Auf Frischinstall können Dienste fehlen -> net stop kein :fail (erwartet).
::     sc config schlägt nur fehl wenn Registry-Key fehlt (Dienst komplett absent).
:: ============================================================
echo %C%[*]%Z% [27] Xbox Game DVR / Game Bar...
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 27-dvr-off
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f >nul 2>&1 || call :fail 27-dvr-fse
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 27-dvr-honor-fse
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 27-dvr-pol
net stop XblGameSave /y >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1 || call :fail 27-xbl-save-dis
net stop XboxNetApiSvc /y >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1 || call :fail 27-xbox-net-dis
echo   %G%[OK]%Z% Game DVR und Xbox-Dienste deaktiviert.

:: ============================================================
:: 28. Maus-Beschleunigung deaktivieren (Enhance Pointer Precision)
:: ============================================================
echo %C%[*]%Z% [28] Maus-Beschleunigung...
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1 || call :fail 28-mouse-speed
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1 || call :fail 28-mouse-thresh1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1 || call :fail 28-mouse-thresh2
echo   %G%[OK]%Z% Enhance Pointer Precision deaktiviert.

:: ============================================================
:: 29. Hibernation und Fast Startup deaktivieren
::     HiberbootEnabled=0 deaktiviert Fast Startup unabhaengig
::     von powercfg. Beide Methoden kombiniert fuer Sicherheit.
:: ============================================================
echo %C%[*]%Z% [29] Hibernation und Fast Startup...
powercfg /hibernate off >nul 2>&1 || call :fail 29-hibernate-off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 29-hiberboot
echo   %Y%[HINWEIS]%Z% Hibernation deaktiviert - hiberfil.sys entfernt, Fast Startup aus.

:: ============================================================
:: 30. Defragmentierung deaktivieren, TRIM sicherstellen
::     ScheduledDefrag deaktiviert auf SSD auch den Retrim-Lauf
::     -> eigenen schlanken Retrim-Task anlegen (defrag /L nur).
::     DisableDeleteNotify=0: TRIM aktiv halten.
:: ============================================================
echo %C%[*]%Z% [30] Defragmentierung / TRIM / Retrim...
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /Disable >nul 2>&1 || call :fail 30-no-defrag
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1 || call :fail 30-trim-on
:: /L = RetrimOnly; C: explizit statt /C (alle Volumes) - verhindert Retrim auf USB-Drives
schtasks /Create /TN "WeeklyRetrim" /TR "%SystemRoot%\System32\defrag.exe C: /L" /SC WEEKLY /D SUN /ST 03:00 /RL HIGHEST /RU SYSTEM /F >nul 2>&1 || call :fail 30-retrim-task
echo   %G%[OK]%Z% Auto-Defrag aus, TRIM aktiv, woechentlicher Retrim-Task angelegt.

:: ============================================================
:: 31. UAC haerten
::     PromptOnSecureDesktop=0: kein Abdunkeln auf Secure Desktop.
::     WICHTIG: ConsentUX liest den Wert erst beim naechsten Login/Reboot.
:: ============================================================
echo %C%[*]%Z% [31] UAC-Haertung...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 31-uac-enable
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 2 /f >nul 2>&1 || call :fail 31-uac-prompt
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 31-uac-no-secure-dt
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableVirtualization" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 31-uac-virt
echo   %G%[OK]%Z% UAC aktiv, Secure-Desktop-Abdunkelung deaktiviert.
echo   %Y%[HINWEIS]%Z% Wirkt erst nach Abmelden/Neustart.

:: ============================================================
:: 32. Speicherintegritaet (HVCI) aktivieren
::     WARNUNG: inkompatible Alttreiber -> Boot-Fehler moeglich.
::     Pruefen: msinfo32 > Geraeteschutz.
::     Gaming-Kontext: 5-10% FPS-Einbussen moeglich (1%-Lows).
::     Bei Performance-Priorisierung diese Sektion auskommentieren.
:: ============================================================
echo %C%[*]%Z% [32] Speicherintegritaet (HVCI)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 32-hvci
echo   %Y%[HINWEIS]%Z% HVCI aktiviert - greift nach Neustart. Alttreiber vorher pruefen.

:: ============================================================
:: 33. Clipboard Cloud-Sync deaktivieren
:: ============================================================
echo %C%[*]%Z% [33] Clipboard-Datenschutz...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowClipboardHistory" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 33-no-clip-hist
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowCrossDeviceClipboard" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 33-no-cross-clip
reg add "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 33-clip-hkcu
echo   %G%[OK]%Z% Clipboard Cloud-Sync deaktiviert.

:: ============================================================
:: 34. Aktivitaetenverlauf (Timeline) deaktivieren
::     In 25H2 UI-seitig entfernt, Datensammlung laeuft ohne Policy
:: ============================================================
echo %C%[*]%Z% [34] Aktivitaetenverlauf (Timeline)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 34-no-activity
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 34-no-pub-act
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 34-no-upload-act
echo   %G%[OK]%Z% Aktivitaetenverlauf deaktiviert.

:: ============================================================
:: 35. Storage Sense deaktivieren
:: ============================================================
echo %C%[*]%Z% [35] Storage Sense...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 35-storage-sense
echo   %G%[OK]%Z% Storage Sense deaktiviert.

:: ============================================================
:: 36. BitLocker deaktivieren
::     manage-bde -off entschluesselt vorhandene Volumes (Hintergrund).
::     PreventDeviceEncryption: primaerer Policy-Riegel.
::     DISM: kein :fail - Feature auf Frischinstall oft nicht vorhanden.
:: ============================================================
echo %C%[*]%Z% [36] BitLocker deaktivieren...
manage-bde -off C: >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\BitLocker" /v "PreventDeviceEncryption" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 36-no-bitlocker-pol
:: DISM: Feature oft nicht installiert -> kein :fail (erwartet auf Frischinstall)
dism /online /disable-feature /featurename:BitLocker /norestart /quiet >nul 2>&1
dism /online /disable-feature /featurename:BitLocker-Utilities /norestart /quiet >nul 2>&1
echo   %Y%[HINWEIS]%Z% BitLocker deaktiviert - Entschluesselung von C: laeuft ggf. im Hintergrund weiter.

:: ============================================================
:: 37. ReadyBoost deaktivieren
::     EMDMgmt-Policy: verhindert Wechseldatentraeger als Cache.
:: ============================================================
echo %C%[*]%Z% [37] ReadyBoost...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EMDMgmt" /v "DisableEMD" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 37-readyboost
echo   %G%[OK]%Z% ReadyBoost deaktiviert.

:: ============================================================
:: 38. Explorer: Datums-Gruppierung deaktivieren
::     NoDateGrouping=1: kein "Heute/Gestern/Letzte Woche" in Listen.
::     Sortierreihenfolge (pro Ordner gespeichert) bleibt unveraendert.
:: ============================================================
echo %C%[*]%Z% [38] Explorer: Datums-Gruppierung...
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "NoDateGrouping" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 38-no-date-group
echo   %G%[OK]%Z% Datums-Gruppierung deaktiviert.

:: ============================================================
:: 39. Windows-Logo beim Boot ausblenden
::     bootuxdisabled: wirkt auf {current} (aktiver Bootloader-Eintrag).
:: ============================================================
echo %C%[*]%Z% [39] Windows-Logo beim Boot...
bcdedit /set {current} bootuxdisabled true >nul 2>&1
if !errorlevel! neq 0 (
    echo   %Y%[WARNUNG]%Z% bcdedit fehlgeschlagen - Logo bleibt sichtbar.
) else (
    echo   %G%[OK]%Z% Boot-Logo deaktiviert.
)

:: ============================================================
:: 40. Klassisches Kontextmenue erzwingen (Win11)
::     Leere InprocServer32 taeuscht fehlende COM-Implementierung vor
::     -> Explorer faellt auf vollstaendiges Win10-Menue zurueck.
:: ============================================================
echo %C%[*]%Z% [40] Klassisches Kontextmenue...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1 || call :fail 40-classic-ctx
echo   %G%[OK]%Z% Klassisches Kontextmenue aktiv.

:: ============================================================
:: 41. Nagle-Algorithmus deaktivieren
::     TcpAckFrequency/TCPNoDelay: pro Netzwerk-Interface unter
::     dynamischem GUID-Schluessel -> zur Laufzeit fuer alle IPv4-
::     Interfaces gesetzt statt fest verdrahtet.
:: ============================================================
echo %C%[*]%Z% [41] Nagle-Algorithmus deaktivieren...
powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand JABiAGEAcwBlACAAPQAgACcASABLAEwATQA6AFwAUwBZAFMAVABFAE0AXABDAHUAcgByAGUAbgB0AEMAbwBuAHQAcgBvAGwAUwBlAHQAXABTAGUAcgB2AGkAYwBlAHMAXABUAGMAcABpAHAAXABQAGEAcgBhAG0AZQB0AGUAcgBzAFwASQBuAHQAZQByAGYAYQBjAGUAcwAnADsAIABHAGUAdAAtAEMAaABpAGwAZABJAHQAZQBtACAAJABiAGEAcwBlACAALQBFAHIAcgBvAHIAQQBjAHQAaQBvAG4AIABTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlACAAfAAgAEYAbwByAEUAYQBjAGgALQBPAGIAagBlAGMAdAAgAHsAIAB0AHIAeQAgAHsAIABpAGYAIAAoAEcAZQB0AC0ASQB0AGUAbQBQAHIAbwBwAGUAcgB0AHkAIAAtAFAAYQB0AGgAIAAkAF8ALgBQAFMAUABhAHQAaAAgAC0ATgBhAG0AZQAgAEQAaABjAHAASQBQAEEAZABkAHIAZQBzAHMALABJAFAAQQBkAGQAcgBlAHMAcwAgAC0ARQByAHIAbwByAEEAYwB0AGkAbwBuACAAUwBpAGwAZQBuAHQAbAB5AEMAbwBuAHQAaQBuAHUAZQApACAAewAgAFMAZQB0AC0ASQB0AGUAbQBQAHIAbwBwAGUAcgB0AHkAIAAtAFAAYQB0AGgAIAAkAF8ALgBQAFMAUABhAHQAaAAgAC0ATgBhAG0AZQAgAFQAYwBwAEEAYwBrAEYAcgBlAHEAdQBlAG4AYwB5ACAALQBWAGEAbAB1AGUAIAAxACAALQBUAHkAcABlACAARABXAG8AcgBkACAALQBGAG8AcgBjAGUAOwAgAFMAZQB0AC0ASQB0AGUAbQBQAHIAbwBwAGUAcgB0AHkAIAAtAFAAYQB0AGgAIAAkAF8ALgBQAFMAUABhAHQAaAAgAC0ATgBhAG0AZQAgAFQAQwBQAE4AbwBEAGUAbABhAHkAIAAtAFYAYQBsAHUAZQAgADEAIAAtAFQAeQBwAGUAIABEAFcAbwByAGQAIAAtAEYAbwByAGMAZQAgAH0AIAB9ACAAYwBhAHQAYwBoACAAewB9ACAAfQA= >nul 2>&1 || call :fail 41-nagle-per-nic
echo   %G%[OK]%Z% Nagle-Algorithmus fuer aktive Netzwerk-Interfaces deaktiviert.

:: ============================================================
:: 42. Windows Defender: Ausnahmen fuer Spiele-Verzeichnisse
::     Nur Standard-Installationspfade. Weitere Pfade manuell ergaenzen.
:: ============================================================
echo %C%[*]%Z% [42] Defender-Ausnahmen Spiele-Verzeichnisse...
powershell.exe -NoProfile -ExecutionPolicy Bypass -EncodedCommand JABwAGEAdABoAHMAIAA9ACAAQAAoACcAQwA6AFwAUAByAG8AZwByAGEAbQAgAEYAaQBsAGUAcwAgACgAeAA4ADYAKQBcAFMAdABlAGEAbQAnACwAJwBDADoAXABQAHIAbwBnAHIAYQBtACAARgBpAGwAZQBzAFwARQBwAGkAYwAgAEcAYQBtAGUAcwAnACwAJwBDADoAXABQAHIAbwBnAHIAYQBtACAARgBpAGwAZQBzACAAKAB4ADgANgApAFwATwByAGkAZwBpAG4AIABHAGEAbQBlAHMAJwAsACcAQwA6AFwAUAByAG8AZwByAGEAbQAgAEYAaQBsAGUAcwBcAFIAaQBvAHQAIABHAGEAbQBlAHMAJwAsACcAQwA6AFwAUAByAG8AZwByAGEAbQAgAEYAaQBsAGUAcwAgACgAeAA4ADYAKQBcAEIAYQB0AHQAbABlAC4AbgBlAHQAJwAsACcAQwA6AFwAWABiAG8AeABHAGEAbQBlAHMAJwApADsAIABmAG8AcgBlAGEAYwBoACAAKAAkAHAAIABpAG4AIAAkAHAAYQB0AGgAcwApACAAewAgAGkAZgAgACgAVABlAHMAdAAtAFAAYQB0AGgAIAAkAHAAKQAgAHsAIAB0AHIAeQAgAHsAIABBAGQAZAAtAE0AcABQAHIAZQBmAGUAcgBlAG4AYwBlACAALQBFAHgAYwBsAHUAcwBpAG8AbgBQAGEAdABoACAAJABwACAALQBFAHIAcgBvAHIAQQBjAHQAaQBvAG4AIABTAGkAbABlAG4AdABsAHkAQwBvAG4AdABpAG4AdQBlACAAfQAgAGMAYQB0AGMAaAAgAHsAfQAgAH0AIAB9AA== >nul 2>&1 || call :fail 42-defender-exclusions
echo   %G%[OK]%Z% Defender-Ausnahmen fuer vorhandene Spiele-Verzeichnisse gesetzt.

:: ============================================================
:: 43. TCP-Feintuning
::     TcpTimedWaitDelay=30: TIME_WAIT von 120s auf 30s (schnellere
::     Socket-Freigabe). DefaultTTL=64: Unix-Standard (Default 128).
::     Beide Keys erfordern Neustart, wirken global.
:: ============================================================
echo %C%[*]%Z% [43] TCP-Feintuning...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30 /f >nul 2>&1 || call :fail 43-time-wait
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f >nul 2>&1 || call :fail 43-default-ttl
echo   %G%[OK]%Z% TcpTimedWaitDelay=30s, DefaultTTL=64 gesetzt.

:: ============================================================
:: 44. GPU TDR-Timeout erhoehen
::     TdrDelay=8: Schwellwert fuer GPU-Timeout von 2s auf 8s.
::     Verhindert "Grafiktreiber nicht mehr reagiert" bei Lastspitzen
::     (Shader-Kompilierung, DX12/Vulkan-Stutter).
:: ============================================================
echo %C%[*]%Z% [44] GPU TDR-Timeout...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 8 /f >nul 2>&1 || call :fail 44-tdr-delay
echo   %G%[OK]%Z% TdrDelay auf 8 Sekunden gesetzt.

:: ============================================================
:: 45. Dienste deaktivieren: Tablet/Stift/Geo/Maps/WSearch
::     TabletInputService: seit Build 22471 umbenannt zu TextInputManagementService.
::     Auf 25H2 existiert TabletInputService nicht mehr -> beide Namen versuchen,
::     kein :fail da hardware-abhängig und Build-abhängig.
::     lfsvc/MapsBroker: auf Frischinstall bereits gestoppt (Trigger-Start) -> net stop kein :fail.
::     WICHTIG: WSearch-Deaktivierung unterbindet "Mobilgeraet im
::     Explorer anzeigen" (Android via MTP). Ggf. auskommentieren.
:: ============================================================
echo %C%[*]%Z% [45] Unnoetige Dienste deaktivieren...
:: TabletInputService (alt) / TextInputManagementService (25H2): kein :fail - Build-abhängig
:: WARNUNG: TextInputManagementService steuert Texteingabe in UWP/WinUI-Apps und
:: Windows Terminal. Deaktivierung kann dort Tippen komplett unterbinden.
:: Auf reinem Desktop-PC ohne Touch-Eingabe i.d.R. unproblematisch.
net stop TabletInputService /y >nul 2>&1
sc config TabletInputService start= disabled >nul 2>&1
net stop TextInputManagementService /y >nul 2>&1
sc config TextInputManagementService start= disabled >nul 2>&1
:: lfsvc/MapsBroker: Trigger-Start -> auf Frischinstall gestoppt -> net stop kein :fail
net stop lfsvc /y >nul 2>&1
sc config lfsvc start= disabled >nul 2>&1 || call :fail 45-geo-dis
net stop MapsBroker /y >nul 2>&1
sc config MapsBroker start= disabled >nul 2>&1 || call :fail 45-maps-dis
net stop WSearch /y >nul 2>&1 || call :fail 45-wsearch-stop
sc config WSearch start= disabled >nul 2>&1 || call :fail 45-wsearch-dis
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Search" /v "SearchFlags" /t REG_DWORD /d 4 /f >nul 2>&1 || call :fail 45-search-flags
echo   %G%[OK]%Z% TabletInput/TextInputMgmt, lfsvc, MapsBroker, WSearch deaktiviert.
echo   %Y%[HINWEIS]%Z% WSearch aus: Explorer-Suche langsamer, Android-MTP-Integration eingeschraenkt.

:: ============================================================
:: 46. Input-App-Preload deaktivieren
::     IsInputAppPreloadEnabled=0: kein Vorabladen der Touch-Tastatur.
::     TIPC-Telemetrie abschalten.
:: ============================================================
echo %C%[*]%Z% [46] Input-App-Preload...
reg add "HKCU\Software\Microsoft\Input" /v "IsInputAppPreloadEnabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 46-no-preload
reg add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1 || call :fail 46-no-tipc
echo   %G%[OK]%Z% Input-App-Preload und TIPC-Telemetrie deaktiviert.

:: ============================================================
:: 47. Geolocation-Policy sperren
::     AllowLocation=0: system-weite Sperre via Policy, verhindert
::     WinRT Location API auch bei deaktiviertem lfsvc-Dienst.
:: ============================================================
echo %C%[*]%Z% [47] Geolocation-Policy...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 47-no-location
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 47-no-loc-script
echo   %G%[OK]%Z% Standortzugriff per Policy gesperrt.

:: ============================================================
:: 48. Search-Banner nach WSearch-Deaktivierung unterdruecken
::     PreventIndexingOutlook=1: kein Outlook-Index (falls installiert).
:: ============================================================
echo %C%[*]%Z% [48] Search-Index-Banner unterdruecken...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventIndexingOutlook" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 48-no-search-banner
echo   %G%[OK]%Z% Search-Banner-Unterdrueckung gesetzt.

:: ============================================================
:: 49. Audit-Policy
::     Process Creation (Success): Event 4688 + Kommandozeile.
::     Logon Success+Failure: Event 4624/4625.
::     Security System Extension: Event 4697 (Treiber/Service-Install).
::     auditpol nutzt englische Subcategory-Namen (locale-unabhaengig).
:: ============================================================
echo %C%[*]%Z% [49] Audit-Policy konfigurieren...
auditpol /set /subcategory:"Process Creation" /success:enable >nul 2>&1 || call :fail 49-audit-proc
auditpol /set /subcategory:"Logon" /success:enable /failure:enable >nul 2>&1 || call :fail 49-audit-logon
auditpol /set /subcategory:"Security System Extension" /success:enable >nul 2>&1 || call :fail 49-audit-svc
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit" /v "ProcessCreationIncludeCmdLine_Enabled" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 49-audit-cmdline
echo   %G%[OK]%Z% Audit: Prozessstart (inkl. Kommandozeile), Anmeldung, Treiber-Installation aktiv.

:: ============================================================
:: 50. Event-Log-Groessen erhoehen
::     Security=128MB (Audit-intensiv), System/Application=64MB.
::     wevtutil /ms in Bytes; Werte sind Vielfache von 64KB.
:: ============================================================
echo %C%[*]%Z% [50] Event-Log-Groessen...
wevtutil sl Security /ms:134217728 >nul 2>&1 || call :fail 50-log-security
wevtutil sl System /ms:67108864 >nul 2>&1 || call :fail 50-log-system
wevtutil sl Application /ms:67108864 >nul 2>&1 || call :fail 50-log-application
echo   %G%[OK]%Z% Event-Logs: Security=128MB, System=64MB, Application=64MB.

:: ============================================================
:: 51. PowerShell Script Block Logging
::     Event 4104: dekodiert -EncodedCommand-Inhalte im PS-Log.
::     PS-Operational-Log auf 64MB (Default 15MB reicht nicht).
::     Kein InvocationLogging (zu viel Rauschen).
:: ============================================================
echo %C%[*]%Z% [51] PowerShell Script Block Logging...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v "EnableScriptBlockLogging" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 51-ps-sbl
wevtutil sl "Microsoft-Windows-PowerShell/Operational" /ms:67108864 >nul 2>&1 || call :fail 51-ps-log-size
echo   %G%[OK]%Z% PS Script Block Logging aktiv (Event 4104), Operational-Log=64MB.

:: ============================================================
:: 52. Crash-Dump-Konfiguration
::     CrashDumpEnabled=7 (Automatic): Windows passt Pagefile dynamisch
::     an um Kernel-Dump zu garantieren.
::     AlwaysKeepMemoryDump=1: Disk-Cleanup loescht MEMORY.DMP nicht.
::     AutoReboot=1: Neustart nach BSOD (sicherstellen Default aktiv).
:: ============================================================
echo %C%[*]%Z% [52] Crash-Dump-Konfiguration...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 7 /f >nul 2>&1 || call :fail 52-dump-type
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AlwaysKeepMemoryDump" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 52-dump-keep
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 52-dump-reboot
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "MinidumpDir" /t REG_EXPAND_SZ /d "%SystemRoot%\Minidump" /f >nul 2>&1 || call :fail 52-dump-dir
echo   %G%[OK]%Z% Crash-Dump: Automatic, AlwaysKeep=1, AutoReboot=1, Minidump-Pfad gesetzt.

:: ============================================================
:: 53. NumLock beim Start aktivieren
::     .DEFAULT: Login-Screen (vor erstem Login).
::     HKCU: laufende/naechste Benutzer-Session.
::     InitialKeyboardIndicators 2147483650: korrekter Win11-Wert
::     (Bit 31 gesetzt = moderner Pfad; "2" nur fuer Win7-Compat).
::     Fast Startup (Sek.29 deaktiviert) wuerde .DEFAULT-Wert cachen.
:: ============================================================
echo %C%[*]%Z% [53] NumLock beim Start...
reg add "HKU\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2147483650" /f >nul 2>&1 || call :fail 53-numlock-default
reg add "HKCU\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f >nul 2>&1 || call :fail 53-numlock-hkcu
echo   %G%[OK]%Z% NumLock: Login-Screen (.DEFAULT) und Benutzer-Session (HKCU) aktiviert.

:: ============================================================
:: 54. Verbose Boot/Shutdown + Accessibility-Shortcuts deaktivieren
::     VerboseStatus=1: konkrete Statusmeldungen statt Spinner.
::     StickyKeys (Flags=506): Shift 5x -> Dialog deaktiviert.
::     ToggleKeys (Flags=58): NumLock/CapsLock/Scroll 5s -> Piepton aus.
::     FilterKeys (Flags=122): Rechts-Shift 8s -> Verlangsamung aus.
:: ============================================================
echo %C%[*]%Z% [54] Verbose Status und Accessibility-Shortcuts...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "VerboseStatus" /t REG_DWORD /d 1 /f >nul 2>&1 || call :fail 54-verbose
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f >nul 2>&1 || call :fail 54-sticky-keys
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "58" /f >nul 2>&1 || call :fail 54-toggle-keys
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f >nul 2>&1 || call :fail 54-filter-keys
echo   %G%[OK]%Z% VerboseStatus aktiv, Sticky/Toggle/Filter-Keys-Shortcuts deaktiviert.
echo   %Y%[HINWEIS]%Z% VerboseStatus greift erst nach Neustart.

:: ============================================================
:: 55. System-Bereinigung
::     Reihenfolge: (1) Update-Dienste stoppen -> (2) Cache loeschen
::     -> (3) catroot2 loeschen -> (4) Temp -> (5) Prefetch
::     -> (6) Dienste wieder starten.
::     rd loescht Ordner selbst -> anschliessend md noetig.
::     Laufende Prozesse koennen Temp-Dateien sperren -> >nul 2>&1.
::     catroot selbst NICHT loeschen (Systemdateien).
:: ============================================================
echo %C%[*]%Z% [55] System-Bereinigung...
:: Fehlschlaege hier werden nicht gezaehlt: gesperrte Temp-Dateien
:: durch laufende Prozesse sind erwartet und kein Fehler des Skripts.

net stop wuauserv /y >nul 2>&1
net stop bits /y >nul 2>&1
net stop cryptsvc /y >nul 2>&1

rd /s /q "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1
md "%SystemRoot%\SoftwareDistribution\Download" >nul 2>&1

:: rd /s /q loescht catroot2 komplett inkl. Ordner selbst -> md noetig
rd /s /q "%SystemRoot%\System32\catroot2" >nul 2>&1
md "%SystemRoot%\System32\catroot2" >nul 2>&1

del /f /s /q "%TEMP%\*" >nul 2>&1
rd /s /q "%TEMP%" >nul 2>&1
md "%TEMP%" >nul 2>&1
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
rd /s /q "%SystemRoot%\Temp" >nul 2>&1
md "%SystemRoot%\Temp" >nul 2>&1

del /f /s /q "%SystemRoot%\Prefetch\*" >nul 2>&1

net start cryptsvc >nul 2>&1
net start bits >nul 2>&1
net start wuauserv >nul 2>&1

echo   %G%[OK]%Z% Temp, Update-Cache, catroot2, Prefetch bereinigt.

:: ============================================================
:: 56. Explorer neu starten
::     runas /trustlevel:0x20000: startet ohne erhoehten Token.
::     start explorer.exe aus elevated cmd -> Admin-Token erbt.
:: ============================================================
echo.
echo %C%[*]%Z% [56] Explorer neu starten...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
runas /trustlevel:0x20000 "explorer.exe"

:: ============================================================
:: Zusammenfassung
:: ============================================================
echo.
if !ERR_TOTAL! equ 0 (
    echo   %G%Alle Tweaks erfolgreich angewendet.%Z%
) else (
    echo   %Y%!ERR_TOTAL! Fehlschlag^(e^) aufgetreten:%Z%
    echo   %R%!ERR_LIST!%Z%
    echo.
    echo   %Y%Hinweis: Manche Fehlschlaege sind erwartet ^(z.B. Tasks die in 25H2
    echo   nicht mehr existieren, Keys die bereits geloescht waren, Dienste die
    echo   nicht installiert sind^). Bitte manuell pruefen falls unerwartet.%Z%
)
echo.
echo   %Y%Neustart erforderlich%Z% fuer:
echo   Telemetrie, CLR, HAGS, HVCI, Retpoline, Energieplan, mDNS-Policy,
echo   NetBIOS, Boot-Logo, BitLocker-Policy, UAC-Secure-Desktop,
echo   TdrDelay, TCP-Feintuning, Audit-Policy, PS-Logging, VerboseStatus, NumLock,
echo   TextInputManagementService, Werbe-ID.
echo.
pause
goto :EOF

:: :fail <label>
::   Aufruf via '|| call :fail LABEL' nach fehlgeschlagenen Befehlen.
::   Muss nach goto :EOF stehen damit der Hauptfluss nicht durchfaellt.
:fail
    set /a ERR_TOTAL+=1
    set "ERR_LIST=!ERR_LIST! %~1"
    goto :eof
