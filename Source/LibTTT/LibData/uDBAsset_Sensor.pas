unit uDBAsset_Sensor;

interface

uses
  {Delphi Uses}
  Classes,

  {Project Uses}
  uSimObjects, uConstantaData, uRecordData, uSimContainers;

type

  TSensor = class(TSimObject)

  public
    constructor Create;
    destructor Destroy;override;

  end;

  TRadar_On_Board = class(TSensor)

  public
    FData : TRecRadar_On_Board;
    FDef  : TRecRadar_Definition;

    constructor Create;
    destructor Destroy; override;
  end;

  TSonar_On_Board = class (TSensor)

  public
    FData : TRecSonar_On_Board;
    FDef  : TRecSonar_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TESM_On_Board = class(TSensor)

  public
    FData : TRecESM_On_Board;
    FDef  : TRecESM_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TMAD_On_Board = class(TSensor)

  public
    FData : TRecMAD_On_Board;
    FDef  : TRecMAD_Definition;

    constructor Create;
    destructor Destroy;override;

  end;

  TEOD_On_Board = class(TSensor)

  public
    FData : TRecEOD_On_Board;
    FDef  : TRecEOD_Definition;

    constructor Create;
    destructor Destroy;override;

  end;

  TSonobuoy_On_Board = class(TSensor)

  public
    FData : TRecSonobuoy_On_Board;
    FDef  : TRecSonobuoy_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TIFF_On_Board = class(TSensor)

  public

    constructor Create;
    destructor Destroy;override;
  end;

  TFCR_On_Board = class(TSensor)

  public

    constructor Create;
    destructor Destroy;override;
  end;

  TVisual_On_Board = class (TSensor)

  public

    constructor Create;
    destructor Destroy;override;
  end;

implementation

{$REGION ' TRadar_On_Board '}

constructor TRadar_On_Board.Create;
begin

end;

destructor TRadar_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TSonar_On_Board '}

constructor TSonar_On_Board.Create;
begin

end;

destructor TSonar_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TESM_On_Board '}

constructor TESM_On_Board.Create;
begin

end;

destructor TESM_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TMAD_On_Board '}

constructor TMAD_On_Board.Create;
begin

end;

destructor TMAD_On_Board.Destroy;
begin

  inherited;
end;
{$ENDREGION}

{$REGION ' TEOD_On_Board '}

constructor TEOD_On_Board.Create;
begin

end;

destructor TEOD_On_Board.Destroy;
begin

end;

{$ENDREGION}

{$REGION ' TSonobuoy_On_Board '}

constructor TSonobuoy_On_Board.Create;
begin

end;

destructor TSonobuoy_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TIFF_On_Board '}

constructor TIFF_On_Board.Create;
begin

end;

destructor TIFF_On_Board.Destroy;
begin

  inherited;
end;
{$ENDREGION}

{$REGION ' TFCR_On_Board '}

constructor TFCR_On_Board.Create;
begin

end;

destructor TFCR_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TVisual_Sensor_On_Board '}

constructor TVisual_On_Board.Create;
begin

end;

destructor TVisual_On_Board.Destroy;
begin

  inherited;
end;
{$ENDREGION}

{$REGION ' TSensor_On_Board '}

constructor TSensor.Create;
begin

end;

destructor TSensor.Destroy;
begin

  inherited;
end;
{$ENDREGION}

end.
