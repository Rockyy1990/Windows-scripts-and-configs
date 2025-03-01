# Function to display the menu
function Show-Menu {
    Clear-Host
    Write-Host "====================="
    Write-Host "   PowerShell Menu   "
    Write-Host "====================="
    Write-Host "1. Install ASP.NET 4.8"
    Write-Host "2. Install Windows Sandbox"
    Write-Host "3. Install Windows Subsystem for Linux (WSL)"
    Write-Host "4. Remove Windows Search"
    Write-Host "5. Launch Explorer in Separate Process"
    Write-Host "6. Show Known File Extensions"
    Write-Host "7. Enable Verbose Login"
    Write-Host "8. Compact Explorer View"
    Write-Host "9. Exit"
}

# Function to install ASP.NET 4.8
function Install-AspNet {
    Write-Host "Installing ASP.NET 4.8..."
    Start-Process -FilePath "DISM.exe" -ArgumentList "/Online", "/Enable-Feature", "/FeatureName:NetFx4", "/All" -Wait
    Write-Host "ASP.NET 4.8 installation completed."
}

# Function to install Windows Sandbox
function Install-WindowsSandbox {
    Write-Host "Installing Windows Sandbox..."
    Start-Process -FilePath "DISM.exe" -ArgumentList "/Online", "/Enable-Feature", "/FeatureName:Containers-DisposableClientVM", "/All" -Wait
    Write-Host "Windows Sandbox installation completed."
}

# Function to install WSL
function Install-WSL {
    Write-Host "Installing Windows Subsystem for Linux (WSL)..."
    Start-Process -FilePath "wsl.exe" -ArgumentList "--install" -Wait
    Write-Host "WSL installation completed."
}

# Function to remove Windows Search
function Remove-WindowsSearch {
    Write-Host "Removing Windows Search..."
    Start-Process -FilePath "DISM.exe" -ArgumentList "/Online", "/Disable-Feature", "/FeatureName:Search" -Wait
    Write-Host "Windows Search removal completed."
}

# Function to launch Explorer in a separate process
function Launch-ExplorerSeparate {
    Write-Host "Launching Explorer in a separate process..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "SeparateProcess" -Value 1
    Write-Host "Explorer will now launch in a separate process."
}

# Function to show known file extensions
function Show-KnownFileExtensions {
    Write-Host "Showing known file extensions..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
    Write-Host "Known file extensions will now be shown."
}

# Function to enable verbose login
function Enable-VerboseLogin {
    Write-Host "Enabling verbose login..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Value 1
    Write-Host "Verbose login has been enabled."
}

# Function to compact Explorer view
function Compact-ExplorerView {
    Write-Host "Enabling compact view in Explorer..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "CompactView" -Value 1
    Write-Host "Compact view in Explorer has been enabled."
}

# Main loop
do {
    Show-Menu
    $choice = Read-Host "Please enter your choice (1-9)"
    
    switch ($choice) {
        1 { Install-AspNet }
        2 { Install-WindowsSandbox }
        3 { Install-WSL }
        4 { Remove-WindowsSearch }
        5 { Launch-ExplorerSeparate }
        6 { Show-KnownFileExtensions }
        7 { Enable-VerboseLogin }
        8 { Compact-ExplorerView }
        9 { Write-Host "Exiting..."; break }
        default { Write-Host "Invalid choice. Please try again." }
    }
    
    Read-Host "Press Enter to continue..."
} while ($true)