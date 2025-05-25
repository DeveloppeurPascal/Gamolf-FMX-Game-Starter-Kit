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
  File last update : 2025-05-08T20:36:26.998+02:00
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
