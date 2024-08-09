unit uDMAboutBoxLogoStorrage;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ImageList,
  FMX.ImgList;

type
  TdmAboutBoxLogo = class(TDataModule)
    imgLogo: TImageList;
  private
  public
  end;

{$MESSAGE WARN 'change the About box logo in this TImageList'}
  // TODO : change the About box logo in this TImageList

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

end.
