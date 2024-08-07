unit uConsts;

interface

// TODO : personalize the game global settings
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
  CAboutVersionDate = '20240807';

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

end.
