/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Starter Kit
///
/// Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.
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
/// File last update : 2025-05-10T16:02:34.229+02:00
/// Signature : e198c0e45b4644d0f7fb6ff7f5e443053a286118
/// ***************************************************************************
/// </summary>

unit uGameData;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.
//
// If you want to add features to TGameData, don't change this file, simply use
// the helpers.
//
// If you want to add fields or properties, create a new class in your project
// and inherits from current TGameData. Override all needed methods and add what
// you have to manage for your game.

uses
  System.Messaging,
  System.Classes;

type
  /// <summary>
  /// Subscribe to this message if you need to be informed about a score change
  /// </summary>
  TScoreChangedMessage = class(TMessage)
  private
    FScore: int64;
  protected
  public
    property Score: int64 read FScore;
    constructor Create(const AScore: int64);
    class procedure Broadcast(const AScore: int64);
  end;

  /// <summary>
  /// Subscribe to this message if you need to be informed about a level change
  /// </summary>
  TLevelChangedMessage = class(TMessage)
  private
    FLevel: int64;
  protected
  public
    property Level: int64 read FLevel;
    constructor Create(const ALevel: int64);
    class procedure Broadcast(const ALevel: int64);
  end;

  /// <summary>
  /// Subscribe to this message if you need to be informed about a lives number change
  /// </summary>
  TNbLivesChangedMessage = class(TMessage)
  private
    FNbLives: int64;
  protected
  public
    property NbLives: int64 read FNbLives;
    constructor Create(const ANbLives: int64);
    class procedure Broadcast(const ANbLives: int64);
  end;

  /// <summary>
  /// Subscribe to this message if you need to be informed about a user pseudo change
  /// </summary>
  TPseudoChangedMessage = class(TMessage)
  private
    FPseudo: string;
  protected
  public
    property Pseudo: string read FPseudo;
    constructor Create(const APseudo: string);
    class procedure Broadcast(const APseudo: string);
  end;

  /// <summary>
  /// Manage the game data and have the ability to be saved/restored or started/paused/restarted
  /// </summary>
  /// <remarks>
  /// To add new features and store other things, it's better to inherits from
  /// this class. It allow you to update thise file with the future templates
  /// updates.
  /// </remarks>
  TGameData = class
  private const
    /// <summary>
    /// Version level of this class. It is used to check compatibility between
    /// the program and the files it saves or tries to load.
    /// </summary>
    CGameDataVersion = 1;

  var
    FLevel: int64;
    FUserPseudo: string;
    FScore: int64;
    FFilePath: string;
    FNbLives: int64;
    procedure SetNbLives(const Value: int64);
    function GetFileName: string;
    function GetPath: string;
    procedure SetLevel(const Value: int64);
    procedure SetPath(const Value: string);
    procedure SetScore(const Value: int64);
    procedure SetUserPseudo(const Value: string);
    class procedure SetDefaultGameDataInstance(const Value: TGameData);
    class function GetDefaultGameDataInstance: TGameData;
  protected
    FPath: string;
    FHasChanged: boolean;
    FIsPlaying: boolean;
    FIsPaused: boolean;
  public
    /// <summary>
    /// It's the current player score
    /// </summary>
    property Score: int64 read FScore write SetScore;
    /// <summary>
    /// It's the current player level
    /// </summary>
    property Level: int64 read FLevel write SetLevel;
    /// <summary>
    /// It's the current player lives number level
    /// </summary>
    property NbLives: int64 read FNbLives write SetNbLives;
    /// <summary>
    /// It's the current player pseudo (if it has been asked)
    /// </summary>
    property UserPseudo: string read FUserPseudo write SetUserPseudo;
    /// <summary>
    /// Returns True after a load() or a pausegame()
    /// Returns False after a Clear()
    /// </summary>
    property IsPaused: boolean read FIsPaused;
    /// <summary>
    /// Returns True after a StartANewGame() or ContinueGame()
    /// Returns False after a PauseGame() or StopGame()
    /// </summary>
    property IsPlaying: boolean read FIsPlaying;
    /// <summary>
    /// Path to the folder where games will be saved
    /// </summary>
    /// <remarks>
    /// Default value is based on TConfig saving path combined to "Games" folder
    /// </remarks>
    property Path: string read GetPath write SetPath;
    /// <summary>
    /// The FileName for this game (no path, no extension) if opened by
    /// LoadFromFile(WithAName) or it has been saved by SaveToFile(WithAName)
    /// </summary>
    property FileName: string read GetFileName;
    /// <summary>
    /// Returns True if a game parameter has changed since last Clear(),
    /// LoadXXX() or SaveXXX()
    /// </summary>
    property HasChanged: boolean read FHasChanged;
    /// <summary>
    /// Used to create a new instance of this class.
    /// It's better to use TGameData.DefaultGameData if you don't need to
    /// manage complex things on your game data.
    /// </summary>
    constructor Create; virtual;
    /// <summary>
    /// Never call it, use only "Free" or "FreeAndNil" if you called the
    /// Create() method to get a new instance of this game.
    /// </summary>
    destructor Destroy; override;
    /// <summary>
    /// Used to load the game data from a file after clearing the instance.
    /// </summary>
    procedure LoadFromFile(const AFilePath: string);
    /// <summary>
    /// Used to save current game data to a file
    /// </summary>
    procedure SaveToFile(const AFilePath: string = '');
    /// <summary>
    /// Used to load the game data from a stream.
    /// </summary>
    /// <remarks>
    /// No Clear() is called, its only load the saved datas, don't initialize
    /// other things from your game.
    /// </remarks>
    procedure LoadFromStream(const AStream: TStream); virtual;
    /// <summary>
    /// Used to save current game data to a stream
    /// </summary>
    procedure SaveToStream(const AStream: TStream); virtual;
    /// <summary>
    /// Get the instance of default game data as a TGameData instance.
    /// </summary>
    /// <remarks>
    /// If you work on a descendant class, use "DefaultGameData(T):T" to create
    /// your instance and add a Current function at the descendant level to
    /// simplify your life.
    /// </remarks>
    class function DefaultGameData: TGameData; overload; virtual;
    /// <summary>
    /// Get the instance of current game data as a T instance.
    /// </summary>
    class function DefaultGameData<T: TGameData>: T; overload;
    /// <summary>
    /// Start the game after clearing the game data
    /// </summary>
    /// <remarks>
    /// All properties and fields must be initialized to start a new game.
    /// After initiallizing all the data, it calls the ContinueGame() method to
    /// start the game.
    /// </remarks>
    procedure StartANewGame; virtual;
    /// <summary>
    /// Start the game without clearing the game data before
    /// Use it to continue a game after a pause or loading it
    /// </summary>
    /// <remarks>
    /// Use it to initialize things linked to the display, sprites, ...
    /// </remarks>
    procedure ContinueGame; virtual;
    /// <summary>
    /// Call it when you pause (stop temporary) a game and want to continue it in the future
    /// </summary>
    procedure PauseGame; virtual;
    /// <summary>
    /// Call it when you stop a game
    /// </summary>
    procedure StopGame; virtual;
    /// <summary>
    /// Used to clean current instance and reset all properties and fields to
    /// their default values
    /// </summary>
    procedure Clear; virtual;
  end;

implementation

uses
  FMX.Types,
  System.SysUtils,
  System.IOUtils,
  uConfig,
  Olf.RTL.Streams,
  Olf.RTL.CryptDecrypt,
  uConsts;

var
  LDefaultGameData: TGameData;

  { TScoreChangedMessage }

class procedure TScoreChangedMessage.Broadcast(const AScore: int64);
var
  LScore: int64;
begin
  LScore := AScore;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TScoreChangedMessage.Create(LScore));
    end);
end;

constructor TScoreChangedMessage.Create(const AScore: int64);
begin
  inherited Create;
  FScore := AScore;
end;

{ TLevelChangedMessage }

class procedure TLevelChangedMessage.Broadcast(const ALevel: int64);
var
  LLevel: int64;
begin
  LLevel := ALevel;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TLevelChangedMessage.Create(LLevel));
    end);
end;

constructor TLevelChangedMessage.Create(const ALevel: int64);
begin
  inherited Create;
  FLevel := ALevel;
end;

{ TGameData }

procedure TGameData.Clear;
begin
  FFilePath := '';
  FLevel := CDefaultLevel;
  FScore := CDefaultScore;
  FNbLives := CDefaultNbLives;
  UserPseudo := '';
  FHasChanged := false;
  FIsPlaying := false;
  FIsPaused := false;
end;

procedure TGameData.ContinueGame;
begin
  // nothing to do at this level for the game template
  FIsPlaying := true;
  FIsPaused := false;
end;

constructor TGameData.Create;
begin
  inherited;
  FPath := '';
  FFilePath := '';
  FLevel := CDefaultLevel;
  FScore := CDefaultScore;
  FNbLives := CDefaultNbLives;
  FUserPseudo := '';
  FHasChanged := false;
  FIsPlaying := false;
  FIsPaused := false;
end;

class function TGameData.DefaultGameData: TGameData;
begin
  if not assigned(LDefaultGameData) then
    LDefaultGameData := TGameData.Create;
  result := LDefaultGameData;
end;

class function TGameData.DefaultGameData<T>: T;
var
  gd: TGameData;
{$IFNDEF RELEASE}
  s: string;
{$ENDIF}
begin
  gd := TGameData.GetDefaultGameDataInstance;
  if not assigned(gd) then
    TGameData.SetDefaultGameDataInstance(T.Create)
  else if not(gd is T) then
  begin
{$IFDEF RELEASE}
    gd.free;
    TGameData.SetDefaultGameDataInstance(T.Create)
{$ELSE}
    // It could be an error on a normal behaviour,
    // hard to choose between the two cases and raise an exception or just
    // a warning on the debugger console.
    //
    // To avoid this case, access to YOUR game data instance in the
    // "initialization" section of its unit declaration.
      s := '***** WARNING ***** Removed ' + gd.ClassName +
      ' instance to create a ';
    gd.free;
    TGameData.SetDefaultGameDataInstance(T.Create);
    s := s + TGameData.GetDefaultGameDataInstance.ClassName + ' instance.';
    log.d(s);
{$ENDIF}
  end;
  result := TGameData.GetDefaultGameDataInstance as T;
end;

destructor TGameData.Destroy;
begin
  inherited;
end;

class function TGameData.GetDefaultGameDataInstance: TGameData;
begin
  result := LDefaultGameData;
end;

function TGameData.GetFileName: string;
begin
  result := tpath.GetFileNameWithoutExtension(FFilePath);
end;

function TGameData.GetPath: string;
begin
  if not FFilePath.IsEmpty then
    result := tpath.GetDirectoryName(FFilePath)
  else if FPath.IsEmpty or (not tdirectory.exists(FPath)) then
    result := tpath.GetDirectoryName(tconfig.current.GetPath)
  else
    result := FPath;
end;

procedure TGameData.LoadFromFile(const AFilePath: string);
var
  FS: TFileStream;
{$IFDEF RELEASE}
  MS: TMemoryStream;
{$ENDIF}
begin
  if (not AFilePath.IsEmpty) and tfile.exists(AFilePath) then
  begin
    Clear;
    FS := TFileStream.Create(AFilePath, fmOpenRead);
    try
{$IFDEF RELEASE}
      MS := TOlfCryptDecrypt.XORDecrypt(FS, GGameDataXORKey);
      try
        MS.Position := 0;
        LoadFromStream(MS);
      finally
        MS.free;
      end;
{$ELSE}
      LoadFromStream(FS);
{$ENDIF}
    finally
      FS.free;
      FFilePath := AFilePath;
      FHasChanged := false;
    end;
  end;
end;

procedure TGameData.LoadFromStream(const AStream: TStream);
var
  Guid: string;
  VersionNum: integer;
begin
  // Check is this game data file is for current game.
  Guid := LoadStringFromStream(AStream);
  if (Guid <> CGameGUID) then
    raise exception.Create('This file is not recognized !');

  // Check if the game data file has a block version number.
  if (sizeof(VersionNum) <> AStream.read(VersionNum, sizeof(VersionNum))) then
    raise exception.Create('Wrong File format !');

  // Check if the program can open the game data.
  if (VersionNum > CGameDataVersion) then
    raise exception.Create
      ('Can''t open this file. Please update the game before trying again.');

  if (VersionNum >= 1) then
  begin
    // Load the level
    if (sizeof(FLevel) <> AStream.read(FLevel, sizeof(FLevel))) then
      raise exception.Create('Wrong File format !');
    // Load the score
    if (sizeof(FScore) <> AStream.read(FScore, sizeof(FScore))) then
      raise exception.Create('Wrong File format !');
    // Load the number of lives
    if (sizeof(FNbLives) <> AStream.read(FNbLives, sizeof(FNbLives))) then
      raise exception.Create('Wrong File format !');
    // Load user pseudo
    FUserPseudo := LoadStringFromStream(AStream);
  end;

  FHasChanged := false;
end;

procedure TGameData.PauseGame;
begin
  FIsPlaying := false;
  FIsPaused := true;

  // do what you need to do when you pause the game (stop threads, timers, ...)
  // perhaps autosave the game

  if not FFilePath.IsEmpty then
    SaveToFile;
end;

procedure TGameData.SaveToFile(const AFilePath: string);
var
  LFilePath: string;
  Folder: string;
  FS: TFileStream;
{$IFDEF RELEASE}
  MS, MS2: TMemoryStream;
{$ENDIF}
begin
  if AFilePath.IsEmpty then
    LFilePath := FFilePath
  else
    LFilePath := AFilePath;

  if LFilePath.IsEmpty then
    raise exception.Create('Specify a file path where to save current game.');

  Folder := tpath.GetDirectoryName(LFilePath);
  if (not Folder.IsEmpty) then
  begin
    if not tdirectory.exists(Folder) then
      tdirectory.CreateDirectory(Folder);
    FS := TFileStream.Create(LFilePath, fmcreate + fmOpenWrite);
    try
{$IFDEF RELEASE}
      MS := TMemoryStream.Create;
      try
        SaveToStream(MS);
        MS.Position := 0;
        MS2 := TOlfCryptDecrypt.XORcrypt(MS, GGameDataXORKey);
        try
          MS2.Position := 0;
          FS.CopyFrom(MS2);
        finally
          MS2.free;
        end;
      finally
        MS.free;
      end;
{$ELSE}
      SaveToStream(FS);
{$ENDIF}
    finally
      FS.free;
      FFilePath := LFilePath;
      FHasChanged := false;
    end;
  end;
end;

procedure TGameData.SaveToStream(const AStream: TStream);
var
  Guid: string;
  VersionNum: integer;
begin
  Guid := CGameGUID;
  SaveStringToStream(Guid, AStream);
  VersionNum := CGameDataVersion;
  AStream.Write(VersionNum, sizeof(VersionNum));
  AStream.Write(FLevel, sizeof(FLevel));
  AStream.Write(FScore, sizeof(FScore));
  AStream.Write(FNbLives, sizeof(FNbLives));
  SaveStringToStream(FUserPseudo, AStream);
  FHasChanged := false;
end;

class procedure TGameData.SetDefaultGameDataInstance(const Value: TGameData);
begin
  LDefaultGameData := Value;
end;

procedure TGameData.SetLevel(const Value: int64);
begin
  if (FLevel <> Value) then
  begin
    FLevel := Value;
    FHasChanged := true;
    TLevelChangedMessage.Broadcast(FLevel);
  end;
end;

procedure TGameData.SetNbLives(const Value: int64);
begin
  if (FNbLives <> Value) then
  begin
    FNbLives := Value;
    FHasChanged := true;
    TNbLivesChangedMessage.Broadcast(FNbLives);
  end;
end;

procedure TGameData.SetPath(const Value: string);
begin
  if Value.IsEmpty or tdirectory.exists(Value) then
    FPath := Value;
end;

procedure TGameData.SetScore(const Value: int64);
begin
  if (FScore <> Value) then
  begin
    FScore := Value;
    FHasChanged := true;
    TScoreChangedMessage.Broadcast(FScore);
  end;
end;

procedure TGameData.SetUserPseudo(const Value: string);
begin
  if (FUserPseudo <> Value) then
  begin
    FUserPseudo := Value;
    FHasChanged := true;
    TPseudoChangedMessage.Broadcast(FUserPseudo);
  end;
end;

procedure TGameData.StartANewGame;
begin
  Clear;
  ContinueGame;
end;

procedure TGameData.StopGame;
begin
  // perhaps call PauseGame()
  // do what you need to do when you stop the game (stop threads, timers, ...)
  // perhaps save the score if it's not done in your game scene finalization or
  // gameover(win/lost) scene
  FIsPlaying := false;
  FIsPaused := false;
end;

{ TPseudoChangedMessage }

class procedure TPseudoChangedMessage.Broadcast(const APseudo: string);
var
  LPseudo: string;
begin
  LPseudo := APseudo;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TPseudoChangedMessage.Create(LPseudo));
    end);
end;

constructor TPseudoChangedMessage.Create(const APseudo: string);
begin
  inherited Create;
  FPseudo := APseudo;
end;

{ TNbLivesChangedMessage }

class procedure TNbLivesChangedMessage.Broadcast(const ANbLives: int64);
var
  LNbLives: int64;
begin
  LNbLives := ANbLives;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TNbLivesChangedMessage.Create(LNbLives));
    end);
end;

constructor TNbLivesChangedMessage.Create(const ANbLives: int64);
begin
  inherited Create;
  FNbLives := ANbLives;
end;

initialization

LDefaultGameData := nil;

finalization

LDefaultGameData.free;

end.
