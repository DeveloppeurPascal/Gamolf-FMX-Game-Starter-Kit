(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit
  Copyright (c) 2024-2026 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  ***************************************************************************

  The "Gamolf FMX Game Starter Kit" is both a "technical" example of a video
  game developed in Delphi with everything you need inside and a reusable
  project template you can customize for your own games.

  The files provided are fully functional. Numerous comments are included in
  the sources to explain how they work and what you need to copy, override
  or customize to make video games without starting from scratch.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://fmxgamestarterkit.developpeur-pascal.fr/

  Project site :
  https://codeberg.org/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit

  ***************************************************************************
  File last update : 2026-04-02T19:25:40.776+02:00
  Signature : 403b9842c5408b9152e82c0013f6427a6f4618f1
  ***************************************************************************
*)

unit uTranslate;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

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
