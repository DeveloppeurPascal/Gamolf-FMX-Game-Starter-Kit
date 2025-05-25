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
  File last update : 2025-02-09T11:12:49.095+01:00
  Signature : 7009c106cd84dbb8bdaecabf690b92b4cbba05d3
  ***************************************************************************
*)

unit uDMGameControllerCenter;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.SysUtils,
  System.Classes,
  Gamolf.RTL.Joystick;

type
  TDMGameControllerCenter = class(TDataModule)
    DGEGamepadManager1: TDGEGamepadManager;
    procedure DGEGamepadManager1DirectionPadChange(const AGamepadID: Integer;
      const AValue: TJoystickDPad);
    procedure DGEGamepadManager1ButtonDown(const AGamepadID: Integer;
      const AButton: TJoystickButtons);
    procedure DGEGamepadManager1AxesChange(const GamepadID: Integer;
      const Axe: TJoystickAxes; const Value: Single);
  private
  public
  end;

var
  DMGameControllerCenter: TDMGameControllerCenter;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  uUIElements,
  Gamolf.RTL.UIElements;

{$R *.dfm}

procedure TDMGameControllerCenter.DGEGamepadManager1AxesChange(const GamepadID
  : Integer; const Axe: TJoystickAxes; const Value: Single);
begin
  if (Axe in [TJoystickAxes.LeftStickX, TJoystickAxes.RightStickX]) then
  begin
    if (Value > 0.9) then
      DGEGamepadManager1DirectionPadChange(GamepadID, TJoystickDPad.Right)
    else if (Value < -0.9) then
      DGEGamepadManager1DirectionPadChange(GamepadID, TJoystickDPad.Left);
  end
  else if (Axe in [TJoystickAxes.LeftSticky, TJoystickAxes.RightSticky]) then
  begin
    if (Value > 0.9) then
      DGEGamepadManager1DirectionPadChange(GamepadID, TJoystickDPad.Bottom)
    else if (Value < -0.9) then
      DGEGamepadManager1DirectionPadChange(GamepadID, TJoystickDPad.Top);
  end;
end;

procedure TDMGameControllerCenter.DGEGamepadManager1ButtonDown(const AGamepadID
  : Integer; const AButton: TJoystickButtons);
var
  LButton: TJoystickButtons;
begin
  LButton := AButton;
  tthread.queue(nil,
    procedure
    var
      Handled: boolean;
      Item: TUIElement;
    begin
      TUIItemsList.Current.GamepadButtonDown(LButton, Handled);
      if not Handled then
      begin
        Item := TUIItemsList.Current.Focused;
        if assigned(Item) and (LButton = TJoystickButtons.a) then
          Item.DoClick;
      end;
    end);
end;

procedure TDMGameControllerCenter.DGEGamepadManager1DirectionPadChange
  (const AGamepadID: Integer; const AValue: TJoystickDPad);
var
  LValue: TJoystickDPad;
begin
  LValue := AValue;
  tthread.queue(nil,
    procedure
    begin
      TUIItemsList.Current.GamepadMove(LValue);
    end);
end;

end.
