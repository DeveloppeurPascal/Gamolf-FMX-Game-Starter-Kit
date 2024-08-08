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
  _SceneAncestor,
  FMX.Objects;

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

procedure TSceneBackground.FinalizeScene;
begin
  inherited;
  // TODO : stop your background features and free it's memory if it's not owned by Self
end;

procedure TSceneBackground.InitializeScene;
begin
  inherited;
  SendToBack;

  // TODO : start what you want to do in your game background, remove the default TRectangle or do anything else
end;

procedure TSceneBackground.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : use it if you have texts in the background scene
end;

end.
