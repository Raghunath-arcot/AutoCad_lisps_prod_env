# Pendrive Admin Instructions

Copy this full `pendrive` folder to your USB drive.

Expected USB layout:

```text
CADSubscriptionTools_Setup.exe
install-from-pendrive.bat
Payload/
  CADSubscriptionTools.bundle/
  License/
```

Do not rename `Payload`. The installer reads current LISP files from this folder at install time.

To add a LISP:

```powershell
..\admin\Add-LispTool.ps1 -SourceLisp "D:\MyTools\area-tool.lsp"
```

To remove a LISP:

```powershell
..\admin\Remove-LispTool.ps1 -ToolName "area-tool.lsp"
```

On the customer computer:

1. Close AutoCAD.
2. Run `CADSubscriptionTools_Setup.exe`, or run `install-from-pendrive.bat` for immediate testing before the EXE is built.
3. Open AutoCAD.
4. Run `CPTACTIVATE`.
5. Run your LISP command, or run `CPTABOUT` to confirm the loader is active.

Important: if you change LISP files on the pendrive after installing on a customer computer, run the installer again on that customer computer to copy the latest files.
