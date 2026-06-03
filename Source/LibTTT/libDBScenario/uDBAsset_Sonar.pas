unit uDBAsset_Sonar;

interface

uses

  tttData,Classes,uDBBlind_Zone, uDBNote_Storage,uDBAsset_Vehicle,
  uSimObjects,  uSimContainers, Graphics, uObjectVisuals,
  uBaseCoordSystem, uSensor;


type

  TSonar_On_Board = class (TSensor)
  private
    FControlMode    : TSonarControlMode;

    procedure SetOperationalStatus(const Value: TSensorOperationalStatus);override;
    procedure SensorProcess;override;
    procedure SetControlMode(const Value: TSonarControlMode);
  published
  public
    FData           : TRecSonar_On_Board;
    FDef            : TRecSonar_Definition;
    FBlind_Zone     : TBlind_Zone;
    FBlind          : TList;
    FPattern_Sonar  : TList; //TRecPattern_Sonar_Event;
    FScripted_sonar : TList;  //TRecScripted_Sonar_Event;
    FPOD            : TRecPOD_vs_SNR_Curve_Definition;
    FPattern  : TRecPattern_Sonar_Event;
    FCategory : TRecSonar_Category ;
    FNote     : TNote_Storage ;
    FVehicle  : TVehicle_Definition;

    FBZone_1  : TRecBlind_Zone_Definition;
    FBZone_2  : TRecBlind_Zone_Definition;

    property ControlMode : TSonarControlMode read FControlMode write SetControlMode;

    constructor Create;
    destructor Destroy;override;
    procedure UpdateVisual; override;
    procedure Move(const aDeltaMs: double); override;
    procedure Draw(aCnv: tCanvas); override;
  end;

implementation

uses uDBAssetObject;

{ TSonar_On_Board }

constructor TSonar_On_Board.Create;
begin
  inherited;

  FBlind          := TList.Create;
  FPattern_Sonar  := TList.Create; //TRecPattern_Sonar_Event;
  FScripted_sonar := TList.Create;
  FBlind_Zone     := TBlind_Zone.Create;
  FVehicle        := TVehicle_Definition.Create;

  FControlMode    := scmOff;
  DetectionRange  := FDef.Max_Detect_Range;
end;

destructor TSonar_On_Board.Destroy;
begin
  FreeItemsAndFreeList(FBlind);
  FreeItemsAndFreeList(FPattern_Sonar);
  FreeItemsAndFreeList(FScripted_sonar);
  FBlind_Zone.Free;
  FVehicle.Free;
  inherited;
end;

procedure TSonar_On_Board.Draw(aCnv: tCanvas);
begin
  inherited;
end;

procedure TSonar_On_Board.Move(const aDeltaMs: double);
begin
  inherited;

  {if FParent.ClassType = TPlatform_Instance then begin
    with TPlatform_Instance (FParent) do begin

      // kedalaman platform harus diubah ke feet dulu
      if PositionZ > FDef.Max_Operating_Depth then SetOperationalStatus(sosTooDeep)
      else
      if Speed > FDef.Maximum_Sonar_Speed then SetOperationalStatus(sosTooFast)
      else SetOperationalStatus(sosOFF);

      if (FOperationalStatus = sosTooDeep) or
         (FOperationalStatus = sosTooFast) then exit;
    end;
  end;  }

end;

procedure TSonar_On_Board.SetControlMode(const Value: TSonarControlMode);
begin
  FControlMode := Value;
  case FControlMode of
    scmOff      : SetOperationalStatus(sopOFF);
    scmPassive  : SetOperationalStatus(sopPassive);
    scmActive   : SetOperationalStatus(sopActive);
  end;

  if Value = scmOff then
    RemoveAllDetectedObject(dstSonar,FDef.Sonar_Identifier);
end;

procedure TSonar_On_Board.SetOperationalStatus(
  const Value: TSensorOperationalStatus);
begin
  inherited;
  if isNeedNotify then TriggerChange(etSonarOperationalStatus);
end;

procedure TSonar_On_Board.SensorProcess;
var
  list : TList;
  i : integer;
  obj : TSimObject;
  range, bearing : double;
  isInRange, isOutsideBlindZone, isOnGroup : boolean;
begin
  inherited;
  if not Assigned(FSimObjects) then Exit;

  list := FSimObjects.GetList;
  for i := 0 to list.Count - 1 do begin

    isInRange := false;
    isOutsideBlindZone := true;
    isOnGroup := false;

    obj := list.Items[i];
    // if parent same with self
    if Assigned(obj.Parent) then
      if obj.Parent = Parent then continue;
    if Parent = obj then continue;


   if obj.ClassType = TPlatform_Instance then begin
      range := CalcRange(FPosition.X,FPosition.Y,
               TPlatform_Instance(obj).PositionX,TPlatform_Instance(obj).PositionY);
      bearing := CalcBearing(FPosition.X,FPosition.Y,
               TPlatform_Instance(obj).PositionX,TPlatform_Instance(obj).PositionY);

      // periksa apakah dalam jangkauan radar
      if range <= DetectionRange then isInRange := true;

      // periksa apakah diluar area blind zone
      if not (FBlind_Zone.FData.Start_Angle = FBlind_Zone.FData.End_Angle) then begin
        {jika start > end angle}
        if (FBlindZone.RelativeStartAngle > FBlindZone.RelativeEndAngle) then begin
          if (bearing > FBlindZone.RelativeStartAngle) or
             (bearing < FBlindZone.RelativeEndAngle) then isOutsideBlindZone := false;
        end else
        if (bearing > FBlindZone.RelativeStartAngle) and
           (bearing < FBlindZone.RelativeEndAngle) then isOutsideBlindZone := false;
      end;

      //isOnGroup := simMgrClient.isPIOnGroup(TPlatform_Instance(obj));

      // periksa semua factor deteksi
 //     if isInRange and isOutsideBlindZone and not isOnGroup then
 //       AddDetectedObject(obj,dstSonar,FDef.Sonar_Identifier)
 
      if isInRange and isOutsideBlindZone then
        AddDetectedObject(obj,dstSonar,FDef.Sonar_Identifier)
      else
        RemoveDetectedObject(obj,dstSonar,FDef.Sonar_Identifier);
   end;
  end;
  FSimObjects.ReturnList;
end;

procedure TSonar_On_Board.UpdateVisual;
begin
  inherited;
  if Assigned(FParent) then begin
    DetectionRange := FDef.Max_Detect_Range;
  end;

end;

end.
