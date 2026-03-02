unit uMapXData;

interface

uses
  MapXLib_TLB;

type

  TSimMapData = class
  private
  protected

    FLyrDepth     : CMapXLayer;
    FmDSet        : CMapXDataset;
    FmPt          : CMapXPoint;
    FmRowVals     : CMapXRowValues;
    FLastFeatKey  : string;
    FLastDVal1, FLastDVal2 : double;

    FLyrLands : array [0..5] of CMapXLayer;
    FLyrAreas : array [1..5] of CMapXLayer;

  public
    DMap          : TMap;
    constructor Create;
    destructor Destroy; override;

    procedure LoadDataMap(const mData: string);
    procedure LoadMap(aGeoset: String);

    function GetMapDepth(const x, y: double; var d1, d2: double): boolean;
//    function GetMapLand(const x, y: double): boolean;
    function GetMapLand(const x, y: double; var d1, d2: double): boolean;


  end;


var
  VMapData: TSimMapData;

implementation

uses
  SysUtils, Windows, ComObj;

procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).vType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;


{ TSimMapData }

constructor TSimMapData.Create;
begin
  DMap := TMap.Create(nil);
  FmPt := CoPoint.Create;
end;

destructor TSimMapData.Destroy;
begin
  inherited;
end;

procedure TSimMapData.LoadMap(aGeoset: String);
var
  i: Integer;
  z: OleVariant;
  //mInfo: CMapXLayerInfo;
begin
  if DMap = nil then
    Exit;
  InitOleVariant(z);
  DMap.Layers.RemoveAll;

  DMap.Geoset := aGeoset;

  if aGeoset <> '' then
  begin
    for i := 1 to DMap.Layers.Count do
    begin
      DMap.Layers.Item(i).Selectable := false;
      DMap.Layers.Item(i).Editable  := False;
//      FMap.Layers.Item(i).AutoLabel := True;
    end;
  end;
  DMap.BackColor := RGB(192, 224, 255);
//  FConverter.FMap := FMap;
end;

procedure TSimMapData.LoadDataMap(const mData: string);
const
  CDepthName   = 'area_kedalaman';
  CLayerName: array [1..5] of string =
   ('ID1000_',
    'ID2000_',
    'ID3000_',
    'ID4000_',
    'ID5000_');

   CCoastland = 'Coastline';
   CLand =  'land';
   CArea =  'area_coverage';
var
    i: Integer;
    Z : OleVariant;
begin
  DMap.Layers.RemoveAll;
  InitOleVariant(Z);
  FLyrDepth := nil;
  FmDSet    := nil;
  FLastFeatKey := '';

  if not FileExists(mData) then
    Exit;

  DMap.Geoset := mData;
  try
    FLyrDepth := DMap.Layers.Item(CDepthName);
  except
    on EOleException do
      FLyrDepth := nil;
  end;
  FmDSet := DMap.Datasets.Add( miDataSetLayer, FLyrDepth ,CDepthName, Z, Z, Z, Z, Z );

  try
    FLyrLands[0] := DMap.Layers.Item(CCoastland);
  except
    on EOleException do
      FLyrLands[0] := nil;
  end;

  for i := 1 to 5 do begin
    try
      FLyrLands[i] := DMap.Layers.Item(CLayerName[i]+ CLand);
    except
      on EOleException do
        FLyrLands[i] := nil;
    end;
  end;

  for i := 1 to 5 do begin
    try
      FLyrAreas[i] := DMap.Layers.Item(CLayerName[i]+ CArea);
    except
      on EOleException do
        FLyrAreas[i] := nil;
    end;
  end;
end;

function TSimMapData.GetMapDepth(const x, y: double; var d1,
  d2: double): boolean;
var
    fs: CMapXFeatures;
    f : CMapXFeature;
    i : integer;
begin
  Result := False;
  if FLyrDepth = nil then Exit;

  d1 := 1000;
  d2 := -1000;

  FmPt.Set_(x, y);

  //try
    fs := FLyrDepth.SearchAtPoint(FmPt);
    //count := fs.Count;
  //finally
    //count := 0;
  //end;

  if fs.Count > 0 then
  begin
    for I := 1 to fs.Count do
    begin
      try
        f := fs.Item(i);
        if f.FeatureKey <> FLastFeatKey then begin
          //the problem is here:  memory sucker
          //      mRowVals := FmDSet.RowValues[f.FeatureID];
          FmRowVals := FmDSet.RowValues[f.featureKey];

          if (d1 >= FmRowVals.Item('DRVAL1___1').Value) then
            d1 := FmRowVals.Item('DRVAL1___1').Value;

          if (d2 <= FmRowVals.Item('DRVAL2___2').Value) then   // tertinggi
            d2 := FmRowVals.Item('DRVAL2___2').Value;

          FLastFeatKey  := f.FeatureKey;
          FLastDVal1    := d1;
          FLastDVal2    := d2;
        end
        else begin
          d1 := FLastDVal1;
          d2 := FLastDVal2;
        end;
      finally
      end;
    end;

    Result := True;
  end;
end;

function TSimMapData.GetMapLand(const x, y: double; var d1, d2: double): boolean;
var
    i : Integer;
    fs: CMapXFeatures;
    found: Boolean;
begin
  FmPt.Set_(x, y);
  d1 := 0;
  d2 := 0;
  found := False;

  for i := 5 downto 1 do begin
    try
      if FLyrLands[i] = nil then
        Continue;

      fs := FLyrLands[i].SearchAtPoint(FmPt);

      if fs.Count > 0 then
      begin
        found := true;
        Break;
      end;
    finally
    end;
  end;

  result := found;
end;

//function TSimMapData.GetMapLand(const x, y: double): boolean;
//var i : Integer;
//    fs: CMapXFeatures;
//    found: Boolean;
//begin
//  FmPt.Set_(x, y);
//
//  result := False;
//
//  found := False;
//  for i := 5 downto 1 do begin
//    if FLyrLands[i] = nil then
//      Continue;
//    fs := FLyrAreas[i].SearchAtPoint(FmPt);
//    if fs.Count > 0 then begin
//      found := true;
//      Break;
//    end;
//  end;
//  if found then begin
//    fs := FLyrLands[i].SearchAtPoint(FmPt);
//    if fs.Count > 0 then
//      Result := True;
//  end
//  else begin
//    if FLyrLands[0] <> nil then begin
//      fs := FLyrLands[0].SearchAtPoint(FmPt);
//      if fs.Count > 0 then
//        Result := True;
//    end;
//  end;
//end;

end.
