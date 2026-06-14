(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit
  Copyright (c) 2024-2026 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  ***************************************************************************

  The "Gamolf FMX Game Starter Kit" is both a "technical" example of a video
  game developed in Delphi with everything you need inside and a reusable
  project template you can customize for your own games.

  The files provided are fully functional. Numerous comments are included in
  the sources to explain how they work and what you need to copy, override
  or customize to make video games without starting from scratch.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://fmxgamestarterkit.developpeur-pascal.fr/

  Project site :
  https://codeberg.org/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit

  ***************************************************************************
  File last update : 2026-04-02T19:25:40.531+02:00
  Signature : b60fe849bc96251acc409c80fbd614ae0b2d200a
  ***************************************************************************
*)

program PongGameSample;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  fMain in '..\..\src\fMain.pas' {frmMain},
  Olf.FMX.AboutDialog in '..\..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  u_urlOpen in '..\..\lib-externes\librairies\src\u_urlOpen.pas',
  uConsts in 'uConsts.pas',
  Olf.RTL.Language in '..\..\lib-externes\librairies\src\Olf.RTL.Language.pas',
  Olf.RTL.CryptDecrypt in '..\..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Params in '..\..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  Olf.Skia.SVGToBitmap in '..\..\lib-externes\librairies\src\Olf.Skia.SVGToBitmap.pas',
  uDMAboutBox in '..\..\src\uDMAboutBox.pas' {AboutBox: TDataModule},
  uDMAboutBoxLogoStorrage in '..\..\src\uDMAboutBoxLogoStorrage.pas' {dmAboutBoxLogo: TDataModule},
  uTxtAboutLicense in '..\uTxtAboutLicense.pas',
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
  uTranslate in '..\..\src\uTranslate.pas',
  uConfig in '..\..\src\uConfig.pas',
  uScene in '..\..\src\uScene.pas',
  uUIElements in '..\..\src\uUIElements.pas',
  uGameData in '..\..\src\uGameData.pas',
  Olf.RTL.Streams in '..\..\lib-externes\librairies\src\Olf.RTL.Streams.pas',
  Olf.RTL.Maths.Conversions in '..\..\lib-externes\librairies\src\Olf.RTL.Maths.Conversions.pas',
  uBackgroundMusic in '..\..\src\uBackgroundMusic.pas',
  USVGInputPrompts in '..\..\assets\kenney_nl\InputPrompts\USVGInputPrompts.pas',
  uDMGameControllerCenter in '..\..\src\uDMGameControllerCenter.pas' {DMGameControllerCenter: TDataModule},
  uSVGBitmapManager in 'uSVGBitmapManager.pas',
  uDMHelpBarManager in '..\..\src\uDMHelpBarManager.pas' {HelpBarManager: TDataModule},
  uSceneBackground in 'uSceneBackground.pas' {SceneBackground: TFrame},
  uSceneHome in 'uSceneHome.pas' {SceneHome: TFrame},
  uSceneGame in 'uSceneGame.pas' {SceneGame: TFrame},
  uSceneGameOver in 'uSceneGameOver.pas' {SceneGameOver: TFrame},
  uSceneCredits in 'uSceneCredits.pas' {SceneCredits: TFrame},
  _ButtonsAncestor in '..\..\src\_ButtonsAncestor.pas' {__ButtonAncestor: TFrame},
  _ScenesAncestor in '..\..\src\_ScenesAncestor.pas' {__SceneAncestor: TFrame},
  _EggHunterButtonAncestor in '..\_SampleGame\ButtonsSamples\EggHunter\_EggHunterButtonAncestor.pas' {__EggHunterButtonAncestor: TFrame};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMGameControllerCenter, DMGameControllerCenter);
  Application.Run;
end.
