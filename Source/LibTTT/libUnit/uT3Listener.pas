unit uT3Listener;

interface

type
  TPropIntVal = procedure (PropName : string;PropValue : Integer) of object;
  TPropDblVal = procedure (PropName : string;PropValue : Double) of object;
  TPropBoolVal = procedure (PropName : string;PropValue : Boolean) of object;
  TPropStrVal = procedure (PropName : string;PropValue : String) of object;

  TIntProc  = procedure (Value : Integer) of object;
  TDblProc  = procedure (Value : Double) of object;
  TBoolProc = procedure (Value : Boolean) of object;
  TByteProc = procedure (Value : Byte) of object;

  {Properties ID}
  TPropsID =
    (
      // weapon, sensor, counter measure properties
      psQuantity, psControlMode, psSalvoMode, psSalvoSize, psSetTarget,
      psInterceptRgn, psThresSpeed, psAssigned, psBreak, psWeaponStatus,
      psCeaseFire, psNGScorrectLR, psNGScorrectDA, psChaffPosition, psChaffBloom,
      psSensorOpStatus, psCMStatus,

      // platform
      psHeading, psSpeed, psPosition, psDamage, psAltitudeDepth,
      psForceDesig,psFuelCapacity,psFuelEndurance,psLaunchTime,psTrack_ID,
      psDormantTime, psDormant,

      // unit
      psVisible, psTrackNumber,

      // vehicle

      // game setting properties
      psChaffAttenuationOnRadar, psChaffRemovalEvent,
      psSonobuoyRemovalEvent, psBubbleRemovalEvent,
      psAutomaticRemovePlatformOutsideArea,
      psTimeRemoveWreck, psCoastlineCollision,
      psAircraftTerrainColl, psTidalStreamEffectToShip,
      psWindEffectToAircraft, psSimplifySensorCheck,
      psProbabilityOfKill, psGuidanceCommand,
      psStudentLaunchRestriction, psStudentCanLaunchAirCraft,
      psLandmassOcculting, psSensorBlindZone, psVisualVisibility,
      psAutomaticSensorIdentity, psAirTrackLostContactTime,
      psSurfaceTrackLostContactTime, psSubSurfaceTrackLostContatTime,
      psESMTrackLostContactTime, psAcousticTrackLostContactTimer,
      psAirTrackDropTime, psSurfaceTrackDropTime,
      psSubsurfaceTrackDropTime, psESMTrackDropTime, psAcousticTrackDropTime
    );

  TPropsIntProc   = procedure (Sender : TObject;Props : TPropsID; Value : Integer) of object;
  TPropsDblProc   = procedure (Sender : TObject;Props : TPropsID; Value : Double)  of object;
  TPropsBoolProc  = procedure (Sender : TObject;Props : TPropsID; Value : Boolean) of object;
  TPropsByteProc  = procedure (Sender : TObject;Props : TPropsID; Value : Byte)    of object;
  TPropsStrProc   = procedure (Sender : TObject;Props : TPropsID; Value : String)    of object;

  // custom proc object
  TProp2DblProc = procedure(Sender : TObject;Props : TPropsID; ValueX, ValueY : double) of object;

  TEventListener = class
  private
    FListenerID: String;
    procedure SetListenerID(const Value: String);

  protected
    procedure Release;virtual;
  public
    destructor Destroy;override;
    property ListenerID : String read FListenerID write SetListenerID;
  end;

  TPropertyEventListener = class(TEventListener)
  private
    FOnPropertyByteChange: TPropsByteProc;
    FOnPropertyDblChange: TPropsDblProc;
    FOnPropertyIntChange: TPropsIntProc;
    FOnPropertyBoolChange: TPropsBoolProc;
    FOnPropertyStrChange: TPropsStrProc;
    procedure SetOnPropertyDblChange(const Value: TPropsDblProc);
    procedure SetOnPropertyIntChange(const Value: TPropsIntProc);
    procedure SetOnPropertyBoolChange(const Value: TPropsBoolProc);
    procedure SetOnPropertyByteChange(const Value: TPropsByteProc);
    procedure SetOnPropertyStrChange(const Value: TPropsStrProc);
  protected
    procedure Release;override;
  public
    procedure PropertyIntChange(Sender : TObject;PropsID : TPropsID; Value : integer);
    procedure PropertyDblChange(Sender : TObject;PropsID : TPropsID; Value : double);
    procedure PropertyBoolChange(Sender : TObject;PropsID : TPropsID; Value : boolean);
    procedure PropertyByteChange(Sender : TObject;PropsID : TPropsID; Value : Byte);
    procedure PropertyStrChange(Sender : TObject;PropsID : TPropsID; Value : String);

    property OnPropertyIntChange : TPropsIntProc read FOnPropertyIntChange write SetOnPropertyIntChange;
    property OnPropertyDblChange : TPropsDblProc read FOnPropertyDblChange write SetOnPropertyDblChange;
    property OnPropertyBoolChange : TPropsBoolProc read FOnPropertyBoolChange write SetOnPropertyBoolChange;
    property OnPropertyByteChange : TPropsByteProc read FOnPropertyByteChange write SetOnPropertyByteChange;
    property OnPropertyStrChange : TPropsStrProc read FOnPropertyStrChange write SetOnPropertyStrChange;
  end;

  TT3BombOnVehicleListener = class(TPropertyEventListener)
  end;

  TT3MineOnVehicleListener = class(TPropertyEventListener)
  end;

  //farid add for hybrid
  TT3HybridOnVehicleListener = class(TPropertyEventListener)
  end;

  TT3GunOnVehicleListener = class(TPropertyEventListener)
  private
    FOnChaffPosition: TProp2DblProc;

    procedure SetOnChaffPosition(const Value: TProp2DblProc);

  protected
    procedure Release;override;
  public
    // custom event
    property OnChaffPosition : TProp2DblProc read FOnChaffPosition write SetOnChaffPosition;
  end;

  TT3VehicleListener = class(TPropertyEventListener)

  end;

  // Hambali add for launcher
  TPropTorpOnVhcLauncher = procedure (Sender : TObject;Launcher : TObject;Value : integer) of object;
  TT3TorpedoOnVehicleListener = class(TPropertyEventListener)
  private
    FOnPropertyLauncherChange: TPropTorpOnVhcLauncher;
    procedure SetOnPropertyLauncherChange(const Value: TPropTorpOnVhcLauncher);
  protected
    procedure Release;override;
  public
    property OnPropertyLauncherChange : TPropTorpOnVhcLauncher read FOnPropertyLauncherChange write SetOnPropertyLauncherChange;
  end;

  TPropMissOnVhcLauncher = procedure (Sender : TObject;Launcher : TObject;Value : integer) of object;
  TT3MissileOnVehicleListener = class(TPropertyEventListener)
  private
    FOnPropertyLauncherChange: TPropMissOnVhcLauncher;
    procedure SetOnPropertyLauncherChange(const Value: TPropMissOnVhcLauncher);
  protected
    procedure Release;override;
  public
    property OnPropertyLauncherChange : TPropMissOnVhcLauncher read FOnPropertyLauncherChange write SetOnPropertyLauncherChange;
  end;

  TT3ChaffLauncherListener = class(TEventListener)
  private
    FOnDelayChange: TIntProc;
    FOnBloomRangeChange: TDblProc;
    FOnBloomAltitudeChange: TDblProc;
    FOnSalvoChange: TIntProc;
    FOnStateChange: TIntProc;
    procedure SetOnDelayChange(const Value: TIntProc);
    procedure SetOnBloomAltitudeChange(const Value: TDblProc);
    procedure SetOnBloomRangeChange(const Value: TDblProc);
    procedure SetOnSalvoChange(const Value: TIntProc);
    procedure SetOnStateChange(const Value: TIntProc);
  protected
    procedure Release;override;
  public
    procedure DelayChange(Value : integer);
    procedure SalvoSizeChange(Value : integer);
    procedure BloomRangeChange(Value : double);
    procedure BloomAltitudeChange(Value : double);
    procedure StateChange(Value : integer);

    property OnDelayChange : TIntProc read FOnDelayChange write SetOnDelayChange;
    property OnSalvoChange : TIntProc read FOnSalvoChange write SetOnSalvoChange;
    property OnBloomRangeChange : TDblProc read FOnBloomRangeChange write SetOnBloomRangeChange;
    property OnBloomAltitudeChange : TDblProc read FOnBloomAltitudeChange write SetOnBloomAltitudeChange;
    property OnStateChange : TIntProc read FOnStateChange write SetOnStateChange;
  end;


implementation

{ TT3ChaffLauncherListener }

procedure TT3ChaffLauncherListener.BloomAltitudeChange(Value: double);
begin
  if Assigned(FOnBloomAltitudeChange) then
    FOnBloomAltitudeChange(Value);
end;

procedure TT3ChaffLauncherListener.BloomRangeChange(Value: double);
begin
  if Assigned(FOnBloomRangeChange) then
    FOnBloomRangeChange(Value);
end;

procedure TT3ChaffLauncherListener.DelayChange(Value: integer);
begin
  if Assigned(FOnDelayChange) then
    FOnDelayChange(Value);
end;

procedure TT3ChaffLauncherListener.Release;
begin
  inherited;

  FOnDelayChange      := nil;
  FOnBloomRangeChange := nil;
  FOnBloomAltitudeChange:= nil;
  FOnSalvoChange := nil;
  FOnStateChange := nil;

end;

procedure TT3ChaffLauncherListener.SalvoSizeChange(Value: integer);
begin
  if Assigned(FOnSalvoChange) then
    FOnSalvoChange(Value);
end;

procedure TT3ChaffLauncherListener.SetOnBloomAltitudeChange(
  const Value: TDblProc);
begin
  FOnBloomAltitudeChange := Value;
end;

procedure TT3ChaffLauncherListener.SetOnBloomRangeChange(const Value: TDblProc);
begin
  FOnBloomRangeChange := Value;
end;

procedure TT3ChaffLauncherListener.SetOnDelayChange(const Value: TIntProc);
begin
  FOnDelayChange := Value;
end;

procedure TT3ChaffLauncherListener.SetOnSalvoChange(const Value: TIntProc);
begin
  FOnSalvoChange := Value;
end;

procedure TT3ChaffLauncherListener.SetOnStateChange(const Value: TIntProc);
begin
  FOnStateChange := Value;
end;

procedure TT3ChaffLauncherListener.StateChange(Value: integer);
begin
  if Assigned(FOnStateChange) then
    FOnStateChange(Value);
end;

{ TPropertyEventListener }

procedure TPropertyEventListener.PropertyBoolChange(Sender : TObject;PropsID: TPropsID;
  Value: boolean);
begin
  if Assigned(FOnPropertyBoolChange) then
    FOnPropertyBoolChange(Sender,PropsID,Value);
end;

procedure TPropertyEventListener.PropertyByteChange(Sender : TObject;PropsID: TPropsID;
  Value: Byte);
begin
  if Assigned(FOnPropertyByteChange) then
    FOnPropertyByteChange(Sender,PropsID,Value);
end;

procedure TPropertyEventListener.PropertyDblChange(Sender : TObject;PropsID: TPropsID;
  Value: double);
begin
  if Assigned(FOnPropertyDblChange) then
    FOnPropertyDblChange(Sender,PropsID,Value);
end;

procedure TPropertyEventListener.PropertyIntChange(Sender : TObject;PropsID: TPropsID;
  Value: integer);
begin
  if Assigned(FOnPropertyIntChange) then
    FOnPropertyIntChange(Sender,PropsID,Value);
end;

procedure TPropertyEventListener.PropertyStrChange(Sender: TObject;
  PropsID: TPropsID; Value: String);
begin
  if Assigned(FOnPropertyStrChange) then
    FOnPropertyStrChange(Sender,PropsID,Value);

end;

procedure TPropertyEventListener.Release;
begin
  inherited;

  FOnPropertyByteChange := nil;
  FOnPropertyDblChange  := nil;
  FOnPropertyIntChange  := nil;
  FOnPropertyBoolChange := nil;

end;

procedure TPropertyEventListener.SetOnPropertyBoolChange(
  const Value: TPropsBoolProc);
begin
  FOnPropertyBoolChange := Value;
end;

procedure TPropertyEventListener.SetOnPropertyByteChange(
  const Value: TPropsByteProc);
begin
  FOnPropertyByteChange := Value;
end;

procedure TPropertyEventListener.SetOnPropertyDblChange(
  const Value: TPropsDblProc);
begin
  FOnPropertyDblChange := Value;
end;

procedure TPropertyEventListener.SetOnPropertyIntChange(
  const Value: TPropsIntProc);
begin
  FOnPropertyIntChange := Value;
end;

procedure TPropertyEventListener.SetOnPropertyStrChange(
  const Value: TPropsStrProc);
begin
  FOnPropertyStrChange := Value;
end;

{ TT3GunListener }

procedure TT3GunOnVehicleListener.Release;
begin
  inherited;
  FOnChaffPosition  := nil;
end;

procedure TT3GunOnVehicleListener.SetOnChaffPosition(const Value: TProp2DblProc);
begin
  FOnChaffPosition := Value;
end;

{ TT3MissileOnVehicleListener }

procedure TT3MissileOnVehicleListener.Release;
begin
  inherited;
  FOnPropertyLauncherChange := nil;
end;

procedure TT3MissileOnVehicleListener.SetOnPropertyLauncherChange(
  const Value: TPropMissOnVhcLauncher);
begin
  FOnPropertyLauncherChange := Value;
end;

{ TT3TorpedoOnVehicleListener }

procedure TT3TorpedoOnVehicleListener.Release;
begin
  inherited;
  FOnPropertyLauncherChange := nil;
end;

procedure TT3TorpedoOnVehicleListener.SetOnPropertyLauncherChange(
  const Value: TPropTorpOnVhcLauncher);
begin
  FOnPropertyLauncherChange := Value;
end;

{ TEventListener }

destructor TEventListener.Destroy;
begin
  Release;

  inherited;
end;

procedure TEventListener.Release;
begin

end;

procedure TEventListener.SetListenerID(const Value: String);
begin
  FListenerID := Value;
end;

end.
