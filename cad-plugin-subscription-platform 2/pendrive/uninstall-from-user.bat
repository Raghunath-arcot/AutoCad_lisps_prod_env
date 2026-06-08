@echo off
setlocal

set "BUNDLE_DEST=%APPDATA%\Autodesk\ApplicationPlugins\CADSubscriptionTools.bundle"

echo Removing CAD Subscription Tools AutoCAD bundle...

if exist "%BUNDLE_DEST%" (
  rmdir /s /q "%BUNDLE_DEST%"
  echo Removed:
  echo %BUNDLE_DEST%
) else (
  echo Bundle not found:
  echo %BUNDLE_DEST%
)

echo.
echo The local license file is intentionally kept at:
echo %APPDATA%\CADSubscriptionTools\License\license.lsp
echo.
pause
