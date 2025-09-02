
# Last Edit: 02.09.2025

-------------------
  Useful links
-------------------

# Eleven Forum 
(https://www.elevenforum.com/)

# Creating custom windows install
https://www.elevenforum.com/t/winpe-create-a-custom-windows-install-usb.4804/

https://www.elevenforum.com/t/create-windows-11-bootable-usb-installation-media.750/#Three


# Creating an vhd or vhdx (virtual disk) file
https://www.elevenforum.com/t/create-vhd-or-vhdx-file-in-windows-11.19203/

https://www.elevenforum.com/t/create-windows-11-virtual-hard-disk-vhdx-at-boot-to-native-boot.645/
https://www.elevenforum.com/t/mount-or-unmount-vhd-and-vhdx-file-as-drive-in-windows-11.19177/


# Windows 10,11 services (restore cmd scripts)
https://batcmd.com/windows/10/services/
https://batcmd.com/windows/11/services/


# Creating an win10,11 iso with all updates
https://uupdump.net/

# Windows ISOs
# https://os.click
# https://genuine-iso-verifier.weebly.com
# https://massgrave.dev/genuine-installation-media.html
# https://uup.rg-adguard.net/
# https://files.rg-adguard.net/category

# News for windows (and win11,10 isos with latest updates)
https://deskmodder.de/


# Creating an answer file for windows auto install
https://schneegans.de/windows/unattend-generator/

# Creating usb sticks for multiple ISOs
https://github.com/ventoy/Ventoy/releases


; Github Repositorys (Windows 10,11 tweaks)
# https://github.com/Batleman
# https://github.com/AlchemyTweaks
# https://github.com/TairikuOokami
# https://github.com/ionuttbara
# https://github.com/Hyyote
# https://github.com/MoriEdan
# https://github.com/NicholasBly
# https://github.com/rahilpathan
# https://github.com/ChrisTitusTech
# https://github.com/simeononsecurity
# https://github.com/alufena
# https://github.com/shoober420


#
# Various Tweaks and Tipps 
#

( Info: The CMD or Windows Terminal must be run with elevated rights to run system tasks !!)


# Apps - FixWin          - https://www.thewindowsclub.com/fixwin-windows-pc-repair-software
# Windows Drivers        - https://www.catalog.update.microsoft.com
# Windows Repair Install - https://www.elevenforum.com/t/repair-install-windows-11-with-an-in-place-upgrade.418
# Windows Update Reset   - https://github.com/ManuelGil/Reset-Windows-Update-Tool/releases
# Windows Repair Toolbox - https://windows-repair-toolbox.com


# Using winget (windows package manager)

# Winget update
winget upgrade
winget install Microsoft.AppInstaller --accept-package-agreements --accept-source-agreements

# Update all programs over winget
winget upgrade --all 
winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements

# install a program over winget
winget install -e --id

# Remove a program over winget
winget remove --id

# Search for a program over winget
winget search


# Windows Update
# Choose how updates are delivered
0 - Turns off Delivery Optimization 
1 - Gets or sends updates and apps to PCs on the same NAT only 
2 - Gets or sends updates and apps to PCs on the same local network domain 
3 - Gets or sends updates and apps to PCs on the Internet 
99  - Simple download mode with no peering 
100 - Use BITS instead of Windows Update Delivery Optimization

reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f

# Update apps automatically / 2 - Off / 4 - On
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d "4" /f

# Cleaning Windows update files via dism
dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase /Quiet



# Fix boot - (https://neosmart.net/wiki/bootrec/#Bootrec_in_Windows10)

bootrec / fixmbr
bootrec / fixboot
bootrec / rebuildbcd

# Boot into Recovery Mode 
Shutdown /f /r /o /t 0


# Access CMD with SYSTEM rights at logon (Win+U)

takeown /s %computername% /u %username% /f "%WINDIR%\System32\utilman.exe"
icacls "%WINDIR%\System32\utilman.exe" /grant:r %username%:F
copy /y %WINDIR%\System32\cmd.exe %WINDIR%\System32\utilman.exe
takeown /s %computername% /u %username% /f "%WINDIR%\System32\sethc.exe"
icacls "%WINDIR%\System32\sethc.exe" /grant:r %username%:F
copy /y %WINDIR%\System32\cmd.exe %WINDIR%\System32\sethc.exe


# Reset password/gain admin access/enable local admin account
# https://www.technibble.com/bypass-windows-logons-utilman/

copy /y c:\windows\system32\cmd.exe c:\windows\system32\utilman.exe
net user username password
net user Administrator /active:yes
net user Administrator *
net user NewGuy * /add
net localgroup Administrators NewGuy /add


# Performance - Settings - Advanced - Virtual memory
# Disable pagefile (use it only with 32gb or more ram !!)

# Enable WMIC
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~

wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefileset where name="%SystemDrive%\\pagefile.sys" set InitialSize=0,MaximumSize=0
wmic pagefileset where name="%SystemDrive%\\pagefile.sys" delete


# Force update Group Policies 
# user and computer policies, including any new or updated policies, without requiring a system restart.
gpupdate /force


# Rename a drive (C: or an other drive) via cmd or windows terminal
label C: System

# Deleting Temp files on drive C:
del /s /f /q c:\windows\temp\*.*
del /s /f /q C:\WINDOWS\Prefetch


# Disable Windows Recovery Partition
reagentc /info
reagentc /disable

# Change dns (primary and secondary) over cmd / windows terminal
netsh interface ipv4 set dns name=%INTERFACE_NAME% static 8.8.8.8 primary
netsh interface ipv4 add dns name=%INTERFACE_NAME% 1.1.1.1 index=2


# Change Powerplan for screen and pc (pc sleep after 36min and screen turned of after 24 min)

# Turn off my screen after 24 minutes (ac-plugged in)
powercfg -change -monitor-timeout-ac 24
powercfg -change -monitor-timeout-dc 24

# Put my device to sleep after 36 minutes (ac-plugged in)
powercfg -change -standby-timeout-ac 36
powercfg -change -standby-timeout-dc 36


# Bios/UEFI Settings

Disable CPU SMT/Hyperthreating  - Improve Gaming performance if you have 8 or more physical cpu cores
Disable CPU Spread Spectrum     - Can improve system performance
Enable  CPU Resizable BAR       - Improve performance (Direct access to gpu memory)
Disable CPU Boost settings	    - More system stability
Disable     IOMMU
Disable CPU SVM                 
Disable CPU TPM (fTPM)          - If you use win11 you must disable the hardware checks. (bypass cpu,tpm)
Disable UEFI Secure Boot        - If you use win11 you must disable secure boot check
Disable FCH Spread Spectrum
Disable UEFI Fast Boot
Disable CSM (UEFI Bios Mode)
Disable TSME (Transparent Secure Memory Encryption)

PCIe ARI Support -> Auto
PCIe ARI Enumeration -> Auto
PCIe Spread Spectrum Clocking -> Disabled

USB Power down after PC shutdown (One of the 3 entries. Depend on UEFI/Bios)
USB Power Delivery in Soft Off State -> disable
ErP Ready -> disable
Deep Sleep / USB Power share -> disable


