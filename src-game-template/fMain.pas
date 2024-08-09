/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Template
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
/// The "Gamolf FMX Game Template" is both a "technical" example of a video
/// game developed in Delphi with everything you need inside, and a reusable
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
/// https://gametemplate.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Template
///
/// ***************************************************************************
/// File last update : 2024-08-08T21:50:26.000+02:00
/// Signature : 077d9b8ce50ae3148b0f429d9e6e444fb31f9547
/// ***************************************************************************
/// </summary>

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
  Gamolf.RTL.GamepadDetected,
  Gamolf.FMX.HelpBar,
  FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    mnuMacOSAppname: TMenuItem;
    mnuAbout: TMenuItem;
    DGEGamepadDetected1: TDGEGamepadDetected;
    DGEFMXHelpBar1: TDGEFMXHelpBar;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
    procedure mnuAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    BackgroundScene: TSceneBackground;
  protected
  public
    procedure TranslateTexts(const Sender: TObject;
      const Msg: TMessage); Virtual;
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
  // Remove the WARNING message for the developper in Delphi IDE.
  FreeAndNil(Label1);

  fullscreen := COpenGameInFullScreenMode;
{$IF Defined(MACOS) and not Defined(IOS)}
{$ELSE}
  FreeAndNil(MainMenu);
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
