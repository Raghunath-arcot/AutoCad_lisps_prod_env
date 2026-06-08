@echo off
setlocal

set "BUNDLE_SOURCE=%~dp0Payload\CADSubscriptionTools.bundle"
set "LICENSE_SOURCE=%~dp0Payload\License\license-template.lsp"
set "PLUGIN_ROOT=%APPDATA%\Autodesk\ApplicationPlugins"
set "BUNDLE_DEST=%PLUGIN_ROOT%\CADSubscriptionTools.bundle"
set "LICENSE_DEST_DIR=%APPDATA%\CADSubscriptionTools\License"
set "LICENSE_DEST=%LICENSE_DEST_DIR%\license.lsp"

if not exist "%BUNDLE_SOURCE%" (
  echo Payload missing: %BUNDLE_SOURCE%
  echo Keep this BAT/EXE next to the Payload folder.
  pause
  exit /b 1
)

echo Installing CAD Subscription Tools...
echo.

if exist "%BUNDLE_DEST%" (
  rmdir /s /q "%BUNDLE_DEST%"
)

mkdir "%PLUGIN_ROOT%" 2>nul
xcopy "%BUNDLE_SOURCE%" "%BUNDLE_DEST%\" /E /I /Y >nul

mkdir "%LICENSE_DEST_DIR%" 2>nul
if not exist "%LICENSE_DEST%" (
  copy "%LICENSE_SOURCE%" "%LICENSE_DEST%" >nul
)

echo Installed AutoCAD bundle:
echo %BUNDLE_DEST%
echo.
echo License file:
echo %LICENSE_DEST%
echo.
echo Next steps:
echo 1. Close and reopen AutoCAD.
echo 2. Run CPTACTIVATE inside AutoCAD.
echo 3. Run CPTABOUT to verify installation.
echo.
pause
