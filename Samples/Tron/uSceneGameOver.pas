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
  File last update : 2025-05-08T20:36:27.050+02:00
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
