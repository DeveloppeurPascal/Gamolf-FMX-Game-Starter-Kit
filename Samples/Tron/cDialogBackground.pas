unit cDialogBackground;

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
  FMX.Objects,
  FMX.Layouts;

type
  TDialogBackground = class(TFrame)
    lBackground: TLayout;
    rBackgroundHeader: TRectangle;
    rBackgroundFooter: TRectangle;
    rBackgroundContent: TRectangle;
    Image1: TImage;
    lHeader: TLayout;
    lFooter: TLayout;
    lContent: TLayout;
    rBackgroundContentLeft: TRectangle;
    rBackgroundContentRight: TRectangle;
    rBackgroundFooterLeft: TRectangle;
    rBackgroundFooterRight: TRectangle;
    rBackgroundHeaderLeft: TRectangle;
    rBackgroundHeaderRight: TRectangle;
    procedure imgContentResized(Sender: TObject);
  private
    FInCreate: boolean;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.fmx}

uses
  USVGUIPack,
  uSVGBitmapManager_UIPack;

constructor TDialogBackground.Create(AOwner: TComponent);
begin
  FInCreate := true;
  inherited;
  tthread.ForceQueue(nil,
    procedure
    begin
      FInCreate := false;
      imgContentResized(self);
    end);
end;

procedure TDialogBackground.imgContentResized(Sender: TObject);
var
  bmp: TBitmap;
  BmpScale: single;
begin
  if FInCreate then
    exit;

  BmpScale := Image1.Bitmap.BitmapScale;

  bmp := getBitmapFromSVG(TSVGUIPackIndex.ButtonRectangleFlat, 192, 64,
    BmpScale);

  rBackgroundHeaderLeft.Fill.Bitmap.Bitmap.SetSize(round(10 * BmpScale),
    round(10 * BmpScale));
  rBackgroundHeaderLeft.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundHeaderLeft.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create(0, 0, round(10 * BmpScale), round(10 * BmpScale)),
      trectf.Create(0, 0, round(10 * BmpScale), round(10 * BmpScale)), 1);
  finally
    rBackgroundHeaderLeft.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;

  rBackgroundHeader.Fill.Bitmap.Bitmap.SetSize
    (bmp.Width - 2 * round(10 * BmpScale), round(10 * BmpScale));
  rBackgroundHeader.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundHeader.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create(round(10 * BmpScale), 0, bmp.Width - round(10 * BmpScale),
      round(10 * BmpScale)), trectf.Create(0, 0,
      bmp.Width - 2 * round(10 * BmpScale), round(10 * BmpScale)), 1);
  finally
    rBackgroundHeader.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;

  rBackgroundHeaderRight.Fill.Bitmap.Bitmap.SetSize(round(10 * BmpScale),
    round(10 * BmpScale));
  rBackgroundHeaderRight.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundHeaderRight.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create(bmp.Width - round(10 * BmpScale), 0, bmp.Width,
      round(10 * BmpScale)), trectf.Create(0, 0, round(10 * BmpScale),
      round(10 * BmpScale)), 1);
  finally
    rBackgroundHeaderRight.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;

  rBackgroundContentLeft.Fill.Bitmap.Bitmap.SetSize(round(10 * BmpScale),
    round(20 * BmpScale));
  rBackgroundContentLeft.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundContentLeft.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create(0, round(10 * BmpScale), round(10 * BmpScale),
      bmp.height - round(10 * BmpScale)),
      trectf.Create(0, 0, round(10 * BmpScale),
      bmp.height - 2 * round(10 * BmpScale)), 1);
  finally
    rBackgroundContentLeft.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;

  rBackgroundContent.Fill.Bitmap.Bitmap.SetSize
    (bmp.Width - 2 * round(10 * BmpScale), round(20 * BmpScale));
  rBackgroundContent.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundContent.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create((10 * BmpScale), round(10 * BmpScale),
      bmp.Width - (10 * BmpScale), bmp.height - round(10 * BmpScale)),
      trectf.Create(0, 0, bmp.Width - 2 * (10 * BmpScale),
      bmp.height - 2 * round(10 * BmpScale)), 1);
  finally
    rBackgroundContent.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;

  rBackgroundContentRight.Fill.Bitmap.Bitmap.SetSize(round(10 * BmpScale),
    round(20 * BmpScale));
  rBackgroundContentRight.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundContentRight.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create(bmp.Width - round(10 * BmpScale), round(10 * BmpScale),
      bmp.Width, bmp.height - round(10 * BmpScale)),
      trectf.Create(0, 0, round(10 * BmpScale),
      bmp.height - 2 * round(10 * BmpScale)), 1);
  finally
    rBackgroundContentRight.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;

  rBackgroundFooterLeft.Fill.Bitmap.Bitmap.SetSize(round(10 * BmpScale),
    round(10 * BmpScale));
  rBackgroundFooterLeft.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundFooterLeft.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create(0, bmp.height - round(10 * BmpScale), round(10 * BmpScale),
      bmp.height), trectf.Create(0, 0, round(10 * BmpScale),
      round(10 * BmpScale)), 1);
  finally
    rBackgroundFooterLeft.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;

  rBackgroundFooter.Fill.Bitmap.Bitmap.SetSize
    (bmp.Width - 2 * round(10 * BmpScale), round(10 * BmpScale));
  rBackgroundFooter.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundFooter.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create(round(10 * BmpScale), bmp.height - round(10 * BmpScale),
      bmp.Width - round(10 * BmpScale), bmp.height),
      trectf.Create(0, 0, bmp.Width - 2 * round(10 * BmpScale),
      round(10 * BmpScale)), 1);
  finally
    rBackgroundFooter.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;

  rBackgroundFooterRight.Fill.Bitmap.Bitmap.SetSize(round(10 * BmpScale),
    round(10 * BmpScale));
  rBackgroundFooterRight.Fill.Bitmap.Bitmap.canvas.BeginScene;
  try
    rBackgroundFooterRight.Fill.Bitmap.Bitmap.canvas.DrawBitmap(bmp,
      trectf.Create(bmp.Width - round(10 * BmpScale),
      bmp.height - round(10 * BmpScale), bmp.Width, bmp.height),
      trectf.Create(0, 0, round(10 * BmpScale), round(10 * BmpScale)), 1);
  finally
    rBackgroundFooterRight.Fill.Bitmap.Bitmap.canvas.EndScene;
  end;
end;

end.
