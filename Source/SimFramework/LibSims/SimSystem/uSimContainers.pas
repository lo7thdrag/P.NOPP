unit uSimContainers;
(*
  last edit: 2010 Juni 14
*)

interface

uses
  Classes, uBaseSimObjects, SysUtils, Windows;

type

  //==============================================================================
  //TThListAdapter = class (TObject)
  TThListAdapter = class(TObject)
  private
    function getItemCount: integer;

  protected
    FListItem: TThreadList;

  public
    constructor Create;
    destructor Destroy; override;

    procedure ClearAndFreeObject;

    procedure AddObject(aObj: TObject); virtual;
    procedure RemoveObject(aObj: TObject); virtual;
    procedure Remove(aObj: TObject); overload;virtual;
    procedure Remove(index : integer);overload;virtual;

    {do not remove from list and return it}
    function getObject(const Index: integer): TObject;

    function GetList: TList;
    procedure ReturnList;

  public
    property ItemCount: integer read getItemCount;
    property ListItem: TThreadList read FListItem write FListItem;

  end;

  //============================================================================
  TSimContainer = class(TThListAdapter)
  public
    procedure CleanUpObject(); virtual; // delete marked 'unused' object;
    function FindObjectByUid(const aUid: string): TBaseSimObject;
  end;

  //============================================================================
  // Iterator event type
  TProcIterateObject = procedure(obj: TBaseSimObject) of object;
  TFuncIterateFinder = function(obj: TBaseSimObject): boolean of object;

  TFinderObject = function(obj: TObject): boolean of object;

  //============================================================================
  TSimIterators = class
  private
    FLastItem: TBaseSimObject;

    FOnGetItem: TProcIterateObject;
    FOnSearchItem: TFuncIterateFinder;

  public
    FList: TSimContainer;

    constructor Create;
    destructor Destroy; override;

    function Iterate(cl: TClass): boolean;

    function Find: TObject;

    property OnGetItem: TProcIterateObject read FOnGetItem write FOnGetItem;
    property FindFunction: TFuncIterateFinder read FOnSearchItem write FOnSearchItem;

  end;

  //==============================================================================
  TThListIterators = class
  private
    FOnGetItem: TNotifyEvent;

  public
    NList: TThreadList;
    LastItem: TObject;

    constructor Create;
    destructor Destroy; override;

    function Iterate: boolean;

    property OnGetItem: TNotifyEvent read FOnGetItem write FOnGetItem;
  end;

  //==============================================================================
  TListIterators = class
  private
    FOnGetItem: TNotifyEvent;
    FOnSearchItem: TFinderObject;

  public
    NList: TList;
    LastItem: TObject;

    constructor Create;
    destructor Destroy; override;

    function Iterate: boolean;
    function Find: TObject;

    property OnGetItem: TNotifyEvent read FOnGetItem write FOnGetItem;
    property FindFunction: TFinderObject read FOnSearchItem write FOnSearchItem;
  end;

  //****************************************************************************//
  procedure FreeItemsAndFreeList(var l: TList);

  procedure ClearAndFreeItems(var l: TList); overload;
  procedure ClearAndFreeItems(var tl: TThreadList); overload;
  procedure ClearAndFreeItems(var sl: TStrings); overload;

  //****************************************************************************//
implementation

{TSimContainer}
//==============================================================================

// == constructor and destructor

constructor TThListAdapter.Create;
begin
  FListItem := TThreadList.Create;

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

destructor TThListAdapter.Destroy;
begin
  ClearAndFreeObject;

  FListItem.Free;
  FListItem := nil;

  inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// == private methods

function TThListAdapter.getItemCount: integer;
begin
  Result := FListItem.LockList.Count;
  FListItem.UnlockList;
end;

// == public methods ===========================================================

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TThListAdapter.AddObject(aObj: TObject);
begin
  with FListItem.LockList do try
    Add(aObj);
  finally
    FListItem.UnlockList;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// remove only not free
procedure TThListAdapter.Remove(aObj: TObject);
begin
  with FListItem.LockList do try
    Remove(aObj);
  finally
    FListItem.UnlockList;
  end;
end;

procedure TThListAdapter.Remove(index: integer);
begin
  with FListItem.LockList do try
    if index < Count then
      Delete(index);
  finally
    FListItem.UnlockList;
  end;
end;

procedure TThListAdapter.RemoveObject(aObj: TObject);
begin
  with FListItem.LockList do try
    Remove(aObj);
    aObj.Free;
  finally
    FListItem.UnlockList;
  end;

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TThListAdapter.ClearAndFreeObject();
var
  i: integer;
  obj: TObject;
begin
  with FListItem.LockList do try
    for i := Count - 1 downto 0 do begin
      obj := Items[i];
      obj.Free;
    end;
    Clear;
  finally
    FListItem.UnlockList;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TThListAdapter.getObject(const Index: integer): TObject;
begin
  result := nil;
  with FListItem.LockList do try
    if (Index >= 0) and (Index < Count) then begin
      result := Items[Index];
    end;
  finally
    FListItem.UnlockList;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TThListAdapter.GetList: TList;
begin
  result := FListItem.LockList;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TThListAdapter.ReturnList;
begin
  FListItem.UnlockList;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//==============================================================================
{ TThListIterators }

constructor TThListIterators.Create;
begin

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

destructor TThListIterators.Destroy;
begin

  inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TThListIterators.Iterate: boolean;
var
  i: integer;
  l: TList;
begin
  result := false;
  if not Assigned(NList) then exit;
  if not Assigned(FOnGetItem) then exit;

  l := NList.LockList;
  i := 0;
  LastItem := nil;

  while (i < l.Count) do begin
    LastItem := l[i];
    FOnGetItem(LastItem);
    inc(i)
  end;
  result := true;

  NList.UnlockList;

end;

//==============================================================================
{ TSimContainer }
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TSimContainer.CleanUpObject;
var
  i: integer;
  obj: TObject;
begin
  with FListItem.LockList do try
    //for i := Count - 1 downto 0 do begin
    for i := Count - 1 downto 0 do begin
      obj := Items[i];
      if Assigned(obj) then
      begin
//        try
        if (obj is TBaseSimObject) and (obj as TBaseSimObject).AbsoluteFree then begin
          FreeAndNil(obj);
          //obj.Free;
          Delete(i);
        end;
//        finally
//
//        end;
      end;
    end;
    pack;

  finally
    FListItem.UnlockList;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TSimContainer.FindObjectByUid(const aUid: string): TBaseSimObject;
var
  i: integer;
  obj: TBaseSimObject;
  found: boolean;
begin
  result := nil;
  obj := nil;
  with FListItem.LockList do try
    i := 0;
    found := false;
    while not found and (i < Count) do begin
      obj := TBaseSimObject(Items[i]);
      found := aUid = obj.UniqueID;

      inc(i);
    end;
  finally
    FListItem.UnlockList;
  end;
  if found then result := obj;

end;

{ TSimIterators }
//==============================================================================

constructor TSimIterators.Create;
begin
  inherited;

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

destructor TSimIterators.Destroy;
begin

  inherited;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TSimIterators.Iterate(cl: TClass): boolean;
var
  i: integer;
  l: TList;
begin
  result := false;
  if not Assigned(FList) then exit;
  if not Assigned(FOnGetItem) then exit;

  l := FList.GetList;
  i := 0;
  FLastItem := nil;

  while (i < l.Count) do begin
    FLastItem := l[i];
    if FLastItem is cl then
      FOnGetItem(FLastItem);
    inc(i)
  end;
  result := true;

  FList.ReturnList;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TSimIterators.Find: TObject;
var
  i: integer;
  b: boolean;
  l: TList;
begin
  result := nil;
  if not Assigned(FList) then exit;
  if not Assigned(FOnSearchItem) then exit;

  l := FList.GetList;
  FLastItem := nil;

  i := 0;
  b := false;
  while not b and (i < l.Count) do begin
    FLastItem := l[i];
    b := FOnSearchItem(FLastItem);
    inc(i)
  end;
  FList.ReturnList;
  if b then result := FLastItem;
end;

//==============================================================================
{ TListIterators }

constructor TListIterators.Create;
begin

end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

destructor TListIterators.Destroy;
begin

  inherited;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TListIterators.Find: TObject;
var
  i: integer;
  b: boolean;
begin
  result := nil;
  if not Assigned(NList) then exit;
  if not Assigned(FOnSearchItem) then exit;

  LastItem := nil;

  i := 0;
  b := false;
  while not b and (i < NList.Count) do begin
    LastItem := NList[i];
    b := FOnSearchItem(LastItem);
    inc(i)
  end;
  if b then
    result := LastItem
  else
    result := nil;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TListIterators.Iterate: boolean;
var
  i: integer;
begin
  result := false;
  if not Assigned(NList) then exit;
  if not Assigned(FOnGetItem) then exit;

  i := 0;
  LastItem := nil;

  while (i < NList.Count) do begin
    LastItem := NList[i];
    FOnGetItem(LastItem);
    inc(i)
  end;
  result := true;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure ClearAndFreeItems(var l: TList);
var
  i: integer;
  o: TObject;
begin
  for i := l.Count - 1 downto 0 do begin
    o := l[i];
    o.Free;
  end;
  l.Clear;
  l.Pack;

end;

procedure FreeItemsAndFreeList(var l: TList);
var
  i: integer;
  o: TObject;
begin
  for i := l.Count - 1 downto 0 do begin
    o := l[i];
    o.Free;
  end;
  l.Clear;
  l.Free;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure ClearAndFreeItems(var tl: TThreadList);
var
  i: integer;
  o: TObject;
  l: TList;
begin
  l := tl.LockList;
  for i := l.Count - 1 downto 0 do begin
    o := l[i];
    o.Free;
  end;
  l.Clear;
  l.Pack;
  tl.UnlockList;

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure ClearAndFreeItems(var sl: TStrings);
var
  i: integer;
  o: TObject;
begin
  for i := sl.Count - 1 downto 0 do begin
    o := sl.Objects[i];
    o.Free;
  end;
  sl.Clear;
end;

end.
