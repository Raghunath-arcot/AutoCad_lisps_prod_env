#define MyAppName "CAD Subscription Tools"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Your Company"

[Setup]
AppId={{B66C8853-5A1E-4C8F-8614-3D7642CC4A23}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={userappdata}\CADSubscriptionTools
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputDir=..\pendrive
OutputBaseFilename=CADSubscriptionTools_Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest
UninstallDisplayName={#MyAppName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Dirs]
Name: "{userappdata}\Autodesk\ApplicationPlugins"
Name: "{userappdata}\CADSubscriptionTools"
Name: "{userappdata}\CADSubscriptionTools\License"
Name: "{userappdata}\CADSubscriptionTools\Logs"

[InstallDelete]
Type: filesandordirs; Name: "{userappdata}\Autodesk\ApplicationPlugins\CADSubscriptionTools.bundle"

[Files]
Source: "{src}\Payload\CADSubscriptionTools.bundle\*"; DestDir: "{userappdata}\Autodesk\ApplicationPlugins\CADSubscriptionTools.bundle"; Flags: external recursesubdirs createallsubdirs ignoreversion
Source: "{src}\Payload\License\license-template.lsp"; DestDir: "{userappdata}\CADSubscriptionTools\License"; DestName: "license.lsp"; Flags: external ignoreversion onlyifdoesntexist

[Run]
Filename: "{cmd}"; Parameters: "/C echo Installed {#MyAppName} on %DATE% %TIME% > ""{userappdata}\CADSubscriptionTools\Logs\install.log"""; Flags: runhidden

[UninstallDelete]
Type: filesandordirs; Name: "{userappdata}\Autodesk\ApplicationPlugins\CADSubscriptionTools.bundle"

[Code]
function InitializeSetup(): Boolean;
begin
  if not DirExists(ExpandConstant('{src}\Payload\CADSubscriptionTools.bundle')) then
  begin
    MsgBox('Payload folder missing. Keep CADSubscriptionTools_Setup.exe next to the Payload folder on the pendrive.', mbError, MB_OK);
    Result := False;
  end
  else
    Result := True;
end;
