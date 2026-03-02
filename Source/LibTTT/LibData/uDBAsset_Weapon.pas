unit uDBAsset_Weapon;

interface

uses
  {Delphi Uses}
  Classes,

  {Project Uses}
  uSimObjects, uConstantaData, uRecordData, uSimContainers;

type

  TMissile_On_Board = class (TSimObject)

  public
    FData : TRecFitted_Weapon_On_Board;
    FDef  : TRecMissile_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TTorpedo_On_Board = class (TSimObject)

  public
    FData : TRecFitted_Weapon_On_Board;
    FDef  : TRecTorpedo_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TGun_On_Board = class(TSimObject)

  public
    FData : TRecPoint_Effect_On_Board;
    FDef  : TRecGun_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TBomb_On_Board = class(TSimObject)

  public
    FData : TRecPoint_Effect_On_Board;
    FDef  : TRecBomb_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TMine_On_Board = class(TSimObject)

  public
    FData : TRecFitted_Weapon_On_Board;
    FDef  : TRecMine_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  implementation

uses uDataModule;

{$region  ' TMissile_On_Board '}

constructor TMissile_On_Board.Create;
begin

end;

destructor TMissile_On_Board.Destroy;
begin

  inherited;
end;
{$ENDREGION}

{$region  ' TTorpedo_On_Board '}

constructor TTorpedo_On_Board.Create;
begin

end;

destructor TTorpedo_On_Board.Destroy;
begin

  inherited;
end;
{$ENDREGION}

{$REGION ' TGun_Definition '}

constructor TGun_On_Board.Create;
begin

end;

destructor TGun_On_Board.Destroy;
begin

  inherited;
end;
{$ENDREGION}

{$REGION ' TBomb_Definition '}

constructor TBomb_On_Board.Create;
begin

end;

destructor TBomb_On_Board.Destroy;
begin
  inherited;
end;
{$ENDREGION}

{$REGION ' TMine_On_Board '}

constructor TMine_On_Board.Create;
begin

end;

destructor TMine_On_Board.Destroy;
begin

  inherited;
end;
{$ENDREGION}

end.
