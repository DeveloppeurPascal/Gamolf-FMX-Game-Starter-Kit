unit uUIElements;

interface

uses
  FMX.Controls,
  Gamolf.RTL.UIElements;

type
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
    /// Add a control to the current list of User Interface elements and the
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
      begin
        if assigned(Sender) and (Sender is TUIElement) and
          assigned((Sender as TUIElement).TagObject) and
          ((Sender as TUIElement).TagObject is TControl) and
          assigned(((Sender as TUIElement).TagObject as TControl).OnClick) then
          ((Sender as TUIElement).TagObject as TControl)
            .OnClick((Sender as TUIElement).TagObject as TControl);
      end);
    item.OnPaintProc := procedure(const Sender: TObject)
      begin
        if assigned(Sender) and (Sender is TUIElement) and
          (Sender as TUIElement).IsFocused and
          assigned((Sender as TUIElement).TagObject) and
          ((Sender as TUIElement).TagObject is TControl) and
          assigned(((Sender as TUIElement).TagObject as TControl).OnClick) then
          ((Sender as TUIElement).TagObject as TControl).SetFocus;
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
