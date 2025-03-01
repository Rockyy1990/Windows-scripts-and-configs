# Must be run as Admin

# Set the execution policy to allow scripts to run
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser  -Force

Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

# List of applications to install
$applications = @(
    "VideoLAN.VLC",
    "AIMP.AIMP",
    "Mozilla.Thunderbird",
    "TheDocumentFoundation.LibreOffice",
    "Waterfox.Waterfox",
    "Freac.Freac",
    "Notepad++.Notepad++"
)

# Install each application using winget
foreach ($app in $applications) {
    try {
        Write-Host "Installing $app..."
        winget install --id $app --exact --silent
        Write-Host "$app installed successfully."
    } catch {
        Write-Host "Failed to install $app. Error: $_"
    }
}

Write-Host "All installations attempted."