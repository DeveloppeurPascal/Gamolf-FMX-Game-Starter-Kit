unit uBackgroundMusic;

interface

uses
  System.Messaging;

type
  TBackgroundMusicStatusMessage = class(TMessage)
  private
    FPlaying: Boolean;
  protected
  public
    property Playing: Boolean read FPlaying;
    constructor Create(const APlaying: Boolean);
    class procedure Broadcast(const APlaying: Boolean);
  end;

  TBackgroundMusic = class
  private
    class var FCurrent: TBackgroundMusic;
    class function GetCurrent: TBackgroundMusic; static;
  protected
  public
    class property Current: TBackgroundMusic read GetCurrent;
    constructor Create;
    procedure OnOff(aOn: Boolean);
    procedure Volume(AVolume: integer);
    function HasAValidBackgroundMusicFile: Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  uConfig,
  Gamolf.FMX.MusicLoop,
  System.Classes,
  uConsts;

{ TBackgroundMusic }

constructor TBackgroundMusic.Create;
var
  Folder: string;
  MusicFilePath: string;
begin
  inherited;

{$IF defined(ANDROID)}
  // deploy in .\assets\internal\
  Folder := System.IOUtils.tpath.GetDocumentsPath;
{$ELSEIF defined(MSWINDOWS)}
  // deploy in ;\
{$IFDEF DEBUG}
  Folder := '..\..\..\_PRIVATE\musics\';
{$ELSE}
  Folder := extractfilepath(paramstr(0));
{$ENDIF}
{$ELSEIF defined(IOS)}
  // deploy in .\
  Folder := extractfilepath(paramstr(0));
{$ELSEIF defined(MACOS)}
  // deploy in Contents\MacOS
  Folder := extractfilepath(paramstr(0));
{$ELSEIF Defined(LINUX)}
  Folder := extractfilepath(paramstr(0));
{$ELSE}
{$MESSAGE FATAL 'OS non supporté'}
{$ENDIF}
  MusicFilePath := tpath.combine(Folder, CBackgroundMusicFileName);

  if (not CBackgroundMusicFileName.IsEmpty) and tfile.Exists(MusicFilePath) then
    TMusicLoop.Current.Load(MusicFilePath);

  Volume(TConfig.Current.BackgroundMusicVolume);
end;

class function TBackgroundMusic.GetCurrent: TBackgroundMusic;
begin
  if not assigned(FCurrent) then
    FCurrent := TBackgroundMusic.Create;

  result := FCurrent;
end;

function TBackgroundMusic.HasAValidBackgroundMusicFile: Boolean;
var
  Folder, MusicFilePath: string;
begin
{$IF defined(ANDROID)}
  // deploy in .\assets\internal\
  Folder := System.IOUtils.tpath.GetDocumentsPath;
{$ELSEIF defined(MSWINDOWS)}
  // deploy in .\
{$IFDEF DEBUG}
  Folder := '..\..\..\_PRIVATE\musics\';
{$ELSE}
  Folder := extractfilepath(paramstr(0));
{$ENDIF}
{$ELSEIF defined(IOS)}
  // deploy in .\
  Folder := extractfilepath(paramstr(0));
{$ELSEIF defined(MACOS)}
  // deploy in Contents\MacOS
  Folder := extractfilepath(paramstr(0));
{$ELSEIF Defined(LINUX)}
  // deploy in .\
  Folder := extractfilepath(paramstr(0));
{$ELSE}
{$MESSAGE FATAL 'OS non supporté'}
{$ENDIF}
  MusicFilePath := tpath.combine(Folder, CBackgroundMusicFileName);

  result := (not CBackgroundMusicFileName.IsEmpty) and
    tfile.Exists(MusicFilePath);
end;

procedure TBackgroundMusic.OnOff(aOn: Boolean);
begin
  if aOn then
    TMusicLoop.Current.Play
  else
    TMusicLoop.Current.Stop;

  if aOn <> TConfig.Current.BackgroundMusicOnOff then
    TConfig.Current.BackgroundMusicOnOff := aOn;

  TBackgroundMusicStatusMessage.Broadcast(aOn)
end;

procedure TBackgroundMusic.Volume(AVolume: integer);
begin
  if AVolume in [0 .. 100] then
  begin
    TMusicLoop.Current.Volume := AVolume;
    if TConfig.Current.BackgroundMusicVolume <> AVolume then
      TConfig.Current.BackgroundMusicVolume := AVolume;
  end;
end;

{ TBackgroundMusicStatusMessage }

class procedure TBackgroundMusicStatusMessage.Broadcast(const APlaying
  : Boolean);
var
  LPlaying: Boolean;
begin
  LPlaying := APlaying;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TBackgroundMusicStatusMessage.Create(LPlaying));
    end);
end;

constructor TBackgroundMusicStatusMessage.Create(const APlaying: Boolean);
begin
  inherited Create;
  FPlaying := APlaying;
end;

initialization

TBackgroundMusic.FCurrent := nil;

finalization

TBackgroundMusic.FCurrent.free;

end.
