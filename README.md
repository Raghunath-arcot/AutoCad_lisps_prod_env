
# AutoCad_Lisps_Prod_Env

## CAD Plugin Subscription Platform
How To Execute

On Windows:

cd C:\Path\To\cad-plugin-subscription-platform
.\build-installer.ps1
That creates:

pendrive\CADSubscriptionTools_Setup.exe
Copy the full pendrive folder to your USB drive, not only the EXE, because the EXE reads the current Payload folder so you can add/modify/delete LISP files on the pendrive.

For immediate testing before building the EXE, run this on the customer Windows computer:

pendrive\install-from-pendrive.bat
Then open AutoCAD and run:

CPTACTIVATE
CPTABOUT
CPTHELLO
To add/remove LISP files:

.\admin\Add-LispTool.ps1 -SourceLisp "C:\MyLisps\tool.lsp"
.\admin\Remove-LispTool.ps1 -ToolName "tool.lsp"



A Windows installer scaffold for distributing licensed AutoLISP tools to AutoCAD users.

The current implementation is a practical pendrive installer:

- Admin keeps approved `.lsp` files in:
  `pendrive\Payload\CADSubscriptionTools.bundle\Contents\Tools`
- Admin runs helper scripts to add/remove LISP files and update `tools-manifest.lsp`
- The installer copies the AutoCAD bundle into the customer's AutoCAD plugin folder
- AutoCAD loads `CPT_Loader.lsp` on startup
- The loader checks a local license file and loads only approved LISP files listed in the manifest

---

# Folder Layout

```text
cad-plugin-subscription-platform/
│
├── build-installer.ps1
│
├── installer/
│   └── CADSubscriptionTools.iss
│
├── pendrive/
│   ├── CADSubscriptionTools_Setup.exe
│   ├── install-from-pendrive.bat
│   ├── uninstall-from-user.bat
│   ├── README_PENDRIVE_ADMIN.md
│   │
│   ├── Payload/
│   │   └── CADSubscriptionTools.bundle/
│   │       ├── PackageContents.xml
│   │       │
│   │       └── Contents/
│   │           ├── CPT_Loader.lsp
│   │           │
│   │           └── Tools/
│   │               ├── tools-manifest.lsp
│   │               ├── sample-hello.lsp
│   │               └── sample-layer-tools.lsp
│   │
│   └── License/
│       └── license-template.lsp
│
├── admin/
│   ├── Add-LispTool.ps1
│   ├── Remove-LispTool.ps1
│   └── Generate-OfflineLicenseTemplate.ps1
│
├── customer-portal/
├── server-api/
└── docs/
```

---

# Build The EXE On Windows

## Prerequisites

Install Inno Setup 6:

https://jrsoftware.org/isinfo.php

## Build Process

Open PowerShell:

```powershell
cd C:\Path\To\cad-plugin-subscription-platform
```

Run:

```powershell
.\build-installer.ps1
```

After successful build:

```text
pendrive\CADSubscriptionTools_Setup.exe
```

will be generated.

---

# Copy To USB Drive

Copy the complete `pendrive` folder to your USB drive.

> Do NOT copy only the EXE file because the installer reads the Payload folder during installation.

---

# Immediate Test Without Building EXE

For testing purposes:

```bat
pendrive\install-from-pendrive.bat
```

This performs the same plugin installation process without generating the EXE.

---

# Add A New LISP Tool

Run:

```powershell
.\admin\Add-LispTool.ps1 -SourceLisp "C:\MyLisps\road-chainage.lsp"
```

This will:

- Copy the LISP file into the payload
- Update `tools-manifest.lsp`

Location:

```text
pendrive\Payload\CADSubscriptionTools.bundle\Contents\Tools\
```

---

# Remove A LISP Tool

Run:

```powershell
.\admin\Remove-LispTool.ps1 -ToolName "road-chainage.lsp"
```

This removes the file and updates the manifest automatically.

---

# Install On Customer Computer

## Option 1 - Production Installer

Run:

```text
CADSubscriptionTools_Setup.exe
```

## Option 2 - Test Installer

Run:

```text
install-from-pendrive.bat
```

---

# Installation Steps

1. Insert USB drive
2. Close AutoCAD
3. Run installer
4. Open AutoCAD
5. Run:

```text
CPTACTIVATE
```

6. Enter customer license key

---

# Test Commands

Verify installation using:

```text
CPTABOUT
```

```text
CPTHELLO
```

```text
CPTMAKELAYER
```

---

# Installation Locations

## AutoCAD Bundle

```text
%APPDATA%\Autodesk\ApplicationPlugins\CADSubscriptionTools.bundle
```

## License File

```text
%APPDATA%\CADSubscriptionTools\License\license.lsp
```

---

# AutoCAD Startup Flow

```text
AutoCAD Starts
      ↓
CPT_Loader.lsp Loads
      ↓
License Validation
      ↓
Read tools-manifest.lsp
      ↓
Load Approved LISP Files
      ↓
Commands Become Available
```

---

# License Activation Flow

```text
Customer Installs Plugin
            ↓
Runs CPTACTIVATE
            ↓
Enters License Key
            ↓
License File Created
            ↓
Plugin Activated
```

---

# Current Features

- Offline installer
- AutoCAD plugin bundle deployment
- License-based activation
- Manifest-driven LISP loading
- Easy add/remove tool management
- No Windows administrator rights required
- USB distribution support

---

# Production Notes

This scaffold is suitable for:

- MVP
- Prototype deployments
- Offline customer installations

This is NOT a fully secure production licensing system.

---

# Production Roadmap

## Licensing

- Server-side subscription validation
- Online activation
- Device activation limits
- Device deactivation

## Security

- Signed license files
- Encrypted LISP packages
- Tamper protection
- Secure update delivery

## Administration

- Customer portal
- Admin dashboard
- License management
- Subscription management

## Updates

- Remote updates
- Version control
- Automatic synchronization

## Protection

- Device fingerprinting
- Compiled loader/helper service
- Advanced license enforcement

---

# Future Architecture

```text
Admin Portal
      ↓
Server API
      ↓
License Service
      ↓
AutoCAD Plugin Loader
      ↓
Encrypted LISP Packages
      ↓
Customer AutoCAD Environment
```

---

# Disclaimer

This project is currently an offline AutoCAD plugin distribution scaffold.

Additional licensing, security, update management, and subscription infrastructure should be implemented before commercial deployment.
