unit uDBAsset_Vehicle;

interface

uses
  {Delphi Uses}
  Classes,

  {Project Uses}
  uDBAsset_Weapon, uDBAsset_Sensor, uDBAsset_Countermeasure, uConstantaData, uRecordData, uSimContainers;

type


  TVehicle_Definition = class

  public
    FDef  : TRecVehicle_Definition;

    {Weapon}
    Missiles : TList;
    Torpedos : TList;
    Hybrids  : TList;
    Guns     : TList;
    Bombs    : TList;
    Mines    : TList;

    {Sensor}
    Radars    : TList;
    Sonars    : TList;
    ESMs      : TList;
    EODs      : TList;
    MADs      : TList;
    Sonobuoy  : TList;
    IFFs      : TList;
    Visuals   : TList;
    FCRs      : TList;

    {Countermeasure}
    Chaffs          : TList;
    Air_Bubble      : TList;
    Acoustic_Decoys : TList;
    Infrared_Decoys : TList;
    Floating_Decoys : TList;
    Towed_Decoys    : TList;
    Defensive_Jammers   : TList;
    Radar_Noise_Jammers : TList;

    constructor Create;
    destructor Destroy; override;
  end;


implementation

{ TVehicle_Definition }

constructor TVehicle_Definition.Create;
begin
  {weapons}
  Missiles := TList.Create;
  Torpedos := TList.Create;
  Hybrids  := TList.Create;
  Guns     := TList.Create;
  Bombs    := TList.Create;
  Mines    := TList.Create;

  {sensors}
  Radars    := TList.Create;
  Sonars    := TList.Create;
  ESMs      := TList.Create;
  EODs      := TList.Create;
  MADs      := TList.Create;
  Sonobuoy  := TList.Create;
  IFFs      := TList.Create;
  Visuals   := TList.Create;
  FCRs      := TList.Create;

  {countermeasure}
  Chaffs              := TList.Create;
  Air_Bubble          := TList.Create;
  Acoustic_Decoys     := TList.Create;
  Infrared_Decoys     := TList.Create;
  Floating_Decoys     := TList.Create;
  Towed_Decoys        := TList.Create;
  Defensive_Jammers   := TList.Create;
  Radar_Noise_Jammers := TList.Create;
end;

destructor TVehicle_Definition.Destroy;
begin
  {weapons}
  FreeItemsAndFreeList(Missiles);
  FreeItemsAndFreeList(Torpedos);
  FreeItemsAndFreeList(Hybrids);
  FreeItemsAndFreeList(Guns);
  FreeItemsAndFreeList(Bombs);
  FreeItemsAndFreeList(Mines);

  {sensors}
  FreeItemsAndFreeList(Radars);
  FreeItemsAndFreeList(Sonars);
  FreeItemsAndFreeList(ESMs);
  FreeItemsAndFreeList(EODs);
  FreeItemsAndFreeList(MADs);
  FreeItemsAndFreeList(Sonobuoy);
  FreeItemsAndFreeList(IFFs);
  FreeItemsAndFreeList(Visuals);
  FreeItemsAndFreeList(FCRs);

  {countermeasure}
  FreeItemsAndFreeList(Chaffs);
  FreeItemsAndFreeList(Air_Bubble);
  FreeItemsAndFreeList(Acoustic_Decoys);
  FreeItemsAndFreeList(Infrared_Decoys);
  FreeItemsAndFreeList(Floating_Decoys);
  FreeItemsAndFreeList(Towed_Decoys);
  FreeItemsAndFreeList(Defensive_Jammers);
  FreeItemsAndFreeList(Radar_Noise_Jammers);

  inherited;
end;

end.
