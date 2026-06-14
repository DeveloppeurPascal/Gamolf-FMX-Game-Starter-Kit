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
  File last update : 2026-04-02T19:25:40.755+02:00
  Signature : 63c0486c870482a5d6634d1ca076db93eb0db434
  ***************************************************************************
*)

unit uDMHelpBarManager;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.SysUtils,
  System.Classes,
  FMX.Types,
  Gamolf.FMX.HelpBar;

type
  THelpBarManager = class(TDataModule)
  private
  public
    class function Current: TDGEFMXHelpBar;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  FMX.forms,
  fMain;

var
  HelpBarManager: THelpBarManager;

  { THelpBarManager }

class function THelpBarManager.Current: TDGEFMXHelpBar;
begin
  // if not assigned(HelpBarManager) then
  // HelpBarManager := THelpBarManager.create(nil);
  // result := HelpBarManager.DGEFMXHelpBar1;

  // TODO -oDeveloppeurPascal -cCheckIssue : corriger problème de parent sur le composant lorsqu'il n'est pas sur une fiche
  // See https://github.com/DeveloppeurPascal/Delphi-Game-Engine/issues/208
  result := (application.mainform as tfrmmain).DGEFMXHelpBar1;
end;

initialization

HelpBarManager := nil;

finalization

HelpBarManager.free;

end.
