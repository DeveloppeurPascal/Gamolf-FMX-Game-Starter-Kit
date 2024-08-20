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
/// File last update : 2024-08-20T10:35:54.000+02:00
/// Signature : cadecc1b4d025f19036832d980a0f8be872ace71
/// ***************************************************************************
/// </summary>

program SnakeGameSample;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  fMain in '..\..\starter-kit-src\fMain.pas' {frmMain},
  Olf.FMX.AboutDialog in '..\..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  u_urlOpen in '..\..\lib-externes\librairies\src\u_urlOpen.pas',
  uConsts in 'uConsts.pas',
  Olf.RTL.Language in '..\..\lib-externes\librairies\src\Olf.RTL.Language.pas',
  Olf.RTL.CryptDecrypt in '..\..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Params in '..\..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  Olf.Skia.SVGToBitmap in '..\..\lib-externes\librairies\src\Olf.Skia.SVGToBitmap.pas',
  uDMAboutBox in '..\..\starter-kit-src\uDMAboutBox.pas' {AboutBox: TDataModule},
  uDMAboutBoxLogoStorrage in '..\..\starter-kit-src\uDMAboutBoxLogoStorrage.pas' {dmAboutBoxLogo: TDataModule},
  uTxtAboutDescription in 'uTxtAboutDescription.pas',
  Gamolf.FMX.HelpBar in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.HelpBar.pas',
  Gamolf.FMX.Joystick in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.Joystick.pas',
  Gamolf.FMX.MusicLoop in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.MusicLoop.pas',
  Gamolf.RTL.GamepadDetected in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.GamepadDetected.pas',
  Gamolf.RTL.Joystick.DirectInput.Win in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.DirectInput.Win.pas',
  Gamolf.RTL.Joystick.Helpers in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Helpers.pas',
  Gamolf.RTL.Joystick.Mac in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Mac.pas',
  Gamolf.RTL.Joystick in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.pas',
  Gamolf.RTL.Scores in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Scores.pas',
  Gamolf.RTL.UIElements in '..\..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.UIElements.pas',
  iOSapi.GameController in '..\..\lib-externes\Delphi-Game-Engine\src\iOSapi.GameController.pas',
  Macapi.GameController in '..\..\lib-externes\Delphi-Game-Engine\src\Macapi.GameController.pas',
  uTranslate in '..\..\starter-kit-src\uTranslate.pas',
  uConfig in '..\..\starter-kit-src\uConfig.pas',
  _ScenesAncestor in '..\..\starter-kit-src\_ScenesAncestor.pas' {__SceneAncestor: TFrame},
  uScene in '..\..\starter-kit-src\uScene.pas',
  uUIElements in '..\..\starter-kit-src\uUIElements.pas',
  uGameData in '..\..\starter-kit-src\uGameData.pas',
  Olf.RTL.Streams in '..\..\lib-externes\librairies\src\Olf.RTL.Streams.pas',
  Olf.RTL.Maths.Conversions in '..\..\lib-externes\librairies\src\Olf.RTL.Maths.Conversions.pas',
  uBackgroundMusic in '..\..\starter-kit-src\uBackgroundMusic.pas',
  USVGInputPrompts in '..\..\assets\kenney_nl\InputPrompts\USVGInputPrompts.pas',
  uDMGameControllerCenter in '..\..\starter-kit-src\uDMGameControllerCenter.pas' {DMGameControllerCenter: TDataModule},
  uSVGBitmapManager_InputPrompts in '..\..\starter-kit-src\uSVGBitmapManager_InputPrompts.pas',
  uDMHelpBarManager in '..\..\starter-kit-src\uDMHelpBarManager.pas' {HelpBarManager: TDataModule},
  _ButtonsAncestor in '..\..\starter-kit-src\_ButtonsAncestor.pas' {__ButtonAncestor: TFrame},
  uSceneBackground in 'uSceneBackground.pas' {SceneBackground: TFrame},
  uTxtAboutLicense in '..\uTxtAboutLicense.pas',
  uSceneHome in 'uSceneHome.pas' {HomeScene: TFrame},
  uSceneGameOver in 'uSceneGameOver.pas' {GameOverScene: TFrame},
  uSceneCredits in 'uSceneCredits.pas' {CreditsScene: TFrame},
  uSceneSnake in 'uSceneSnake.pas' {SnakeScene: TFrame},
  uButton in 'uButton.pas' {TextButton: TFrame};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMGameControllerCenter, DMGameControllerCenter);
  Application.Run;
end.
