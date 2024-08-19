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
  FMX.Layouts,
  _ButtonsAncestor,
  _EggHunterButtonAncestor;

type
  TSceneHome = class(T__SceneAncestor)
    Layout1: TLayout;
    btnGame: T__EggHunterButtonAncestor;
    btnQuit: T__EggHunterButtonAncestor;
    btnCredits: T__EggHunterButtonAncestor;
    procedure btnQuitClick(Sender: TObject);
    procedure btnGameClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
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
  System.Messaging,
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  Gamolf.FMX.HelpBar,
  uGameData;

procedure TSceneHome.BeforeFirstShowScene;
begin
  inherited;
  THelpBarManager.Current.Height := 100;
  THelpBarManager.Current.TextSettings.Font.Size :=
    THelpBarManager.Current.TextSettings.Font.Size * 2;
  THelpBarManager.Current.TextSettings.FontColor := talphacolors.Whitesmoke;
  THelpBarManager.Current.HorzAlign := TDGEFMXHelpBarHorzAlign.Center;
end;

procedure TSceneHome.btnCreditsClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Credits;
end;

procedure TSceneHome.btnGameClick(Sender: TObject);
begin
  TGameData.DefaultGameData.StartANewGame;
  TScene.Current := TSceneType.Game;
end;

procedure TSceneHome.btnQuitClick(Sender: TObject);
begin
  TScene.Current := TSceneType.exit;
end;

procedure TSceneHome.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TSceneHome.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnGame, nil, nil, btnCredits, nil, true);
  TUIItemsList.Current.AddControl(btnCredits, btnGame, nil, btnQuit, nil);
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

procedure TSceneHome.TranslateTexts(const Language: string);
begin
  inherited;
  btnGame.Text := 'Play';
  btnCredits.Text := 'Credits';
  btnQuit.Text := 'Quit';
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
