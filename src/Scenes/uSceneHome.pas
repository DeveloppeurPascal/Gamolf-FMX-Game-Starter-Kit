unit uSceneHome;

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
  Gamolf.FMX.HelpBar,
  FMX.Layouts;

type
  TSceneHome = class(T__SceneAncestor)
    Label1: TLabel;
    FlowLayout1: TFlowLayout;
    btnNewGame: TButton;
    btnContinue: TButton;
    btnHallOfFame: TButton;
    btnOptions: TButton;
    btnCredits: TButton;
    btnQuit: TButton;
    procedure btnNewGameClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure btnHallOfFameClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
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
  uGameData,
  uConsts,
  uSoundEffects,
  uUIElements;

{ TSceneHome }

procedure TSceneHome.btnContinueClick(Sender: TObject);
begin
  TGameData.DefaultGameData.ContinueGame;
  TScene.Current := TSceneType.game;
end;

procedure TSceneHome.btnCreditsClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Credits;
end;

procedure TSceneHome.btnHallOfFameClick(Sender: TObject);
begin
  TScene.Current := TSceneType.HallOfFame;
end;

procedure TSceneHome.btnNewGameClick(Sender: TObject);
begin
  TGameData.DefaultGameData.StartANewGame;
  TScene.Current := TSceneType.game;
end;

procedure TSceneHome.btnOptionsClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Options;
end;

procedure TSceneHome.btnQuitClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Exit;
end;

procedure TSceneHome.FinalizeScene;
begin
  inherited;
  // TODO : à compléter
  TSoundEffects.Play(TSoundEffectType.demo);
end;

procedure TSceneHome.InitializeScene;
begin
  inherited;

  btnContinue.Visible := TGameData.DefaultGameData.IsPaused;
{$IF Defined(IOS) or Defined(ANDROID)}
  btnQuit.Visible := false;
{$ENDIF}
  if btnContinue.Visible then
  begin
    TUIItemsList.Current.AddControl(btnNewGame, nil, btnContinue, btnContinue,
      nil, true);
    TUIItemsList.Current.AddControl(btnContinue, btnNewGame, btnHallOfFame,
      btnHallOfFame, btnNewGame);
    TUIItemsList.Current.AddControl(btnHallOfFame, btnContinue, btnOptions,
      btnOptions, btnContinue);
  end
  else
  begin
    TUIItemsList.Current.AddControl(btnNewGame, nil, btnHallOfFame,
      btnHallOfFame, nil, true);
    TUIItemsList.Current.AddControl(btnHallOfFame, btnNewGame, btnOptions,
      btnOptions, btnNewGame);
  end;
  TUIItemsList.Current.AddControl(btnOptions, btnHallOfFame, btnCredits,
    btnCredits, btnHallOfFame);
  if btnQuit.Visible then
  begin
    TUIItemsList.Current.AddControl(btnCredits, btnOptions, btnQuit, btnQuit,
      btnOptions);
    TUIItemsList.Current.AddControl(btnQuit, btnCredits, nil, nil, btnCredits,
      false, true);
  end
  else
    TUIItemsList.Current.AddControl(btnCredits, btnOptions, nil, nil,
      btnOptions);

  TSoundEffects.Play(TSoundEffectType.demo);
end;

procedure TSceneHome.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : à compléter
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneHome;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Home) then
    begin
      NewScene := TSceneHome.Create(application.mainform);
      NewScene.Parent := application.mainform;
      TScene.RegisterScene(TSceneType.Home, NewScene);
    end;
  end);

end.
