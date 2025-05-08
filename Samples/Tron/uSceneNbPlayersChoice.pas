/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Starter Kit
///
/// Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// The "Gamolf FMX Game Starter Kit" is both a "technical" example of a video
/// game developed in Delphi with everything you need inside and a reusable
/// project template you can customize for your own games.
///
/// The files provided are fully functional. Numerous comments are included in
/// the sources to explain how they work and what you need to copy, override
/// or customize to make video games without starting from scratch.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://fmxgamestarterkit.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit
///
/// ***************************************************************************
/// File last update : 2025-05-08T20:34:32.000+02:00
/// Signature : a4268d003b2f1e40026f50e232a984fac866e753
/// ***************************************************************************
/// </summary>

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
