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
/// File last update : 2024-08-10T11:04:38.000+02:00
/// Signature : 796957ced9a1d6f565cb097ef9d2b1a5ef52ed05
/// ***************************************************************************
/// </summary>

unit _TheQuizAncestorButton;

interface

// Button created by Patrick Prémartin for "The Quiz" game
// This game is available at https://github.com/DeveloppeurPascal/DevDaysOfSummer2024-MakeGamesInDelphi

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
  FMX.Objects,
  FMX.Effects,
  FMX.Layouts;

type
  T__TheQuizAncestorButton = class(T__ButtonAncestor)
    lDown: TLayout;
    Rectangle1: TRectangle;
    ShadowEffect2: TShadowEffect;
    txtDown: TText;
    lUp: TLayout;
    Rectangle2: TRectangle;
    ShadowEffect1: TShadowEffect;
    txtUp: TText;
    rFocused: TRectangle;
  private
  protected
  public
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}

procedure T__TheQuizAncestorButton.Repaint;
begin
  lUp.Visible := not IsDown;
  lDown.Visible := IsDown;
  rFocused.Visible := IsFocused;
  if not text.IsEmpty then
  begin
    txtUp.text := text;
    txtDown.text := text;
  end;
end;

end.
