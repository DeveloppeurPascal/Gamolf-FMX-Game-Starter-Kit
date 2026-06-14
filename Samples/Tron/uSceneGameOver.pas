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
  File last update : 2026-04-02T19:25:40.631+02:00
  Signature : 4543d1f0fe55865cceb14025c2d8444a2651caa5
  ***************************************************************************
*)

unit uSceneGameOver;

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
  cDialogBackground,
  cShowMessage;

type
  TGameOverScene = class(T__SceneAncestor)
    ShowMessage1: TShowMessage;
    procedure ShowMessage1TextButton1Click(Sender: TObject);
  private
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

{ TGameOverScene }

procedure TGameOverScene.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TGameOverScene.ShowMessage1TextButton1Click(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TGameOverScene.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(ShowMessage1.TextButton1, nil, nil, nil, nil,
    true, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardSpace +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorAOutline +
    TSVGInputPrompts.Tag, 'Select');
end;

procedure TGameOverScene.TranslateTexts(const Language: string);
var
  PlayerID: TCellType;
  Winner: integer;
begin
  inherited;

  Winner := 0;
  for PlayerID := TCellType.Player1 to TCellType.Player4 do
    if TTronGameData.Current.Players[PlayerID].IsAlive then
      Winner := ord(PlayerID) - ord(TCellType.Player1) + 1;

  if Winner < 1 then
    ShowMessage1.Text := 'Game over'
  else
    ShowMessage1.Text := 'The winner is player ' + Winner.ToString;

  ShowMessage1.ButtonText := 'Home';
end;

initialization

tscene.RegisterScene<TGameOverScene>(TSceneType.GameOver);

end.
