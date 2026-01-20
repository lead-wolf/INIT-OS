# installers/devtools.ps1

Write-Host "Installing Dev Tools..." -ForegroundColor Cyan

if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    throw "Chocolatey not installed"
}

choco install vscode -y
choco install docker-desktop -y
choco install openjdk --version=21 -y
choco install intellijidea-community -y
choco install gh -y
choco install git -y

Write-Host "Dev tools installed" -ForegroundColor Green
