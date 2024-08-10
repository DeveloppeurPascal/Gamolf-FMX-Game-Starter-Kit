unit _EggHunterButtonAncestor;

interface

// Button created by Patrick Prémartin for "Egg Hunter" game
// This game is available at https://egghunter.gamolf.fr
//
// The button's background are bitmaps from the "UI Adventure Pack".
// The images are licensed by Kenney (https://kenney.nl).
//
// The hand pointing image come from Pictogrammers.com website
// It's licensed by Austin Andrews : https://pictogrammers.com/library/mdi/icon/hand-pointing-right/

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
  T__EggHunterButtonAncestor = class(T__ButtonAncestor)
    Background_Off: TRectangle;
    Text_Off: TText;
    Background_On: TRectangle;
    Text_On: TText;
    HandOff: TPath;
    HandOn: TPath;
  private
  public
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}

procedure T__EggHunterButtonAncestor.Repaint;
begin
  Background_Off.Visible := IsUp;
  Background_On.Visible := IsDown;
  if not Text.isEmpty then
  begin
    Text_On.Text := Text;
    Text_Off.Text := Text;
  end;
  HandOn.Visible := IsFocused;
  HandOff.Visible := IsFocused;
end;

end.
