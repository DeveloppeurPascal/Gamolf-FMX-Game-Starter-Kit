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
/// File last update : 2024-08-10T10:58:56.000+02:00
/// Signature : b3fabeda72b38216bda6ae8721ddda29e0209f0a
/// ***************************************************************************
/// </summary>

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
  System.Messaging,
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

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneHome;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Home) then
    begin
      NewScene := TSceneHome.Create(application.mainform);
      NewScene.Parent := application.mainform;
      TScene.RegisterScene(TSceneType.Home, NewScene);
    end;
  end);

end.
