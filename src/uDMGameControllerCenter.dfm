object DMGameControllerCenter: TDMGameControllerCenter
  Height = 480
  Width = 640
  object DGEGamepadManager1: TDGEGamepadManager
    OnButtonDown = DGEGamepadManager1ButtonDown
    OnAxesChange = DGEGamepadManager1AxesChange
    OnDirectionPadChange = DGEGamepadManager1DirectionPadChange
    Left = 304
    Top = 224
  end
end
