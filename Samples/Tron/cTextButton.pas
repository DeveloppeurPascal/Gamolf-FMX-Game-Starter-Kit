(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit
  Copyright (c) 2024-2026 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
  File last update : 2025-07-13T16:14:30.550+02:00
  Signature : 7323ed9074b50f0f32f09000f89ed3a6f57b8d96
  ***************************************************************************
*)

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
  USVGUIPack;

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
