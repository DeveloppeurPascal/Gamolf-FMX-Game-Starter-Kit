unit uDMGameControllerCenter;

interface

uses
  System.SysUtils,
  System.Classes,
  Gamolf.RTL.Joystick;

type
  TDMGameControllerCenter = class(TDataModule)
    DGEGamepadManager1: TDGEGamepadManager;
    procedure DGEGamepadManager1DirectionPadChange(const GamepadID: Integer;
      const Value: TJoystickDPad);
    procedure DGEGamepadManager1ButtonDown(const GamepadID: Integer;
      const Button: TJoystickButtons);
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

procedure TDMGameControllerCenter.DGEGamepadManager1ButtonDown(const GamepadID
  : Integer; const Button: TJoystickButtons);
var
  Handled: boolean;
  Item: TUIElement;
begin
  TUIItemsList.Current.GamepadButtonDown(Button, Handled);
  if not Handled then
  begin
    Item := TUIItemsList.Current.Focused;
    if assigned(Item) and (Button = TJoystickButtons.a) then
      Item.DoClick;
  end;
end;

procedure TDMGameControllerCenter.DGEGamepadManager1DirectionPadChange
  (const GamepadID: Integer; const Value: TJoystickDPad);
begin
  TUIItemsList.Current.GamepadMove(Value);
end;

end.
