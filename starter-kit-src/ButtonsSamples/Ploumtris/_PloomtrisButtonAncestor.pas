/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Starter Kit
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
/// The "Gamolf FMX Game Starter Kit" is both a "technical" example of a video
/// game developed in Delphi with everything you need inside and a reusable
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
/// https://fmxgamestarterkit.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit
///
/// ***************************************************************************
/// File last update : 2024-08-10T11:56:32.000+02:00
/// Signature : 957a7d5c9b2f3579df43c46bdef0cf13f35a0972
/// ***************************************************************************
/// </summary>

unit _PloomtrisButtonAncestor;

interface

// Button created by Patrick Prémartin for "Ploomtris" game
// This game is available at https://ploomtris.gamolf.fr
//
// The button's background is a SVG from the "Puzzle Assets 2".
// The images are licensed by Kenney (https://kenney.nl).

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
