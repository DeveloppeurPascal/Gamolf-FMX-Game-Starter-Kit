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
/// File last update : 2025-01-13T20:37:32.000+01:00
/// Signature : 2101c40a4ca5ce23da06521c618b4a57ea57b2dc
/// ***************************************************************************
/// </summary>

unit uBackgroundMusic;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

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
    function isOn: Boolean;
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
  Folder := CDefaultBackgroundMusicPath;
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

function TBackgroundMusic.isOn: Boolean;
begin
  result := TMusicLoop.Current.IsPlaying;
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
