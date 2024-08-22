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

  TControllerType = (Keyboard, DPad, Axes);

  TPlayer = class
  private
    FKeyCharUp: WideChar;
    FKeyRight: Word;
    FKeyCharLeft: WideChar;
    FGamePadID: integer;
    FControllerType: TControllerType;
    FColor: TAlphaColor;
    FVX: integer;
    FKeyCharRight: WideChar;
    FVY: integer;
    FKeyDown: Word;
    FX: integer;
    FY: integer;
    FAxeXID: TJoystickAxes;
    FKeyUp: Word;
    FKeyCharDown: WideChar;
    FKeyLeft: Word;
    FAxeYID: TJoystickAxes;
    FEnabled: boolean;
    FIsAlive: boolean;
    procedure SetAxeXID(const Value: TJoystickAxes);
    procedure SetAxeYID(const Value: TJoystickAxes);
    procedure SetColor(const Value: TAlphaColor);
    procedure SetControllerType(const Value: TControllerType);
    procedure SetGamePadID(const Value: integer);
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
  protected
  public
    property X: integer read FX write SetX;
    property Y: integer read FY write SetY;
    property VX: integer read FVX write SetVX;
    property VY: integer read FVY write SetVY;
    property Color: TAlphaColor read FColor write SetColor;
    property ControllerType: TControllerType read FControllerType
      write SetControllerType;
    property KeyUp: Word read FKeyUp write SetKeyUp;
    property KeyCharUp: WideChar read FKeyCharUp write SetKeyCharUp;
    property KeyRight: Word read FKeyRight write SetKeyRight;
    property KeyCharRight: WideChar read FKeyCharRight write SetKeyCharRight;
    property KeyDown: Word read FKeyDown write SetKeyDown;
    property KeyCharDown: WideChar read FKeyCharDown write SetKeyCharDown;
    property KeyLeft: Word read FKeyLeft write SetKeyLeft;
    property KeyCharLeft: WideChar read FKeyCharLeft write SetKeyCharLeft;
    property GamePadID: integer read FGamePadID write SetGamePadID;
    property AxeYID: TJoystickAxes read FAxeYID write SetAxeYID;
    property AxeXID: TJoystickAxes read FAxeXID write SetAxeXID;
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
  FKeyUp := vkup;
  FKeyCharUp := #0;
  FKeyRight := vkRight;
  FKeyCharRight := #0;
  FKeyDown := vkDown;
  FKeyCharDown := #0;
  FKeyLeft := vkLeft;
  FKeyCharLeft := #0;
  FGamePadID := -1;
  FControllerType := TControllerType.Keyboard;
  FColor := TAlphaColors.Red;
  FAxeXID := TJoystickAxes.LeftStickX;
  FAxeYID := TJoystickAxes.LeftSticky;
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

procedure TPlayer.SetAxeXID(const Value: TJoystickAxes);
begin
  FAxeXID := Value;
end;

procedure TPlayer.SetAxeYID(const Value: TJoystickAxes);
begin
  FAxeYID := Value;
end;

procedure TPlayer.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
end;

procedure TPlayer.SetControllerType(const Value: TControllerType);
begin
  FControllerType := Value;
end;

procedure TPlayer.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TPlayer.SetGamePadID(const Value: integer);
begin
  FGamePadID := Value;
end;

procedure TPlayer.SetIsAlive(const Value: boolean);
begin
  FIsAlive := Value;
  // TODO: traiter mort du joueur
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
    if PlayerID = TCellType.Player1 then
      FPlayers[PlayerID].Restart;
end;

initialization

LTronGameData := nil;

finalization

LTronGameData.Free;

end.
