# Importiere die WPF Assemblies
Add-Type -AssemblyName PresentationFramework

# Erstelle das Hauptfenster
$window = New-Object System.Windows.Window
$window.Title = "YT-DLP GUI"
$window.Width = 400
$window.Height = 200
$window.WindowStartupLocation = "CenterScreen"

# Erstelle ein StackPanel für die Layout
$stackPanel = New-Object System.Windows.Controls.StackPanel
$window.Content = $stackPanel

# Erstelle ein Textfeld für die URL
$urlTextBox = New-Object System.Windows.Controls.TextBox
$urlTextBox.Width = 350
$urlTextBox.Margin = "10"
$urlTextBox.PlaceholderText = "Gib die YouTube-URL hier ein"
$stackPanel.Children.Add($urlTextBox)

# Erstelle einen Button zum Starten des Downloads
$downloadButton = New-Object System.Windows.Controls.Button
$downloadButton.Content = "Download"
$downloadButton.Margin = "10"
$stackPanel.Children.Add($downloadButton)

# Erstelle ein Label für den Fortschritt
$progressLabel = New-Object System.Windows.Controls.Label
$progressLabel.Margin = "10"
$stackPanel.Children.Add($progressLabel)

# Funktion zum Ausführen des Downloads
$downloadButton.Add_Click({
    $url = $urlTextBox.Text
    if (-not [string]::IsNullOrWhiteSpace($url)) {
        $progressLabel.Content = "Lade herunter..."
        $progressLabel.Foreground = [System.Windows.Media.Brushes]::Black

        # Starte den yt-dlp Prozess
        $process = Start-Process -FilePath ".\yt-dlp.exe" -ArgumentList $url -NoNewWindow -PassThru -RedirectStandardOutput "output.txt" -RedirectStandardError "error.txt"

        # Überwache den Fortschritt
        while (-not $process.HasExited) {
            Start-Sleep -Seconds 1
            $output = Get-Content "output.txt" -Tail 10
            $progressLabel.Content = $output -join "`n"
        }

        $progressLabel.Content = "Download abgeschlossen!"
        $progressLabel.Foreground = [System.Windows.Media.Brushes]::Green
    } else {
        $progressLabel.Content = "Bitte gib eine gültige URL ein."
        $progressLabel.Foreground = [System.Windows.Media.Brushes]::Red
    }
})

# Zeige das Fenster an
$window.ShowDialog() | Out-Null