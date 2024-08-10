/// <summary>
/// ***************************************************************************
///
/// Make games in Delphi (2024 edition) - Dev Days of Summer 2024
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
/// Samples projects for the "Make games in Delphi (2024 Edition)" talk at
/// <Dev Days of Summer> 2024 online conference.
///
/// The projects are based on the "Gamolf FMX Game Template" you can find at
/// https://gametemplate.developpeur-pascal.fr/
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://serialstreameur.fr/make-games-in-delphi-2024-edition.html
///
/// Project site :
/// https://github.com/DeveloppeurPascal/DevDaysOfSummer2024-MakeGamesInDelphi
///
/// ***************************************************************************
/// File last update : 2024-08-09T23:59:48.000+02:00
/// Signature : c62906edb264afe47fb85e02786bdff71d4ff236
/// ***************************************************************************
/// </summary>

unit _ButtonsAncestor;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Forms,
  System.Messaging,
  uUIElements;

type
  T__ButtonAncestor = class(TFrame, IUIControl)
    procedure FrameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FrameMouseLeave(Sender: TObject);
  private
    FIsFocused: boolean;
    FIsDown: boolean;
    FText: string;
    procedure SetIsDown(const Value: boolean);
    procedure SetIsFocused(const Value: boolean);
    procedure SetText(const Value: string);
  protected
    procedure DoTranslateTexts(const Sender: TObject; const Msg: TMessage);
  public
    property IsFocused: boolean read FIsFocused write SetIsFocused;
    property IsDown: boolean read FIsDown write SetIsDown;
    property Text: string read FText write SetText;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    constructor Create(AOwner: TComponent); override;
    procedure TranslateTexts(const Language: string); virtual;
    procedure Click; override;
    procedure SetFocus; virtual;
    procedure ResetFocus; virtual;
    procedure Repaint; virtual; abstract;
  end;

implementation

{$R *.fmx}

uses
  uConfig,
  uTranslate;

{ TcadButton }

procedure T__ButtonAncestor.AfterConstruction;
begin
  inherited;
  tthread.ForceQueue(nil,
    procedure
    begin
      TranslateTexts(tconfig.Current.Language);
      TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
        DoTranslateTexts);
      Repaint;
    end);
end;

procedure T__ButtonAncestor.BeforeDestruction;
begin
  inherited;
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    DoTranslateTexts, true);
end;

procedure T__ButtonAncestor.Click;
begin
  IsDown := true;
  IsFocused := true;
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(50);
      tthread.queue(nil,
        procedure
        begin
          if not assigned(self) then
            exit;

          IsDown := false;

          inherited;
        end);
    end).Start;
end;

constructor T__ButtonAncestor.Create(AOwner: TComponent);
begin
  inherited;
  FIsFocused := false;
  FIsDown := false;
end;

procedure T__ButtonAncestor.DoTranslateTexts(const Sender: TObject;
const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
    TranslateTexts((Msg as TTranslateTextsMessage).Language);
end;

procedure T__ButtonAncestor.FrameMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  IsDown := true;
end;

procedure T__ButtonAncestor.FrameMouseLeave(Sender: TObject);
begin
  IsDown := false;
end;

procedure T__ButtonAncestor.ResetFocus;
begin
  IsFocused := false;
end;

procedure T__ButtonAncestor.SetFocus;
begin
  IsFocused := true;
end;

procedure T__ButtonAncestor.SetIsDown(const Value: boolean);
begin
  FIsDown := Value;
  Repaint;
end;

procedure T__ButtonAncestor.SetIsFocused(const Value: boolean);
begin
  FIsFocused := Value;
  Repaint;
end;

procedure T__ButtonAncestor.SetText(const Value: string);
begin
  FText := Value;
  Repaint;
end;

procedure T__ButtonAncestor.TranslateTexts(const Language: string);
begin
  // nothing to do here at this level
end;

end.
