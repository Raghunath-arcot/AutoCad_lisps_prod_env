# CAD Plugin Subscription Platform

This is a Windows installer scaffold for distributing licensed AutoLISP tools to AutoCAD users.

The current implementation is a practical pendrive installer:

- Admin keeps approved `.lsp` files in `pendrive\Payload\CADSubscriptionTools.bundle\Contents\Tools`.
- Admin runs helper scripts to add/remove LISP files and update `tools-manifest.lsp`.
- The installer copies the AutoCAD bundle into the customer's per-user AutoCAD plugin folder.
- AutoCAD loads `CPT_Loader.lsp` on startup.
- The loader checks a local license file and then loads only the approved LISP files listed in the manifest.

## Folder Layout

```text
cad-plugin-subscription-platform/
  build-installer.ps1
  installer/
    CADSubscriptionTools.iss
  pendrive/
    CADSubscriptionTools_Setup.exe        Generated after build
    install-from-pendrive.bat             Immediate test installer
    uninstall-from-user.bat
    README_PENDRIVE_ADMIN.md
    Payload/
      CADSubscriptionTools.bundle/
        PackageContents.xml
        Contents/
          CPT_Loader.lsp
          Tools/
            tools-manifest.lsp
            sample-hello.lsp
            sample-layer-tools.lsp
      License/
        license-template.lsp
  admin/
    Add-LispTool.ps1
    Remove-LispTool.ps1
    Generate-OfflineLicenseTemplate.ps1
  customer-portal/
  server-api/
  docs/
```

## Build The EXE On Windows

1. Install Inno Setup 6:
   [https://jrsoftware.org/isinfo.php](https://jrsoftware.org/isinfo.php)

2. Open PowerShell in this folder:

```powershell
cd C:\Path\To\cad-plugin-subscription-platform
```

3. Build the installer:

```powershell
.\build-installer.ps1
```

4. After build, this file will be created:

```text
pendrive\CADSubscriptionTools_Setup.exe
```

Copy the full `pendrive` folder to your USB drive. Do not copy only the EXE, because this installer intentionally reads the current external `Payload` folder at install time.

## Immediate Test Without Building EXE

On a Windows customer/test computer, you can install immediately with:

```text
pendrive\install-from-pendrive.bat
```

This performs the same core copy operation as the installer. Use this for testing before you build the `.exe`.

## Add A New LISP Tool

From PowerShell:

```powershell
.\admin\Add-LispTool.ps1 -SourceLisp "C:\MyLisps\road-chainage.lsp"
```

This copies the file into the pendrive payload and refreshes:

```text
pendrive\Payload\CADSubscriptionTools.bundle\Contents\Tools\tools-manifest.lsp
```

## Remove A LISP Tool

```powershell
.\admin\Remove-LispTool.ps1 -ToolName "road-chainage.lsp"
```

## Install On Customer Computer

1. Copy the full `pendrive` folder to the USB drive.
2. Insert the USB drive into the customer computer.
3. Close AutoCAD.
4. Run the EXE after building:

```text
CADSubscriptionTools_Setup.exe
```

Or run this test installer before the EXE exists:

```text
install-from-pendrive.bat
```

5. Open AutoCAD.
6. Run this command inside AutoCAD:

```text
CPTACTIVATE
```

7. Enter the customer license key.
8. Test the sample commands:

```text
CPTABOUT
CPTHELLO
CPTMAKELAYER
```

## Where It Installs

The installer uses a per-user install, so it does not need Windows administrator rights.

AutoCAD bundle:

```text
%APPDATA%\Autodesk\ApplicationPlugins\CADSubscriptionTools.bundle
```

License file:

```text
%APPDATA%\CADSubscriptionTools\License\license.lsp
```

## Important Production Notes

This scaffold is suitable for a first offline/pendrive prototype. It is not a secure production licensing system yet.

For production, add:

- Server-side subscription validation.
- Signed license files.
- Device activation/deactivation.
- Encrypted LISP package download.
- Compiled loader or helper service for stronger license enforcement.
- Admin portal for LISP versions and customer licenses.

## Autodesk References

AutoCAD supports loading plug-ins through a bundle folder with `PackageContents.xml`:

[Autodesk PackageContents.xml Format Reference](https://help.autodesk.com/cloudhelp/2024/ENU/AutoCAD-LT-Customization/files/GUID-BC76355D-682B-46ED-B9B7-66C95EEF2BD0.htm)

Autodesk also documents automatic loading of AutoLISP routines:

[Automatically load AutoLISP routines](https://www.autodesk.com/support/technical/article/Automatically-load-AutoLISP-routines/)
