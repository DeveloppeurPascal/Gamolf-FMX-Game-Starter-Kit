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
  File last update : 2025-05-08T20:36:27.043+02:00
  Signature : 32068409c365cdc3e203e9f02afa627944a020c5
  ***************************************************************************
*)

unit uSceneControlsChoice;

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
  Gamolf.RTL.Joystick,
  FMX.Layouts,
  FMX.Objects,
  FMX.Effects,
  uTronGameData;

type
  TControlsChoiceScene = class(T__SceneAncestor)
    DGEGamepadManager1: TDGEGamepadManager;
    Layout1: TLayout;
    txtPlayer: TText;
    txtStep: TText;
    pUp: TPath;
    pLeft: TPath;
    pRight: TPath;
    pDown: TPath;
    GridPanelLayout1: TGridPanelLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    GlowEffect1: TGlowEffect;
    procedure DGEGamepadManager1AxesChange(const GamepadID: Integer;
      const Axe: TJoystickAxes; const Value: Single);
    procedure DGEGamepadManager1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
    procedure DGEGamepadManager1DirectionPadChange(const GamepadID: Integer;
      const Value: TJoystickDPad);
    procedure FrameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
  private
    FPlayerID: TCellType;
    FStepID: Integer;
    FIsWaiting: boolean;
    procedure SetPlayerID(const Value: TCellType);
    procedure SetStepID(const Value: Integer);
    procedure SetIsWaiting(const Value: boolean);
  protected
  public
    property PlayerID: TCellType read FPlayerID write SetPlayerID;
    property StepID: Integer read FStepID write SetStepID;
    property IsWaiting: boolean read FIsWaiting write SetIsWaiting;
    procedure HideScene; override;
    procedure ShowScene; override;
    procedure GotoNextStep;
    procedure InitArrowsOpacity;
    procedure WaitAndCheckIfTestIsOk;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  Gamolf.RTL.UIElements;

const
  CStepChooseUp = 1;
  CStepChooseBottom = 2;
  CStepChooseLeft = 3;
  CStepChooseRight = 4;
  CStepTest = 5;
  CStepNext = 6;

procedure TControlsChoiceScene.AfterConstruction;
begin
  inherited;
  DGEGamepadManager1.Enabled := false;
end;

procedure TControlsChoiceScene.DGEGamepadManager1AxesChange(const GamepadID
  : Integer; const Axe: TJoystickAxes; const Value: Single);
var
  TGD: TTronGameData;
begin
  if IsWaiting then
    exit;

  if (Value > -0.9) and (Value < 0.9) then
    exit;

  TGD := TTronGameData.Current;

  case StepID of
    CStepChooseUp:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeUp := TControllerType.Axe;
        TGD.Players[PlayerID].GamePadIDUp := GamepadID;
        TGD.Players[PlayerID].AxeIDUp := Axe;
        TGD.Players[PlayerID].AxeValueUp := Value;
        tthread.Synchronize(nil,
          procedure
          begin
            pUp.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseRight:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeRight := TControllerType.Axe;
        TGD.Players[PlayerID].GamePadIDRight := GamepadID;
        TGD.Players[PlayerID].AxeIDRight := Axe;
        TGD.Players[PlayerID].AxeValueRight := Value;
        tthread.Synchronize(nil,
          procedure
          begin
            pRight.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseBottom:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeDown := TControllerType.Axe;
        TGD.Players[PlayerID].GamePadIDDown := GamepadID;
        TGD.Players[PlayerID].AxeIDDown := Axe;
        TGD.Players[PlayerID].AxeValueDown := Value;
        tthread.Synchronize(nil,
          procedure
          begin
            pDown.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseLeft:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeLeft := TControllerType.Axe;
        TGD.Players[PlayerID].GamePadIDLeft := GamepadID;
        TGD.Players[PlayerID].AxeIDLeft := Axe;
        TGD.Players[PlayerID].AxeValueLeft := Value;
        tthread.Synchronize(nil,
          procedure
          begin
            pLeft.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepTest:
      begin
        if (TGD.Players[PlayerID].ControllerTypeUp = TControllerType.Axe) and
          (TGD.Players[PlayerID].GamePadIDUp = GamepadID) and
          (TGD.Players[PlayerID].AxeIDUp = Axe) and
          (((TGD.Players[PlayerID].AxeValueUp > 0) and (Value > 0)) or
          ((TGD.Players[PlayerID].AxeValueUp < 0) and (Value < 0))) and
          (abs(Value) > 0.9 * abs(TGD.Players[PlayerID].AxeValueUp)) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pUp.Opacity := 1;
              pUp.tag := pUp.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeRight = TControllerType.
          Axe) and (TGD.Players[PlayerID].GamePadIDRight = GamepadID) and
          (TGD.Players[PlayerID].AxeIDRight = Axe) and
          (((TGD.Players[PlayerID].AxeValueRight > 0) and (Value > 0)) or
          ((TGD.Players[PlayerID].AxeValueRight < 0) and (Value < 0))) and
          (abs(Value) > 0.9 * abs(TGD.Players[PlayerID].AxeValueRight)) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pRight.Opacity := 1;
              pRight.tag := pRight.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeDown = TControllerType.Axe)
          and (TGD.Players[PlayerID].GamePadIDDown = GamepadID) and
          (TGD.Players[PlayerID].AxeIDDown = Axe) and
          (((TGD.Players[PlayerID].AxeValueDown > 0) and (Value > 0)) or
          ((TGD.Players[PlayerID].AxeValueDown < 0) and (Value < 0))) and
          (abs(Value) > 0.9 * abs(TGD.Players[PlayerID].AxeValueDown)) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pDown.Opacity := 1;
              pDown.tag := pDown.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeLeft = TControllerType.Axe)
          and (TGD.Players[PlayerID].GamePadIDLeft = GamepadID) and
          (TGD.Players[PlayerID].AxeIDLeft = Axe) and
          (((TGD.Players[PlayerID].AxeValueLeft > 0) and (Value > 0)) or
          ((TGD.Players[PlayerID].AxeValueLeft < 0) and (Value < 0))) and
          (abs(Value) > 0.9 * abs(TGD.Players[PlayerID].AxeValueLeft)) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pLeft.Opacity := 1;
              pLeft.tag := pLeft.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end;
      end;
  else
    raise Exception.Create('Unknown step ' + StepID.ToString);
  end;
end;

procedure TControlsChoiceScene.DGEGamepadManager1ButtonDown(const GamepadID
  : Integer; const Button: TJoystickButtons);
var
  TGD: TTronGameData;
begin
  if IsWaiting then
    exit;

  TGD := TTronGameData.Current;

  case StepID of
    CStepChooseUp:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeUp := TControllerType.Button;
        TGD.Players[PlayerID].GamePadIDUp := GamepadID;
        TGD.Players[PlayerID].ButtonUp := Button;
        tthread.Synchronize(nil,
          procedure
          begin
            pUp.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseRight:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeRight := TControllerType.Button;
        TGD.Players[PlayerID].GamePadIDRight := GamepadID;
        TGD.Players[PlayerID].ButtonRight := Button;
        tthread.Synchronize(nil,
          procedure
          begin
            pRight.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseBottom:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeDown := TControllerType.Button;
        TGD.Players[PlayerID].GamePadIDDown := GamepadID;
        TGD.Players[PlayerID].ButtonDown := Button;
        tthread.Synchronize(nil,
          procedure
          begin
            pDown.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseLeft:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeLeft := TControllerType.Button;
        TGD.Players[PlayerID].GamePadIDLeft := GamepadID;
        TGD.Players[PlayerID].ButtonLeft := Button;
        tthread.Synchronize(nil,
          procedure
          begin
            pLeft.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepTest:
      begin
        if (TGD.Players[PlayerID].ControllerTypeUp = TControllerType.Button) and
          (TGD.Players[PlayerID].GamePadIDUp = GamepadID) and
          (TGD.Players[PlayerID].ButtonUp = Button) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pUp.Opacity := 1;
              pUp.tag := pUp.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeRight = TControllerType.
          Button) and (TGD.Players[PlayerID].GamePadIDRight = GamepadID) and
          (TGD.Players[PlayerID].ButtonRight = Button) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pRight.Opacity := 1;
              pRight.tag := pRight.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeDown = TControllerType.
          Button) and (TGD.Players[PlayerID].GamePadIDDown = GamepadID) and
          (TGD.Players[PlayerID].ButtonDown = Button) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pDown.Opacity := 1;
              pDown.tag := pDown.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeLeft = TControllerType.
          Button) and (TGD.Players[PlayerID].GamePadIDLeft = GamepadID) and
          (TGD.Players[PlayerID].ButtonLeft = Button) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pLeft.Opacity := 1;
              pLeft.tag := pLeft.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end;
      end;
  else
    raise Exception.Create('Unknown step ' + StepID.ToString);
  end;
end;

procedure TControlsChoiceScene.DGEGamepadManager1DirectionPadChange
  (const GamepadID: Integer; const Value: TJoystickDPad);
var
  TGD: TTronGameData;
begin
  if IsWaiting then
    exit;

  TGD := TTronGameData.Current;

  case StepID of
    CStepChooseUp:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeUp := TControllerType.DPad;
        TGD.Players[PlayerID].GamePadIDUp := GamepadID;
        TGD.Players[PlayerID].DPadUp := Value;
        tthread.Synchronize(nil,
          procedure
          begin
            pUp.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseRight:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeRight := TControllerType.DPad;
        TGD.Players[PlayerID].GamePadIDRight := GamepadID;
        TGD.Players[PlayerID].DPadRight := Value;
        tthread.Synchronize(nil,
          procedure
          begin
            pRight.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseBottom:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeDown := TControllerType.DPad;
        TGD.Players[PlayerID].GamePadIDDown := GamepadID;
        TGD.Players[PlayerID].DPadDown := Value;
        tthread.Synchronize(nil,
          procedure
          begin
            pDown.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepChooseLeft:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeLeft := TControllerType.DPad;
        TGD.Players[PlayerID].GamePadIDLeft := GamepadID;
        TGD.Players[PlayerID].DPadLeft := Value;
        tthread.Synchronize(nil,
          procedure
          begin
            pLeft.Opacity := 1;
          end);
        GotoNextStep;
      end;
    CStepTest:
      begin
        if (TGD.Players[PlayerID].ControllerTypeUp = TControllerType.DPad) and
          (TGD.Players[PlayerID].GamePadIDUp = GamepadID) and
          (TGD.Players[PlayerID].DPadUp = Value) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pUp.Opacity := 1;
              pUp.tag := pUp.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeRight = TControllerType.
          DPad) and (TGD.Players[PlayerID].GamePadIDRight = GamepadID) and
          (TGD.Players[PlayerID].DPadRight = Value) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pRight.Opacity := 1;
              pRight.tag := pRight.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeDown = TControllerType.
          DPad) and (TGD.Players[PlayerID].GamePadIDDown = GamepadID) and
          (TGD.Players[PlayerID].DPadDown = Value) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pDown.Opacity := 1;
              pDown.tag := pDown.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeLeft = TControllerType.
          DPad) and (TGD.Players[PlayerID].GamePadIDLeft = GamepadID) and
          (TGD.Players[PlayerID].DPadLeft = Value) then
        begin
          tthread.Synchronize(nil,
            procedure
            begin
              InitArrowsOpacity;
              pLeft.Opacity := 1;
              pLeft.tag := pLeft.tag + 1;
            end);
          WaitAndCheckIfTestIsOk;
        end;
      end;
  else
    raise Exception.Create('Unknown step ' + StepID.ToString);
  end;
end;

procedure TControlsChoiceScene.FrameKeyDown(Sender: TObject; var Key: Word;
var KeyChar: WideChar; Shift: TShiftState);
var
  TGD: TTronGameData;
begin
  if (Key = 0) and (KeyChar = #0) then
    exit;

  if IsWaiting then
  begin
    Key := 0;
    KeyChar := #0;
    exit;
  end;

  TGD := TTronGameData.Current;

  case StepID of
    CStepChooseUp:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeUp := TControllerType.Keyboard;
        TGD.Players[PlayerID].KeyUp := Key;
        TGD.Players[PlayerID].KeyCharUp := KeyChar;
        pUp.Opacity := 1;
        Key := 0;
        KeyChar := #0;
        GotoNextStep;
      end;
    CStepChooseRight:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeRight := TControllerType.Keyboard;
        TGD.Players[PlayerID].KeyRight := Key;
        TGD.Players[PlayerID].KeyCharRight := KeyChar;
        pRight.Opacity := 1;
        Key := 0;
        KeyChar := #0;
        GotoNextStep;
      end;
    CStepChooseBottom:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeDown := TControllerType.Keyboard;
        TGD.Players[PlayerID].KeyDown := Key;
        TGD.Players[PlayerID].KeyCharDown := KeyChar;
        pDown.Opacity := 1;
        Key := 0;
        KeyChar := #0;
        GotoNextStep;
      end;
    CStepChooseLeft:
      begin
        // TODO : check conflict (the key ust be used only once)
        TGD.Players[PlayerID].ControllerTypeLeft := TControllerType.Keyboard;
        TGD.Players[PlayerID].KeyLeft := Key;
        TGD.Players[PlayerID].KeyCharLeft := KeyChar;
        pLeft.Opacity := 1;
        Key := 0;
        KeyChar := #0;
        GotoNextStep;
      end;
    CStepTest:
      begin
        if (TGD.Players[PlayerID].ControllerTypeUp = TControllerType.Keyboard)
          and (TGD.Players[PlayerID].KeyUp = Key) and
          (TGD.Players[PlayerID].KeyCharUp = KeyChar) then
        begin
          InitArrowsOpacity;
          pUp.Opacity := 1;
          pUp.tag := pUp.tag + 1;
          Key := 0;
          KeyChar := #0;
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeRight = TControllerType.
          Keyboard) and (TGD.Players[PlayerID].KeyRight = Key) and
          (TGD.Players[PlayerID].KeyCharRight = KeyChar) then
        begin
          InitArrowsOpacity;
          pRight.Opacity := 1;
          pRight.tag := pRight.tag + 1;
          Key := 0;
          KeyChar := #0;
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeDown = TControllerType.
          Keyboard) and (TGD.Players[PlayerID].KeyDown = Key) and
          (TGD.Players[PlayerID].KeyCharDown = KeyChar) then
        begin
          InitArrowsOpacity;
          pDown.Opacity := 1;
          pDown.tag := pDown.tag + 1;
          Key := 0;
          KeyChar := #0;
          WaitAndCheckIfTestIsOk;
        end
        else if (TGD.Players[PlayerID].ControllerTypeLeft = TControllerType.
          Keyboard) and (TGD.Players[PlayerID].KeyLeft = Key) and
          (TGD.Players[PlayerID].KeyCharLeft = KeyChar) then
        begin
          InitArrowsOpacity;
          pLeft.Opacity := 1;
          pLeft.tag := pLeft.tag + 1;
          Key := 0;
          KeyChar := #0;
          WaitAndCheckIfTestIsOk;
        end;
      end;
  else
    raise Exception.Create('Unknown step ' + StepID.ToString);
  end;
end;

procedure TControlsChoiceScene.GotoNextStep;
begin
  IsWaiting := true;
  tthread.CreateAnonymousThread(
    procedure
    begin
      // TODO : play a "ok" song
      sleep(300);
      tthread.queue(nil,
        procedure
        begin
          IsWaiting := false;
          StepID := StepID + 1;
        end);
    end).Start;
end;

procedure TControlsChoiceScene.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
  DGEGamepadManager1.Enabled := false;
end;

procedure TControlsChoiceScene.InitArrowsOpacity;
begin
  pUp.Opacity := 0.3;
  pRight.Opacity := 0.3;
  pDown.Opacity := 0.3;
  pLeft.Opacity := 0.3;
end;

procedure TControlsChoiceScene.SetIsWaiting(const Value: boolean);
begin
  FIsWaiting := Value;
end;

procedure TControlsChoiceScene.SetPlayerID(const Value: TCellType);
begin
  FPlayerID := Value;
  // TODO : translate text
  txtPlayer.Text := 'Player ' + (ord(FPlayerID) - ord(TCellType.Player1) +
    1).ToString;
  GlowEffect1.GlowColor := TTronGameData.Current.Players[FPlayerID].Color;
  StepID := CStepChooseUp;
end;

procedure TControlsChoiceScene.SetStepID(const Value: Integer);
begin
  InitArrowsOpacity;
  FIsWaiting := false;
  FStepID := Value;
  case FStepID of
    CStepChooseUp: // Choose UP control
      begin
        // TODO : translate text
        txtStep.Text := 'Move to the top.';
        pUp.Opacity := 0.8;
      end;
    CStepChooseRight: // Choose RIGHT control
      begin
        // TODO : translate text
        txtStep.Text := 'Move to the right.';
        pRight.Opacity := 0.8;
      end;
    CStepChooseBottom: // Choose DOWN control
      begin
        // TODO : translate text
        txtStep.Text := 'Move to the bottom.';
        pDown.Opacity := 0.8;
      end;
    CStepChooseLeft: // Choose LEFT control
      begin
        // TODO : translate text
        txtStep.Text := 'Move to the left.';
        pLeft.Opacity := 0.8;
      end;
    CStepTest: // Test controls
      begin
        // TODO : translate text
        txtStep.Text := 'Test each direction two times.';
        pUp.tag := 0;
        pRight.tag := 0;
        pDown.tag := 0;
        pLeft.tag := 0;
      end;
    CStepNext: // Next player
      begin
        if PlayerID < TCellType.Player4 then
        begin
          PlayerID := TCellType(ord(PlayerID) + 1);
          if not TTronGameData.Current.Players[PlayerID].Enabled then
            SetStepID(6)
          else
            StepID := 1;
        end
        else
          tscene.Current := TSceneType.Game;
      end;
  else
    raise Exception.Create('Unknow step ' + FStepID.ToString);
  end;
end;

procedure TControlsChoiceScene.ShowScene;
begin
  inherited;
  TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      tscene.Current := TSceneType.Home;
    end).KeyShortcuts.Add(vkescape, #0, []);

  PlayerID := TCellType.Player1;

  DGEGamepadManager1.Enabled := true;
end;

procedure TControlsChoiceScene.WaitAndCheckIfTestIsOk;
begin
  IsWaiting := true;
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(300);
      tthread.queue(nil,
        procedure
        begin
          IsWaiting := false;
          if (pUp.tag > 1) and (pRight.tag > 1) and (pDown.tag > 1) and
            (pLeft.tag > 1) then
            GotoNextStep
          else
            InitArrowsOpacity;
        end);
    end).Start;
end;

initialization

tscene.RegisterScene<TControlsChoiceScene>(TSceneType.ControlsChoice);

end.
