object AboutBox: TAboutBox
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object OlfAboutDialog1: TOlfAboutDialog
    MultiResBitmap = <
      item
      end>
    onURLClick = OlfAboutDialog1URLClick
    onGetText = OlfAboutDialog1GetText
    Left = 304
    Top = 224
  end
end
