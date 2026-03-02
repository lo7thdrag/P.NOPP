unit uShipView;

interface

uses
  Classes, uDataTypes, Graphics;

type

  TRecShipSize = record
    Length,
    Beam,
    Draft  : Double;
  end;

  TRecShipShape = record
    pts: array[0..4] of t2DPoint;
  end;

  function CreateShipShape(const sz: TRecShipSize ): TRecShipShape;

  function RotateShipShape(const org: TRecShipShape; const d: Double): TRecShipShape;
  function TranslateShipShape(const org: TRecShipShape; const x, y: double): TRecShipShape;
  function ScaleShipShape(const org: TRecShipShape; const s: double): TRecShipShape;


implementation

uses
  Math;

const
  CShapeSize = 5;

{  function CreateShipShape(const sz : TRecShipSize ): TRecShipShape;
  //sz : TRecShipSize is in meter.
  // north up
  var hl, hw: Double;
      x,  y: Double;
      dLeft, dRight, dTop, dBot, dQuad : Double;

  begin
    x := 0;
    y := 0;

    hw := 0.5 * sz.Beam;
    dLeft   := x - hw;
    dRight  := x + hw;

    hl := 0.5 * sz.Length;
    dTop  := y - hl;
    dQuad := y - 0.5 * hl;
    dBot  := y + hl;

    with Result do begin
      pts[0].X   := x;      //dFront.X       := x;
      pts[0].Y   := dTop;   //dFront.Y       := dTop;
        //
      pts[1].X   := dLeft;  //dLeftFront.X   := dLeft;
      pts[1].Y   := dQuad;  //dLeftFront.Y   := dQuad;

      pts[2].X   := dLeft;  //dLeftBack.X    := dLeft;
      pts[2].Y   := dBot;   //dLeftBack.Y    := dBot;


      pts[3].X   := dRight; //dRightBack.X   := dRight;
      pts[3].Y   := dBot;   //dRightBack.Y   := dBot;

      pts[4].X   := dRight; //dRightFront.X  := dRight;
      pts[4].Y   := dQuad;  //dRightFront.Y  := dQuad;
    end;

  end;
}
  function CreateShipShape(const sz : TRecShipSize ): TRecShipShape;
  //sz : TRecShipSize is in meter.
  var hl, hw: Double;
      x,  y: Double;
      dLeft, dRight, dTop, dBot, dQuad : Double;
  begin
    x := 0;
    y := 0;

    hw := 0.5 * sz.Beam;
    dLeft   := y - hw;
    dRight  := y + hw;

    hl := 0.5 * sz.Length;
    dTop  := x + hl;
    dQuad := x + 0.5 * hl;
    dBot  := x - hl;

    //   ______
    //  |      \
    //  |______/
    with Result do begin
      pts[0].X   := dTop;   //dFront.X       := x;
      pts[0].Y   := y;      //dFront.Y       := dTop;

      pts[1].X   := dQuad;  //dLeftFront.X   := dLeft;
      pts[1].Y   := dLeft;  //dLeftFront.Y   := dQuad;

      pts[2].X   := dBot;  //dLeftBack.X    := dLeft;
      pts[2].Y   := dLeft;   //dLeftBack.Y    := dBot;


      pts[3].X   := dBot; //dRightBack.X   := dRight;
      pts[3].Y   := dRight;   //dRightBack.Y   := dBot;

      pts[4].X   := dQuad; //dRightFront.X  := dRight;
      pts[4].Y   := dRight;  //dRightFront.Y  := dQuad;
    end;

  end;

  function RotateShipShape(const org: TRecShipShape; const d: Double): TRecShipShape;
  var i: Integer;
      aSin, aCos: Extended;
  begin
    SinCos(DegToRad( d), aSin, aCos);
    for i := 0 to CShapeSize-1  do  
      Result.pts[i] := Rotate2DPoint(org.pts[i], aSin, aCos);
  end;


  function TranslateShipShape(const org: TRecShipShape; const x, y: double): TRecShipShape;
  var i: Integer;
      off: t2DPoint;
  begin
    off.X := x;
    off.Y := y;
    for i := 0 to CShapeSize-1  do
      Result.pts[i] := Translate2DPoint( org.pts[i] , off );
  end;

  function ScaleShipShape(const org: TRecShipShape; const s: double): TRecShipShape;
  var i: Integer;
      sc: t2DPoint;
  begin
    sc.X := s;
    sc.Y := s;
    for i := 0 to CShapeSize-1  do
      Result.pts[i] := Scale2DPoint( org.pts[i], sc);
  end;

end.
