unit uGameData;

interface

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
  /// Subscribe to this message if you need to be informed about a user pseudo change
  /// </summary>
  TPseudoChangedMessage = class(TMessage)
  private
    FPseudo: string;
    procedure SetPseudo(const Value: string);
  protected
  public
    property Pseudo: string read FPseudo write SetPseudo;
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
    function GetFileName: string;
    function GetPath: string;
    procedure SetLevel(const Value: int64);
    procedure SetPath(const Value: string);
    procedure SetScore(const Value: int64);
    procedure SetUserPseudo(const Value: string);
  protected
    FPath: string;
    FHasChanged: boolean;
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
    /// It's the current player pseudo (if it has been asked)
    /// </summary>
    property UserPseudo: string read FUserPseudo write SetUserPseudo;
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
    constructor Create;
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
    /// Get the instance of default game data.
    /// In most cases it's better to use it than creating a new instance
    /// If you work on a descendnt of TGameData, don't call this method,
    /// create your own or use the constructor.
    /// </summary>
    class function DefaultGameData: TGameData; virtual;
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
    /// Used to clean current instance and reset all properties and fields to
    /// their default values
    /// </summary>
    procedure Clear; virtual;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  uConfig,
  Olf.RTL.Streams,
  Olf.RTL.CryptDecrypt, uConsts;

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
  Level := 0;
  Score := 0;
  UserPseudo := '';
  FFilePath := '';
  FHasChanged := false;
end;

procedure TGameData.ContinueGame;
begin
  // nothing to do at this level for the game template
end;

constructor TGameData.Create;
begin
  inherited;
  FLevel := 0;
  FScore := 0;
  FUserPseudo := '';
  FPath := '';
  FFilePath := '';
  FHasChanged := false;
end;

class function TGameData.DefaultGameData: TGameData;
begin
  if not assigned(LDefaultGameData) then
    LDefaultGameData := TGameData.Create;
  result := LDefaultGameData;
end;

destructor TGameData.Destroy;
begin
  inherited;
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
    result := tconfig.current.GetPath
  else
    result := FPath;
end;

procedure TGameData.LoadFromFile(const AFilePath: string);
var
  FS: tfilestream;
begin
  if (not AFilePath.IsEmpty) and tfile.exists(AFilePath) then
  begin
    Clear;
    FS := tfilestream.Create(AFilePath, fmOpenRead);
    try
{$IFDEF RELEASE}
      // TODO -opprem : traiter le chiffrement des données de backup
{$MESSAGE FATAL 'code missing'}
{$ELSE}
      LoadFromStream(FS);
{$ENDIF}
    finally
      FS.Free;
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
    // Load user pseudo
    FUserPseudo := LoadStringFromStream(AStream);
  end;

  FHasChanged := false;
end;

procedure TGameData.SaveToFile(const AFilePath: string);
var
  LFilePath: string;
  Folder: string;
  FS: tfilestream;
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
    FS := tfilestream.Create(LFilePath, fmcreate + fmOpenWrite);
    try
{$IFDEF RELEASE}
      // TODO -opprem : traiter le chiffrement des données de backup
{$MESSAGE FATAL 'code missing'}
{$ELSE}
      SaveToStream(FS);
{$ENDIF}
    finally
      FS.Free;
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
  SaveStringToStream(FUserPseudo, AStream);
  FHasChanged := false;
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

procedure TPseudoChangedMessage.SetPseudo(const Value: string);
begin
  FPseudo := Value;
end;

initialization

LDefaultGameData := nil;

finalization

LDefaultGameData.Free;

end.
