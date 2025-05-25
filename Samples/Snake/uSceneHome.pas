(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit

  Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

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
  File last update : 2025-05-08T20:36:27.022+02:00
  Signature : 74ab9b7de211a54b987a281041470fcd5f313927
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
  FMX.Objects,
  FMX.Effects,
  _ButtonsAncestor,
  uButton,
  FMX.Layouts;

type
  THomeScene = class(T__SceneAncestor)
    txtTitle: TText;
    GlowEffect1: TGlowEffect;
    Layout1: TLayout;
    btnPlay: TTextButton;
    btnQuit: TTextButton;
    btnCredits: TTextButton;
    procedure btnPlayClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
  private
  public
    procedure ShowScene; override;
    procedure HideScene; override;
    procedure BeforeFirstShowScene; override;
    procedure TranslateTexts(const Language: string); override;

  end;

implementation

{$R *.fmx}

uses
  uConsts,
  uScene,
  uUIElements,
  USVGInputPrompts,
  uDMHelpBarManager,
  Gamolf.FMX.HelpBar,
  uGameData;

procedure THomeScene.BeforeFirstShowScene;
begin
  inherited;
  THelpBarManager.Current.Height := 100;
  THelpBarManager.Current.TextSettings.Font.Size :=
    THelpBarManager.Current.TextSettings.Font.Size * 2;
  THelpBarManager.Current.TextSettings.FontColor := talphacolors.Whitesmoke;
  THelpBarManager.Current.HorzAlign := TDGEFMXHelpBarHorzAlign.Center;
end;

procedure THomeScene.btnCreditsClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Credits;
end;

procedure THomeScene.btnPlayClick(Sender: TObject);
begin
  tgamedata.DefaultGameData.StartANewGame;
  tscene.Current := TSceneType.Game;
end;

procedure THomeScene.btnQuitClick(Sender: TObject);
begin
  tscene.Current := TSceneType.exit;
end;

procedure THomeScene.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure THomeScene.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnPlay, nil, nil, btnCredits, nil, true);
  TUIItemsList.Current.AddControl(btnCredits, btnPlay, nil, btnQuit, nil);
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

procedure THomeScene.TranslateTexts(const Language: string);
begin
  inherited;
  txtTitle.Text := CAboutGameTitle;
  btnPlay.Text := 'Play';
  btnCredits.Text := 'Credits';
  btnQuit.Text := 'Quit';
end;

initialization

tscene.RegisterScene<THomeScene>(TSceneType.Home);

end.
