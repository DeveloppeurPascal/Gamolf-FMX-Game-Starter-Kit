unit uUIElements;

interface

uses
  Gamolf.RTL.UIElements;

type
  TUIItemsList = class(TUIElementsList)
  private
  protected
  public
    class function Current: TUIItemsList;
  end;

implementation

var
  UIElements: TUIItemsList;

  { TUIItemsList }

class function TUIItemsList.Current: TUIItemsList;
begin
  if not assigned(UIElements) then
    UIElements := TUIItemsList.Create;

  result := UIElements;
end;

initialization

UIElements := nil;

finalization

UIElements.Free;

end.
