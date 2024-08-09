/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Template
///
/// Copyright 2024 Patrick Pr�martin under AGPL 3.0 license.
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
/// File last update : 2024-08-08T21:52:40.000+02:00
/// Signature : 9e1b9bc81b6042a3eccadfd43d192c5a6e35fc55
/// ***************************************************************************
/// </summary>

unit uDMHelpBarManager;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, Gamolf.FMX.HelpBar;

type
  THelpBarManager = class(TDataModule)
    DGEFMXHelpBar1: TDGEFMXHelpBar;
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

  // TODO -opprem : corriger probl�me de parent sur le composant lorsqu'il n'est pas sur une fiche
  result := frmMain.DGEFMXHelpBar1;
end;

initialization

HelpBarManager := nil;

finalization

HelpBarManager.free;

end.
