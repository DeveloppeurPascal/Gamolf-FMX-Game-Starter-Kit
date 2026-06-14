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
  File last update : 2026-04-02T19:25:40.639+02:00
  Signature : f9278bdc42da204adbd89e61361e326377f93aa8
  ***************************************************************************
*)

unit uSceneNbPlayersChoice;

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
  cTextButton;

type
  TNbPlayersChoiceScene = class(T__SceneAncestor)
    GridPanelLayout1: TGridPanelLayout;
    btnOne: TTextButton;
    btnTwo: TTextButton;
    btnThree: TTextButton;
    btnFour: TTextButton;
    btnBack: TTextButton;
    procedure btnBackClick(Sender: TObject);
    procedure btnOneClick(Sender: TObject);
    procedure btnFourClick(Sender: TObject);
    procedure btnThreeClick(Sender: TObject);
    procedure btnTwoClick(Sender: TObject);
  private
    procedure ActivatePlayer1;
    procedure ActivatePlayer2;
    procedure ActivatePlayer3;
    procedure ActivatePlayer4;
  public
    procedure ShowScene; override;
    procedure HideScene; override;
    procedure TranslateTexts(const Language: string); override;
  end;

implementation

{$R *.fmx}

uses
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  uTronGameData;

{ TNbPlayersChoiceScene }

procedure TNbPlayersChoiceScene.ActivatePlayer2;
begin
  with TTronGameData.Current.Players[TCellType.Player2] do
  begin
    Enabled := true;
    IsAlive := true;
    Color := talphacolors.Greenyellow;
    x := CColCount - 1;
    y := CRowCount - 1;
    vx := -1;
    vy := 0;
    TTronGameData.Current.grid[x, y] := TCellType.Player2;
  end;
end;

procedure TNbPlayersChoiceScene.ActivatePlayer3;
begin
  with TTronGameData.Current.Players[TCellType.Player3] do
  begin
    Enabled := true;
    IsAlive := true;
    Color := talphacolors.Deepskyblue;
    x := CColCount - 1;
    y := 0;
    vx := 0;
    vy := 1;
    TTronGameData.Current.grid[x, y] := TCellType.Player3;
  end;
end;

procedure TNbPlayersChoiceScene.ActivatePlayer4;
begin
  with TTronGameData.Current.Players[TCellType.Player4] do
  begin
    Enabled := true;
    IsAlive := true;
    Color := talphacolors.Orange;
    x := 0;
    y := CRowCount - 1;
    vx := 0;
    vy := -1;
    TTronGameData.Current.grid[x, y] := TCellType.Player4;
  end;
end;

procedure TNbPlayersChoiceScene.btnBackClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Home;
end;

procedure TNbPlayersChoiceScene.btnFourClick(Sender: TObject);
begin
  ActivatePlayer1;
  ActivatePlayer2;
  ActivatePlayer3;
  ActivatePlayer4;
  TScene.Current := TSceneType.ControlsChoice;
end;

procedure TNbPlayersChoiceScene.btnOneClick(Sender: TObject);
begin
  ActivatePlayer1;
  TScene.Current := TSceneType.ControlsChoice;
end;

procedure TNbPlayersChoiceScene.btnThreeClick(Sender: TObject);
begin
  ActivatePlayer1;
  ActivatePlayer2;
  ActivatePlayer3;
  TScene.Current := TSceneType.ControlsChoice;
end;

procedure TNbPlayersChoiceScene.btnTwoClick(Sender: TObject);
begin
  ActivatePlayer1;
  ActivatePlayer2;
  TScene.Current := TSceneType.ControlsChoice;
end;

procedure TNbPlayersChoiceScene.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TNbPlayersChoiceScene.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnOne, nil, btnTwo, btnThree, nil, true);
  TUIItemsList.Current.AddControl(btnTwo, nil, nil, btnFour, btnOne);
  TUIItemsList.Current.AddControl(btnThree, btnOne, btnFour, btnBack, nil);
  TUIItemsList.Current.AddControl(btnFour, btnTwo, nil, btnBack, btnThree);
  TUIItemsList.Current.AddControl(btnBack, btnThree, nil, nil, nil,
    false, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowUp +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadUpOutline +
    TSVGInputPrompts.Tag);
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowRight +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadRightOutline +
    TSVGInputPrompts.Tag);
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowDown +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadDownOutline +
    TSVGInputPrompts.Tag);
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowLeft +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadLeftOutline +
    TSVGInputPrompts.Tag, 'Move');
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardSpace +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorAOutline +
    TSVGInputPrompts.Tag, 'Select');
end;

procedure TNbPlayersChoiceScene.TranslateTexts(const Language: string);
begin
  inherited;
  btnOne.Text := '1 player';
  btnTwo.Text := '2 players';
  btnThree.Text := '3 players';
  btnFour.Text := '4 players';
  btnBack.Text := 'Home';
end;

procedure TNbPlayersChoiceScene.ActivatePlayer1;
begin
  with TTronGameData.Current.Players[TCellType.Player1] do
  begin
    Enabled := true;
    IsAlive := true;
    Color := talphacolors.Red;
    x := 0;
    y := 0;
    vx := 1;
    vy := 0;
    TTronGameData.Current.grid[x, y] := TCellType.Player1;
  end;
end;

initialization

TScene.RegisterScene<TNbPlayersChoiceScene>(TSceneType.NbPlayersChoice);

end.
