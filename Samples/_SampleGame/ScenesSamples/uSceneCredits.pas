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
  File last update : 2025-05-08T20:36:27.087+02:00
  Signature : c313d0c32b3db9b27c7fe666864f6134bce71c5f
  ***************************************************************************
*)

unit uSceneCredits;

interface

{$MESSAGE WARN 'If this scene interest you save this file in your project folder and customize the copy. Don''t change the template version if you want to be able to update it.'}
// TODO : If this scene interest you save this file in your project folder and customize the copy. Don''t change the template version if you want to be able to update it.
// TODO : If you don't want it in your project remove the unit from your project

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  _ScenesAncestor,
  FMX.Controls.Presentation,
  FMX.Layouts;

type
  TSceneCredits = class(T__SceneAncestor)
    Label1: TLabel;
    Label2: TLabel;
    ScrollBox1: TScrollBox;
    btnBack: TButton;
    procedure btnBackClick(Sender: TObject);
  private
  protected
  public
    procedure ShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  uDMAboutBox,
  uUIElements,
  USVGInputPrompts,
  uDMHelpBarManager;

{ TSceneCredits }

procedure TSceneCredits.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TSceneCredits.ShowScene;
begin
  inherited;

  TUIItemsList.Current.AddControl(btnBack, nil, nil, nil, nil, true, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(ord(TSVGInputPromptsIndex.KeyboardEscape),
    ord(TSVGInputPromptsIndex.SteamButtonColorXOutline), 'Back');

  Label2.Text := TAboutBox.Current.OlfAboutDialog1.Titre + slinebreak +
    TAboutBox.Current.OlfAboutDialog1.GetVersionDate + slinebreak + '(c) ' +
    TAboutBox.Current.OlfAboutDialog1.Copyright + slinebreak + slinebreak +
    TAboutBox.Current.OlfAboutDialog1.Description.Text + slinebreak + slinebreak
    + TAboutBox.Current.OlfAboutDialog1.Licence.Text + slinebreak + slinebreak;
end;

initialization

tscene.RegisterScene<TSceneCredits>(TSceneType.Credits);

end.
