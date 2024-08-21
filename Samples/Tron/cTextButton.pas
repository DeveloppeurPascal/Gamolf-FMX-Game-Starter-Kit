unit cTextButton;

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
  FMX.Objects;

type
  TTextButton = class(T__ButtonAncestor)
    imgUp: TImage;
    imgDown: TImage;
    imgUpFocused: TImage;
    txtUpFocused: TText;
    txtUp: TText;
    txtDown: TText;
    procedure imgUpFocusedResized(Sender: TObject);
    procedure imgUpResized(Sender: TObject);
    procedure imgDownResized(Sender: TObject);
  private
  public
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}

uses
  uSVGBitmapManager_UIPack,
  USVGUIPack;
{ TTextButton }

procedure TTextButton.imgDownResized(Sender: TObject);
begin
  if (imgDown.Width < 1) or (imgDown.Height < 1) then
    exit;

  imgDown.Bitmap.Assign(getBitmapFromSVG(TSVGUIPackIndex.ButtonRectangleLine,
    imgDown.Width, imgDown.Height, imgDown.Bitmap.BitmapScale));
end;

procedure TTextButton.imgUpFocusedResized(Sender: TObject);
begin
  if (imgUpFocused.Width < 1) or (imgUpFocused.Height < 1) then
    exit;

  imgUpFocused.Bitmap.Assign
    (getBitmapFromSVG(TSVGUIPackIndex.ButtonRectangleDepthBorder,
    imgUpFocused.Width, imgUpFocused.Height, imgUpFocused.Bitmap.BitmapScale));
end;

procedure TTextButton.imgUpResized(Sender: TObject);
begin
  if (imgUp.Width < 1) or (imgUp.Height < 1) then
    exit;

  imgUp.Bitmap.Assign(getBitmapFromSVG(TSVGUIPackIndex.ButtonRectangleDepthLine,
    imgUp.Width, imgUp.Height, imgUp.Bitmap.BitmapScale));
end;

procedure TTextButton.Repaint;
begin
  imgUpFocused.Visible := IsFocused and isup;
  imgUp.Visible := isup and (not IsFocused);
  imgDown.Visible := IsDown;
  if not text.IsEmpty then
  begin
    txtUpFocused.text := text;
    txtUp.text := text;
    txtDown.text := text;
  end;
end;

end.
