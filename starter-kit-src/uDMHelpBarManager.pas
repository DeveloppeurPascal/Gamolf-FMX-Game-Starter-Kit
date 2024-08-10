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
/// File last update : 2024-08-09T20:14:22.000+02:00
/// Signature : ad9ce0661a3179cdb1ad7ef3cfcb8cdb82cd29e7
/// ***************************************************************************
/// </summary>

unit uDMHelpBarManager;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.SysUtils,
  System.Classes,
  FMX.Types,
  Gamolf.FMX.HelpBar;

type
  THelpBarManager = class(TDataModule)
  private
  public
    class function Current: TDGEFMXHelpBar;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  fMain;

var
  HelpBarManager: THelpBarManager;

  { THelpBarManager }

class function THelpBarManager.Current: TDGEFMXHelpBar;
begin
  // if not assigned(HelpBarManager) then
  // HelpBarManager := THelpBarManager.create(nil);
  // result := HelpBarManager.DGEFMXHelpBar1;

  // TODO -opprem : corriger problème de parent sur le composant lorsqu'il n'est pas sur une fiche
  // See https://github.com/DeveloppeurPascal/Delphi-Game-Engine/issues/208
  result := frmMain.DGEFMXHelpBar1;
end;

initialization

HelpBarManager := nil;

finalization

HelpBarManager.free;

end.
