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
/// File last update : 2024-08-08T18:19:58.000+02:00
/// Signature : 115cc065308da8d8bd7e374cef373e79f5dc5303
/// ***************************************************************************
/// </summary>

unit uConsts;

interface

// TODO : personalize the game global settings by saving this file in an other folder and changing defauls values
{$MESSAGE WARN 'Personalize these constants'}

const
  /// <summary>
  /// Version number of your game, don't forget to update the
  /// Project/Options/Versions infos before compiling a public RELEASE
  /// </summary>
  CAboutVersionNumber = '0.0';

  /// <summary>
  /// Version date of your game, change it when you publish a new public release
  /// </summary>
  CAboutVersionDate = '20240808';

  /// <summary>
  /// Title of your game used in the About box and as the main form caption
  /// </summary>
  CAboutGameTitle = 'My Game Template';

  /// <summary>
  /// The copyright to show in the About box
  /// </summary>
  CAboutCopyright = ''; // 2024 your name or anything else

  /// <summary>
  /// The website URL of your game (used in the About box)
  /// </summary>
  CAboutGameURL = 'https://gametemplate.developpeur-pascal.fr/';

  /// <summary>
  /// Default language used if the system language is not supported
  /// (of course you have to translate all textes of the program in this
  /// language, so use yours or English by default)
  /// </summary>
  /// <remarks>
  /// use 2 letters ISO code
  /// </remarks>
  CDefaultLanguage = 'en';

  /// <summary>
  /// If true the main form is opened in full screen. A menu with a "about" option is added for macOS.
  /// If false the main form is what you did with it, no menu is added for macOS.
  /// </summary>
  /// <remarks>
  /// Only available for desktop platforms. For iOS and Android it's "fullscreen" by design
  /// </remarks>
{$IFDEF DEBUG}
  // In DEBUG mode
  COpenGameInFullScreenMode = true;
{$ELSE}
  // For other compilations (including RELEASE)
  COpenGameInFullScreenMode = true;
{$ENDIF}
  //
  /// <summary>
  /// Add the name of your WAV or MP3 file to use as background music
  /// </summary>
  /// <remarks>
  /// For example : 'MyMusic.mp3', stored locally in _PRIVATE/musics,
  /// added to deployment project options for DEBUG or RELEASE other than Windows
  /// </remarks>
  CBackgroundMusicFileName = 'SmoothRide.mp3';

  /// <summary>
  /// Used as a folder name to store your game folder
  /// </summary>
  /// <remarks>
  /// Don't use a path, only a name to use a a folder name.
  /// The real paths are calculated automatically depending on the platform.
  /// </remarks>
  CEditorFolderName = 'Test';
  // for example your name, label or company name (avoid spaces, accents and special characters

  /// <summary>
  /// Used as a folder name to store the settings and scores
  /// </summary>
  /// Don't use a path, only a name to use a a folder name.
  /// The real paths are calculated automatically depending on the platform.
  /// </remarks>
  CGameFolderName = 'Test';
  // for exemple your game title (avoid spaces, accents and special characters)

  /// <summary>
  /// The GUID to use for this game when saving/loading files like game data
  /// to check they are from this game and not an other one.
  /// </summary>
  CGameGUID = '{48AD6D06-1BED-4F33-ADCA-267E12D74417}';
  // Use Shift+Ctrl+G to generate a new GUID and replace current value by the new one
  // TODO : Set your game GUID. Each game must have it's GUID, don't use the same !
{$MESSAGE WARN 'Set your game GUID, don't use the default value !!!'}

type
{$SCOPEDENUMS ON}
  /// <summary>
  /// List of scenes available in your game
  /// "None", "Home" and "Exit" are used by the template engine, you can add/remove the others
  /// </summary>
  /// <remarks>
  /// Change value of TScene.Current to autocreate and show the good scene.
  /// Create scenes screens by inheriting from /Scenes/_SceneAncestor.pas
  /// </remarks>
  TSceneType = (None (* "None" must stay *) , Home (* "Home" must stay *) ,
    Exit (* "Exit" must stay *) , Game, GameOverLost, GameOverWin, Credits,
    Options, HallOfFame);

implementation

uses
  System.SysUtils;

initialization

if CAboutGameTitle.Trim.IsEmpty then
  raise Exception.Create
    ('Please give a title to your game in CAboutGameTitle !');

if CEditorFolderName.Trim.IsEmpty then
  raise Exception.Create
    ('Please give an editor folder name in CEditorFolderName !');

if CGameFolderName.Trim.IsEmpty then
  raise Exception.Create('Please give a game folder name in CGameFolderName !');

if CDefaultLanguage.Trim.IsEmpty then
  raise Exception.Create
    ('Please specify a default language ISO code in CDefaultLanguage !');

if (CDefaultLanguage <> CDefaultLanguage.Trim.ToLower) then
  raise Exception.Create('Please use "' + CDefaultLanguage.Trim.ToLower +
    '" as CDefaultLanguage value.');

{$IFDEF RELEASE}
if (CGameGUID = '{48AD6D06-1BED-4F33-ADCA-267E12D74417}') then
  raise Exception.Create('Wrong GUID. Change it in game settings !');
{$ENDIF}

end.
