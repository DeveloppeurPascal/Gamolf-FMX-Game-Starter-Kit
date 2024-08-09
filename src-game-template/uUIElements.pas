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
/// File last update : 2024-08-09T22:17:48.000+02:00
/// Signature : b1ca1460badfd300fa8f122e7b74be2a2b585359
/// ***************************************************************************
/// </summary>

unit uUIElements;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  FMX.Controls,
  Gamolf.RTL.UIElements;

type
  /// <summary>
  /// Implement this interface on elements you want to add to TUIElements
  /// </summary>
  IUIControl = interface
    ['{0C1BD2A6-6312-4C78-89B3-550BF8425DD1}']
    procedure SetFocus;
    procedure ResetFocus;
    procedure Click(Sender: TObject);
  end;

  /// <summary>
  /// This class manage the user interface elements and movements between them.
  /// </summary>
  TUIItemsList = class(TUIElementsList)
  private
  protected
    procedure OnControlEnter(Sender: TObject);
  public
    /// <summary>
    /// Add default shortkeys to quit the game : ESC, HardwareBack and gamepad "X" button
    /// </summary>
    procedure AddQuit;
    /// <summary>
    /// Add a TControl to the current list of User Interface elements and the
    /// path to move around from keyboard arrows and a game controller DPad.
    /// </summary>
    procedure AddControl(const Control, TopControl, RightControl, BottomControl,
      LeftControl: TControl; const HasFocus: boolean = false;
      const IsBackControl: boolean = false);
    /// <summary>
    /// Returns default instance to "play" with
    /// </summary>
    class function Current: TUIItemsList;
  end;

implementation

uses
  System.UITypes,
  Gamolf.RTL.Joystick,
  uScene,
  uConsts;

var
  UIElements: TUIItemsList;

  { TUIItemsList }

procedure TUIItemsList.AddControl(const Control, TopControl, RightControl,
  BottomControl, LeftControl: TControl; const HasFocus: boolean;
  const IsBackControl: boolean);
var
  item: TUIElement;
begin
  if assigned(Control) then
  begin
    item := AddUIItem(
      procedure(const Sender: TObject)
      var
        UIControl: IUIControl;
      begin
        if assigned(Sender) and (Sender is TUIElement) and
          assigned((Sender as TUIElement).TagObject) and
          ((Sender as TUIElement).TagObject is TControl) then
          if ((Sender as TUIElement).TagObject as TControl)
            .GetInterface(IUIControl, UIControl) then
            UIControl.Click((Sender as TUIElement).TagObject as TControl)
          else if assigned(((Sender as TUIElement).TagObject as TControl)
            .OnClick) then
            ((Sender as TUIElement).TagObject as TControl)
              .OnClick((Sender as TUIElement).TagObject as TControl);
      end);
    item.OnPaintProc := procedure(const Sender: TObject)
      var
        UIControl: IUIControl;
      begin
        if assigned(Sender) and (Sender is TUIElement) and
          assigned((Sender as TUIElement).TagObject) and
          ((Sender as TUIElement).TagObject is TControl) then
          if ((Sender as TUIElement).TagObject as TControl)
            .GetInterface(IUIControl, UIControl) then
          begin
            if (Sender as TUIElement).IsFocused then
              UIControl.SetFocus
            else
              UIControl.ResetFocus
          end
          else if (Sender as TUIElement).IsFocused then
            ((Sender as TUIElement).TagObject as TControl).SetFocus
          else
            ((Sender as TUIElement).TagObject as TControl).ResetFocus;
      end;
    item.TagObject := Control;
    Control.TagObject := item;
    Control.OnEnter := OnControlEnter;
    item.TopItem := GetElementByTagObject(TopControl);
    item.RightItem := GetElementByTagObject(RightControl);
    item.BottomItem := GetElementByTagObject(BottomControl);
    item.LeftItem := GetElementByTagObject(LeftControl);

    if HasFocus then
      item.SetFocus;

    if IsBackControl then
    begin
      item.KeyShortcuts.Add(vkEscape, #0, []);
      item.KeyShortcuts.Add(vkHardwareBack, #0, []);
      item.GamePadButtons := [TJoystickButtons.x];
    end;
  end;
end;

procedure TUIItemsList.AddQuit;
var
  item: TUIElement;
begin
  item := AddUIItem(
    procedure(const Sender: TObject)
    begin
      TScene.Current := TSceneType.Exit;
    end);
  item.KeyShortcuts.Add(vkEscape, #0, []);
  item.KeyShortcuts.Add(vkHardwareBack, #0, []);
  item.GamePadButtons := [TJoystickButtons.x];
end;

class function TUIItemsList.Current: TUIItemsList;
begin
  if not assigned(UIElements) then
    UIElements := TUIItemsList.Create;

  result := UIElements;
end;

procedure TUIItemsList.OnControlEnter(Sender: TObject);
begin
  if (Sender is TControl) and assigned((Sender as TControl).TagObject) and
    ((Sender as TControl).TagObject is TUIElement) then
    ((Sender as TControl).TagObject as TUIElement).SetFocus;
end;

initialization

UIElements := nil;

finalization

UIElements.Free;

end.
