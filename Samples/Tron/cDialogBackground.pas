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
/// File last update : 2024-08-22T11:47:20.000+02:00
/// Signature : 3984590ba451fa613ea4fd98f3b17646e8b2d28c
/// ***************************************************************************
/// </summary>

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
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  USVGUIPack,
  uSVGBitmapManager_UIPack;

procedure TDialogBackground.AfterConstruction;
begin
  inherited;
  tthread.ForceQueue(nil,
    procedure
    begin
      imgContentResized(self);
    end);
end;

procedure TDialogBackground.imgContentResized(Sender: TObject);
var
  bmp: TBitmap;
  BmpScale: single;
begin
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
