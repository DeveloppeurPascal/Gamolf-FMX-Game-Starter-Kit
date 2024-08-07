unit uTranslate;

interface

uses
  System.Messaging;

type
  TTranslateTextsMessage = class(TMessage)
  private
    FLanguage: string;
  protected
  public
    property Language: string read FLanguage;
    constructor Create(const ALanguage: string);
    /// <summary>
    /// Use this method to translate all texts in your game
    /// </summary>
    class procedure Broadcast(const ALanguage: string);
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  uConfig;

{ TTranslateTextsMessage }

class procedure TTranslateTextsMessage.Broadcast(const ALanguage: string);
var
  LLanguage: string;
begin
  LLanguage := ALanguage;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TTranslateTextsMessage.Create(LLanguage));
    end);
end;

constructor TTranslateTextsMessage.Create(const ALanguage: string);
begin
  inherited Create;
  FLanguage := ALanguage.ToLower;
  if FLanguage.IsEmpty then
    FLanguage := tconfig.Current.Language;
end;

procedure init;
begin
  TTranslateTextsMessage.Broadcast(tconfig.Current.Language);
end;

initialization

// I know, it's ugly, but with this I'm sure to execute the init after all
// "ForceQueue()" sent during program initialization, after the program has
// started and shown it's window.

tthread.ForceQueue(nil,
  procedure
  begin
    tthread.ForceQueue(nil,
      procedure
      begin
        init;
      end);
  end);

end.
