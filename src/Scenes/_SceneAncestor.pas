unit _SceneAncestor;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Messaging,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls;

type
  T__SceneAncestor = class(TFrame)
  private
  protected
    procedure DoTranslateTexts(const Sender: TObject; const Msg: TMessage);
  public
    procedure InitializeScene; virtual;
    procedure FinalizeScene; virtual;
    procedure TranslateTexts(const Language: string); virtual;
  end;

implementation

{$R *.fmx}

uses
  uTranslate,
  uConfig;

{ TSceneAncestor }

procedure T__SceneAncestor.DoTranslateTexts(const Sender: TObject;
  const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
    TranslateTexts((Msg as TTranslateTextsMessage).Language);
end;

procedure T__SceneAncestor.FinalizeScene;
begin
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    DoTranslateTexts, true);
end;

procedure T__SceneAncestor.InitializeScene;
begin
  TranslateTexts(tconfig.Current.Language);
  TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
    DoTranslateTexts);
end;

procedure T__SceneAncestor.TranslateTexts(const Language: string);
begin
  // nothing to do at this level,
  // override this method on each scene where you need to translate something
end;

end.
