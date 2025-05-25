(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit

  Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

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
  https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit

  ***************************************************************************
  File last update : 2025-02-09T11:12:48.120+01:00
  Signature : 6deaf40ada4937a09d69a63c7509d243d776f48f
  ***************************************************************************
*)

unit uTronGameData;

interface

uses
  System.UITypes,
  Gamolf.RTL.Joystick,
  uGameData;

const
  /// <summary>
  /// Nb cells for the biggest side
  /// </summary>
  CColCount = 64;
  /// <summary>
  /// Nb cells for the lowest side
  /// </summary>
  CRowCount = 48;
  /// <summary>
  /// Move speed : cells per seconde
  /// </summary>
  CNbCellPerSecondes = 5;

type
{$SCOPEDENUMS ON}
  TCellType = (Nothing, Player1, Player2, Player3, Player4);

  TGameGrid = array [0 .. (CColCount - 1), 0 .. (CRowCount - 1)] of TCellType;

  TControllerType = (Keyboard, DPad, Axe, Button);

  TPlayer = class
  private
    FKeyCharUp: WideChar;
    FKeyRight: Word;
    FKeyCharLeft: WideChar;
    FColor: TAlphaColor;
    FVX: integer;
    FKeyCharRight: WideChar;
    FVY: integer;
    FKeyDown: Word;
    FX: integer;
    FY: integer;
    FKeyUp: Word;
    FKeyCharDown: WideChar;
    FKeyLeft: Word;
    FEnabled: boolean;
    FIsAlive: boolean;
    FDPadRight: TJoystickDPad;
    FGamePadIDUp: integer;
    FButtonLeft: TJoystickButtons;
    FAxeValueRight: single;
    FControllerTypeUp: TControllerType;
    FGamePadIDLeft: integer;
    FControllerTypeLeft: TControllerType;
    FAxeIDDown: TJoystickAxes;
    FButtonRight: TJoystickButtons;
    FGamePadIDRight: integer;
    FDPadDown: TJoystickDPad;
    FAxeValueDown: single;
    FControllerTypeRight: TControllerType;
    FAxeIDUp: TJoystickAxes;
    FAxeIDLeft: TJoystickAxes;
    FDPadUp: TJoystickDPad;
    FButtonDown: TJoystickButtons;
    FAxeValueUp: single;
    FDPadLeft: TJoystickDPad;
    FGamePadIDDown: integer;
    FAxeValueLeft: single;
    FAxeIDRight: TJoystickAxes;
    FControllerTypeDown: TControllerType;
    FButtonUp: TJoystickButtons;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetKeyCharDown(const Value: WideChar);
    procedure SetKeyCharLeft(const Value: WideChar);
    procedure SetKeyCharRight(const Value: WideChar);
    procedure SetKeyCharUp(const Value: WideChar);
    procedure SetKeyDown(const Value: Word);
    procedure SetKeyLeft(const Value: Word);
    procedure SetKeyRight(const Value: Word);
    procedure SetKeyUp(const Value: Word);
    procedure SetVX(const Value: integer);
    procedure SetVY(const Value: integer);
    procedure SetX(const Value: integer);
    procedure SetY(const Value: integer);
    procedure SetEnabled(const Value: boolean);
    procedure SetIsAlive(const Value: boolean);
    procedure SetAxeIDDown(const Value: TJoystickAxes);
    procedure SetAxeIDLeft(const Value: TJoystickAxes);
    procedure SetAxeIDRight(const Value: TJoystickAxes);
    procedure SetAxeIDUp(const Value: TJoystickAxes);
    procedure SetAxeValueDown(const Value: single);
    procedure SetAxeValueLeft(const Value: single);
    procedure SetAxeValueRight(const Value: single);
    procedure SetAxeValueUp(const Value: single);
    procedure SetButtonDown(const Value: TJoystickButtons);
    procedure SetButtonLeft(const Value: TJoystickButtons);
    procedure SetButtonRight(const Value: TJoystickButtons);
    procedure SetButtonUp(const Value: TJoystickButtons);
    procedure SetControllerTypeDown(const Value: TControllerType);
    procedure SetControllerTypeLeft(const Value: TControllerType);
    procedure SetControllerTypeRight(const Value: TControllerType);
    procedure SetControllerTypeUp(const Value: TControllerType);
    procedure SetDPadDown(const Value: TJoystickDPad);
    procedure SetDPadLeft(const Value: TJoystickDPad);
    procedure SetDPadRight(const Value: TJoystickDPad);
    procedure SetDPadUp(const Value: TJoystickDPad);
    procedure SetGamePadIDDown(const Value: integer);
    procedure SetGamePadIDLeft(const Value: integer);
    procedure SetGamePadIDRight(const Value: integer);
    procedure SetGamePadIDUp(const Value: integer);
  protected
  public
    property X: integer read FX write SetX;
    property Y: integer read FY write SetY;
    property VX: integer read FVX write SetVX;
    property VY: integer read FVY write SetVY;
    property Color: TAlphaColor read FColor write SetColor;
    property ControllerTypeUp: TControllerType read FControllerTypeUp
      write SetControllerTypeUp;
    property KeyUp: Word read FKeyUp write SetKeyUp;
    property KeyCharUp: WideChar read FKeyCharUp write SetKeyCharUp;
    property GamePadIDUp: integer read FGamePadIDUp write SetGamePadIDUp;
    property AxeIDUp: TJoystickAxes read FAxeIDUp write SetAxeIDUp;
    property AxeValueUp: single read FAxeValueUp write SetAxeValueUp;
    property DPadUp: TJoystickDPad read FDPadUp write SetDPadUp;
    property ButtonUp: TJoystickButtons read FButtonUp write SetButtonUp;
    property ControllerTypeRight: TControllerType read FControllerTypeRight
      write SetControllerTypeRight;
    property KeyRight: Word read FKeyRight write SetKeyRight;
    property KeyCharRight: WideChar read FKeyCharRight write SetKeyCharRight;
    property GamePadIDRight: integer read FGamePadIDRight
      write SetGamePadIDRight;
    property AxeIDRight: TJoystickAxes read FAxeIDRight write SetAxeIDRight;
    property AxeValueRight: single read FAxeValueRight write SetAxeValueRight;
    property DPadRight: TJoystickDPad read FDPadRight write SetDPadRight;
    property ButtonRight: TJoystickButtons read FButtonRight
      write SetButtonRight;
    property ControllerTypeDown: TControllerType read FControllerTypeDown
      write SetControllerTypeDown;
    property KeyDown: Word read FKeyDown write SetKeyDown;
    property KeyCharDown: WideChar read FKeyCharDown write SetKeyCharDown;
    property GamePadIDDown: integer read FGamePadIDDown write SetGamePadIDDown;
    property AxeIDDown: TJoystickAxes read FAxeIDDown write SetAxeIDDown;
    property AxeValueDown: single read FAxeValueDown write SetAxeValueDown;
    property DPadDown: TJoystickDPad read FDPadDown write SetDPadDown;
    property ButtonDown: TJoystickButtons read FButtonDown write SetButtonDown;
    property ControllerTypeLeft: TControllerType read FControllerTypeLeft
      write SetControllerTypeLeft;
    property KeyLeft: Word read FKeyLeft write SetKeyLeft;
    property KeyCharLeft: WideChar read FKeyCharLeft write SetKeyCharLeft;
    property GamePadIDLeft: integer read FGamePadIDLeft write SetGamePadIDLeft;
    property AxeIDLeft: TJoystickAxes read FAxeIDLeft write SetAxeIDLeft;
    property AxeValueLeft: single read FAxeValueLeft write SetAxeValueLeft;
    property DPadLeft: TJoystickDPad read FDPadLeft write SetDPadLeft;
    property ButtonLeft: TJoystickButtons read FButtonLeft write SetButtonLeft;
    property Enabled: boolean read FEnabled write SetEnabled;
    property IsAlive: boolean read FIsAlive write SetIsAlive;
    constructor Create; virtual;
    procedure Restart;
    procedure Move;
    procedure ToTheLeft;
    procedure ToTheRight;
    procedure ToTheTop;
    procedure ToTheBottom;
  end;

  TPlayers = array [TCellType.Player1 .. TCellType.Player4] of TPlayer;

  TTronGameData = class(tgamedata)
  private
    FPlayers: TPlayers;
    procedure SetPlayers(const Value: TPlayers);
  protected
  public
    Grid: TGameGrid;
    property Players: TPlayers read FPlayers write SetPlayers;
    procedure StartANewGame; override;
    constructor Create; override;
    destructor Destroy; override;
    class function DefaultGameData: tgamedata; override;
    class function Current: TTronGameData; virtual;
  end;

implementation

var
  LTronGameData: TTronGameData;

  { TPlayer }

constructor TPlayer.Create;
begin
  inherited Create;
  FControllerTypeUp := TControllerType.Keyboard;
  FKeyUp := vkup;
  FKeyCharUp := #0;
  FGamePadIDUp := -1;
  FDPadUp := TJoystickDPad.Top;
  FAxeIDUp := TJoystickAxes.LeftSticky;
  FAxeValueUp := -1;
  FButtonUp := TJoystickButtons.Y;

  FControllerTypeRight := TControllerType.Keyboard;
  FKeyRight := vkRight;
  FKeyCharRight := #0;
  FGamePadIDRight := -1;
  FDPadRight := TJoystickDPad.Right;
  FAxeIDRight := TJoystickAxes.LeftStickX;
  FAxeValueRight := 1;
  FButtonRight := TJoystickButtons.B;

  FControllerTypeDown := TControllerType.Keyboard;
  FKeyDown := vkDown;
  FKeyCharDown := #0;
  FGamePadIDDown := -1;
  FDPadDown := TJoystickDPad.Bottom;
  FAxeIDDown := TJoystickAxes.LeftSticky;
  FAxeValueDown := 1;
  FButtonDown := TJoystickButtons.A;

  FControllerTypeLeft := TControllerType.Keyboard;
  FKeyLeft := vkLeft;
  FKeyCharLeft := #0;
  FGamePadIDLeft := -1;
  FDPadLeft := TJoystickDPad.Left;
  FAxeIDLeft := TJoystickAxes.LeftStickX;
  FAxeValueLeft := -1;
  FButtonLeft := TJoystickButtons.X;

  FColor := TAlphaColors.Red;
  FX := 0;
  FY := 0;
  FVX := 1;
  FVY := 0;
  FEnabled := false;
  FIsAlive := false;
end;

procedure TPlayer.Move;
begin
  X := X + VX;
  Y := Y + VY;
end;

procedure TPlayer.Restart;
begin
  FX := 0;
  FY := 0;
  FVX := 1;
  FVY := 0;
  FEnabled := false;
  FIsAlive := false;
end;

procedure TPlayer.SetAxeIDDown(const Value: TJoystickAxes);
begin
  FAxeIDDown := Value;
end;

procedure TPlayer.SetAxeIDLeft(const Value: TJoystickAxes);
begin
  FAxeIDLeft := Value;
end;

procedure TPlayer.SetAxeIDRight(const Value: TJoystickAxes);
begin
  FAxeIDRight := Value;
end;

procedure TPlayer.SetAxeIDUp(const Value: TJoystickAxes);
begin
  FAxeIDUp := Value;
end;

procedure TPlayer.SetAxeValueDown(const Value: single);
begin
  FAxeValueDown := Value;
end;

procedure TPlayer.SetAxeValueLeft(const Value: single);
begin
  FAxeValueLeft := Value;
end;

procedure TPlayer.SetAxeValueRight(const Value: single);
begin
  FAxeValueRight := Value;
end;

procedure TPlayer.SetAxeValueUp(const Value: single);
begin
  FAxeValueUp := Value;
end;

procedure TPlayer.SetButtonDown(const Value: TJoystickButtons);
begin
  FButtonDown := Value;
end;

procedure TPlayer.SetButtonLeft(const Value: TJoystickButtons);
begin
  FButtonLeft := Value;
end;

procedure TPlayer.SetButtonRight(const Value: TJoystickButtons);
begin
  FButtonRight := Value;
end;

procedure TPlayer.SetButtonUp(const Value: TJoystickButtons);
begin
  FButtonUp := Value;
end;

procedure TPlayer.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
end;

procedure TPlayer.SetControllerTypeDown(const Value: TControllerType);
begin
  FControllerTypeDown := Value;
end;

procedure TPlayer.SetControllerTypeLeft(const Value: TControllerType);
begin
  FControllerTypeLeft := Value;
end;

procedure TPlayer.SetControllerTypeRight(const Value: TControllerType);
begin
  FControllerTypeRight := Value;
end;

procedure TPlayer.SetControllerTypeUp(const Value: TControllerType);
begin
  FControllerTypeUp := Value;
end;

procedure TPlayer.SetDPadDown(const Value: TJoystickDPad);
begin
  FDPadDown := Value;
end;

procedure TPlayer.SetDPadLeft(const Value: TJoystickDPad);
begin
  FDPadLeft := Value;
end;

procedure TPlayer.SetDPadRight(const Value: TJoystickDPad);
begin
  FDPadRight := Value;
end;

procedure TPlayer.SetDPadUp(const Value: TJoystickDPad);
begin
  FDPadUp := Value;
end;

procedure TPlayer.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TPlayer.SetGamePadIDDown(const Value: integer);
begin
  FGamePadIDDown := Value;
end;

procedure TPlayer.SetGamePadIDLeft(const Value: integer);
begin
  FGamePadIDLeft := Value;
end;

procedure TPlayer.SetGamePadIDRight(const Value: integer);
begin
  FGamePadIDRight := Value;
end;

procedure TPlayer.SetGamePadIDUp(const Value: integer);
begin
  FGamePadIDUp := Value;
end;

procedure TPlayer.SetIsAlive(const Value: boolean);
begin
  FIsAlive := Value;
end;

procedure TPlayer.SetKeyCharDown(const Value: WideChar);
begin
  FKeyCharDown := Value;
end;

procedure TPlayer.SetKeyCharLeft(const Value: WideChar);
begin
  FKeyCharLeft := Value;
end;

procedure TPlayer.SetKeyCharRight(const Value: WideChar);
begin
  FKeyCharRight := Value;
end;

procedure TPlayer.SetKeyCharUp(const Value: WideChar);
begin
  FKeyCharUp := Value;
end;

procedure TPlayer.SetKeyDown(const Value: Word);
begin
  FKeyDown := Value;
end;

procedure TPlayer.SetKeyLeft(const Value: Word);
begin
  FKeyLeft := Value;
end;

procedure TPlayer.SetKeyRight(const Value: Word);
begin
  FKeyRight := Value;
end;

procedure TPlayer.SetKeyUp(const Value: Word);
begin
  FKeyUp := Value;
end;

procedure TPlayer.SetVX(const Value: integer);
begin
  FVX := Value;
end;

procedure TPlayer.SetVY(const Value: integer);
begin
  FVY := Value;
end;

procedure TPlayer.SetX(const Value: integer);
begin
  FX := Value;
end;

procedure TPlayer.SetY(const Value: integer);
begin
  FY := Value;
end;

procedure TPlayer.ToTheBottom;
begin
  VX := 0;
  VY := 1;
end;

procedure TPlayer.ToTheLeft;
begin
  VX := -1;
  VY := 0;
end;

procedure TPlayer.ToTheRight;
begin
  VX := 1;
  VY := 0;
end;

procedure TPlayer.ToTheTop;
begin
  VX := 0;
  VY := -1;
end;

{ TTronGameData }

constructor TTronGameData.Create;
var
  PlayerID: TCellType;
begin
  inherited;
  for PlayerID := TCellType.Player1 to TCellType.Player4 do
    FPlayers[PlayerID] := TPlayer.Create;
end;

class function TTronGameData.Current: TTronGameData;
begin
  if not assigned(LTronGameData) then
    LTronGameData := TTronGameData.Create;
  result := LTronGameData;
end;

class function TTronGameData.DefaultGameData: tgamedata;
begin
  result := Current;
end;

destructor TTronGameData.Destroy;
var
  PlayerID: TCellType;
begin
  for PlayerID := TCellType.Player1 to TCellType.Player4 do
    if assigned(FPlayers[PlayerID]) then
      FPlayers[PlayerID].Free;
  inherited;
end;

procedure TTronGameData.SetPlayers(const Value: TPlayers);
begin
  FPlayers := Value;
end;

procedure TTronGameData.StartANewGame;
var
  PlayerID: TCellType;
  X, Y: integer;
begin
  inherited;
  // Init game grid
  for X := 0 to CColCount - 1 do
    for Y := 0 to CRowCount - 1 do
      Grid[X, Y] := TCellType.Nothing;

  // Init players
  for PlayerID := TCellType.Player1 to TCellType.Player4 do
    FPlayers[PlayerID].Restart;
end;

initialization

LTronGameData := nil;

finalization

LTronGameData.Free;

end.
