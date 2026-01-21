# shell.ps1
# Setup PowerShell profile and Oh My Posh theme

Write-Host "Setting up PowerShell shell configuration..." -ForegroundColor Cyan

$ProfileDir = "$env:USERPROFILE\Documents\WindowsPowerShell"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Create WindowsPowerShell directory if it doesn't exist
if (!(Test-Path $ProfileDir)) {
    Write-Host "Creating directory: $ProfileDir" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
}

# Copy profile file
Write-Host "Copying Microsoft.PowerShell_profile.ps1..." -ForegroundColor Yellow
Copy-Item -Path "$ScriptDir\Microsoft.PowerShell_profile.ps1" `
          -Destination "$ProfileDir\Microsoft.PowerShell_profile.ps1" `
          -Force

# Copy theme file
Write-Host "Copying easy-term.omp.json..." -ForegroundColor Yellow
Copy-Item -Path "$ScriptDir\easy-term.omp.json" `
          -Destination "$ProfileDir\easy-term.omp.json" `
          -Force

# Install Caskaydia Mono Nerd Font
Write-Host "Installing Caskaydia Mono Nerd Font..." -ForegroundColor Yellow

if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    throw "Chocolatey not installed. Please install Chocolatey first."
}

choco install cascadia-code-nerd-font -y

Write-Host "Shell configuration completed!" -ForegroundColor Green
Write-Host "Files copied to: $ProfileDir" -ForegroundColor Green
Write-Host "Font installed: Caskaydia Mono Nerd Font" -ForegroundColor Green
Write-Host "`nℹ️  Please restart PowerShell to apply changes" -ForegroundColor Cyan