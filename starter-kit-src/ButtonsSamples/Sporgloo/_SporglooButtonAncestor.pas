unit _SporglooButtonAncestor;

interface

// Button created by Patrick Prémartin for "Sporgloo" game
// This game is available at https://sporgloo.gamolf.fr
//
// The button's background are bitmaps from the "UI Pack".
// The images are licensed by Kenney (https://kenney.nl).
//
// The check image come from Pictogrammers.com website
// It's licensed by Google : https://pictogrammers.com/library/mdi/icon/check/

// Use it by code and fill its Text property or inherits from it to create your
// buttons with a text, an icon or the both.

// TODO : If you don't want this button in your project remove the unit from your project

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
  _ButtonsAncestor,
  FMX.Objects;

type
  T__SporglooButtonAncestor = class(T__ButtonAncestor)
    rDown: TRectangle;
    rUp: TRectangle;
    txtUp: TText;
    txtDown: TText;
    pFocusedDown: TPath;
    pFocusedUp: TPath;
  private
  public
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}

procedure T__SporglooButtonAncestor.Repaint;
begin
  rDown.Visible := isDown;
  rUp.Visible := not isDown;
  if not text.IsEmpty then
  begin
    txtUp.text := text;
    txtDown.text := text;
  end;
  pFocusedUp.Visible := IsFocused;
  pFocusedDown.Visible := IsFocused;
end;

end.
