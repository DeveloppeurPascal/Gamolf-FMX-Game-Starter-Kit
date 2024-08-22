/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Starter Kit
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
/// File last update : 2024-08-21T11:43:38.000+02:00
/// Signature : 4e3fa8ef68f43bdfb563fe6096130ad7137b2b37
/// ***************************************************************************
/// </summary>

unit uSceneCredits;

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
  _ScenesAncestor,
  cDialogBackground,
  cShowMessage;

type
  TCreditsScene = class(T__SceneAncestor)
    ShowMessage1: TShowMessage;
    procedure ShowMessage1TextButton1Click(Sender: TObject);
  private
  protected
  public
    procedure ShowScene; override;
    procedure HideScene; override;
    procedure TranslateTexts(const Language: string); override;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  uConsts,
  uScene,
  uUIElements,
  uDMHelpBarManager,
  USVGInputPrompts,
  uTxtAboutDescription,
  uTxtAboutLicense;

procedure TCreditsScene.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TCreditsScene.ShowMessage1TextButton1Click(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TCreditsScene.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(ShowMessage1.TextButton1, nil, nil, nil, nil,
    true, true);

  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardSpace +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorAOutline +
    TSVGInputPrompts.Tag, 'Select');
end;

procedure TCreditsScene.TranslateTexts(const Language: string);
begin
  inherited;
  ShowMessage1.Text := GetTxtAboutDescription(Language) + slinebreak +
    slinebreak + GetTxtAboutLicense(Language) + slinebreak + slinebreak;
  ShowMessage1.ButtonText := 'Home';
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TCreditsScene;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Credits) then
    begin
      NewScene := TCreditsScene.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Credits, NewScene);
    end;
  end);

end.
