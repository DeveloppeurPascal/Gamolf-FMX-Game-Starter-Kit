(* C2PP
  ***************************************************************************

  Gamolf FMX Game Starter Kit

  Copyright 2024-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

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
  https://github.com/DeveloppeurPascal/Gamolf-FMX-Game-Starter-Kit

  ***************************************************************************
  File last update : 2025-05-08T20:36:27.121+02:00
  Signature : d9ecd60236a610568f3763a330d3d0d9434b2bbc
  ***************************************************************************
*)

unit uScene;

interface

// If you want to be able to update the template files in your game project,
// we recommend that you don't modify this file. Its operation should support
// all standard use cases. Save the file in your project and work on the copy.
// In this case, we suggest you open a ticket on the code repository to explain
// your needs and the changes to be made to the template.

uses
  System.Messaging,
  _ScenesAncestor,
  System.Generics.Collections,
  uConsts;

type
  /// <summary>
  /// To store the list of scenes and their instance
  /// </summary>
  TScenesList = class(TDictionary<TSceneType, T__SceneAncestor>)
  private
  protected
  public
  end;

  /// <summary>
  /// The scene manager.
  /// Use it to access to current scene and go to an other one.
  /// </summary>
  TScene = class
  private
    class var FCurrent: TSceneType;
    class procedure SetCurrent(const Value: TSceneType); static;
    class function GetScenesList: TScenesList;
  protected
  public
    /// <summary>
    /// Register a new scene in the list of available scenes and show it
    /// </summary>
    class procedure RegisterScene(const AType: TSceneType;
      const AScene: T__SceneAncestor); overload;
      deprecated 'Replace it by RegisterScene<T__SceneAncestor>(TSceneType)';
    /// <summary>
    /// Register a new scene in the list of available scenes and show it
    /// </summary>
    class procedure RegisterScene<T: T__SceneAncestor>
      (const AType: TSceneType); overload;
    /// <summary>
    /// Unregister a scene from the list
    /// (to use only if you remove scenes and free their instance manually)
    /// </summary>
    class procedure UnRegisterScene(const AType: TSceneType); overload;
    /// <summary>
    /// Return current scene on screen. Change it's value to show an other scene.
    /// </summary>
    class property Current: TSceneType read FCurrent write SetCurrent;
    /// <summary>
    /// Return the instance of current displayed scene.
    /// </summary>
    class function GetInstance: T__SceneAncestor;
  end;

  /// <summary>
  /// Used by the scene registration.
  /// Subcribe to this message if you want to auto create a scene in your game.
  /// </summary>
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
  FMX.Forms,
  System.Classes;

var
  ScenesList: TScenesList;

  { TScene }

class function TScene.GetScenesList: TScenesList;
begin
  result := ScenesList;
end;

class function TScene.GetInstance: T__SceneAncestor;
begin
  if not ScenesList.TryGetValue(FCurrent, result) then
    result := nil;
end;

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

class procedure TScene.RegisterScene<T>(const AType: TSceneType);
begin
  TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
    procedure(const Sender: TObject; const Msg: tmessage)
    var
      NewScene: T;
    begin
      if (Msg is TSceneFactory) and ((Msg as TSceneFactory).SceneType = AType)
      then
      begin
        NewScene := T.Create(application.mainform);
        NewScene.Parent := application.mainform;
        UnRegisterScene(AType);
        GetScenesList.Add(AType, NewScene);
        tthread.ForceQueue(nil,
          procedure
          begin
            Current := AType;
          end);
      end;
    end);
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
