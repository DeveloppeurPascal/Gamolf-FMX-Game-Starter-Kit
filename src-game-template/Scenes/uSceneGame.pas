/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Template
///
/// Copyright 2024 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// The "Gamolf FMX Game Template" is both a "technical" example of a video
/// game developed in Delphi with everything you need inside, and a reusable
/// project template you can customize for your own games.
///
/// The files provided are fully functional. Numerous comments are included in
/// the sources to explain how they work and what you need to copy, override
/// or customize to make video games without starting from scratch.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://gametemplate.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Template
///
/// ***************************************************************************
/// File last update : 2024-08-08T21:43:26.000+02:00
/// Signature : 5b7d6272b6b264ff9a4848340c655531aca667c5
/// ***************************************************************************
/// </summary>

unit uSceneGame;

interface

{$MESSAGE WARN 'If this scene interest you save this file in your project folder and customize the copy. Don''t change the template version if you want to be able to update it.'}
// TODO : If this scene interest you save this file in your project folder and customize the copy. Don''t change the template version if you want to be able to update it.
// TODO : If you don't want it in your project remove the unit from your project

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
  FMX.Layouts,
  FMX.Effects;

type
  TSceneGame = class(T__SceneAncestor)
    Label1: TLabel;
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
    btnPlayMusic: TButton;
    btnStopMusic: TButton;
    GridPanelLayout2: TGridPanelLayout;
    lblLives: TLabel;
    GlowEffect4: TGlowEffect;
    procedure btnGoWinClick(Sender: TObject);
    procedure btnGoLostClick(Sender: TObject);
    procedure btnScoreClick(Sender: TObject);
    procedure btnLevelClick(Sender: TObject);
    procedure btnPseudoClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnPlayMusicClick(Sender: TObject);
    procedure btnStopMusicClick(Sender: TObject);
  private
  protected
    procedure DoScoreChanged(const Sender: TObject; const Msg: TMessage);
    procedure ShowScore;
    procedure DoNbLivesChanged(const Sender: TObject; const Msg: TMessage);
    procedure ShowNbLives;
    procedure DoLevelChanged(const Sender: TObject; const Msg: TMessage);
    procedure ShowLevel;
    procedure DoUserPseudoChanged(const Sender: TObject; const Msg: TMessage);
    procedure ShowUserPseudo;
    procedure DoBackgroundMusicStatusChanged(const Sender: TObject;
      const Msg: TMessage);
  public
    procedure ShowScene; override;
    procedure HideScene; override;
  end;

implementation

{$R *.fmx}

uses
  FMX.DialogService,
  uScene,
  uConsts,
  uGameData,
  uBackgroundMusic,
  uConfig,
  uUIElements,
  USVGInputPrompts,
  uDMHelpBarManager;

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

procedure TSceneGame.btnPlayMusicClick(Sender: TObject);
begin
  TBackgroundMusic.Current.OnOff(true);
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

procedure TSceneGame.btnStopMusicClick(Sender: TObject);
begin
  TBackgroundMusic.Current.OnOff(false);
end;

procedure TSceneGame.DoBackgroundMusicStatusChanged(const Sender: TObject;
const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TBackgroundMusicStatusMessage) then
  begin
    btnPlayMusic.visible := not tconfig.Current.BackgroundMusicOnOff;
    btnStopMusic.visible := tconfig.Current.BackgroundMusicOnOff;
    if btnPlayMusic.visible then
    begin
      TUIItemsList.Current.GetElementByTagObject(btnPlayMusic).LeftItem :=
        TUIItemsList.Current.GetElementByTagObject(btnPause);
      TUIItemsList.Current.GetElementByTagObject(btnPlayMusic).TopItem :=
        TUIItemsList.Current.GetElementByTagObject(btnPause);
    end
    else if TUIItemsList.Current.GetElementByTagObject(btnPlayMusic).IsFocused
    then
      TUIItemsList.Current.GetElementByTagObject(btnStopMusic).SetFocus;
    if btnStopMusic.visible then
    begin
      TUIItemsList.Current.GetElementByTagObject(btnStopMusic).LeftItem :=
        TUIItemsList.Current.GetElementByTagObject(btnPause);
      TUIItemsList.Current.GetElementByTagObject(btnStopMusic).TopItem :=
        TUIItemsList.Current.GetElementByTagObject(btnPause);
    end
    else if TUIItemsList.Current.GetElementByTagObject(btnStopMusic).IsFocused
    then
      TUIItemsList.Current.GetElementByTagObject(btnPlayMusic).SetFocus;
  end;
end;

procedure TSceneGame.DoLevelChanged(const Sender: TObject; const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TLevelChangedMessage) then
    ShowLevel;
end;

procedure TSceneGame.DoNbLivesChanged(const Sender: TObject;
const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TNbLivesChangedMessage) then
    ShowNbLives;
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

procedure TSceneGame.HideScene;
begin
  inherited;
  TMessageManager.DefaultManager.Unsubscribe(TNbLivesChangedMessage,
    DoNbLivesChanged, true);
  TMessageManager.DefaultManager.Unsubscribe(TScoreChangedMessage,
    DoScoreChanged, true);
  TMessageManager.DefaultManager.Unsubscribe(TLevelChangedMessage,
    DoLevelChanged, true);
  TMessageManager.DefaultManager.Unsubscribe(TPseudoChangedMessage,
    DoUserPseudoChanged, true);
  TMessageManager.DefaultManager.Unsubscribe(TBackgroundMusicStatusMessage,
    DoBackgroundMusicStatusChanged, true);

  // stop your game loop
  // stop your workers
  // etc...
end;

procedure TSceneGame.ShowScene;
begin
  inherited;
  ShowNbLives;
  TMessageManager.DefaultManager.SubscribeToMessage(TNbLivesChangedMessage,
    DoNbLivesChanged);
  ShowScore;
  TMessageManager.DefaultManager.SubscribeToMessage(TScoreChangedMessage,
    DoScoreChanged);
  ShowLevel;
  TMessageManager.DefaultManager.SubscribeToMessage(TLevelChangedMessage,
    DoLevelChanged);
  ShowUserPseudo;
  TMessageManager.DefaultManager.SubscribeToMessage(TPseudoChangedMessage,
    DoUserPseudoChanged);

  if TBackgroundMusic.Current.HasAValidBackgroundMusicFile then
  begin
    btnPlayMusic.visible := not tconfig.Current.BackgroundMusicOnOff;
    btnStopMusic.visible := tconfig.Current.BackgroundMusicOnOff;
  end
  else
  begin
    btnPlayMusic.visible := false;
    btnStopMusic.visible := false;
  end;
  TMessageManager.DefaultManager.SubscribeToMessage
    (TBackgroundMusicStatusMessage, DoBackgroundMusicStatusChanged);

  TUIItemsList.Current.AddControl(btnScore, nil, btnLevel, btnLevel, nil, true);
  TUIItemsList.Current.AddControl(btnLevel, btnScore, btnPseudo, btnPseudo,
    btnScore);
  TUIItemsList.Current.AddControl(btnPseudo, btnLevel, btnGoWin, btnGoWin,
    btnLevel);
  TUIItemsList.Current.AddControl(btnGoWin, btnPseudo, btnGoLost, btnGoLost,
    btnPseudo);
  TUIItemsList.Current.AddControl(btnGoLost, btnGoWin, btnPause, btnPause,
    btnGoWin);
  TUIItemsList.Current.AddControl(btnPause, btnGoLost, nil, nil, btnGoLost,
    false, true);

  if btnPlayMusic.visible then
    TUIItemsList.Current.AddControl(btnPlayMusic, btnPause, nil, nil, btnPause)
  else
    TUIItemsList.Current.AddControl(btnPlayMusic, nil, nil, nil, nil);

  if btnStopMusic.visible then
    TUIItemsList.Current.AddControl(btnStopMusic, btnPause, nil, nil, btnPause)
  else
    TUIItemsList.Current.AddControl(btnStopMusic, nil, nil, nil, nil);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardEscape),
    ord(TSVGInputPromptsIndex.SteamButtonColorXOutline), 'Pause');
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowUp),
    ord(TSVGInputPromptsIndex.SteamDpadHorizontalOutline));
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowDown),
    ord(TSVGInputPromptsIndex.SteamDpadHorizontalOutline), 'Move');
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardSpace),
    ord(TSVGInputPromptsIndex.SteamButtonColorAOutline), 'Click');

  // start your game loop
  // start your workers
  // etc...
end;

procedure TSceneGame.ShowLevel;
begin
  lblLevel.Text := 'Level ' + TGameData.DefaultGameData.Level.ToString;
end;

procedure TSceneGame.ShowNbLives;
begin
  lblLives.Text := 'Lives ' + TGameData.DefaultGameData.NbLives.ToString;
end;

procedure TSceneGame.ShowScore;
begin
  lblScore.Text := 'Score ' + TGameData.DefaultGameData.Score.ToString;
end;

procedure TSceneGame.ShowUserPseudo;
begin
  lblUserPseudo.Text := 'Player "' + TGameData.DefaultGameData.UserPseudo + '"';
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
