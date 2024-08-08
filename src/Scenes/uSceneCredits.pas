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
  _SceneAncestor,
  FMX.Controls.Presentation,
  Gamolf.FMX.HelpBar,
  FMX.Layouts;

type
  TSceneCredits = class(T__SceneAncestor)
    Label1: TLabel;
    Label2: TLabel;
    ScrollBox1: TScrollBox;
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
  uDMAboutBox;

{ TSceneCredits }

procedure TSceneCredits.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TSceneCredits.FinalizeScene;
begin
  inherited;
  // TODO : à compléter
end;

procedure TSceneCredits.InitializeScene;
begin
  inherited;
  // TODO : à compléter
  Label2.Text := TAboutBox.Current.OlfAboutDialog1.Titre + slinebreak +
    TAboutBox.Current.OlfAboutDialog1.GetVersionDate + slinebreak +
    TAboutBox.Current.OlfAboutDialog1.Copyright + slinebreak + slinebreak +
    TAboutBox.Current.OlfAboutDialog1.Description.Text + slinebreak + slinebreak
    + TAboutBox.Current.OlfAboutDialog1.Licence.Text + slinebreak + slinebreak;
end;

procedure TSceneCredits.TranslateTexts(const Language: string);
begin
  inherited;
  // TODO : à compléter
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
      tscene.RegisterScene(TSceneType.Credits, NewScene);
    end;
  end);

end.
