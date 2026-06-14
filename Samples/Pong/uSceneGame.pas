(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit
  Copyright (c) 2024-2026 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  ***************************************************************************

  The "Gamolf FMX Game Starter Kit" is both a "technical" example of a video
  game developed in Delphi with everything you need inside and a reusable
  project template you can customize for your own games.

  The files provided are fully functional. Numerous comments are included in
  the sources to explain how they work and what you need to copy, override
  or customize to make video games without starting from scratch.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://fmxgamestarterkit.developpeur-pascal.fr/

  Project site :
  https://codeberg.org/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit

  ***************************************************************************
  File last update : 2026-04-02T19:25:40.548+02:00
  Signature : 0fd7bd2152c739cea7b41dd5f5dd3ddfe4f1bfe4
  ***************************************************************************
*)

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

tscene.RegisterScene<TSceneGame>(TSceneType.Game);
randomize;

end.
