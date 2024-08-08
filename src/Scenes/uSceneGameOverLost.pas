unit uSceneGameOverLost;

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
  TSceneGameOverLost = class(T__SceneAncestor)
    Label1: TLabel;
    btnBack: TButton;
    procedure btnBackClick(Sender: TObject);
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
  uScene,
  uConsts,
  uUIElements;

{ TSceneGameOverLost }

procedure TSceneGameOverLost.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TSceneGameOverLost.FinalizeScene;
begin
  inherited;
  // TODO : à compléter
end;

procedure TSceneGameOverLost.InitializeScene;
begin
  inherited;
  TUIItemsList.Current.AddControl(btnBack, nil, nil, nil, nil, true, true);
end;

procedure TSceneGameOverLost.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : à compléter
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneGameOverLost;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.GameOverLost) then
    begin
      NewScene := TSceneGameOverLost.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.GameOverLost, NewScene);
    end;
  end);

end.
