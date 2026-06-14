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
  File last update : 2026-04-02T19:25:40.539+02:00
  Signature : 01ae5d098b1bc1917aa53a5c0740de775e4b5c1c
  ***************************************************************************
*)

unit uSceneCredits;

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
  _ButtonsAncestor,
  _EggHunterButtonAncestor,
  FMX.Objects,
  FMX.Layouts;

type
  TSceneCredits = class(T__SceneAncestor)
    rBackground: TRectangle;
    VertScrollBox1: TVertScrollBox;
    Text1: TText;
    btnQuit: T__EggHunterButtonAncestor;
    Layout1: TLayout;
    procedure btnQuitClick(Sender: TObject);
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
  uTxtAboutDescription,
  uTxtAboutLicense,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts;

procedure TSceneCredits.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TSceneCredits.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnQuit, nil, nil, nil, nil, true, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardSpace +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorAOutline +
    TSVGInputPrompts.Tag, 'Select');

  rBackground.Fill.Color := THelpBarManager.Current.BackgroundFill.Color;
end;

procedure TSceneCredits.TranslateTexts(const Language: string);
begin
  inherited;
  Text1.Text := GetTxtAboutDescription(Language) + slinebreak + slinebreak +
    GetTxtAboutLicense(Language) + slinebreak + slinebreak;
  btnQuit.Text := 'Home';
end;

procedure TSceneCredits.BeforeFirstShowScene;
begin
  inherited;
  Text1.TextSettings.Font.Size := Text1.TextSettings.Font.Size * 1.5;
end;

procedure TSceneCredits.btnQuitClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Home;
end;

initialization

TScene.RegisterScene<TSceneCredits>(TSceneType.Credits);

end.
