unit _PloomtrisButtonAncestor;

interface

// Button created by Patrick Prémartin for "Ploomtris" game
// This game is available at https://ploomtris.gamolf.fr

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
  T__PloomtrisButtonAncestor = class(T__ButtonAncestor)
    rBackground: TRectangle;
    Text1: TText;
  private
  protected
  public
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}

uses
  USVGPuzzleAssets2,
  uSVGBitmapManager;

procedure T__PloomtrisButtonAncestor.Repaint;
var
  SVGIdx: TSVGPuzzleAssets2Index;
begin
  if isDown then
    SVGIdx := TSVGPuzzleAssets2Index.BtnOn
  else if IsFocused then
    SVGIdx := TSVGPuzzleAssets2Index.BtnFocus
  else
    SVGIdx := TSVGPuzzleAssets2Index.BtnOff;
  rBackground.Fill.Bitmap.Bitmap.assign(getBitmapFromSVG(SVGIdx,
    rBackground.width, rBackground.height,
    rBackground.Fill.Bitmap.Bitmap.BitmapScale));
  if not text.IsEmpty then
    Text1.text := text;
end;

end.
