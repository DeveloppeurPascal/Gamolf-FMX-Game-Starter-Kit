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
