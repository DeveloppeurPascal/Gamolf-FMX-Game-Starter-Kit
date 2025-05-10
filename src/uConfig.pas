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
/// File last update : 2025-05-10T15:56:44.000+02:00
/// Signature : fe8fa39bf8c8c48594fd00ed672eca359dc339a6
/// ***************************************************************************
/// </summary>

unit uConfig;

interface

// To add your settings in the standard settings file,
// inherits from TConfig and use GetParams() method to Get/Set your values.
//
// It's recommanded to add your game name as a prefix of keys names
// in the settings file.

uses
  Olf.RTL.Params;

type
  TConfig = class
  private
    FParams: TParamsFile;
    function GetBackgroundMusic: boolean;
    function GetBackgroundMusicVolume: integer;
    procedure SetBackgroundMusic(const Value: boolean);
    procedure SetBackgroundMusicVolume(const Value: integer);
    function GetSoundEffects: boolean;
    function GetSoundEffectsVolume: integer;
    procedure SetSoundEffects(const Value: boolean);
    procedure SetSoundEffectsVolume(const Value: integer);
    function GetInterfaceTactileOnOff: boolean;
    procedure SetInterfaceTactileOnOff(const Value: boolean);
    function GetLanguage: string;
    procedure SetLanguage(const Value: string);
  protected
    /// <summary>
    /// Use this method to access to the settings storrage file/class in
    /// TConfig descendants.
    /// </summary>
    function GetParams: TParamsFile;
  public
    /// <summary>
    /// Start or stop the background music
    /// </summary>
    property BackgroundMusicOnOff: boolean read GetBackgroundMusic
      write SetBackgroundMusic;
    /// <summary>
    /// Background music volume between 0 and 100
    /// </summary>
    property BackgroundMusicVolume: integer read GetBackgroundMusicVolume
      write SetBackgroundMusicVolume;
    /// <summary>
    /// Allow the sound effects
    /// </summary>
    property SoundEffectsOnOff: boolean read GetSoundEffects
      write SetSoundEffects;
    /// <summary>
    /// Sound effects volume between 0 and 100
    /// </summary>
    property SoundEffectsVolume: integer read GetSoundEffectsVolume
      write SetSoundEffectsVolume;
    /// <summary>
    /// Show virtual controls on screen (for a virtual gamepad or other things
    /// on iOS/Android or other screens with touch capacity)
    /// </summary>
    property VirtualControlsOnOff: boolean read GetInterfaceTactileOnOff
      write SetInterfaceTactileOnOff;
    /// <summary>
    /// The language you should use on screen and messages
    /// </summary>
    /// <remarks>
    /// By default it's the operating system language
    /// or the CDefaultLanguage constant if it's not available
    /// </remarks>
    property Language: string read GetLanguage write SetLanguage;
    /// <summary>
    /// Return the instance to TConfig singleton
    /// </summary>
    class function Current: TConfig; Virtual;
    /// <summary>
    /// Returns current path of the config file (directory+filename)
    /// </summary>
    function GetPath: string;
    /// <summary>
    /// Don't use the constructor, it's used only by the Current() method
    /// </summary>
    constructor Create;
    /// <summary>
    /// Don't use the destructor, it's for internal use only
    /// </summary>
    destructor Destroy; override;
    /// <summary>
    /// Use it to delay the saving of parameters if you have more than one
    /// to update at the same time.
    /// </summary>
    procedure BeginUpdate; virtual;
    /// <summary>
    /// Use the EndUpdate to Save pending changes since a BeginUpdate.
    /// </summary>
    procedure EndUpdate; virtual;
  end;

implementation

uses
  System.Classes,
  System.Types,
  System.IOUtils,
  System.SysUtils,
  FMX.Platform,
  Olf.RTL.CryptDecrypt,
  Olf.RTL.Language,
  uConsts,
  uTranslate;

var
  ConfigInstance: TConfig;

  { TConfig }

procedure TConfig.BeginUpdate;
begin
  FParams.BeginUpdate;
end;

constructor TConfig.Create;
begin
  FParams := TParamsFile.Create;
  FParams.InitDefaultFileNameV2(CEditorFolderName, CGameFolderName, false);
{$IF Defined(RELEASE)}
  FParams.onCryptProc := function(Const AParams: string): TStream
    var
      ParStream: TStringStream;
    begin
      ParStream := TStringStream.Create(AParams);
      try
        result := TOlfCryptDecrypt.XORCrypt(ParStream, GConfigXORKey);
      finally
        ParStream.free;
      end;
    end;
  FParams.onDecryptProc := function(Const AStream: TStream): string
    var
      Stream: TStream;
      StringStream: TStringStream;
    begin
      result := '';
      Stream := TOlfCryptDecrypt.XORdeCrypt(AStream, GConfigXORKey);
      try
        if assigned(Stream) and (Stream.Size > 0) then
        begin
          StringStream := TStringStream.Create;
          try
            Stream.Position := 0;
            StringStream.CopyFrom(Stream);
            result := StringStream.DataString;
          finally
            StringStream.free;
          end;
        end;
      finally
        Stream.free;
      end;
    end;
{$ENDIF}
  FParams.Load;
end;

class function TConfig.Current: TConfig;
begin
  if not assigned(ConfigInstance) then
  begin
    ConfigInstance := TConfig.Create;
  end;
  result := ConfigInstance;
end;

destructor TConfig.Destroy;
begin
  FParams.free;
  inherited;
end;

procedure TConfig.EndUpdate;
begin
  FParams.EndUpdate;
end;

function TConfig.GetBackgroundMusic: boolean;
begin
  result := FParams.getValue('MusicOnOff', true);
end;

function TConfig.GetBackgroundMusicVolume: integer;
begin
  result := FParams.getValue('MusicVol', 100);
end;

function TConfig.GetInterfaceTactileOnOff: boolean;
var
  DefaultValue: boolean;
  svc: IFMXDeviceService;
begin
  if (TPlatformServices.Current.SupportsPlatformService(IFMXDeviceService, svc))
  then
    DefaultValue := (TDeviceFeature.HasTouchScreen in svc.GetFeatures)
  else
{$IF Defined(iOS) or Defined(ANDROID)}
    DefaultValue := true;
{$ELSE}
    DefaultValue := false;
{$ENDIF}
  result := tParams.getValue('TouchOnOff', DefaultValue);
end;

function TConfig.GetLanguage: string;
var
  lng: string;
begin
  lng := GetCurrentLanguageISOCode;
  if lng.IsEmpty then
    lng := CDefaultLanguage;

  result := FParams.getValue('Language', lng);
end;

function TConfig.GetParams: TParamsFile;
begin
  result := FParams;
end;

function TConfig.GetPath: string;
begin
  result := FParams.getFilePath;
end;

function TConfig.GetSoundEffects: boolean;
begin
  result := FParams.getValue('SoundsOnOff', true);
end;

function TConfig.GetSoundEffectsVolume: integer;
begin
  result := FParams.getValue('SoundsVol', 100);
end;

procedure TConfig.SetBackgroundMusic(const Value: boolean);
begin
  FParams.setValue('MusicOnOff', Value);
  FParams.Save;
end;

procedure TConfig.SetBackgroundMusicVolume(const Value: integer);
begin
  FParams.setValue('MusicVol', Value);
  FParams.Save;
end;

procedure TConfig.SetInterfaceTactileOnOff(const Value: boolean);
begin
  FParams.setValue('TouchOnOff', Value);
  FParams.Save;
end;

procedure TConfig.SetLanguage(const Value: string);
var
  lng: string;
begin
  lng := Value.tolower;
  if lng.IsEmpty then
    lng := CDefaultLanguage;

  FParams.setValue('Language', Value);
  FParams.Save;
  TTranslateTextsMessage.Broadcast(Value);
end;

procedure TConfig.SetSoundEffects(const Value: boolean);
begin
  FParams.setValue('SoundsOnOff', Value);
  FParams.Save;
end;

procedure TConfig.SetSoundEffectsVolume(const Value: integer);
begin
  FParams.setValue('SoundsVol', Value);
  FParams.Save;
end;

initialization

ConfigInstance := nil;

finalization

ConfigInstance.free;

end.
