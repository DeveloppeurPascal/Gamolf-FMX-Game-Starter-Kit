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
  _ButtonsAncestor,
  _EggHunterButtonAncestor,
  FMX.Layouts,
  FMX.Objects;

type
  TSceneGameOver = class(T__SceneAncestor)
    rBackground: TRectangle;
    Layout1: TLayout;
    btnQuit: T__EggHunterButtonAncestor;
    Text1: TText;
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
  System.Messaging,
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  uGameData;

procedure TSceneGameOver.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TSceneGameOver.ShowScene;
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

procedure TSceneGameOver.TranslateTexts(const Language: string);
begin
  inherited;
  Text1.Text := 'GAME OVER' + slinebreak + slinebreak + 'Your score is ' +
    TGameData.DefaultGameData.Score.tostring + slinebreak + slinebreak;
  btnQuit.Text := 'Home';
end;

procedure TSceneGameOver.BeforeFirstShowScene;
begin
  inherited;
  Text1.TextSettings.Font.Size := Text1.TextSettings.Font.Size * 1.5;
end;

procedure TSceneGameOver.btnQuitClick(Sender: TObject);
begin
  TScene.Current := TSceneType.Home;
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneGameOver;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.GameOver) then
    begin
      NewScene := TSceneGameOver.Create(application.mainform);
      NewScene.Parent := application.mainform;
      TScene.RegisterScene(TSceneType.GameOver, NewScene);
    end;
  end);

end.
