# Function to display the menu
function Show-Menu {
    Clear-Host
    Write-Host "====================="
    Write-Host "   Winget Menu"
    Write-Host "====================="
    Write-Host "1. Search for a package"
    Write-Host "2. Install a package"
    Write-Host "3. Remove a package"
    Write-Host "4. Update all packages"
    Write-Host "5. Exit"
    Write-Host "====================="
}

# Function to search for a package
function Search-Package {
    $packageName = Read-Host "Enter the package name to search"
    winget search $packageName
    Pause
}

# Function to install a package
function Install-Package {
    $packageName = Read-Host "Enter the package name to install"
    winget install --accept-source-agreements --accept-package-agreements --no-hash $packageName
    Pause
}

# Function to remove a package
function Remove-Package {
    $packageName = Read-Host "Enter the package name to remove"
    winget uninstall --accept-source-agreements --accept-package-agreements --no-hash $packageName
    Pause
}

# Function to update all packages
function Update-AllPackages {
    winget upgrade --all --accept-source-agreements --accept-package-agreements --no-hash
    Pause
}

# Main loop
do {
    Show-Menu
    $choice = Read-Host "Please select an option (1-5)"
    
    switch ($choice) {
        '1' { Search-Package }
        '2' { Install-Package }
        '3' { Remove-Package }
        '4' { Update-AllPackages }
        '5' { Write-Host "Exiting..."; exit }
        default { Write-Host "Invalid option. Please try again." }
    }
} while ($true)