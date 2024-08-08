unit uDMHelpBarManager;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, Gamolf.FMX.HelpBar;

type
  THelpBarManager = class(TDataModule)
    DGEFMXHelpBar1: TDGEFMXHelpBar;
  private
  public
    class function Current: TDGEFMXHelpBar;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  fMain;

var
  HelpBarManager: THelpBarManager;

  { THelpBarManager }

class function THelpBarManager.Current: TDGEFMXHelpBar;
begin
  // if not assigned(HelpBarManager) then
  // HelpBarManager := THelpBarManager.create(nil);
  // result := HelpBarManager.DGEFMXHelpBar1;

  // TODO -opprem : corriger problème de parent sur le composant lorsqu'il n'est pas sur une fiche
  result := frmMain.DGEFMXHelpBar1;
end;

initialization

HelpBarManager := nil;

finalization

HelpBarManager.free;

end.
