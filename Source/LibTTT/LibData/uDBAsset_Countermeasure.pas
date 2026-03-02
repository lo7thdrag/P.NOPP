unit uDBAsset_Countermeasure;

interface

uses
  {Delphi Uses}
  Classes,

  {Project Uses}
  uSimObjects, uConstantaData, uRecordData, uSimContainers;

type

  TChaff_On_Board = class

  public
    FData : TRecChaff_On_Board;
    FDef  : TRecChaff_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TAir_Bubble_On_Board = class

  public
    FData           : TRecAir_Bubble_On_Board;
    FDef  : TRecAir_Bubble_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TAcoustic_Decoy_On_Board = class

  public
    FData  : TRecAcoustic_Decoy_On_Board;
    FDef  : TRecAcoustic_Decoy_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TInfrared_Decoy_On_Board = class

  public
    FData               : TRecInfrared_Decoy_On_Board;
    FDef  : TRecInfrared_Decoy_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TFloating_Decoy_On_Board = class

  public
    FData              : TRecFloating_Decoy_On_Board;
    FDef  : TRecFloating_Decoy_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TTowed_Decoy_On_Board = class

  public
    FData : TRecTowed_Decoy_On_Board;
    FDef  : TRecTowed_Decoy_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TDefensive_Jammer_On_Board = class

  public
    FData                : TRecDefensive_Jammer_On_Board;
    FDef  : TRecDefensive_Jammer_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TRadar_Noise_Jammer_On_Board = class

  public
    FData  : TRecRadar_Noise_Jammer_On_Board;
    FDef  : TRecRadar_Noise_Jammer_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

implementation

{$REGION ' TChaff_On_Board '}

constructor TChaff_On_Board.Create;
begin

end;

destructor TChaff_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION  ' TAir_Bubble_On_Board '}

constructor TAir_Bubble_On_Board.Create;
begin

end;

destructor TAir_Bubble_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TAcoustic_Decoy_On_Board '}

constructor TAcoustic_Decoy_On_Board.Create;
begin
  inherited;
end;

destructor TAcoustic_Decoy_On_Board.Destroy;
begin
  inherited;
end;

{$ENDREGION}

{$REGION ' TInfrared_Decoy_On_Board '}

constructor TInfrared_Decoy_On_Board.Create;
begin

end;

destructor TInfrared_Decoy_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TFloating_Decoy_On_Board '}

constructor TFloating_Decoy_On_Board.Create;
begin

end;

destructor TFloating_Decoy_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TTowed_Decoy_On_Board '}

constructor TTowed_Decoy_On_Board.Create;
begin

end;

destructor TTowed_Decoy_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TDefensive_Jammer_On_Board '}

constructor TDefensive_Jammer_On_Board.Create;
begin

end;

destructor TDefensive_Jammer_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TRadar_Noise_Jammer_On_Board '}

constructor TRadar_Noise_Jammer_On_Board.Create;
begin

end;

destructor TRadar_Noise_Jammer_On_Board.Destroy;
begin

  inherited;
end;

{$ENDREGION}

end.
