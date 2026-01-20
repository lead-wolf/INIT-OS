Write-Host "Installing applications..." -ForegroundColor Cyan

# ---- Chocolatey apps
choco install microsoft-windows-terminal -y
choco install coretemp -y
choco install foxitreader -y

# ---- Winget apps
winget install --id XP8K1GHCB0F1R2 -e `
  --silent `
  --accept-source-agreements `
  --accept-package-agreements

winget install --id Google.Chrome -e `
  --silent `
  --accept-source-agreements `
  --accept-package-agreements