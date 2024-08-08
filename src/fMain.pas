unit fMain;

interface

uses
  System.SysUtils,
  System.Messaging,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Menus,
  uSceneBackground,
  Gamolf.RTL.GamepadDetected;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    mnuMacOSAppname: TMenuItem;
    mnuAbout: TMenuItem;
    DGEGamepadDetected1: TDGEGamepadDetected;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
    procedure mnuAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    BackgroundScene: TSceneBackground;
  protected
    procedure TranslateTexts(const Sender: TObject; const Msg: TMessage);
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  uDMAboutBox,
  uConsts,
  uTranslate,
  uScene,
  uBackgroundMusic,
  uConfig,
  uUIElements,
  Gamolf.RTL.UIElements;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  fullscreen := COpenGameInFullScreenMode;
{$IF Defined(MACOS) and not Defined(IOS)}
{$ELSE}
  freeandnil(MainMenu);
{$ENDIF}
  BackgroundScene := TSceneBackground.Create(self);
  BackgroundScene.parent := self;
  BackgroundScene.InitializeScene;

  TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
    TranslateTexts);

  TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
    procedure(const Sender: TObject; const Msg: TMessage)
    begin
      if (Msg is TSceneFactory) and
        ((Msg as TSceneFactory).SceneType = TSceneType.Exit) then
        close;
    end);

  if TBackgroundMusic.Current.HasAValidBackgroundMusicFile then
    TBackgroundMusic.Current.OnOff(tconfig.Current.BackgroundMusicOnOff);

  tthread.ForceQueue(nil,
    procedure
    begin
      tscene.Current := TSceneType.Home;
    end);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    TranslateTexts, true);
  BackgroundScene.FinalizeScene;
  BackgroundScene.Free;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
var KeyChar: WideChar; Shift: TShiftState);
var
  item: TUIElement;
begin
  if (Key = vkF1) and (KeyChar = #0) and (Shift = []) then
  begin
    Key := 0;
    KeyChar := #0;
    TAboutBox.ShowModal;
  end
  else
    TUIItemsList.Current.KeyDown(Key, KeyChar, Shift);
  if (Key = vkReturn) or ((Key = 0) and (KeyChar = ' ')) then
  begin
    item := TUIItemsList.Current.Focused;
    if assigned(item) then
    begin
      Key := 0;
      KeyChar := #0;
      item.DoClick;
    end;
  end;
end;

procedure TfrmMain.mnuAboutClick(Sender: TObject);
begin
  TAboutBox.ShowModal;
end;

procedure TfrmMain.TranslateTexts(const Sender: TObject; const Msg: TMessage);
// var
// ttm: TTranslateTextsMessage;
begin
  if not assigned(self) then
    Exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
  begin
    if assigned(MainMenu) then
      mnuAbout.Text := TAboutBox.GetCaption;

    // Uncomment and fill this code to translate texts on this form

    // ttm := Msg as TTranslateTextsMessage;
    // if ttm.Language = 'en' then
    // begin
    // end
    // else if ttm.Language = 'fr' then
    // begin
    // end
    // else if ttm.Language = 'it' then
    // begin
    // end
    // else if ttm.Language = 'pt' then
    // begin
    // end
    // else if ttm.Language = 'sp' then
    // begin
    // end
    // else if ttm.Language = 'de' then
    // begin
    // end
    // else
    // raise Exception.Create('Sorry, I can''t translate in "' +
    // ttm.Language + '".');
  end;
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}
randomize;

end.
