unit uSceneBackground;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  _SceneAncestor, FMX.Objects;

type
  TSceneBackground = class(T__SceneAncestor)
    Rectangle1: TRectangle;
  private
  protected
  public
    procedure TranslateTexts(const Language: string); override;
    procedure InitializeScene; override;
    procedure FinalizeScene; override;
  end;

implementation

{$R *.fmx}
{ T__SceneAncestor1 }

procedure TSceneBackground.FinalizeScene;
begin
  inherited;

end;

procedure TSceneBackground.InitializeScene;
begin
  inherited;

end;

procedure TSceneBackground.TranslateTexts(const Language: string);
begin
  inherited;

end;

end.
