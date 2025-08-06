@echo off

echo.
echo Dieses script erstellt eine VHDx datei (Virtuelle Festplatte)
echo Standard pfad ist C:\VHDs und Größe 10gb. Für einen anderen Pfad und Größe muss dieses script vorher angepasst werden.
pause

REM Pfad zur VHDX-Datei
set VHDXPath=C:\VHDs\meine_vhdx.vhdx
set VHDSize=10GB

REM 1. VHDX erstellen
powershell -Command "New-VHD -Path '%VHDXPath%' -SizeBytes 10GB -Dynamic"

REM 2. VHD mounten
powershell -Command "Mount-VHD -Path '%VHDXPath%'"

REM Kurze Pause, um sicherzustellen, dass das Laufwerk erkannt wird
timeout /t 5

REM 3. Ermitteln des Laufwerksbuchstabens
for /f "tokens=1,2 delims=:" %%A in ('powershell -Command "& {Get-Disk | Where-Object IsOffline -eq \$false -and PartitionStyle -eq 'RAW' | Select-Object -First 1 | Get-Partition | Select-Object -ExpandProperty DriveLetter}"') do (
    set DRIVE=%%A
)

REM 4. Disk initialisieren, partitionieren und formatieren
powershell -Command ^
    $diskNumber = (Get-Disk | Where-Object { $_.Location -like '*%VHDXPath%' }).Number; ^
    Initialize-Disk -Number $diskNumber -PartitionStyle MBR -PassThru | Out-Null; ^
    New-Partition -DiskNumber $diskNumber -UseMaximumSize -AssignDriveLetter | Out-Null; ^
    Get-Partition -DiskNumber $diskNumber | Format-Volume -FileSystem NTFS -NewFileSystemLabel "VHDXVolume" -Confirm:$false

REM Optional: VHD wieder aushängen
echo mit: powershell -Command "Dismount-VHD -Path '%VHDXPath%'" lässt sich die vhdx datei wieder aushängen..

echo VHDX wurde erstellt, initialisiert, formatiert und eingebunden.
pause
