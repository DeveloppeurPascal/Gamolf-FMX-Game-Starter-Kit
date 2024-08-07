unit uDMAboutBox;

interface

uses
  System.SysUtils,
  System.Classes,
  FMX.Types,
  Olf.FMX.AboutDialog;

type
  TAboutBox = class(TDataModule)
    OlfAboutDialog1: TOlfAboutDialog;
    procedure DataModuleCreate(Sender: TObject);
    procedure OlfAboutDialog1URLClick(const AURL: string);
  private
  protected
  public
    class function Current: TAboutBox;
    class procedure ShowModal;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  uDMAboutBoxLogoStorrage,
  uConsts,
  u_urlOpen, uTxtAboutDescription, uTxtAboutLicense;

{$R *.dfm}

var
  LAboutBox: TAboutBox;

  { TAboutBox }

class function TAboutBox.Current: TAboutBox;
begin
  if not assigned(LAboutBox) then
    LAboutBox := TAboutBox.create(nil);

  result := LAboutBox;
end;

procedure TAboutBox.DataModuleCreate(Sender: TObject);
var
  dm: TdmAboutBoxLogo;
begin
  OlfAboutDialog1.Titre := CAboutGameTitle;
  OlfAboutDialog1.VersionNumero := CAboutVersionNumber;
  OlfAboutDialog1.VersionDate := CAboutVersionDate;
  OlfAboutDialog1.Copyright := CAboutCopyright;
  OlfAboutDialog1.URL := CAboutGameURL;
  dm := TdmAboutBoxLogo.create(self);
  OlfAboutDialog1.Images := dm.imgLogo;
  OlfAboutDialog1.ImageIndex := 0;
  OlfAboutDialog1.ReplaceMainFormCaption := true;
  // TODO : prendre en charge les demandes de changement de langue de l'interface utilisateur
end;

procedure TAboutBox.OlfAboutDialog1URLClick(const AURL: string);
begin
  url_Open_In_Browser(AURL);
end;

class procedure TAboutBox.ShowModal;
begin
  Current.OlfAboutDialog1.Execute;
end;

initialization

LAboutBox := nil;
TThread.ForceQueue(nil,
  procedure
  begin
    LAboutBox := TAboutBox.Current;
  end);

finalization

LAboutBox.free;

end.
