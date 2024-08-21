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
/// File last update : 2024-08-21T10:52:42.000+02:00
/// Signature : 58e57a0d965e8590b6dddd40e82acd51872fd0c1
/// ***************************************************************************
/// </summary>

unit cTextButton;

interface

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
  TTextButton = class(T__ButtonAncestor)
    imgUp: TImage;
    imgDown: TImage;
    imgUpFocused: TImage;
    txtUpFocused: TText;
    txtUp: TText;
    txtDown: TText;
    procedure imgUpFocusedResized(Sender: TObject);
    procedure imgUpResized(Sender: TObject);
    procedure imgDownResized(Sender: TObject);
  private
  public
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}

uses
  uSVGBitmapManager_UIPack,
  USVGUIPack;
{ TTextButton }

procedure TTextButton.imgDownResized(Sender: TObject);
begin
  if (imgDown.Width < 1) or (imgDown.Height < 1) then
    exit;

  imgDown.Bitmap.Assign(getBitmapFromSVG(TSVGUIPackIndex.ButtonRectangleLine,
    imgDown.Width, imgDown.Height, imgDown.Bitmap.BitmapScale));
end;

procedure TTextButton.imgUpFocusedResized(Sender: TObject);
begin
  if (imgUpFocused.Width < 1) or (imgUpFocused.Height < 1) then
    exit;

  imgUpFocused.Bitmap.Assign
    (getBitmapFromSVG(TSVGUIPackIndex.ButtonRectangleDepthBorder,
    imgUpFocused.Width, imgUpFocused.Height, imgUpFocused.Bitmap.BitmapScale));
end;

procedure TTextButton.imgUpResized(Sender: TObject);
begin
  if (imgUp.Width < 1) or (imgUp.Height < 1) then
    exit;

  imgUp.Bitmap.Assign(getBitmapFromSVG(TSVGUIPackIndex.ButtonRectangleDepthLine,
    imgUp.Width, imgUp.Height, imgUp.Bitmap.BitmapScale));
end;

procedure TTextButton.Repaint;
begin
  imgUpFocused.Visible := IsFocused and isup;
  imgUp.Visible := isup and (not IsFocused);
  imgDown.Visible := IsDown;
  if not text.IsEmpty then
  begin
    txtUpFocused.text := text;
    txtUp.text := text;
    txtDown.text := text;
  end;
end;

end.
