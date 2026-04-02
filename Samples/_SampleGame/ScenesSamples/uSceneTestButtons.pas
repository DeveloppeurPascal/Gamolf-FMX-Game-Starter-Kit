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
  File last update : 2025-05-25T17:43:44.531+02:00
  Signature : b162c104285ccb798bbc6d1fe09190f0267b6997
  ***************************************************************************
*)

unit uSceneTestButtons;

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
  FMX.Layouts,
  _ButtonsAncestor,
  _TheQuizAncestorButton,
  cTheQuizHelloButton,
  _PloomtrisButtonAncestor,
  cPloomtrisWorldButton,
  _SporglooButtonAncestor,
  cSporglooIUseDelphiButton,
  _EggHunterButtonAncestor,
  cEggHunterAndYouButton,
  uButton;

type
  TSceneTestButtons = class(T__SceneAncestor)
    btnBack: TButton;
    TheQuizHelloButton1: TTheQuizHelloButton;
    Layout1: TLayout;
    Label1: TLabel;
    PloomtrisWorldButton1: TPloomtrisWorldButton;
    SporglooIUseDelphiButton1: TSporglooIUseDelphiButton;
    EggHunterAndYouButton1: TEggHunterAndYouButton;
    TextButton1: TTextButton;
    procedure btnBackClick(Sender: TObject);
  private
  protected
    procedure ButtonsClick(Sender: TObject);
  public
    procedure ShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts;

procedure TSceneTestButtons.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TSceneTestButtons.ButtonsClick(Sender: TObject);
begin
  Label1.text := 'clicked on ' + Sender.ClassName;
end;

procedure TSceneTestButtons.ShowScene;
begin
  inherited;
  Label1.text := '';

  TheQuizHelloButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(TheQuizHelloButton1, nil, nil,
    PloomtrisWorldButton1, nil, true);

  PloomtrisWorldButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(PloomtrisWorldButton1, TheQuizHelloButton1,
    nil, SporglooIUseDelphiButton1, nil);

  SporglooIUseDelphiButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(SporglooIUseDelphiButton1,
    PloomtrisWorldButton1, nil, EggHunterAndYouButton1, nil);

  EggHunterAndYouButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(EggHunterAndYouButton1,
    SporglooIUseDelphiButton1, nil, TextButton1, nil);

  TextButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(TextButton1, EggHunterAndYouButton1, nil,
    btnBack, nil);

  TUIItemsList.Current.AddControl(btnBack, TextButton1, nil, nil, nil,
    false, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardEscape),
    ord(TSVGInputPromptsIndex.SteamButtonColorXOutline), 'Menu');
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowUp),
    ord(TSVGInputPromptsIndex.SteamDpadUpOutline));
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowDown),
    ord(TSVGInputPromptsIndex.SteamDpadDownOutline), 'Move');
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardSpace),
    ord(TSVGInputPromptsIndex.SteamButtonColorAOutline), 'Select');
end;

initialization

tscene.RegisterScene<TSceneTestButtons>(TSceneType.TestUIButtons);

end.
