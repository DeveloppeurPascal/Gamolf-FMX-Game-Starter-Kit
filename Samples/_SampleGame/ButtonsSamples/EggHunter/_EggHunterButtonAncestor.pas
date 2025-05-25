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
  File last update : 2025-02-09T11:12:48.120+01:00
  Signature : 071d4a0a8cc424aab409b4cd1601c97ea65a8fdf
  ***************************************************************************
*)

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
