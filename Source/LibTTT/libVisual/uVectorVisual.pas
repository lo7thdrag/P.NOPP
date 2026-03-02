unit uVectorVisual;

interface

uses
  Windows, Graphics, uSimVisuals, uCoordConvertor, uDataTypes, uConstantaData,
  Math, uBaseCoordSystem, uObjectVisuals;

type

  TVectorSymbol = class(TDrawElement)
  private
    function GetCallSign(const Index: Integer): String;
    procedure SetCallSign(const Index: Integer; const Value: String);
    procedure SetControlled(const Value: boolean);
    procedure SetCourse(const Value: Double);
    procedure SetDimLength(const Value: Double);
    procedure SetDimWidth(const Value: Double);
    procedure SetSelected(const Value: boolean);
  protected
    FCourse        : Double;
    FDimLength     : Double;
    FDimWidth      : Double;
    FSelected      : boolean;
    FControlled    : boolean;
    FColorSelected : TColor;

    FTextVisuals   : array [0..2] of TTextVisual;
    FRectArea      : TRect;
    FCallSigns     : array [0..2] of string;

    procedure InitPoints;virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;

    property Course    : Double read FCourse write SetCourse;
    property DimWidth  : Double read FDimWidth write SetDimWidth;    // in feet
    property DimLength : Double read FDimLength write SetDimLength;  // in feet
    property CallSign1  : String index 1 read GetCallSign write SetCallSign;
    property CallSign2  : String index 2 read GetCallSign write SetCallSign;
    property CallSign3  : String index 3 read GetCallSign write SetCallSign;

    property Selected       : boolean read FSelected write SetSelected ;
    property Controlled     : boolean read FControlled write SetControlled;
  end;

  TShipVectorSymbol = class(TVectorSymbol)
  private
    FPoints        : array [0..4] of TPoint;
  protected
    procedure InitPoints; override;
  public
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

  TAirPlaneVectorSymbol = class(TVectorSymbol)
  private
    FPoints        : array [0..14] of TPoint;
  protected
    procedure InitPoints; override;
  public
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

  THelicopterVectorSymbol = class(TVectorSymbol)
  private
    FPoints        : array [0..20] of TPoint;
    FRotary1, FRotary2 : array [0..1] of TPoint;
  protected
    procedure InitPoints; override;
  public
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

  TTankVectorSymbol = class(TVectorSymbol)
  private
    FPoints        : array of TPoint;
    FTurretPts     : array [0..1] of TPoint;
  protected
    procedure InitPoints; override;
  public
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

  TSubSurfaceVectorSymbol = class (TVectorSymbol)
  private
//    FPoints        : array of TPoint;
  protected
    procedure InitPoints; override;
  public
    procedure ConvertCoord(cvt: TCoordConverter); override;
    procedure Draw(aCanvas: TCanvas); override;
  end;

implementation

{ TVectorSymbol }

procedure TShipVectorSymbol.ConvertCoord(cvt: TCoordConverter);
const
  C_LRATIO = 2 / 3;
var
  halfL, halfW, mx,my,cx,cy : double;
  mapPt : array [0..4] of TPointBOL;
  I, l,w, ctx, cty: Integer;
begin
  {    0
       /\
     4/  \1
      |* |    L
      |  |
     3----2
        W
  }

  { find center mappoint of ship }
  cvt.ConvertToMap(Center.X,Center.Y,cx,cy);

  { scale ship to map }
  halfL := DimLength / 2 * C_Feet_To_Meter * C_Meter_To_NauticalMile; // in nM
  halfW := DimWidth / 2 * C_Feet_To_Meter * C_Meter_To_NauticalMile;  // in nM

  { find front mappoint ship, point 0 }
  RangeBearingToCoord(halfL,Course,mx,my);
  mapPt[0].x := cx + mx;
  mapPt[0].y := cy + my;

  { find lower mappoint ship (between 2 and 3) }
  //RangeBearingToCoord(halfL,Course + 180,mx,my);
  mx := cx - mx;
  my := cy - my;

  { find point 2,3 }
  RangeBearingToCoord(halfW,Course + 90,cx,cy);
  mapPt[2].x := mx + cx;
  mapPt[2].y := my + cy;
  mapPt[3].x := mx - cx;
  mapPt[3].y := my - cy;

  { find point 1 and 4 using length ratio }
  RangeBearingToCoord(halfL * 2 * C_LRATIO,Course,mx,my);
  mapPt[1].x := mapPt[2].x + mx;
  mapPt[1].y := mapPt[2].y + my;
  mapPt[4].x := mapPt[3].x + mx;
  mapPt[4].y := mapPt[3].y + my;

  { convert all to screen coordinate }
  for I := 0 to Length(mapPt) - 1 do
    cvt.ConvertToScreen(mapPt[I].x,mapPt[I].y,FPoints[I].X,FPoints[I].Y);

  { create vector rect boundary }
  FRectArea.Left  := FPoints[0].X;
  FRectArea.Right := FPoints[0].X;
  FRectArea.Top   := FPoints[0].Y;
  FRectArea.Bottom:= FPoints[0].Y;

  for I := 0 to Length(FPoints) - 1 do
  begin
    // most left
    if FPoints[I].X < FRectArea.Left then
      FRectArea.Left := FPoints[I].X;

    // most right
    if FPoints[I].X > FRectArea.Right then
      FRectArea.Right := FPoints[I].X;

    // most top
    if FPoints[I].Y < FRectArea.Top then
      FRectArea.Top := FPoints[I].Y;

    // most bottom
    if FPoints[I].Y > FRectArea.Bottom then
      FRectArea.Bottom := FPoints[I].Y;
  end;

  w := Abs(FRectArea.Right - FRectArea.Left) ;
  l := Abs(FRectArea.Bottom - FRectArea.Top) ;
  ctx := FRectArea.Left + ( w div 2 );
  cty := FRectArea.Top + ( l div 2 );

  if l >= w then // samakan dengan l
  begin
    FRectArea.Left  := ctx - ( l div 2 );
    FRectArea.Right := ctx + ( l div 2 );
  end else
  // samakan dengan w
  begin
    FRectArea.Top   := cty - ( w div 2 );
    FRectArea.Bottom:= cty + ( w div 2 );
  end;

  { text call sign 3 rows }
  for I := 0 to Length(FTextVisuals) - 1 do
  begin
    FTextVisuals[I].Center := Center;
    //FTextVisuals[I].Offset.X := Abs(FRectArea.Right - Center.X);
    FTextVisuals[I].Offset.X := 0;
    FTextVisuals[I].Offset.Y := Abs(FRectArea.Top - Center.Y) + ( 10 * I );
  end;

end;


procedure TShipVectorSymbol.Draw(aCanvas: TCanvas);
var
  I : integer;
begin
  inherited;

  if not Visible then
    exit;

  { dont draw if dimension not valid }
  if (DimWidth <= 0) or (DimLength <= 0) then
    Exit;

  with aCanvas do begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psSolid;

    Brush.Color := Color;
    Polygon(FPoints);

    for I := 0 to Length(FTextVisuals) - 1 do
    begin
      FTextVisuals[I].Color := Color;
      FTextVisuals[I].Text := FCallSigns[I];
//      FTextVisuals[I].Draw(aCanvas);
    end;

    if FSelected then
    begin
      with aCanvas do
      begin

        Pen.Style := psSolid;
        Pen.Width := 1;
        Pen.Color := FColorSelected;
        Brush.Style := bsClear;

        Rectangle(
            FRectArea.Left - 2, FRectArea.Top - 2,
            FRectArea.Right + 2,FRectArea.Bottom + 2);
      end;
    end;

    if FControlled then
    begin
      with aCanvas do
      begin
        Pen.Width := 1;
        pen.Style := psSolid;
        Pen.Color := clWhite;
        Brush.Style := bsClear;

        Rectangle(FRectArea);
      end;
    end;
  end;

end;

procedure TShipVectorSymbol.InitPoints;
var
  I: Integer;
begin
  inherited;

  for I := 0 to Length(FPoints) - 1 do
  begin
    FPoints[I].X := 0;
    FPoints[I].Y := 0;
  end;
end;


{ TVectorSymbol }

procedure TVectorSymbol.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

end;

constructor TVectorSymbol.Create;
var
  I : integer;
begin

  for I := 0 to Length(FTextVisuals) - 1 do
  begin
    FTextVisuals[I] := TTextVisual.Create;
    FTextVisuals[I].FontName := 'Tahoma';
    FTextVisuals[I].Size := 6;
  end;

  FDimWidth   := 0;
  FDimLength  := 0;
  FColorSelected := clrSelected;

  InitPoints;

  Visible := True;
end;

destructor TVectorSymbol.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FTextVisuals) - 1 do
    FTextVisuals[I].Free;
  inherited;
end;

procedure TVectorSymbol.Draw(aCanvas: TCanvas);
begin
  inherited;

end;

function TVectorSymbol.GetCallSign(const Index: Integer): String;
begin
  result := FCallSigns[Index - 1];
end;

procedure TVectorSymbol.InitPoints;
begin

end;

procedure TVectorSymbol.SetCallSign(const Index: Integer; const Value: String);
begin
  FCallSigns[Index - 1] := Value;
end;

procedure TVectorSymbol.SetControlled(const Value: boolean);
begin
  FControlled := Value;
end;

procedure TVectorSymbol.SetCourse(const Value: Double);
begin
  FCourse := Value;
end;

procedure TVectorSymbol.SetDimLength(const Value: Double);
begin
  FDimLength := Value;
end;

procedure TVectorSymbol.SetDimWidth(const Value: Double);
begin
  FDimWidth := Value;
end;

procedure TVectorSymbol.SetSelected(const Value: boolean);
var
  I : integer;
begin
  FSelected := Value;

  if FSelected  then begin
    for I := 0 to Length(FTextVisuals) - 1 do
      FTextVisuals[I].Color         := FColorSelected;
  end
  else begin
    for I := 0 to Length(FTextVisuals) - 1 do
      FTextVisuals[I].Color         := FColor;
  end;
end;

{ TAirPlaneVectorSymbol }

procedure TAirPlaneVectorSymbol.ConvertCoord(cvt: TCoordConverter);
const
  C_LRATIO = 2 / 3;
  ZOOMRATIO = 1;
var
  upperhalfL,lowerhalfL, halfW,
  mx,my,mx2, my2, cx,cy, tmp : double;
  mapPt : array [0..14] of TPointBOL;
  BasePtCtr : array [0..1] of TPointBOL;
  I, l,w, ctx, cty: Integer;
begin
  inherited;
  {
           0
           /\
         1|  |14
         2|  |13          L
   3____ /    \____12
   |       *        |
   |______    ______|
   4     5|  |10     11
        6/    \9
        7------8

            W
    * -> center of gravity base on LRatio

  }

  {multiply dimension : visualizaion purpose}
  FDimWidth := ZOOMRATIO * DimWidth;
  FDimLength:= ZOOMRATIO * DimLength;

  { find center mappoint of plane  }
  cvt.ConvertToMap(Center.X,Center.Y,cx,cy);

  { scale plane to map }
  upperhalfL := DimLength * C_LRATIO * C_Feet_To_Meter * C_Meter_To_NauticalMile; // in nM
  lowerhalfL := DimLength * (1 - C_LRATIO) * C_Feet_To_Meter * C_Meter_To_NauticalMile; // in nM
  halfW := DimWidth / 2 * C_Feet_To_Meter * C_Meter_To_NauticalMile;  // in nM

  { find front mappoint, point 0 }
  RangeBearingToCoord(upperhalfL,Course,mx,my);
  mapPt[0].x := cx + mx;
  mapPt[0].y := cy + my;

  { find base pt left and right side center point }
  RangeBearingToCoord(halfW / 4, Course + 90 ,mx,my);
  BasePtCtr[0].x := cx - mx;
  BasePtCtr[0].y := cy - my;
  BasePtCtr[1].x := cx + mx;
  BasePtCtr[1].y := cy + my;

  { find point 1, 14 }
  RangeBearingToCoord(upperhalfL * (2/3),Course, mx, my);
  mapPt[1].x := BasePtCtr[0].x + mx;
  mapPt[1].y := BasePtCtr[0].y + my;
  mapPt[14].x := BasePtCtr[1].x + mx;
  mapPt[14].y := BasePtCtr[1].y + my;

  { find point 2, 13 }
  RangeBearingToCoord((upperhalfL * (2/3)) * (1/3),Course, mx, my);
  mapPt[2].x := BasePtCtr[0].x + mx;
  mapPt[2].y := BasePtCtr[0].y + my;
  mapPt[13].x := BasePtCtr[1].x + mx;
  mapPt[13].y := BasePtCtr[1].y + my;

  { find point 3, 12 }
  RangeBearingToCoord(halfW , Course + 90 ,mx,my);
  mapPt[3].x := cx - mx;
  mapPt[3].y := cy - my;
  mapPt[12].x := cx + mx;
  mapPt[12].y := cy + my;

  { find point 4, 11 }
  RangeBearingToCoord(lowerhalfL * (1/3), Course + 180, mx, my);
  mapPt[4].x := mapPt[3].x + mx;
  mapPt[4].y := mapPt[3].y + my;
  mapPt[11].x := mapPt[12].x + mx;
  mapPt[11].y := mapPt[12].y + my;

  { find point 5, 10 }
  mapPt[5].x := BasePtCtr[0].x + mx;
  mapPt[5].y := BasePtCtr[0].y + my;
  mapPt[10].x := BasePtCtr[1].x + mx;
  mapPt[10].y := BasePtCtr[1].y + my;

  { find point 6, 9 }
  tmp := lowerhalfL * (2/3) * (1/3);
  tmp := (lowerhalfL * (1/3)) + tmp;
  RangeBearingToCoord(tmp, Course + 180, mx, my);
  mapPt[6].x := BasePtCtr[0].x + mx;
  mapPt[6].y := BasePtCtr[0].y + my;
  mapPt[9].x := BasePtCtr[1].x + mx;
  mapPt[9].y := BasePtCtr[1].y + my;

  {find point 7,8}
  RangeBearingToCoord(lowerhalfL * (1/3), Course + 180, mx, my);
  mx2 := cx + mx;
  my2 := cy + my;
  RangeBearingToCoord(halfW / 2, Course + 90, mx, my);
  mapPt[7].x := mx2 - mx;
  mapPt[7].y := my2 - my;
  mapPt[8].x := mx2 + mx;
  mapPt[8].y := my2 + my;

  { convert all to screen coordinate }
  for I := 0 to Length(mapPt) - 1 do
    cvt.ConvertToScreen(mapPt[I].x,mapPt[I].y,FPoints[I].X,FPoints[I].Y);

  { create vector rect boundary }
  FRectArea.Left  := FPoints[0].X;
  FRectArea.Right := FPoints[0].X;
  FRectArea.Top   := FPoints[0].Y;
  FRectArea.Bottom:= FPoints[0].Y;

  for I := 0 to Length(FPoints) - 1 do
  begin
    // most left
    if FPoints[I].X < FRectArea.Left then
      FRectArea.Left := FPoints[I].X;

    // most right
    if FPoints[I].X > FRectArea.Right then
      FRectArea.Right := FPoints[I].X;

    // most top
    if FPoints[I].Y < FRectArea.Top then
      FRectArea.Top := FPoints[I].Y;

    // most bottom
    if FPoints[I].Y > FRectArea.Bottom then
      FRectArea.Bottom := FPoints[I].Y;
  end;

  w := Abs(FRectArea.Right - FRectArea.Left) ;
  l := Abs(FRectArea.Bottom - FRectArea.Top) ;
  ctx := FRectArea.Left + ( w div 2 );
  cty := FRectArea.Top + ( l div 2 );

  if l >= w then // samakan dengan l
  begin
    FRectArea.Left  := ctx - ( l div 2 );
    FRectArea.Right := ctx + ( l div 2 );
  end else
  // samakan dengan w
  begin
    FRectArea.Top   := cty - ( w div 2 );
    FRectArea.Bottom:= cty + ( w div 2 );
  end;

  { text call sign 3 rows }
  for I := 0 to Length(FTextVisuals) - 1 do
  begin
    FTextVisuals[I].Center := Center;
    //FTextVisuals[I].Offset.X := Abs(FRectArea.Right - Center.X);
    FTextVisuals[I].Offset.X := 0;
    FTextVisuals[I].Offset.Y := Abs(FRectArea.Top - Center.Y) + ( 10 * I );
  end;

end;


procedure TAirPlaneVectorSymbol.Draw(aCanvas: TCanvas);
var
  I : integer;
begin
  inherited;

  if not Visible then
    exit;

  { dont draw if dimension not valid }
  if (DimWidth <= 0) or (DimLength <= 0) then
    Exit;

  with aCanvas do begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psSolid;

    Brush.Color := Color;
    Polygon(FPoints);

    for I := 0 to Length(FTextVisuals) - 1 do
    begin
      FTextVisuals[I].Color := Color;
      FTextVisuals[I].Text := FCallSigns[I];
      FTextVisuals[I].Draw(aCanvas);
    end;

    if FSelected then
    begin
      with aCanvas do
      begin

        Pen.Style := psSolid;
        Pen.Width := 1;
        Pen.Color := FColorSelected;
        Brush.Style := bsClear;

        Rectangle(
            FRectArea.Left - 2, FRectArea.Top - 2,
            FRectArea.Right + 2,FRectArea.Bottom + 2);
      end;
    end;

    if FControlled then
    begin
      with aCanvas do
      begin
        Pen.Width := 1;
        pen.Style := psSolid;
        Pen.Color := clWhite;
        Brush.Style := bsClear;

        Rectangle(FRectArea);
      end;
    end;
  end;
end;

procedure TAirPlaneVectorSymbol.InitPoints;
var
  I: Integer;
begin
  for I := 0 to Length(FPoints) - 1 do
  begin
    FPoints[I].X := 0;
    FPoints[I].Y := 0;
  end;
end;

{ THelicopterVectorSymbol }

procedure THelicopterVectorSymbol.ConvertCoord(cvt: TCoordConverter);
const
  C_LRATIO = 2 / 3;
  ZOOMRATIO = 1;
var
  halfL, halfW,
  mx,my,mx2, my2, cx,cy, tmp : double;
  mapPt : array [0..20] of TPointBOL;
  BasePtCtr : array [0..1] of TPointBOL;
  Rot1, Rot2 : array [0..1] of TPointBOL;
  I, l,w, ctx, cty: Integer;
begin
  inherited;

  {
            0
           /\
     1 +  /  \  + 20
        + |  |+
   3 2 |==|  |==| 19 18
   4 5 |==|* |==| 16 17
        + |  |+
   6 7 +   ||   + 14 15
           ||
   9 8   |====|   13 12
  10                 11

 }

  {multiply dimension : visualization purpose}
  FDimWidth := ZOOMRATIO * DimWidth;
  FDimLength:= ZOOMRATIO * DimLength;

  { find center mappoint of plane  }
  cvt.ConvertToMap(Center.X,Center.Y,cx,cy);

  { scale plane to map }
  halfL := DimLength/ 2 * C_Feet_To_Meter * C_Meter_To_NauticalMile; // in nM
  halfW := DimWidth / 2 * C_Feet_To_Meter * C_Meter_To_NauticalMile;  // in nM

  { find front mappoint, point 0 }
  RangeBearingToCoord(halfL,Course,mx,my);
  mapPt[0].x := cx + mx;
  mapPt[0].y := cy + my;

  { find base pt left and right side center point }
  RangeBearingToCoord(halfW / 3, Course + 90 ,mx,my);
  BasePtCtr[0].x := cx - mx;
  BasePtCtr[0].y := cy - my;
  BasePtCtr[1].x := cx + mx;
  BasePtCtr[1].y := cy + my;

  { find point 1, 20}
  RangeBearingToCoord(halfL * (2/3),Course,mx,my);
  mapPt[1].x := BasePtCtr[0].x + mx;
  mapPt[1].y := BasePtCtr[0].y + my;
  mapPt[20].x := BasePtCtr[1].x + mx;
  mapPt[20].y := BasePtCtr[1].y + my;

  { find point 2, 19}
  tmp := halfL * (2/3) * (1/4);
  RangeBearingToCoord(tmp,Course,mx,my);
  mapPt[2].x := BasePtCtr[0].x + mx;
  mapPt[2].y := BasePtCtr[0].y + my;
  mapPt[19].x := BasePtCtr[1].x + mx;
  mapPt[19].y := BasePtCtr[1].y + my;

  { find point 3, 18}
  RangeBearingToCoord(halfW * (2/3),Course + 270,mx,my);
  mapPt[3].x := mapPt[2].x + mx;
  mapPt[3].y := mapPt[2].y + my;
  RangeBearingToCoord(halfW * (2/3),Course + 90,mx,my);
  mapPt[18].x := mapPt[19].x + mx;
  mapPt[18].y := mapPt[19].y + my;

  { find point 5, 16}
  mapPt[5].x := BasePtCtr[0].x;
  mapPt[5].y := BasePtCtr[0].y;
  mapPt[16].x := BasePtCtr[1].x;
  mapPt[16].y := BasePtCtr[1].y;

  { find point 4, 17}
  RangeBearingToCoord(halfW * (2/3),Course + 270,mx,my);
  mapPt[4].x := mapPt[5].x + mx;
  mapPt[4].y := mapPt[5].y + my;
  RangeBearingToCoord(halfW * (2/3),Course + 90,mx,my);
  mapPt[17].x := mapPt[16].x + mx;
  mapPt[17].y := mapPt[16].y + my;

  { find point 6, 15}
  RangeBearingToCoord(halfW * (1/3),Course + 180,mx,my);
  mapPt[6].x := BasePtCtr[0].x + mx;
  mapPt[6].y := BasePtCtr[0].y + my;
  mapPt[15].x := BasePtCtr[1].x + mx;
  mapPt[15].y := BasePtCtr[1].y + my;

  { find point 7, 14}
  tmp := CalcRange(BasePtCtr[0].x,BasePtCtr[0].y,BasePtCtr[1].x,BasePtCtr[1].y);
  tmp := tmp / 3;
  RangeBearingToCoord(tmp,Course + 90, mx,my);
  mapPt[7].x := mapPt[6].x + mx;
  mapPt[7].y := mapPt[6].y + my;
  RangeBearingToCoord(tmp,Course + 270, mx,my);
  mapPt[14].x := mapPt[15].x + mx;
  mapPt[14].y := mapPt[15].y + my;

  { find point 8, 13}
  tmp := halfL - ( halfL * (1/5) );
  RangeBearingToCoord(tmp,Course + 180, mx,my);
  mapPt[8].x := mapPt[7].x + mx;
  mapPt[8].y := mapPt[7].y + my;
  mapPt[13].x := mapPt[14].x + mx;
  mapPt[13].y := mapPt[14].y + my;

  { find point 9, 12}
  RangeBearingToCoord(halfW / 2,Course + 270, mx,my);
  mapPt[9].x := mapPt[8].x + mx;
  mapPt[9].y := mapPt[8].y + my;
  RangeBearingToCoord(halfW / 2,Course + 90, mx,my);
  mapPt[12].x := mapPt[13].x + mx;
  mapPt[12].y := mapPt[13].y + my;

  { find point 10, 11}
  tmp := halfL - ( halfL * (4/5) );
  RangeBearingToCoord(tmp,Course + 180, mx,my);
  mapPt[10].x := mapPt[9].x + mx;
  mapPt[10].y := mapPt[9].y + my;
  mapPt[11].x := mapPt[12].x + mx;
  mapPt[11].y := mapPt[12].y + my;

  { convert all to screen coordinate }
  for I := 0 to Length(mapPt) - 1 do
    cvt.ConvertToScreen(mapPt[I].x,mapPt[I].y,FPoints[I].X,FPoints[I].Y);

  {set rotary point}
  RangeBearingToCoord(halfL , Course + 315,mx,my);
  Rot1[0].X := cx + mx;
  Rot1[0].Y := cy + my;
  RangeBearingToCoord(halfL ,Course + 135,mx,my);
  Rot1[1].X := cx + mx;
  Rot1[1].Y := cy + my;

  RangeBearingToCoord(halfL , Course + 45,mx,my);
  Rot2[0].X := cx + mx;
  Rot2[0].Y := cy + my;
  RangeBearingToCoord(halfL ,Course + 225,mx,my);
  Rot2[1].X := cx + mx;
  Rot2[1].Y := cy + my;

  for I := 0 to Length(Rot1) - 1 do
  begin
    cvt.ConvertToScreen(Rot1[I].x,Rot1[I].y,FRotary1[I].X,FRotary1[I].Y);
    cvt.ConvertToScreen(Rot2[I].x,Rot2[I].y,FRotary2[I].X,FRotary2[I].Y);
  end;

  { create vector rect boundary }
  FRectArea.Left  := FPoints[0].X;
  FRectArea.Right := FPoints[0].X;
  FRectArea.Top   := FPoints[0].Y;
  FRectArea.Bottom:= FPoints[0].Y;

  for I := 0 to Length(FPoints) - 1 do
  begin
    // most left
    if FPoints[I].X < FRectArea.Left then
      FRectArea.Left := FPoints[I].X;

    // most right
    if FPoints[I].X > FRectArea.Right then
      FRectArea.Right := FPoints[I].X;

    // most top
    if FPoints[I].Y < FRectArea.Top then
      FRectArea.Top := FPoints[I].Y;

    // most bottom
    if FPoints[I].Y > FRectArea.Bottom then
      FRectArea.Bottom := FPoints[I].Y;
  end;

  w := Abs(FRectArea.Right - FRectArea.Left) ;
  l := Abs(FRectArea.Bottom - FRectArea.Top) ;
  ctx := FRectArea.Left + ( w div 2 );
  cty := FRectArea.Top + ( l div 2 );

  if l >= w then // samakan dengan l
  begin
    FRectArea.Left  := ctx - ( l div 2 );
    FRectArea.Right := ctx + ( l div 2 );
  end else
  // samakan dengan w
  begin
    FRectArea.Top   := cty - ( w div 2 );
    FRectArea.Bottom:= cty + ( w div 2 );
  end;

  { text call sign 3 rows }
  for I := 0 to Length(FTextVisuals) - 1 do
  begin
    FTextVisuals[I].Center := Center;
    //FTextVisuals[I].Offset.X := Abs(FRectArea.Right - Center.X);
    FTextVisuals[I].Offset.X := 0;
    FTextVisuals[I].Offset.Y := Abs(FRectArea.Top - Center.Y) + ( 10 * I );
  end;


end;

procedure THelicopterVectorSymbol.Draw(aCanvas: TCanvas);
var
  I : integer;
begin
  inherited;

  if not Visible then
    exit;

  { dont draw if dimension not valid }
  if (DimWidth <= 0) or (DimLength <= 0) then
    Exit;

  with aCanvas do begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psSolid;

    Brush.Color := Color;
    Polygon(FPoints);

    {rotary draw}
    Pen.Width := 4;

    MoveTo(FRotary1[0].X, FRotary1[0].Y);
    LineTo(FRotary1[1].X, FRotary1[1].Y);
    MoveTo(FRotary2[0].X, FRotary2[0].Y);
    LineTo(FRotary2[1].X, FRotary2[1].Y);

    for I := 0 to Length(FTextVisuals) - 1 do
    begin
      FTextVisuals[I].Color := Color;
      FTextVisuals[I].Text := FCallSigns[I];
      FTextVisuals[I].Draw(aCanvas);
    end;

    if FSelected then
    begin
      with aCanvas do
      begin

        Pen.Style := psSolid;
        Pen.Width := 1;
        Pen.Color := FColorSelected;
        Brush.Style := bsClear;

        Rectangle(
            FRectArea.Left - 2, FRectArea.Top - 2,
            FRectArea.Right + 2,FRectArea.Bottom + 2);
      end;
    end;

    if FControlled then
    begin
      with aCanvas do
      begin
        Pen.Width := 1;
        pen.Style := psSolid;
        Pen.Color := clWhite;
        Brush.Style := bsClear;

        Rectangle(FRectArea);
      end;
    end;
  end;
end;

procedure THelicopterVectorSymbol.InitPoints;
var
  I: Integer;
begin
  for I := 0 to Length(FPoints) - 1 do
  begin
    FPoints[I].X := 0;
    FPoints[I].Y := 0;
  end;
end;

{ TTankVectorSymbol }

procedure TTankVectorSymbol.ConvertCoord(cvt: TCoordConverter);
const
  ZOOMRATIO = 1;
var
  mapPt     : array [0..3] of TPointBOL;
  TurretPt  : array [0..1] of TPointBOL;
  mx,my,halfL, halfW, cx,cy, tmpx, tmpy : double;
  I, l,w, ctx, cty: Integer;
begin
  inherited;

{
         +
         +
  1  ||=====||  4
     ||  +  ||
     ||  +  ||
     ||     ||
  2  ||=====||  3
}
  {multiply dimension : visualization purpose}
  FDimWidth := ZOOMRATIO * DimWidth;
  FDimLength:= ZOOMRATIO * DimLength;

  { find center mappoint of tank  }
  cvt.ConvertToMap(Center.X,Center.Y,cx,cy);

  { scale to map }
  halfL := DimLength/ 2 * C_Feet_To_Meter * C_Meter_To_NauticalMile; // in nM
  halfW := DimWidth / 2 * C_Feet_To_Meter * C_Meter_To_NauticalMile;  // in nM

  { find middle point 1-2 }
  RangeBearingToCoord(halfW,Course + 270,mx,my);
  tmpx := cx + mx;
  tmpy := cy + my;

  { find point 1 }
  RangeBearingToCoord(halfL,Course ,mx,my);
  mapPt[0].x := tmpx + mx;
  mapPt[0].y := tmpy + my;

  { find point 2 }
  RangeBearingToCoord(halfL,Course + 180,mx,my);
  mapPt[1].x := tmpx + mx;
  mapPt[1].y := tmpy + my;

  { find middle point 3-4 }
  RangeBearingToCoord(halfW,Course + 90,mx,my);
  tmpx := cx + mx;
  tmpy := cy + my;

  { find point 3 }
  RangeBearingToCoord(halfL,Course + 180,mx,my);
  mapPt[2].x := tmpx + mx;
  mapPt[2].y := tmpy + my;

  { find point 4 }
  RangeBearingToCoord(halfL,Course ,mx,my);
  mapPt[3].x := tmpx + mx;
  mapPt[3].y := tmpy + my;

  {turret}
  RangeBearingToCoord(DimLength,Course ,mx,my);
  TurretPt[0].x := cx;
  TurretPt[0].y := cy;
  TurretPt[1].x := cx + mx;
  TurretPt[1].y := cy + my;

  { convert all to screen coordinate }
  for I := 0 to Length(mapPt) - 1 do
    cvt.ConvertToScreen(mapPt[I].x,mapPt[I].y,FPoints[I].X,FPoints[I].Y);
  for I := 0 to Length(TurretPt) - 1 do
    cvt.ConvertToScreen(TurretPt[I].x,TurretPt[I].y,FTurretPts[I].X,FTurretPts[I].Y);

  { create vector rect boundary }
  FRectArea.Left  := FPoints[0].X;
  FRectArea.Right := FPoints[0].X;
  FRectArea.Top   := FPoints[0].Y;
  FRectArea.Bottom:= FPoints[0].Y;

  for I := 0 to Length(FPoints) - 1 do
  begin
    // most left
    if FPoints[I].X < FRectArea.Left then
      FRectArea.Left := FPoints[I].X;

    // most right
    if FPoints[I].X > FRectArea.Right then
      FRectArea.Right := FPoints[I].X;

    // most top
    if FPoints[I].Y < FRectArea.Top then
      FRectArea.Top := FPoints[I].Y;

    // most bottom
    if FPoints[I].Y > FRectArea.Bottom then
      FRectArea.Bottom := FPoints[I].Y;
  end;

  w := Abs(FRectArea.Right - FRectArea.Left) ;
  l := Abs(FRectArea.Bottom - FRectArea.Top) ;
  ctx := FRectArea.Left + ( w div 2 );
  cty := FRectArea.Top + ( l div 2 );

  if l >= w then // samakan dengan l
  begin
    FRectArea.Left  := ctx - ( l div 2 );
    FRectArea.Right := ctx + ( l div 2 );
  end else
  // samakan dengan w
  begin
    FRectArea.Top   := cty - ( w div 2 );
    FRectArea.Bottom:= cty + ( w div 2 );
  end;

  { text call sign 3 rows }
  for I := 0 to Length(FTextVisuals) - 1 do
  begin
    FTextVisuals[I].Center := Center;
    //FTextVisuals[I].Offset.X := Abs(FRectArea.Right - Center.X);
    FTextVisuals[I].Offset.X := 0;
    FTextVisuals[I].Offset.Y := Abs(FRectArea.Top - Center.Y) + ( 10 * I );
  end;
end;

procedure TTankVectorSymbol.Draw(aCanvas: TCanvas);
var
  I : integer;
begin
  inherited;

  if not Visible then
    exit;

  { dont draw if dimension not valid }
  if (DimWidth <= 0) or (DimLength <= 0) then
    Exit;

  with aCanvas do begin
    Pen.Color := Color;
    Pen.Width := 1;
    Pen.Style := psSolid;

    Brush.Color := Color;
    Polygon(FPoints);

    {turret draw}
    Pen.Width := 1;
//    MoveTo(FTurretPts[0].X,FTurretPts[0].Y);
//    LineTo(FTurretPts[1].X,FTurretPts[1].Y);

    for I := 0 to Length(FTextVisuals) - 1 do
    begin
      FTextVisuals[I].Color := Color;
      FTextVisuals[I].Text := FCallSigns[I];
      FTextVisuals[I].Draw(aCanvas);
    end;

    if FSelected then
    begin
      with aCanvas do
      begin

        Pen.Style := psSolid;
        Pen.Width := 1;
        Pen.Color := FColorSelected;
        Brush.Style := bsClear;

        Rectangle(
            FRectArea.Left - 2, FRectArea.Top - 2,
            FRectArea.Right + 2,FRectArea.Bottom + 2);
      end;
    end;

    if FControlled then
    begin
      with aCanvas do
      begin
        Pen.Width := 1;
        pen.Style := psSolid;
        Pen.Color := clWhite;
        Brush.Style := bsClear;

        Rectangle(FRectArea);
      end;
    end;
  end;
end;

procedure TTankVectorSymbol.InitPoints;
var
  i : integer;
begin
  inherited;

  SetLength(FPoints,4);

  for I := 0 to Length(FPoints) - 1 do
  begin
    FPoints[I].X := 0;
    FPoints[I].Y := 0;
  end;

end;

{ TSubSurfaceVectorSymbol }

procedure TSubSurfaceVectorSymbol.ConvertCoord(cvt: TCoordConverter);
begin
  inherited;

end;

procedure TSubSurfaceVectorSymbol.Draw(aCanvas: TCanvas);
begin
  inherited;

end;

procedure TSubSurfaceVectorSymbol.InitPoints;
begin
  inherited;

end;

end.
