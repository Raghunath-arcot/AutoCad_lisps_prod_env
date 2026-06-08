param(
  [Parameter(Mandatory = $true)]
  [string]$LicenseKey,

  [string]$CustomerName = "",
  [string]$ExpiresOn = ""
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$LicenseFile = Join-Path $Root "pendrive\Payload\License\license-template.lsp"

$lines = @(
  ';;; Offline license template installed on first setup only.',
  ';;; For production, replace this with server validation and signed license files.',
  "",
  '(setq CPT_LICENSE_STATUS "ACTIVE")',
  "(setq CPT_LICENSE_KEY `"$LicenseKey`")",
  "(setq CPT_LICENSE_CUSTOMER `"$CustomerName`")",
  "(setq CPT_LICENSE_EXPIRES_ON `"$ExpiresOn`")",
  '(setq CPT_LICENSE_MACHINE "")'
)

Set-Content -Path $LicenseFile -Value $lines -Encoding ASCII

Write-Host "Generated offline license template:" -ForegroundColor Green
Write-Host $LicenseFile
Write-Host "Note: existing customer installs keep their existing %APPDATA%\CADSubscriptionTools\License\license.lsp file."
