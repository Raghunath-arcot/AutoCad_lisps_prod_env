param(
  [string]$InnoSetupCompiler = ""
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$IssFile = Join-Path $Root "installer\CADSubscriptionTools.iss"
$OutputExe = Join-Path $Root "pendrive\CADSubscriptionTools_Setup.exe"

if (-not (Test-Path $IssFile)) {
  throw "Installer script not found: $IssFile"
}

if ([string]::IsNullOrWhiteSpace($InnoSetupCompiler)) {
  $candidates = @(
    "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
    "${env:ProgramFiles}\Inno Setup 6\ISCC.exe"
  )
  $InnoSetupCompiler = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
}

if (-not $InnoSetupCompiler -or -not (Test-Path $InnoSetupCompiler)) {
  throw "Inno Setup compiler not found. Install Inno Setup 6, or pass -InnoSetupCompiler C:\Path\ISCC.exe"
}

& $InnoSetupCompiler $IssFile

if (Test-Path $OutputExe) {
  Write-Host "Built installer:" -ForegroundColor Green
  Write-Host $OutputExe
  Write-Host ""
  Write-Host "Copy the full pendrive folder to USB, not only the EXE."
} else {
  throw "Build finished, but installer EXE was not found: $OutputExe"
}
