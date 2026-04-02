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
  File last update : 2025-05-25T17:43:44.411+02:00
  Signature : 7f47b1af1392c1f8f95f857d0308eb0caf8f2258
  ***************************************************************************
*)

unit cShowMessage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  cDialogBackground, FMX.Layouts, _ButtonsAncestor, cTextButton, FMX.Objects;

type
  TShowMessage = class(TDialogBackground)
    TextButton1: TTextButton;
    VertScrollBox1: TVertScrollBox;
    lButtons: TLayout;
    Text1: TText;
  private
    procedure SetButtonClick(const Value: TNotifyEvent);
    procedure SetButtonText(const Value: string);
    procedure SetText(const Value: String);
    function GetButtonClick: TNotifyEvent;
    function GetButtonText: string;
    function GetText: String;
  public
    property Text: String read GetText write SetText;
    property ButtonText: string read GetButtonText write SetButtonText;
    property ButtonClick: TNotifyEvent read GetButtonClick write SetButtonClick;
  end;

var
  ShowMessage: TShowMessage;

implementation

{$R *.fmx}
{ TDialogBackground1 }

function TShowMessage.GetButtonClick: TNotifyEvent;
begin
  result := TextButton1.OnClick;
end;

function TShowMessage.GetButtonText: string;
begin
  result := TextButton1.Text;
end;

function TShowMessage.GetText: String;
begin
  result := Text1.Text;
end;

procedure TShowMessage.SetButtonClick(const Value: TNotifyEvent);
begin
  TextButton1.OnClick := Value;
end;

procedure TShowMessage.SetButtonText(const Value: string);
begin
  TextButton1.Text := Value;
end;

procedure TShowMessage.SetText(const Value: String);
begin
  Text1.Text := Value;
end;

end.
