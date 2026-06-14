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
  File last update : 2026-04-02T19:25:40.694+02:00
  Signature : c313d0c32b3db9b27c7fe666864f6134bce71c5f
  ***************************************************************************
*)

unit uSceneCredits;

interface

{$MESSAGE WARN 'If this scene interest you save this file in your project folder and customize the copy. Don''t change the template version if you want to be able to update it.'}
// TODO : If this scene interest you save this file in your project folder and customize the copy. Don''t change the template version if you want to be able to update it.
// TODO : If you don't want it in your project remove the unit from your project

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
  _ScenesAncestor,
  FMX.Controls.Presentation,
  FMX.Layouts;

type
  TSceneCredits = class(T__SceneAncestor)
    Label1: TLabel;
    Label2: TLabel;
    ScrollBox1: TScrollBox;
    btnBack: TButton;
    procedure btnBackClick(Sender: TObject);
  private
  protected
  public
    procedure ShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  uDMAboutBox,
  uUIElements,
  USVGInputPrompts,
  uDMHelpBarManager;

{ TSceneCredits }

procedure TSceneCredits.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TSceneCredits.ShowScene;
begin
  inherited;

  TUIItemsList.Current.AddControl(btnBack, nil, nil, nil, nil, true, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardEscape),
    ord(TSVGInputPromptsIndex.SteamButtonColorXOutline), 'Back');

  Label2.Text := TAboutBox.Current.OlfAboutDialog1.Titre + slinebreak +
    TAboutBox.Current.OlfAboutDialog1.GetVersionDate + slinebreak + '(c) ' +
    TAboutBox.Current.OlfAboutDialog1.Copyright + slinebreak + slinebreak +
    TAboutBox.Current.OlfAboutDialog1.Description.Text + slinebreak + slinebreak
    + TAboutBox.Current.OlfAboutDialog1.Licence.Text + slinebreak + slinebreak;
end;

initialization

tscene.RegisterScene<TSceneCredits>(TSceneType.Credits);

end.
