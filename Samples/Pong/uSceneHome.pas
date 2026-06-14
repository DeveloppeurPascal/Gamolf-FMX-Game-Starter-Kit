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
  File last update : 2026-04-02T19:25:40.556+02:00
  Signature : e463dc39ed76579b0e2ad6b5d872fc57e9f789dd
  ***************************************************************************
*)

unit uSceneHome;

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
  _ScenesAncestor,
  FMX.Layouts,
  _ButtonsAncestor,
  _EggHunterButtonAncestor;

type
  TSceneHome = class(T__SceneAncestor)
    Layout1: TLayout;
    btnGame: T__EggHunterButtonAncestor;
    btnQuit: T__EggHunterButtonAncestor;
    btnCredits: T__EggHunterButtonAncestor;
    procedure btnQuitClick(Sender: TObject);
    procedure btnGameClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
  private
  protected
  public
    procedure TranslateTexts(const Language: string); override;
    procedure ShowScene; override;
    procedure HideScene; override;
    procedure BeforeFirstShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  Gamolf.FMX.HelpBar,
  uGameData;

procedure TSceneHome.BeforeFirstShowScene;
begin
  inherited;
  THelpBarManager.Current.Height := 100;
  THelpBarManager.Current.TextSettings.Font.Size :=
    THelpBarManager.Current.TextSettings.Font.Size * 2;
  THelpBarManager.Current.TextSettings.FontColor := talphacolors.Whitesmoke;
  THelpBarManager.Current.HorzAlign := TDGEFMXHelpBarHorzAlign.Center;
end;

procedure TSceneHome.btnCreditsClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Credits;
end;

procedure TSceneHome.btnGameClick(Sender: TObject);
begin
  TGameData.DefaultGameData.StartANewGame;
  TScene.Current := TSceneType.Game;
end;

procedure TSceneHome.btnQuitClick(Sender: TObject);
begin
  TScene.Current := TSceneType.exit;
end;

procedure TSceneHome.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TSceneHome.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnGame, nil, nil, btnCredits, nil, true);
  TUIItemsList.Current.AddControl(btnCredits, btnGame, nil, btnQuit, nil);
  TUIItemsList.Current.AddControl(btnQuit, btnCredits, nil, nil, nil,
    false, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowUp +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadUpOutline +
    TSVGInputPrompts.Tag);
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowDown +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadDownOutline +
    TSVGInputPrompts.Tag, 'Move');
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardSpace +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorAOutline +
    TSVGInputPrompts.Tag, 'Select');
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardEscape +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorXOutline +
    TSVGInputPrompts.Tag, 'Quit');
end;

procedure TSceneHome.TranslateTexts(const Language: string);
begin
  inherited;
  btnGame.Text := 'Play';
  btnCredits.Text := 'Credits';
  btnQuit.Text := 'Quit';
end;

initialization

TScene.RegisterScene<TSceneHome>(TSceneType.Home);

end.
