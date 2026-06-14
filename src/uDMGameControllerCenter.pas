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
  File last update : 2026-04-02T19:25:40.752+02:00
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
