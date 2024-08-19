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
  System.Messaging,
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

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneCredits;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Credits) then
    begin
      NewScene := TSceneCredits.Create(application.mainform);
      NewScene.Parent := application.mainform;
      TScene.RegisterScene(TSceneType.Credits, NewScene);
    end;
  end);

end.
