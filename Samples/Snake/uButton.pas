unit uButton;

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
  _ButtonsAncestor,
  FMX.Objects,
  FMX.Effects;

type
  TTextButton = class(T__ButtonAncestor)
    rFocus: TRectangle;
    rUp: TRectangle;
    TextUp: TText;
    rDown: TRectangle;
    TextDown: TText;
    ShadowEffect1: TShadowEffect;
  private
  public
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}
{ TTextButton }

procedure TTextButton.Repaint;
begin
  inherited;
  rFocus.Visible := IsFocused;
  rDown.Visible := IsDown;
  rUp.Visible := not rDown.Visible;
  TextUp.Text := Text;
  TextDown.Text := Text;
end;

end.
