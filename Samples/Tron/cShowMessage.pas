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
/// File last update : 2024-08-21T11:41:42.000+02:00
/// Signature : 43ff0430bb39503a3e5a72cc123550e8eed1a168
/// ***************************************************************************
/// </summary>

unit cShowMessage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  cDialogBackground, FMX.Layouts, _ButtonsAncestor, cTextButton, FMX.Objects;

type
  TShowMessage = class(TDialogBackground)
    TextButton1: TTextButton;
    VertScrollBox1: TVertScrollBox;
    lButtons: TLayout;
    Text1: TText;
  private
    procedure SetButtonClick(const Value: TNotifyEvent);
    procedure SetButtonText(const Value: string);
    procedure SetText(const Value: String);
    function GetButtonClick: TNotifyEvent;
    function GetButtonText: string;
    function GetText: String;
  public
    property Text: String read GetText write SetText;
    property ButtonText: string read GetButtonText write SetButtonText;
    property ButtonClick: TNotifyEvent read GetButtonClick write SetButtonClick;
  end;

var
  ShowMessage: TShowMessage;

implementation

{$R *.fmx}
{ TDialogBackground1 }

function TShowMessage.GetButtonClick: TNotifyEvent;
begin
  result := TextButton1.OnClick;
end;

function TShowMessage.GetButtonText: string;
begin
  result := TextButton1.Text;
end;

function TShowMessage.GetText: String;
begin
  result := Text1.Text;
end;

procedure TShowMessage.SetButtonClick(const Value: TNotifyEvent);
begin
  TextButton1.OnClick := Value;
end;

procedure TShowMessage.SetButtonText(const Value: string);
begin
  TextButton1.Text := Value;
end;

procedure TShowMessage.SetText(const Value: String);
begin
  Text1.Text := Value;
end;

end.
