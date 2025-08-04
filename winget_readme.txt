winget (Windows Paketmanager)

Befehl	Beschreibung

winget search <name>	 Sucht nach verfügbaren Paketen im Repository
winget install <name>	 Installiert eine Anwendung
winget uninstall <name>  Deinstalliert ein Programm
winget list	         Zeigt installierte Programme an
winget upgrade	         Listet Programme mit verfügbaren Updates
winget upgrade --all	 Aktualisiert alle installierbaren Programme automatisch
winget show <name>	 Zeigt Paketdetails, Quelle, Versionen und Installationsart
winget source list	 Zeigt konfigurierte Paketquellen
winget settings	         Öffnet Konfigurationsdatei (JSON) zur Feinjustierung


Programme mit PowerShell automatisiert installieren

Gerade für IT-affine Anwender, Techniker und Administratoren liegt der wahre Vorteil von winget in der Möglichkeit, mehrere Programme über ein Skript zu installieren – z. B. direkt nach einer Windows-Neuinstallation.

Beispiel: PowerShell-Installationsskript


$programme = @(
    "Google.Chrome",
    "Mozilla.Firefox",
    "7zip.7zip",
    "Notepad++.Notepad++",
    "VideoLAN.VLC",
    "TheDocumentFoundation.LibreOffice"
)

foreach ($p in $programme) {
    winget install --id=$p --accept-package-agreements --accept-source-agreements --silent
}


Fehlerquellen erkennen und beheben

Beim Arbeiten mit winget können verschiedene Fehlertypen auftreten. Die häufigsten Ursachen und Lösungsansätze:

Problemtyp	                   Mögliche Ursache	                                  Lösung
Paket wird nicht gefunden	   Schreibfehler oder mehrere gleichnamige Pakete	winget search und dann exakte --id verwenden
Installation bricht ab	           Paket benötigt Benutzerinteraktion	                --silent ggf. nicht unterstützt – Alternativpaket prüfen
Download schlägt fehl	           Netzwerkprobleme, blockierte Quelle, Proxy nötig	Internetzugang prüfen, ggf. alternative Quelle konfigurieren
Versionsparameter wird ignoriert   Version nicht im Manifest vorhanden	                winget show zur Versionsprüfung nutzen
Fehlercode 0x8a15000f	           Paket kann nicht still installiert werden	        Nur interaktive Installation oder manuelle Lösung möglich