/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Starter Kit
///
/// Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.
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
/// File last update : 2025-05-08T20:34:54.000+02:00
/// Signature : fe0cc28eed4159edcc38618840920ef11f9a9600
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
  uTronGameData,
  Gamolf.RTL.Joystick;

type
{$SCOPEDENUMS ON}
  TOrientationType = (Paysage, Portrait);

  TGameScene = class(T__SceneAncestor)
    GameLoop: TTimer;
    rBackground: TRectangle;
    imgScreen: TImage;
    DGEGamepadManager1: TDGEGamepadManager;
    procedure GameLoopTimer(Sender: TObject);
    procedure FrameResized(Sender: TObject);
    procedure FrameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure imgScreenResized(Sender: TObject);
    procedure DGEGamepadManager1AxesChange(const GamepadID: Integer;
      const Axe: TJoystickAxes; const Value: Single);
    procedure DGEGamepadManager1DirectionPadChange(const GamepadID: Integer;
      const Value: TJoystickDPad);
    procedure DGEGamepadManager1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
  private
  protected
    FFirstResize: boolean;
    FOrientation: TOrientationType;
  public
    procedure ShowScene; override;
    procedure HideScene; override;
    constructor Create(AOwner: TComponent); override;
    procedure DrawCell(const X, Y: Integer);
    procedure AfterConstruction; override;
    procedure GoToTop(const PlayerID: TCellType);
    procedure GoToRight(const PlayerID: TCellType);
    procedure GoToBottom(const PlayerID: TCellType);
    procedure GoToLeft(const PlayerID: TCellType);
    procedure GameOver;
  end;

implementation

{$R *.fmx}
// TODO : accélérer le jeu en cours de partie (à partir d'un certain niveau de score)

uses
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  Gamolf.RTL.UIElements;

procedure TGameScene.AfterConstruction;
begin
  inherited;
  DGEGamepadManager1.Enabled := false;
  GameLoop.Enabled := false;
end;

constructor TGameScene.Create(AOwner: TComponent);
begin
  inherited;
  FFirstResize := true;
end;

procedure TGameScene.DGEGamepadManager1AxesChange(const GamepadID: Integer;
  const Axe: TJoystickAxes; const Value: Single);
var
  PlayerID: TCellType;
  tgd: TTronGameData;
begin
  tgd := TTronGameData.current;

  for PlayerID := TCellType.Player1 to TCellType.Player4 do
    if tgd.Players[PlayerID].IsAlive then
      if (tgd.Players[PlayerID].ControllerTypeUp = TControllerType.Axe) and
        (tgd.Players[PlayerID].GamePadIDUp = GamepadID) and
        (tgd.Players[PlayerID].AxeIDUp = Axe) and
        (((tgd.Players[PlayerID].AxeValueUp > 0) and (Value > 0)) or
        ((tgd.Players[PlayerID].AxeValueUp < 0) and (Value < 0))) and
        (abs(Value) > 0.9 * abs(tgd.Players[PlayerID].AxeValueUp)) then
        GoToTop(PlayerID)
      else if (tgd.Players[PlayerID].ControllerTypeRight = TControllerType.Axe)
        and (tgd.Players[PlayerID].GamePadIDRight = GamepadID) and
        (tgd.Players[PlayerID].AxeIDRight = Axe) and
        (((tgd.Players[PlayerID].AxeValueRight > 0) and (Value > 0)) or
        ((tgd.Players[PlayerID].AxeValueRight < 0) and (Value < 0))) and
        (abs(Value) > 0.9 * abs(tgd.Players[PlayerID].AxeValueRight)) then
        GoToRight(PlayerID)
      else if (tgd.Players[PlayerID].ControllerTypeDown = TControllerType.Axe)
        and (tgd.Players[PlayerID].GamePadIDDown = GamepadID) and
        (tgd.Players[PlayerID].AxeIDDown = Axe) and
        (((tgd.Players[PlayerID].AxeValueDown > 0) and (Value > 0)) or
        ((tgd.Players[PlayerID].AxeValueDown < 0) and (Value < 0))) and
        (abs(Value) > 0.9 * abs(tgd.Players[PlayerID].AxeValueDown)) then
        GoToBottom(PlayerID)
      else if (tgd.Players[PlayerID].ControllerTypeLeft = TControllerType.Axe)
        and (tgd.Players[PlayerID].GamePadIDLeft = GamepadID) and
        (tgd.Players[PlayerID].AxeIDLeft = Axe) and
        (((tgd.Players[PlayerID].AxeValueLeft > 0) and (Value > 0)) or
        ((tgd.Players[PlayerID].AxeValueLeft < 0) and (Value < 0))) and
        (abs(Value) > 0.9 * abs(tgd.Players[PlayerID].AxeValueLeft)) then
        GoToLeft(PlayerID);
end;

procedure TGameScene.DGEGamepadManager1ButtonDown(const GamepadID: Integer;
  const Button: TJoystickButtons);
var
  PlayerID: TCellType;
  tgd: TTronGameData;
begin
  tgd := TTronGameData.current;

  for PlayerID := TCellType.Player1 to TCellType.Player4 do
    if tgd.Players[PlayerID].IsAlive then
      if (tgd.Players[PlayerID].ControllerTypeUp = TControllerType.Button) and
        (tgd.Players[PlayerID].GamePadIDUp = GamepadID) and
        (tgd.Players[PlayerID].ButtonUp = Button) then
        GoToTop(PlayerID)
      else if (tgd.Players[PlayerID].ControllerTypeRight = TControllerType.
        Button) and (tgd.Players[PlayerID].GamePadIDRight = GamepadID) and
        (tgd.Players[PlayerID].ButtonRight = Button) then
        GoToRight(PlayerID)
      else if (tgd.Players[PlayerID].ControllerTypeDown = TControllerType.
        Button) and (tgd.Players[PlayerID].GamePadIDDown = GamepadID) and
        (tgd.Players[PlayerID].ButtonDown = Button) then
        GoToBottom(PlayerID)
      else if (tgd.Players[PlayerID].ControllerTypeLeft = TControllerType.
        Button) and (tgd.Players[PlayerID].GamePadIDLeft = GamepadID) and
        (tgd.Players[PlayerID].ButtonLeft = Button) then
        GoToLeft(PlayerID);
end;

procedure TGameScene.DGEGamepadManager1DirectionPadChange(const GamepadID
  : Integer; const Value: TJoystickDPad);
var
  PlayerID: TCellType;
  tgd: TTronGameData;
begin
  tgd := TTronGameData.current;

  for PlayerID := TCellType.Player1 to TCellType.Player4 do
    if tgd.Players[PlayerID].IsAlive then
      if (Value = TJoystickDPad.Top) and
        (tgd.Players[PlayerID].ControllerTypeUp = TControllerType.DPad) and
        (tgd.Players[PlayerID].GamePadIDUp = GamepadID) then
        GoToTop(PlayerID)
      else if (Value = TJoystickDPad.Right) and
        (tgd.Players[PlayerID].ControllerTypeRight = TControllerType.DPad) and
        (tgd.Players[PlayerID].GamePadIDRight = GamepadID) then
        GoToRight(PlayerID)
      else if (Value = TJoystickDPad.Bottom) and
        (tgd.Players[PlayerID].ControllerTypeDown = TControllerType.DPad) and
        (tgd.Players[PlayerID].GamePadIDDown = GamepadID) then
        GoToBottom(PlayerID)
      else if (Value = TJoystickDPad.Left) and
        (tgd.Players[PlayerID].ControllerTypeLeft = TControllerType.DPad) and
        (tgd.Players[PlayerID].GamePadIDLeft = GamepadID) then
        GoToLeft(PlayerID);
end;

procedure TGameScene.DrawCell(const X, Y: Integer);
var
  SX, SY: Single; // Coordonnées d'écran en pixels physiques (ScreenX,ScreenY)
  SizeX, SizeY: Single;
  tgd: TTronGameData;
begin
  if (X < 0) or (Y < 0) or (X >= CColCount) or (Y >= CRowCount) then
    exit;

  tgd := TTronGameData.current;

  if FOrientation = TOrientationType.Paysage then // mode paysage
  begin
    SizeX := (imgScreen.Bitmap.Width / CColCount) /
      imgScreen.Bitmap.BitmapScale;
    SizeY := (imgScreen.Bitmap.Height / CRowCount) /
      imgScreen.Bitmap.BitmapScale;
    SX := X * SizeX;
    SY := Y * SizeY;
  end
  else // mode portrait ou carré (pas de device de ce format)
  begin
    SizeX := (imgScreen.Bitmap.Width / CRowCount) /
      imgScreen.Bitmap.BitmapScale;
    SizeY := (imgScreen.Bitmap.Height / CColCount) /
      imgScreen.Bitmap.BitmapScale;
    SX := Y * SizeX;
    SY := (CColCount - 1 - X) * SizeY;
  end;

  imgScreen.Bitmap.Canvas.BeginScene;
  try
    case tgd.Grid[X, Y] of
      TCellType.Nothing:
        imgScreen.Bitmap.Canvas.fill.Color := TAlphaColors.black;
      TCellType.Player1 .. TCellType.Player4:
        imgScreen.Bitmap.Canvas.fill.Color := tgd.Players[tgd.Grid[X, Y]].Color;
    end;
    imgScreen.Bitmap.Canvas.FillRect(trectf.Create(SX, SY, SX + SizeX + 1,
      SY + SizeY + 1), 1);
  finally
    imgScreen.Bitmap.Canvas.EndScene;
  end;
end;

procedure TGameScene.FrameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
var
  PlayerID: TCellType;
  tgd: TTronGameData;
begin
  tgd := TTronGameData.current;

  if (Key <> 0) or (KeyChar <> #0) then
    for PlayerID := TCellType.Player1 to TCellType.Player4 do
      if tgd.Players[PlayerID].IsAlive then
        if (tgd.Players[PlayerID].ControllerTypeUp = TControllerType.Keyboard)
          and (tgd.Players[PlayerID].KeyUp = Key) and
          (tgd.Players[PlayerID].KeyCharUp = KeyChar) then
        begin
          GoToTop(PlayerID);
          Key := 0;
          KeyChar := #0;
        end
        else if (tgd.Players[PlayerID].ControllerTypeRight = TControllerType.
          Keyboard) and (tgd.Players[PlayerID].KeyRight = Key) and
          (tgd.Players[PlayerID].KeyCharRight = KeyChar) then
        begin
          GoToRight(PlayerID);
          Key := 0;
          KeyChar := #0;
        end
        else if (tgd.Players[PlayerID].ControllerTypeDown = TControllerType.
          Keyboard) and (tgd.Players[PlayerID].KeyDown = Key) and
          (tgd.Players[PlayerID].KeyCharDown = KeyChar) then
        begin
          GoToBottom(PlayerID);
          Key := 0;
          KeyChar := #0;
        end
        else if (tgd.Players[PlayerID].ControllerTypeLeft = TControllerType.
          Keyboard) and (tgd.Players[PlayerID].KeyLeft = Key) and
          (tgd.Players[PlayerID].KeyCharLeft = KeyChar) then
        begin
          GoToLeft(PlayerID);
          Key := 0;
          KeyChar := #0;
        end;
end;

procedure TGameScene.FrameResized(Sender: TObject);
var
  ratio: Single;
  w, h, h2: Single;
  X, Y: Integer;
begin
  if FFirstResize then
  begin
    FFirstResize := false;
    exit;
  end;

  if Width > Height then
    ratio := CColCount / CRowCount
  else
    ratio := CRowCount / CColCount;

  w := Width - rBackground.margins.Left - rBackground.margins.Right;
  h := w / ratio;
  h2 := Height - rBackground.margins.Top - rBackground.margins.Bottom;
  if (h > h2) then
  begin
    h := h2;
    w := h * ratio;
  end;

  rBackground.Width := w;
  rBackground.Height := h;

  imgScreen.Bitmap.SetSize
    (round(imgScreen.Width * imgScreen.Bitmap.BitmapScale),
    round(imgScreen.Height * imgScreen.Bitmap.BitmapScale));
  imgScreen.Bitmap.Clear(TAlphaColors.green);

  for X := 0 to CColCount - 1 do
    for Y := 0 to CRowCount - 1 do
      DrawCell(X, Y);
end;

procedure TGameScene.GameLoopTimer(Sender: TObject);
var
  PlayerID: TCellType;
  tgd: TTronGameData;
  APlayerDied: boolean;
  Nb: Integer;
begin
  if (not GameLoop.Enabled) or (not TTronGameData.current.IsPlaying) then
    exit;

  tgd := TTronGameData.current;
  APlayerDied := false;

  for PlayerID := TCellType.Player1 to TCellType.Player4 do
    if tgd.Players[PlayerID].Enabled and tgd.Players[PlayerID].IsAlive then
    begin
      tgd.Players[PlayerID].Move;

      if (tgd.Players[PlayerID].X < 0) or (tgd.Players[PlayerID].Y < 0) or
        (tgd.Players[PlayerID].X >= CColCount) or
        (tgd.Players[PlayerID].Y >= CRowCount) or
        (not(tgd.Grid[tgd.Players[PlayerID].X, tgd.Players[PlayerID].Y]
        = TCellType.Nothing)) then
      begin
        tgd.Players[PlayerID].IsAlive := false;
        APlayerDied := true;
      end
      else
      begin
        tgd.Grid[tgd.Players[PlayerID].X, tgd.Players[PlayerID].Y] := PlayerID;
        DrawCell(tgd.Players[PlayerID].X, tgd.Players[PlayerID].Y);
      end;
    end;

  if APlayerDied then
  begin
    Nb := 0;
    for PlayerID := TCellType.Player1 to TCellType.Player4 do
      if tgd.Players[PlayerID].IsAlive then
        inc(Nb);
    if (Nb < 2) then
      GameOver;
  end;
end;

procedure TGameScene.GameOver;
begin
  TTronGameData.current.StopGame;
  tscene.current := TSceneType.GameOver;
end;

procedure TGameScene.GoToBottom(const PlayerID: TCellType);
begin
  if FOrientation = TOrientationType.Paysage then
    TTronGameData.current.Players[PlayerID].ToTheBottom
  else
    TTronGameData.current.Players[PlayerID].ToTheLeft;
end;

procedure TGameScene.GoToLeft(const PlayerID: TCellType);
begin
  if FOrientation = TOrientationType.Paysage then
    TTronGameData.current.Players[PlayerID].ToTheLeft
  else
    TTronGameData.current.Players[PlayerID].ToTheTop;
end;

procedure TGameScene.GoToRight(const PlayerID: TCellType);
begin
  if FOrientation = TOrientationType.Paysage then
    TTronGameData.current.Players[PlayerID].ToTheRight
  else
    TTronGameData.current.Players[PlayerID].ToTheBottom;
end;

procedure TGameScene.GoToTop(const PlayerID: TCellType);
begin
  if FOrientation = TOrientationType.Paysage then
    TTronGameData.current.Players[PlayerID].ToTheTop
  else
    TTronGameData.current.Players[PlayerID].ToTheRight;
end;

procedure TGameScene.HideScene;
begin
  inherited;
  GameLoop.Enabled := false;
  DGEGamepadManager1.Enabled := false;
  TUIItemsList.current.RemoveLayout;
end;

procedure TGameScene.imgScreenResized(Sender: TObject);
begin
  if imgScreen.Width > imgScreen.Height then
    FOrientation := TOrientationType.Paysage
  else
    FOrientation := TOrientationType.Portrait;
end;

procedure TGameScene.ShowScene;
var
  X, Y: Integer;
begin
  inherited;
  TUIItemsList.current.NewLayout;
  TUIItemsList.current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      GameOver;
    end).KeyShortcuts.Add(vkescape, #0, []);

  // To force the player controls for tests
  // TTronGameData.current.Players[TCellType.Player1].ControllerTypeUp :=
  // TControllerType.Button;
  // TTronGameData.current.Players[TCellType.Player1].GamePadIDUp := 2;
  // TTronGameData.current.Players[TCellType.Player1].ControllerTypeRight :=
  // TControllerType.Button;
  // TTronGameData.current.Players[TCellType.Player1].GamePadIDRight := 2;
  // TTronGameData.current.Players[TCellType.Player1].ControllerTypeDown :=
  // TControllerType.Button;
  // TTronGameData.current.Players[TCellType.Player1].GamePadIDDown := 2;
  // TTronGameData.current.Players[TCellType.Player1].ControllerTypeLeft :=
  // TControllerType.Button;
  // TTronGameData.current.Players[TCellType.Player1].GamePadIDLeft := 2;

  // Init game grid
  for X := 0 to CColCount - 1 do
    for Y := 0 to CRowCount - 1 do
      DrawCell(X, Y);

  // init and start the game loop
  GameLoop.Interval := round(1000 / CNbCellPerSecondes);
  GameLoop.Enabled := true;

  // Start the local game controller manager
  DGEGamepadManager1.Enabled := true;
end;

initialization

tscene.RegisterScene<TGameScene>(TSceneType.Game);

end.
