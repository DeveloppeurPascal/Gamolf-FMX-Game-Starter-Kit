/// <summary>
/// ***************************************************************************
///
/// Gamolf FMX Game Template
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
/// The "Gamolf FMX Game Template" is both a "technical" example of a video
/// game developed in Delphi with everything you need inside, and a reusable
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
/// https://gametemplate.developpeur-pascal.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Template
///
/// ***************************************************************************
/// File last update : 2024-08-08T16:02:28.000+02:00
/// Signature : ac9b146e53986ffeca4102c66b19106dc8ca9699
/// ***************************************************************************
/// </summary>

unit uScene;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.Messaging,
  _SceneAncestor,
  uConsts;

type
  TScene = class
  private
    class var FCurrent: TSceneType;
    class procedure SetCurrent(const Value: TSceneType); static;
  protected
  public
    /// <summary>
    /// Register a new scene in the list of available scenes and show it
    /// </summary>
    class procedure RegisterScene(const AType: TSceneType;
      const AScene: T__SceneAncestor);
    /// <summary>
    /// Unregister a scene from the list
    /// (to use only if you remove scenes and free their instance manually)
    /// </summary>
    class procedure UnRegisterScene(const AType: TSceneType); overload;
    /// <summary>
    /// Return current scene on screen. Change it's value to show an other scene.
    /// </summary>
    class property Current: TSceneType read FCurrent write SetCurrent;
  end;

  TSceneFactory = class(tmessage)
  private
    FSceneType: TSceneType;
  protected
  public
    property SceneType: TSceneType read FSceneType;
    constructor Create(const AType: TSceneType);
    class procedure Broadcast(const AType: TSceneType);
  end;

implementation

uses
  System.Generics.Collections,
  System.Classes;

type
  TScenesList = class(TDictionary<TSceneType, T__SceneAncestor>)
  private
  protected
  public
  end;

var
  ScenesList: TScenesList;

  { TScene }

class procedure TScene.RegisterScene(const AType: TSceneType;
  const AScene: T__SceneAncestor);
begin
  UnRegisterScene(AType);
  if assigned(AScene) then
  begin
    ScenesList.Add(AType, AScene);
    tthread.ForceQueue(nil,
      procedure
      begin
        Current := AType;
      end);
  end;
end;

class procedure TScene.SetCurrent(const Value: TSceneType);
var
  OldScene: T__SceneAncestor;
  NewScene: T__SceneAncestor;
begin
  if ScenesList.TryGetValue(FCurrent, OldScene) then
  begin
    OldScene.HideScene;
    FCurrent := TSceneType.None;
  end;

  if ScenesList.TryGetValue(Value, NewScene) then
  begin
    FCurrent := Value;
    NewScene.ShowScene;
  end
  else
    TSceneFactory.Broadcast(Value);
end;

class procedure TScene.UnRegisterScene(const AType: TSceneType);
begin
  if ScenesList.ContainsKey(AType) then
    ScenesList.Remove(AType);
end;

{ TSceneFactory }

class procedure TSceneFactory.Broadcast(const AType: TSceneType);
var
  LType: TSceneType;
begin
  LType := AType;
  tthread.Queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TSceneFactory.Create(LType));
    end);
end;

constructor TSceneFactory.Create(const AType: TSceneType);
begin
  inherited Create;
  FSceneType := AType;
end;

initialization

TScene.FCurrent := TSceneType.None;
ScenesList := TScenesList.Create;

finalization

ScenesList.Free;

end.
