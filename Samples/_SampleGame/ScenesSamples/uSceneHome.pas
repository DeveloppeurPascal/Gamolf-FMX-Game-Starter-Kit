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
  File last update : 2026-04-02T19:25:40.697+02:00
  Signature : 319dc7db82046c00f658c359e9872cd7eca05387
  ***************************************************************************
*)

unit uSceneHome;

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
  TSceneHome = class(T__SceneAncestor)
    Label1: TLabel;
    FlowLayout1: TFlowLayout;
    btnNewGame: TButton;
    btnContinue: TButton;
    btnHallOfFame: TButton;
    btnOptions: TButton;
    btnCredits: TButton;
    btnQuit: TButton;
    procedure btnNewGameClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure btnHallOfFameClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
  private
  protected
  public
    procedure ShowScene; override;
    procedure HideScene; override;
    procedure BeforeFirstShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uGameData,
  uConsts,
  uSoundEffects,
  uUIElements,
  USVGInputPrompts,
  uDMHelpBarManager;

{ TSceneHome }

procedure TSceneHome.BeforeFirstShowScene;
begin
  THelpBarManager.Current.height := 100;
  THelpBarManager.Current.TextSettings.FontColor := talphacolors.Yellow;
  THelpBarManager.Current.TextSettings.font.Size :=
    THelpBarManager.Current.TextSettings.font.Size * 2;
  THelpBarManager.Current.TextSettings.font.Style := [TFontStyle.fsBold];
end;

procedure TSceneHome.btnContinueClick(Sender: TObject);
begin
  TGameData.DefaultGameData.ContinueGame;
  TScene.Current := TSceneType.game;
end;

procedure TSceneHome.btnCreditsClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Credits;
end;

procedure TSceneHome.btnHallOfFameClick(Sender: TObject);
begin
  TScene.Current := TSceneType.HallOfFame;
end;

procedure TSceneHome.btnNewGameClick(Sender: TObject);
begin
  TGameData.DefaultGameData.StartANewGame;
  TScene.Current := TSceneType.game;
end;

procedure TSceneHome.btnOptionsClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Options;
end;

procedure TSceneHome.btnQuitClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Exit;
end;

procedure TSceneHome.HideScene;
begin
  inherited;
  TSoundEffects.Play(TSoundEffectType.demo);
end;

procedure TSceneHome.ShowScene;
begin
  inherited;

  btnContinue.Visible := TGameData.DefaultGameData.IsPaused;
{$IF Defined(IOS) or Defined(ANDROID)}
  btnQuit.Visible := false;
{$ENDIF}
  if btnContinue.Visible then
  begin
    TUIItemsList.Current.AddControl(btnNewGame, nil, btnContinue, btnContinue,
      nil, true);
    TUIItemsList.Current.AddControl(btnContinue, btnNewGame, btnHallOfFame,
      btnHallOfFame, btnNewGame);
    TUIItemsList.Current.AddControl(btnHallOfFame, btnContinue, btnOptions,
      btnOptions, btnContinue);
  end
  else
  begin
    TUIItemsList.Current.AddControl(btnNewGame, nil, btnHallOfFame,
      btnHallOfFame, nil, true);
    TUIItemsList.Current.AddControl(btnHallOfFame, btnNewGame, btnOptions,
      btnOptions, btnNewGame);
  end;
  TUIItemsList.Current.AddControl(btnOptions, btnHallOfFame, btnCredits,
    btnCredits, btnHallOfFame);
  if btnQuit.Visible then
  begin
    TUIItemsList.Current.AddControl(btnCredits, btnOptions, btnQuit, btnQuit,
      btnOptions);
    TUIItemsList.Current.AddControl(btnQuit, btnCredits, nil, nil, btnCredits,
      false, true);
  end
  else
    TUIItemsList.Current.AddControl(btnCredits, btnOptions, nil, nil,
      btnOptions);

  THelpBarManager.Current.OpenHelpBar;
  if btnQuit.Visible then
    THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardEscape),
      ord(TSVGInputPromptsIndex.SteamButtonColorXOutline), 'Quit');
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowLeft),
    ord(TSVGInputPromptsIndex.SteamDpadLeftOutline));
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowUp),
    ord(TSVGInputPromptsIndex.SteamDpadUpOutline));
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowRight),
    ord(TSVGInputPromptsIndex.SteamDpadRightOutline));
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowDown),
    ord(TSVGInputPromptsIndex.SteamDpadDownOutline), 'Move');
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardSpace),
    ord(TSVGInputPromptsIndex.SteamButtonColorAOutline), 'Select');

  TSoundEffects.Play(TSoundEffectType.demo);
end;

initialization

TScene.RegisterScene<TSceneHome>(TSceneType.Home);

end.
