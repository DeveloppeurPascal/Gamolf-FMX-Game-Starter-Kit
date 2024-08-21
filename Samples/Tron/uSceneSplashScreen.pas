unit uSceneSplashScreen;

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
  FMX.Effects;

type
  TSplashScreenScene = class(T__SceneAncestor)
    Text1: TText;
    GlowEffect1: TGlowEffect;
  private
  public
    procedure ShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts;

{ TSplashScreenScene }

procedure TSplashScreenScene.ShowScene;
begin
  inherited;
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(3000);
      tthread.Queue(nil,
        procedure
        begin
          tscene.Current := TSceneType.Home;
        end);
    end).Start;
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSplashScreenScene;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.SplashScreen) then
    begin
      NewScene := TSplashScreenScene.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.SplashScreen, NewScene);
    end;
  end);

end.
