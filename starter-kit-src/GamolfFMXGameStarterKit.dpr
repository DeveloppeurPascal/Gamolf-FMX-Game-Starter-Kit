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
/// File last update : 2024-08-10T13:15:54.875+02:00
/// Signature : 19f0a14c40822e2cf67120a8feae3810bc4de64b
/// ***************************************************************************
/// </summary>

program GamolfFMXGameStarterKit;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  fMain in 'fMain.pas' {frmMain},
  Olf.FMX.AboutDialog in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  u_urlOpen in '..\lib-externes\librairies\src\u_urlOpen.pas',
  uConsts in 'uConsts.pas',
  Olf.RTL.Language in '..\lib-externes\librairies\src\Olf.RTL.Language.pas',
  Olf.RTL.CryptDecrypt in '..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Params in '..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  Olf.Skia.SVGToBitmap in '..\lib-externes\librairies\src\Olf.Skia.SVGToBitmap.pas',
  uDMAboutBox in 'uDMAboutBox.pas' {AboutBox: TDataModule},
  uDMAboutBoxLogoStorrage in 'uDMAboutBoxLogoStorrage.pas' {dmAboutBoxLogo: TDataModule},
  uTxtAboutLicense in 'uTxtAboutLicense.pas',
  uTxtAboutDescription in 'uTxtAboutDescription.pas',
  Gamolf.FMX.HelpBar in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.HelpBar.pas',
  Gamolf.FMX.Joystick in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.Joystick.pas',
  Gamolf.FMX.MusicLoop in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.MusicLoop.pas',
  Gamolf.RTL.GamepadDetected in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.GamepadDetected.pas',
  Gamolf.RTL.Joystick.DirectInput.Win in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.DirectInput.Win.pas',
  Gamolf.RTL.Joystick.Helpers in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Helpers.pas',
  Gamolf.RTL.Joystick.Mac in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Mac.pas',
  Gamolf.RTL.Joystick in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.pas',
  Gamolf.RTL.Scores in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Scores.pas',
  Gamolf.RTL.UIElements in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.UIElements.pas',
  iOSapi.GameController in '..\lib-externes\Delphi-Game-Engine\src\iOSapi.GameController.pas',
  Macapi.GameController in '..\lib-externes\Delphi-Game-Engine\src\Macapi.GameController.pas',
  uTranslate in 'uTranslate.pas',
  uConfig in 'uConfig.pas',
  _ScenesAncestor in '_AncestorsForScenesAndUIElements\_ScenesAncestor.pas' {__SceneAncestor: TFrame},
  uSceneBackground in 'ScenesSamples\uSceneBackground.pas' {SceneBackground: TFrame},
  uScene in 'uScene.pas',
  uSceneHome in 'ScenesSamples\uSceneHome.pas' {SceneHome: TFrame},
  uSceneGame in 'ScenesSamples\uSceneGame.pas' {SceneGame: TFrame},
  uSceneGameOverLost in 'ScenesSamples\uSceneGameOverLost.pas' {SceneGameOverLost: TFrame},
  uSceneGameOverWin in 'ScenesSamples\uSceneGameOverWin.pas' {SceneGameOverWin: TFrame},
  uSceneOptions in 'ScenesSamples\uSceneOptions.pas' {SceneOptions: TFrame},
  uSceneCredits in 'ScenesSamples\uSceneCredits.pas' {SceneCredits: TFrame},
  uSceneHallOfFame in 'ScenesSamples\uSceneHallOfFame.pas' {SceneHallOfFame: TFrame},
  uUIElements in 'uUIElements.pas',
  uGameData in 'uGameData.pas',
  Olf.RTL.Streams in '..\lib-externes\librairies\src\Olf.RTL.Streams.pas',
  Olf.RTL.Maths.Conversions in '..\lib-externes\librairies\src\Olf.RTL.Maths.Conversions.pas',
  uBackgroundMusic in 'uBackgroundMusic.pas',
  uSoundEffects in 'uSoundEffects.pas',
  USVGInputPrompts in '..\assets\kenney_nl\InputPrompts\USVGInputPrompts.pas',
  uDMGameControllerCenter in 'uDMGameControllerCenter.pas' {DMGameControllerCenter: TDataModule},
  uSVGBitmapManager in 'uSVGBitmapManager.pas',
  uDMHelpBarManager in 'uDMHelpBarManager.pas' {HelpBarManager: TDataModule},
  _ButtonsAncestor in '_AncestorsForScenesAndUIElements\_ButtonsAncestor.pas' {__ButtonAncestor: TFrame},
  _TheQuizAncestorButton in 'ButtonsSamples\DDoS2024TheQuiz\_TheQuizAncestorButton.pas' {__TheQuizAncestorButton: TFrame},
  cTheQuizHelloButton in 'ButtonsSamples\DDoS2024TheQuiz\cTheQuizHelloButton.pas' {TheQuizHelloButton: TFrame},
  uSceneTestButtons in 'ScenesSamples\uSceneTestButtons.pas' {SceneTestButtons: TFrame},
  _PloomtrisButtonAncestor in 'ButtonsSamples\Ploumtris\_PloomtrisButtonAncestor.pas' {__PloomtrisButtonAncestor: TFrame},
  USVGPuzzleAssets2 in '..\assets\kenney_nl\PuzzleAssets2\USVGPuzzleAssets2.pas',
  cPloomtrisWorldButton in 'ButtonsSamples\Ploumtris\cPloomtrisWorldButton.pas' {PloomtrisWorldButton: TFrame},
  _SporglooButtonAncestor in 'ButtonsSamples\Sporgloo\_SporglooButtonAncestor.pas' {__SporglooButtonAncestor: TFrame},
  cSporglooIUseDelphiButton in 'ButtonsSamples\Sporgloo\cSporglooIUseDelphiButton.pas' {SporglooIUseDelphiButton: TFrame},
  _EggHunterButtonAncestor in 'ButtonsSamples\EggHunter\_EggHunterButtonAncestor.pas' {__EggHunterButtonAncestor: TFrame},
  cEggHunterAndYouButton in 'ButtonsSamples\EggHunter\cEggHunterAndYouButton.pas' {EggHunterAndYouButton: TFrame};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMGameControllerCenter, DMGameControllerCenter);
  Application.Run;
end.
