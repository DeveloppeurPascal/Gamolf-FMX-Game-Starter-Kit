/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Starter Kit
///
/// Copyright 2024 Patrick Prémartin under AGPL 3.0 license.
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
/// File last update : 2024-08-21T12:10:10.000+02:00
/// Signature : 30fe608ee5a12518f32cf484d5c0d2ca87db7600
/// ***************************************************************************
/// </summary>

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
  FMX.Effects,
  FMX.Objects,
  FMX.Layouts,
  _ButtonsAncestor,
  cTextButton,
  cDialogBackground;

type
  THomeScene = class(T__SceneAncestor)
    Layout1: TLayout;
    Text1: TText;
    GlowEffect1: TGlowEffect;
    DialogBackground1: TDialogBackground;
    btnPlay: TTextButton;
    btnQuit: TTextButton;
    btnCredits: TTextButton;
    procedure btnQuitClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
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
  System.Messaging,
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  uGameData,
  Gamolf.FMX.HelpBar;

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
  tscene.Current := TSceneType.credits;
end;

procedure THomeScene.btnPlayClick(Sender: TObject);
begin
  TGameData.DefaultGameData.StartANewGame;
  tscene.Current := TSceneType.NbPlayersChoice;
end;

procedure THomeScene.btnQuitClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Exit;
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
  btnPlay.Text := 'Play';
  btnCredits.Text := 'Credits';
  btnQuit.Text := 'Quit';
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: THomeScene;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Home) then
    begin
      NewScene := THomeScene.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Home, NewScene);
    end;
  end);

end.
