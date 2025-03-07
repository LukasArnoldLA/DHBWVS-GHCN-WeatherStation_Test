Write-Host "Datenbank wird heruntergeladen."
Invoke-WebRequest -Uri https://www.swisstransfer.com/api/download/968031e6-fb0e-4c76-b947-75f33e7b16a3 -OutFile ./database.zip
Write-Host "Datenbank wird entpackt."
Expand-Archive -Path ./database.zip -DestinationPath ./database -Force
Expand-Archive -Path ./database/database.zip -DestinationPath . -Force
Remove-Item ./database.zip
Remove-Item ./database/database.zip
Write-Host "docker-compose.yml wird heruntergeladen."
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/LukasArnoldLA/DHBWVS-GHCN-WeatherStation_Test/main/docker-compose.yml" -OutFile ".\docker-compose.yml"
Write-Host "Images werden heruntergeladen und Container erstellt."
docker compose up -d
while ($true) {
    try {
        Invoke-WebRequest -Uri http://localhost:5000 -Method Head -TimeoutSec 10
        Start-Process http://localhost:5000
        break
    } catch {
        Write-Host "Anwendung wird gestartet..."
        Start-Sleep -Seconds 5
    }
}