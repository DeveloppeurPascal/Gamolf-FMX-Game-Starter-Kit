unit uScene;

interface

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
    OldScene.FinalizeScene;
    OldScene.Visible := false;
    FCurrent := TSceneType.None;
  end;

  if ScenesList.TryGetValue(Value, NewScene) then
  begin
    FCurrent := Value;
    NewScene.InitializeScene;
    NewScene.Visible := true;
    NewScene.BringToFront;
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
