(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit

  Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  The "Gamolf FMX Game Starter Kit" is both a "technical" example of a video
  game developed in Delphi with everything you need inside and a reusable
  project template you can customize for your own games.

  The files provided are fully functional. Numerous comments are included in
  the sources to explain how they work and what you need to copy, override
  or customize to make video games without starting from scratch.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://fmxgamestarterkit.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit

  ***************************************************************************
  File last update : 2025-02-09T11:12:49.095+01:00
  Signature : 63c0486c870482a5d6634d1ca076db93eb0db434
  ***************************************************************************
*)

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
  FMX.forms,
  fMain;

var
  HelpBarManager: THelpBarManager;

  { THelpBarManager }

class function THelpBarManager.Current: TDGEFMXHelpBar;
begin
  // if not assigned(HelpBarManager) then
  // HelpBarManager := THelpBarManager.create(nil);
  // result := HelpBarManager.DGEFMXHelpBar1;

  // TODO -oDeveloppeurPascal -cCheckIssue : corriger problème de parent sur le composant lorsqu'il n'est pas sur une fiche
  // See https://github.com/DeveloppeurPascal/Delphi-Game-Engine/issues/208
  result := (application.mainform as tfrmmain).DGEFMXHelpBar1;
end;

initialization

HelpBarManager := nil;

finalization

HelpBarManager.free;

end.
