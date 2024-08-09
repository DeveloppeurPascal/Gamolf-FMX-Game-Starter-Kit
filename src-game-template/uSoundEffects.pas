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
/// File last update : 2024-08-09T20:05:08.000+02:00
/// Signature : 217e9571c012c3961d4b3809c25289bbcedf2263
/// ***************************************************************************
/// </summary>

unit uSoundEffects;

interface

{$MESSAGE WARN 'Save uSoundEffects.pas in your game folder and customize its sounds list and loaded files. Don''t change the template version if you want to be able to update it.'}
// TODO : Save uSoundEffects.pas in your game folder and customize its sounds list and loaded files. Don't change the template version if you want to be able to update it.

type
{$SCOPEDENUMS ON}
  TSoundEffectType = (None (* Must exist ! *) , Demo);
  // TODO : reference your sounds types
  // TODO : add the files to folder _PRIVATE/sounds for Windows DEBUG (or change the folder in RegisterSounds())
  // TODO : add the files to Project/Deployment for each supported platform

  TSoundEffects = class;
  TSoundEffectsClass = class of TSoundEffects;

  TSoundEffects = class
  private
  protected
    class procedure RegisterSounds;
  public
    class procedure Play(const Sound: TSoundEffectType);
    class procedure StopAll;
    class procedure Volume(AVolume: integer);
    class function Current: TSoundEffectsClass;
  end;

implementation

{ TSoundEffects }

uses
  uConfig,
  Gamolf.FMX.MusicLoop,
  System.SysUtils,
  System.IOUtils;

class procedure TSoundEffects.StopAll;
begin
  TSoundList.Current.MuteAll;
end;

class function TSoundEffects.Current: TSoundEffectsClass;
begin
  result := TSoundEffects;
end;

class procedure TSoundEffects.Play(const Sound: TSoundEffectType);
begin
  if tconfig.Current.SoundEffectsOnOff then
    TSoundList.Current.Play(ord(Sound));
end;

class procedure TSoundEffects.RegisterSounds;
var
  Sound: TSoundEffectType;
  Folder, FileName, FilePath: string;
begin
{$IF defined(ANDROID)}
  // deploy in .\assets\internal\
  Folder := tpath.GetDocumentsPath;
{$ELSEIF defined(MSWINDOWS)}
  // deploy in .\
{$IFDEF DEBUG}
  Folder := '..\..\..\_PRIVATE\sounds\';
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
  for Sound := low(TSoundEffectType) to high(TSoundEffectType) do
  begin
    case Sound of
      TSoundEffectType.None:
        FileName := '';
      TSoundEffectType.Demo:
        FileName := 'DuckyOuch.wav';
      // TODO : Update the list of sound effects files
    else
      raise Exception.Create('Missing a sound effect !');
    end;
    if (not FileName.isempty) then
    begin
      FilePath := tpath.combine(Folder, FileName);
      if tfile.exists(FilePath) then
        TSoundList.Current.add(ord(Sound), FilePath);
    end;
  end;
  TSoundList.Current.Volume := tconfig.Current.SoundEffectsVolume;
end;

class procedure TSoundEffects.Volume(AVolume: integer);
begin
  if AVolume in [0 .. 100] then
  begin
    TSoundList.Current.Volume := AVolume;
    if tconfig.Current.SoundEffectsVolume <> AVolume then
      tconfig.Current.SoundEffectsVolume := AVolume;
  end;

end;

initialization

TSoundEffects.RegisterSounds;

end.
