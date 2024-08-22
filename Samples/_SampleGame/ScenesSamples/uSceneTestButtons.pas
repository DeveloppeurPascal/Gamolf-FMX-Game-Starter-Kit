﻿/// <summary>
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
/// File last update : 2024-08-22T08:47:19.032+02:00
/// Signature : 2bda23be7e4da9a6caa20977557ce2c067768379
/// ***************************************************************************
/// </summary>

unit uSceneTestButtons;

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
  FMX.Layouts,
  _ButtonsAncestor,
  _TheQuizAncestorButton,
  cTheQuizHelloButton,
  _PloomtrisButtonAncestor,
  cPloomtrisWorldButton,
  _SporglooButtonAncestor,
  cSporglooIUseDelphiButton,
  _EggHunterButtonAncestor,
  cEggHunterAndYouButton,
  uButton;

type
  TSceneTestButtons = class(T__SceneAncestor)
    btnBack: TButton;
    TheQuizHelloButton1: TTheQuizHelloButton;
    Layout1: TLayout;
    Label1: TLabel;
    PloomtrisWorldButton1: TPloomtrisWorldButton;
    SporglooIUseDelphiButton1: TSporglooIUseDelphiButton;
    EggHunterAndYouButton1: TEggHunterAndYouButton;
    TextButton1: TTextButton;
    procedure btnBackClick(Sender: TObject);
  private
  protected
    procedure ButtonsClick(Sender: TObject);
  public
    procedure ShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  uScene,
  uConsts,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts;

procedure TSceneTestButtons.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TSceneTestButtons.ButtonsClick(Sender: TObject);
begin
  Label1.text := 'clicked on ' + Sender.ClassName;
end;

procedure TSceneTestButtons.ShowScene;
begin
  inherited;
  Label1.text := '';

  TheQuizHelloButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(TheQuizHelloButton1, nil, nil,
    PloomtrisWorldButton1, nil, true);

  PloomtrisWorldButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(PloomtrisWorldButton1, TheQuizHelloButton1,
    nil, SporglooIUseDelphiButton1, nil);

  SporglooIUseDelphiButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(SporglooIUseDelphiButton1,
    PloomtrisWorldButton1, nil, EggHunterAndYouButton1, nil);

  EggHunterAndYouButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(EggHunterAndYouButton1,
    SporglooIUseDelphiButton1, nil, TextButton1, nil);

  TextButton1.OnClick := ButtonsClick;
  TUIItemsList.Current.AddControl(TextButton1,
    EggHunterAndYouButton1, nil, btnBack, nil);

  TUIItemsList.Current.AddControl(btnBack, TextButton1, nil, nil,
    nil, false, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardEscape),
    ord(TSVGInputPromptsIndex.SteamButtonColorXOutline), 'Menu');
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowUp),
    ord(TSVGInputPromptsIndex.SteamDpadUpOutline));
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardArrowDown),
    ord(TSVGInputPromptsIndex.SteamDpadDownOutline), 'Move');
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardSpace),
    ord(TSVGInputPromptsIndex.SteamButtonColorAOutline), 'Select');
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneTestButtons;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.TestUIButtons) then
    begin
      NewScene := TSceneTestButtons.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.TestUIButtons, NewScene);
    end;
  end);

end.
