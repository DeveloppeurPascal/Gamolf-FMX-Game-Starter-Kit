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
  File last update : 2026-04-02T19:25:40.576+02:00
  Signature : 3c771de91a53f4fcfc8b83a2ab2317257384ca99
  ***************************************************************************
*)

unit uButton;

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
  FMX.Objects,
  FMX.Effects;

type
  TTextButton = class(T__ButtonAncestor)
    rFocus: TRectangle;
    rUp: TRectangle;
    TextUp: TText;
    rDown: TRectangle;
    TextDown: TText;
    ShadowEffect1: TShadowEffect;
  private
  public
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}
{ TTextButton }

procedure TTextButton.Repaint;
begin
  inherited;
  rFocus.Visible := IsFocused;
  rDown.Visible := IsDown;
  rUp.Visible := not rDown.Visible;
  TextUp.Text := Text;
  TextDown.Text := Text;
end;

end.
