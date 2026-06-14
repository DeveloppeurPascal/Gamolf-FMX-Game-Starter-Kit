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
  File last update : 2026-04-02T19:25:40.674+02:00
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
