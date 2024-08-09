/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Template
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
/// The "Gamolf FMX Game Template" is both a "technical" example of a video
/// game developed in Delphi with everything you need inside, and a reusable
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
/// https://gametemplate.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Template
///
/// ***************************************************************************
/// File last update : 2024-08-08T21:06:54.000+02:00
/// Signature : aa0232ae3bea54bd5dc631f7ffb20fe43bc29090
/// ***************************************************************************
/// </summary>

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
