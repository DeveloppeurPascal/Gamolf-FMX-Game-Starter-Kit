unit uGameData;

interface

uses
  System.Messaging,
  System.Classes;

type
  /// <summary>
  /// Subscribe to this message if you need to be informed about a score change
  /// </summary>
  TScoreUpdatedMessage = class(TMessage)
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
  TLevelUpdatedMessage = class(TMessage)
  private
    FLevel: int64;
  protected
  public
    property Level: int64 read FLevel;
    constructor Create(const ALevel: int64);
    class procedure Broadcast(const ALevel: int64);
  end;

  /// <summary>
  /// Manage the game data and have the ability to be saved/restored or started/paused/restarted
  /// </summary>
  TGameData = class
    // TODO : to add features needed for your game you should inherits from this class (better than changing this one if you want to update your game source from the game template)
  private const
    CGameDataVersion = 1;
    // increase CGameDataVersion it each time you add new properties to the game data files (in LoadFromStream/SaveToStream)

  var
    FLevel: int64;
    FUserPseudo: string;
    FScore: int64;
    function GetFileName: string;
    function GetPath: string;
    procedure SetLevel(const Value: int64);
    procedure SetPath(const Value: string);
    procedure SetScore(const Value: int64);
    procedure SetUserPseudo(const Value: string);
  protected
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

var
  LDefaultGameData: TGameData;

  { TScoreUpdatedMessage }

class procedure TScoreUpdatedMessage.Broadcast(const AScore: int64);
begin

end;

constructor TScoreUpdatedMessage.Create(const AScore: int64);
begin

end;

{ TLevelUpdatedMessage }

class procedure TLevelUpdatedMessage.Broadcast(const ALevel: int64);
begin

end;

constructor TLevelUpdatedMessage.Create(const ALevel: int64);
begin

end;

{ TGameData }

procedure TGameData.Clear;
begin

end;

procedure TGameData.ContinueGame;
begin

end;

constructor TGameData.Create;
begin

end;

class function TGameData.DefaultGameData: TGameData;
begin

end;

destructor TGameData.Destroy;
begin

  inherited;
end;

function TGameData.GetFileName: string;
begin

end;

function TGameData.GetPath: string;
begin

end;

procedure TGameData.LoadFromFile(const AFilePath: string);
begin

end;

procedure TGameData.LoadFromStream(const AStream: TStream);
begin

end;

procedure TGameData.SaveToFile(const AFilePath: string);
begin

end;

procedure TGameData.SaveToStream(const AStream: TStream);
begin

end;

procedure TGameData.SetLevel(const Value: int64);
begin
  FLevel := Value;
end;

procedure TGameData.SetPath(const Value: string);
begin

end;

procedure TGameData.SetScore(const Value: int64);
begin
  FScore := Value;
end;

procedure TGameData.SetUserPseudo(const Value: string);
begin
  FUserPseudo := Value;
end;

procedure TGameData.StartANewGame;
begin

end;

initialization

LDefaultGameData := nil;

finalization

LDefaultGameData.free;

end.
