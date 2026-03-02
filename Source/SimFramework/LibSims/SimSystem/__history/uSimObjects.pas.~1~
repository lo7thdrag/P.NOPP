unit uSimObjects;


interface

uses
  Classes,  uBaseSimObjects, uSimContainers, uDataTypes,
  Graphics, uObjectVisuals, uCoordConvertor, uGameData_TTT;

type
  THancurEvent = procedure (Sender: TObject; Target : string; reasondestroy : Byte) of object;

//==============================================================================
  TSimObject = class(TBaseSimObject)
  protected
    FObjectID: String;
    FOnDestroy: TNotifyEvent;
    FOnPositionChange : TNotifyEvent;
//    FOnHancur: TNotifyEvent;
    FOnHancur: THancurEvent;
    FOnPropertyChange : TNotifyEvent;

    FPosition: t3DPoint;
    FDynamicOverlay :  TRecord_DynamicOverlay;

    //untuk gambar Assigned Track
    FAssignedSymbol : TBitmapSymbol;

    function GetObjectID: String;
    procedure SetObjectID(val: String);

    procedure SetFreeMe(const Value: boolean);override;
  private
    FConverter: TCoordConverter;
    FLockFCR: Boolean;
    FOwner: TSimObject;
    FParentInstanceIndex: Integer;
    FGameTime: TDateTime;
    procedure SetLockFCR(const Value: Boolean);

    procedure setGameTime(const Value: TDateTime);    //function GetPosition(index : integer): double;
    //procedure SetPosition(const Value: T3DPoint);

  protected
    FParent : TSimObject;
    FAssigned : Boolean;
    FInstanceIndex  : integer;
    procedure SetConverter(const Value: TCoordConverter);virtual;
    procedure ChildOnDestroy(sender : TObject); virtual;
    procedure SetOwner(const Value: TSimObject);virtual;

  public
    constructor Create;
    destructor Destroy; override;

    function getInstanceIndex: Integer;
    function getPositionX: double;
    function getPositionY: double;
    function getPositionZ: double;

    procedure setPositionX(const v: double); virtual;
    procedure setPositionY(const v: double); virtual;
    procedure setPositionZ(const v: double); virtual;
    procedure SetAssigned(const value : Boolean); virtual;
    procedure Move(const aDeltaMs: double); virtual;
    procedure UpdateVisual; virtual;
    procedure Draw(aCnv: tCanvas); virtual;
    procedure FreeChilds; virtual;     //divirtual disimobject supaya bisa dipanggil dari container;

    property ObjectID: String read GetObjectID write SetObjectID;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnHancur: THancurEvent read FOnHancur write FOnHancur;
    property Parent : TSimObject read FParent write FParent;
    property Owner : TSimObject read FOwner write SetOwner;
    property OnPropertyChange: TNotifyEvent read FOnPropertyChange write FOnPropertyChange;
    property OnPositionChange : TNotifyEvent read FOnPositionChange write FOnPositionChange;

    property IsAssigned : Boolean read FAssigned write SetAssigned;
    property LockFCR: Boolean read FLockFCR write SetLockFCR;
    property PosX: double read getPositionX write setPositionX;
    property PosY: double read getPositionY write setPositionY;
    property PosZ: double read getPositionZ write setPositionZ;
    property Converter : TCoordConverter read FConverter write SetConverter;
    property ParentInstanceIndex : Integer read FParentInstanceIndex write FParentInstanceIndex;
    property GameTime : TDateTime read FGameTime write setGameTime;
  end;

//==============================================================================
  TSimObjectNode = class(TSimObject)
  private
    function GetChild(const i: integer): TSimObject;
    function GetChildCount: Integer;

  protected
    FChilds: TSimContainer;

    procedure ChildOnDestroy(sender : TObject); override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddChild(cSimObject: TSimObject);
    procedure RemoveChild(cSimObject: TSimObject);
    procedure ClearChilds;

    procedure ClearAndFreeChilds;
    procedure CleanChildNeedFree;

    procedure MoveChilds(const aDeltaMs: double); virtual;  //call child update
    procedure Move(const aDeltaMs: double); override;

    procedure UpdateChildsVisual; virtual;
    procedure UpdateVisual; override;

    procedure DrawChilds(aCnv: tCanvas); virtual;
    procedure Draw(aCnv: tCanvas); override;

    property Childs[const i: integer]: TSimObject read GetChild;
    property ChildCount: Integer read GetChildCount;
  end;

implementation

uses
  SysUtils, uLibSettingTTT, Windows;

{ TBaseSimClass }
constructor TSimObject.Create;
begin
  inherited;
  FAssignedSymbol := TBitmapSymbol.Create;
  
  FParent := nil;
end;

destructor TSimObject.Destroy;
begin
//  if Assigned(FParent) then
//    FParent.ChildOnDestroy(self);
//  if Assigned(FOnDestroy) then
//    FOnDestroy(self);

  if Assigned(FParent) then
    FParent := nil;

  FreeAndNil(FAssignedSymbol);

  inherited;
end;


function TSimObject.GetObjectID: String;
begin
  Result := FObjectID;
end;

function TSimObject.getPositionX: double;
begin
  result := FPosition.X;
end;

function TSimObject.getPositionY: double;
begin
  result := FPosition.Y;
end;

function TSimObject.getPositionZ: double;
begin
  result := FPosition.Z;
end;

procedure TSimObject.setPositionX(const v: double);
begin
  FPosition.X := v;
end;

procedure TSimObject.setPositionY(const v: double);
begin
  FPosition.Y := v;
end;
procedure TSimObject.setPositionZ(const v: double);
begin
  FPosition.Z := v;
end;

procedure TSimObject.SetAssigned(const value : Boolean);
begin
  FAssigned := value;
end;

procedure TSimObject.SetConverter(const Value: TCoordConverter);
begin
  FConverter := Value;
end;

procedure TSimObject.SetFreeMe(const Value: boolean);
begin
  if Value <> FFreeMe then
  begin
    if Assigned(FOnDestroy) then
      FOnDestroy(self);
  end;

  inherited;
end;

procedure TSimObject.setGameTime(const Value: TDateTime);
begin
  FGameTime := Value;
end;

procedure TSimObject.SetLockFCR(const Value: Boolean);
begin
  FLockFCR := Value;
end;

procedure TSimObject.SetObjectID(val: String);
begin
  FObjectID := val;
end;

procedure TSimObject.SetOwner(const Value: TSimObject);
begin
  FOwner := Value;

//  if Assigned(FOwner) then

end;

procedure TSimObject.UpdateVisual;
begin
  if Assigned(FParent) then begin
    FPosition.X := FParent.getPositionX;
    FPosition.Y := FParent.getPositionY;
    FPosition.Z := FParent.getPositionZ;
  end;
end;

procedure TSimObject.Draw(aCnv: tCanvas);
var
  p : TPoint;
begin
  FAssignedSymbol.Visible := False;

  if IsAssigned then
  begin
    //draw assign obj oleh FC
    FAssignedSymbol.Visible := True;
    FAssignedSymbol.LoadBitmap(vSymbolSetting.ImgPath + 'Assign' + '.bmp', clWhite);

    Converter.ConvertToScreen(getPositionX, getPositionY, p.X, p.Y);
    FAssignedSymbol.Center := p;
    FAssignedSymbol.Draw(aCnv);
  end;
end;

procedure TSimObject.FreeChilds;
begin

end;

function TSimObject.getInstanceIndex: Integer;
begin
  Result := FInstanceIndex;
end;

procedure TSimObject.ChildOnDestroy(sender : TObject);
begin
  // procedure ini dipanggil dari child.
  // karena TsimObject tidak punya child, seharusnya procedure ini tidak pernah
  // dipanggil.
end;

procedure TSimObject.Move(const aDeltaMs: double);
begin
   // self update.
  //calc movement etc
end;

//==============================================================================
{ TSimObjectNode }

constructor TSimObjectNode.Create;
begin
  FChilds := TSimContainer.Create;

end;

destructor TSimObjectNode.Destroy;
begin
  FreeAndNil( FChilds);

  inherited;
end;


procedure TSimObjectNode.ChildOnDestroy(sender : TObject);
begin  // procedure ini dipanggil waktu
  FChilds.GetList.Remove(sender);
  FChilds.ReturnList;
end;


procedure TSimObjectNode.CleanChildNeedFree;
var
  list : TList;
  simObj : TSimObject;
  i : integer;
begin
  list := FChilds.GetList;
  for I := List.Count - 1 downto 0 do begin
    simObj := TSimObject(list[i]);
    if simObj.FreeMe then begin
      list.Delete(i);
    end;
  end;

  FChilds.ReturnList;
end;

procedure TSimObjectNode.ClearAndFreeChilds;
begin
  FChilds.ClearAndFreeObject;
end;

procedure TSimObjectNode.ClearChilds;
begin
  // clear list and free all child.
  //  FChilds.ClearObject;
  // ju
  FChilds.GetList.Clear;
  FChilds.ReturnList;

end;


procedure TSimObjectNode.AddChild(cSimObject: TSimObject);
begin
  FChilds.AddObject(cSimObject);
end;


procedure TSimObjectNode.RemoveChild(cSimObject: TSimObject);
//var l : TList;
begin
//  1. remove from list and  free.
//     FChilds.RemoveObject(cSimObject);
 // 2. just remove from list. do not destroy the object.

  FChilds.GetList.Remove(cSimObject);
  FChilds.ReturnList;
end;


procedure TSimObjectNode.MoveChilds(const aDeltaMs: double);
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FChilds.GetList;

  for I := l.Count - 1 downto 0 do begin
    sco :=  l[i];
    if Assigned(sco)  then
      sco.Move(aDeltaMs);
  end;

  FChilds.ReturnList;
end;

procedure TSimObjectNode.Move(const aDeltaMs: double);
begin
  //  inherited;
  // update my self

  MoveChilds (aDeltaMs);
end;

procedure TSimObjectNode.UpdateChildsVisual;
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FChilds.GetList;
  for I := 0 to l.Count - 1 do begin
    sco :=  l[i];
    if Assigned(sco)  then
      sco.UpdateVisual;
  end;
  FChilds.ReturnList;
end;

procedure TSimObjectNode.UpdateVisual;
begin
  //inherited;
  UpdateChildsVisual;

end;


procedure TSimObjectNode.DrawChilds(aCnv: tCanvas);
var i : Integer;
    l : TList;
    sco : TSimObject;
begin
  l :=  FChilds.GetList;
  for I := 0 to l.Count - 1 do begin
    sco :=  l[i];
    if Assigned(sco)  then
      sco.Draw(aCnv);
  end;
  FChilds.ReturnList;

end;

function TSimObjectNode.GetChild(const i: integer): TSimObject;
var    l : TList;
begin
  l :=  FChilds.GetList;
  if (i>=0) and (i <l.Count)  then
    Result := l[i]
  else
    Result := nil;

  FChilds.ReturnList;

end;

function TSimObjectNode.GetChildCount: Integer;
begin
  Result := FChilds.GetList.Count;
  FChilds.ReturnList;

end;

procedure TSimObjectNode.Draw(aCnv: tCanvas);
begin
//  inherited;
  DrawChilds(aCnv);

end;

end.

