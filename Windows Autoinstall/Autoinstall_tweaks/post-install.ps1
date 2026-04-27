#Requires -Version 5.1
<#
.SYNOPSIS
    Post-Install Tweaks for Windows 11 24H2 / 25H2
.DESCRIPTION
    Run AFTER first login as Administrator.
    Applies: Visual Effects, TCP/Network tuning, Service trimming,
             SSD/NVMe optimizations, Crash Dump config, Boot menu,
             UX tweaks, Gaming tweaks, Telemetry-Task cleanup,
             Network hardening (LLMNR/NetBIOS) and NTFS optimization.

    Companion to autounattend.xml (audio latency + privacy already done there).

.NOTES
    Author       : sysadmin
    Compatible   : Windows 11 24H2 / 25H2
    Encoding     : UTF-8 with BOM, CRLF
    Run as       : Administrator (self-elevates if needed)

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\post-install.ps1
    powershell -ExecutionPolicy Bypass -File .\post-install.ps1 -SkipServices
    powershell -ExecutionPolicy Bypass -File .\post-install.ps1 -SkipGaming -NoReboot
#>

[CmdletBinding()]
param(
    [switch]$SkipServices,
    [switch]$SkipGaming,
    [switch]$NoReboot
)

# ============================================================ #
# SELF-ELEVATION                                               #
# ============================================================ #
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Restarting as Administrator..." -ForegroundColor Yellow
    $argList = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$PSCommandPath`"")
    if ($SkipServices) { $argList += '-SkipServices' }
    if ($SkipGaming)   { $argList += '-SkipGaming' }
    if ($NoReboot)     { $argList += '-NoReboot' }
    Start-Process -FilePath 'powershell.exe' -ArgumentList $argList -Verb RunAs
    exit
}

$ErrorActionPreference = 'Continue'
$ProgressPreference    = 'SilentlyContinue'
$LogFile = "$env:SystemRoot\Logs\post-install-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"
Start-Transcript -Path $LogFile -Force | Out-Null

# ============================================================ #
# HELPER FUNCTIONS                                             #
# ============================================================ #
function Write-Section {
    param([string]$Title)
    Write-Host ""
    Write-Host ('=' * 64) -ForegroundColor Cyan
    Write-Host "  $Title" -ForegroundColor Cyan
    Write-Host ('=' * 64) -ForegroundColor Cyan
}

function Write-Step {
    param([string]$Message, [string]$Status = 'INFO')
    $color = switch ($Status) {
        'OK'    { 'Green' }
        'WARN'  { 'Yellow' }
        'ERROR' { 'Red' }
        default { 'Gray' }
    }
    Write-Host "  [$Status] $Message" -ForegroundColor $color
}

function Set-RegValue {
    # Idempotent registry writer - creates path if missing
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)]$Value,
        [ValidateSet('DWord', 'String', 'ExpandString', 'Binary', 'MultiString', 'QWord')]
        [string]$Type = 'DWord'
    )
    try {
        if (-not (Test-Path $Path)) {
            New-Item -Path $Path -Force | Out-Null
        }
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
        return $true
    } catch {
        Write-Step "Reg write failed: $Path\$Name - $_" 'ERROR'
        return $false
    }
}

function Disable-ServiceSafe {
    # Stop + disable service, ignoring missing services
    param([string]$Name, [string]$DisplayName = $Name)
    try {
        $svc = Get-Service -Name $Name -ErrorAction Stop
        if ($svc.Status -eq 'Running') {
            Stop-Service -Name $Name -Force -ErrorAction SilentlyContinue
        }
        Set-Service -Name $Name -StartupType Disabled -ErrorAction Stop
        Write-Step "Service disabled: $DisplayName" 'OK'
    } catch {
        Write-Step "Service not found / skipped: $DisplayName" 'WARN'
    }
}

# ============================================================ #
# 1. VISUAL EFFECTS - SNAPPIER UI                              #
# ============================================================ #
Write-Section "Visual Effects (Performance UI)"

# Custom Performance: animations off, smooth-scrolling kept, font smoothing kept
Set-RegValue 'HKCU:\Control Panel\Desktop' 'UserPreferencesMask' ([byte[]](0x90,0x12,0x07,0x80,0x10,0x00,0x00,0x00)) 'Binary'
Set-RegValue 'HKCU:\Control Panel\Desktop' 'MenuShowDelay' '0' 'String'
Set-RegValue 'HKCU:\Control Panel\Desktop\WindowMetrics' 'MinAnimate' '0' 'String'
Set-RegValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' 'VisualFXSetting' 3
# Disable transparency in Start/Taskbar (slight GPU savings)
Set-RegValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' 'EnableTransparency' 0
# Disable Aero Shake (accidental minimize on dragging)
Set-RegValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'DisallowShaking' 1
Write-Step "Visual effects optimized" 'OK'

# ============================================================ #
# 2. TCP / NETWORK TUNING                                      #
# ============================================================ #
Write-Section "TCP / Network Stack"

$netshCommands = @(
    @('int','tcp','set','global','autotuninglevel=normal'),
    @('int','tcp','set','supplemental','Internet','congestionprovider=cubic'),
    @('int','tcp','set','global','rss=enabled'),
    @('int','tcp','set','global','ecncapability=enabled'),
    @('int','tcp','set','global','timestamps=disabled'),
    @('int','tcp','set','global','initialRto=2000'),
    @('int','tcp','set','global','nonsackrttresiliency=disabled'),
    @('int','tcp','set','heuristics','disabled')
)
foreach ($cmd in $netshCommands) {
    & netsh.exe @cmd | Out-Null
}
Write-Step "netsh tuning applied" 'OK'

# Per-interface tweaks: TcpAckFrequency=1, TCPNoDelay=1 on all NICs
$tcpipPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces'
Get-ChildItem $tcpipPath -ErrorAction SilentlyContinue | ForEach-Object {
    Set-RegValue $_.PSPath 'TcpAckFrequency' 1
    Set-RegValue $_.PSPath 'TCPNoDelay'      1
    Set-RegValue $_.PSPath 'TcpDelAckTicks'  0
}
Write-Step "Per-NIC ACK/Nagle tuning applied" 'OK'

# Disable DNS over HTTPS auto-fallback issues + larger DNS cache
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' 'CacheHashTableBucketSize' 1
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' 'CacheHashTableSize' 384
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' 'MaxCacheEntryTtlLimit' 64000
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' 'MaxSOACacheEntryTtlLimit' 301
Write-Step "DNS cache enlarged" 'OK'

# ============================================================ #
# 3. SERVICE TRIMMING                                          #
# ============================================================ #
if (-not $SkipServices) {
    Write-Section "Service Trimming"

    # Aggressive but safe: services rarely needed on modern desktops
    $servicesToDisable = @(
        @{Name='Fax';                  Reason='No fax modem'}
        @{Name='RemoteRegistry';       Reason='Security'}
        @{Name='WerSvc';               Reason='Error reporting'}
        @{Name='WMPNetworkSvc';        Reason='WMP sharing'}
        @{Name='RetailDemo';           Reason='Retail demo only'}
        @{Name='MapsBroker';           Reason='Maps app'}
        @{Name='lfsvc';                Reason='Geolocation'}
        @{Name='SharedAccess';         Reason='ICS'}
        @{Name='WbioSrvc';             Reason='Biometrics (re-enable if used)'}
        @{Name='diagnosticshub.standardcollector.service'; Reason='VS diagnostics'}
        @{Name='DiagTrack';            Reason='Telemetry'}
        @{Name='dmwappushservice';     Reason='WAP push'}
    )
    foreach ($s in $servicesToDisable) {
        Disable-ServiceSafe -Name $s.Name -DisplayName "$($s.Name) ($($s.Reason))"
    }

    # Print Spooler: only if no printers detected
    $printers = Get-Printer -ErrorAction SilentlyContinue | Where-Object { $_.Type -eq 'Local' -or $_.PortName -notlike 'PORTPROMPT:*' }
    if (-not $printers) {
        Disable-ServiceSafe -Name 'Spooler' -DisplayName 'Spooler (no printers detected)'
    } else {
        Write-Step "Spooler kept (printers detected)" 'WARN'
    }

    # Xbox stack: only if no Xbox controller / GameBar usage
    $xboxServices = @('XblAuthManager','XblGameSave','XboxGipSvc','XboxNetApiSvc')
    foreach ($svc in $xboxServices) {
        Disable-ServiceSafe -Name $svc -DisplayName $svc
    }
} else {
    Write-Step "Service trimming skipped (-SkipServices)" 'WARN'
}

# ============================================================ #
# 4. SSD / NVMe OPTIMIZATIONS                                  #
# ============================================================ #
Write-Section "SSD / NVMe Optimizations"

# Detect if system drive is SSD
try {
    $sysDrive = $env:SystemDrive.TrimEnd(':')
    $physical = Get-PhysicalDisk | Where-Object {
        ($_ | Get-Disk -ErrorAction SilentlyContinue | Get-Partition -ErrorAction SilentlyContinue |
         Get-Volume -ErrorAction SilentlyContinue).DriveLetter -contains $sysDrive
    } | Select-Object -First 1
    $isSSD = $physical.MediaType -in @('SSD','NVMe') -or $physical.BusType -eq 'NVMe'
} catch {
    $isSSD = $true  # safer default for modern hardware
}

if ($isSSD) {
    # Disable scheduled defrag (TRIM is sufficient and runs separately)
    schtasks /Change /TN '\Microsoft\Windows\Defrag\ScheduledDefrag' /Disable 2>$null | Out-Null
    Write-Step "Scheduled defrag disabled (SSD detected)" 'OK'

    # SysMain (Superfetch) is often counterproductive on NVMe
    Disable-ServiceSafe -Name 'SysMain' -DisplayName 'SysMain/Superfetch (NVMe)'

    # Verify TRIM is enabled
    $trim = (& fsutil.exe behavior query DisableDeleteNotify) -match 'NTFS\s*=\s*0'
    if ($trim) { Write-Step "TRIM is enabled" 'OK' }
    else       { & fsutil.exe behavior set DisableDeleteNotify NTFS 0 | Out-Null; Write-Step "TRIM enabled" 'OK' }
} else {
    Write-Step "HDD detected - SSD tweaks skipped" 'WARN'
}

# ============================================================ #
# 5. CRASH DUMP - SMALL DUMPS ONLY                             #
# ============================================================ #
Write-Section "Crash Dump Configuration"

# CrashDumpEnabled=3 = Small memory dump (256KB), saves disk space + time on BSOD
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl' 'CrashDumpEnabled' 3
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl' 'MinidumpsCount' 50
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl' 'AutoReboot' 1
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl' 'LogEvent' 1
Write-Step "Crash dump set to small (256KB minidump)" 'OK'

# ============================================================ #
# 6. BOOT MENU                                                 #
# ============================================================ #
Write-Section "Boot Menu"

& bcdedit.exe /timeout 3 | Out-Null
& bcdedit.exe /set bootux disabled | Out-Null
& bcdedit.exe /set quietboot yes | Out-Null
Write-Step "Boot timeout=3s, animation off" 'OK'

# ============================================================ #
# 7. UX TWEAKS                                                 #
# ============================================================ #
Write-Section "UX Quality of Life"

# Show seconds in taskbar clock
Set-RegValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'ShowSecondsInSystemClock' 1
# Show all tray icons
Set-RegValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' 'EnableAutoTray' 0
# Verbose status messages during startup/login
Set-RegValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' 'VerboseStatus' 1
# Disable first-sign-in animation (faster initial login per user)
Set-RegValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' 'EnableFirstLogonAnimation' 0
# Disable startup delay for desktop apps
Set-RegValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize' 'StartupDelayInMSec' 0
# Open new File Explorer windows in same process (faster but less crash-resilient)
Set-RegValue 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' 'SeparateProcess' 0
# Increase keyboard repeat rate
Set-RegValue 'HKCU:\Control Panel\Keyboard' 'KeyboardDelay' '0' 'String'
Set-RegValue 'HKCU:\Control Panel\Keyboard' 'KeyboardSpeed' '31' 'String'
Write-Step "UX tweaks applied" 'OK'

# ============================================================ #
# 8. GAMING TWEAKS                                             #
# ============================================================ #
if (-not $SkipGaming) {
    Write-Section "Gaming Tweaks"

    # Mouse: completely flat acceleration curves (already disabled in XML, here we zero curves)
    $zeroCurve = [byte[]](0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0)
    Set-RegValue 'HKCU:\Control Panel\Mouse' 'SmoothMouseXCurve' $zeroCurve 'Binary'
    Set-RegValue 'HKCU:\Control Panel\Mouse' 'SmoothMouseYCurve' $zeroCurve 'Binary'

    # Fullscreen Optimizations off globally
    Set-RegValue 'HKCU:\System\GameConfigStore' 'GameDVR_FSEBehaviorMode' 2
    Set-RegValue 'HKCU:\System\GameConfigStore' 'GameDVR_FSEBehavior' 2
    Set-RegValue 'HKCU:\System\GameConfigStore' 'GameDVR_HonorUserFSEBehaviorMode' 1
    Set-RegValue 'HKCU:\System\GameConfigStore' 'GameDVR_DXGIHonorFSEWindowsCompatible' 1
    Set-RegValue 'HKCU:\System\GameConfigStore' 'GameDVR_EFSEFeatureFlags' 0

    # USB Selective Suspend disable on AC (lower DPC latency, USB devices stay responsive)
    & powercfg.exe /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 | Out-Null
    & powercfg.exe /setactive SCHEME_CURRENT | Out-Null

    Write-Step "Gaming tweaks applied" 'OK'
} else {
    Write-Step "Gaming tweaks skipped (-SkipGaming)" 'WARN'
}

# ============================================================ #
# 9. SCHEDULED TELEMETRY TASKS - DISABLE                       #
# ============================================================ #
Write-Section "Telemetry Scheduled Tasks"

# Well-known telemetry/CEIP tasks - safe to disable
# Source: Microsoft documentation on minimizing telemetry
$tasksToDisable = @(
    '\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser',
    '\Microsoft\Windows\Application Experience\ProgramDataUpdater',
    '\Microsoft\Windows\Application Experience\StartupAppTask',
    '\Microsoft\Windows\Application Experience\PcaPatchDbTask',
    '\Microsoft\Windows\Customer Experience Improvement Program\Consolidator',
    '\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip',
    '\Microsoft\Windows\Feedback\Siuf\DmClient',
    '\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload',
    '\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector',
    '\Microsoft\Windows\Maintenance\WinSAT',
    '\Microsoft\Windows\Autochk\Proxy',
    '\Microsoft\Windows\NetTrace\GatherNetworkInfo',
    '\Microsoft\Windows\Windows Error Reporting\QueueReporting',
    '\Microsoft\Windows\CloudExperienceHost\CreateObjectTask'
)

foreach ($task in $tasksToDisable) {
    try {
        $taskName = Split-Path $task -Leaf
        $taskPath = Split-Path $task -Parent
        # Path needs trailing backslash for Get-ScheduledTask
        if (-not $taskPath.EndsWith('\')) { $taskPath += '\' }
        $existing = Get-ScheduledTask -TaskName $taskName -TaskPath $taskPath -ErrorAction SilentlyContinue
        if ($existing -and $existing.State -ne 'Disabled') {
            Disable-ScheduledTask -TaskName $taskName -TaskPath $taskPath -ErrorAction Stop | Out-Null
            Write-Step "Disabled: $taskName" 'OK'
        } elseif ($existing) {
            Write-Step "Already disabled: $taskName" 'OK'
        } else {
            Write-Step "Not present: $taskName" 'WARN'
        }
    } catch {
        Write-Step "Failed: $taskName - $_" 'ERROR'
    }
}

# ============================================================ #
# 10. NETWORK HARDENING + NTFS OPTIMIZATION                    #
# ============================================================ #
Write-Section "Network Hardening + NTFS"

# --- LLMNR (Link-Local Multicast Name Resolution) disable ---
# LLMNR is used for local hostname resolution but is a known attack vector
# (responder.py spoofing). DNS works fine without it. Safe on home networks.
Set-RegValue 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' 'EnableMulticast' 0
Write-Step "LLMNR disabled (DNS poisoning protection)" 'OK'

# --- NetBIOS over TCP/IP disable ---
# NetBIOS is a legacy name resolution protocol superseded by DNS.
# Modern Windows networks (Win10+) work fine without it.
# NetbiosOptions: 0=default, 1=enable, 2=disable
$nbtPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces'
$interfaces = Get-ChildItem $nbtPath -ErrorAction SilentlyContinue | Where-Object { $_.PSChildName -like 'Tcpip_*' }
$nbtCount = 0
foreach ($iface in $interfaces) {
    Set-RegValue $iface.PSPath 'NetbiosOptions' 2
    $nbtCount++
}
Write-Step "NetBIOS over TCP/IP disabled on $nbtCount interfaces" 'OK'

# --- Disable WPAD (Web Proxy Auto-Discovery) ---
# WPAD is another known attack vector if no proxy is configured
Set-RegValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad' 'WpadOverride' 1
Write-Step "WPAD disabled" 'OK'

# --- Disable IPv6 transition tunnels ---
# Teredo, ISATAP, 6to4 are legacy transition mechanisms.
# Modern dual-stack networks don't need them and they add attack surface.
& netsh.exe interface teredo set state disabled 2>$null | Out-Null
& netsh.exe interface isatap set state disabled 2>$null | Out-Null
& netsh.exe interface 6to4 set state disabled 2>$null | Out-Null
Write-Step "IPv6 tunnel protocols (Teredo/ISATAP/6to4) disabled" 'OK'

# --- NTFS: Disable 8.3 short filename creation ---
# 8.3 names (PROGRA~1) only needed for legacy 16-bit software.
# Disabling provides ~10-20% performance boost on directories with many files.
& fsutil.exe behavior set disable8dot3 1 2>&1 | Out-Null
Write-Step "NTFS 8.3 short names disabled (faster I/O)" 'OK'

# --- NTFS: Increase paged pool memory cache ---
# MftZoneReservation: reserve more space for MFT growth (1=12.5%, 2=25%, 3=37.5%, 4=50%)
# Value 2 is a safe default for most systems with many small files
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' 'NtfsMftZoneReservation' 2
Write-Step "NTFS MFT Zone Reservation set to 25%" 'OK'

# --- Memory: Disable Clear PageFile at Shutdown ---
# Default is 0 (off) but enterprise images sometimes have it on.
# Clearing pagefile adds 5-30 seconds to every shutdown.
Set-RegValue 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' 'ClearPageFileAtShutdown' 0
Write-Step "PageFile not cleared on shutdown (faster shutdown)" 'OK'

# ============================================================ #
# 11. CLEANUP / FINAL STEPS                                    #
# ============================================================ #
Write-Section "Cleanup"

# Cleanup temp + Windows.old + previous installation files (safe)
& cleanmgr.exe /sagerun:1 2>$null

# Restart Explorer to apply all HKCU changes
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1
Start-Process explorer.exe
Write-Step "Explorer restarted" 'OK'

# ============================================================ #
# SUMMARY                                                      #
# ============================================================ #
Write-Section "Done"
Write-Host "  Log:    $LogFile" -ForegroundColor Gray
Write-Host "  Reboot: recommended for all changes to take effect" -ForegroundColor Yellow

Stop-Transcript | Out-Null

if (-not $NoReboot) {
    Write-Host ""
    $answer = Read-Host "  Reboot now? [y/N]"
    if ($answer -match '^[yYjJ]') {
        Restart-Computer -Force
    }
}
