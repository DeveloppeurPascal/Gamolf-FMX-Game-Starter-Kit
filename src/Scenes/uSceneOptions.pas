unit uSceneOptions;

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
  _SceneAncestor,
  FMX.Controls.Presentation,
  Gamolf.FMX.HelpBar;

type
  TSceneOptions = class(T__SceneAncestor)
    Label1: TLabel;
    btnBack: TButton;
    procedure btnBackClick(Sender: TObject);
  private
  protected
  public
    procedure InitializeScene; override;
    procedure FinalizeScene; override;
    procedure TranslateTexts(const Language: string); override;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  uScene,
  uConsts,
  uUIElements;

{ TSceneOptions }

procedure TSceneOptions.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TSceneOptions.FinalizeScene;
begin
  inherited;
  // TODO : à compléter
end;

procedure TSceneOptions.InitializeScene;
begin
  inherited;
  TUIItemsList.Current.AddControl(btnBack, nil, nil, nil, nil, true, true);
end;

procedure TSceneOptions.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : à compléter
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TSceneOptions;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Options) then
    begin
      NewScene := TSceneOptions.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Options, NewScene);
    end;
  end);

end.
