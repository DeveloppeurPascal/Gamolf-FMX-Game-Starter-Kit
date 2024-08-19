/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Starter Kit
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
/// The "Gamolf FMX Game Starter Kit" is both a "technical" example of a video
/// game developed in Delphi with everything you need inside and a reusable
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
/// https://fmxgamestarterkit.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit
///
/// ***************************************************************************
/// File last update : 2024-08-19T13:30:44.000+02:00
/// Signature : be4a7c80f7ac19176e5d7b1487451ca853dbe1ce
/// ***************************************************************************
/// </summary>

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
  _ScenesAncestor,
  FMX.Objects,
  FMX.Layouts,
  System.Messaging,
  Gamolf.RTL.Joystick;

type
  TSceneGame = class(T__SceneAncestor)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    lZone: TLayout;
    Player: TRectangle;
    Ball: TCircle;
    GameLoop: TTimer;
    DGEGamepadManager1: TDGEGamepadManager;
    GridPanelLayout1: TGridPanelLayout;
    txtScore: TText;
    txtLifes: TText;
    procedure GameLoopTimer(Sender: TObject);
    procedure DGEGamepadManager1DirectionPadChange(const GamepadID: Integer;
      const Value: TJoystickDPad);
  private
    procedure InitBall;
  protected
    PlayerVX, BallVX, BallVY: single;
    procedure PlayerGoToLeft;
    procedure PlayerGoToRight;
    procedure DoScoreChanged(const Sender: TObject; const Msg: TMessage);
    procedure DoNbLivesChanged(const Sender: TObject; const Msg: TMessage);
  public
    procedure HideScene; override;
    procedure ShowScene; override;
    procedure AfterConstruction; override;
    procedure UpdateScoreAndLifes;
  end;

implementation

{$R *.fmx}

uses
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  uGameData,
  Gamolf.RTL.UIElements;

{ TSceneGame }

procedure TSceneGame.AfterConstruction;
begin
  inherited;
  GameLoop.Enabled := false;
end;

procedure TSceneGame.InitBall;
begin
  Ball.Position.x := Player.Position.x + (Player.Width - Ball.Width) / 2;
  Ball.Position.y := Player.Position.y - Ball.height;
  repeat
    BallVX := random(10) - 5;
  until (BallVX <> 0);
  BallVY := -1;
end;

procedure TSceneGame.PlayerGoToLeft;
begin
  PlayerVX := -abs(BallVX);
end;

procedure TSceneGame.PlayerGoToRight;
begin
  PlayerVX := abs(BallVX);
end;

procedure TSceneGame.DGEGamepadManager1DirectionPadChange(const GamepadID
  : Integer; const Value: TJoystickDPad);
begin
  case Value of
    TJoystickDPad.LeftTop, TJoystickDPad.Left, TJoystickDPad.LeftBottom:
      PlayerGoToLeft;
    TJoystickDPad.RightTop, TJoystickDPad.Right, TJoystickDPad.RightBottom:
      PlayerGoToRight;
  end;
end;

procedure TSceneGame.DoNbLivesChanged(const Sender: TObject;
  const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TNbLivesChangedMessage) then
    UpdateScoreAndLifes;
end;

procedure TSceneGame.DoScoreChanged(const Sender: TObject; const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TScoreChangedMessage) then
    UpdateScoreAndLifes;
end;

procedure TSceneGame.GameLoopTimer(Sender: TObject);
begin
  if (not GameLoop.Enabled) or (not TGameData.DefaultGameData.IsPlaying) then
    exit;

  Ball.Position.x := Ball.Position.x + BallVX;
  Ball.Position.y := Ball.Position.y + BallVY;

  if (Ball.Position.x < 0) or (Ball.Position.x + Ball.Width > lZone.Width) then
  begin
    BallVX := -BallVX;
    TGameData.DefaultGameData.Score := TGameData.DefaultGameData.Score + 10;
  end;

  if (Ball.Position.y < 0) then
  begin
    BallVY := -BallVY;
    TGameData.DefaultGameData.Score := TGameData.DefaultGameData.Score + 10;
  end;

  if (Ball.Position.y + Ball.height > Player.Position.y) then
    if (Ball.Position.x + Ball.Width / 2 > Player.Position.x) and
      (Ball.Position.x + Ball.Width / 2 < Player.Position.x + Player.Width) then
    begin
      BallVY := -BallVY;
      TGameData.DefaultGameData.Score := TGameData.DefaultGameData.Score + 100;
    end
    else
    begin
      TGameData.DefaultGameData.NbLives :=
        TGameData.DefaultGameData.NbLives - 1;
      if (TGameData.DefaultGameData.NbLives < 0) then
      begin
        TGameData.DefaultGameData.StopGame;
        tscene.Current := TSceneType.GameOver;
      end
      else
        InitBall;
    end;

  Player.Position.x := Player.Position.x + PlayerVX;

  if (Player.Position.x < 0) or (Player.Position.x + Player.Width > lZone.Width)
  then
    PlayerVX := 0;
end;

procedure TSceneGame.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
  GameLoop.Enabled := false;
  TMessageManager.DefaultManager.Unsubscribe(TNbLivesChangedMessage,
    DoNbLivesChanged, true);
  TMessageManager.DefaultManager.Unsubscribe(TScoreChangedMessage,
    DoScoreChanged, true);
end;

procedure TSceneGame.ShowScene;
var
  item: tuielement;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  item := TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      TGameData.DefaultGameData.StopGame;
      tscene.Current := TSceneType.Home;
    end);
  item.KeyShortcuts.Add(vkEscape, #0, []);
  item.GamePadButtons := [TJoystickButtons.x];

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowLeft +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadLeftOutline +
    TSVGInputPrompts.Tag);
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowRight +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadRightOutline +
    TSVGInputPrompts.Tag, 'Move');
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardEscape +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorXOutline +
    TSVGInputPrompts.Tag, 'Quit');

  Player.Position.x := (lZone.Width - Player.Width) / 2;
  Player.Position.y := lZone.height - Player.height;
  PlayerVX := 0;

  InitBall;

  TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      PlayerGoToLeft;
    end).KeyShortcuts.Add(vkLeft, #0, []);

  TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      PlayerGoToRight;
    end).KeyShortcuts.Add(vkRight, #0, []);

  UpdateScoreAndLifes;
  TMessageManager.DefaultManager.SubscribeToMessage(TNbLivesChangedMessage,
    DoNbLivesChanged);
  TMessageManager.DefaultManager.SubscribeToMessage(TScoreChangedMessage,
    DoScoreChanged);

  GameLoop.Enabled := true;
end;

procedure TSceneGame.UpdateScoreAndLifes;
begin
  txtScore.Text := 'Score : ' + TGameData.DefaultGameData.Score.ToString;
  txtLifes.Text := 'Ball : ' + TGameData.DefaultGameData.NbLives.ToString;
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
      tscene.RegisterScene(TSceneType.Game, NewScene);
    end;
  end);
randomize;

end.
