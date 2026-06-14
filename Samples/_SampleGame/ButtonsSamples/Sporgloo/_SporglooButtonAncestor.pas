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
  https://codeberg.org/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit

  ***************************************************************************
  File last update : 2026-04-02T19:25:40.686+02:00
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
