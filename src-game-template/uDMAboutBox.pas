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
/// File last update : 2024-08-09T20:35:10.000+02:00
/// Signature : ac0fcbca7a7e0109f16f7a09a818ac075e9e037b
/// ***************************************************************************
/// </summary>

unit uDMAboutBox;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.Messaging,
  System.SysUtils,
  System.Classes,
  FMX.Types,
  Olf.FMX.AboutDialog,
  Olf.FMX.AboutDialogForm;

type
  TAboutBox = class(TDataModule)
    OlfAboutDialog1: TOlfAboutDialog;
    procedure DataModuleCreate(Sender: TObject);
    procedure OlfAboutDialog1URLClick(const AURL: string);
    procedure DataModuleDestroy(Sender: TObject);
    function OlfAboutDialog1GetText(const ALang: TOlfAboutDialogLang;
      const ATxtID: TOlfAboutDialogTxtID): string;
  private
  protected
    procedure TranslateTexts(const Sender: TObject; const Msg: TMessage);
  public
    class function Current: TAboutBox;
    class procedure ShowModal;
    class function GetCaption: string;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses
  uDMAboutBoxLogoStorrage,
  uConsts,
  u_urlOpen,
  uTxtAboutDescription,
  uTxtAboutLicense,
  uTranslate;

{$R *.dfm}

var
  LAboutBox: TAboutBox;

  { TAboutBox }

class function TAboutBox.Current: TAboutBox;
begin
  if not assigned(LAboutBox) then
    LAboutBox := TAboutBox.create(nil);

  result := LAboutBox;
end;

procedure TAboutBox.DataModuleCreate(Sender: TObject);
var
  dm: TdmAboutBoxLogo;
begin
  OlfAboutDialog1.Titre := CAboutGameTitle;
  OlfAboutDialog1.VersionNumero := CAboutVersionNumber;
  OlfAboutDialog1.VersionDate := CAboutVersionDate;
  OlfAboutDialog1.Copyright := CAboutCopyright;
  OlfAboutDialog1.URL := CAboutGameURL;
  dm := TdmAboutBoxLogo.create(self);
  OlfAboutDialog1.Images := dm.imgLogo;
  OlfAboutDialog1.ImageIndex := 0;
  OlfAboutDialog1.ReplaceMainFormCaption := true;

  TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
    TranslateTexts);
end;

procedure TAboutBox.DataModuleDestroy(Sender: TObject);
begin
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    TranslateTexts, true);
end;

class function TAboutBox.GetCaption: string;
begin
  // TODO -opprem : � remplacer par mieux un jour, cf https://github.com/DeveloppeurPascal/AboutDialog-Delphi-Component/issues/59
  result := 'About ' + Current.OlfAboutDialog1.Titre;
end;

function TAboutBox.OlfAboutDialog1GetText(const ALang: TOlfAboutDialogLang;
  const ATxtID: TOlfAboutDialogTxtID): string;
begin
  // If you want to manage other languages than TOlfAboutDialogLang enumeration
  // for the about box, you'll have to manage your translations here:
  case ATxtID of
    TOlfAboutDialogTxtID.About:
      // used as "About "+GameTitle for the about box caption
      // TODO -opprem : compl�ter un exemple avec la langue actuelle du projet
      result := '';
    TOlfAboutDialogTxtID.Version:
      // used as "Version "+VersionNumber in the about box
      result := '';
    TOlfAboutDialogTxtID.Date: // used as "Date "+VersionNumber in the about box
      result := '';
    TOlfAboutDialogTxtID.CloseButton: // used as the about box close button text
      result := '';
    TOlfAboutDialogTxtID.TitleText:
      result := CAboutGameTitle;
    // change it if you want to translate your game title
  end;
end;

procedure TAboutBox.OlfAboutDialog1URLClick(const AURL: string);
begin
  url_Open_In_Browser(AURL);
end;

class procedure TAboutBox.ShowModal;
begin
  Current.OlfAboutDialog1.Execute;
end;

procedure TAboutBox.TranslateTexts(const Sender: TObject; const Msg: TMessage);
var
  ttm: TTranslateTextsMessage;
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
  begin
    ttm := Msg as TTranslateTextsMessage;
    if ttm.Language = 'en' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.EN
    else if ttm.Language = 'fr' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.FR
    else if ttm.Language = 'it' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.IT
    else if ttm.Language = 'pt' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.PT
    else if ttm.Language = 'sp' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.SP
    else if ttm.Language = 'de' then
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.DE
    else
      OlfAboutDialog1.Langue := TOlfAboutDialogLang.Manual;
    OlfAboutDialog1.Description.Text := GetTxtAboutDescription(ttm.Language);
    OlfAboutDialog1.Licence.Text := GetTxtAboutLicense(ttm.Language);
  end;
end;

initialization

LAboutBox := nil;
TThread.ForceQueue(nil,
  procedure
  begin
    LAboutBox := TAboutBox.Current;
  end);

finalization

LAboutBox.free;

end.