unit uSceneSnake;

interface

// TODO : add virtual controllers for iOS/Android

uses
  System.Messaging,
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
  Gamolf.RTL.Joystick,
  FMX.Objects,
  FMX.Layouts,
  Gamolf.RTL.GamepadDetected,
  _ScenesAncestor,
  FMX.Effects;

const
  CFPS = 60;
  CCellSize = 10;
  CColCount = 32;
  CRowCount = 20;
  CDefaultSpeed = 3 * CFPS / 1000; // Nb cells by second

type
  TCellType = (Nothing, SnakeHead, SnakeQueue, SnakeBody, Bonus);
  TCells = array [0 .. (CColCount - 1), 0 .. (CRowCount - 1)] of TCellType;

  TSnakePart = class
  public
    X, Y: integer;
    Next: TSnakePart;
    constructor Create(const AX, AY: integer); virtual;
    procedure Clear; virtual;
  end;

  TSnakeScene = class(T__SceneAncestor)
    DGEGamepadManager1: TDGEGamepadManager;
    slScreen: TScaledLayout;
    imgScreen: TImage;
    rBackground: TRectangle;
    GameLoop: TTimer;
    txtScore: TText;
    GlowEffect1: TGlowEffect;
    Layout1: TLayout;
    procedure FrameResized(Sender: TObject);
    procedure GameLoopTimer(Sender: TObject);
    procedure DGEGamepadManager1DirectionPadChange(const GamepadID: integer;
      const Value: TJoystickDPad);
    procedure DGEGamepadManager1AxesChange(const GamepadID: integer;
      const Axe: TJoystickAxes; const Value: Single);
  private
    FFirstX: Single;
    FFirstY: Single;
    FVX: integer;
    FVY: integer;
    FNewVX: integer;
    FNewVY: integer;
    FSpeed: Single;
    FGameGrid: TCells;
    FHasBonus: boolean;
    FBonusX: integer;
    FBonusY: integer;
    FFirstPart: TSnakePart;
    FLastPart: TSnakePart;
    FScore: int64;
    procedure SetFirstX(const Value: Single);
    procedure SetFirstY(const Value: Single);
    procedure SetSpeed(const Value: Single);
    procedure ToTheLeft;
    procedure ToTheRight;
    procedure ToTheTop;
    procedure ToTheBottom;
    procedure SetBonusX(const Value: integer);
    procedure SetBonusY(const Value: integer);
    procedure SetScore(const Value: int64);
  protected
    procedure DrawCell(const X, Y: integer);
    procedure DoScoreChanged(const Sender: TObject; const Msg: TMessage);
  public
    property FirstX: Single read FFirstX write SetFirstX;
    property FirstY: Single read FFirstY write SetFirstY;
    property Speed: Single read FSpeed write SetSpeed;
    property HasBonus: boolean read FHasBonus;
    property BonusX: integer read FBonusX write SetBonusX;
    property BonusY: integer read FBonusY write SetBonusY;
    property Score: int64 read FScore write SetScore;
    procedure InitGame;
    procedure InitKeyboard;
    procedure AfterConstruction; override;
    procedure AddBonus;
    procedure TheSnakeEatTheBonus;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    procedure ShowScene; override;
    procedure HideScene; override;
  end;

implementation

{$R *.fmx}

uses
  uConsts,
  uScene,
  System.SyncObjs,
  uUIElements,
  uGameData, Gamolf.RTL.UIElements, uDMHelpBarManager, USVGInputPrompts;

procedure TSnakeScene.AddBonus;
var
  i: integer;
begin
  if HasBonus then
    exit;

  BonusX := random(CColCount - 2) + 1;
  BonusY := random(CRowCount - 2) + 1;
  i := (CColCount - 2) * (CRowCount - 2);
  while (FGameGrid[BonusX, BonusY] <> TCellType.Nothing) and (i > 0) do
  begin
    dec(i);
    if (BonusX < CColCount - 2) then
      BonusX := BonusX + 1
    else
    begin
      BonusX := 1;
      if (BonusY < CRowCount - 2) then
        BonusY := BonusY + 1
      else
        BonusY := 1;
    end;
  end;

  if (i > 0) then
  begin
    FHasBonus := true;
    FGameGrid[BonusX, BonusY] := TCellType.Bonus;
    DrawCell(BonusX, BonusY);
  end;
end;

procedure TSnakeScene.AfterConstruction;
begin
  inherited;
  slScreen.OriginalWidth := CCellSize * CColCount;
  slScreen.OriginalHeight := CCellSize * CRowCount;

  GameLoop.Enabled := false;
end;

constructor TSnakeScene.Create(AOwner: TComponent);
begin
  inherited;
  FFirstPart := nil;
  FLastPart := nil;
end;

procedure TSnakeScene.TheSnakeEatTheBonus;
begin
  FHasBonus := false;
  FGameGrid[BonusX, BonusY] := TCellType.Nothing;
  tgamedata.DefaultGameData.Score := tgamedata.DefaultGameData.Score + 50;
end;

procedure TSnakeScene.ToTheBottom;
begin
  if (FVY = -1) or (FNewVY = 1) then
    exit;

  tinterlocked.add(FNewVX, -FNewVX);
  tinterlocked.add(FNewVY, -FNewVY);
  tinterlocked.Increment(FNewVY);
end;

procedure TSnakeScene.ToTheTop;
begin
  if (FVY = 1) or (FNewVY = -1) then
    exit;

  tinterlocked.add(FNewVX, -FNewVX);
  tinterlocked.add(FNewVY, -FNewVY);
  tinterlocked.Decrement(FNewVY);
end;

procedure TSnakeScene.ToTheRight;
begin
  if (FVX = -1) or (FNewVX = 1) then
    exit;

  tinterlocked.add(FNewVX, -FNewVX);
  tinterlocked.Increment(FNewVX);
  tinterlocked.add(FNewVY, -FNewVY);
end;

procedure TSnakeScene.ToTheLeft;
begin
  if (FVX = 1) or (FNewVX = -1) then
    exit;

  tinterlocked.add(FNewVX, -FNewVX);
  tinterlocked.Decrement(FNewVX);
  tinterlocked.add(FNewVY, -FNewVY);
end;

destructor TSnakeScene.Destroy;
begin
  if assigned(FLastPart) then
    FLastPart.Clear;
  inherited;
end;

procedure TSnakeScene.DGEGamepadManager1AxesChange(const GamepadID: integer;
  const Axe: TJoystickAxes; const Value: Single);
begin
  if (Axe in [TJoystickAxes.LeftStickX, TJoystickAxes.RightStickX]) and
    (abs(Value) > 0.9) then
  begin
    if Value > 0 then
      ToTheRight
    else
      ToTheLeft;
  end
  else if (Axe in [TJoystickAxes.LeftSticky, TJoystickAxes.RightSticky]) and
    (abs(Value) > 0.9) then
  begin
    if Value > 0 then
      ToTheBottom
    else
      ToTheTop;
  end;
end;

procedure TSnakeScene.DGEGamepadManager1DirectionPadChange(const GamepadID
  : integer; const Value: TJoystickDPad);
begin
  if Value = TJoystickDPad.Left then
    ToTheLeft
  else if Value = TJoystickDPad.Right then
    ToTheRight
  else if Value = TJoystickDPad.Top then
    ToTheTop
  else if Value = TJoystickDPad.Bottom then
    ToTheBottom;
end;

procedure TSnakeScene.DoScoreChanged(const Sender: TObject;
  const Msg: TMessage);
begin
  Score := tgamedata.DefaultGameData.Score;
end;

procedure TSnakeScene.DrawCell(const X, Y: integer);
begin
  imgScreen.Bitmap.Canvas.BeginScene;
  try
    case FGameGrid[X, Y] of
      TCellType.Nothing:
        imgScreen.Bitmap.Canvas.fill.Color := TAlphaColors.Greenyellow;
      TCellType.SnakeHead:
        imgScreen.Bitmap.Canvas.fill.Color := TAlphaColors.Darkolivegreen;
      TCellType.SnakeQueue:
        imgScreen.Bitmap.Canvas.fill.Color := TAlphaColors.Darkseagreen;
      TCellType.SnakeBody:
        imgScreen.Bitmap.Canvas.fill.Color := TAlphaColors.Forestgreen;
      TCellType.Bonus:
        imgScreen.Bitmap.Canvas.fill.Color := TAlphaColors.Orange;
    end;
    imgScreen.Bitmap.Canvas.FillRect(trectf.Create(X * CCellSize, Y * CCellSize,
      (X * CCellSize + CCellSize), (Y * CCellSize + CCellSize)), 1);
  finally
    imgScreen.Bitmap.Canvas.EndScene;
  end;
end;

procedure TSnakeScene.FrameResized(Sender: TObject);
var
  ratio: Single;
  w, h: Single;
begin
  ratio := slScreen.OriginalWidth / slScreen.OriginalHeight;

  w := Width - rBackground.Stroke.Thickness * 2;
  h := w / ratio;
  if (h >= Height - rBackground.Stroke.Thickness * 2) then
  begin
    h := Height - rBackground.Stroke.Thickness * 2;
    w := h * ratio;
  end;

  rBackground.Width := w;
  rBackground.Height := h;
end;

procedure TSnakeScene.GameLoopTimer(Sender: TObject);
var
  PrevX, PrevY, X, Y: integer;
  AllowMoveQueue: boolean;
  PrevLastPart: TSnakePart;
begin
  if (not GameLoop.Enabled) or (not tgamedata.DefaultGameData.IsPlaying) then
    exit;

  // Move the snake

  PrevX := round(FirstX);
  PrevY := round(FirstY);

  if (FVX <> FNewVX) or (FVY <> FNewVY) then
  begin
    FVX := FNewVX;
    FVY := FNewVY;
    FirstX := FFirstPart.X + FVX;
    FirstY := FFirstPart.Y + FVY;
  end
  else
  begin
    FirstX := FirstX + FVX * Speed;
    FirstY := FirstY + FVY * Speed;
  end;

  X := round(FirstX);
  Y := round(FirstY);

  if (PrevX <> X) or (PrevY <> Y) then
  begin
    // Check collision with borders and snake parts
    if ((X < 0) or (Y < 0) or (X >= CColCount) or (Y >= CRowCount)) or
      (FGameGrid[X, Y] in [TCellType.SnakeHead, TCellType.SnakeBody,
      TCellType.SnakeQueue]) then
    begin
      tgamedata.DefaultGameData.StopGame;
      tscene.Current := TSceneType.GameOver;
      exit;
    end;

    // Check bonus
    if FGameGrid[X, Y] = TCellType.Bonus then
    begin
      TheSnakeEatTheBonus;
      AllowMoveQueue := false;
    end
    else
    begin
      tgamedata.DefaultGameData.Score := tgamedata.DefaultGameData.Score + 1;
      AllowMoveQueue := true;
    end;

    FGameGrid[X, Y] := TCellType.SnakeHead;
    DrawCell(X, Y);
    FGameGrid[PrevX, PrevY] := TCellType.SnakeBody;
    DrawCell(PrevX, PrevY);

    FFirstPart.Next := TSnakePart.Create(X, Y);
    FFirstPart := FFirstPart.Next;

    // Move snake queue
    if AllowMoveQueue then
    begin
      PrevLastPart := FLastPart;
      FLastPart := PrevLastPart.Next;
      FGameGrid[FLastPart.X, FLastPart.Y] := TCellType.SnakeHead;
      DrawCell(FLastPart.X, FLastPart.Y);
      FGameGrid[PrevLastPart.X, PrevLastPart.Y] := TCellType.Nothing;
      DrawCell(PrevLastPart.X, PrevLastPart.Y);
      PrevLastPart.free;
    end;
  end;

  if (not HasBonus) and (random(100) > 80) then
    AddBonus;
end;

procedure TSnakeScene.HideScene;
begin
  inherited;
  GameLoop.Enabled := false;

  TUIItemsList.Current.RemoveLayout;

  TMessageManager.DefaultManager.Unsubscribe(TScoreChangedMessage,
    DoScoreChanged, true);
end;

procedure TSnakeScene.InitGame;
var
  X, Y: integer;
begin
  imgScreen.Bitmap.SetSize
    (round(imgScreen.Width * imgScreen.Bitmap.BitmapScale),
    round(imgScreen.Height * imgScreen.Bitmap.BitmapScale));
  imgScreen.Bitmap.Clear(TAlphaColors.Red);

  // Init grid
  for X := 0 to CColCount - 1 do
    for Y := 0 to CRowCount - 1 do
    begin
      FGameGrid[X, Y] := TCellType.Nothing;
      DrawCell(X, Y);
    end;

  // Init snake position and size
  if assigned(FLastPart) then
    FLastPart.Clear;

  // -> head
  FFirstPart := TSnakePart.Create(CColCount div 2, CRowCount div 2);
  FGameGrid[FFirstPart.X, FFirstPart.Y] := TCellType.SnakeHead;
  DrawCell(FFirstPart.X, FFirstPart.Y);
  FirstX := FFirstPart.X;
  FirstY := FFirstPart.Y;
  // -> queue
  FLastPart := TSnakePart.Create(FFirstPart.X + 2, FFirstPart.Y);
  FGameGrid[FLastPart.X, FLastPart.Y] := TCellType.SnakeQueue;
  DrawCell(FLastPart.X, FLastPart.Y);
  // -> body
  FLastPart.Next := TSnakePart.Create(FFirstPart.X + 1, FFirstPart.Y);
  FLastPart.Next.Next := FFirstPart;
  FGameGrid[FFirstPart.X + 1, FFirstPart.Y] := TCellType.SnakeBody;
  DrawCell(FFirstPart.X + 1, FFirstPart.Y);

  // -> speed and direction
  Speed := CDefaultSpeed;
  FNewVX := -1;
  FNewVY := 0;
  FVX := FNewVX;
  FVY := FNewVY;

  // Bonus
  FHasBonus := false;
end;

procedure TSnakeScene.InitKeyboard;
var
  item: TUIElement;
begin
  TUIItemsList.Current.NewLayout;

  TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      ToTheLeft;
    end).KeyShortcuts.add(vkLeft, #0, []);
  TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      ToTheRight;
    end).KeyShortcuts.add(vkRight, #0, []);
  TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      ToTheTop;
    end).KeyShortcuts.add(vkUp, #0, []);
  TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      ToTheBottom;
    end).KeyShortcuts.add(vkDown, #0, []);

  item := TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      tgamedata.DefaultGameData.StopGame;
      tscene.Current := TSceneType.Home;
    end);
  item.KeyShortcuts.add(vkEscape, #0, []);
  item.GamePadButtons := [TJoystickButtons.X];

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowLeft +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadLeftOutline +
    TSVGInputPrompts.Tag);
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowUp +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadUpOutline +
    TSVGInputPrompts.Tag);
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowRight +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadRightOutline +
    TSVGInputPrompts.Tag);
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowDown +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadDownOutline +
    TSVGInputPrompts.Tag, 'Move');
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardEscape +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorXOutline +
    TSVGInputPrompts.Tag, 'Quit');
end;

procedure TSnakeScene.SetBonusX(const Value: integer);
begin
  FBonusX := Value;
end;

procedure TSnakeScene.SetBonusY(const Value: integer);
begin
  FBonusY := Value;
end;

procedure TSnakeScene.SetFirstX(const Value: Single);
begin
  FFirstX := Value;
end;

procedure TSnakeScene.SetFirstY(const Value: Single);
begin
  FFirstY := Value;
end;

procedure TSnakeScene.SetScore(const Value: int64);
begin
  FScore := Value;
  txtScore.Text := 'Score: ' + FScore.tostring;
end;

procedure TSnakeScene.SetSpeed(const Value: Single);
begin
  FSpeed := Value;
end;

procedure TSnakeScene.ShowScene;
begin
  inherited;

  InitGame;

  InitKeyboard;

  Score := 0;
  TMessageManager.DefaultManager.SubscribeToMessage(TScoreChangedMessage,
    DoScoreChanged);

  GameLoop.Interval := round(1000 / CFPS);
  GameLoop.Enabled := true;
end;

{ TSnakePart }

procedure TSnakePart.Clear;
begin
  if assigned(Next) then
    Next.Clear;
  tthread.forcequeue(nil,
    procedure
    begin
      free;
    end);
end;

constructor TSnakePart.Create(const AX, AY: integer);
begin
  inherited Create;
  X := AX;
  Y := AY;
  Next := nil;
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSnakeScene;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Game) then
    begin
      NewScene := TSnakeScene.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Game, NewScene);
    end;
  end);

randomize;

end.
