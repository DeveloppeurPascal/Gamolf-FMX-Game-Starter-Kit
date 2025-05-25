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
  Signature : d7ff48c82021dacff8fdd5c5dd9a282c8ce4b80a
  ***************************************************************************
*)

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
