unit uSceneCredits;

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
  FMX.Controls.Presentation,
  Gamolf.FMX.HelpBar;

type
  TSceneCredits = class(T__SceneAncestor)
    Label1: TLabel;
  private
  protected
  public
    procedure InitializeScene; override;
    procedure FinalizeScene; override;
    procedure TranslateTexts(const Language: string); override;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  uScene;

{ TSceneCredits }

procedure TSceneCredits.FinalizeScene;
begin
  inherited;
  // TODO : à compléter
end;

procedure TSceneCredits.InitializeScene;
begin
  inherited;
  // TODO : à compléter
end;

procedure TSceneCredits.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : à compléter
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneCredits;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Credits) then
    begin
      NewScene := TSceneCredits.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Credits, NewScene);
    end;
  end);

end.
