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
/// File last update : 2024-08-10T10:43:38.000+02:00
/// Signature : 670323c3742b357a9dad8c0599f1a2d370372112
/// ***************************************************************************
/// </summary>

unit _ButtonsAncestor;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.
//
// The starter kit manage "real" buttons (FMX TControl descendants which can be
// focused) or other controls implementing IUIControl interface.
//
// To simplify your life when you want a customized UI button :
// - inherits from this frame,
// - draw your button states (up by default, down when clicked, with and without
// the focus) in the form designer,
// - override the Repaint() method to manage visibility of your elements
// depending on IsDown and IsFocused properties,
// - use your new button as it or inherits from it to have a frame for each
// text/icon button to show them with the good shape when designing your scenes

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Forms,
  System.Messaging,
  uUIElements;

type
  /// <summary>
  /// Should be used as your UI buttons ancestor.
  /// </summary>
  /// <remarks>
  /// Override Repaint() method in your descendants or you'll get EAbstractError
  /// exceptions.
  /// </remarks>
  T__ButtonAncestor = class(TFrame, IUIControl)
    procedure FrameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FrameMouseLeave(Sender: TObject);
  private
    FIsFocused: boolean;
    FIsDown: boolean;
    FText: string;
    FTimeBetweenDownAndUpStatesWhenClicked: Integer;
    procedure SetIsDown(const Value: boolean);
    procedure SetIsFocused(const Value: boolean);
    procedure SetText(const Value: string);
    function GetIsUp: boolean;
    procedure SetIsUp(const Value: boolean);
    procedure SetTimeBetweenDownAndUpStatesWhenClicked(const Value: Integer);
    function GetTimeBetweenDownAndUpStatesWhenClicked: Integer;
  protected
    procedure DoTranslateTexts(const Sender: TObject; const Msg: TMessage);
  public
    /// <summary>
    /// Manage the focus state of this button
    /// </summary>
    property IsFocused: boolean read FIsFocused write SetIsFocused;
    /// <summary>
    /// Manage the status of this button (False by default)
    /// </summary>
    property IsDown: boolean read FIsDown write SetIsDown;
    /// <summary>
    /// Manage the status of this button (True by default)
    /// </summary>
    property IsUp: boolean read GetIsUp write SetIsUp;
    /// <summary>
    /// Sleeping time between Down and up states when the Click method is called.
    /// Value is in milliseconds, used by the sleep() instruction.
    /// </summary>
    /// <remarks>
    /// Default value is -1 to use CTimeInMSBetweenButtonDownAndUp value from
    /// the game settings.
    /// </remarks>
    property TimeBetweenDownAndUpStatesWhenClicked: Integer
      read GetTimeBetweenDownAndUpStatesWhenClicked
      write SetTimeBetweenDownAndUpStatesWhenClicked;
    /// <summary>
    /// The text shown on this button
    /// </summary>
    property Text: string read FText write SetText;
    /// <summary>
    /// Where you can translate the text of your button
    /// (override and call it in your descendants)
    /// </summary>
    procedure TranslateTexts(const Language: string); virtual;
    /// <summary>
    /// Called when the button is clicked.
    /// - activate the down status
    /// - wait for TimeBetweenDownAndUpStatesWhenClicked ms
    /// - activate the up status
    /// - call the onClick() event if it's not empty
    /// (you can override it but it's better to fill the onClick event)
    /// </summary>
    procedure Click; override;
    /// <summary>
    /// mostly internal use, change then IsFocused property is better
    /// </summary>
    procedure SetFocus; virtual;
    /// <summary>
    /// mostly internal use, change then IsFocused property is better
    /// </summary>
    procedure ResetFocus; virtual;
    /// <summary>
    /// Called to refresh the button on screen, override it in your descendants
    /// or it will crash !
    /// </summary>
    procedure Repaint; virtual; abstract;
    /// <summary>
    /// internal use, call it only if you override it in a descendant
    /// </summary>
    procedure AfterConstruction; override;
    /// <summary>
    /// internal use, call it only if you override it in a descendant
    /// </summary>
    procedure BeforeDestruction; override;
    /// <summary>
    /// Returns an instance of this class
    /// </summary>
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.fmx}

uses
  uConfig,
  uTranslate,
  uConsts;

procedure T__ButtonAncestor.AfterConstruction;
begin
  inherited;
  name := '';
  tthread.ForceQueue(nil,
    procedure
    begin
      TranslateTexts(tconfig.Current.Language);
      TMessageManager.DefaultManager.SubscribeToMessage(TTranslateTextsMessage,
        DoTranslateTexts);
      Repaint;
    end);
end;

procedure T__ButtonAncestor.BeforeDestruction;
begin
  inherited;
  TMessageManager.DefaultManager.Unsubscribe(TTranslateTextsMessage,
    DoTranslateTexts, true);
end;

procedure T__ButtonAncestor.Click;
begin
  if GetTimeBetweenDownAndUpStatesWhenClicked < 1 then
    inherited
  else
  begin
    IsDown := true;
    IsFocused := true;
    tthread.CreateAnonymousThread(
      procedure
      begin
        sleep(GetTimeBetweenDownAndUpStatesWhenClicked);
        tthread.queue(nil,
          procedure
          begin
            if not assigned(self) then
              exit;

            IsDown := false;

            inherited;
          end);
      end).Start;
  end;
end;

constructor T__ButtonAncestor.Create(AOwner: TComponent);
begin
  inherited;
  FIsFocused := false;
  FIsDown := false;
  FText := '';
  FTimeBetweenDownAndUpStatesWhenClicked := -1;
end;

procedure T__ButtonAncestor.DoTranslateTexts(const Sender: TObject;
const Msg: TMessage);
begin
  if not assigned(self) then
    exit;

  if assigned(Msg) and (Msg is TTranslateTextsMessage) then
    TranslateTexts((Msg as TTranslateTextsMessage).Language);
end;

procedure T__ButtonAncestor.FrameMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  IsDown := true;
end;

procedure T__ButtonAncestor.FrameMouseLeave(Sender: TObject);
begin
  IsDown := false;
end;

function T__ButtonAncestor.GetIsUp: boolean;
begin
  result := not IsDown;
end;

function T__ButtonAncestor.GetTimeBetweenDownAndUpStatesWhenClicked: Integer;
begin
  if FTimeBetweenDownAndUpStatesWhenClicked < 0 then
    result := CTimeInMSBetweenButtonDownAndUp
  else
    result := FTimeBetweenDownAndUpStatesWhenClicked;
end;

procedure T__ButtonAncestor.ResetFocus;
begin
  IsFocused := false;
end;

procedure T__ButtonAncestor.SetFocus;
begin
  IsFocused := true;
end;

procedure T__ButtonAncestor.SetIsDown(const Value: boolean);
begin
  FIsDown := Value;
  Repaint;
end;

procedure T__ButtonAncestor.SetIsFocused(const Value: boolean);
begin
  FIsFocused := Value;
  Repaint;
end;

procedure T__ButtonAncestor.SetIsUp(const Value: boolean);
begin
  IsDown := not Value;
end;

procedure T__ButtonAncestor.SetText(const Value: string);
begin
  FText := Value;
  Repaint;
end;

procedure T__ButtonAncestor.SetTimeBetweenDownAndUpStatesWhenClicked
  (const Value: Integer);
begin
  FTimeBetweenDownAndUpStatesWhenClicked := Value;
end;

procedure T__ButtonAncestor.TranslateTexts(const Language: string);
begin
  // nothing to do here at this level
end;

end.
