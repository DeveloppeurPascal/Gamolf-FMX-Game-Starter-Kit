/// <summary>
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
/// File last update : 2024-08-20T10:14:44.000+02:00
/// Signature : 6f80af99aca1dfad488388c6faa6fb082dd24423
/// ***************************************************************************
/// </summary>

unit fMain;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

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
  FMX.StdCtrls,
  uDMAboutBox,
  Olf.FMX.AboutDialogForm;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    mnuMacOSAppname: TMenuItem;
    mnuAbout: TMenuItem;
    DGEGamepadDetected1: TDGEGamepadDetected;
    /// <remarks>
    /// Never use DGEFMXHelpBar1 or frmMain.DGEFMXHelpBar1, it will be removed
    /// in a future release of this template.
    /// To access to the Help Bar, use THelpBarManager.Current from
    /// uDMHelpBarManager unit.
    /// </remarks>
    DGEFMXHelpBar1: TDGEFMXHelpBar;
    /// <remarks>
    /// This label is a warning, it's removed during form creation.
    /// Don't use it in your code or you'll have access violations !
    /// </remarks>
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
    procedure mnuAboutClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
  private
    BackgroundScene: TSceneBackground;
    FOnAboutBoxTranslateTexts: TOnAboutBoxTranslateTexts;
    procedure SetOnAboutBoxTranslateTexts(const Value
      : TOnAboutBoxTranslateTexts);
  protected
    /// <summary>
    /// Used as OnAboutBoxTranslateTexts event in the about box dialog
    /// if OnAboutBoxTranslateTexts property is not assigned.
    /// </summary>
    /// <remarks>
    /// Override it in your main form or assign an other method to
    /// OnAboutBoxTranslateTexts
    /// languages.
    /// </remarks>
    function DoAboutBoxTranslateTexts(const Language: string;
      const TxtID: TOlfAboutDialogTxtID): string; virtual;
  public
    /// <summary>
    /// Use it if you want to override about box texts translation or add your languages.
    /// </summary>
    property OnAboutBoxTranslateTexts: TOnAboutBoxTranslateTexts
      read FOnAboutBoxTranslateTexts write SetOnAboutBoxTranslateTexts;
    procedure TranslateTexts(const Sender: TObject;
      const Msg: TMessage); Virtual;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  uConsts,
  uTranslate,
  uScene,
  uBackgroundMusic,
  uConfig,
  uUIElements,
  Gamolf.RTL.UIElements,
  _ScenesAncestor;

procedure TfrmMain.AfterConstruction;
begin
  inherited;
{$IF Defined(MACOS) and not Defined(IOS)}
{$ELSE}
  FreeAndNil(MainMenu);
{$ENDIF}
  // Remove the WARNING message for the developper in Delphi IDE.
  FreeAndNil(Label1);

  fullscreen := COpenGameInFullScreenMode;

  TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
    TranslateTexts);

  TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
    procedure(const Sender: TObject; const Msg: TMessage)
    begin
      if (Msg is TSceneFactory) and
        ((Msg as TSceneFactory).SceneType = TSceneType.Exit) then
        close;
    end);

  tthread.ForceQueue(nil,
    procedure
    begin
      BackgroundScene := TSceneBackground.Create(self);
      BackgroundScene.parent := self;
      BackgroundScene.ShowScene;

      tscene.Current := CDefaultSceneOnStartup;

      if TBackgroundMusic.Current.HasAValidBackgroundMusicFile then
        TBackgroundMusic.Current.OnOff(tconfig.Current.BackgroundMusicOnOff);
    end);
end;

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;
  BackgroundScene := nil;
end;

function TfrmMain.DoAboutBoxTranslateTexts(const Language: string;
const TxtID: TOlfAboutDialogTxtID): string;
begin
  // Do nothing at this level
  result := '';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    TranslateTexts, true);
  if assigned(BackgroundScene) then
  begin
    BackgroundScene.HideScene;
    BackgroundScene.Free;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
var KeyChar: WideChar; Shift: TShiftState);
var
  item: TUIElement;
  CurrentScene: T__SceneAncestor;
begin
  if (Key = vkF1) and (KeyChar = #0) and (Shift = []) then
  begin
    Key := 0;
    KeyChar := #0;
    mnuAboutClick(Sender);
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
  if (Key <> 0) or (KeyChar <> #0) then
  begin
    CurrentScene := tscene.GetInstance;
    if assigned(CurrentScene) and assigned(CurrentScene.OnKeyDown) then
      CurrentScene.OnKeyDown(Sender, Key, KeyChar, Shift);
  end;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word;
var KeyChar: WideChar; Shift: TShiftState);
var
  CurrentScene: T__SceneAncestor;
begin
  if (Key <> 0) or (KeyChar <> #0) then
  begin
    CurrentScene := tscene.GetInstance;
    if assigned(CurrentScene) and assigned(CurrentScene.OnKeyUp) then
      CurrentScene.OnKeyUp(Sender, Key, KeyChar, Shift);
  end;
end;

procedure TfrmMain.mnuAboutClick(Sender: TObject);
begin
  if assigned(OnAboutBoxTranslateTexts) then
    TAboutBox.Current.OnAboutBoxTranslateTexts := OnAboutBoxTranslateTexts
  else
    TAboutBox.Current.OnAboutBoxTranslateTexts := DoAboutBoxTranslateTexts;
  TAboutBox.Current.ShowModal;
end;

procedure TfrmMain.SetOnAboutBoxTranslateTexts(const Value
  : TOnAboutBoxTranslateTexts);
begin
  FOnAboutBoxTranslateTexts := Value;
end;

procedure TfrmMain.TranslateTexts(const Sender: TObject; const Msg: TMessage);
begin
  if not assigned(self) then
    Exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
  begin
    if assigned(MainMenu) then
      mnuAbout.Text := TAboutBox.Current.GetCaption;
  end;
end;

initialization

randomize;

end.
