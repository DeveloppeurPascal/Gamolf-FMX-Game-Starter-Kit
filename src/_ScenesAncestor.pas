﻿(* C2PP
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
  Signature : 46dc4e3b5c7e85baf25d411c78c922e5fa509d92
  ***************************************************************************
*)

unit _ScenesAncestor;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.
//
// All scenes in your game must inherits from this class or its descendants.

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Messaging,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls;

type
  /// <summary>
  /// Should be used as your scenes ancestor.
  /// </summary>
  T__SceneAncestor = class(TFrame)
  private
    FHasCalledBeforeFirstShowScene: boolean;
  protected
    procedure DoTranslateTexts(const Sender: TObject; const Msg: TMessage);
  public
    /// <summary>
    /// Contains scene initialization called only one time (before the first
    /// ShowScene, after instance construction)
    /// </summary>
    procedure BeforeFirstShowScene; virtual;
    /// <summary>
    /// Contains scene initialization. It's called each time the scene is shown.
    /// </summary>
    procedure ShowScene; virtual;
    /// <summary>
    /// Contains scene finalization. It's called each time the scene is hidden.
    /// </summary>
    procedure HideScene; virtual;
    /// <summary>
    /// Contains scene finalization called only one time (during instance
    /// destruction)
    /// </summary>
    procedure AfterLastHideScene; virtual;
    /// <summary>
    /// This method is called each time a global translation broadcast is sent
    /// with current language as argument.
    /// </summary>
    procedure TranslateTexts(const Language: string); virtual;
    /// <summary>
    /// Returns an instance of this class
    /// </summary>
    constructor Create(AOwner: TComponent); override;
    /// <summary>
    /// internal use, call it only if you override it in a descendant
    /// </summary>
    destructor Destroy; override;
    /// <summary>
    /// internal use, call it only if you override it in a descendant
    /// </summary>
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  uTranslate,
  uConfig,
  uUIElements,
  uDMHelpBarManager;

{ TSceneAncestor }

procedure T__SceneAncestor.AfterConstruction;
begin
  inherited;
  name := '';
  Visible := false;
end;

procedure T__SceneAncestor.AfterLastHideScene;
begin
  // nothing to do here at this level
end;

procedure T__SceneAncestor.BeforeFirstShowScene;
begin
  // nothing to do here at this level
end;

constructor T__SceneAncestor.Create(AOwner: TComponent);
begin
  inherited;
  FHasCalledBeforeFirstShowScene := false;
end;

destructor T__SceneAncestor.Destroy;
begin
  AfterLastHideScene;
  inherited;
end;

procedure T__SceneAncestor.DoTranslateTexts(const Sender: TObject;
  const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
    TranslateTexts((Msg as TTranslateTextsMessage).Language);
end;

procedure T__SceneAncestor.HideScene;
begin
  Visible := false;

  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    DoTranslateTexts, true);

  if TUIItemsList.Current.Focused <> nil then
    TUIItemsList.Current.Focused.ResetFocus;
  // TODO -oDeveloppeurPascal -cCheckIssue : à retirer une fois ce ticket clôturé https://github.com/DeveloppeurPascal/Delphi-Game-Engine/issues/212
  TUIItemsList.Current.RemoveLayout;

  THelpBarManager.Current.CloseHelpBar;
end;

procedure T__SceneAncestor.ShowScene;
begin
  if not FHasCalledBeforeFirstShowScene then
  begin
    BeforeFirstShowScene;
    FHasCalledBeforeFirstShowScene := true;
  end;

  TranslateTexts(tconfig.Current.Language);
  TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
    DoTranslateTexts);

  THelpBarManager.Current.Clear;

  TUIItemsList.Current.NewLayout;

  Align := TAlignLayout.Contents;
  Visible := true;
  BringToFront;
end;

procedure T__SceneAncestor.TranslateTexts(const Language: string);
begin
  // nothing to do here at this level
end;

end.
