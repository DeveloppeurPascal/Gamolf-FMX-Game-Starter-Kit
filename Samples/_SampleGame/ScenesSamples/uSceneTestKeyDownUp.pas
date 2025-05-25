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
  File last update : 2025-05-08T20:36:27.107+02:00
  Signature : 99bbc673f057d5caf4b38417451b8f60224c2de1
  ***************************************************************************
*)

unit uSceneTestKeyDownUp;

interface

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
  _ScenesAncestor;

type
  TSceneTestKeyDownUp = class(T__SceneAncestor)
    procedure FrameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure FrameKeyUp(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);
  private
  public
    procedure ShowScene; override;
    procedure HideScene; override;
  end;

implementation

{$R *.fmx}

uses
  uScene,
  uConsts,
  uUIElements;

procedure TSceneTestKeyDownUp.FrameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
  showmessage('keydown : ' + KeyChar);
end;

procedure TSceneTestKeyDownUp.FrameKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
  showmessage('keyup : ' + KeyChar);
end;

procedure TSceneTestKeyDownUp.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TSceneTestKeyDownUp.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.addquit;
end;

initialization

TScene.RegisterScene<TSceneTestKeyDownUp>(TSceneType.TestKeyDown);

end.
