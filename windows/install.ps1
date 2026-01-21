# install.ps1
# Run as Administrator

if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Host "Please run this script as Administrator!" -ForegroundColor Red
    exit 1
}

Start-Transcript -Path install.log

Set-ExecutionPolicy Bypass -Scope Process -Force
$ErrorActionPreference = "Stop"

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$ScriptRoot\config.ps1"

Write-Host "🚀 Starting Windows Dev Environment Setup..." -ForegroundColor Cyan

function Run-Installer($name, $path) {
    Write-Host "`n-> Installing $name..." -ForegroundColor Yellow
    & $path
    Write-Host "[OK] $name installed" -ForegroundColor Green
}

if ($Install.Choco)    { Run-Installer "Chocolatey" "$ScriptRoot\installers\choco.ps1" }
if ($Install.Scoop)    { Run-Installer "Scoop"       "$ScriptRoot\installers\scoop.ps1" }
if ($Install.DevTools) { Run-Installer "Dev Tools"   "$ScriptRoot\installers\devtools.ps1" }
if ($Install.AppList)  { Run-Installer "App List"    "$ScriptRoot\installers\app_list.ps1" }

Write-Host "All done! Please reboot if Docker was installed." -ForegroundColor Cyan
Stop-Transcript
