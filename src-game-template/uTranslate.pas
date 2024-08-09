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
/// File last update : 2024-08-09T20:31:52.000+02:00
/// Signature : 2a63fc094ceafe239125b9b63cab89520c3baf40
/// ***************************************************************************
/// </summary>

unit uTranslate;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.Messaging;

type
  TTranslateTextsMessage = class(TMessage)
  private
    FLanguage: string;
  protected
  public
    property Language: string read FLanguage;
    constructor Create(const ALanguage: string);
    /// <summary>
    /// Use this method to translate all texts in your game
    /// </summary>
    class procedure Broadcast(const ALanguage: string);
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  uConfig;

{ TTranslateTextsMessage }

class procedure TTranslateTextsMessage.Broadcast(const ALanguage: string);
var
  LLanguage: string;
begin
  LLanguage := ALanguage;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TTranslateTextsMessage.Create(LLanguage));
    end);
end;

constructor TTranslateTextsMessage.Create(const ALanguage: string);
begin
  inherited Create;
  FLanguage := ALanguage.ToLower;
  if FLanguage.IsEmpty then
    FLanguage := tconfig.Current.Language;
end;

procedure init;
begin
  TTranslateTextsMessage.Broadcast(tconfig.Current.Language);
end;

initialization

// I know, it's ugly, but with this I'm sure to execute the init after all
// "ForceQueue()" sent during program initialization, after the program has
// started and shown it's window.

tthread.ForceQueue(nil,
  procedure
  begin
    tthread.ForceQueue(nil,
      procedure
      begin
        init;
      end);
  end);

end.
