unit uSceneGame;

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
  System.Messaging,
  FMX.Controls.Presentation,
  Gamolf.FMX.HelpBar,
  FMX.Layouts,
  FMX.Effects;

type
  TSceneGame = class(T__SceneAncestor)
    Label1: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    lblScore: TLabel;
    lblUserPseudo: TLabel;
    lblLevel: TLabel;
    btnScore: TButton;
    btnLevel: TButton;
    btnPseudo: TButton;
    btnGoWin: TButton;
    btnGoLost: TButton;
    FlowLayout1: TFlowLayout;
    btnPause: TButton;
    GlowEffect1: TGlowEffect;
    GlowEffect2: TGlowEffect;
    GlowEffect3: TGlowEffect;
    procedure btnGoWinClick(Sender: TObject);
    procedure btnGoLostClick(Sender: TObject);
    procedure btnScoreClick(Sender: TObject);
    procedure btnLevelClick(Sender: TObject);
    procedure btnPseudoClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
  private
  protected
    procedure DoScoreChanged(const Sender: TObject; const Msg: TMessage);
    procedure ShowScore;
    procedure DoLevelChanged(const Sender: TObject; const Msg: TMessage);
    procedure ShowLevel;
    procedure DoUserPseudoChanged(const Sender: TObject; const Msg: TMessage);
    procedure ShowUserPseudo;
  public
    procedure InitializeScene; override;
    procedure FinalizeScene; override;
    procedure TranslateTexts(const Language: string); override;
  end;

implementation

{$R *.fmx}

uses
  FMX.DialogService,
  uScene,
  uConsts,
  uGameData;

{ TSceneGame }

procedure TSceneGame.btnGoLostClick(Sender: TObject);
begin
  TGameData.DefaultGameData.StopGame;
  TScene.Current := TSceneType.GameOverLost;
end;

procedure TSceneGame.btnGoWinClick(Sender: TObject);
begin
  TGameData.DefaultGameData.StopGame;
  TScene.Current := TSceneType.GameOverWin;
end;

procedure TSceneGame.btnLevelClick(Sender: TObject);
begin
  TGameData.DefaultGameData.Level := TGameData.DefaultGameData.Level + 1;
end;

procedure TSceneGame.btnPauseClick(Sender: TObject);
begin
  TGameData.DefaultGameData.PauseGame;
  TScene.Current := TSceneType.Home;
end;

procedure TSceneGame.btnPseudoClick(Sender: TObject);
begin
  TDialogService.InputQuery('Please give me', ['Your pseudo or name'],
    [TGameData.DefaultGameData.UserPseudo],
    procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      if (AResult = mrok) and (length(AValues) = 1) then
        TGameData.DefaultGameData.UserPseudo := AValues[0];
    end);
end;

procedure TSceneGame.btnScoreClick(Sender: TObject);
begin
  TGameData.DefaultGameData.Score := TGameData.DefaultGameData.Score +
    random(100) + 5;
end;

procedure TSceneGame.DoLevelChanged(const Sender: TObject; const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TLevelChangedMessage) then
    ShowLevel;
end;

procedure TSceneGame.DoScoreChanged(const Sender: TObject; const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TScoreChangedMessage) then
    ShowScore;
end;

procedure TSceneGame.DoUserPseudoChanged(const Sender: TObject;
const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TPseudoChangedMessage) then
    ShowUserPseudo;
end;

procedure TSceneGame.FinalizeScene;
begin
  inherited;
  TMessageManager.DefaultManager.Unsubscribe(TScoreChangedMessage,
    DoScoreChanged, true);
  TMessageManager.DefaultManager.Unsubscribe(TLevelChangedMessage,
    DoLevelChanged, true);
  TMessageManager.DefaultManager.Unsubscribe(TPseudoChangedMessage,
    DoUserPseudoChanged, true);

  // stop your game loop
  // stop your workers
  // etc...

  // TODO : à compléter
end;

procedure TSceneGame.InitializeScene;
begin
  inherited;
  ShowScore;
  TMessageManager.DefaultManager.SubscribeToMessage(TScoreChangedMessage,
    DoScoreChanged);
  ShowLevel;
  TMessageManager.DefaultManager.SubscribeToMessage(TLevelChangedMessage,
    DoLevelChanged);
  ShowUserPseudo;
  TMessageManager.DefaultManager.SubscribeToMessage(TPseudoChangedMessage,
    DoUserPseudoChanged);

  // start your game loop
  // start your workers
  // etc...

  // TODO : à compléter
end;

procedure TSceneGame.ShowLevel;
begin
  lblLevel.Text := 'Level ' + TGameData.DefaultGameData.Level.ToString;
end;

procedure TSceneGame.ShowScore;
begin
  lblScore.Text := 'Score ' + TGameData.DefaultGameData.Score.ToString;
end;

procedure TSceneGame.ShowUserPseudo;
begin
  lblUserPseudo.Text := 'Player "' + TGameData.DefaultGameData.UserPseudo + '"';
end;

procedure TSceneGame.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : à compléter
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneGame;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Game) then
    begin
      NewScene := TSceneGame.Create(application.mainform);
      NewScene.Parent := application.mainform;
      TScene.RegisterScene(TSceneType.Game, NewScene);
    end;
  end);

end.
