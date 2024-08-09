﻿/// <summary>
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
/// File last update : 2024-08-09T21:36:26.000+02:00
/// Signature : 5d795577c49e9abf7e2adbedc8788459356fb1fe
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
  FMX.StdCtrls;

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
  BackgroundScene.ShowScene;

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
      tscene.Current := CDefaultSceneOnStartup;
    end);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    TranslateTexts, true);
  BackgroundScene.HideScene;
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
begin
  if not assigned(self) then
    Exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
  begin
    if assigned(MainMenu) then
      mnuAbout.Text := TAboutBox.GetCaption;
  end;
end;

initialization

randomize;

end.