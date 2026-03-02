unit uOverlay;

interface

uses
  MapXLib_TLB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ImgList, ComCtrls, ToolWin, uBaseCoordSystem,
  OleCtrls, uMapXHandler, uCoordConvertor, uGameData_TTT,
  {TeCanvas,} ColorGrd, uDataTypes, uT3Unit, uLibSettingTTT, tttData, uSnapshotData;

type

//  TBeaRng = record
//    Range : Double;
//    Bearing  : Double;
//  end;
//
//  TGrid  = record
//    gridLongitude : string[30];
//    gridLatitude  : string[30];
//  end;
//
//  TMainTrackSelection = class
//  private
//    FTrackInstanceIndex: Integer;
//    FTrackId: string;
//    FConverter: TCoordConverter;
//
//    procedure SetTrackId(const Value: string);
//    procedure SetTrackInstanceIndex(const Value: Integer);  protected
//    procedure SetConverter(const Value: TCoordConverter); protected
//
//  public
//    Parent : TT3PlatformInstance;
//    Orientation : Byte; {0: Relative; 1: True}
//    RangeOffset : Double;
//    BearingOffset, Rotation : Integer;
//    isDraw : Boolean;
//
//    constructor Create(cvt : TCoordConverter);
//    procedure Draw(aCnv: TCanvas); virtual;
//    destructor Destroy; override;
//
//    property TrackId   : string read FTrackId write SetTrackId;
//    property TrackInstanceIndex   : Integer read FTrackInstanceIndex write SetTrackInstanceIndex;
//    property Converter : TCoordConverter read FConverter write SetConverter;
//  end;

  TMainOverlayTemplate = class
  private
    FOverlayIndex : Integer;
    FIdx : Integer;
    FName : string;
    FTipe : Integer;
    FDomain : Integer;
    FCubicle : Integer;
    FForce : Integer;
    FRole : Byte;
    FRoleName : string;
    FisShow : Boolean;
    FStaticList : TList; {Container overlay static}
    FDynamicList : TList; {Container overlay dynamic}
    FListAttachShip : TList; {list kapal yg di attach}

  protected
    procedure SetName(const Value: string);
    procedure SetTipe(const Value: Integer);
    procedure SetDomain(const Value: Integer);
    procedure SetCubicle(const Value: Integer);

  public
    FMap : TMap;
    FCanvas : TCanvas;

    constructor create;
    destructor Destroy; override;

    function GetSnapshotData : _SS_TMainOverlayTemplate;

    procedure Clear;
    procedure Draw(FCanvas: TCanvas; FMap: TMap); virtual;
    procedure Save; virtual; abstract;

//    procedure AddListTrack(ListTrack : TMainTrackSelection);

    property OverlayIndex : Integer read FOverlayIndex write FOverlayIndex;
    property Name : string read FName write SetName;
    property Tipe : Integer read FTipe write SetTipe;
    property Domain : Integer read FDomain write SetDomain;
    property Cubicle : Integer read FCubicle write SetCubicle;
    property Idx : Integer read FIdx write FIdx;
    property Force : Integer read FForce write FForce;
    property Role : Byte read FRole write FRole;
    property RoleName : string read FRoleName write FRoleName;
    property isShow : Boolean read FisShow write FisShow;
    property StaticList : TList read FStaticList write FStaticList;
    property DynamicList : TList read FDynamicList write FDynamicList;
    property ListAttachShip : TList read FListAttachShip write FListAttachShip;
  end;



implementation

uses
  uMainStaticShape, uMainDynamicShape;

procedure TMainOverlayTemplate.AddListTrack(ListTrack: TMainTrackSelection);
begin
  ListAttachShip.Add(ListTrack);
end;

procedure TMainOverlayTemplate.Clear;
begin
  FStaticList.Clear;
  FDynamicList.Clear;
  FListAttachShip.Clear;
end;

constructor TMainOverlayTemplate.create;
begin
  FStaticList := TList.Create;
  FDynamicList := TList.Create;
  FListAttachShip := TList.Create;
end;

destructor TMainOverlayTemplate.destroy;
begin
  inherited;
  FStaticList.Free;
  FDynamicList.Free;
  FListAttachShip.Free;
end;

procedure TMainOverlayTemplate.Draw(FCanvas: TCanvas; FMap: TMap);
var
  i, j : Integer;
  StaticShape : TMainStaticShape;
  DynamicShape : TMainDynamicShape;
  Ship : TMainTrackSelection;
begin
  FCanvas.Pen.Style := psSolid;
  case Tipe of
    osDynamic :
    begin
      for i := 0 to FListAttachShip.Count - 1 do
      begin
        Ship := FListAttachShip[i];

        for j := 0 to DynamicList.Count - 1 do
        begin
          DynamicShape := DynamicList[j];
          DynamicShape.Parent := Ship.Parent;
          DynamicShape.RangeOffset := Ship.RangeOffset;
          DynamicShape.BearingOffset := Ship.BearingOffset;
          DynamicShape.RotationOffset := Ship.Rotation;
          DynamicShape.Orientation := Ship.Orientation;

          DynamicShape.Draw(FCanvas);
        end;
        Ship.Draw(FCanvas);
      end;
    end;
    osStatic :
    begin
      if not FisShow then
        Exit;

      for i := 0 to StaticList.Count - 1 do
      begin
        StaticShape := StaticList[i];
        StaticShape.Draw(FCanvas);
      end;
    end;
  end;
end;

function TMainOverlayTemplate.GetSnapshotData: _SS_TMainOverlayTemplate;
var
  s : _SS_TMainOverlayTemplate;
begin
  s.OverlayIndex := OverlayIndex;
  s.Name := Name;
  s.Domain := Domain;
  s.Cubicle := Cubicle;
  s.Idx := Idx;
  s.Role := Role;
  s.RoleName := RoleName;
  s.Tipe := Tipe;

  Result := s;
end;

procedure TMainOverlayTemplate.SetCubicle(const Value: Integer);
begin
  FCubicle := Value;
end;

procedure TMainOverlayTemplate.SetDomain(const Value: Integer);
begin
  FDomain := Value;
end;

procedure TMainOverlayTemplate.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TMainOverlayTemplate.SetTipe(const Value: Integer);
begin
  FTipe := Value;
end;

{ TMainTrackSelection }


constructor TMainTrackSelection.create;
begin
  FConverter := cvt;
end;

destructor TMainTrackSelection.Destroy;
begin

  inherited;
end;

procedure TMainTrackSelection.Draw(aCnv: TCanvas);
var
  sx, sy : Integer;

  mx, my, BpOffset : Double;
  pOffset :  t2DPoint;
begin
  inherited;
  if not Assigned(Parent) then Exit;
  if (Parent.Dormant) or (Parent.FreeMe) then Exit;

  case Orientation of
    0 : BpOffset := ValidateDegree(Parent.Heading + BearingOffset);
    1 : BpOffset := ValidateDegree(BearingOffset);
  end;

  {Point offset from Ship}
  RangeBearingToCoord(RangeOffset, BpOffset, mx, my);
  pOffset.X := Parent.PosX + mx;
  pOffset.Y := Parent.PosY + my;

  Converter.ConvertToScreen(pOffset.X, pOffset.Y, sx, sy);

  with aCnv do
  begin
    Brush.Style := bsClear;

    Pen.Color := clBlack;

    MoveTo(sx-5,sy); LineTo(sx+5,sy);
    MoveTo(sx,sy-5); LineTo(sx,sy+5);
  end;
end;

procedure TMainTrackSelection.SetConverter(const Value: TCoordConverter);
begin

end;

procedure TMainTrackSelection.SetTrackId(const Value: string);
begin
  FTrackId := Value;
end;

procedure TMainTrackSelection.SetTrackInstanceIndex(const Value: Integer);
begin
  FTrackInstanceIndex := Value;
end;

end.


