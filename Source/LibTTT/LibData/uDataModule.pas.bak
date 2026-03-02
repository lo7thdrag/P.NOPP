unit uDataModule;

interface

uses
  {Delphi uses}
  Dialogs, SysUtils, Classes, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZConnection, ZAbstractConnection, Data.DB,

  {Project uses}
  uConstantaData, uClassData, uRecordData, uDBAsset_Vehicle, uDBAsset_Weapon, uDBAsset_Sensor, uDBAsset_Countermeasure;

type

  TdmINWO = class(TDataModule)
    ZQ: TZQuery;
    ZConn: TZConnection;

  private

  public
    function InitZDB(const zDbServer, zDBProto, zDBname, zDBuser, zDBPass: string): boolean;

    {$REGION ' File Direktori '}
    function GetAllFile(var aList: TList): Integer;
    function GetSearchFile(var rec: TRecFile_Data): Integer;

    function InsertFile(var rec : TRecFile_Data) : Boolean;
    function UpdateFile(var rec : TRecFile_Data): Boolean;
    function DeleteFile(const FileID: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Referensi '}
    function GetAllReferensi(var aList: TList): Integer;
    function GetSearchReferensi(var rec: TRecFile_Data): Integer;
    function GetFilterByReferensi(var rec: TRecFile_Data): Integer;

    function InsertReferensi(var rec : TRecFile_Data) : Boolean;
    function UpdateReferensi(var rec : TRecFile_Data): Boolean;
    function DeleteReferensi(const FileID: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' User Role '}
    function GetAllRole(var aList: TList): Integer;
    function GetAllSubRole(var aList: TList): Integer;
    function GetAllUserRole(var aList: TList): Integer;

    function GetRoleByName(const aName: string): Integer; overload;
    function GetRoleInSubRole(const RoleID: Integer): Integer;

    function GetSubRoleByName(const aName: string): Integer; overload;
    function GetSubRoleInUserRole(const RoleID: Integer): Integer;

    function GetSubRoleByID(const SubRoleID: Integer; var rec : TRecSubRole): Integer;

    function GetUserRoleByName(var rec : TRecUser_Role): Integer;

    function GetSearchUserRole(var FilterIndex : Integer ; SearchContent : string ; aList: TList ): Integer;
    function GetUserRoleByFilterUsername(var rec : TRecUser_Role): Integer;

    function InsertRole(var rec : TRecRole) : Boolean;
    function UpdateRole(var rec : TRecRole): Boolean;
    function DeleteRole(const RoleID: Integer): Boolean;

    function InsertSubRole(var rec : TRecSubRole) : Boolean;
    function UpdateSubRole(var rec : TRecSubRole): Boolean;
    function DeleteSubRole(const SubRoleID: Integer): Boolean;

    function InsertUserRole(var rec : TRecUser_Role) : Boolean;
    function UpdateUserRole(var rec : TRecUser_Role): Boolean;
    function DeleteUserRole(const UserRoleID: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Asset '}

    {$REGION ' Vehicle '}
    function GetFilterVehicleDef(var aList: TList; aFilter: String): Integer;
    function GetFilterVehicleDefByDomain(var aList: TList; aFilter: Integer): Integer;
    function GetFilterVehicleForLandDomain(var aList: TList; aFilter: Integer): Integer;
    function GetAllVehicleDef(var aList: TList): Integer;
    function GetVehicleDef(const aClassName: string): Integer; overload;
    function GetVehicleDef(const aVehicleID: Integer; var aResult: TVehicle_Definition): boolean; overload;

    function InsertVehicleDef(var aRec: TRecVehicle_Definition): Boolean;
    function UpdateVehicleDef(var aRec: TRecVehicle_Definition): Boolean;
    function DeleteVehicleDef(const aVehicleID: Integer): Boolean;
    {$ENDREGION}


    {$REGION ' Weapons Section '}

    {$REGION ' Missile Definition '}
    function GetAllMissileDef(var aList: TList): Integer;
    function GetFilterMissileDef(var aList: TList; aFilter: String): Integer;
    function GetMissileDef(const aClassName: string): Integer; overload;

    function InsertMissileDef(var aRec: TRecMissile_Definition): Boolean;
    function UpdateMissileDef(var aRec: TRecMissile_Definition): Boolean;
    function DeleteMissileDef(const aMissileIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Torpedo Definition '}
    function GetAllTorpedoDef(var aList: TList): Integer;
    function GetFilterTorpedoDef(var aList: TList; aFilter: String): Integer;
    function GetTorpedoDef(const aClassName: string): Integer; overload;

    function InsertTorpedoDef(var aRec: TRecTorpedo_Definition): Boolean;
    function UpdateTorpedoDef(var aRec: TRecTorpedo_Definition): Boolean;
    function DeleteTorpedoDef(const aTorpedoIndex: Integer): Boolean;

    {$ENDREGION}

    {$REGION ' Mine Definition '}
    function GetAllMineDef(var aList: TList): Integer;
    function GetFilterMineDef(var aList: TList; aFilter: String): Integer;
    function GetMineDef(const aClassName: string): Integer; overload;

    function InsertMineDef(var aRec: TRecMine_Definition): Boolean;
    function UpdateMineDef(var aRec: TRecMine_Definition): Boolean;
    function DeleteMineDef(const aMineIndex: Integer): Boolean;

    {$ENDREGION}

    {$REGION ' Gun Definition '}
    function GetAllGunDef(var aList: TList): Integer;
    function GetFilterGunDef(var aList: TList; aFilter: String): Integer;
    function GetGunDef(const aClassName: string): Integer; overload;

    function InsertGunDef(var aRec: TRecGun_Definition): Boolean;
    function UpdateGunDef(var aRec: TRecGun_Definition): Boolean;
    function DeleteGunDef(const aGunIndex: Integer): Boolean;

    {$ENDREGION}

    {$REGION ' Bomb Definition '}
    function GetAllBombDef(var aList: TList): Integer;
    function GetFilterBombDef(var aList: TList; aFilter: String): Integer;
    function GetBombDef(const aClassName: string): Integer; overload;

    function InsertBombDef(var aRec: TRecBomb_Definition): Boolean;
    function UpdateBombDef(var aRec: TRecBomb_Definition): Boolean;
    function DeleteBombDef(const aBombIndex: Integer): Boolean;

    {$ENDREGION}

    {$REGION ' Weapon On Board '}

//    function GetMissileOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetTorpedoOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetMineOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetGunOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetBombOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//
//    function GetFittedWeaponOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetPointEffectOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetFittedWeaponLauncherOnBoardCount(const aFittedWeapID: Integer; const aType: Integer): Boolean;
//    function GetFittedWeaponLauncherOnBoard(const aWeaponID: Integer; var aList: TList): Boolean;
//
//    function InsertFittedWeaponOnBoard(const aInsertType: Byte;var aRec: TRecFitted_Weapon_On_Board): Boolean;
//    function UpdateFittedWeaponOnBoard(const aUpdateType: Byte;var aRec: TRecFitted_Weapon_On_Board): Boolean;
//    function DeleteFittedWeaponOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//
//    function InsertPointEffectOnBoard(const aInsertType: Byte;var aRec: TRecPoint_Effect_On_Board): Boolean;
//    function UpdatePointEffectOnBoard(const aUpdateType: Byte;var aRec: TRecPoint_Effect_On_Board): Boolean;
//    function DeletePointEffectOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//
//    function InsertFittedWeaponLauncherOnBoard(const aRec: TRecFitted_Weap_Launcher_On_Board): Boolean;
//    function UpdateFittedWeaponLauncherOnBoard(const aRec: TRecFitted_Weap_Launcher_On_Board): Boolean;
//    function DeleteFittedWeaponLauncherOnBoard(const aWeaponID, aLauncherType: Integer): Boolean; overload;
//    function DeleteFittedWeaponLauncherOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean; overload;

    {$ENDREGION}

    {$ENDREGION}

    {$REGION ' Sensor Section '}

    {$REGION ' Radar Definition '}
    function GetAllRadarDef(var aList: TList): Integer;
    function GetFilterRadarDef(var aList: TList; aFilter: String): Integer;
    function GetRadarDef(const aClassName: string): Integer; overload;

    function InsertRadarDef(var aRec: TRecRadar_Definition): Boolean;
    function UpdateRadarDef(var aRec: TRecRadar_Definition): Boolean;
    function DeleteRadarDef(const aRadarIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Sonar Definition '}
    function GetAllSonarDef(var aList: TList): Integer;
    function GetFilterSonarDef(var aList: TList; aFilter: String): Integer;
    function GetSonarDef(const aClassName: string): Integer; overload;
//    function GetSonarDef(const aClassID: Integer; var aSonar: TSonar_On_Board): Boolean; overload;

    function InsertSonarDef(var aRec: TRecSonar_Definition): Boolean;
    function UpdateSonarDef(var aRec: TRecSonar_Definition): Boolean;
    function DeleteSonarDef(const aSonarIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' ESM Definition '}
    function GetAllESMDef(var aList: TList): Integer;
    function GetFilterESMDef(var aList: TList; aFilter: String): Integer;
    function GetESMDef(const aClassName: string): Integer; overload;

    function InsertESMDef(var aRec: TRecESM_Definition): Boolean;
    function UpdateESMDef(var aRec: TRecESM_Definition): Boolean;
    function DeleteESMDef(const aESMIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' EOD Definition '}
    function GetAllEODDef(var aList: TList): Integer;
    function GetFilterEODDef(var aList: TList; aFilter: String): Integer;
    function GetEODDef(const aClassName: string): Integer; overload;

    function InsertEODDef(var aRec: TRecEOD_Definition): Boolean;
    function UpdateEODDef(var aRec: TRecEOD_Definition): Boolean;
    function DeleteEODDef(const aEODIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Sonobuoy Definition '}
    function GetAllSonobuoyDef(var aList: TList): Integer;
    function GetFilterSonobuoyDef(var aList: TList; aFilter: String): Integer;
    function GetSonobuoyDef(const aClassName: string): Integer; overload;

    function InsertSonobuoyDef(var aRec: TRecSonobuoy_Definition): Boolean;
    function UpdateSonobuoyDef(var aRec: TRecSonobuoy_Definition): Boolean;
    function DeleteSonobuoyDef(const aSonobuoyIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' MAD Definition '}
    function GetAllMADDef(var aList: TList): Integer;
    function GetFilterMADDef(var aList: TList; aFilter: String): Integer;
    function GetMADDef(const aClassName: string): Integer; overload;

    function InsertMADDef(var aRec: TRecMAD_Definition): Boolean;
    function UpdateMADDef(var aRec: TRecMAD_Definition): Boolean;
    function DeleteMADDef(const aMADIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Sensor On Board '}
    {Digunakan untuk pengecekan data sensor apakah sedang terhubung dengan suatu kapal (untuk delete sensor definition)}
//    function GetSensor_On_Board_By_Index(const typeOnBoard, id: Integer): Boolean;

    {Digunakan untuk mengambil data sensor yang ada di suatu kapal (OnBoard)}
//    function GetRadarOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetSonarOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetESMOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetEOOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetSonobuoyOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetMADOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetIFFOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetVisualOnBoard(const aVehicleID: Integer; var aList: TList): Integer;

    {Digunakan untuk pengecekan 1 jenis sensor tidak boleh menempati mount yg sama}
//    function GetRadarOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetSonarOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetESMOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetMADOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetEOOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetSonobuoyOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetIFFOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetVisualDetectorOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;

//    function InsertRadarOnBoard(var aRec: TRecRadar_On_Board): Boolean;
//    function InsertEOOnBoard(var aRec: TRecEO_On_Board): Boolean;
//    function InsertESMOnBoard(var aRec: TRecESM_On_Board): Boolean;
//    function InsertSonarOnBoard(var aRec: TRecSonar_On_Board): Boolean;
//    function InsertSonobuoyOnBoard(var aRec: TRecSonobuoy_On_Board): Boolean;
//    function InsertIFFOnBoard(var aRec: TRecIFF_Sensor_On_Board): Boolean;
//    function InsertVisualOnBoard(var aRec: TRecVisual_Sensor_On_Board): Boolean;
//    function InsertMADOnBoard(var aRec: TRecMAD_Sensor_On_Board): Boolean;

//    function UpdateRadarOnBoard(var aRec: TRecRadar_On_Board): Boolean;
//    function UpdateEOOnBoard(var aRec: TRecEO_On_Board): Boolean;
//    function UpdateESMOnBoard(var aRec: TRecESM_On_Board): Boolean;
//    function UpdateSonarOnBoard(var aRec: TRecSonar_On_Board): Boolean;
//    function UpdateSonobuoyOnBoard(var aRec: TRecSonobuoy_On_Board): Boolean;
//    function UpdateIFFOnBoard(var aRec: TRecIFF_Sensor_On_Board): Boolean;
//    function UpdateVisualOnBoard(var aRec: TRecVisual_Sensor_On_Board): Boolean;
//    function UpdateMADOnBoard(var aRec: TRecMAD_Sensor_On_Board): Boolean;

//    function DeleteRadarOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//    function DeleteSonarOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//    function DeleteESMOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//    function DeleteEOOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//    function DeleteSonobuoyOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteMADOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//    function DeleteIFFOnBoard(const aDeleteType: Byte;const aIndex: Integer): Boolean;
//    function DeleteVisualOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;

    {$ENDREGION}

    {$ENDREGION}

    {$REGION ' Countermeasures Section '}

    {$REGION ' Chaff Definition '}
    function GetAllChaffDef(var aList: TList): Integer;
    function GetFilterChaffDef(var aList: TList; aFilter: String): Integer;
    function GetChaffDef(const aClassName: string): Integer; overload;

    function InsertChaffDef(var aRec: TRecChaff_Definition): Boolean;
    function UpdateChaffDef(var aRec: TRecChaff_Definition): Boolean;
    function DeleteChaffDef(const aChaffIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Air Bubble Definition '}
    function GetAllAirBubbleDef(var aList: TList): Integer;
    function GetFilterAirBubbleDef(var aList: TList; aFilter: String): Integer;
    function GetAirBubbleDef(const aClassName: string): Integer; overload;

    function InsertAirBubbleDef(var aRec: TRecAir_Bubble_Definition): Boolean;
    function UpdateAirBubbleDef(var aRec: TRecAir_Bubble_Definition): Boolean;
    function DeleteAirBubbleDef(const aAirBubbleIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Acoustic Decoy Definition '}
    function GetAllAcousticDecoyDef(var aList: TList): Integer;
    function GetFilterAcousticDecoyDef(var aList: TList; aFilter: String): Integer;
    function GetAcousticDecoyDef(const aClassName: string): Integer; overload;

    function InsertAcousticDecoyDef(var aRec: TRecAcoustic_Decoy_Definition): Boolean;
    function UpdateAcousticDecoyDef(var aRec: TRecAcoustic_Decoy_Definition): Boolean;
    function DeleteAcousticDecoyDef(const aAcousticDecoyIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Infrared Decoy Definition '}
    function GetAllInfraredDecoyDef(var aList: TList): Integer;
    function GetFilterInfraredDecoyDef(var aList: TList; aFilter: String): Integer;
    function GetInfraredDecoyDef(const aClassName: string): Integer; overload;

    function InsertInfraredDecoyDef(var aRec: TRecInfrared_Decoy_Definition): Boolean;
    function UpdateInfraredDecoyDef(var aRec: TRecInfrared_Decoy_Definition): Boolean;
    function DeleteInfraredDecoyDef(const aInfraredDecoyIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Floating Decoy Definition '}
    function GetAllFloatingDecoyDef(var aList: TList): Integer;
    function GetFilterFloatingDecoyDef(var aList: TList; aFilter: String): Integer;
    function GetFloatingDecoyDef(const aClassName: string): Integer; overload;

    function InsertFloatingDecoyDef(var aRec: TRecFloating_Decoy_Definition): Boolean;
    function UpdateFloatingDecoyDef(var aRec: TRecFloating_Decoy_Definition): Boolean;
    function DeleteFloatingDecoyDef(const aFloatingDecoyIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Towed Decoy Definition '}
    function GetAllTowedDecoyDef(var aList: TList): Integer;
    function GetFilterTowedDecoyDef(var aList: TList; aFilter: String): Integer;
    function GetTowedDecoyDef(const aClassName: string): Integer; overload;

    function InsertTowedDecoyDef(var aRec: TRecTowed_Decoy_Definition): Boolean;
    function UpdateTowedDecoyDef(var aRec: TRecTowed_Decoy_Definition): Boolean;
    function DeleteTowedDecoyDef(const aTowedJammerIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Self Defensive Jammer Definition '}
    function GetAllSelfDefensiveJammerDef(var aList: TList): Integer;
    function GetFilterSelfDefensiveJammerDef(var aList: TList; aFilter: String): Integer;
    function GetSelfDefensiveJammerDef(const aClassName: string): Integer; overload;

    function InsertSelfDefensiveJammerDef(var aRec: TRecDefensive_Jammer_Definition): Boolean;
    function UpdateSelfDefensiveJammerDef(var aRec: TRecDefensive_Jammer_Definition): Boolean;
    function DeleteSelfDefensiveJammerDef(const aSelfDefensiveJammerIndex: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Radar Noise Jammer Definition '}
    function GetAllRadarNoiseJammerDef(var aList: TList): Integer;
    function GetFilterRadarNoiseJammerDef(var aList: TList; aFilter: String): Integer;
    function GetRadarNoiseJammerDef(const aClassName: string): Integer; overload;

    function InsertRadarNoiseJammerDef(var aRec: TRecRadar_Noise_Jammer_Definition): Boolean;
    function UpdateRadarNoiseJammerDef(var aRec: TRecRadar_Noise_Jammer_Definition): Boolean;
    function DeleteRadarNoiseJammerDef(const aRadarNoiseJammer: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Countermeasure On Board '}

//    function GetCountermeasure_On_Board_By_Index(const typeOnBoard, id: Integer): Boolean; {New}
//
//    function GetAcousticDecoyOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetAirBubbleOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetRadarNoiseJammerOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetSelfDefensiveJammerOnBoard(const aVehicleID: Integer;var aList: TList): Integer;
//    function GetTowedJammerDecoyOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetFloatingDecoyOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetInfraredDecoyOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetChaffOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//    function GetChaffLauncherOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//
//    {Digunakan untuk pengecekan 1 jenis sensor tidak boleh menempati mount yg sama}
//    function GetAcousticDecoyOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetAirBubbleOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetChaffOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetFloatingDecoyOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetInfraredDecoyOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetRadarNoiseJammerOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetSelfDefensiveJammerOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetTowedJammerOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//    function GetChaffLauncherOnBoardCount(const aVehicleID, aLauncherID: Integer): Boolean;
//
//    function InsertRadarNoiseJammerOnBoard(var aRec: TRecRadar_Noise_Jammer_On_Board): Boolean;
//    function InsertAirBubbleOnBoard(var aRec: TRecAir_Bubble_On_Board): Boolean;
//    function InsertAcousticDecoyOnBoard(var aRec: TRecAcoustic_Decoy_On_Board): Boolean;
//    function InsertSelfDefensiveJammerOnBoard(var aRec: TRecDefensive_Jammer_On_Board): Boolean;
//    function InsertTowedJammerDecoyOnBoard(var aRec: TRecTowed_Jammer_Decoy_On_Board): Boolean;
//    function InsertFloatingDecoyOnBoard( var aRec: TRecFloating_Decoy_On_Board): Boolean;
//    function InsertInfraredDecoyOnBoard(var aRec: TRecInfrared_Decoy_On_Board): Boolean;
//    function InsertChaffOnBoard(var aRec: TRecChaff_On_Board): Boolean;
//    function InsertChaffLauncherOnBoard( var aRec: TRecChaff_Launcher_On_Board): Boolean;
//
//    function UpdateRadarNoiseJammerOnBoard( var aRec: TRecRadar_Noise_Jammer_On_Board): Boolean;
//    function UpdateAirBubbleOnBoard(var aRec: TRecAir_Bubble_On_Board): Boolean;
//    function UpdateAcousticDecoyOnBoard(var aRec: TRecAcoustic_Decoy_On_Board): Boolean;
//    function UpdateSelfDefensiveJammerOnBoard(var aRec: TRecDefensive_Jammer_On_Board): Boolean;
//    function UpdateTowedJammerDecoyOnBoard(var aRec: TRecTowed_Jammer_Decoy_On_Board): Boolean;
//    function UpdateFloatingDecoyOnBoard(var aRec: TRecFloating_Decoy_On_Board): Boolean;
//    function UpdateInfraredDecoyOnBoard(var aRec: TRecInfrared_Decoy_On_Board): Boolean;
//    function UpdateChaffOnBoard(var aRec: TRecChaff_On_Board): Boolean;
//    function UpdateChaffLauncherOnBoard( var aRec: TRecChaff_Launcher_On_Board): Boolean;
//
//    function DeleteAcousticDecoyOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteAirBubbleOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteRadarNoiseJammerOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteSelfDefensiveJammerOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteTowedJammerDecoyOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteFloatingDecoyOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteInfraredDecoyOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteChaffOnBoard(const aDeleteType: Byte; aIndex: Integer): Boolean;
//    function DeleteChaffLauncherOnBoard( const aVehicleIndex: Integer): Boolean; overload;
//    function DeleteChaffLauncherOnBoard(const aVehicleIndex, aLauncherNumber: Integer): Boolean; overload;

    {$ENDREGION}

    {$ENDREGION}

    {$ENDREGION}

    {$REGION ' Peta '}
    function GetAllGameAreaDef(var aList: TList): Integer; {New}
    function GetFilterGameAreaDef(var aList: TList; aFilter: String): Integer;
    function GetGameAreaDef(const aAreaIdentifier: string): Integer; overload;
    function GetGameAreaDef(const aGameAreaID: Integer; var aResult: TRecGame_Area_Definition): Boolean; overload;

    function InsertGameAreaDef(var aRec: TRecGame_Area_Definition): Boolean;
    function UpdateGameAreaDef(var aRec: TRecGame_Area_Definition): Boolean;
    function DeleteGameAreaDef(const aGameAreaID: Integer): Boolean;
    {$ENDREGION}

    {$REGION ' Tactical Symbol '}
    function InsertTacticalSymbol(var aRec: TRecTactical_Symbol): Boolean;
    function GetAllTacticalSymbol(var aList: TList): Integer;
    function GetFilterByTactical(var aRec: TRecTactical_Symbol): Integer;
    function GetSearchTacticalSymbol(var FilterIndex: Integer; SearchContent: string; aList:TList): Integer;
    function UpdateTacticalSymbol(var aRec: TRecTactical_Symbol): Boolean;
    function DeleteTacticalSymbol(const aTacticalSymbolID: Integer): Boolean;

    function getAllFontTaktis(mList: TList; aFontType : Byte): Integer;
    function getFontByID(const id: Integer; var FontTaktis: TFontTaktis): Integer;
    function getFilterSimbol(const aSrch :string; const FontType : Byte; var FontTaktisList: TList):integer;
    {$ENDREGION}

    {$REGION ' Additional Section '}

    {$REGION ' Note Storage '}
    function InsertNoteStorage(const aOwnerType: Byte; const aOwnerIndex: Integer; var aRec: TRecNote_Storage): Boolean;
    function UpdateNoteStorage(const aOwnerIndex: Integer; var aRec: TRecNote_Storage): Boolean;
    function DeleteNoteStorage(const aOwnerType: Integer; const aOwnerIndex: Integer): Integer;
    {$ENDREGION}

    {$REGION ' Usage '}

    {$REGION ' Platform Usage '}

//    function GetMotionCharacteristicAtVehicleDef(const id: Integer; var pList: TList): boolean;
//    function GetMotionCharacteristicAtMissileDef(const id: Integer; var pList: TList): boolean;
//    function GetMotionCharacteristicAtTorpedoDef(const id: Integer; var pList: TList): boolean;

    {$ENDREGION}

    {$REGION ' Sensor Usage '}
    function GetRadarAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetSonarAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetSonarAtSonobuoyDef(const id: Integer; var pList: TList): boolean;
    function GetESMAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetEODAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetMADAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetSonobuoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    {$ENDREGION}

    {$REGION ' Weapon Usage '}
    function GetFittedWeaponAtVehicleOnBoard(const index,id: Integer; var pList: TList): boolean;
    function GetTorpedoAtMissileDef (const id: Integer; var pList: TList): boolean;
    function GetPointEffectAtVehicleOnBoard(const index,id: Integer; var pList: TList): boolean;
    {$ENDREGION}

    {$REGION ' Countermeasure Usage '}
    function GetChaffAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetAirBubbleAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetAcousticDecoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetInfraredDecoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetFloatingDecoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetTowedDecoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetDefensiveJammerAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    function GetRadarNoiseJammerAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
    {$ENDREGION}

    {$ENDREGION}

    {$ENDREGION}

  end;

var
  dmINWO: TdmINWO;

implementation

{$R *.dfm}

function TdmINWO.InitZDB(const zDbServer, zDBProto, zDBname, zDBuser, zDBPass: string): boolean;
begin
  //result := false;
  with ZConn do
  begin
    HostName := zDbServer;
    Protocol := zDBProto;
    Database := zDBname;
    User := zDBuser;
    Password := zDBPass;
  end;

  try
    ZConn.Connect;
    result := ZConn.Connected;
  except
    on Exception do
    begin
      MessageDlg('Error Database Connection on ' + zDbServer, mtError, [mbOK],
        0);
      result := false;
      exit;
    end
  end;
  ZQ.Connection := ZConn;
end;

{$REGION ' File Direktori '}

function TdmINWO.GetAllFile(var aList: TList): Integer;
var
  i : Integer;
  rec : TFile_Data;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM File_Directory');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TFile_Data.Create;

        with rec.FData do
        begin
          ID_File := FieldByName('ID_File').AsInteger;
          Nama_File := FieldByName('Nama_File').AsString;
          Directory_Path := FieldByName('Directory_Path').AsString;
          Encripted_File_Name := FieldByName('Encripted_File_Name').AsString;
          Tipe_File := FieldByName('Tipe_File').AsString;
          Modified_Date := FieldByName('Modified_Date').AsString;
          Modified_By := FieldByName('Modified_By').AsString;
          id_User := FieldByName('id_User').AsInteger;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetSearchFile(var rec: TRecFile_Data): Integer;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM File_Directory');
    SQL.Add('WHERE (Nama_File = ' + QuotedStr(rec.Nama_File) + ') ' );
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertFile(var rec: TRecFile_Data): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;

    SQL.Add('INSERT INTO File_Directory');
    SQL.Add('(Nama_File, Directory_Path, Encripted_File_Name, Tipe_File, Modified_Date, Modified_By, id_User)');
    SQL.Add('VALUES (');

    with rec do
    begin
      SQL.Add(QuotedStr(Nama_File) + ', ');
      SQL.Add(QuotedStr(Directory_Path) + ', ');
      SQL.Add(QuotedStr(Encripted_File_Name) + ', ');
      SQL.Add(QuotedStr(Tipe_File) + ', ');
      SQL.Add(QuotedStr(Modified_Date) + ', ');
      SQL.Add(QuotedStr(Modified_By) + ', ');
      SQL.Add(IntToStr(id_User) + ')');
    end;
    ExecSQL;

//    Result := True;

    {Yg barusan diinput diambil lagi datanya, untuk mengetahui Indexnya}
    SQL.Clear;
    SQL.Add('SELECT * FROM File_Directory ');
    SQL.Add('WHERE Nama_File = ' + QuotedStr(rec.Nama_File) + ' and Modified_Date = ' + QuotedStr(rec.Modified_Date));
    Open;

    Result := RecordCount > 0;

    rec.ID_File := FieldByName('ID_File').AsInteger;
    rec.Encripted_File_Name := FieldByName('ID_File').AsString + FieldByName('Tipe_File').AsString;
  end;
end;

function TdmINWO.UpdateFile(var rec: TRecFile_Data): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    with rec do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE File_Directory');
      SQL.Add('SET');
      SQL.Add('Nama_File=' + QuotedStr(rec.Nama_File)+',');
      SQL.Add('Directory_Path=' + QuotedStr(rec.Directory_Path)+',');
      SQL.Add('Encripted_File_Name=' + QuotedStr(rec.Encripted_File_Name)+',');
      SQL.Add('Tipe_File=' + QuotedStr(rec.Tipe_File)+',');
      SQL.Add('Modified_Date=' + QuotedStr(rec.Modified_Date)+',');
      SQL.Add('Modified_By=' + QuotedStr(rec.Modified_By)+',');
      SQL.Add('id_User=' + IntToStr(rec.id_User));
      SQL.Add(' WHERE (ID_File =' + IntToStr(rec.ID_File) + ')');
      ExecSQL;
    end;

    Result := True;
  end;
end;

function TdmINWO.DeleteFile(const FileID: Integer): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM File_Directory');
    SQL.Add('WHERE (ID_File='+QuotedStr(IntToStr(FileID))+')');
    ExecSQL;
    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Referensi '}

function TdmINWO.GetAllReferensi(var aList: TList): Integer;
var
  i : Integer;
  rec : TFile_Data;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM File_Referensi');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TFile_Data.Create;

        with rec.FData do
        begin
          ID_File := FieldByName('ID_File').AsInteger;
          Nama_File := FieldByName('Nama_File').AsString;
          Directory_Path := FieldByName('Directory_Path').AsString;
          Encripted_File_Name := FieldByName('Encripted_File_Name').AsString;
          Tipe_File := FieldByName('Tipe_File').AsString;
          Modified_Date := FieldByName('Modified_Date').AsString;
          Modified_By := FieldByName('Modified_By').AsString;
          id_User := FieldByName('id_User').AsInteger;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetSearchReferensi(var rec: TRecFile_Data): Integer;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM File_Referensi');
    SQL.Add('WHERE (Nama_File = ' + QuotedStr(rec.Nama_File) + ') ' );
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.GetFilterByReferensi(var rec: TRecFile_Data): Integer;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM File_Referensi');
    SQL.Add('WHERE (Nama_File = ' + QuotedStr(rec.Nama_File) + ') and ' +
          '(Tipe_File = ' + QuotedStr(rec.Tipe_File) + ') and ' +
          '(Modified_By = ' + QuotedStr(rec.Modified_By) + ') and ' +
          '(ID_File = ' + IntToStr(rec.ID_File) + ') and ' +
          '(Encripted_File_Name = ' + QuotedStr(rec.Encripted_File_Name) + ') and ' +
          '(id_User = ' + IntToStr(rec.id_User) + ') and ' +
          '(Modified_Date = ' + QuotedStr(rec.Modified_Date) + ') and ' +
          '(Directory_Path = ' + QuotedStr(rec.Directory_Path) + ')');
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertReferensi(var rec: TRecFile_Data): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;

    SQL.Add('INSERT INTO File_Referensi');
    SQL.Add('(Nama_File, Directory_Path, Encripted_File_Name, Tipe_File, Modified_Date, Modified_By, id_User)');
    SQL.Add('VALUES (');

    with rec do
    begin
      SQL.Add(QuotedStr(Nama_File) + ', ');
      SQL.Add(QuotedStr(Directory_Path) + ', ');
      SQL.Add(QuotedStr(Encripted_File_Name) + ', ');
      SQL.Add(QuotedStr(Tipe_File) + ', ');
      SQL.Add(QuotedStr(Modified_Date) + ', ');
      SQL.Add(QuotedStr(Modified_By) + ', ');
      SQL.Add(IntToStr(id_User) + ')');
    end;
    ExecSQL;

//    Result := True;

    {Yg barusan diinput diambil lagi datanya, untuk mengetahui Indexnya}
    SQL.Clear;
    SQL.Add('SELECT * FROM File_Referensi ');
    SQL.Add('WHERE Nama_File = ' + QuotedStr(rec.Nama_File) + ' and Modified_Date = ' + QuotedStr(rec.Modified_Date) );
    Open;

    Result := RecordCount > 0;

    rec.ID_File := FieldByName('ID_File').AsInteger;
    rec.Encripted_File_Name := FieldByName('ID_File').AsString + FieldByName('Tipe_File').AsString;
  end;
end;

function TdmINWO.UpdateReferensi(var rec: TRecFile_Data): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    with rec do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE File_Referensi');
      SQL.Add('SET');
      SQL.Add('Nama_File=' + QuotedStr(rec.Nama_File)+',');
      SQL.Add('Directory_Path=' + QuotedStr(rec.Directory_Path)+',');
      SQL.Add('Encripted_File_Name=' + QuotedStr(rec.Encripted_File_Name)+',');
      SQL.Add('Tipe_File=' + QuotedStr(rec.Tipe_File)+',');
      SQL.Add('Modified_Date=' + QuotedStr(rec.Modified_Date)+',');
      SQL.Add('Modified_By=' + QuotedStr(rec.Modified_By)+',');
      SQL.Add('id_User=' + IntToStr(rec.id_User));
      SQL.Add(' WHERE (ID_File =' + IntToStr(rec.ID_File) + ')');
      ExecSQL;
    end;

    Result := True;
  end;
end;

function TdmINWO.DeleteReferensi(const FileID: Integer): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM File_Referensi');
    SQL.Add('WHERE (ID_File='+QuotedStr(IntToStr(FileID))+')');
    ExecSQL;
    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' User Role '}

function TdmINWO.GetAllRole(var aList: TList): Integer;
var
  i : Integer;
  rec : TRole;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Role_Definition');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TRole.Create;

        with rec.FData do
        begin
          RoleIndex := FieldByName('RoleIndex').AsInteger;
          RoleAcronim := FieldByName('RoleAcronim').AsString;
          RoleIdentifier := FieldByName('RoleIdentifier').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAllSubRole(var aList: TList): Integer;
var
  i : Integer;
  rec : TSubRole;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM SubRole_Definition');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TSubRole.Create;

        with rec.FData do
        begin
          SubRoleIndex := FieldByName('SubRoleIndex').AsInteger;
          RoleIndex := FieldByName('RoleIndex').AsInteger;
          SubRoleAcronim := FieldByName('SubRoleAcronim').AsString;
          SubRoleIdentifier := FieldByName('SubRoleIdentifier').AsString;
          Perencanaan := Ord(FieldByName('Perencanaan').AsBoolean);
          Persiapan := Ord(FieldByName('Persiapan').AsBoolean);
          Pelaksanaan := Ord(FieldByName('Pelaksanaan').AsBoolean);
          Pengakhiran := Ord(FieldByName('Pengakhiran').AsBoolean);
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAllUserRole(var aList: TList): Integer;
var
  i : Integer;
  rec : TUserRole;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM User_Role_Definition');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TUserRole.Create;

        with rec.FData do
        begin
          RoleIndex := FieldByName('RoleIndex').AsInteger;
          SubRoleIndex := FieldByName('SubRoleIndex').AsInteger;
          UserRoleIndex := FieldByName('UserRoleIndex').AsInteger;
          UserRoleAcronim := FieldByName('UserRoleAcronim').AsString;
          UserRoleIdentifier := FieldByName('UserRoleIdentifier').AsString;
          Username := FieldByName('Username').AsString;
          Password := FieldByName('Password').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetRoleByName(const aName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Role_Definition');
    SQL.Add('WHERE RoleAcronim = '+ QuotedStr(aName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.GetSubRoleByID(const SubRoleID: Integer; var rec: TRecSubRole): Integer;
var
  i : Integer;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM SubRole_Definition WHERE SubRoleIndex = '  + IntToStr(SubRoleID));
    Open;

    Result := RecordCount;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        with rec do
        begin
          SubRoleIndex := FieldByName('SubRoleIndex').AsInteger;
          RoleIndex := FieldByName('RoleIndex').AsInteger;
          SubRoleAcronim := FieldByName('SubRoleAcronim').AsString;
          SubRoleIdentifier := FieldByName('SubRoleIdentifier').AsString;
          Perencanaan := Ord(FieldByName('Perencanaan').AsBoolean);
          Persiapan := Ord(FieldByName('Persiapan').AsBoolean);
          Pelaksanaan := Ord(FieldByName('Pelaksanaan').AsBoolean);
          Pengakhiran := Ord(FieldByName('Pengakhiran').AsBoolean);
        end;
      end;
    end;
  end;
end;

function TdmINWO.GetSubRoleByName(const aName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM SubRole_Definition');
    SQL.Add('WHERE SubRoleAcronim = '+ QuotedStr(aName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.GetSubRoleInUserRole(const RoleID: Integer): Integer;
var
  i : Integer;
  rec: TSubRole;
begin
  Result := 0;

  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM User_Role_Definition');
    SQL.Add('WHERE SubRoleIndex = '+ IntToStr(RoleID));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.GetRoleInSubRole(const RoleID: Integer): Integer;
var
  i : Integer;
  rec: TSubRole;
begin
  Result := 0;

  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM SubRole_Definition');
    SQL.Add('WHERE RoleIndex = '+ IntToStr(RoleID));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.GetSearchUserRole(var FilterIndex : Integer ; SearchContent : string ; aList: TList ): Integer;
var
  i : Integer;
  rec : TUserRole;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM User_Role_Definition');
    if FilterIndex = 0 then
      SQL.Add('WHERE UserRoleAcronim like '  + quotedStr('%' + SearchContent + '%'))
    else if FilterIndex = 1 then
      SQL.Add('WHERE RoleIndex = '  + SearchContent )
    else if FilterIndex = 2 then
      SQL.Add('WHERE SubRoleIndex = '  + SearchContent);

    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TUserRole.Create;

        with rec.FData do
        begin
          RoleIndex := FieldByName('RoleIndex').AsInteger;
          SubRoleIndex := FieldByName('SubRoleIndex').AsInteger;
          UserRoleIndex := FieldByName('UserRoleIndex').AsInteger;
          UserRoleAcronim := FieldByName('UserRoleAcronim').AsString;
          UserRoleIdentifier := FieldByName('UserRoleIdentifier').AsString;
          Username := FieldByName('Username').AsString;
          Password := FieldByName('Password').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetUserRoleByName(var rec: TRecUser_Role): Integer;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM User_Role_Definition');
    SQL.Add('WHERE (UserRoleAcronim = ' + QuotedStr(rec.UserRoleAcronim) + ') and (RoleIndex = ' + IntToStr(rec.RoleIndex) + ') and ' );
    SQL.Add('(SubRoleIndex = ' + IntToStr(rec.SubRoleIndex) + ')' );
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.GetUserRoleByFilterUsername(var rec: TRecUser_Role): Integer;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM User_Role_Definition');
    SQL.Add('WHERE (Username = ' + QuotedStr(rec.Username) + ') ' );
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertRole(var rec: TRecRole): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;

    SQL.Add('INSERT INTO Role_Definition');
    SQL.Add('(RoleAcronim, RoleIdentifier)');
    SQL.Add('VALUES (');

    with rec do
    begin
      SQL.Add(QuotedStr(RoleAcronim) + ', ');
      SQL.Add(QuotedStr(RoleIdentifier));
    end;

    SQL.Add(')');
    ExecSQL;

    Result := True;

    {Yg barusan diinput diambil lagi datanya, untuk mengetahui Indexnya}
    SQL.Clear;
    SQL.Add('SELECT * FROM Role_Definition');
    SQL.Add('WHERE (RoleAcronim = ' + QuotedStr(rec.RoleAcronim) +
     ') and (RoleIdentifier = ' + QuotedStr(rec.RoleIdentifier) + ')' );
    Open;

    rec.RoleIndex := FieldByName('RoleIndex').AsInteger;
  end;
end;

 function TdmINWO.InsertSubRole(var rec: TRecSubRole): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;

    SQL.Add('INSERT INTO SubRole_Definition');
    SQL.Add('(RoleIndex, SubRoleAcronim, SubRoleIdentifier, Perencanaan, Persiapan, Pelaksanaan, Pengakhiran)');
    SQL.Add('VALUES (');

    with rec do
    begin
      SQL.Add(IntToStr(RoleIndex) + ', ');
      SQL.Add(QuotedStr(SubRoleAcronim) + ', ');
      SQL.Add(QuotedStr(SubRoleIdentifier) + ', ');
      SQL.Add(IntToStr(Perencanaan) + ', ');
      SQL.Add(IntToStr(Persiapan) + ', ');
      SQL.Add(IntToStr(Pelaksanaan) + ', ');
      SQL.Add(IntToStr(Pengakhiran));
    end;

    SQL.Add(')');
    ExecSQL;

    Result := True;

    {Yg barusan diinput diambil lagi datanya, untuk mengetahui Indexnya}
    SQL.Clear;
    SQL.Add('SELECT * FROM SubRole_Definition');
    SQL.Add('WHERE (RoleIndex = ' + IntToStr(rec.RoleIndex) +
     ') and (SubRoleAcronim = ' + QuotedStr(rec.SubRoleAcronim) +
     ') and (SubRoleIdentifier = ' + QuotedStr(rec.SubRoleIdentifier) +
     ') and (Perencanaan = ' + IntToStr(rec.Perencanaan) +
     ') and (Persiapan = ' + IntToStr(rec.Persiapan) +
     ') and (Pelaksanaan = ' + IntToStr(rec.Pelaksanaan) +
     ') and (Pengakhiran = ' + IntToStr(rec.Pengakhiran) + ')' );
    Open;

    rec.SubRoleIndex := FieldByName('SubRoleIndex').AsInteger;
  end;
end;

function TdmINWO.UpdateSubRole(var rec: TRecSubRole): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    with rec do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE SubRole_Definition');
      SQL.Add('SET');
      SQL.Add('RoleIndex=' + IntToStr(rec.RoleIndex)+',');
      SQL.Add('SubRoleAcronim=' + QuotedStr(rec.SubRoleAcronim) + ',');
      SQL.Add('SubRoleIdentifier=' + QuotedStr(rec.SubRoleIdentifier) + ',');
      SQL.Add('Perencanaan=' + IntToStr(rec.Perencanaan) + ',');
      SQL.Add('Persiapan=' + IntToStr(rec.Persiapan) + ',');
      SQL.Add('Pelaksanaan=' + IntToStr(rec.Pelaksanaan)+ ',');
      SQL.Add('Pengakhiran=' + IntToStr(rec.Pengakhiran)+ ',');
      SQL.Add('WHERE (SubRoleIndex =' + IntToStr(rec.SubRoleIndex) + ')');
      ExecSQL;
    end;

    Result := True;
  end;
end;

function TdmINWO.UpdateRole(var rec: TRecRole): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    with rec do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Role_Definition');
      SQL.Add('SET');
      SQL.Add('RoleAcronim=' + QuotedStr(rec.RoleAcronim)+',');
      SQL.Add('RoleIdentifier=' + QuotedStr(rec.RoleIdentifier));
      SQL.Add('WHERE (RoleIndex =' + IntToStr(rec.RoleIndex) + ')');
      ExecSQL;
    end;

    Result := True;
  end;
end;

function TdmINWO.DeleteSubRole(const SubRoleID: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM SubRole_Definition');
    SQL.Add('WHERE (SubRoleIndex = ' + IntToStr(SubRoleID) + ')');
    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM SubRole_Definition');
    SQL.Add('WHERE SubRoleIndex = ' + IntToStr(SubRoleID));
    Open;

    Result := RecordCount = 0;
  end;
end;

function TdmINWO.DeleteRole(const RoleID: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM Role_Definition ');
    SQL.Add('WHERE (RoleIndex = ' + IntToStr(RoleID) + ')');
    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Role_Definition');
    SQL.Add('WHERE RoleIndex = ' + IntToStr(RoleID));
    Open;

    Result := RecordCount = 0;
  end;
end;

function TdmINWO.InsertUserRole(var rec : TRecUser_Role) : Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;

    SQL.Add('INSERT INTO User_Role_Definition');
    SQL.Add('(RoleIndex, SubRoleIndex, UserRoleAcronim, UserRoleIdentifier, Username, Password)');
    SQL.Add('VALUES (');

    with rec do
    begin
      SQL.Add(IntToStr(RoleIndex) + ', ');
      SQL.Add(IntToStr(SubRoleIndex) + ', ');
      SQL.Add(QuotedStr(UserRoleAcronim) + ', ');
      SQL.Add(QuotedStr(UserRoleIdentifier) + ', ');
      SQL.Add(QuotedStr(Username) + ', ');
      SQL.Add(QuotedStr(Password));
    end;

    SQL.Add(')');
    ExecSQL;

    Result := True;

    {Yg barusan diinput diambil lagi datanya, untuk mengetahui Indexnya}
    SQL.Clear;
    SQL.Add('SELECT * FROM User_Role_Definition');
    SQL.Add('WHERE (RoleIndex = ' + IntToStr(rec.RoleIndex) + ') and (SubRoleIndex = ' + IntToStr(rec.SubRoleIndex) + ') and ' );
    SQL.Add('(UserRoleAcronim = ' + QuotedStr(rec.UserRoleAcronim) + ')' );
    Open;

    rec.UserRoleIndex := FieldByName('UserRoleIndex').AsInteger;
  end;
end;

function TdmINWO.UpdateUserRole(var rec: TRecUser_Role): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    with rec do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE User_Role_Definition');
      SQL.Add('SET');
      SQL.Add('RoleIndex=' + IntToStr(rec.RoleIndex)+',');
      SQL.Add('SubRoleIndex=' + IntToStr(rec.SubRoleIndex)+',');
      SQL.Add('UserRoleAcronim=' + QuotedStr(rec.UserRoleAcronim)+',');
      SQL.Add('UserRoleIdentifier=' + QuotedStr(rec.UserRoleIdentifier)+',');
      SQL.Add('Username=' + QuotedStr(rec.Username)+',');
      SQL.Add('Password=' + QuotedStr(rec.Password));
      SQL.Add('WHERE (UserRoleIndex =' + IntToStr(rec.UserRoleIndex) + ')');
      ExecSQL;
    end;

    Result := True;
  end;
end;

function TdmINWO.DeleteUserRole(const UserRoleID: Integer): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM User_Role_Definition');
    SQL.Add('WHERE (UserRoleIndex='+QuotedStr(IntToStr(UserRoleID))+')');
    ExecSQL;
    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Asset '}

{$REGION ' Vehicle '}

function TdmINWO.GetFilterVehicleDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TVehicle_Definition;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Vehicle_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index');
    SQL.Add('WHERE a.Vehicle_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Vehicle_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TVehicle_Definition.Create;

        with rec.FDef do
        begin
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier := FieldByName('Vehicle_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Motion_Characteristics := FieldByName('Motion_Characteristics').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Draft := FieldByName('Draft').AsSingle;
          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Magnetic_Cross := FieldByName('Magnetic_Cross').AsSingle;
          Front_Visual_EO_Cross := FieldByName('Front_Visual_EO_Cross').AsSingle;
          Side_Visual_EO_Cross := FieldByName('Side_Visual_EO_Cross').AsSingle;
          Front_Infrared_Cross := FieldByName('Front_Infrared_Cross').AsSingle;
          Side_Infrared_Cross := FieldByName('Side_Infrared_Cross').AsSingle;
          LSpeed_Acoustic_Intens := FieldByName('LSpeed_Acoustic_Intens').AsSingle;
          Below_Cav_Acoustic_Intens := FieldByName('Below_Cav_Acoustic_Intens').AsSingle;
          Above_Cav_Acoustic_Intens := FieldByName('Above_Cav_Acoustic_Intens').AsSingle;
          HSpeed_Acoustic_Intens := FieldByName('HSpeed_Acoustic_Intens').AsSingle;
          Cavitation_Speed_Switch := FieldByName('Cavitation_Speed_Switch').AsSingle;
          Time_of_Weapon_Impact := FieldByName('Time_of_Weapon_Impact').AsInteger;
          Chaff_Seduction_Capable := FieldByName('Chaff_Seduction_Capable').AsBoolean;
          Seduction_Mode_Prob := FieldByName('Seduction_Mode_Prob').AsSingle;
          Min_Delay_Between_Chaff_Rounds := FieldByName('Min_Delay_Between_Chaff_Rounds').AsInteger;
          Max_Chaff_Salvo_Size := FieldByName('Max_Chaff_Salvo_Size').AsInteger;
          SARH_POH_Modifier := FieldByName('SARH_POH_Modifier').AsSingle;
          CG_POH_Modifier := FieldByName('CG_POH_Modifier').AsSingle;
          TARH_POH_Modifier := FieldByName('TARH_POH_Modifier').AsSingle;
          IR_POH_Modifier := FieldByName('IR_POH_Modifier').AsSingle;
          AR_POH_Modifier := FieldByName('AR_POH_Modifier').AsSingle;
          Active_Acoustic_Tor_POH_Mod := FieldByName('Active_Acoustic_Tor_POH_Mod').AsSingle;
          Passive_Acoustic_Tor_POH_Mod := FieldByName('Passive_Acoustic_Tor_POH_Mod').AsSingle;
          Active_Passive_Tor_POH_Mod := FieldByName('Active_Passive_Tor_POH_Mod').AsSingle;
          Wake_Home_POH_Modifier := FieldByName('Wake_Home_POH_Modifier').AsSingle;
          Wire_Guide_POH_Modifier := FieldByName('Wire_Guide_POH_Modifier').AsSingle;
          Mag_Mine_POH_Modifier := FieldByName('Mag_Mine_POH_Modifier').AsSingle;
          Press_Mine_POH_Modifier := FieldByName('Press_Mine_POH_Modifier').AsSingle;
          Impact_Mine_POH_Modifier := FieldByName('Impact_Mine_POH_Modifier').AsSingle;
          Acoustic_Mine_POH_Modifier := FieldByName('Acoustic_Mine_POH_Modifier').AsSingle;
          Sub_Comm_Antenna_Height := FieldByName('Sub_Comm_Antenna_Height').AsSingle;
          Rel_Comm_Antenna_Height := FieldByName('Rel_Comm_Antenna_Height').AsSingle;
          Max_Comm_Operating_Depth := FieldByName('Max_Comm_Operating_Depth').AsSingle;
          HF_Link_Capable := FieldByName('HF_Link_Capable').AsBoolean;
          UHF_Link_Capable := FieldByName('UHF_Link_Capable').AsBoolean;
          HF_Voice_Capable := FieldByName('HF_Voice_Capable').AsBoolean;
          VHF_Voice_Capable := FieldByName('VHF_Voice_Capable').AsBoolean;
          UHF_Voice_Capable := FieldByName('UHF_Voice_Capable').AsBoolean;
          SATCOM_Voice_Capable := FieldByName('SATCOM_Voice_Capable').AsBoolean;
          UWT_Voice_Capable := FieldByName('UWT_Voice_Capable').AsBoolean;
          HF_MHS_Capable := FieldByName('HF_MHS_Capable').AsBoolean;
          UHF_MHS_Capable := FieldByName('UHF_MHS_Capable').AsBoolean;
          SATCOM_MHS_Capable := FieldByName('SATCOM_MHS_Capable').AsBoolean;
          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
          Plat_Basing_Capability := FieldByName('Plat_Basing_Capability').AsBoolean;
          Chaff_Capability := FieldByName('Chaff_Capability').AsBoolean;
          Readying_Time := FieldByName('Readying_Time').AsInteger;
          Sonobuoy_Capable := FieldByName('Sonobuoy_Capable').AsBoolean;
          Nav_Light_Capable := FieldByName('Nav_Light_Capable').AsBoolean;
          Periscope_Depth := FieldByName('Periscope_Depth').AsSingle;
          Periscope_Height_Above_Water := FieldByName('Periscope_Height_Above_Water').AsSingle;
          Periscope_Front_Radar_Xsection := FieldByName('Periscope_Front_Radar_Xsection').AsSingle;
          Periscope_Side_Radar_Xsection := FieldByName('Periscope_Side_Radar_Xsection').AsSingle;
          Periscope_Front_Vis_Xsection := FieldByName('Periscope_Front_Vis_Xsection').AsSingle;
          Periscope_Side_Vis_Xsection := FieldByName('Periscope_Side_Vis_Xsection').AsSingle;
          Periscope_Front_IR_Xsection := FieldByName('Periscope_Front_IR_Xsection').AsSingle;
          Periscope_Side_IR_Xsection := FieldByName('Periscope_Side_IR_Xsection').AsSingle;
          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
          Auto_Air_Defense_Capable := FieldByName('Auto_Air_Defense_Capable').AsBoolean;
          Alert_State_Time := FieldByName('Alert_State_Time').AsSingle;
          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
          Max_Sonobuoys_To_Monitor := FieldByName('Max_Sonobuoys_To_Monitor').AsInteger;
          Sonobuoy_Deploy_Max_Altitude := FieldByName('Sonobuoy_Deploy_Max_Altitude').AsInteger;
          Sonobuoy_Deploy_Min_Altitude := FieldByName('Sonobuoy_Deploy_Min_Altitude').AsInteger;
          Sonobuoy_Deploy_Max_Speed := FieldByName('Sonobuoy_Deploy_Max_Speed').AsInteger;
          Air_Drop_Torpedo_Max_Altitude := FieldByName('Air_Drop_Torpedo_Max_Altitude').AsInteger;
          Air_Drop_Torpedo_Min_Altitude := FieldByName('Air_Drop_Torpedo_Min_Altitude').AsInteger;
          Air_Drop_Torpedo_Max_Speed := FieldByName('Air_Drop_Torpedo_Max_Speed').AsInteger;
          TMA_Rate_Factor := FieldByName('TMA_Rate_Factor').AsSingle;
          HMS_Noise_Reduction_Factor := FieldByName('HMS_Noise_Reduction_Factor').AsSingle;
          TAS_Noise_Reduction_Factor := FieldByName('TAS_Noise_Reduction_Factor').AsSingle;
          Infrared_Decoy_Capable := FieldByName('Infrared_Decoy_Capable').AsBoolean;
          HF_Mid_Course_Update_Capable := FieldByName('HF_Mid_Course_Update_Capable').AsBoolean;
          UHF_Mid_Course_Update_Capable := FieldByName('UHF_Mid_Course_Update_Capable').AsBoolean;
          Platform_Capability_Index := FieldByName('Platform_Capability_Index').AsInteger;
          Logistics_Index := FieldByName('Logistics_Index').AsInteger;
//          SATCOM_Mid_Course_Update_Capable := FieldByName('SATCOM_Mid_Course_Update_Capable').AsBoolean;
          Font_id := FieldByName('font_id').AsInteger;
          VBS_Class_Name := FieldByName('vbs_class_name').AsString;
          Quantity_Group_Personal := FieldByName('Quantity_Group_Personal').AsInteger;
          GangwayPosition := FieldByName('GangwayPosition').AsInteger;
          DWT := FieldByName('DWT').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterVehicleDefByDomain(var aList: TList; aFilter: Integer): Integer;
var
  i : Integer;
  rec : TVehicle_Definition;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Vehicle_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index');
    SQL.Add('WHERE a.Platform_Domain = ' + IntToStr(aFilter));
    SQL.Add('ORDER BY Vehicle_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TVehicle_Definition.Create;

        with rec.FDef do
        begin
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier := FieldByName('Vehicle_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Motion_Characteristics := FieldByName('Motion_Characteristics')
            .AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Draft := FieldByName('Draft').AsSingle;
          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Magnetic_Cross := FieldByName('Magnetic_Cross').AsSingle;
          Front_Visual_EO_Cross := FieldByName('Front_Visual_EO_Cross')
            .AsSingle;
          Side_Visual_EO_Cross := FieldByName('Side_Visual_EO_Cross').AsSingle;
          Front_Infrared_Cross := FieldByName('Front_Infrared_Cross').AsSingle;
          Side_Infrared_Cross := FieldByName('Side_Infrared_Cross').AsSingle;
          LSpeed_Acoustic_Intens := FieldByName('LSpeed_Acoustic_Intens')
            .AsSingle;
          Below_Cav_Acoustic_Intens := FieldByName('Below_Cav_Acoustic_Intens')
            .AsSingle;
          Above_Cav_Acoustic_Intens := FieldByName('Above_Cav_Acoustic_Intens')
            .AsSingle;
          HSpeed_Acoustic_Intens := FieldByName('HSpeed_Acoustic_Intens')
            .AsSingle;
          Cavitation_Speed_Switch := FieldByName('Cavitation_Speed_Switch')
            .AsSingle;
          Time_of_Weapon_Impact := FieldByName('Time_of_Weapon_Impact')
            .AsInteger;
          Chaff_Seduction_Capable := FieldByName('Chaff_Seduction_Capable')
            .AsBoolean;
          Seduction_Mode_Prob := FieldByName('Seduction_Mode_Prob').AsSingle;
          Min_Delay_Between_Chaff_Rounds := FieldByName
            ('Min_Delay_Between_Chaff_Rounds').AsInteger;
          Max_Chaff_Salvo_Size := FieldByName('Max_Chaff_Salvo_Size').AsInteger;
          SARH_POH_Modifier := FieldByName('SARH_POH_Modifier').AsSingle;
          CG_POH_Modifier := FieldByName('CG_POH_Modifier').AsSingle;
          TARH_POH_Modifier := FieldByName('TARH_POH_Modifier').AsSingle;
          IR_POH_Modifier := FieldByName('IR_POH_Modifier').AsSingle;
          AR_POH_Modifier := FieldByName('AR_POH_Modifier').AsSingle;
          Active_Acoustic_Tor_POH_Mod := FieldByName
            ('Active_Acoustic_Tor_POH_Mod').AsSingle;
          Passive_Acoustic_Tor_POH_Mod := FieldByName
            ('Passive_Acoustic_Tor_POH_Mod').AsSingle;
          Active_Passive_Tor_POH_Mod := FieldByName
            ('Active_Passive_Tor_POH_Mod').AsSingle;
          Wake_Home_POH_Modifier := FieldByName('Wake_Home_POH_Modifier')
            .AsSingle;
          Wire_Guide_POH_Modifier := FieldByName('Wire_Guide_POH_Modifier')
            .AsSingle;
          Mag_Mine_POH_Modifier := FieldByName('Mag_Mine_POH_Modifier')
            .AsSingle;
          Press_Mine_POH_Modifier := FieldByName('Press_Mine_POH_Modifier')
            .AsSingle;
          Impact_Mine_POH_Modifier := FieldByName('Impact_Mine_POH_Modifier')
            .AsSingle;
          Acoustic_Mine_POH_Modifier := FieldByName
            ('Acoustic_Mine_POH_Modifier').AsSingle;
          Sub_Comm_Antenna_Height := FieldByName('Sub_Comm_Antenna_Height')
            .AsSingle;
          Rel_Comm_Antenna_Height := FieldByName('Rel_Comm_Antenna_Height')
            .AsSingle;
          Max_Comm_Operating_Depth := FieldByName('Max_Comm_Operating_Depth')
            .AsSingle;
          HF_Link_Capable := FieldByName('HF_Link_Capable').AsBoolean;
          UHF_Link_Capable := FieldByName('UHF_Link_Capable').AsBoolean;
          HF_Voice_Capable := FieldByName('HF_Voice_Capable').AsBoolean;
          VHF_Voice_Capable := FieldByName('VHF_Voice_Capable').AsBoolean;
          UHF_Voice_Capable := FieldByName('UHF_Voice_Capable').AsBoolean;
          SATCOM_Voice_Capable := FieldByName('SATCOM_Voice_Capable').AsBoolean;
          UWT_Voice_Capable := FieldByName('UWT_Voice_Capable').AsBoolean;
          HF_MHS_Capable := FieldByName('HF_MHS_Capable').AsBoolean;
          UHF_MHS_Capable := FieldByName('UHF_MHS_Capable').AsBoolean;
          SATCOM_MHS_Capable := FieldByName('SATCOM_MHS_Capable').AsBoolean;
          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
          Plat_Basing_Capability := FieldByName('Plat_Basing_Capability')
            .AsBoolean;
          Chaff_Capability := FieldByName('Chaff_Capability').AsBoolean;
          Readying_Time := FieldByName('Readying_Time').AsInteger;
          Sonobuoy_Capable := FieldByName('Sonobuoy_Capable').AsBoolean;
          Nav_Light_Capable := FieldByName('Nav_Light_Capable').AsBoolean;
          Periscope_Depth := FieldByName('Periscope_Depth').AsSingle;
          Periscope_Height_Above_Water := FieldByName
            ('Periscope_Height_Above_Water').AsSingle;
          Periscope_Front_Radar_Xsection := FieldByName
            ('Periscope_Front_Radar_Xsection').AsSingle;
          Periscope_Side_Radar_Xsection := FieldByName
            ('Periscope_Side_Radar_Xsection').AsSingle;
          Periscope_Front_Vis_Xsection := FieldByName
            ('Periscope_Front_Vis_Xsection').AsSingle;
          Periscope_Side_Vis_Xsection := FieldByName
            ('Periscope_Side_Vis_Xsection').AsSingle;
          Periscope_Front_IR_Xsection := FieldByName
            ('Periscope_Front_IR_Xsection').AsSingle;
          Periscope_Side_IR_Xsection := FieldByName
            ('Periscope_Side_IR_Xsection').AsSingle;
          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
          Auto_Air_Defense_Capable := FieldByName('Auto_Air_Defense_Capable')
            .AsBoolean;
          Alert_State_Time := FieldByName('Alert_State_Time').AsSingle;
          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
          Max_Sonobuoys_To_Monitor := FieldByName('Max_Sonobuoys_To_Monitor')
            .AsInteger;
          Sonobuoy_Deploy_Max_Altitude := FieldByName
            ('Sonobuoy_Deploy_Max_Altitude').AsInteger;
          Sonobuoy_Deploy_Min_Altitude := FieldByName
            ('Sonobuoy_Deploy_Min_Altitude').AsInteger;
          Sonobuoy_Deploy_Max_Speed := FieldByName('Sonobuoy_Deploy_Max_Speed')
            .AsInteger;
          Air_Drop_Torpedo_Max_Altitude := FieldByName
            ('Air_Drop_Torpedo_Max_Altitude').AsInteger;
          Air_Drop_Torpedo_Min_Altitude := FieldByName
            ('Air_Drop_Torpedo_Min_Altitude').AsInteger;
          Air_Drop_Torpedo_Max_Speed := FieldByName
            ('Air_Drop_Torpedo_Max_Speed')
            .AsInteger;
          TMA_Rate_Factor := FieldByName('TMA_Rate_Factor').AsSingle;
          HMS_Noise_Reduction_Factor := FieldByName
            ('HMS_Noise_Reduction_Factor').AsSingle;
          TAS_Noise_Reduction_Factor := FieldByName
            ('TAS_Noise_Reduction_Factor').AsSingle;
          Infrared_Decoy_Capable := FieldByName('Infrared_Decoy_Capable')
            .AsBoolean;
          HF_Mid_Course_Update_Capable := FieldByName
            ('HF_Mid_Course_Update_Capable').AsBoolean;
          UHF_Mid_Course_Update_Capable := FieldByName
            ('UHF_Mid_Course_Update_Capable').AsBoolean;
//          SATCOM_Mid_Course_Update_Capable := FieldByName
//            ('SATCOM_Mid_Course_Update_Capable').AsBoolean;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterVehicleForLandDomain(var aList: TList; aFilter : Integer): Integer;
var
  i : Integer;
  rec : TVehicle_Definition;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Vehicle_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index');
    SQL.Add('WHERE a.Platform_Domain = 3 and ');

    if aFilter = 0 then
    begin
      SQL.Add('a.Platform_Category = 2 and a.Platform_Type = 0');
    end
    else
    begin
      SQL.Add('a.Platform_Category <> 2 and a.Platform_Type <> 0');
    end;

    SQL.Add('ORDER BY Vehicle_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TVehicle_Definition.Create;

        with rec.FDef do
        begin
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier := FieldByName('Vehicle_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Motion_Characteristics := FieldByName('Motion_Characteristics').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Draft := FieldByName('Draft').AsSingle;
          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Magnetic_Cross := FieldByName('Magnetic_Cross').AsSingle;
          Front_Visual_EO_Cross := FieldByName('Front_Visual_EO_Cross').AsSingle;
          Side_Visual_EO_Cross := FieldByName('Side_Visual_EO_Cross').AsSingle;
          Front_Infrared_Cross := FieldByName('Front_Infrared_Cross').AsSingle;
          Side_Infrared_Cross := FieldByName('Side_Infrared_Cross').AsSingle;
          LSpeed_Acoustic_Intens := FieldByName('LSpeed_Acoustic_Intens').AsSingle;
          Below_Cav_Acoustic_Intens := FieldByName('Below_Cav_Acoustic_Intens').AsSingle;
          Above_Cav_Acoustic_Intens := FieldByName('Above_Cav_Acoustic_Intens').AsSingle;
          HSpeed_Acoustic_Intens := FieldByName('HSpeed_Acoustic_Intens').AsSingle;
          Cavitation_Speed_Switch := FieldByName('Cavitation_Speed_Switch').AsSingle;
          Time_of_Weapon_Impact := FieldByName('Time_of_Weapon_Impact').AsInteger;
          Chaff_Seduction_Capable := FieldByName('Chaff_Seduction_Capable').AsBoolean;
          Seduction_Mode_Prob := FieldByName('Seduction_Mode_Prob').AsSingle;
          Min_Delay_Between_Chaff_Rounds := FieldByName('Min_Delay_Between_Chaff_Rounds').AsInteger;
          Max_Chaff_Salvo_Size := FieldByName('Max_Chaff_Salvo_Size').AsInteger;
          SARH_POH_Modifier := FieldByName('SARH_POH_Modifier').AsSingle;
          CG_POH_Modifier := FieldByName('CG_POH_Modifier').AsSingle;
          TARH_POH_Modifier := FieldByName('TARH_POH_Modifier').AsSingle;
          IR_POH_Modifier := FieldByName('IR_POH_Modifier').AsSingle;
          AR_POH_Modifier := FieldByName('AR_POH_Modifier').AsSingle;
          Active_Acoustic_Tor_POH_Mod := FieldByName('Active_Acoustic_Tor_POH_Mod').AsSingle;
          Passive_Acoustic_Tor_POH_Mod := FieldByName('Passive_Acoustic_Tor_POH_Mod').AsSingle;
          Active_Passive_Tor_POH_Mod := FieldByName('Active_Passive_Tor_POH_Mod').AsSingle;
          Wake_Home_POH_Modifier := FieldByName('Wake_Home_POH_Modifier').AsSingle;
          Wire_Guide_POH_Modifier := FieldByName('Wire_Guide_POH_Modifier').AsSingle;
          Mag_Mine_POH_Modifier := FieldByName('Mag_Mine_POH_Modifier').AsSingle;
          Press_Mine_POH_Modifier := FieldByName('Press_Mine_POH_Modifier').AsSingle;
          Impact_Mine_POH_Modifier := FieldByName('Impact_Mine_POH_Modifier').AsSingle;
          Acoustic_Mine_POH_Modifier := FieldByName('Acoustic_Mine_POH_Modifier').AsSingle;
          Sub_Comm_Antenna_Height := FieldByName('Sub_Comm_Antenna_Height').AsSingle;
          Rel_Comm_Antenna_Height := FieldByName('Rel_Comm_Antenna_Height').AsSingle;
          Max_Comm_Operating_Depth := FieldByName('Max_Comm_Operating_Depth').AsSingle;
          HF_Link_Capable := FieldByName('HF_Link_Capable').AsBoolean;
          UHF_Link_Capable := FieldByName('UHF_Link_Capable').AsBoolean;
          HF_Voice_Capable := FieldByName('HF_Voice_Capable').AsBoolean;
          VHF_Voice_Capable := FieldByName('VHF_Voice_Capable').AsBoolean;
          UHF_Voice_Capable := FieldByName('UHF_Voice_Capable').AsBoolean;
          SATCOM_Voice_Capable := FieldByName('SATCOM_Voice_Capable').AsBoolean;
          UWT_Voice_Capable := FieldByName('UWT_Voice_Capable').AsBoolean;
          HF_MHS_Capable := FieldByName('HF_MHS_Capable').AsBoolean;
          UHF_MHS_Capable := FieldByName('UHF_MHS_Capable').AsBoolean;
          SATCOM_MHS_Capable := FieldByName('SATCOM_MHS_Capable').AsBoolean;
          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
          Plat_Basing_Capability := FieldByName('Plat_Basing_Capability').AsBoolean;
          Chaff_Capability := FieldByName('Chaff_Capability').AsBoolean;
          Readying_Time := FieldByName('Readying_Time').AsInteger;
          Sonobuoy_Capable := FieldByName('Sonobuoy_Capable').AsBoolean;
          Nav_Light_Capable := FieldByName('Nav_Light_Capable').AsBoolean;
          Periscope_Depth := FieldByName('Periscope_Depth').AsSingle;
          Periscope_Height_Above_Water := FieldByName('Periscope_Height_Above_Water').AsSingle;
          Periscope_Front_Radar_Xsection := FieldByName('Periscope_Front_Radar_Xsection').AsSingle;
          Periscope_Side_Radar_Xsection := FieldByName('Periscope_Side_Radar_Xsection').AsSingle;
          Periscope_Front_Vis_Xsection := FieldByName('Periscope_Front_Vis_Xsection').AsSingle;
          Periscope_Side_Vis_Xsection := FieldByName('Periscope_Side_Vis_Xsection').AsSingle;
          Periscope_Front_IR_Xsection := FieldByName('Periscope_Front_IR_Xsection').AsSingle;
          Periscope_Side_IR_Xsection := FieldByName('Periscope_Side_IR_Xsection').AsSingle;
          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
          Auto_Air_Defense_Capable := FieldByName('Auto_Air_Defense_Capable').AsBoolean;
          Alert_State_Time := FieldByName('Alert_State_Time').AsSingle;
          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
          Max_Sonobuoys_To_Monitor := FieldByName('Max_Sonobuoys_To_Monitor').AsInteger;
          Sonobuoy_Deploy_Max_Altitude := FieldByName('Sonobuoy_Deploy_Max_Altitude').AsInteger;
          Sonobuoy_Deploy_Min_Altitude := FieldByName('Sonobuoy_Deploy_Min_Altitude').AsInteger;
          Sonobuoy_Deploy_Max_Speed := FieldByName('Sonobuoy_Deploy_Max_Speed').AsInteger;
          Air_Drop_Torpedo_Max_Altitude := FieldByName('Air_Drop_Torpedo_Max_Altitude').AsInteger;
          Air_Drop_Torpedo_Min_Altitude := FieldByName('Air_Drop_Torpedo_Min_Altitude').AsInteger;
          Air_Drop_Torpedo_Max_Speed := FieldByName('Air_Drop_Torpedo_Max_Speed').AsInteger;
          TMA_Rate_Factor := FieldByName('TMA_Rate_Factor').AsSingle;
          HMS_Noise_Reduction_Factor := FieldByName('HMS_Noise_Reduction_Factor').AsSingle;
          TAS_Noise_Reduction_Factor := FieldByName('TAS_Noise_Reduction_Factor').AsSingle;
          Infrared_Decoy_Capable := FieldByName('Infrared_Decoy_Capable').AsBoolean;
          HF_Mid_Course_Update_Capable := FieldByName('HF_Mid_Course_Update_Capable').AsBoolean;
          UHF_Mid_Course_Update_Capable := FieldByName('UHF_Mid_Course_Update_Capable').AsBoolean;
//          SATCOM_Mid_Course_Update_Capable := FieldByName
//            ('SATCOM_Mid_Course_Update_Capable').AsBoolean;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAllVehicleDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TVehicle_Definition;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Vehicle_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index');
    SQL.Add('ORDER BY Vehicle_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TVehicle_Definition.Create;

        with rec.FDef do
        begin
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier := FieldByName('Vehicle_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Motion_Characteristics := FieldByName('Motion_Characteristics').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Draft := FieldByName('Draft').AsSingle;
          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Magnetic_Cross := FieldByName('Magnetic_Cross').AsSingle;
          Front_Visual_EO_Cross := FieldByName('Front_Visual_EO_Cross').AsSingle;
          Side_Visual_EO_Cross := FieldByName('Side_Visual_EO_Cross').AsSingle;
          Front_Infrared_Cross := FieldByName('Front_Infrared_Cross').AsSingle;
          Side_Infrared_Cross := FieldByName('Side_Infrared_Cross').AsSingle;
          LSpeed_Acoustic_Intens := FieldByName('LSpeed_Acoustic_Intens').AsSingle;
          Below_Cav_Acoustic_Intens := FieldByName('Below_Cav_Acoustic_Intens').AsSingle;
          Above_Cav_Acoustic_Intens := FieldByName('Above_Cav_Acoustic_Intens').AsSingle;
          HSpeed_Acoustic_Intens := FieldByName('HSpeed_Acoustic_Intens').AsSingle;
          Cavitation_Speed_Switch := FieldByName('Cavitation_Speed_Switch').AsSingle;
          Time_of_Weapon_Impact := FieldByName('Time_of_Weapon_Impact').AsInteger;
          Chaff_Seduction_Capable := FieldByName('Chaff_Seduction_Capable').AsBoolean;
          Seduction_Mode_Prob := FieldByName('Seduction_Mode_Prob').AsSingle;
          Min_Delay_Between_Chaff_Rounds := FieldByName('Min_Delay_Between_Chaff_Rounds').AsInteger;
          Max_Chaff_Salvo_Size := FieldByName('Max_Chaff_Salvo_Size').AsInteger;
          SARH_POH_Modifier := FieldByName('SARH_POH_Modifier').AsSingle;
          CG_POH_Modifier := FieldByName('CG_POH_Modifier').AsSingle;
          TARH_POH_Modifier := FieldByName('TARH_POH_Modifier').AsSingle;
          IR_POH_Modifier := FieldByName('IR_POH_Modifier').AsSingle;
          AR_POH_Modifier := FieldByName('AR_POH_Modifier').AsSingle;
          Active_Acoustic_Tor_POH_Mod := FieldByName('Active_Acoustic_Tor_POH_Mod').AsSingle;
          Passive_Acoustic_Tor_POH_Mod := FieldByName('Passive_Acoustic_Tor_POH_Mod').AsSingle;
          Active_Passive_Tor_POH_Mod := FieldByName('Active_Passive_Tor_POH_Mod').AsSingle;
          Wake_Home_POH_Modifier := FieldByName('Wake_Home_POH_Modifier').AsSingle;
          Wire_Guide_POH_Modifier := FieldByName('Wire_Guide_POH_Modifier').AsSingle;
          Mag_Mine_POH_Modifier := FieldByName('Mag_Mine_POH_Modifier').AsSingle;
          Press_Mine_POH_Modifier := FieldByName('Press_Mine_POH_Modifier').AsSingle;
          Impact_Mine_POH_Modifier := FieldByName('Impact_Mine_POH_Modifier').AsSingle;
          Acoustic_Mine_POH_Modifier := FieldByName('Acoustic_Mine_POH_Modifier').AsSingle;
          Sub_Comm_Antenna_Height := FieldByName('Sub_Comm_Antenna_Height').AsSingle;
          Rel_Comm_Antenna_Height := FieldByName('Rel_Comm_Antenna_Height').AsSingle;
          Max_Comm_Operating_Depth := FieldByName('Max_Comm_Operating_Depth').AsSingle;
          HF_Link_Capable := FieldByName('HF_Link_Capable').AsBoolean;
          UHF_Link_Capable := FieldByName('UHF_Link_Capable').AsBoolean;
          HF_Voice_Capable := FieldByName('HF_Voice_Capable').AsBoolean;
          VHF_Voice_Capable := FieldByName('VHF_Voice_Capable').AsBoolean;
          UHF_Voice_Capable := FieldByName('UHF_Voice_Capable').AsBoolean;
          SATCOM_Voice_Capable := FieldByName('SATCOM_Voice_Capable').AsBoolean;
          UWT_Voice_Capable := FieldByName('UWT_Voice_Capable').AsBoolean;
          HF_MHS_Capable := FieldByName('HF_MHS_Capable').AsBoolean;
          UHF_MHS_Capable := FieldByName('UHF_MHS_Capable').AsBoolean;
          SATCOM_MHS_Capable := FieldByName('SATCOM_MHS_Capable').AsBoolean;
          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
          Plat_Basing_Capability := FieldByName('Plat_Basing_Capability').AsBoolean;
          Chaff_Capability := FieldByName('Chaff_Capability').AsBoolean;
          Readying_Time := FieldByName('Readying_Time').AsInteger;
          Sonobuoy_Capable := FieldByName('Sonobuoy_Capable').AsBoolean;
          Nav_Light_Capable := FieldByName('Nav_Light_Capable').AsBoolean;
          Periscope_Depth := FieldByName('Periscope_Depth').AsSingle;
          Periscope_Height_Above_Water := FieldByName('Periscope_Height_Above_Water').AsSingle;
          Periscope_Front_Radar_Xsection := FieldByName('Periscope_Front_Radar_Xsection').AsSingle;
          Periscope_Side_Radar_Xsection := FieldByName('Periscope_Side_Radar_Xsection').AsSingle;
          Periscope_Front_Vis_Xsection := FieldByName('Periscope_Front_Vis_Xsection').AsSingle;
          Periscope_Side_Vis_Xsection := FieldByName('Periscope_Side_Vis_Xsection').AsSingle;
          Periscope_Front_IR_Xsection := FieldByName('Periscope_Front_IR_Xsection').AsSingle;
          Periscope_Side_IR_Xsection := FieldByName('Periscope_Side_IR_Xsection').AsSingle;
          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
          Auto_Air_Defense_Capable := FieldByName('Auto_Air_Defense_Capable').AsBoolean;
          Alert_State_Time := FieldByName('Alert_State_Time').AsSingle;
          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
          Max_Sonobuoys_To_Monitor := FieldByName('Max_Sonobuoys_To_Monitor').AsInteger;
          Sonobuoy_Deploy_Max_Altitude := FieldByName('Sonobuoy_Deploy_Max_Altitude').AsInteger;
          Sonobuoy_Deploy_Min_Altitude := FieldByName('Sonobuoy_Deploy_Min_Altitude').AsInteger;
          Sonobuoy_Deploy_Max_Speed := FieldByName('Sonobuoy_Deploy_Max_Speed').AsInteger;
          Air_Drop_Torpedo_Max_Altitude := FieldByName('Air_Drop_Torpedo_Max_Altitude').AsInteger;
          Air_Drop_Torpedo_Min_Altitude := FieldByName('Air_Drop_Torpedo_Min_Altitude').AsInteger;
          Air_Drop_Torpedo_Max_Speed := FieldByName('Air_Drop_Torpedo_Max_Speed').AsInteger;
          TMA_Rate_Factor := FieldByName('TMA_Rate_Factor').AsSingle;
          HMS_Noise_Reduction_Factor := FieldByName('HMS_Noise_Reduction_Factor').AsSingle;
          TAS_Noise_Reduction_Factor := FieldByName('TAS_Noise_Reduction_Factor').AsSingle;
          Infrared_Decoy_Capable := FieldByName('Infrared_Decoy_Capable').AsBoolean;
          HF_Mid_Course_Update_Capable := FieldByName('HF_Mid_Course_Update_Capable').AsBoolean;
          UHF_Mid_Course_Update_Capable := FieldByName('UHF_Mid_Course_Update_Capable').AsBoolean;
          Platform_Capability_Index := FieldByName('Platform_Capability_Index').AsInteger;
          Logistics_Index := FieldByName('Logistics_Index').AsInteger;
//          SATCOM_Mid_Course_Update_Capable := FieldByName('SATCOM_Mid_Course_Update_Capable').AsBoolean;
          Font_id := FieldByName('font_id').AsInteger;
          VBS_Class_Name := FieldByName('vbs_class_name').AsString;
          Quantity_Group_Personal := FieldByName('Quantity_Group_Personal').AsInteger;
          GangwayPosition := FieldByName('GangwayPosition').AsInteger;
          FrontGangway := FieldByName('FrontGangway').AsBoolean;
          RearGangway := FieldByName('RearGangway').AsBoolean;
          PortGangway := FieldByName('PortGangway').AsBoolean;
          StarBoardGangway := FieldByName('StarBoardGangway').AsBoolean;
          DWT := FieldByName('DWT').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetVehicleDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Vehicle_Definition');
    SQL.Add('WHERE Vehicle_Identifier = ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.GetVehicleDef(const aVehicleID: Integer; var aResult: TVehicle_Definition): boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Vehicle_Definition');
    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
    Open;

    Result := RecordCount > 0;

    if not IsEmpty then
    begin
      First;
      aResult := TVehicle_Definition.Create;

      with aResult.FDef do
      begin
        Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
        Vehicle_Identifier := FieldByName('Vehicle_Identifier').AsString;
        Platform_Domain := FieldByName('Platform_Domain').AsInteger;
        Platform_Category := FieldByName('Platform_Category').AsInteger;
        Platform_Type := FieldByName('Platform_Type').AsInteger;
        Motion_Characteristics := FieldByName('Motion_Characteristics').AsInteger;
        Length := FieldByName('Length').AsSingle;
        Width := FieldByName('Width').AsSingle;
        Height := FieldByName('Height').AsSingle;
        Draft := FieldByName('Draft').AsSingle;
        Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
        Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
        Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
        Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
        Magnetic_Cross := FieldByName('Magnetic_Cross').AsSingle;
        Front_Visual_EO_Cross := FieldByName('Front_Visual_EO_Cross').AsSingle;
        Side_Visual_EO_Cross := FieldByName('Side_Visual_EO_Cross').AsSingle;
        Front_Infrared_Cross := FieldByName('Front_Infrared_Cross').AsSingle;
        Side_Infrared_Cross := FieldByName('Side_Infrared_Cross').AsSingle;
        LSpeed_Acoustic_Intens := FieldByName('LSpeed_Acoustic_Intens').AsSingle;
        Below_Cav_Acoustic_Intens := FieldByName('Below_Cav_Acoustic_Intens').AsSingle;
        Above_Cav_Acoustic_Intens := FieldByName('Above_Cav_Acoustic_Intens').AsSingle;
        HSpeed_Acoustic_Intens := FieldByName('HSpeed_Acoustic_Intens').AsSingle;
        Cavitation_Speed_Switch := FieldByName('Cavitation_Speed_Switch').AsSingle;
        Time_of_Weapon_Impact := FieldByName('Time_of_Weapon_Impact').AsInteger;
        Chaff_Seduction_Capable := FieldByName('Chaff_Seduction_Capable').AsBoolean;
        Seduction_Mode_Prob := FieldByName('Seduction_Mode_Prob').AsSingle;
        Min_Delay_Between_Chaff_Rounds := FieldByName('Min_Delay_Between_Chaff_Rounds').AsInteger;
        Max_Chaff_Salvo_Size := FieldByName('Max_Chaff_Salvo_Size').AsInteger;
        SARH_POH_Modifier := FieldByName('SARH_POH_Modifier').AsSingle;
        CG_POH_Modifier := FieldByName('CG_POH_Modifier').AsSingle;
        TARH_POH_Modifier := FieldByName('TARH_POH_Modifier').AsSingle;
        IR_POH_Modifier := FieldByName('IR_POH_Modifier').AsSingle;
        AR_POH_Modifier := FieldByName('AR_POH_Modifier').AsSingle;
        Active_Acoustic_Tor_POH_Mod := FieldByName('Active_Acoustic_Tor_POH_Mod').AsSingle;
        Passive_Acoustic_Tor_POH_Mod := FieldByName('Passive_Acoustic_Tor_POH_Mod').AsSingle;
        Active_Passive_Tor_POH_Mod := FieldByName('Active_Passive_Tor_POH_Mod').AsSingle;
        Wake_Home_POH_Modifier := FieldByName('Wake_Home_POH_Modifier').AsSingle;
        Wire_Guide_POH_Modifier := FieldByName('Wire_Guide_POH_Modifier').AsSingle;
        Mag_Mine_POH_Modifier := FieldByName('Mag_Mine_POH_Modifier').AsSingle;
        Press_Mine_POH_Modifier := FieldByName('Press_Mine_POH_Modifier').AsSingle;
        Impact_Mine_POH_Modifier := FieldByName('Impact_Mine_POH_Modifier').AsSingle;
        Acoustic_Mine_POH_Modifier := FieldByName('Acoustic_Mine_POH_Modifier').AsSingle;
        Sub_Comm_Antenna_Height := FieldByName('Sub_Comm_Antenna_Height').AsSingle;
        Rel_Comm_Antenna_Height := FieldByName('Rel_Comm_Antenna_Height').AsSingle;
        Max_Comm_Operating_Depth := FieldByName('Max_Comm_Operating_Depth').AsSingle;
        HF_Link_Capable := FieldByName('HF_Link_Capable').AsBoolean;
        UHF_Link_Capable := FieldByName('UHF_Link_Capable').AsBoolean;
        HF_Voice_Capable := FieldByName('HF_Voice_Capable').AsBoolean;
        VHF_Voice_Capable := FieldByName('VHF_Voice_Capable').AsBoolean;
        UHF_Voice_Capable := FieldByName('UHF_Voice_Capable').AsBoolean;
        SATCOM_Voice_Capable := FieldByName('SATCOM_Voice_Capable').AsBoolean;
        UWT_Voice_Capable := FieldByName('UWT_Voice_Capable').AsBoolean;
        HF_MHS_Capable := FieldByName('HF_MHS_Capable').AsBoolean;
        UHF_MHS_Capable := FieldByName('UHF_MHS_Capable').AsBoolean;
        SATCOM_MHS_Capable := FieldByName('SATCOM_MHS_Capable').AsBoolean;
        Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
        Plat_Basing_Capability := FieldByName('Plat_Basing_Capability').AsBoolean;
        Chaff_Capability := FieldByName('Chaff_Capability').AsBoolean;
        Readying_Time := FieldByName('Readying_Time').AsInteger;
        Sonobuoy_Capable := FieldByName('Sonobuoy_Capable').AsBoolean;
        Nav_Light_Capable := FieldByName('Nav_Light_Capable').AsBoolean;
        Periscope_Depth := FieldByName('Periscope_Depth').AsSingle;
        Periscope_Height_Above_Water := FieldByName('Periscope_Height_Above_Water').AsSingle;
        Periscope_Front_Radar_Xsection := FieldByName('Periscope_Front_Radar_Xsection').AsSingle;
        Periscope_Side_Radar_Xsection := FieldByName('Periscope_Side_Radar_Xsection').AsSingle;
        Periscope_Front_Vis_Xsection := FieldByName('Periscope_Front_Vis_Xsection').AsSingle;
        Periscope_Side_Vis_Xsection := FieldByName('Periscope_Side_Vis_Xsection').AsSingle;
        Periscope_Front_IR_Xsection := FieldByName('Periscope_Front_IR_Xsection').AsSingle;
        Periscope_Side_IR_Xsection := FieldByName('Periscope_Side_IR_Xsection').AsSingle;
        Engagement_Range := FieldByName('Engagement_Range').AsSingle;
        Auto_Air_Defense_Capable := FieldByName('Auto_Air_Defense_Capable').AsBoolean;
        Alert_State_Time := FieldByName('Alert_State_Time').AsSingle;
        Detectability_Type := FieldByName('Detectability_Type').AsInteger;
        Max_Sonobuoys_To_Monitor := FieldByName('Max_Sonobuoys_To_Monitor').AsInteger;
        Sonobuoy_Deploy_Max_Altitude := FieldByName('Sonobuoy_Deploy_Max_Altitude').AsInteger;
        Sonobuoy_Deploy_Min_Altitude := FieldByName('Sonobuoy_Deploy_Min_Altitude').AsInteger;
        Sonobuoy_Deploy_Max_Speed := FieldByName('Sonobuoy_Deploy_Max_Speed').AsInteger;
        Air_Drop_Torpedo_Max_Altitude := FieldByName('Air_Drop_Torpedo_Max_Altitude').AsInteger;
        Air_Drop_Torpedo_Min_Altitude := FieldByName('Air_Drop_Torpedo_Min_Altitude').AsInteger;
        Air_Drop_Torpedo_Max_Speed := FieldByName('Air_Drop_Torpedo_Max_Speed').AsInteger;
        TMA_Rate_Factor := FieldByName('TMA_Rate_Factor').AsSingle;
        HMS_Noise_Reduction_Factor := FieldByName('HMS_Noise_Reduction_Factor').AsSingle;
        TAS_Noise_Reduction_Factor := FieldByName('TAS_Noise_Reduction_Factor').AsSingle;
        Infrared_Decoy_Capable := FieldByName('Infrared_Decoy_Capable').AsBoolean;
        HF_Mid_Course_Update_Capable := FieldByName('HF_Mid_Course_Update_Capable').AsBoolean;
        UHF_Mid_Course_Update_Capable := FieldByName('UHF_Mid_Course_Update_Capable').AsBoolean;
        Platform_Capability_Index := FieldByName('Platform_Capability_Index').AsInteger;
        Logistics_Index := FieldByName('Logistics_Index').AsInteger;
//        SATCOM_Mid_Course_Update_Capable := FieldByName('SATCOM_Mid_Course_Update_Capable').AsBoolean;
        Font_id := FieldByName('font_id').AsInteger;
        VBS_Class_Name := FieldByName('vbs_class_name').AsString;
        Quantity_Group_Personal := FieldByName('Quantity_Group_Personal').AsInteger;
        GangwayPosition := FieldByName('GangwayPosition').AsInteger;
        FrontGangway := FieldByName('FrontGangway').AsBoolean;
        RearGangway := FieldByName('RearGangway').AsBoolean;
        PortGangway := FieldByName('PortGangway').AsBoolean;
        StarBoardGangway := FieldByName('StarBoardGangway').AsBoolean;
        DWT := FieldByName('DWT').AsSingle;
      end;
    end;
  end;
end;

function TdmINWO.InsertVehicleDef(var aRec: TRecVehicle_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Vehicle_Definition');
    SQL.Add('(Vehicle_Identifier, Platform_Domain, Platform_Category,');
    SQL.Add('Platform_Type, Motion_Characteristics, Length, Width, Height,');
    SQL.Add('Draft, Front_Radar_Cross, Side_Radar_Cross,');
    SQL.Add('Front_Acoustic_Cross, Side_Acoustic_Cross,Magnetic_Cross,');
    SQL.Add('Front_Visual_EO_Cross, Side_Visual_EO_Cross,');
    SQL.Add('Front_Infrared_Cross, Side_Infrared_Cross,');
    SQL.Add('LSpeed_Acoustic_Intens, Below_Cav_Acoustic_Intens,');
    SQL.Add('Above_Cav_Acoustic_Intens, HSpeed_Acoustic_Intens,');
    SQL.Add('Cavitation_Speed_Switch, Time_of_Weapon_Impact,');
    SQL.Add('Chaff_Seduction_Capable, Seduction_Mode_Prob,');
    SQL.Add('Min_Delay_Between_Chaff_Rounds, Max_Chaff_Salvo_Size,');
    SQL.Add('SARH_POH_Modifier, CG_POH_Modifier, TARH_POH_Modifier,');
    SQL.Add('IR_POH_Modifier, AR_POH_Modifier,');
    SQL.Add('Active_Acoustic_Tor_POH_Mod, Passive_Acoustic_Tor_POH_Mod,');
    SQL.Add('Active_Passive_Tor_POH_Mod, Wake_Home_POH_Modifier,');
    SQL.Add('Wire_Guide_POH_Modifier, Mag_Mine_POH_Modifier,');
    SQL.Add('Press_Mine_POH_Modifier, Impact_Mine_POH_Modifier,');
    SQL.Add('Acoustic_Mine_POH_Modifier, Sub_Comm_Antenna_Height,');
    SQL.Add('Rel_Comm_Antenna_Height, Max_Comm_Operating_Depth,');
    SQL.Add('HF_Link_Capable, UHF_Link_Capable, HF_Voice_Capable,');
    SQL.Add('VHF_Voice_Capable, UHF_Voice_Capable, SATCOM_Voice_Capable,');
    SQL.Add('UWT_Voice_Capable, HF_MHS_Capable, UHF_MHS_Capable,');
    SQL.Add('Satcom_MHS_Capable, Damage_Capacity, Plat_Basing_Capability,');
    SQL.Add('Chaff_Capability, Readying_Time, Sonobuoy_Capable,');
    SQL.Add('Nav_Light_Capable, Periscope_Depth,');
    SQL.Add('Periscope_Height_Above_Water, Periscope_Front_Radar_Xsection,');
    SQL.Add('Periscope_Side_Radar_Xsection, Periscope_Front_Vis_Xsection,');
    SQL.Add('Periscope_Side_Vis_Xsection, Periscope_Front_IR_Xsection,');
    SQL.Add('Periscope_Side_IR_Xsection, Engagement_Range,');
    SQL.Add('Auto_Air_Defense_Capable, Alert_State_Time,');
    SQL.Add('Detectability_Type, Max_Sonobuoys_To_Monitor,');
    SQL.Add('Sonobuoy_Deploy_Max_Altitude, Sonobuoy_Deploy_Min_Altitude,');
    SQL.Add('Sonobuoy_Deploy_Max_Speed, Air_Drop_Torpedo_Max_Altitude,');
    SQL.Add('Air_Drop_Torpedo_Min_Altitude, Air_Drop_Torpedo_Max_Speed,');
    SQL.Add('TMA_Rate_Factor, HMS_Noise_Reduction_Factor,');
    SQL.Add('TAS_Noise_Reduction_Factor, Infrared_Decoy_Capable,');
    SQL.Add('HF_Mid_Course_Update_Capable, UHF_Mid_Course_Update_Capable,');
    SQL.Add('Platform_Capability_Index,');
    SQL.Add('Logistics_Index,');
    SQL.Add('SATCOM_Mid_Course_Update_Capable,');
    SQL.Add('font_id, vbs_class_name, ');
    SQL.Add('Quantity_Group_Personal,');
    SQL.Add('GangwayPosition,');
    SQL.Add('FrontGangway,');
    SQL.Add('RearGangway,');
    SQL.Add('PortGangway,');
    SQL.Add('StarBoardGangway,');
    SQL.Add('DWT)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Vehicle_Identifier) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(IntToStr(Motion_Characteristics) + ', ');
      SQL.Add(FloatToStr(Length) + ', ');
      SQL.Add(FloatToStr(Width) + ', ');
      SQL.Add(FloatToStr(Height) + ', ');
      SQL.Add(FloatToStr(Draft) + ', ');
      SQL.Add(FloatToStr(Front_Radar_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Radar_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Magnetic_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Visual_EO_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Visual_EO_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Infrared_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Infrared_Cross) + ', ');
      SQL.Add(FloatToStr(LSpeed_Acoustic_Intens) + ', ');
      SQL.Add(FloatToStr(Below_Cav_Acoustic_Intens) + ', ');
      SQL.Add(FloatToStr(Above_Cav_Acoustic_Intens) + ', ');
      SQL.Add(FloatToStr(HSpeed_Acoustic_Intens) + ', ');
      SQL.Add(FloatToStr(Cavitation_Speed_Switch) + ', ');
      SQL.Add(IntToStr(Time_of_Weapon_Impact) + ', ');
      SQL.Add(BoolToStr(Chaff_Seduction_Capable) + ', ');
      SQL.Add(FloatToStr(Seduction_Mode_Prob) + ', ');
      SQL.Add(IntToStr(Min_Delay_Between_Chaff_Rounds) + ', ');
      SQL.Add(IntToStr(Max_Chaff_Salvo_Size) + ', ');
      SQL.Add(FloatToStr(SARH_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(CG_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(TARH_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(IR_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(AR_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Active_Acoustic_Tor_POH_Mod) + ', ');
      SQL.Add(FloatToStr(Passive_Acoustic_Tor_POH_Mod) + ', ');
      SQL.Add(FloatToStr(Active_Passive_Tor_POH_Mod) + ', ');
      SQL.Add(FloatToStr(Wake_Home_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Wire_Guide_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Mag_Mine_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Press_Mine_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Impact_Mine_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Acoustic_Mine_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Sub_Comm_Antenna_Height) + ', ');
      SQL.Add(FloatToStr(Rel_Comm_Antenna_Height) + ', ');
      SQL.Add(FloatToStr(Max_Comm_Operating_Depth) + ', ');
      SQL.Add(BoolToStr(HF_Link_Capable) + ', ');
      SQL.Add(BoolToStr(UHF_Link_Capable) + ', ');
      SQL.Add(BoolToStr(HF_Voice_Capable) + ', ');
      SQL.Add(BoolToStr(VHF_Voice_Capable) + ', ');
      SQL.Add(BoolToStr(UHF_Voice_Capable) + ', ');
      SQL.Add(BoolToStr(SATCOM_Voice_Capable) + ', ');
      SQL.Add(BoolToStr(UWT_Voice_Capable) + ', ');
      SQL.Add(BoolToStr(HF_MHS_Capable) + ', ');
      SQL.Add(BoolToStr(UHF_MHS_Capable) + ', ');
      SQL.Add(BoolToStr(SATCOM_MHS_Capable) + ', ');
      SQL.Add(IntToStr(Damage_Capacity) + ', ');
      SQL.Add(BoolToStr(Plat_Basing_Capability) + ', ');
      SQL.Add(BoolToStr(Chaff_Capability) + ', ');
      SQL.Add(IntToStr(Readying_Time) + ', ');
      SQL.Add(BoolToStr(Sonobuoy_Capable) + ', ');
      SQL.Add(BoolToStr(Nav_Light_Capable) + ', ');
      SQL.Add(FloatToStr(Periscope_Depth) + ', ');
      SQL.Add(FloatToStr(Periscope_Height_Above_Water) + ', ');
      SQL.Add(FloatToStr(Periscope_Front_Radar_Xsection) + ', ');
      SQL.Add(FloatToStr(Periscope_Side_Radar_Xsection) + ', ');
      SQL.Add(FloatToStr(Periscope_Front_Vis_Xsection) + ', ');
      SQL.Add(FloatToStr(Periscope_Side_Vis_Xsection) + ', ');
      SQL.Add(FloatToStr(Periscope_Front_IR_Xsection) + ', ');
      SQL.Add(FloatToStr(Periscope_Side_IR_Xsection) + ', ');
      SQL.Add(FloatToStr(Engagement_Range) + ', ');
      SQL.Add(BoolToStr(Auto_Air_Defense_Capable) + ', ');
      SQL.Add(FloatToStr(Alert_State_Time) + ', ');
      SQL.Add(IntToStr(Detectability_Type) + ', ');
      SQL.Add(IntToStr(Max_Sonobuoys_To_Monitor) + ', ');
      SQL.Add(IntToStr(Sonobuoy_Deploy_Max_Altitude) + ', ');
      SQL.Add(IntToStr(Sonobuoy_Deploy_Min_Altitude) + ', ');
      SQL.Add(IntToStr(Sonobuoy_Deploy_Max_Speed) + ', ');
      SQL.Add(IntToStr(Air_Drop_Torpedo_Max_Altitude) + ', ');
      SQL.Add(IntToStr(Air_Drop_Torpedo_Min_Altitude) + ', ');
      SQL.Add(IntToStr(Air_Drop_Torpedo_Max_Speed) + ', ');
      SQL.Add(FloatToStr(TMA_Rate_Factor) + ', ');
      SQL.Add(FloatToStr(HMS_Noise_Reduction_Factor) + ', ');
      SQL.Add(FloatToStr(TAS_Noise_Reduction_Factor) + ', ');
      SQL.Add(BoolToStr(Infrared_Decoy_Capable) + ', ');
      SQL.Add(BoolToStr(HF_Mid_Course_Update_Capable) + ', ');
      SQL.Add(BoolToStr(UHF_Mid_Course_Update_Capable) + ', ');
      SQL.Add(IntToStr(Platform_Capability_Index) + ', ');
      SQL.Add(IntToStr(Logistics_Index) + ', ');
      SQL.Add(BoolToStr(SATCOM_Mid_Course_Update_Capable) + ',');
      SQL.Add(IntToStr(Font_id) + ', ');
      SQL.Add(QuotedStr(VBS_Class_Name) + ', ');
      SQL.Add(IntToStr(Quantity_Group_Personal) + ', ');
      SQL.Add(IntToStr(GangwayPosition) + ', ');
      SQL.Add(BoolToStr(FrontGangway) + ', ');
      SQL.Add(BoolToStr(RearGangway) + ', ');
      SQL.Add(BoolToStr(PortGangway) + ', ');
      SQL.Add(BoolToStr(StarBoardGangway) + ', ');
      SQL.Add(FloatToStr(DWT) + ')');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Vehicle_Definition');
      SQL.Add('WHERE Vehicle_Identifier = ' + QuotedStr(Vehicle_Identifier));
      Open;

      Result := RecordCount > 0;

      if not IsEmpty then
      begin
        First;

        Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
      end;
    end;
  end;
end;

function TdmINWO.UpdateVehicleDef(var aRec: TRecVehicle_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Vehicle_Definition');

    with aRec do
    begin
      SQL.Add('SET Vehicle_Identifier = ' + QuotedStr(Vehicle_Identifier));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Motion_Characteristics = ' + IntToStr(Motion_Characteristics));
      SQL.Add(', Length = ' + FloatToStr(Length));
      SQL.Add(', Width = ' + FloatToStr(Width));
      SQL.Add(', Height = ' + FloatToStr(Height));
      SQL.Add(', Draft = ' + FloatToStr(Draft));
      SQL.Add(', Front_Radar_Cross = ' + FloatToStr(Front_Radar_Cross));
      SQL.Add(', Side_Radar_Cross = ' + FloatToStr(Side_Radar_Cross));
      SQL.Add(', Front_Acoustic_Cross = ' + FloatToStr(Front_Acoustic_Cross));
      SQL.Add(', Side_Acoustic_Cross = ' + FloatToStr(Side_Acoustic_Cross));
      SQL.Add(', Magnetic_Cross = ' + FloatToStr(Magnetic_Cross));
      SQL.Add(', Front_Visual_EO_Cross = ' + FloatToStr(Front_Visual_EO_Cross));
      SQL.Add(', Side_Visual_EO_Cross = ' + FloatToStr(Side_Visual_EO_Cross));
      SQL.Add(', Front_Infrared_Cross = ' + FloatToStr(Front_Infrared_Cross));
      SQL.Add(', Side_Infrared_Cross = ' + FloatToStr(Side_Infrared_Cross));
      SQL.Add(', LSpeed_Acoustic_Intens = ' + FloatToStr(LSpeed_Acoustic_Intens));
      SQL.Add(', Below_Cav_Acoustic_Intens = ' + FloatToStr(Below_Cav_Acoustic_Intens));
      SQL.Add(', Above_Cav_Acoustic_Intens = ' + FloatToStr(Above_Cav_Acoustic_Intens));
      SQL.Add(', HSpeed_Acoustic_Intens = ' + FloatToStr(HSpeed_Acoustic_Intens));
      SQL.Add(', Cavitation_Speed_Switch = ' + FloatToStr(Cavitation_Speed_Switch));
      SQL.Add(', Time_of_Weapon_Impact = ' + IntToStr(Time_of_Weapon_Impact));
      SQL.Add(', Chaff_Seduction_Capable = ' + BoolToStr(Chaff_Seduction_Capable));
      SQL.Add(', Seduction_Mode_Prob = ' + FloatToStr(Seduction_Mode_Prob));
      SQL.Add(', Min_Delay_Between_Chaff_Rounds = ' + IntToStr(Min_Delay_Between_Chaff_Rounds));
      SQL.Add(', Max_Chaff_Salvo_Size = ' + IntToStr(Max_Chaff_Salvo_Size));
      SQL.Add(', SARH_POH_Modifier = ' + FloatToStr(SARH_POH_Modifier));
      SQL.Add(', CG_POH_Modifier = ' + FloatToStr(CG_POH_Modifier));
      SQL.Add(', TARH_POH_Modifier = ' + FloatToStr(TARH_POH_Modifier));
      SQL.Add(', IR_POH_Modifier = ' + FloatToStr(IR_POH_Modifier));
      SQL.Add(', AR_POH_Modifier = ' + FloatToStr(AR_POH_Modifier));
      SQL.Add(', Active_Acoustic_Tor_POH_Mod = ' + FloatToStr(Active_Acoustic_Tor_POH_Mod));
      SQL.Add(', Passive_Acoustic_Tor_POH_Mod = ' + FloatToStr(Passive_Acoustic_Tor_POH_Mod));
      SQL.Add(', Active_Passive_Tor_POH_Mod = ' + FloatToStr(Active_Passive_Tor_POH_Mod));
      SQL.Add(', Wake_Home_POH_Modifier = ' + FloatToStr(Wake_Home_POH_Modifier));
      SQL.Add(', Wire_Guide_POH_Modifier = ' + FloatToStr(Wire_Guide_POH_Modifier));
      SQL.Add(', Mag_Mine_POH_Modifier = ' + FloatToStr(Mag_Mine_POH_Modifier));
      SQL.Add(', Press_Mine_POH_Modifier = ' + FloatToStr(Press_Mine_POH_Modifier));
      SQL.Add(', Impact_Mine_POH_Modifier = ' + FloatToStr(Impact_Mine_POH_Modifier));
      SQL.Add(', Acoustic_Mine_POH_Modifier = ' + FloatToStr(Acoustic_Mine_POH_Modifier));
      SQL.Add(', Sub_Comm_Antenna_Height = ' + FloatToStr(Sub_Comm_Antenna_Height));
      SQL.Add(', Rel_Comm_Antenna_Height = ' + FloatToStr(Rel_Comm_Antenna_Height));
      SQL.Add(', Max_Comm_Operating_Depth = ' + FloatToStr(Max_Comm_Operating_Depth));
      SQL.Add(', HF_Link_Capable = ' + BoolToStr(HF_Link_Capable));
      SQL.Add(', UHF_Link_Capable = ' + BoolToStr(UHF_Link_Capable));
      SQL.Add(', HF_Voice_Capable = ' + BoolToStr(HF_Voice_Capable));
      SQL.Add(', VHF_Voice_Capable = ' + BoolToStr(VHF_Voice_Capable));
      SQL.Add(', UHF_Voice_Capable = ' + BoolToStr(UHF_Voice_Capable));
      SQL.Add(', SATCOM_Voice_Capable = ' + BoolToStr(SATCOM_Voice_Capable));
      SQL.Add(', UWT_Voice_Capable = ' + BoolToStr(UWT_Voice_Capable));
      SQL.Add(', HF_MHS_Capable = ' + BoolToStr(HF_MHS_Capable));
      SQL.Add(', UHF_MHS_Capable = ' + BoolToStr(UHF_MHS_Capable));
      SQL.Add(', SATCOM_MHS_Capable = ' + BoolToStr(SATCOM_MHS_Capable));
      SQL.Add(', Damage_Capacity = ' + IntToStr(Damage_Capacity));
      SQL.Add(', Plat_Basing_Capability = ' + BoolToStr(Plat_Basing_Capability));
      SQL.Add(', Chaff_Capability = ' + BoolToStr(Chaff_Capability));
      SQL.Add(', Readying_Time = ' + IntToStr(Readying_Time));
      SQL.Add(', Sonobuoy_Capable = ' + BoolToStr(Sonobuoy_Capable));
      SQL.Add(', Nav_Light_Capable = ' + BoolToStr(Nav_Light_Capable));
      SQL.Add(', Periscope_Depth = ' + FloatToStr(Periscope_Depth));
      SQL.Add(', Periscope_Height_Above_Water = ' + FloatToStr(Periscope_Height_Above_Water));
      SQL.Add(', Periscope_Front_Radar_Xsection = ' + FloatToStr(Periscope_Front_Radar_Xsection));
      SQL.Add(', Periscope_Side_Radar_Xsection = ' + FloatToStr(Periscope_Side_Radar_Xsection));
      SQL.Add(', Periscope_Front_Vis_Xsection = ' + FloatToStr(Periscope_Front_Vis_Xsection));
      SQL.Add(', Periscope_Side_Vis_Xsection = ' +  FloatToStr(Periscope_Side_Vis_Xsection));
      SQL.Add(', Periscope_Front_IR_Xsection = ' + FloatToStr(Periscope_Front_IR_Xsection));
      SQL.Add(', Periscope_Side_IR_Xsection = ' + FloatToStr(Periscope_Side_IR_Xsection));
      SQL.Add(', Engagement_Range = ' + FloatToStr(Engagement_Range));
      SQL.Add(', Auto_Air_Defense_Capable = ' + BoolToStr(Auto_Air_Defense_Capable));
      SQL.Add(', Alert_State_Time = ' + FloatToStr(Alert_State_Time));
      SQL.Add(', Detectability_Type = ' + IntToStr(Detectability_Type));
      SQL.Add(', Max_Sonobuoys_To_Monitor = ' + IntToStr(Max_Sonobuoys_To_Monitor));
      SQL.Add(', Sonobuoy_Deploy_Max_Altitude = ' + IntToStr(Sonobuoy_Deploy_Max_Altitude));
      SQL.Add(', Sonobuoy_Deploy_Min_Altitude = ' + IntToStr(Sonobuoy_Deploy_Min_Altitude));
      SQL.Add(', Sonobuoy_Deploy_Max_Speed = ' + IntToStr(Sonobuoy_Deploy_Max_Speed));
      SQL.Add(', Air_Drop_Torpedo_Max_Altitude = ' + IntToStr(Air_Drop_Torpedo_Max_Altitude));
      SQL.Add(', Air_Drop_Torpedo_Min_Altitude = ' + IntToStr(Air_Drop_Torpedo_Min_Altitude));
      SQL.Add(', Air_Drop_Torpedo_Max_Speed = ' + IntToStr(Air_Drop_Torpedo_Max_Speed));
      SQL.Add(', TMA_Rate_Factor = ' + FloatToStr(TMA_Rate_Factor));
      SQL.Add(', HMS_Noise_Reduction_Factor = ' + FloatToStr(HMS_Noise_Reduction_Factor));
      SQL.Add(', TAS_Noise_Reduction_Factor = ' + FloatToStr(TAS_Noise_Reduction_Factor));
      SQL.Add(', Infrared_Decoy_Capable = ' + BoolToStr(Infrared_Decoy_Capable));
      SQL.Add(', HF_Mid_Course_Update_Capable = ' + BoolToStr(HF_Mid_Course_Update_Capable));
      SQL.Add(', UHF_Mid_Course_Update_Capable = ' + BoolToStr(UHF_Mid_Course_Update_Capable));
      SQL.Add(', Platform_Capability_Index = ' + IntToStr(Platform_Capability_Index));
      SQL.Add(', Logistics_Index = ' + IntToStr(Logistics_Index));
      SQL.Add(', SATCOM_Mid_Course_Update_Capable = ' + BoolToStr(SATCOM_Mid_Course_Update_Capable));
      SQL.Add(', font_id = ' + IntToStr(Font_id));
      SQL.Add(', vbs_class_name = ' + QuotedStr(VBS_Class_Name));
      SQL.Add(', Quantity_Group_Personal = ' + IntToStr(Quantity_Group_Personal));
      SQL.Add(', GangwayPosition = ' + IntToStr(GangwayPosition));
      SQL.Add(', FrontGangway = ' + BoolToStr(FrontGangway));
      SQL.Add(', RearGangway = ' + BoolToStr(RearGangway));
      SQL.Add(', PortGangway = ' + BoolToStr(PortGangway));
      SQL.Add(', StarBoardGangway = ' + BoolToStr(StarBoardGangway));
      SQL.Add(', DWT = ' + FloatToStr(DWT));
      SQL.Add('WHERE Vehicle_Index = ' + IntToStr(Vehicle_Index));
      ExecSQL;
    end;
    Result := True;
  end;
end;

function TdmINWO.DeleteVehicleDef(const aVehicleID: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM Vehicle_Definition');
    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Weapons Section '}

{$REGION ' Missile Definition '}

function TdmINWO.GetAllMissileDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TMissile_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Missile_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Missile_Index = b.Missile_Index ');
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      try
        First;

        while not Eof do
        begin
          rec := TMissile_On_Board.Create;

          {$REGION ' Memasukkan data kedalam objek '}
          with rec.FDef do
          begin
            Missile_Index := FieldByName('Missile_Index').AsInteger;
            Class_Identifier := FieldByName('Class_Identifier').AsString;
            Platform_Domain := FieldByName('Platform_Domain').AsInteger;
            Platform_Category := FieldByName('Platform_Category').AsInteger;
            Platform_Type := FieldByName('Platform_Type').AsInteger;
            Max_Range := FieldByName('Max_Range').AsSingle;
            Min_Range := FieldByName('Min_Range').AsSingle;
            Motion_Index := FieldByName('Motion_Index').AsInteger;
            Seeker_TurnOn_Range := FieldByName('Seeker_TurnOn_Range').AsSingle;
            Second_Seeker_Pattern_Capable := FieldByName('Second_Seeker_Pattern_Capable').AsInteger;
            Seeker_Bias_Capable := FieldByName('Seeker_Bias_Capable').AsInteger;
            Fixed_Seeker_Turn_On_Range := FieldByName('Fixed_Seeker_Turn_On_Range').AsInteger;
            Lethality := FieldByName('Lethality').AsInteger;
            Prob_of_Hit := FieldByName('Prob_of_Hit').AsSingle;
            Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
            Default_Altitude := FieldByName('Default_Altitude').AsSingle;
            Length := FieldByName('Length').AsSingle;
            Width := FieldByName('Width').AsSingle;
            Height := FieldByName('Height').AsSingle;
            Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
            Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
            Front_Visual_Cross := FieldByName('Front_Visual_Cross').AsSingle;
            Side_Visual_Cross := FieldByName('Side_Visual_Cross').AsSingle;
            Front_Infrared_Cross := FieldByName('Front_Infrared_Cross').AsSingle;
            Side_Infrared_Cross := FieldByName('Side_Infrared_Cross').AsSingle;
            Pursuit_Guide_Type := FieldByName('Pursuit_Guide_Type').AsInteger;
            Primary_Guide_Type := FieldByName('Primary_Guide_Type').AsInteger;
            Secondary_Guide_Type := FieldByName('Secondary_Guide_Type').AsInteger;
            Anti_Air_Capable := FieldByName('Anti_Air_Capable').AsInteger;
            Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
            Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
            Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
            Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable').AsInteger;
            Primary_Target_Domain := FieldByName('Primary_Target_Domain').AsInteger;
            SARH_POH_Modifier := FieldByName('SARH_POH_Modifier').AsSingle;
            CG_POH_Modifier := FieldByName('CG_POH_Modifier').AsSingle;
            TARH_POH_Modifier := FieldByName('TARH_POH_Modifier').AsSingle;
            IR_POH_Modifier := FieldByName('IR_POH_Modifier').AsSingle;
            AR_POH_Modifier := FieldByName('AR_POH_Modifier').AsSingle;
            Transmitted_Frequency := FieldByName('Transmitted_Frequency').AsFloat;
            Scan_Rate := FieldByName('Scan_Rate').AsSingle;
            Pulse_Rep_Freq := FieldByName('Pulse_Rep_Freq').AsSingle;
            Pulse_Width := FieldByName('Pulse_Width').AsSingle;
            Xmit_Power := FieldByName('Xmit_Power').AsSingle;
            TARH_Jamming_A_Probability := FieldByName('TARH_Jamming_A_Probability').AsSingle;
            TARH_Jamming_B_Probability := FieldByName('TARH_Jamming_B_Probability').AsSingle;
            TARH_Jamming_C_Probability := FieldByName('TARH_Jamming_C_Probability').AsSingle;
            Wpt_Capable := FieldByName('Wpt_Capable').AsInteger;
            Max_Num_Wpts := FieldByName('Max_Num_Wpts').AsInteger;
            Min_Final_Leg_Length := FieldByName('Min_Final_Leg_Length').AsSingle;
            Engagement_Range := FieldByName('Engagement_Range').AsSingle;
            Max_Firing_Depth := FieldByName('Max_Firing_Depth').AsSingle;
            Upper_Received_Freq := FieldByName('Upper_Received_Freq').AsFloat;
            Lower_Received_Freq := FieldByName('Lower_Received_Freq').AsFloat;
            Fly_Out_Required := FieldByName('Fly_Out_Required').AsInteger;
            Fly_Out_Range := FieldByName('Fly_Out_Range').AsSingle;
            Fly_Out_Altitude := FieldByName('Fly_Out_Altitude').AsSingle;
            Booster_Separation_Required := FieldByName('Booster_Separation_Required').AsInteger;
            Booster_Separation_Range := FieldByName('Booster_Separation_Range').AsSingle;
            Booster_Separation_Box_Width := FieldByName('Booster_Separation_Box_Width').AsSingle;
            Booster_Separation_Box_Length := FieldByName('Booster_Separation_Box_Length').AsSingle;
            Term_Guide_Azimuth := FieldByName('Term_Guide_Azimuth').AsSingle;
            Term_Guide_Elevation := FieldByName('Term_Guide_Elevation').AsSingle;
            Term_Guide_Range := FieldByName('Term_Guide_Range').AsSingle;
            Terminal_Guidance_Capability := FieldByName('Terminal_Guidance_Capability').AsInteger;
            Terminal_Altitude_Required := FieldByName('Terminal_Altitude_Required').AsInteger;
            Terminal_Acquisition_Altitude := FieldByName('Terminal_Acquisition_Altitude').AsSingle;
            Terminal_Sinuation_Start_Range := FieldByName('Terminal_Sinuation_Start_Range').AsSingle;
            Terminal_Sinuation_Period := FieldByName('Terminal_Sinuation_Period').AsSingle;
            Terminal_Sinuation_Amplitude := FieldByName('Terminal_Sinuation_Amplitude').AsSingle;
            Terminal_Pop_Up_Range := FieldByName('Terminal_Pop_Up_Range').AsSingle;
            Terminal_Pop_Up_Altitude := FieldByName('Terminal_Pop_Up_Altitude').AsSingle;
            Mid_Course_Update_Mode := FieldByName('Mid_Course_Update_Mode').AsInteger;
            Home_On_Jam_Type_A_Capable := FieldByName('Home_On_Jam_Type_A_Capable').AsInteger;
            Home_On_Jam_Type_B_Capable := FieldByName('Home_On_Jam_Type_B_Capable').AsInteger;
            Home_On_Jam_Type_C_Capable := FieldByName('Home_On_Jam_Type_C_Capable').AsInteger;
            Launch_Method := FieldByName('Launch_Method').AsInteger;
            Data_Entry_Method := FieldByName('Data_Entry_Method').AsInteger;
            Launch_Speed := FieldByName('Launch_Speed').AsInteger;
            Max_Target_Altitude_Delta := FieldByName('Max_Target_Altitude_Delta').AsInteger;
            Term_Guide_Azimuth_Narrow := FieldByName('Term_Guide_Azimuth_Narrow').AsSingle;
            Term_Guide_Elevation_Narrow := FieldByName('Term_Guide_Elevation_Narrow').AsSingle;
            Term_Guide_Range_Narrow := FieldByName('Term_Guide_Range_Narrow').AsSingle;
            Spot_Number := FieldByName('Spot_Number').AsInteger;
            ECCM_Type := FieldByName('ECCM_Type').AsInteger;
            ECM_Detonation := FieldByName('ECM_Detonation').AsInteger;
            ECM_Detection := FieldByName('ECM_Detection').AsInteger;
            Detectability_Type := FieldByName('Detectability_Type').AsInteger;
            IRCM_Detonation := FieldByName('IRCM_Detonation').AsInteger;
            IRCM_Detection := FieldByName('IRCM_Detection').AsInteger;
            Sea_State_Modelling_Capable := FieldByName('Sea_State_Modelling_Capable').AsInteger;
          end;

          with rec.FNote do
          begin
            Note_Index := FieldByName('Note_Index').AsInteger;
            Note_Type := FieldByName('Note_Type').AsInteger;
            Notes := FieldByName('Notes').AsString;
          end;

          {$ENDREGION}

          aList.Add(rec);
          Next;
        end;

      finally
      end;
    end;
  end;
end;

function TdmINWO.GetFilterMissileDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TMissile_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Missile_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Missile_Index = b.Missile_Index ');
    SQL.Add('WHERE Class_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      try
        First;

        while not Eof do
        begin
          rec := TMissile_On_Board.Create;

          {$REGION ' Memasukkan data kedalam objek '}
          with rec.FDef do
          begin
            Missile_Index := FieldByName('Missile_Index').AsInteger;
            Class_Identifier := FieldByName('Class_Identifier').AsString;
            Platform_Domain := FieldByName('Platform_Domain').AsInteger;
            Platform_Category := FieldByName('Platform_Category').AsInteger;
            Platform_Type := FieldByName('Platform_Type').AsInteger;
            Max_Range := FieldByName('Max_Range').AsSingle;
            Min_Range := FieldByName('Min_Range').AsSingle;
            Motion_Index := FieldByName('Motion_Index').AsInteger;
            Seeker_TurnOn_Range := FieldByName('Seeker_TurnOn_Range').AsSingle;
            Second_Seeker_Pattern_Capable := FieldByName('Second_Seeker_Pattern_Capable').AsInteger;
            Seeker_Bias_Capable := FieldByName('Seeker_Bias_Capable').AsInteger;
            Fixed_Seeker_Turn_On_Range := FieldByName('Fixed_Seeker_Turn_On_Range').AsInteger;
            Lethality := FieldByName('Lethality').AsInteger;
            Prob_of_Hit := FieldByName('Prob_of_Hit').AsSingle;
            Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
            Default_Altitude := FieldByName('Default_Altitude').AsSingle;
            Length := FieldByName('Length').AsSingle;
            Width := FieldByName('Width').AsSingle;
            Height := FieldByName('Height').AsSingle;
            Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
            Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
            Front_Visual_Cross := FieldByName('Front_Visual_Cross').AsSingle;
            Side_Visual_Cross := FieldByName('Side_Visual_Cross').AsSingle;
            Front_Infrared_Cross := FieldByName('Front_Infrared_Cross').AsSingle;
            Side_Infrared_Cross := FieldByName('Side_Infrared_Cross').AsSingle;
            Pursuit_Guide_Type := FieldByName('Pursuit_Guide_Type').AsInteger;
            Primary_Guide_Type := FieldByName('Primary_Guide_Type').AsInteger;
            Secondary_Guide_Type := FieldByName('Secondary_Guide_Type').AsInteger;
            Anti_Air_Capable := FieldByName('Anti_Air_Capable').AsInteger;
            Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
            Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
            Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
            Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable').AsInteger;
            Primary_Target_Domain := FieldByName('Primary_Target_Domain').AsInteger;
            SARH_POH_Modifier := FieldByName('SARH_POH_Modifier').AsSingle;
            CG_POH_Modifier := FieldByName('CG_POH_Modifier').AsSingle;
            TARH_POH_Modifier := FieldByName('TARH_POH_Modifier').AsSingle;
            IR_POH_Modifier := FieldByName('IR_POH_Modifier').AsSingle;
            AR_POH_Modifier := FieldByName('AR_POH_Modifier').AsSingle;
            Transmitted_Frequency := FieldByName('Transmitted_Frequency').AsFloat;
            Scan_Rate := FieldByName('Scan_Rate').AsSingle;
            Pulse_Rep_Freq := FieldByName('Pulse_Rep_Freq').AsSingle;
            Pulse_Width := FieldByName('Pulse_Width').AsSingle;
            Xmit_Power := FieldByName('Xmit_Power').AsSingle;
            TARH_Jamming_A_Probability := FieldByName('TARH_Jamming_A_Probability').AsSingle;
            TARH_Jamming_B_Probability := FieldByName('TARH_Jamming_B_Probability').AsSingle;
            TARH_Jamming_C_Probability := FieldByName('TARH_Jamming_C_Probability').AsSingle;
            Wpt_Capable := FieldByName('Wpt_Capable').AsInteger;
            Max_Num_Wpts := FieldByName('Max_Num_Wpts').AsInteger;
            Min_Final_Leg_Length := FieldByName('Min_Final_Leg_Length').AsSingle;
            Engagement_Range := FieldByName('Engagement_Range').AsSingle;
            Max_Firing_Depth := FieldByName('Max_Firing_Depth').AsSingle;
            Upper_Received_Freq := FieldByName('Upper_Received_Freq').AsFloat;
            Lower_Received_Freq := FieldByName('Lower_Received_Freq').AsFloat;
            Fly_Out_Required := FieldByName('Fly_Out_Required').AsInteger;
            Fly_Out_Range := FieldByName('Fly_Out_Range').AsSingle;
            Fly_Out_Altitude := FieldByName('Fly_Out_Altitude').AsSingle;
            Booster_Separation_Required := FieldByName('Booster_Separation_Required').AsInteger;
            Booster_Separation_Range := FieldByName('Booster_Separation_Range').AsSingle;
            Booster_Separation_Box_Width := FieldByName('Booster_Separation_Box_Width').AsSingle;
            Booster_Separation_Box_Length := FieldByName('Booster_Separation_Box_Length').AsSingle;
            Term_Guide_Azimuth := FieldByName('Term_Guide_Azimuth').AsSingle;
            Term_Guide_Elevation := FieldByName('Term_Guide_Elevation').AsSingle;
            Term_Guide_Range := FieldByName('Term_Guide_Range').AsSingle;
            Terminal_Guidance_Capability := FieldByName('Terminal_Guidance_Capability').AsInteger;
            Terminal_Altitude_Required := FieldByName('Terminal_Altitude_Required').AsInteger;
            Terminal_Acquisition_Altitude := FieldByName('Terminal_Acquisition_Altitude').AsSingle;
            Terminal_Sinuation_Start_Range := FieldByName('Terminal_Sinuation_Start_Range').AsSingle;
            Terminal_Sinuation_Period := FieldByName('Terminal_Sinuation_Period').AsSingle;
            Terminal_Sinuation_Amplitude := FieldByName('Terminal_Sinuation_Amplitude').AsSingle;
            Terminal_Pop_Up_Range := FieldByName('Terminal_Pop_Up_Range').AsSingle;
            Terminal_Pop_Up_Altitude := FieldByName('Terminal_Pop_Up_Altitude').AsSingle;
            Mid_Course_Update_Mode := FieldByName('Mid_Course_Update_Mode').AsInteger;
            Home_On_Jam_Type_A_Capable := FieldByName('Home_On_Jam_Type_A_Capable').AsInteger;
            Home_On_Jam_Type_B_Capable := FieldByName('Home_On_Jam_Type_B_Capable')
              .AsInteger;
            Home_On_Jam_Type_C_Capable := FieldByName
              ('Home_On_Jam_Type_C_Capable')
              .AsInteger;
            Launch_Method := FieldByName('Launch_Method').AsInteger;
            Data_Entry_Method := FieldByName('Data_Entry_Method').AsInteger;
            Launch_Speed := FieldByName('Launch_Speed').AsInteger;
            Max_Target_Altitude_Delta := FieldByName('Max_Target_Altitude_Delta')
              .AsInteger;
            Term_Guide_Azimuth_Narrow := FieldByName('Term_Guide_Azimuth_Narrow')
              .AsSingle;
            Term_Guide_Elevation_Narrow := FieldByName
              ('Term_Guide_Elevation_Narrow').AsSingle;
            Term_Guide_Range_Narrow := FieldByName('Term_Guide_Range_Narrow')
              .AsSingle;
            Spot_Number := FieldByName('Spot_Number').AsInteger;
            ECCM_Type := FieldByName('ECCM_Type').AsInteger;
            ECM_Detonation := FieldByName('ECM_Detonation').AsInteger;
            ECM_Detection := FieldByName('ECM_Detection').AsInteger;
            Detectability_Type := FieldByName('Detectability_Type').AsInteger;
            IRCM_Detonation := FieldByName('IRCM_Detonation').AsInteger;
            IRCM_Detection := FieldByName('IRCM_Detection').AsInteger;
            Sea_State_Modelling_Capable := FieldByName
              ('Sea_State_Modelling_Capable').AsInteger;
          end;

          with rec.FNote do
          begin
            Note_Index := FieldByName('Note_Index').AsInteger;
            Note_Type := FieldByName('Note_Type').AsInteger;
            Notes := FieldByName('Notes').AsString;
          end;

          {$ENDREGION}

          aList.Add(rec);
          Next;
        end;

      finally
      end;
    end;
  end;
end;

function TdmINWO.GetMissileDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Missile_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Missile_Index = b.Missile_Index ');
    SQL.Add('WHERE Class_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertMissileDef(var aRec: TRecMissile_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Missile_Definition');
    SQL.Add('(Class_Identifier, Platform_Domain, Platform_Category,');
    SQL.Add('Platform_Type, Max_Range, Min_Range, Motion_Index,');
    SQL.Add('Seeker_TurnOn_Range, Second_Seeker_Pattern_Capable,');
    SQL.Add('Seeker_Bias_Capable, Fixed_Seeker_Turn_On_Range, Lethality,');
    SQL.Add('Prob_of_Hit, Damage_Capacity, Default_Altitude, Length, Width,');
    SQL.Add('Height, Front_Radar_Cross, Side_Radar_Cross, Front_Visual_Cross,');
    SQL.Add('Side_Visual_Cross, Front_Infrared_Cross, Side_Infrared_Cross,');
    SQL.Add('Pursuit_Guide_Type, Primary_Guide_Type, Secondary_Guide_Type,');
    SQL.Add('Anti_Air_Capable, Anti_Sur_Capable, Anti_SubSur_Capable,');
    SQL.Add('Anti_Land_Capable, Primary_Target_Domain, SARH_POH_Modifier,');
    SQL.Add('CG_POH_Modifier, TARH_POH_Modifier, IR_POH_Modifier,');
    SQL.Add('AR_POH_Modifier, Transmitted_Frequency, Scan_Rate,');
    SQL.Add('Pulse_Rep_Freq, Pulse_Width, Xmit_Power,');
    SQL.Add('TARH_Jamming_A_Probability, TARH_Jamming_B_Probability,');
    SQL.Add('TARH_Jamming_C_Probability, Wpt_Capable, Max_Num_Wpts,');
    SQL.Add('Min_Final_Leg_Length, Engagement_Range, Max_Firing_Depth,');
    SQL.Add('Upper_Received_Freq, Lower_Received_Freq, Fly_Out_Required,');
    SQL.Add('Fly_Out_Range, Fly_Out_Altitude, Booster_Separation_Required,');
    SQL.Add('Booster_Separation_Range, Booster_Separation_Box_Width,');
    SQL.Add('Booster_Separation_Box_Length, Term_Guide_Azimuth,');
    SQL.Add('Term_Guide_Elevation, Term_Guide_Range,');
    SQL.Add('Terminal_Guidance_Capability, Terminal_Altitude_Required,');
    SQL.Add('Terminal_Acquisition_Altitude, Terminal_Sinuation_Start_Range,');
    SQL.Add('Terminal_Sinuation_Period, Terminal_Sinuation_Amplitude,');
    SQL.Add('Terminal_Pop_Up_Range, Terminal_Pop_Up_Altitude,');
    SQL.Add('Mid_Course_Update_Mode, Home_On_Jam_Type_A_Capable,');
    SQL.Add('Home_On_Jam_Type_B_Capable, Home_On_Jam_Type_C_Capable,');
    SQL.Add('Launch_Method, Data_Entry_Method, Launch_Speed,');
    SQL.Add('Max_Target_Altitude_Delta, Term_Guide_Azimuth_Narrow,');
    SQL.Add('Term_Guide_Elevation_Narrow, Term_Guide_Range_Narrow,');
    SQL.Add('Spot_Number, ECCM_Type, ECM_Detonation, ECM_Detection,');
    SQL.Add('Detectability_Type, IRCM_Detonation, IRCM_Detection,');
    SQL.Add('Sea_State_Modelling_Capable, Anti_Amphibious_Capable)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Class_Identifier) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(FloatToStr(Max_Range) + ', ');
      SQL.Add(FloatToStr(Min_Range) + ', ');
      SQL.Add(IntToStr(Motion_Index) + ', ');
      SQL.Add(FloatToStr(Seeker_TurnOn_Range) + ', ');
      SQL.Add(IntToStr(Second_Seeker_Pattern_Capable) + ', ');
      SQL.Add(IntToStr(Seeker_Bias_Capable) + ', ');
      SQL.Add(IntToStr(Fixed_Seeker_Turn_On_Range) + ', ');
      SQL.Add(IntToStr(Lethality) + ', ');
      SQL.Add(FloatToStr(Prob_of_Hit) + ', ');
      SQL.Add(IntToStr(Damage_Capacity) + ', ');
      SQL.Add(FloatToStr(Default_Altitude) + ', ');
      SQL.Add(FloatToStr(Length) + ', ');
      SQL.Add(FloatToStr(Width) + ', ');
      SQL.Add(FloatToStr(Height) + ', ');
      SQL.Add(FloatToStr(Front_Radar_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Radar_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Visual_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Visual_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Infrared_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Infrared_Cross) + ', ');
      SQL.Add(IntToStr(Pursuit_Guide_Type) + ', ');
      SQL.Add(IntToStr(Primary_Guide_Type) + ', ');
      SQL.Add(IntToStr(Secondary_Guide_Type) + ', ');
      SQL.Add(IntToStr(Anti_Air_Capable) + ', ');
      SQL.Add(IntToStr(Anti_Sur_Capable) + ', ');
      SQL.Add(IntToStr(Anti_SubSur_Capable) + ', ');
      SQL.Add(IntToStr(Anti_Land_Capable) + ', ');
      SQL.Add(IntToStr(Primary_Target_Domain) + ', ');
      SQL.Add(FloatToStr(SARH_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(CG_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(TARH_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(IR_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(AR_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Transmitted_Frequency) + ', ');
      SQL.Add(FloatToStr(Scan_Rate) + ', ');
      SQL.Add(FloatToStr(Pulse_Rep_Freq) + ', ');
      SQL.Add(FloatToStr(Pulse_Width) + ', ');
      SQL.Add(FloatToStr(Xmit_Power) + ', ');
      SQL.Add(FloatToStr(TARH_Jamming_A_Probability) + ', ');
      SQL.Add(FloatToStr(TARH_Jamming_B_Probability) + ', ');
      SQL.Add(FloatToStr(TARH_Jamming_C_Probability) + ', ');
      SQL.Add(IntToStr(Wpt_Capable) + ', ');
      SQL.Add(IntToStr(Max_Num_Wpts) + ', ');
      SQL.Add(FloatToStr(Min_Final_Leg_Length) + ', ');
      SQL.Add(FloatToStr(Engagement_Range) + ', ');
      SQL.Add(FloatToStr(Max_Firing_Depth) + ', ');
      SQL.Add(FloatToStr(Upper_Received_Freq) + ', ');
      SQL.Add(FloatToStr(Lower_Received_Freq) + ', ');
      SQL.Add(IntToStr(Fly_Out_Required) + ', ');
      SQL.Add(FloatToStr(Fly_Out_Range) + ', ');
      SQL.Add(FloatToStr(Fly_Out_Altitude) + ', ');
      SQL.Add(IntToStr(Booster_Separation_Required) + ', ');
      SQL.Add(FloatToStr(Booster_Separation_Range) + ', ');
      SQL.Add(FloatToStr(Booster_Separation_Box_Width) + ', ');
      SQL.Add(FloatToStr(Booster_Separation_Box_Length) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Azimuth) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Elevation) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Range) + ', ');
      SQL.Add(IntToStr(Terminal_Guidance_Capability) + ', ');
      SQL.Add(IntToStr(Terminal_Altitude_Required) + ', ');
      SQL.Add(FloatToStr(Terminal_Acquisition_Altitude) + ', ');
      SQL.Add(FloatToStr(Terminal_Sinuation_Start_Range) + ', ');
      SQL.Add(FloatToStr(Terminal_Sinuation_Period) + ', ');
      SQL.Add(FloatToStr(Terminal_Sinuation_Amplitude) + ', ');
      SQL.Add(FloatToStr(Terminal_Pop_Up_Range) + ', ');
      SQL.Add(FloatToStr(Terminal_Pop_Up_Altitude) + ', ');
      SQL.Add(IntToStr(Mid_Course_Update_Mode) + ', ');
      SQL.Add(IntToStr(Home_On_Jam_Type_A_Capable) + ', ');
      SQL.Add(IntToStr(Home_On_Jam_Type_B_Capable) + ', ');
      SQL.Add(IntToStr(Home_On_Jam_Type_C_Capable) + ', ');
      SQL.Add(IntToStr(Launch_Method) + ', ');
      SQL.Add(IntToStr(Data_Entry_Method) + ', ');
      SQL.Add(IntToStr(Launch_Speed) + ', ');
      SQL.Add(IntToStr(Max_Target_Altitude_Delta) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Azimuth_Narrow) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Elevation_Narrow) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Range_Narrow) + ', ');
      SQL.Add(IntToStr(Spot_Number) + ', ');
      SQL.Add(IntToStr(ECCM_Type) + ', ');
      SQL.Add(IntToStr(ECM_Detonation) + ', ');
      SQL.Add(IntToStr(ECM_Detection) + ', ');
      SQL.Add(IntToStr(Detectability_Type) + ', ');
      SQL.Add(IntToStr(IRCM_Detonation) + ', ');
      SQL.Add(IntToStr(IRCM_Detection) + ', ');
      SQL.Add(IntToStr(Sea_State_Modelling_Capable) + ', ');
      SQL.Add(IntToStr(Anti_Amphibious_Capable) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Missile_Definition');
      SQL.Add('WHERE Class_Identifier = ' + QuotedStr(aRec.Class_Identifier));
      Open;

      Missile_Index := FieldByName('Missile_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateMissileDef(var aRec: TRecMissile_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Missile_Definition');

    with aRec do
    begin
      SQL.Add('SET Class_Identifier = ' + QuotedStr(Class_Identifier));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Max_Range = ' + FloatToStr(Max_Range));
      SQL.Add(', Min_Range = ' + FloatToStr(Min_Range));
      SQL.Add(', Motion_Index = ' + IntToStr(Motion_Index));
      SQL.Add(', Seeker_TurnOn_Range = ' + FloatToStr(Seeker_TurnOn_Range));
      SQL.Add(', Second_Seeker_Pattern_Capable = ' +
        IntToStr(Second_Seeker_Pattern_Capable));
      SQL.Add(', Seeker_Bias_Capable = ' + IntToStr(Seeker_Bias_Capable));
      SQL.Add(', Fixed_Seeker_Turn_On_Range = ' +
        IntToStr(Fixed_Seeker_Turn_On_Range));
      SQL.Add(', Lethality = ' + IntToStr(Lethality));
      SQL.Add(', Prob_of_Hit = ' + FloatToStr(Prob_of_Hit));
      SQL.Add(', Damage_Capacity = ' + IntToStr(Damage_Capacity));
      SQL.Add(', Default_Altitude = ' + FloatToStr(Default_Altitude));
      SQL.Add(', Length = ' + FloatToStr(Length));
      SQL.Add(', Width = ' + FloatToStr(Width));
      SQL.Add(', Height = ' + FloatToStr(Height));
      SQL.Add(', Front_Radar_Cross = ' + FloatToStr(Front_Radar_Cross));
      SQL.Add(', Side_Radar_Cross = ' + FloatToStr(Side_Radar_Cross));
      SQL.Add(', Front_Visual_Cross = ' + FloatToStr(Front_Visual_Cross));
      SQL.Add(', Side_Visual_Cross = ' + FloatToStr(Side_Visual_Cross));
      SQL.Add(', Front_Infrared_Cross = ' + FloatToStr(Front_Infrared_Cross));
      SQL.Add(', Side_Infrared_Cross = ' + FloatToStr(Side_Infrared_Cross));
      SQL.Add(', Pursuit_Guide_Type = ' + IntToStr(Pursuit_Guide_Type));
      SQL.Add(', Primary_Guide_Type = ' + IntToStr(Primary_Guide_Type));
      SQL.Add(', Secondary_Guide_Type = ' + IntToStr(Secondary_Guide_Type));
      SQL.Add(', Anti_Air_Capable = ' + IntToStr(Anti_Air_Capable));
      SQL.Add(', Anti_Sur_Capable = ' + IntToStr(Anti_Sur_Capable));
      SQL.Add(', Anti_SubSur_Capable = ' + IntToStr(Anti_SubSur_Capable));
      SQL.Add(', Anti_Land_Capable = ' + IntToStr(Anti_Land_Capable));
      SQL.Add(', Primary_Target_Domain = ' + IntToStr(Primary_Target_Domain));
      SQL.Add(', SARH_POH_Modifier = ' + FloatToStr(SARH_POH_Modifier));
      SQL.Add(', CG_POH_Modifier = ' + FloatToStr(CG_POH_Modifier));
      SQL.Add(', TARH_POH_Modifier = ' + FloatToStr(TARH_POH_Modifier));
      SQL.Add(', IR_POH_Modifier = ' + FloatToStr(IR_POH_Modifier));
      SQL.Add(', AR_POH_Modifier = ' + FloatToStr(AR_POH_Modifier));
      SQL.Add(', Transmitted_Frequency = ' + FloatToStr(Transmitted_Frequency));
      SQL.Add(', Scan_Rate = ' + FloatToStr(Scan_Rate));
      SQL.Add(', Pulse_Rep_Freq = ' + FloatToStr(Pulse_Rep_Freq));
      SQL.Add(', Pulse_Width = ' + FloatToStr(Pulse_Width));
      SQL.Add(', Xmit_Power = ' + FloatToStr(Xmit_Power));
      SQL.Add(', TARH_Jamming_A_Probability = ' +
        FloatToStr(TARH_Jamming_A_Probability));
      SQL.Add(', TARH_Jamming_B_Probability = ' +
        FloatToStr(TARH_Jamming_B_Probability));
      SQL.Add(', TARH_Jamming_C_Probability = ' +
        FloatToStr(TARH_Jamming_C_Probability));
      SQL.Add(', Wpt_Capable = ' + IntToStr(Wpt_Capable));
      SQL.Add(', Max_Num_Wpts = ' + IntToStr(Max_Num_Wpts));
      SQL.Add(', Min_Final_Leg_Length = ' + FloatToStr(Min_Final_Leg_Length));
      SQL.Add(', Engagement_Range = ' + FloatToStr(Engagement_Range));
      SQL.Add(', Max_Firing_Depth = ' + FloatToStr(Max_Firing_Depth));
      SQL.Add(', Upper_Received_Freq = ' + FloatToStr(Upper_Received_Freq));
      SQL.Add(', Lower_Received_Freq = ' + FloatToStr(Lower_Received_Freq));
      SQL.Add(', Fly_Out_Required = ' + IntToStr(Fly_Out_Required));
      SQL.Add(', Fly_Out_Range = ' + FloatToStr(Fly_Out_Range));
      SQL.Add(', Fly_Out_Altitude = ' + FloatToStr(Fly_Out_Altitude));
      SQL.Add(', Booster_Separation_Required = ' +
        IntToStr(Booster_Separation_Required));
      SQL.Add(', Booster_Separation_Range = ' +
        FloatToStr(Booster_Separation_Range));
      SQL.Add(', Booster_Separation_Box_Width = ' +
        FloatToStr(Booster_Separation_Box_Width));
      SQL.Add(', Booster_Separation_Box_Length = ' +
        FloatToStr(Booster_Separation_Box_Length));
      SQL.Add(', Term_Guide_Azimuth = ' + FloatToStr(Term_Guide_Azimuth));
      SQL.Add(', Term_Guide_Elevation = ' + FloatToStr(Term_Guide_Elevation));
      SQL.Add(', Term_Guide_Range = ' + FloatToStr(Term_Guide_Range));
      SQL.Add(', Terminal_Guidance_Capability = ' +
        IntToStr(Terminal_Guidance_Capability));
      SQL.Add(', Terminal_Altitude_Required = ' +
        IntToStr(Terminal_Altitude_Required));
      SQL.Add(', Terminal_Acquisition_Altitude = ' +
        FloatToStr(Terminal_Acquisition_Altitude));
      SQL.Add(', Terminal_Sinuation_Start_Range = ' +
        FloatToStr(Terminal_Sinuation_Start_Range));
      SQL.Add(', Terminal_Sinuation_Period = ' +
        FloatToStr(Terminal_Sinuation_Period));
      SQL.Add(', Terminal_Sinuation_Amplitude = ' +
        FloatToStr(Terminal_Sinuation_Amplitude));
      SQL.Add(', Terminal_Pop_Up_Range = ' + FloatToStr(Terminal_Pop_Up_Range));
      SQL.Add(', Terminal_Pop_Up_Altitude = ' +
        FloatToStr(Terminal_Pop_Up_Altitude));
      SQL.Add(', Mid_Course_Update_Mode = ' + IntToStr(Mid_Course_Update_Mode));
      SQL.Add(', Home_On_Jam_Type_A_Capable = ' +
        IntToStr(Home_On_Jam_Type_A_Capable));
      SQL.Add(', Home_On_Jam_Type_B_Capable = ' +
        IntToStr(Home_On_Jam_Type_B_Capable));
      SQL.Add(', Home_On_Jam_Type_C_Capable = ' +
        IntToStr(Home_On_Jam_Type_C_Capable));
      SQL.Add(', Launch_Method = ' + IntToStr(Launch_Method));
      SQL.Add(', Data_Entry_Method = ' + IntToStr(Data_Entry_Method));
      SQL.Add(', Launch_Speed = ' + IntToStr(Launch_Speed));
      SQL.Add(', Max_Target_Altitude_Delta = ' +
        IntToStr(Max_Target_Altitude_Delta));
      SQL.Add(', Term_Guide_Azimuth_Narrow = ' +
        FloatToStr(Term_Guide_Azimuth_Narrow));
      SQL.Add(', Term_Guide_Elevation_Narrow = ' +
        FloatToStr(Term_Guide_Elevation_Narrow));
      SQL.Add(', Term_Guide_Range_Narrow = ' +
        FloatToStr(Term_Guide_Range_Narrow));
      SQL.Add(', Spot_Number = ' + IntToStr(Spot_Number));
      SQL.Add(', ECCM_Type = ' + IntToStr(ECCM_Type));
      SQL.Add(', ECM_Detonation = ' + IntToStr(ECM_Detonation));
      SQL.Add(', ECM_Detection = ' + IntToStr(ECM_Detection));
      SQL.Add(', Detectability_Type = ' + IntToStr(Detectability_Type));
      SQL.Add(', IRCM_Detonation = ' + IntToStr(IRCM_Detonation));
      SQL.Add(', IRCM_Detection = ' + IntToStr(IRCM_Detection));
      SQL.Add(', Sea_State_Modelling_Capable = ' +
        IntToStr(Sea_State_Modelling_Capable));
      SQL.Add(', Anti_Amphibious_Capable = ' +
        IntToStr(Anti_Amphibious_Capable));
      SQL.Add('WHERE Missile_Index = ' + IntToStr(Missile_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteMissileDef(const aMissileIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE Missile_Definition');
    SQL.Add('WHERE Missile_Index = ' + IntToStr(aMissileIndex));
    ExecSQL;

    Result := True;

  end;
end;

{$ENDREGION}

{$REGION ' Torpedo Definition '}

function TdmINWO.GetAllTorpedoDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TTorpedo_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Torpedo_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Torpedo_Index = b.Torpedo_Index ');
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TTorpedo_On_Board.Create;

        with rec.FDef do
        begin
          Torpedo_Index := FieldByName('Torpedo_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Max_Range := FieldByName('Max_Range').AsSingle;
          Min_Range := FieldByName('Min_Range').AsSingle;
          Motion_Index := FieldByName('Motion_Index').AsInteger;
          Seeker_TurnOn_Range := FieldByName('Seeker_TurnOn_Range').AsSingle;
          Lethality := FieldByName('Lethality').AsInteger;
          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
          Default_Depth := FieldByName('Default_Depth').AsSingle;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          LSpeed_Acoustic_Intens := FieldByName('LSpeed_Acoustic_Intens')
            .AsSingle;
          Below_Cav_Acoustic_Intens := FieldByName('Below_Cav_Acoustic_Intens')
            .AsSingle;
          Above_Cav_Acoustic_Intens := FieldByName('Above_Cav_Acoustic_Intens')
            .AsSingle;
          HSpeed_Acoustic_Intens := FieldByName('HSpeed_Acoustic_Intens')
            .AsSingle;
          Cavitation_Switch_Point := FieldByName('Cavitation_Switch_Point')
            .AsSingle;
          Term_Guide_Azimuth := FieldByName('Term_Guide_Azimuth').AsSingle;
          Term_Guide_Elevation := FieldByName('Term_Guide_Elevation').AsSingle;
          Term_Guide_Range := FieldByName('Term_Guide_Range').AsSingle;
          Pursuit_Guidance_Type := FieldByName('Pursuit_Guidance_Type')
            .AsInteger;
          Air_Drop_Capable := FieldByName('Air_Drop_Capable').AsInteger;
          Use_Terminal_Circle := FieldByName('Use_Terminal_Circle').AsInteger;
          Terminal_Circle_Radius := FieldByName('Terminal_Circle_Radius')
            .AsSingle;
          Fixed_Circle_Radius := FieldByName('Fixed_Circle_Radius').AsInteger;
          Lateral_Deceleration := FieldByName('Lateral_Deceleration').AsSingle;
          Airborne_Descent_Rate := FieldByName('Airborne_Descent_Rate').AsFloat;
          Wire_Angle_Offset := FieldByName('Wire_Angle_Offset').AsSingle;
          Guidance_Type := FieldByName('Guidance_Type').AsInteger;
          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
          Primary_Target_Domain := FieldByName('Primary_Target_Domain')
            .AsInteger;
          Active_Acoustic_POH_Mod := FieldByName('Active_Acoustic_POH_Mod')
            .AsSingle;
          Passive_Acoustic_POH_Mod := FieldByName('Passive_Acoustic_POH_Mod')
            .AsSingle;
          Active_Passive_POH_Mod := FieldByName('Active_Passive_POH_Mod')
            .AsSingle;
          WireGuide_POH_Modifier := FieldByName('WireGuide_POH_Modifier')
            .AsSingle;
          WakeHome_POH_Modifier := FieldByName('WakeHome_POH_Modifier')
            .AsSingle;
          Active_Seeker_Power := FieldByName('Active_Seeker_Power').AsSingle;
          Active_Seeker_Freq := FieldByName('Active_Seeker_Freq').AsSingle;
          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
          First_Relative_Gyro_Angle := FieldByName('First_Relative_Gyro_Angle')
            .AsInteger;
          Second_Relative_Gyro_Angle := FieldByName
            ('Second_Relative_Gyro_Angle')
            .AsInteger;
          Max_Torpedo_Gyro_Angle := FieldByName('Max_Torpedo_Gyro_Angle')
            .AsSingle;
          Max_Torpedo_Search_Depth := FieldByName('Max_Torpedo_Search_Depth')
            .AsSingle;
          Acoustic_Torp_Ceiling_Depth := FieldByName
            ('Acoustic_Torp_Ceiling_Depth').AsSingle;
          Fixed_Ceiling_Depth := FieldByName('Fixed_Ceiling_Depth').AsInteger;
          Fixed_Seeker_TurnOn_Range := FieldByName('Fixed_Seeker_TurnOn_Range')
            .AsInteger;
          Sinuation_Runout := FieldByName('Sinuation_Runout').AsInteger;
          Runout_Sinuation_Period := FieldByName('Runout_Sinuation_Period')
            .AsSingle;
          Runout_Sinuation_Amplitude := FieldByName
            ('Runout_Sinuation_Amplitude').AsSingle;
          Min_Runout_Range := FieldByName('Min_Runout_Range').AsSingle;
          Launch_Method := FieldByName('Launch_Method').AsInteger;
          Data_Entry_Method := FieldByName('Data_Entry_Method').AsInteger;
          Launch_Speed := FieldByName('Launch_Speed').AsInteger;
          Opt_Launch_Range_Nuc_Sub := FieldByName('Opt_Launch_Range_Nuc_Sub')
            .AsSingle;
          Opt_Launch_Range_Conv_Sub := FieldByName('Opt_Launch_Range_Conv_Sub')
            .AsSingle;
          Opt_Launch_Range_Other := FieldByName('Opt_Launch_Range_Other')
            .AsSingle;
          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterTorpedoDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TTorpedo_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Torpedo_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Torpedo_Index = b.Torpedo_Index ');
    SQL.Add('WHERE Class_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TTorpedo_On_Board.Create;

        with rec.FDef do
        begin
          Torpedo_Index := FieldByName('Torpedo_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Max_Range := FieldByName('Max_Range').AsSingle;
          Min_Range := FieldByName('Min_Range').AsSingle;
          Motion_Index := FieldByName('Motion_Index').AsInteger;
          Seeker_TurnOn_Range := FieldByName('Seeker_TurnOn_Range').AsSingle;
          Lethality := FieldByName('Lethality').AsInteger;
          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
          Default_Depth := FieldByName('Default_Depth').AsSingle;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          LSpeed_Acoustic_Intens := FieldByName('LSpeed_Acoustic_Intens')
            .AsSingle;
          Below_Cav_Acoustic_Intens := FieldByName('Below_Cav_Acoustic_Intens')
            .AsSingle;
          Above_Cav_Acoustic_Intens := FieldByName('Above_Cav_Acoustic_Intens')
            .AsSingle;
          HSpeed_Acoustic_Intens := FieldByName('HSpeed_Acoustic_Intens')
            .AsSingle;
          Cavitation_Switch_Point := FieldByName('Cavitation_Switch_Point')
            .AsSingle;
          Term_Guide_Azimuth := FieldByName('Term_Guide_Azimuth').AsSingle;
          Term_Guide_Elevation := FieldByName('Term_Guide_Elevation').AsSingle;
          Term_Guide_Range := FieldByName('Term_Guide_Range').AsSingle;
          Pursuit_Guidance_Type := FieldByName('Pursuit_Guidance_Type')
            .AsInteger;
          Air_Drop_Capable := FieldByName('Air_Drop_Capable').AsInteger;
          Use_Terminal_Circle := FieldByName('Use_Terminal_Circle').AsInteger;
          Terminal_Circle_Radius := FieldByName('Terminal_Circle_Radius')
            .AsSingle;
          Fixed_Circle_Radius := FieldByName('Fixed_Circle_Radius').AsInteger;
          Lateral_Deceleration := FieldByName('Lateral_Deceleration').AsSingle;
          Airborne_Descent_Rate := FieldByName('Airborne_Descent_Rate').AsFloat;
          Wire_Angle_Offset := FieldByName('Wire_Angle_Offset').AsSingle;
          Guidance_Type := FieldByName('Guidance_Type').AsInteger;
          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
          Primary_Target_Domain := FieldByName('Primary_Target_Domain')
            .AsInteger;
          Active_Acoustic_POH_Mod := FieldByName('Active_Acoustic_POH_Mod')
            .AsSingle;
          Passive_Acoustic_POH_Mod := FieldByName('Passive_Acoustic_POH_Mod')
            .AsSingle;
          Active_Passive_POH_Mod := FieldByName('Active_Passive_POH_Mod')
            .AsSingle;
          WireGuide_POH_Modifier := FieldByName('WireGuide_POH_Modifier')
            .AsSingle;
          WakeHome_POH_Modifier := FieldByName('WakeHome_POH_Modifier')
            .AsSingle;
          Active_Seeker_Power := FieldByName('Active_Seeker_Power').AsSingle;
          Active_Seeker_Freq := FieldByName('Active_Seeker_Freq').AsSingle;
          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
          First_Relative_Gyro_Angle := FieldByName('First_Relative_Gyro_Angle')
            .AsInteger;
          Second_Relative_Gyro_Angle := FieldByName
            ('Second_Relative_Gyro_Angle')
            .AsInteger;
          Max_Torpedo_Gyro_Angle := FieldByName('Max_Torpedo_Gyro_Angle')
            .AsSingle;
          Max_Torpedo_Search_Depth := FieldByName('Max_Torpedo_Search_Depth')
            .AsSingle;
          Acoustic_Torp_Ceiling_Depth := FieldByName
            ('Acoustic_Torp_Ceiling_Depth').AsSingle;
          Fixed_Ceiling_Depth := FieldByName('Fixed_Ceiling_Depth').AsInteger;
          Fixed_Seeker_TurnOn_Range := FieldByName('Fixed_Seeker_TurnOn_Range')
            .AsInteger;
          Sinuation_Runout := FieldByName('Sinuation_Runout').AsInteger;
          Runout_Sinuation_Period := FieldByName('Runout_Sinuation_Period')
            .AsSingle;
          Runout_Sinuation_Amplitude := FieldByName
            ('Runout_Sinuation_Amplitude').AsSingle;
          Min_Runout_Range := FieldByName('Min_Runout_Range').AsSingle;
          Launch_Method := FieldByName('Launch_Method').AsInteger;
          Data_Entry_Method := FieldByName('Data_Entry_Method').AsInteger;
          Launch_Speed := FieldByName('Launch_Speed').AsInteger;
          Opt_Launch_Range_Nuc_Sub := FieldByName('Opt_Launch_Range_Nuc_Sub')
            .AsSingle;
          Opt_Launch_Range_Conv_Sub := FieldByName('Opt_Launch_Range_Conv_Sub')
            .AsSingle;
          Opt_Launch_Range_Other := FieldByName('Opt_Launch_Range_Other')
            .AsSingle;
          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetTorpedoDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Torpedo_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Torpedo_Index = b.Torpedo_Index');
    SQL.Add('WHERE Class_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertTorpedoDef(var aRec: TRecTorpedo_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Torpedo_Definition');
    SQL.Add('(Class_Identifier, Platform_Domain, Platform_Category,');
    SQL.Add('Platform_Type, Max_Range, Min_Range, Motion_Index,');
    SQL.Add('Seeker_TurnOn_Range, Lethality, Damage_Capacity, Default_Depth,');
    SQL.Add('Length, Width, Height, Front_Acoustic_Cross,');
    SQL.Add('Side_Acoustic_Cross, LSpeed_Acoustic_Intens,');
    SQL.Add('Below_Cav_Acoustic_Intens, Above_Cav_Acoustic_Intens,');
    SQL.Add('HSpeed_Acoustic_Intens, Cavitation_Switch_Point,');
    SQL.Add('Term_Guide_Azimuth, Term_Guide_Elevation, Term_Guide_Range,');
    SQL.Add('Pursuit_Guidance_Type, Air_Drop_Capable, Use_Terminal_Circle,');
    SQL.Add('Terminal_Circle_Radius, Fixed_Circle_Radius,');
    SQL.Add('Lateral_Deceleration, Airborne_Descent_Rate, Wire_Angle_Offset,');
    SQL.Add('Guidance_Type, Anti_Sur_Capable, Anti_SubSur_Capable,');
    SQL.Add('Primary_Target_Domain, Active_Acoustic_POH_Mod,');
    SQL.Add('Passive_Acoustic_POH_Mod, Active_Passive_POH_Mod,');
    SQL.Add('WireGuide_POH_Modifier, WakeHome_POH_Modifier,');
    SQL.Add('Active_Seeker_Power, Active_Seeker_Freq, Engagement_Range,');
    SQL.Add('First_Relative_Gyro_Angle, Second_Relative_Gyro_Angle,');
    SQL.Add('Max_Torpedo_Gyro_Angle, Max_Torpedo_Search_Depth,');
    SQL.Add('Acoustic_Torp_Ceiling_Depth, Fixed_Ceiling_Depth,');
    SQL.Add('Fixed_Seeker_TurnOn_Range, Sinuation_Runout,');
    SQL.Add('Runout_Sinuation_Period, Runout_Sinuation_Amplitude,');
    SQL.Add('Min_Runout_Range, Launch_Method, Data_Entry_Method,');
    SQL.Add('Launch_Speed, Opt_Launch_Range_Nuc_Sub,');
    SQL.Add('Opt_Launch_Range_Conv_Sub, Opt_Launch_Range_Other,');
    SQL.Add('Detectability_Type)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Class_Identifier) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(FloatToStr(Max_Range) + ', ');
      SQL.Add(FloatToStr(Min_Range) + ', ');
      SQL.Add(IntToStr(Motion_Index) + ', ');
      SQL.Add(FloatToStr(Seeker_TurnOn_Range) + ', ');
      SQL.Add(IntToStr(Lethality) + ', ');
      SQL.Add(IntToStr(Damage_Capacity) + ', ');
      SQL.Add(FloatToStr(Default_Depth) + ', ');
      SQL.Add(FloatToStr(Length) + ', ');
      SQL.Add(FloatToStr(Width) + ', ');
      SQL.Add(FloatToStr(Height) + ', ');
      SQL.Add(FloatToStr(Front_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(LSpeed_Acoustic_Intens) + ', ');
      SQL.Add(FloatToStr(Below_Cav_Acoustic_Intens) + ', ');
      SQL.Add(FloatToStr(Above_Cav_Acoustic_Intens) + ', ');
      SQL.Add(FloatToStr(HSpeed_Acoustic_Intens) + ', ');
      SQL.Add(FloatToStr(Cavitation_Switch_Point) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Azimuth) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Elevation) + ', ');
      SQL.Add(FloatToStr(Term_Guide_Range) + ', ');
      SQL.Add(IntToStr(Pursuit_Guidance_Type) + ', ');
      SQL.Add(IntToStr(Air_Drop_Capable) + ', ');
      SQL.Add(IntToStr(Use_Terminal_Circle) + ', ');
      SQL.Add(FloatToStr(Terminal_Circle_Radius) + ', ');
      SQL.Add(IntToStr(Fixed_Circle_Radius) + ', ');
      SQL.Add(FloatToStr(Lateral_Deceleration) + ', ');
      SQL.Add(FloatToStr(Airborne_Descent_Rate) + ', ');
      SQL.Add(FloatToStr(Wire_Angle_Offset) + ', ');
      SQL.Add(IntToStr(Guidance_Type) + ', ');
      SQL.Add(IntToStr(Anti_Sur_Capable) + ', ');
      SQL.Add(IntToStr(Anti_SubSur_Capable) + ', ');
      SQL.Add(IntToStr(Primary_Target_Domain) + ', ');
      SQL.Add(FloatToStr(Active_Acoustic_POH_Mod) + ', ');
      SQL.Add(FloatToStr(Passive_Acoustic_POH_Mod) + ', ');
      SQL.Add(FloatToStr(Active_Passive_POH_Mod) + ', ');
      SQL.Add(FloatToStr(WireGuide_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(WakeHome_POH_Modifier) + ', ');
      SQL.Add(FloatToStr(Active_Seeker_Power) + ', ');
      SQL.Add(FloatToStr(Active_Seeker_Freq) + ', ');
      SQL.Add(FloatToStr(Engagement_Range) + ', ');
      SQL.Add(IntToStr(First_Relative_Gyro_Angle) + ', ');
      SQL.Add(IntToStr(Second_Relative_Gyro_Angle) + ', ');
      SQL.Add(FloatToStr(Max_Torpedo_Gyro_Angle) + ', ');
      SQL.Add(FloatToStr(Max_Torpedo_Search_Depth) + ', ');
      SQL.Add(FloatToStr(Acoustic_Torp_Ceiling_Depth) + ', ');
      SQL.Add(IntToStr(Fixed_Ceiling_Depth) + ', ');
      SQL.Add(IntToStr(Fixed_Seeker_TurnOn_Range) + ', ');
      SQL.Add(IntToStr(Sinuation_Runout) + ', ');
      SQL.Add(FloatToStr(Runout_Sinuation_Period) + ', ');
      SQL.Add(FloatToStr(Runout_Sinuation_Amplitude) + ', ');
      SQL.Add(FloatToStr(Min_Runout_Range) + ', ');
      SQL.Add(IntToStr(Launch_Method) + ', ');
      SQL.Add(IntToStr(Data_Entry_Method) + ', ');
      SQL.Add(IntToStr(Launch_Speed) + ', ');
      SQL.Add(FloatToStr(Opt_Launch_Range_Nuc_Sub) + ', ');
      SQL.Add(FloatToStr(Opt_Launch_Range_Conv_Sub) + ', ');
      SQL.Add(FloatToStr(Opt_Launch_Range_Other) + ', ');
      SQL.Add(IntToStr(Detectability_Type) + ')');
    end;

    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Torpedo_Definition');
    SQL.Add('WHERE Class_Identifier = ' + QuotedStr(aRec.Class_Identifier));
    Open;

    Result := RecordCount > 0;

    if not IsEmpty then
    begin
      First;

      aRec.Torpedo_Index := FieldByName('Torpedo_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateTorpedoDef(var aRec: TRecTorpedo_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Torpedo_Definition');

    with aRec do
    begin
      SQL.Add('SET Class_Identifier = ' + QuotedStr(Class_Identifier));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Max_Range = ' + FloatToStr(Max_Range));
      SQL.Add(', Min_Range = ' + FloatToStr(Min_Range));
      SQL.Add(', Motion_Index = ' + IntToStr(Motion_Index));
      SQL.Add(', Seeker_TurnOn_Range = ' + FloatToStr(Seeker_TurnOn_Range));
      SQL.Add(', Lethality = ' + IntToStr(Lethality));
      SQL.Add(', Damage_Capacity = ' + IntToStr(Damage_Capacity));
      SQL.Add(', Default_Depth = ' + FloatToStr(Default_Depth));
      SQL.Add(', Length = ' + FloatToStr(Length));
      SQL.Add(', Width = ' + FloatToStr(Width));
      SQL.Add(', Height = ' + FloatToStr(Height));
      SQL.Add(', Front_Acoustic_Cross = ' + FloatToStr(Front_Acoustic_Cross));
      SQL.Add(', Side_Acoustic_Cross = ' + FloatToStr(Side_Acoustic_Cross));
      SQL.Add(', LSpeed_Acoustic_Intens = ' +
        FloatToStr(LSpeed_Acoustic_Intens));
      SQL.Add(', Below_Cav_Acoustic_Intens = ' +
        FloatToStr(Below_Cav_Acoustic_Intens));
      SQL.Add(', Above_Cav_Acoustic_Intens = ' +
        FloatToStr(Above_Cav_Acoustic_Intens));
      SQL.Add(', HSpeed_Acoustic_Intens = ' +
        FloatToStr(HSpeed_Acoustic_Intens));
      SQL.Add(', Cavitation_Switch_Point = ' +
        FloatToStr(Cavitation_Switch_Point));
      SQL.Add(', Term_Guide_Azimuth = ' + FloatToStr(Term_Guide_Azimuth));
      SQL.Add(', Term_Guide_Elevation = ' + FloatToStr(Term_Guide_Elevation));
      SQL.Add(', Term_Guide_Range = ' + FloatToStr(Term_Guide_Range));
      SQL.Add(', Pursuit_Guidance_Type = ' + IntToStr(Pursuit_Guidance_Type));
      SQL.Add(', Air_Drop_Capable = ' + IntToStr(Air_Drop_Capable));
      SQL.Add(', Use_Terminal_Circle = ' + IntToStr(Use_Terminal_Circle));
      SQL.Add(', Terminal_Circle_Radius = ' +
        FloatToStr(Terminal_Circle_Radius));
      SQL.Add(', Fixed_Circle_Radius = ' + IntToStr(Fixed_Circle_Radius));
      SQL.Add(', Lateral_Deceleration = ' + FloatToStr(Lateral_Deceleration));
      SQL.Add(', Airborne_Descent_Rate = ' + FloatToStr(Airborne_Descent_Rate));
      SQL.Add(', Wire_Angle_Offset = ' + FloatToStr(Wire_Angle_Offset));
      SQL.Add(', Guidance_Type = ' + IntToStr(Guidance_Type));
      SQL.Add(', Anti_Sur_Capable = ' + IntToStr(Anti_Sur_Capable));
      SQL.Add(', Anti_SubSur_Capable = ' + IntToStr(Anti_SubSur_Capable));
      SQL.Add(', Primary_Target_Domain = ' + IntToStr(Primary_Target_Domain));
      SQL.Add(', Active_Acoustic_POH_Mod = ' +
        FloatToStr(Active_Acoustic_POH_Mod));
      SQL.Add(', Passive_Acoustic_POH_Mod = ' +
        FloatToStr(Passive_Acoustic_POH_Mod));
      SQL.Add(', Active_Passive_POH_Mod = ' +
        FloatToStr(Active_Passive_POH_Mod));
      SQL.Add(', WireGuide_POH_Modifier = ' +
        FloatToStr(WireGuide_POH_Modifier));
      SQL.Add(', WakeHome_POH_Modifier = ' + FloatToStr(WakeHome_POH_Modifier));
      SQL.Add(', Active_Seeker_Power = ' + FloatToStr(Active_Seeker_Power));
      SQL.Add(', Active_Seeker_Freq = ' + FloatToStr(Active_Seeker_Freq));
      SQL.Add(', Engagement_Range = ' + FloatToStr(Engagement_Range));
      SQL.Add(', First_Relative_Gyro_Angle = ' +
        IntToStr(First_Relative_Gyro_Angle));
      SQL.Add(', Second_Relative_Gyro_Angle = ' +
        IntToStr(Second_Relative_Gyro_Angle));
      SQL.Add(', Max_Torpedo_Gyro_Angle = ' +
        FloatToStr(Max_Torpedo_Gyro_Angle));
      SQL.Add(', Max_Torpedo_Search_Depth = ' +
        FloatToStr(Max_Torpedo_Search_Depth));
      SQL.Add(', Acoustic_Torp_Ceiling_Depth = ' +
        FloatToStr(Acoustic_Torp_Ceiling_Depth));
      SQL.Add(', Fixed_Ceiling_Depth = ' + IntToStr(Fixed_Ceiling_Depth));
      SQL.Add(', Fixed_Seeker_TurnOn_Range = ' +
        IntToStr(Fixed_Seeker_TurnOn_Range));
      SQL.Add(', Sinuation_Runout = ' + IntToStr(Sinuation_Runout));
      SQL.Add(', Runout_Sinuation_Period = ' +
        FloatToStr(Runout_Sinuation_Period));
      SQL.Add(', Runout_Sinuation_Amplitude = ' +
        FloatToStr(Runout_Sinuation_Amplitude));
      SQL.Add(', Min_Runout_Range = ' + FloatToStr(Min_Runout_Range));
      SQL.Add(', Launch_Method = ' + IntToStr(Launch_Method));
      SQL.Add(', Data_Entry_Method = ' + IntToStr(Data_Entry_Method));
      SQL.Add(', Launch_Speed = ' + IntToStr(Launch_Speed));
      SQL.Add(', Opt_Launch_Range_Nuc_Sub = ' +
        FloatToStr(Opt_Launch_Range_Nuc_Sub));
      SQL.Add(', Opt_Launch_Range_Conv_Sub = ' +
        FloatToStr(Opt_Launch_Range_Conv_Sub));
      SQL.Add(', Opt_Launch_Range_Other = ' +
        FloatToStr(Opt_Launch_Range_Other));
      SQL.Add(', Detectability_Type = ' + IntToStr(Detectability_Type));
      SQL.Add('WHERE Torpedo_Index = ' + IntToStr(Torpedo_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteTorpedoDef(const aTorpedoIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE Torpedo_Definition');
    SQL.Add('WHERE Torpedo_Index = ' + IntToStr(aTorpedoIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Mine Definition '}

function TdmINWO.GetAllMineDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TMine_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Mine_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Mine_Index = b.Mine_Index ');
    SQL.Add('ORDER BY Mine_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TMine_On_Board.Create;

        with rec.FDef do
        begin
          Mine_Index := FieldByName('Mine_Index').AsInteger;
          Mine_Identifier := FieldByName('Mine_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Mine_Classification := FieldByName('Mine_Classification').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Mooring_Type := FieldByName('Mooring_Type').AsInteger;
          Max_Laying_Depth := FieldByName('Max_Laying_Depth').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Mine_Lethality := FieldByName('Mine_Lethality').AsInteger;
          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterMineDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TMine_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Mine_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Mine_Index = b.Mine_Index ');
    SQL.Add('WHERE Mine_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Mine_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TMine_On_Board.Create;

        with rec.FDef do
        begin
          Mine_Index := FieldByName('Mine_Index').AsInteger;
          Mine_Identifier := FieldByName('Mine_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Mine_Classification := FieldByName('Mine_Classification').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Mooring_Type := FieldByName('Mooring_Type').AsInteger;
          Max_Laying_Depth := FieldByName('Max_Laying_Depth').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Mine_Lethality := FieldByName('Mine_Lethality').AsInteger;
          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetMineDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Mine_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Mine_Index = b.Mine_Index');
    SQL.Add('WHERE Mine_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertMineDef(var aRec: TRecMine_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Mine_Definition');
    SQL.Add('(Mine_Identifier, Platform_Domain, Platform_Category,');
    SQL.Add('Platform_Type, Mine_Classification, Length, Width, Height,');
    SQL.Add('Mooring_Type, Max_Laying_Depth, Front_Acoustic_Cross,');
    SQL.Add('Side_Acoustic_Cross, Mine_Lethality, Engagement_Range,');
    SQL.Add('Anti_Sur_Capable, Anti_SubSur_Capable, Detectability_Type)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Mine_Identifier) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(IntToStr(Mine_Classification) + ', ');
      SQL.Add(FloatToStr(Length) + ', ');
      SQL.Add(FloatToStr(Width) + ', ');
      SQL.Add(FloatToStr(Height) + ', ');
      SQL.Add(IntToStr(Mooring_Type) + ', ');
      SQL.Add(FloatToStr(Max_Laying_Depth) + ', ');
      SQL.Add(FloatToStr(Front_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Mine_Lethality) + ', ');
      SQL.Add(FloatToStr(Engagement_Range) + ', ');
      SQL.Add(IntToStr(Anti_Sur_Capable) + ', ');
      SQL.Add(IntToStr(Anti_SubSur_Capable) + ', ');
      SQL.Add(IntToStr(Detectability_Type) + ')');
    end;

    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Mine_Definition');
    SQL.Add('WHERE Mine_Identifier = ' + QuotedStr(aRec.Mine_Identifier));
    Open;

    Result := RecordCount > 0;

    if not IsEmpty then
    begin
      First;

      aRec.Mine_Index := FieldByName('Mine_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateMineDef(var aRec: TRecMine_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Mine_Definition');

    with aRec do
    begin
      SQL.Add('SET Mine_Identifier = ' + QuotedStr(Mine_Identifier));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Mine_Classification = ' + IntToStr(Mine_Classification));
      SQL.Add(', Length = ' + FloatToStr(Length));
      SQL.Add(', Width = ' + FloatToStr(Width));
      SQL.Add(', Height = ' + FloatToStr(Height));
      SQL.Add(', Mooring_Type = ' + IntToStr(Mooring_Type));
      SQL.Add(', Max_Laying_Depth = ' + FloatToStr(Max_Laying_Depth));
      SQL.Add(', Front_Acoustic_Cross = ' + FloatToStr(Front_Acoustic_Cross));
      SQL.Add(', Side_Acoustic_Cross = ' + FloatToStr(Side_Acoustic_Cross));
      SQL.Add(', Mine_Lethality = ' + FloatToStr(Mine_Lethality));
      SQL.Add(', Engagement_Range = ' + FloatToStr(Engagement_Range));
      SQL.Add(', Anti_Sur_Capable = ' + IntToStr(Anti_Sur_Capable));
      SQL.Add(', Anti_SubSur_Capable = ' + IntToStr(Anti_SubSur_Capable));
      SQL.Add(', Detectability_Type = ' + IntToStr(Detectability_Type));
      SQL.Add('WHERE Mine_Index = ' + IntToStr(Mine_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteMineDef(const aMineIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM Mine_Definition');
    SQL.Add('WHERE Mine_Index = ' + IntToStr(aMineIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Gun Definition '}

function TdmINWO.GetFilterGunDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TGun_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Gun_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Gun_Index = b.Gun_Index ');
    SQL.Add('WHERE a.Gun_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Gun_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TGun_On_Board.Create;

        with rec.FDef do
        begin
          Gun_Index := FieldByName('Gun_Index').AsInteger;
          Gun_Identifier := FieldByName('Gun_Identifier').AsString;
          Gun_Category := FieldByName('Gun_Category').AsInteger;
          Rate_of_Fire := FieldByName('Rate_of_Fire').AsInteger;
          Lethality_per_Round := FieldByName('Lethality_per_Round').AsInteger;
          Min_Range := FieldByName('Min_Range').AsSingle;
          Max_Range := FieldByName('Max_Range').AsSingle;
          Air_Min_Range := FieldByName('Air_Min_Range').AsSingle;
          Air_Max_Range := FieldByName('Air_Max_Range').AsSingle;
          Fire_Cntl_Director_Req := FieldByName('Fire_Cntl_Director_Req')
            .AsInteger;
          Chaff_Capable_Gun := FieldByName('Chaff_Capable_Gun').AsInteger;
          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
          Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
          Anti_Air_Capable := FieldByName('Anti_Air_Capable').AsInteger;
          Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable').AsInteger;

          Automode_Capable := FieldByName('Automode_Capable').AsInteger;
          Max_Target_Altitude_Delta := FieldByName('Max_Target_Altitude_Delta')
            .AsInteger;
          Gun_Average_Shell_Velocity := FieldByName
            ('Gun_Average_Shell_Velocity').AsSingle;
          Man_Gun_Max_Elevation := FieldByName('Man_Gun_Max_Elevation')
            .AsSingle;
          Man_Gun_Min_Elevation := FieldByName('Man_Gun_Min_Elevation')
            .AsSingle;
          Man_Gun_Rotation_Rate := FieldByName('Man_Gun_Rotation_Rate')
            .AsSingle;
          Man_Gun_Elevation_Rate := FieldByName('Man_Gun_Elevation_Rate')
            .AsSingle;
          Man_Gun_Num_Rounds_Per_Load := FieldByName
            ('Man_Gun_Num_Rounds_Per_Load').AsInteger;
          Man_Gun_Time_to_Reload := FieldByName('Man_Gun_Time_to_Reload')
            .AsSingle;
          Man_Gun_Muzzle_Velocity := FieldByName('Man_Gun_Muzzle_Velocity')
            .AsSingle;
          NGS_Capable := FieldByName('NGS_Capable').AsInteger;
          NGS_MinDeflectionError := FieldByName('NGS_MinDeflectionError')
            .AsSingle;
          NGS_MaxDeflectionError := FieldByName('NGS_MaxDeflectionError')
            .AsSingle;
          NGS_MinRangeError := FieldByName('NGS_MinRangeError').AsSingle;
          NGS_MaxRangeError := FieldByName('NGS_MaxRangeError').AsSingle;
          NGS_MaxDispersionError := FieldByName('NGS_MaxDispersionError')
            .AsSingle;
          NGS_MaxDamageRadius := FieldByName('NGS_MaxDamageRadius').AsSingle;
          NGS_EffectiveRadius := FieldByName('NGS_EffectiveRadius').AsSingle;
          NGS_DamageRating := FieldByName('NGS_DamageRating').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAllGunDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TGun_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Gun_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Gun_Index = b.Gun_Index ');
    SQL.Add('ORDER BY Gun_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TGun_On_Board.Create;

        with rec.FDef do
        begin
          Gun_Index := FieldByName('Gun_Index').AsInteger;
          Gun_Identifier := FieldByName('Gun_Identifier').AsString;
          Gun_Category := FieldByName('Gun_Category').AsInteger;
          Rate_of_Fire := FieldByName('Rate_of_Fire').AsInteger;
          Lethality_per_Round := FieldByName('Lethality_per_Round').AsInteger;
          Min_Range := FieldByName('Min_Range').AsSingle;
          Max_Range := FieldByName('Max_Range').AsSingle;
          Air_Min_Range := FieldByName('Air_Min_Range').AsSingle;
          Air_Max_Range := FieldByName('Air_Max_Range').AsSingle;
          Fire_Cntl_Director_Req := FieldByName('Fire_Cntl_Director_Req')
            .AsInteger;
          Chaff_Capable_Gun := FieldByName('Chaff_Capable_Gun').AsInteger;
          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
          Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
          Anti_Air_Capable := FieldByName('Anti_Air_Capable').AsInteger;
          Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable').AsInteger;

          Automode_Capable := FieldByName('Automode_Capable').AsInteger;
          Max_Target_Altitude_Delta := FieldByName('Max_Target_Altitude_Delta')
            .AsInteger;
          Gun_Average_Shell_Velocity := FieldByName
            ('Gun_Average_Shell_Velocity').AsSingle;
          Man_Gun_Max_Elevation := FieldByName('Man_Gun_Max_Elevation')
            .AsSingle;
          Man_Gun_Min_Elevation := FieldByName('Man_Gun_Min_Elevation')
            .AsSingle;
          Man_Gun_Rotation_Rate := FieldByName('Man_Gun_Rotation_Rate')
            .AsSingle;
          Man_Gun_Elevation_Rate := FieldByName('Man_Gun_Elevation_Rate')
            .AsSingle;
          Man_Gun_Num_Rounds_Per_Load := FieldByName
            ('Man_Gun_Num_Rounds_Per_Load').AsInteger;
          Man_Gun_Time_to_Reload := FieldByName('Man_Gun_Time_to_Reload')
            .AsSingle;
          Man_Gun_Muzzle_Velocity := FieldByName('Man_Gun_Muzzle_Velocity')
            .AsSingle;
          NGS_Capable := FieldByName('NGS_Capable').AsInteger;
          NGS_MinDeflectionError := FieldByName('NGS_MinDeflectionError')
            .AsSingle;
          NGS_MaxDeflectionError := FieldByName('NGS_MaxDeflectionError')
            .AsSingle;
          NGS_MinRangeError := FieldByName('NGS_MinRangeError').AsSingle;
          NGS_MaxRangeError := FieldByName('NGS_MaxRangeError').AsSingle;
          NGS_MaxDispersionError := FieldByName('NGS_MaxDispersionError')
            .AsSingle;
          NGS_MaxDamageRadius := FieldByName('NGS_MaxDamageRadius').AsSingle;
          NGS_EffectiveRadius := FieldByName('NGS_EffectiveRadius').AsSingle;
          NGS_DamageRating := FieldByName('NGS_DamageRating').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetGunDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Gun_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Gun_Index = b.Gun_Index');
    SQL.Add('WHERE Gun_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertGunDef(var aRec: TRecGun_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Gun_Definition');
    SQL.Add('(Gun_Identifier, Gun_Category, Rate_of_Fire,');
    SQL.Add('Lethality_per_Round, Min_Range, Max_Range, Air_Min_Range,');
    SQL.Add('Air_Max_Range, Fire_Cntl_Director_Req, Chaff_Capable_Gun,');
    SQL.Add('Anti_Sur_Capable, Anti_Land_Capable, Anti_Air_Capable,');
    SQL.Add('Automode_Capable, Max_Target_Altitude_Delta,');
    SQL.Add('Gun_Average_Shell_Velocity, Man_Gun_Max_Elevation,');
    SQL.Add('Man_Gun_Min_Elevation, Man_Gun_Rotation_Rate,');
    SQL.Add('Man_Gun_Elevation_Rate, Man_Gun_Num_Rounds_Per_Load,');
    SQL.Add('Man_Gun_Time_to_Reload, Man_Gun_Muzzle_Velocity, NGS_Capable,');
    SQL.Add('NGS_MinDeflectionError, NGS_MaxDeflectionError,');
    SQL.Add('NGS_MinRangeError, NGS_MaxRangeError, NGS_MaxDispersionError,');
    SQL.Add('NGS_MaxDamageRadius, NGS_EffectiveRadius, NGS_DamageRating,');
    SQL.Add('Anti_Amphibious_Capable)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Gun_Identifier) + ', ');
      SQL.Add(IntToStr(Gun_Category) + ', ');
      SQL.Add(IntToStr(Rate_of_Fire) + ', ');
      SQL.Add(IntToStr(Lethality_per_Round) + ', ');
      SQL.Add(FloatToStr(Min_Range) + ', ');
      SQL.Add(FloatToStr(Max_Range) + ', ');
      SQL.Add(FloatToStr(Air_Min_Range) + ', ');
      SQL.Add(FloatToStr(Air_Max_Range) + ', ');
      SQL.Add(IntToStr(Fire_Cntl_Director_Req) + ', ');
      SQL.Add(IntToStr(Chaff_Capable_Gun) + ', ');
      SQL.Add(IntToStr(Anti_Sur_Capable) + ', ');
      SQL.Add(IntToStr(Anti_Land_Capable) + ', ');
      SQL.Add(IntToStr(Anti_Air_Capable) + ', ');
      SQL.Add(IntToStr(Automode_Capable) + ', ');
      SQL.Add(IntToStr(Max_Target_Altitude_Delta) + ', ');
      SQL.Add(FloatToStr(Gun_Average_Shell_Velocity) + ', ');
      SQL.Add(FloatToStr(Man_Gun_Max_Elevation) + ', ');
      SQL.Add(FloatToStr(Man_Gun_Min_Elevation) + ', ');
      SQL.Add(FloatToStr(Man_Gun_Rotation_Rate) + ', ');
      SQL.Add(FloatToStr(Man_Gun_Elevation_Rate) + ', ');
      SQL.Add(IntToStr(Man_Gun_Num_Rounds_Per_Load) + ', ');
      SQL.Add(FloatToStr(Man_Gun_Time_to_Reload) + ', ');
      SQL.Add(FloatToStr(Man_Gun_Muzzle_Velocity) + ', ');
      SQL.Add(IntToStr(NGS_Capable) + ', ');
      SQL.Add(FloatToStr(NGS_MinDeflectionError) + ', ');
      SQL.Add(FloatToStr(NGS_MaxDeflectionError) + ', ');
      SQL.Add(FloatToStr(NGS_MinRangeError) + ', ');
      SQL.Add(FloatToStr(NGS_MaxRangeError) + ', ');
      SQL.Add(FloatToStr(NGS_MaxDispersionError) + ', ');
      SQL.Add(FloatToStr(NGS_MaxDamageRadius) + ', ');
      SQL.Add(FloatToStr(NGS_EffectiveRadius) + ', ');
      SQL.Add(IntToStr(NGS_DamageRating) + ', ');
      SQL.Add(IntToStr(Anti_Amphibious_Capable) + ')');
    end;

    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Gun_Definition');
    SQL.Add('WHERE Gun_Identifier = ' + QuotedStr(aRec.Gun_Identifier));
    Open;

    Result := RecordCount > 0;

    if not IsEmpty then
    begin
      First;

      aRec.Gun_Index := FieldByName('Gun_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateGunDef(var aRec: TRecGun_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Gun_Definition');

    with aRec do
    begin
      SQL.Add('SET Gun_Identifier = ' + QuotedStr(Gun_Identifier));
      SQL.Add(', Gun_Category = ' + IntToStr(Gun_Category));
      SQL.Add(', Rate_of_Fire = ' + IntToStr(Rate_of_Fire));
      SQL.Add(', Lethality_per_Round = ' + IntToStr(Lethality_per_Round));
      SQL.Add(', Min_Range = ' + FloatToStr(Min_Range));
      SQL.Add(', Max_Range = ' + FloatToStr(Max_Range));
      SQL.Add(', Air_Min_Range = ' + FloatToStr(Air_Min_Range));
      SQL.Add(', Air_Max_Range = ' + FloatToStr(Air_Max_Range));
      SQL.Add(', Fire_Cntl_Director_Req = ' + IntToStr(Fire_Cntl_Director_Req));
      SQL.Add(', Chaff_Capable_Gun = ' + IntToStr(Chaff_Capable_Gun));
      SQL.Add(', Anti_Sur_Capable = ' + IntToStr(Anti_Sur_Capable));
      SQL.Add(', Anti_Land_Capable = ' + IntToStr(Anti_Land_Capable));
      SQL.Add(', Anti_Air_Capable = ' + IntToStr(Anti_Air_Capable));
      SQL.Add(', Automode_Capable = ' + IntToStr(Automode_Capable));
      SQL.Add(', Max_Target_Altitude_Delta = ' +
        IntToStr(Max_Target_Altitude_Delta));
      SQL.Add(', Gun_Average_Shell_Velocity = ' +
        FloatToStr(Gun_Average_Shell_Velocity));
      SQL.Add(', Man_Gun_Max_Elevation = ' + FloatToStr(Man_Gun_Max_Elevation));
      SQL.Add(', Man_Gun_Min_Elevation = ' + FloatToStr(Man_Gun_Min_Elevation));
      SQL.Add(', Man_Gun_Rotation_Rate = ' + FloatToStr(Man_Gun_Rotation_Rate));
      SQL.Add(', Man_Gun_Elevation_Rate = ' +
        FloatToStr(Man_Gun_Elevation_Rate));
      SQL.Add(', Man_Gun_Num_Rounds_Per_Load = ' +
        IntToStr(Man_Gun_Num_Rounds_Per_Load));
      SQL.Add(', Man_Gun_Time_to_Reload = ' +
        FloatToStr(Man_Gun_Time_to_Reload));
      SQL.Add(', Man_Gun_Muzzle_Velocity = ' +
        FloatToStr(Man_Gun_Muzzle_Velocity));
      SQL.Add(', NGS_Capable = ' + IntToStr(NGS_Capable));
      SQL.Add(', NGS_MinDeflectionError = ' +
        FloatToStr(NGS_MinDeflectionError));
      SQL.Add(', NGS_MaxDeflectionError = ' +
        FloatToStr(NGS_MaxDeflectionError));
      SQL.Add(', NGS_MinRangeError = ' + FloatToStr(NGS_MinRangeError));
      SQL.Add(', NGS_MaxRangeError = ' + FloatToStr(NGS_MaxRangeError));
      SQL.Add(', NGS_MaxDispersionError = ' +
        FloatToStr(NGS_MaxDispersionError));
      SQL.Add(', NGS_MaxDamageRadius = ' + FloatToStr(NGS_MaxDamageRadius));
      SQL.Add(', NGS_EffectiveRadius = ' + FloatToStr(NGS_EffectiveRadius));
      SQL.Add(', NGS_DamageRating = ' + IntToStr(NGS_DamageRating));
      SQL.Add(', Anti_Amphibious_Capable = ' +
        IntToStr(Anti_Amphibious_Capable));
      SQL.Add('WHERE Gun_Index = ' + IntToStr(Gun_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteGunDef(const aGunIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM Gun_Definition');
    SQL.Add('WHERE Gun_Index = ' + IntToStr(aGunIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Bomb Definition '}

function TdmINWO.GetAllBombDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TBomb_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Bomb_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Bomb_Index = b.Bomb_Index ');
    SQL.Add('ORDER BY Bomb_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TBomb_On_Board.Create;

        with rec.FDef do
        begin
          Bomb_Index := FieldByName('Bomb_Index').AsInteger;
          Bomb_Identifier := FieldByName('Bomb_Identifier').AsString;
          Bomb_Type := FieldByName('Bomb_Type').AsInteger;
          Lethality := FieldByName('Lethality').AsInteger;
          Min_Range := FieldByName('Min_Range').AsSingle;
          Max_Range := FieldByName('Max_Range').AsSingle;
          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
          Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
          Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable').AsInteger;
          Rocket_Launcher := FieldByName('Rocket_Launcher').AsInteger;

        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterBombDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TBomb_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Bomb_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.Bomb_Index = b.Bomb_Index ');
    SQL.Add('WHERE Bomb_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Bomb_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TBomb_On_Board.Create;

        with rec.FDef do
        begin
          Bomb_Index := FieldByName('Bomb_Index').AsInteger;
          Bomb_Identifier := FieldByName('Bomb_Identifier').AsString;
          Bomb_Type := FieldByName('Bomb_Type').AsInteger;
          Lethality := FieldByName('Lethality').AsInteger;
          Min_Range := FieldByName('Min_Range').AsSingle;
          Max_Range := FieldByName('Max_Range').AsSingle;
          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
          Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
          Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable').AsInteger;
          Rocket_Launcher := FieldByName('Rocket_Launcher').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetBombDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Bomb_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Bomb_Index = b.Bomb_Index');
    SQL.Add('WHERE Bomb_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertBombDef(var aRec: TRecBomb_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Bomb_Definition');
    SQL.Add('(Bomb_Identifier, Bomb_Type, Lethality, Min_Range, Max_Range,');
    SQL.Add('Rocket_Launcher, Anti_Sur_Capable, Anti_SubSur_Capable, Anti_Land_Capable,');
    SQL.Add('Anti_Amphibious_Capable)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Bomb_Identifier) + ', ');
      SQL.Add(IntToStr(Bomb_Type) + ', ');
      SQL.Add(IntToStr(Lethality) + ', ');
      SQL.Add(FloatToStr(Min_Range) + ', ');
      SQL.Add(FloatToStr(Max_Range) + ', ');
      SQL.Add(IntToStr(Rocket_Launcher) + ', ');
      SQL.Add(IntToStr(Anti_Sur_Capable) + ', ');
      SQL.Add(IntToStr(Anti_SubSur_Capable) + ', ');
      SQL.Add(IntToStr(Anti_Land_Capable) + ', ');
      SQL.Add(IntToStr(Anti_Amphibious_Capable) + ')');
    end;

    ExecSQL;

    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Bomb_Definition');
    SQL.Add('WHERE Bomb_Identifier = ' + QuotedStr(aRec.Bomb_Identifier));
    Open;

    Result := RecordCount > 0;

    if not IsEmpty then
    begin
      First;

      aRec.Bomb_Index := FieldByName('Bomb_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateBombDef(var aRec: TRecBomb_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Bomb_Definition');

    with aRec do
    begin
      SQL.Add('SET Bomb_Identifier = ' + QuotedStr(Bomb_Identifier));
      SQL.Add(', Bomb_Type = ' + IntToStr(Bomb_Type));
      SQL.Add(', Lethality = ' + IntToStr(Lethality));
      SQL.Add(', Min_Range = ' + FloatToStr(Min_Range));
      SQL.Add(', Max_Range = ' + FloatToStr(Max_Range));
      SQL.Add(', Anti_Sur_Capable = ' + IntToStr(Anti_Sur_Capable));
      SQL.Add(', Anti_SubSur_Capable = ' + IntToStr(Anti_SubSur_Capable));
      SQL.Add(', Anti_Land_Capable = ' + IntToStr(Anti_Land_Capable));
      SQL.Add(', Anti_Amphibious_Capable = ' + IntToStr(Anti_Amphibious_Capable));
      SQL.Add(', Rocket_Launcher = ' + IntToStr(Rocket_Launcher));
      SQL.Add('WHERE Bomb_Index = ' + IntToStr(Bomb_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteBombDef(const aBombIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM Bomb_Definition');
    SQL.Add('WHERE Bomb_Index = ' + IntToStr(aBombIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Weapon On Board '}

//function TdmTTT.GetMissileOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//var
//  i : Integer;
//  rec : TMissile_On_Board;
//begin
//  Result := -1;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT * ');
//    SQL.Add('FROM Fitted_Weapon_On_Board a ');
//    SQL.Add('JOIN Missile_Definition b ');
//    SQL.Add('ON a.Missile_Index = b.Missile_Index ');
//    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
//    SQL.Add('ORDER BY Instance_Identifier');
//    Open;
//
//    Result := RecordCount;
//
//    if Assigned(aList) then
//    begin
//      for i := 0 to aList.Count - 1 do
//      begin
//        rec := aList.Items[i];
//        rec.Free;
//      end;
//
//      aList.Clear;
//    end
//    else
//      aList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TMissile_On_Board.Create;
//
//        with rec.FData do
//        begin
//          Fitted_Weap_Index := FieldByName('Fitted_Weap_Index').AsInteger;
//          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
//          Instance_Type := FieldByName('Instance_Type').AsInteger;
//          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
//          Mount_Type := FieldByName('Mount_Type').AsInteger;
//          Launch_Angle := FieldByName('Launch_Angle').AsSingle;
//          Launch_Angle_Required := FieldByName('Launch_Angle_Required')
//            .AsInteger;
//          Quantity := FieldByName('Quantity').AsInteger;
//          Firing_Delay := FieldByName('Firing_Delay').AsSingle;
//          Missile_Index := FieldByName('Missile_Index').AsInteger;
//          Torpedo_Index := FieldByName('Torpedo_Index').AsInteger;
//          Mine_Index := FieldByName('Mine_Index').AsInteger;
//          Hybrid_Index := FieldByName('Hybrid_Index').AsInteger;
//        end;
//
//        with rec.FDef do
//        begin
//          Missile_Index := FieldByName('Missile_Index').AsInteger;
//          Class_Identifier := FieldByName('Class_Identifier').AsString;
//          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
//          Platform_Category := FieldByName('Platform_Category').AsInteger;
//          Platform_Type := FieldByName('Platform_Type').AsInteger;
//          Max_Range := FieldByName('Max_Range').AsSingle;
//          Min_Range := FieldByName('Min_Range').AsSingle;
//          Motion_Index := FieldByName('Motion_Index').AsInteger;
//          Seeker_TurnOn_Range := FieldByName('Seeker_TurnOn_Range').AsSingle;
//          Second_Seeker_Pattern_Capable := FieldByName
//            ('Second_Seeker_Pattern_Capable').AsInteger;
//          Seeker_Bias_Capable := FieldByName('Seeker_Bias_Capable').AsInteger;
//          Fixed_Seeker_Turn_On_Range := FieldByName
//            ('Fixed_Seeker_Turn_On_Range')
//            .AsInteger;
//          Lethality := FieldByName('Lethality').AsInteger;
//          Prob_of_Hit := FieldByName('Prob_of_Hit').AsSingle;
//          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
//          Default_Altitude := FieldByName('Default_Altitude').AsSingle;
//          Length := FieldByName('Length').AsSingle;
//          Width := FieldByName('Width').AsSingle;
//          Height := FieldByName('Height').AsSingle;
//          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
//          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
//          Front_Visual_Cross := FieldByName('Front_Visual_Cross').AsSingle;
//          Side_Visual_Cross := FieldByName('Side_Visual_Cross').AsSingle;
//          Front_Infrared_Cross := FieldByName('Front_Infrared_Cross').AsSingle;
//          Side_Infrared_Cross := FieldByName('Side_Infrared_Cross').AsSingle;
//          Pursuit_Guide_Type := FieldByName('Pursuit_Guide_Type').AsInteger;
//          Primary_Guide_Type := FieldByName('Primary_Guide_Type').AsInteger;
//          Secondary_Guide_Type := FieldByName('Secondary_Guide_Type').AsInteger;
//          Anti_Air_Capable := FieldByName('Anti_Air_Capable').AsInteger;
//          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
//          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
//          Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
//          Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable')
//            .AsInteger;
//          Primary_Target_Domain := FieldByName('Primary_Target_Domain')
//            .AsInteger;
//          SARH_POH_Modifier := FieldByName('SARH_POH_Modifier').AsSingle;
//          CG_POH_Modifier := FieldByName('CG_POH_Modifier').AsSingle;
//          TARH_POH_Modifier := FieldByName('TARH_POH_Modifier').AsSingle;
//          IR_POH_Modifier := FieldByName('IR_POH_Modifier').AsSingle;
//          AR_POH_Modifier := FieldByName('AR_POH_Modifier').AsSingle;
//          Transmitted_Frequency := FieldByName('Transmitted_Frequency').AsFloat;
//          Scan_Rate := FieldByName('Scan_Rate').AsSingle;
//          Pulse_Rep_Freq := FieldByName('Pulse_Rep_Freq').AsSingle;
//          Pulse_Width := FieldByName('Pulse_Width').AsSingle;
//          Xmit_Power := FieldByName('Xmit_Power').AsSingle;
//          TARH_Jamming_A_Probability := FieldByName
//            ('TARH_Jamming_A_Probability').AsSingle;
//          TARH_Jamming_B_Probability := FieldByName
//            ('TARH_Jamming_B_Probability').AsSingle;
//          TARH_Jamming_C_Probability := FieldByName
//            ('TARH_Jamming_C_Probability').AsSingle;
//          Wpt_Capable := FieldByName('Wpt_Capable').AsInteger;
//          Max_Num_Wpts := FieldByName('Max_Num_Wpts').AsInteger;
//          Min_Final_Leg_Length := FieldByName('Min_Final_Leg_Length').AsSingle;
//          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
//          Max_Firing_Depth := FieldByName('Max_Firing_Depth').AsSingle;
//          Upper_Received_Freq := FieldByName('Upper_Received_Freq').AsFloat;
//          Lower_Received_Freq := FieldByName('Lower_Received_Freq').AsFloat;
//          Fly_Out_Required := FieldByName('Fly_Out_Required').AsInteger;
//          Fly_Out_Range := FieldByName('Fly_Out_Range').AsSingle;
//          Fly_Out_Altitude := FieldByName('Fly_Out_Altitude').AsSingle;
//          Booster_Separation_Required := FieldByName
//            ('Booster_Separation_Required').AsInteger;
//          Booster_Separation_Range := FieldByName('Booster_Separation_Range')
//            .AsSingle;
//          Booster_Separation_Box_Width := FieldByName
//            ('Booster_Separation_Box_Width').AsSingle;
//          Booster_Separation_Box_Length := FieldByName
//            ('Booster_Separation_Box_Length').AsSingle;
//          Term_Guide_Azimuth := FieldByName('Term_Guide_Azimuth').AsSingle;
//          Term_Guide_Elevation := FieldByName('Term_Guide_Elevation').AsSingle;
//          Term_Guide_Range := FieldByName('Term_Guide_Range').AsSingle;
//          Terminal_Guidance_Capability := FieldByName
//            ('Terminal_Guidance_Capability').AsInteger;
//          Terminal_Altitude_Required := FieldByName
//            ('Terminal_Altitude_Required')
//            .AsInteger;
//          Terminal_Acquisition_Altitude := FieldByName
//            ('Terminal_Acquisition_Altitude').AsSingle;
//          Terminal_Sinuation_Start_Range := FieldByName
//            ('Terminal_Sinuation_Start_Range').AsSingle;
//          Terminal_Sinuation_Period := FieldByName('Terminal_Sinuation_Period')
//            .AsSingle;
//          Terminal_Sinuation_Amplitude := FieldByName
//            ('Terminal_Sinuation_Amplitude').AsSingle;
//          Terminal_Pop_Up_Range := FieldByName('Terminal_Pop_Up_Range')
//            .AsSingle;
//          Terminal_Pop_Up_Altitude := FieldByName('Terminal_Pop_Up_Altitude')
//            .AsSingle;
//          Mid_Course_Update_Mode := FieldByName('Mid_Course_Update_Mode')
//            .AsInteger;
//          Home_On_Jam_Type_A_Capable := FieldByName
//            ('Home_On_Jam_Type_A_Capable')
//            .AsInteger;
//          Home_On_Jam_Type_B_Capable := FieldByName
//            ('Home_On_Jam_Type_B_Capable')
//            .AsInteger;
//          Home_On_Jam_Type_C_Capable := FieldByName
//            ('Home_On_Jam_Type_C_Capable')
//            .AsInteger;
//          Launch_Method := FieldByName('Launch_Method').AsInteger;
//          Data_Entry_Method := FieldByName('Data_Entry_Method').AsInteger;
//          Launch_Speed := FieldByName('Launch_Speed').AsInteger;
//          Max_Target_Altitude_Delta := FieldByName('Max_Target_Altitude_Delta')
//            .AsInteger;
//          Term_Guide_Azimuth_Narrow := FieldByName('Term_Guide_Azimuth_Narrow')
//            .AsSingle;
//          Term_Guide_Elevation_Narrow := FieldByName
//            ('Term_Guide_Elevation_Narrow').AsSingle;
//          Term_Guide_Range_Narrow := FieldByName('Term_Guide_Range_Narrow')
//            .AsSingle;
//          Spot_Number := FieldByName('Spot_Number').AsInteger;
//          ECCM_Type := FieldByName('ECCM_Type').AsInteger;
//          ECM_Detonation := FieldByName('ECM_Detonation').AsInteger;
//          ECM_Detection := FieldByName('ECM_Detection').AsInteger;
//          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
//          IRCM_Detonation := FieldByName('IRCM_Detonation').AsInteger;
//          IRCM_Detection := FieldByName('IRCM_Detection').AsInteger;
//          Sea_State_Modelling_Capable := FieldByName
//            ('Sea_State_Modelling_Capable').AsInteger;
//        end;
//
//        aList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;
//
//function TdmTTT.GetTorpedoOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//var
//  i : Integer;
//  rec : TTorpedo_On_Board;
//begin
//  Result := -1;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT * ');
//    SQL.Add('FROM Fitted_Weapon_On_Board a ');
//    SQL.Add('JOIN Torpedo_Definition b ');
//    SQL.Add('ON a.Torpedo_Index = b.Torpedo_Index ');
//    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
//    SQL.Add('ORDER BY Instance_Identifier');
//    Open;
//
//    Result := RecordCount;
//
//    if Assigned(aList) then
//    begin
//      for i := 0 to aList.Count - 1 do
//      begin
//        rec := aList.Items[i];
//        rec.Free;
//      end;
//
//      aList.Clear;
//    end
//    else
//      aList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TTorpedo_On_Board.Create;
//
//        with rec.FData do
//        begin
//          Fitted_Weap_Index := FieldByName('Fitted_Weap_Index').AsInteger;
//          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
//          Instance_Type := FieldByName('Instance_Type').AsInteger;
//          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
//          Mount_Type := FieldByName('Mount_Type').AsInteger;
//          Launch_Angle := FieldByName('Launch_Angle').AsSingle;
//          Launch_Angle_Required := FieldByName('Launch_Angle_Required')
//            .AsInteger;
//          Quantity := FieldByName('Quantity').AsInteger;
//          Firing_Delay := FieldByName('Firing_Delay').AsSingle;
//          Missile_Index := FieldByName('Missile_Index').AsInteger;
//          Torpedo_Index := FieldByName('Torpedo_Index').AsInteger;
//          Mine_Index := FieldByName('Mine_Index').AsInteger;
//          Hybrid_Index := FieldByName('Hybrid_Index').AsInteger;
//        end;
//
//        with rec.FDef do
//        begin
//          Torpedo_Index := FieldByName('Torpedo_Index').AsInteger;
//          Class_Identifier := FieldByName('Class_Identifier').AsString;
//          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
//          Platform_Category := FieldByName('Platform_Category').AsInteger;
//          Platform_Type := FieldByName('Platform_Type').AsInteger;
//          Max_Range := FieldByName('Max_Range').AsSingle;
//          Min_Range := FieldByName('Min_Range').AsSingle;
//          Motion_Index := FieldByName('Motion_Index').AsInteger;
//          Seeker_TurnOn_Range := FieldByName('Seeker_TurnOn_Range').AsSingle;
//          Lethality := FieldByName('Lethality').AsInteger;
//          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
//          Default_Depth := FieldByName('Default_Depth').AsSingle;
//          Length := FieldByName('Length').AsSingle;
//          Width := FieldByName('Width').AsSingle;
//          Height := FieldByName('Height').AsSingle;
//          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
//          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
//          LSpeed_Acoustic_Intens := FieldByName('LSpeed_Acoustic_Intens')
//            .AsSingle;
//          Below_Cav_Acoustic_Intens := FieldByName('Below_Cav_Acoustic_Intens')
//            .AsSingle;
//          Above_Cav_Acoustic_Intens := FieldByName('Above_Cav_Acoustic_Intens')
//            .AsSingle;
//          HSpeed_Acoustic_Intens := FieldByName('HSpeed_Acoustic_Intens')
//            .AsSingle;
//          Cavitation_Switch_Point := FieldByName('Cavitation_Switch_Point')
//            .AsSingle;
//          Term_Guide_Azimuth := FieldByName('Term_Guide_Azimuth').AsSingle;
//          Term_Guide_Elevation := FieldByName('Term_Guide_Elevation').AsSingle;
//          Term_Guide_Range := FieldByName('Term_Guide_Range').AsSingle;
//          Pursuit_Guidance_Type := FieldByName('Pursuit_Guidance_Type')
//            .AsInteger;
//          Air_Drop_Capable := FieldByName('Air_Drop_Capable').AsInteger;
//          Use_Terminal_Circle := FieldByName('Use_Terminal_Circle').AsInteger;
//          Terminal_Circle_Radius := FieldByName('Terminal_Circle_Radius')
//            .AsSingle;
//          Fixed_Circle_Radius := FieldByName('Fixed_Circle_Radius').AsInteger;
//          Lateral_Deceleration := FieldByName('Lateral_Deceleration').AsSingle;
//          Airborne_Descent_Rate := FieldByName('Airborne_Descent_Rate').AsFloat;
//          Wire_Angle_Offset := FieldByName('Wire_Angle_Offset').AsSingle;
//          Guidance_Type := FieldByName('Guidance_Type').AsInteger;
//          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
//          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
//          Primary_Target_Domain := FieldByName('Primary_Target_Domain')
//            .AsInteger;
//          Active_Acoustic_POH_Mod := FieldByName('Active_Acoustic_POH_Mod')
//            .AsSingle;
//          Passive_Acoustic_POH_Mod := FieldByName('Passive_Acoustic_POH_Mod')
//            .AsSingle;
//          Active_Passive_POH_Mod := FieldByName('Active_Passive_POH_Mod')
//            .AsSingle;
//          WireGuide_POH_Modifier := FieldByName('WireGuide_POH_Modifier')
//            .AsSingle;
//          WakeHome_POH_Modifier := FieldByName('WakeHome_POH_Modifier')
//            .AsSingle;
//          Active_Seeker_Power := FieldByName('Active_Seeker_Power').AsSingle;
//          Active_Seeker_Freq := FieldByName('Active_Seeker_Freq').AsSingle;
//          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
//          First_Relative_Gyro_Angle := FieldByName('First_Relative_Gyro_Angle')
//            .AsInteger;
//          Second_Relative_Gyro_Angle := FieldByName
//            ('Second_Relative_Gyro_Angle')
//            .AsInteger;
//          Max_Torpedo_Gyro_Angle := FieldByName('Max_Torpedo_Gyro_Angle')
//            .AsSingle;
//          Max_Torpedo_Search_Depth := FieldByName('Max_Torpedo_Search_Depth')
//            .AsSingle;
//          Acoustic_Torp_Ceiling_Depth := FieldByName
//            ('Acoustic_Torp_Ceiling_Depth').AsSingle;
//          Fixed_Ceiling_Depth := FieldByName('Fixed_Ceiling_Depth').AsInteger;
//          Fixed_Seeker_TurnOn_Range := FieldByName('Fixed_Seeker_TurnOn_Range')
//            .AsInteger;
//          Sinuation_Runout := FieldByName('Sinuation_Runout').AsInteger;
//          Runout_Sinuation_Period := FieldByName('Runout_Sinuation_Period')
//            .AsSingle;
//          Runout_Sinuation_Amplitude := FieldByName
//            ('Runout_Sinuation_Amplitude').AsSingle;
//          Min_Runout_Range := FieldByName('Min_Runout_Range').AsSingle;
//          Launch_Method := FieldByName('Launch_Method').AsInteger;
//          Data_Entry_Method := FieldByName('Data_Entry_Method').AsInteger;
//          Launch_Speed := FieldByName('Launch_Speed').AsInteger;
//          Opt_Launch_Range_Nuc_Sub := FieldByName('Opt_Launch_Range_Nuc_Sub')
//            .AsSingle;
//          Opt_Launch_Range_Conv_Sub := FieldByName('Opt_Launch_Range_Conv_Sub')
//            .AsSingle;
//          Opt_Launch_Range_Other := FieldByName('Opt_Launch_Range_Other')
//            .AsSingle;
//          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
//        end;
//
//        aList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;
//
//function TdmTTT.GetMineOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//var
//  i : Integer;
//  rec : TMine_On_Board;
//begin
//  Result := -1;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT * ');
//    SQL.Add('FROM Fitted_Weapon_On_Board a ');
//    SQL.Add('JOIN Mine_Definition b ');
//    SQL.Add('ON a.Mine_Index = b.Mine_Index ');
//    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
//    SQL.Add('ORDER BY Instance_Identifier');
//    Open;
//
//    Result := RecordCount;
//
//    if Assigned(aList) then
//    begin
//      for i := 0 to aList.Count - 1 do
//      begin
//        rec := aList.Items[i];
//        rec.Free;
//      end;
//
//      aList.Clear;
//    end
//    else
//      aList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TMine_On_Board.Create;
//
//        with rec.FData do
//        begin
//          Fitted_Weap_Index := FieldByName('Fitted_Weap_Index').AsInteger;
//          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
//          Instance_Type := FieldByName('Instance_Type').AsInteger;
//          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
//          Mount_Type := FieldByName('Mount_Type').AsInteger;
//          Launch_Angle := FieldByName('Launch_Angle').AsSingle;
//          Launch_Angle_Required := FieldByName('Launch_Angle_Required')
//            .AsInteger;
//          Quantity := FieldByName('Quantity').AsInteger;
//          Firing_Delay := FieldByName('Firing_Delay').AsSingle;
//          Missile_Index := FieldByName('Missile_Index').AsInteger;
//          Torpedo_Index := FieldByName('Torpedo_Index').AsInteger;
//          Mine_Index := FieldByName('Mine_Index').AsInteger;
//          Hybrid_Index := FieldByName('Hybrid_Index').AsInteger;
//        end;
//
//        with rec.FMine_Def do
//        begin
//          Mine_Index := FieldByName('Mine_Index').AsInteger;
//          Mine_Identifier := FieldByName('Mine_Identifier').AsString;
//          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
//          Platform_Category := FieldByName('Platform_Category').AsInteger;
//          Platform_Type := FieldByName('Platform_Type').AsInteger;
//          Mine_Classification := FieldByName('Mine_Classification').AsInteger;
//          Length := FieldByName('Length').AsSingle;
//          Width := FieldByName('Width').AsSingle;
//          Height := FieldByName('Height').AsSingle;
//          Mooring_Type := FieldByName('Mooring_Type').AsInteger;
//          Max_Laying_Depth := FieldByName('Max_Laying_Depth').AsSingle;
//          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
//          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
//          Mine_Lethality := FieldByName('Mine_Lethality').AsInteger;
//          Engagement_Range := FieldByName('Engagement_Range').AsSingle;
//          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
//          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
//          Detectability_Type := FieldByName('Detectability_Type').AsInteger;
//        end;
//
//        aList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;
//
//function TdmTTT.GetGunOnBoard(const aVehicleID: Integer;var aList: TList): Integer;
//var
//  i : Integer;
//  rec : TGun_Definition;
//begin
//  Result := -1;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT * ');
//    SQL.Add('FROM Point_Effect_On_Board a ');
//    SQL.Add('JOIN Gun_Definition b ');
//    SQL.Add('ON a.Gun_Index = b.Gun_Index ');
//    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
//    SQL.Add('ORDER BY Instance_Identifier');
//    Open;
//
//    Result := RecordCount;
//
//    if Assigned(aList) then
//    begin
//      for i := 0 to aList.Count - 1 do
//      begin
//        rec := aList.Items[i];
//        rec.Free;
//      end;
//
//      aList.Clear;
//    end
//    else
//      aList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TGun_Definition.Create;
//
//        with rec.FPoint.FData do
//        begin
//          Point_Effect_Index := FieldByName('Point_Effect_Index').AsInteger;
//          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
//          Quantity := FieldByName('Quantity').AsInteger;
//          Gun_Index := FieldByName('Gun_Index').AsInteger;
//          Mount_Type := FieldByName('Mount_Type').AsInteger;
//          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
//          Instance_Type := FieldByName('Instance_Type').AsInteger;
//        end;
//
//        with rec.FData do
//        begin
//          Gun_Index := FieldByName('Gun_Index').AsInteger;
//          Gun_Identifier := FieldByName('Gun_Identifier').AsString;
//          Gun_Category := FieldByName('Gun_Category').AsInteger;
//          Rate_of_Fire := FieldByName('Rate_of_Fire').AsInteger;
//          Lethality_per_Round := FieldByName('Lethality_per_Round').AsInteger;
//          Min_Range := FieldByName('Min_Range').AsSingle;
//          Max_Range := FieldByName('Max_Range').AsSingle;
//          Air_Min_Range := FieldByName('Air_Min_Range').AsSingle;
//          Air_Max_Range := FieldByName('Air_Max_Range').AsSingle;
//          Fire_Cntl_Director_Req := FieldByName('Fire_Cntl_Director_Req')
//            .AsInteger;
//          Chaff_Capable_Gun := FieldByName('Chaff_Capable_Gun').AsInteger;
//          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
//          Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
//          Anti_Air_Capable := FieldByName('Anti_Air_Capable').AsInteger;
//          Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable')
//            .AsInteger;
//          Automode_Capable := FieldByName('Automode_Capable').AsInteger;
//          Max_Target_Altitude_Delta := FieldByName('Max_Target_Altitude_Delta')
//            .AsInteger;
//          Gun_Average_Shell_Velocity := FieldByName
//            ('Gun_Average_Shell_Velocity').AsSingle;
//          Man_Gun_Max_Elevation := FieldByName('Man_Gun_Max_Elevation')
//            .AsSingle;
//          Man_Gun_Min_Elevation := FieldByName('Man_Gun_Min_Elevation')
//            .AsSingle;
//          Man_Gun_Rotation_Rate := FieldByName('Man_Gun_Rotation_Rate')
//            .AsSingle;
//          Man_Gun_Elevation_Rate := FieldByName('Man_Gun_Elevation_Rate')
//            .AsSingle;
//          Man_Gun_Num_Rounds_Per_Load := FieldByName
//            ('Man_Gun_Num_Rounds_Per_Load').AsInteger;
//          Man_Gun_Time_to_Reload := FieldByName('Man_Gun_Time_to_Reload')
//            .AsSingle;
//          Man_Gun_Muzzle_Velocity := FieldByName('Man_Gun_Muzzle_Velocity')
//            .AsSingle;
//          NGS_Capable := FieldByName('NGS_Capable').AsInteger;
//          NGS_MinDeflectionError := FieldByName('NGS_MinDeflectionError')
//            .AsSingle;
//          NGS_MaxDeflectionError := FieldByName('NGS_MaxDeflectionError')
//            .AsSingle;
//          NGS_MinRangeError := FieldByName('NGS_MinRangeError').AsSingle;
//          NGS_MaxRangeError := FieldByName('NGS_MaxRangeError').AsSingle;
//          NGS_MaxDispersionError := FieldByName('NGS_MaxDispersionError')
//            .AsSingle;
//          NGS_MaxDamageRadius := FieldByName('NGS_MaxDamageRadius').AsSingle;
//          NGS_EffectiveRadius := FieldByName('NGS_EffectiveRadius').AsSingle;
//          NGS_DamageRating := FieldByName('NGS_DamageRating').AsInteger;
//        end;
//
//        aList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;
//
//function TdmTTT.GetBombOnBoard(const aVehicleID: Integer; var aList: TList): Integer;
//var
//  i : Integer;
//  rec : TBomb_Definition;
//begin
//  Result := -1;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT * ');
//    SQL.Add('FROM Point_Effect_On_Board a ');
//    SQL.Add('JOIN Bomb_Definition b ');
//    SQL.Add('ON a.Bomb_Index = b.Bomb_Index ');
//    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
//    SQL.Add('ORDER BY Instance_Identifier');
//    Open;
//
//    Result := RecordCount;
//
//    if Assigned(aList) then
//    begin
//      for i := 0 to aList.Count - 1 do
//      begin
//        rec := aList.Items[i];
//        rec.Free;
//      end;
//
//      aList.Clear;
//    end
//    else
//      aList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TBomb_Definition.Create;
//
//        with rec.FPoint.FData do
//        begin
//          Point_Effect_Index := FieldByName('Point_Effect_Index').AsInteger;
//          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
//          Quantity := FieldByName('Quantity').AsInteger;
//          Gun_Index := FieldByName('Gun_Index').AsInteger;
//          Bomb_Index := FieldByName('Bomb_Index').AsInteger;
//          Mount_Type := FieldByName('Mount_Type').AsInteger;
//          Instance_Type := FieldByName('Instance_Type').AsInteger;
//          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
//        end;
//
//        with rec.FData do
//        begin
//          Bomb_Index := FieldByName('Bomb_Index').AsInteger;
//          Bomb_Identifier := FieldByName('Bomb_Identifier').AsString;
//          Bomb_Type := FieldByName('Bomb_Type').AsInteger;
//          Lethality := FieldByName('Lethality').AsInteger;
//          Min_Range := FieldByName('Min_Range').AsSingle;
//          Max_Range := FieldByName('Max_Range').AsSingle;
//          Anti_Sur_Capable := FieldByName('Anti_Sur_Capable').AsInteger;
//          Anti_SubSur_Capable := FieldByName('Anti_SubSur_Capable').AsInteger;
//          Anti_Land_Capable := FieldByName('Anti_Land_Capable').AsInteger;
//          Anti_Amphibious_Capable := FieldByName('Anti_Amphibious_Capable')
//            .AsInteger;
//        end;
//
//        aList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;
//
//function TdmTTT.GetFittedWeaponOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT *');
//    SQL.Add('FROM Fitted_Weapon_On_Board');
//    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
//    SQL.Add('AND Instance_Identifier = ' + QuotedStr(aIdentifier));
//    Open;
//
//    Result := RecordCount > 0;
//  end;
//end;
//
//function TdmTTT.GetPointEffectOnBoardCount(const aVehicleID: Integer; const aIdentifier: string): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT *');
//    SQL.Add('FROM Point_Effect_On_Board');
//    SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aVehicleID));
//    SQL.Add('AND Instance_Identifier = ' + QuotedStr(aIdentifier));
//    Open;
//
//    Result := RecordCount > 0;
//  end;
//end;
//
//function TdmTTT.GetFittedWeaponLauncherOnBoard(const aWeaponID: Integer;   var aList: TList): Boolean;
//var
//  i : Integer;
//  rec : TFitted_Weap_Launcher_On_Board;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT *');
//    SQL.Add('FROM Fitted_Weap_Launcher_On_Board');
//    SQL.Add('WHERE Fitted_Weap_Index = ' + IntToStr(aWeaponID));
//    SQL.Add('ORDER BY Launcher_Type');
//    Open;
//
//    Result := RecordCount > 0;
//
//    if Assigned(aList) then
//    begin
//      for i := 0 to aList.Count - 1 do
//      begin
//        rec := aList.Items[i];
//        rec.Free;
//      end;
//
//      aList.Clear;
//    end
//    else
//      aList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TFitted_Weap_Launcher_On_Board.Create;
//
//        with rec.FData do
//        begin
//          Fitted_Weap_Index := FieldByName('Fitted_Weap_Index').AsInteger;
//          Launcher_Type := FieldByName('Launcher_Type').AsInteger;
//          Launcher_Angle_Required := FieldByName('Launcher_Angle_Required')
//            .AsInteger;
//          Launcher_Angle := FieldByName('Launcher_Angle').AsInteger;
//          Launcher_Max_Qty := FieldByName('Launcher_Max_Qty').AsInteger;
//        end;
//
//        aList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;
//
//function TdmTTT.GetFittedWeaponLauncherOnBoardCount(const aFittedWeapID: Integer; const aType: Integer): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT *');
//    SQL.Add('FROM Fitted_Weap_Launcher_On_Board');
//    SQL.Add('WHERE Fitted_Weap_Index = ' + IntToStr(aFittedWeapID));
//    SQL.Add('AND Launcher_Type = ' + IntToStr(aType));
//    Open;
//
//    Result := RecordCount > 0;
//  end;
//end;
//
//function TdmTTT.InsertFittedWeaponOnBoard(const aInsertType: Byte;var aRec: TRecFitted_Weapon_On_Board): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('INSERT INTO Fitted_Weapon_On_Board');
//    SQL.Add('(Instance_Identifier, Vehicle_Index, Instance_Type, Mount_Type,');
//    SQL.Add('Quantity, Firing_Delay,');
//
//    case aInsertType of
//      1: SQL.Add('Missile_Index)');
//      2: SQL.Add('Torpedo_Index)');
//      3: SQL.Add('Mine_Index)');
//      4: SQL.Add('Hybrid_Index)');
//    end;
//
//    SQL.Add('VALUES ( ');
//
//    with aRec do
//    begin
//      SQL.Add(QuotedStr(Instance_Identifier) + ', ');
//      SQL.Add(IntToStr(Vehicle_Index) + ', ');
//      SQL.Add(IntToStr(Instance_Type) + ', ');
//      SQL.Add(IntToStr(Mount_Type) + ', ');
//      SQL.Add(IntToStr(Quantity) + ', ');
//      SQL.Add(FloatToStr(Firing_Delay) + ', ');
//
//      case aInsertType of
//        1: SQL.Add(IntToStr(Missile_Index) + ')');
//        2: SQL.Add(IntToStr(Torpedo_Index) + ')');
//        3: SQL.Add(IntToStr(Mine_Index) + ')');
//        4: SQL.Add(IntToStr(Hybrid_Index) + ')');
//      end;
//    end;
//
//    ExecSQL;
//
//    SQL.Clear;
//    SQL.Add('SELECT *');
//    SQL.Add('FROM Fitted_Weapon_On_Board');
//    SQL.Add('WHERE Instance_Identifier = ' + QuotedStr(aRec.Instance_Identifier));
//    SQL.Add('AND Vehicle_Index = ' + IntToStr(aRec.Vehicle_Index));
//    Open;
//
//    Result := RecordCount > 0;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      aRec.Fitted_Weap_Index := FieldByName('Fitted_Weap_Index').AsInteger;
//    end;
//  end;
//end;
//
//function TdmTTT.UpdateFittedWeaponOnBoard(const aUpdateType: Byte;var aRec: TRecFitted_Weapon_On_Board): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('UPDATE Fitted_Weapon_On_Board');
//
//    with aRec do
//    begin
//      SQL.Add('SET Instance_Identifier = ' + QuotedStr(Instance_Identifier));
//      SQL.Add(', Vehicle_Index = ' + IntToStr(Vehicle_Index));
//      SQL.Add(', Instance_Type = ' + IntToStr(Instance_Type));
//      SQL.Add(', Mount_Type = ' + IntToStr(Mount_Type));
//      SQL.Add(', Firing_Delay = '+ FloatToStr(Firing_Delay));
//      SQL.Add(', Quantity = ' + IntToStr(Quantity));
//
//      case aUpdateType of
//        1: SQL.Add(', Missile_Index = ' + IntToStr(Missile_Index));
//        2: SQL.Add(', Torpedo_Index = ' + IntToStr(Torpedo_Index));
//        3: SQL.Add(', Mine_Index = ' + IntToStr(Mine_Index));
//        4: SQL.Add(', Hybrid_Index = ' + IntToStr(Hybrid_Index));
//      end;
//
//      SQL.Add('WHERE Fitted_Weap_index = ' + IntToStr(Fitted_Weap_Index));
//    end;
//
//    ExecSQL;
//  end;
//end;

//function TdmTTT.InsertPointEffectOnBoard(const aInsertType: Byte;var aRec: TRecPoint_Effect_On_Board): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('INSERT INTO Point_Effect_On_Board');
//    SQL.Add('(Instance_Identifier, Instance_Type, Vehicle_Index, Mount_Type,');
//    SQL.Add('Quantity,');
//
//    case aInsertType of
//      1: SQL.Add('Gun_Index)');
//      2: SQL.Add('Bomb_Index)');
//    end;
//
//    SQL.Add('VALUES (');
//
//    with aRec do
//    begin
//      SQL.Add(QuotedStr(Instance_Identifier) + ', ');
//      SQL.Add(IntToStr(Instance_Type) + ', ');
//      SQL.Add(IntToStr(Vehicle_Index) + ', ');
//      SQL.Add(IntToStr(Mount_Type) + ', ');
//      SQL.Add(IntToStr(Quantity) + ', ');
//
//      case aInsertType of
//        1: SQL.Add(IntToStr(Gun_Index) + ')');
//        2: SQL.Add(IntToStr(Bomb_Index) + ')');
//      end;
//    end;
//
//    ExecSQL;
//
//    SQL.Clear;
//    SQL.Add('SELECT *');
//    SQL.Add('FROM Point_Effect_On_Board');
//    SQL.Add('WHERE Instance_Identifier = ' + QuotedStr(aRec.Instance_Identifier));
//    SQL.Add('AND Vehicle_Index = ' + IntToStr(aRec.Vehicle_Index));
//    Open;
//
//    Result := RecordCount > 0;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      aRec.Point_Effect_Index := FieldByName('Point_Effect_Index').AsInteger;
//    end;
//  end;
//end;

//function TdmTTT.UpdatePointEffectOnBoard(const aUpdateType: Byte;var aRec: TRecPoint_Effect_On_Board): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('UPDATE Point_Effect_On_Board');
//
//    with aRec do
//    begin
//      SQL.Add('SET Instance_Identifier = ' + QuotedStr(Instance_Identifier));
//      SQL.Add(', Vehicle_Index = '+ IntToStr(Vehicle_Index));
//      SQL.Add(', Instance_Type = '+ IntToStr(Instance_Type));
//      SQL.Add(', Mount_Type = ' + IntToStr(Mount_Type));
//      SQL.Add(', Quantity = ' + IntToStr(Quantity));
//
//      case aUpdateType of
//        1: SQL.Add(', Gun_Index = ' + IntToStr(Gun_Index));
//        2: SQL.Add(', Bomb_Index = ' + IntToStr(Bomb_Index));
//      end;
//
//      SQL.Add('WHERE Point_Effect_Index = ' + IntToStr(Point_Effect_Index));
//    end;
//
//    ExecSQL;
//
//    Result := True;
//  end;
//end;

//function TdmTTT.DeleteFittedWeaponLauncherOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('DELETE FROM Fitted_Weap_Launcher_On_Board');
//
//    case aDeleteType of
//      1:
//      begin
//        SQL.Add('WHERE Fitted_Weap_Index IN ( SELECT Fitted_Weap_Index');
//        SQL.Add('FROM Fitted_Weapon_On_Board');
//        SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aIndex) + ')');
//      end;
//      2: SQL.Add('WHERE Fitted_Weap_Index = ' + IntToStr(aIndex));
//    end;
//
//    ExecSQL;
//
//    Result := True;
//  end;
//end;

//function TdmTTT.DeleteFittedWeaponOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('DELETE FROM Fitted_Weapon_On_Board');
//
//    case aDeleteType of
//      1: SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aIndex));
//      2: SQL.Add('WHERE Fitted_Weap_Index = ' + IntToStr(aIndex));
//    end;
//
//    ExecSQL;
//
//    SQL.Clear;
//    SQL.Add('SELECT *');
//    SQL.Add('FROM Fitted_Weapon_On_Board');
//
//    case aDeleteType of
//      1: SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aIndex));
//      2: SQL.Add('WHERE Fitted_Weap_Index = ' + IntToStr(aIndex));
//    end;
//
//    Open;
//
//    Result := RecordCount = 0;
//  end;
//end;

//function TdmTTT.DeletePointEffectOnBoard(const aDeleteType: Byte; const aIndex: Integer): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('DELETE FROM Point_Effect_On_Board');
//
//    case aDeleteType of
//      1: SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aIndex));
//      2: SQL.Add('WHERE Point_Effect_Index = ' + IntToStr(aIndex));
//    end;
//
//    ExecSQL;
//
//    SQL.Clear;
//    SQL.Add('SELECT *');
//    SQL.Add('FROM Point_Effect_On_Board');
//
//    case aDeleteType of
//      1: SQL.Add('WHERE Vehicle_Index = ' + IntToStr(aIndex));
//      2: SQL.Add('WHERE Point_Effect_Index = ' + IntToStr(aIndex));
//    end;
//
//    Open;
//
//    Result := RecordCount = 0;
//  end;
//end;

//function TdmTTT.InsertFittedWeaponLauncherOnBoard(const aRec: TRecFitted_Weap_Launcher_On_Board): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('INSERT INTO Fitted_Weap_Launcher_On_Board');
//    SQL.Add('(Fitted_Weap_Index, Launcher_Type, Launcher_Angle_Required,');
//    SQL.Add('Launcher_Angle, Launcher_Max_Qty)');
//    SQL.Add('VALUES( ');
//
//    with aRec do
//    begin
//      SQL.Add(IntToStr(Fitted_Weap_Index) + ', ');
//      SQL.Add(IntToStr(Launcher_Type) + ', ');
//      SQL.Add(IntToStr(Launcher_Angle_Required) + ', ');
//      SQL.Add(IntToStr(Launcher_Angle) + ', ');
//      SQL.Add(IntToStr(Launcher_Max_Qty) + ')');
//    end;
//
//    ExecSQL;
//
//    Result := True;
//  end;
//end;

//function TdmTTT.UpdateFittedWeaponLauncherOnBoard(const aRec: TRecFitted_Weap_Launcher_On_Board): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('UPDATE Fitted_Weap_Launcher_On_Board');
//
//    with aRec do
//    begin
//      SQL.Add('SET Launcher_Angle_Required = ' + IntToStr(Launcher_Angle_Required));
//      SQL.Add(', Launcher_Type = ' + IntToStr(Launcher_Type));
//      SQL.Add(', Launcher_Angle = ' + IntToStr(Launcher_Angle));
//      SQL.Add(', Launcher_Max_Qty = ' + IntToStr(Launcher_Max_Qty));
//      SQL.Add('WHERE Fitted_Weap_Index = ' + IntToStr(Fitted_Weap_Index));
//      SQL.Add('AND Launcher_Type = ' + IntToStr(LastLauncher_Type));
//    end;
//
//    ExecSQL;
//
//    Result := True;
//  end;
//end;

//function TdmTTT.DeleteFittedWeaponLauncherOnBoard(const aWeaponID, aLauncherType: Integer): Boolean;
//begin
//  Result := False;
//
//  if not ZConn.Connected then
//    Exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('DELETE FROM Fitted_Weap_Launcher_On_Board');
//    SQL.Add('WHERE Fitted_Weap_Index = ' + IntToStr(aWeaponID));
//    SQL.Add('AND Launcher_Type = ' + IntToStr(aLauncherType));
//    ExecSQL;
//
//    Result := True;
//  end;
//end;

{$ENDREGION}

{$ENDREGION}

{$REGION ' Sensor Section '}

{$REGION ' Radar Definition '}

function TdmINWO.GetAllRadarDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TRadar_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Radar_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Radar_Index = b.Radar_Index');
    SQL.Add('ORDER BY a.Radar_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TRadar_On_Board.Create;

        with rec.FDef do
        begin
          Radar_Index := FieldByName('Radar_Index').AsInteger;
          Radar_Identifier := FieldByName('Radar_Identifier').AsString;
          Radar_Emitter := FieldByName('Radar_Emitter').AsString;
          Radar_Type := FieldByName('Radar_Type').AsInteger;
          Frequency := FieldByName('Frequency').AsSingle;
          Scan_Rate := FieldByName('Scan_Rate').AsSingle;
          Pulse_Rep_Freq := FieldByName('Pulse_Rep_Freq').AsSingle;
          Pulse_Width := FieldByName('Pulse_Width').AsSingle;
          Radar_Power := FieldByName('Radar_Power').AsSingle;
          Detection_Range := FieldByName('Detection_Range').AsSingle;
          Known_Cross_Section := FieldByName('Known_Cross_Section').AsSingle;
          Max_Unambig_Detect_Range := FieldByName('Max_Unambig_Detect_Range').AsSingle;
          IFF_Capability := FieldByName('IFF_Capability').AsBoolean;
          Altitude_Data_Capability := FieldByName('Altitude_Data_Capability').AsBoolean;
          Ground_Speed_Data_Capability := FieldByName('Ground_Speed_Data_Capability').AsBoolean;
          Heading_Data_Capability := FieldByName('Heading_Data_Capability').AsBoolean;
          Plat_Type_Recog_Capability := FieldByName('Plat_Type_Recog_Capability').AsBoolean;
          Plat_Class_Recog_Capability := FieldByName('Plat_Class_Recog_Capability').AsBoolean;
          Clutter_Rejection := FieldByName('Clutter_Rejection').AsSingle;
          Anti_Jamming_Capable := FieldByName('Anti_Jamming_Capable').AsBoolean;
          Curve_Definition_Index := FieldByName('Curve_Definition_Index').AsInteger;
          Second_Vert_Coverage := FieldByName('Second_Vert_Coverage').AsBoolean;
          Jamming_A_Resistant := FieldByName('Jamming_A_Resistant').AsBoolean;
          Jamming_B_Resistant := FieldByName('Jamming_B_Resistant').AsBoolean;
          Jamming_C_Resistant := FieldByName('Jamming_C_Resistant').AsBoolean;
          Anti_Jamming_A_Resistant := FieldByName('Anti_Jamming_A_Resistant').AsBoolean;
          Anti_Jamming_B_Resistant := FieldByName('Anti_Jamming_B_Resistant').AsBoolean;
          Anti_Jamming_C_Resistant := FieldByName('Anti_Jamming_C_Resistant').AsBoolean;
          Anti_Jamming_Range_Reduction := FieldByName('Anti_Jamming_Range_Reduction').AsSingle;
          Beam_Width := FieldByName('Beam_Width').AsSingle;
          Sector_Scan_Capable := FieldByName('Sector_Scan_Capable').AsBoolean;
          Off_Axis_Jammer_Reduction := FieldByName('Off_Axis_Jammer_Reduction').AsSingle;
          Num_FCR_Channels := FieldByName('Num_FCR_Channels').AsInteger;
          Radar_Spot_Number := FieldByName('Radar_Spot_Number').AsInteger;
          Radar_Horizon_Factor := FieldByName('Radar_Horizon_Factor').AsSingle;
          Main_Lobe_Gain := FieldByName('Main_Lobe_Gain').AsSingle;
          Counter_Detection_Factor := FieldByName('Counter_Detection_Factor').AsSingle;
          ECCM_Type := FieldByName('ECCM_Type').AsInteger;
          MTI_Capable := FieldByName('MTI_Capable').AsBoolean;
          MTI_MinTargetSpeed := FieldByName('MTI_MinTargetSpeed').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterRadarDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TRadar_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Radar_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Radar_Index = b.Radar_Index');
    SQL.Add('WHERE a.Radar_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Radar_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TRadar_On_Board.Create;

        with rec.FDef do
        begin
          Radar_Index := FieldByName('Radar_Index').AsInteger;
          Radar_Identifier := FieldByName('Radar_Identifier').AsString;
          Radar_Emitter := FieldByName('Radar_Emitter').AsString;
          Radar_Type := FieldByName('Radar_Type').AsInteger;
          Frequency := FieldByName('Frequency').AsSingle;
          Scan_Rate := FieldByName('Scan_Rate').AsSingle;
          Pulse_Rep_Freq := FieldByName('Pulse_Rep_Freq').AsSingle;
          Pulse_Width := FieldByName('Pulse_Width').AsSingle;
          Radar_Power := FieldByName('Radar_Power').AsSingle;
          Detection_Range := FieldByName('Detection_Range').AsSingle;
          Known_Cross_Section := FieldByName('Known_Cross_Section').AsSingle;
          Max_Unambig_Detect_Range := FieldByName('Max_Unambig_Detect_Range').AsSingle;
          IFF_Capability := FieldByName('IFF_Capability').AsBoolean;
          Altitude_Data_Capability := FieldByName('Altitude_Data_Capability').AsBoolean;
          Ground_Speed_Data_Capability := FieldByName('Ground_Speed_Data_Capability').AsBoolean;
          Heading_Data_Capability := FieldByName('Heading_Data_Capability').AsBoolean;
          Plat_Type_Recog_Capability := FieldByName('Plat_Type_Recog_Capability').AsBoolean;
          Plat_Class_Recog_Capability := FieldByName('Plat_Class_Recog_Capability').AsBoolean;
          Clutter_Rejection := FieldByName('Clutter_Rejection').AsSingle;
          Anti_Jamming_Capable := FieldByName('Anti_Jamming_Capable').AsBoolean;
          Curve_Definition_Index := FieldByName('Curve_Definition_Index').AsInteger;
          Second_Vert_Coverage := FieldByName('Second_Vert_Coverage').AsBoolean;
          Jamming_A_Resistant := FieldByName('Jamming_A_Resistant').AsBoolean;
          Jamming_B_Resistant := FieldByName('Jamming_B_Resistant').AsBoolean;
          Jamming_C_Resistant := FieldByName('Jamming_C_Resistant').AsBoolean;
          Anti_Jamming_A_Resistant := FieldByName('Anti_Jamming_A_Resistant').AsBoolean;
          Anti_Jamming_B_Resistant := FieldByName('Anti_Jamming_B_Resistant').AsBoolean;
          Anti_Jamming_C_Resistant := FieldByName('Anti_Jamming_C_Resistant').AsBoolean;
          Anti_Jamming_Range_Reduction := FieldByName('Anti_Jamming_Range_Reduction').AsSingle;
          Beam_Width := FieldByName('Beam_Width').AsSingle;
          Sector_Scan_Capable := FieldByName('Sector_Scan_Capable').AsBoolean;
          Off_Axis_Jammer_Reduction := FieldByName('Off_Axis_Jammer_Reduction').AsSingle;
          Num_FCR_Channels := FieldByName('Num_FCR_Channels').AsInteger;
          Radar_Spot_Number := FieldByName('Radar_Spot_Number').AsInteger;
          Radar_Horizon_Factor := FieldByName('Radar_Horizon_Factor').AsSingle;
          Main_Lobe_Gain := FieldByName('Main_Lobe_Gain').AsSingle;
          Counter_Detection_Factor := FieldByName('Counter_Detection_Factor').AsSingle;
          ECCM_Type := FieldByName('ECCM_Type').AsInteger;
          MTI_Capable := FieldByName('MTI_Capable').AsBoolean;
          MTI_MinTargetSpeed := FieldByName('MTI_MinTargetSpeed').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetRadarDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Radar_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Radar_Index = b.Radar_Index');
    SQL.Add('WHERE a.Radar_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertRadarDef(var aRec: TRecRadar_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Radar_Definition');
    SQL.Add('(Radar_Identifier, Radar_Emitter, Radar_Type, Frequency,');
    SQL.Add('Scan_Rate, Pulse_Rep_Freq, Pulse_Width, Radar_Power,');
    SQL.Add('Detection_Range, Known_Cross_Section, Max_Unambig_Detect_Range,');
    SQL.Add('IFF_Capability, Altitude_Data_Capability,');
    SQL.Add('Ground_Speed_Data_Capability, Heading_Data_Capability,');
    SQL.Add('Plat_Type_Recog_Capability, Plat_Class_Recog_Capability,');
    SQL.Add('Clutter_Rejection, Anti_Jamming_Capable, Curve_Definition_Index,');
    SQL.Add('Second_Vert_Coverage, Jamming_A_Resistant, Jamming_B_Resistant,');
    SQL.Add('Jamming_C_Resistant, Anti_Jamming_A_Resistant,');
    SQL.Add('Anti_Jamming_B_Resistant, Anti_Jamming_C_Resistant,');
    SQL.Add('Anti_Jamming_Range_Reduction, Beam_Width, Sector_Scan_Capable,');
    SQL.Add('Off_Axis_Jammer_Reduction, Num_FCR_Channels, Radar_Spot_Number,');
    SQL.Add('Radar_Horizon_Factor, Main_Lobe_Gain, Counter_Detection_Factor,');
    SQL.Add('ECCM_Type, MTI_Capable, MTI_MinTargetSpeed)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Radar_Identifier) + ', ');
      SQL.Add(QuotedStr(Radar_Emitter) + ', ');
      SQL.Add(IntToStr(Radar_Type) + ', ');
      SQL.Add(FloatToStr(Frequency) + ', ');
      SQL.Add(FloatToStr(Scan_Rate) + ', ');
      SQL.Add(FloatToStr(Pulse_Rep_Freq) + ', ');
      SQL.Add(FloatToStr(Pulse_Width) + ', ');
      SQL.Add(FloatToStr(Radar_Power) + ', ');
      SQL.Add(FloatToStr(Detection_Range) + ', ');
      SQL.Add(FloatToStr(Known_Cross_Section) + ', ');
      SQL.Add(FloatToStr(Max_Unambig_Detect_Range) + ', ');
      SQL.Add(BoolToStr(IFF_Capability) + ', ');
      SQL.Add(BoolToStr(Altitude_Data_Capability) + ', ');
      SQL.Add(BoolToStr(Ground_Speed_Data_Capability) + ', ');
      SQL.Add(BoolToStr(Heading_Data_Capability) + ', ');
      SQL.Add(BoolToStr(Plat_Type_Recog_Capability) + ', ');
      SQL.Add(BoolToStr(Plat_Class_Recog_Capability) + ', ');
      SQL.Add(FloatToStr(Clutter_Rejection) + ', ');
      SQL.Add(BoolToStr(Anti_Jamming_Capable) + ', ');
      SQL.Add(IntToStr(Curve_Definition_Index) + ', ');
      SQL.Add(BoolToStr(Second_Vert_Coverage) + ', ');
      SQL.Add(BoolToStr(Jamming_A_Resistant) + ', ');
      SQL.Add(BoolToStr(Jamming_B_Resistant) + ', ');
      SQL.Add(BoolToStr(Jamming_C_Resistant) + ', ');
      SQL.Add(BoolToStr(Anti_Jamming_A_Resistant) + ', ');
      SQL.Add(BoolToStr(Anti_Jamming_B_Resistant) + ', ');
      SQL.Add(BoolToStr(Anti_Jamming_C_Resistant) + ', ');
      SQL.Add(FloatToStr(Anti_Jamming_Range_Reduction) + ', ');
      SQL.Add(FloatToStr(Beam_Width) + ', ');
      SQL.Add(BoolToStr(Sector_Scan_Capable) + ', ');
      SQL.Add(FloatToStr(Off_Axis_Jammer_Reduction) + ', ');
      SQL.Add(IntToStr(Num_FCR_Channels) + ', ');
      SQL.Add(IntToStr(Radar_Spot_Number) + ', ');
      SQL.Add(FloatToStr(Radar_Horizon_Factor) + ', ');
      SQL.Add(FloatToStr(Main_Lobe_Gain) + ', ');
      SQL.Add(FloatToStr(Counter_Detection_Factor) + ', ');
      SQL.Add(IntToStr(ECCM_Type) + ', ');
      SQL.Add(BoolToStr(MTI_Capable) + ', ');
      SQL.Add(FloatToStr(MTI_MinTargetSpeed) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Radar_Definition');
      SQL.Add('WHERE Radar_Identifier = ' + QuotedStr(Radar_Identifier));
      Open;

      Radar_Index := FieldByName('Radar_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateRadarDef(var aRec: TRecRadar_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Radar_Definition');

    with aRec do
    begin
      SQL.Add('SET Radar_Identifier  = ' + QuotedStr(Radar_Identifier));
      SQL.Add(', Radar_Emitter = ' + QuotedStr(Radar_Emitter));
      SQL.Add(', Radar_Type = ' + IntToStr(Radar_Type));
      SQL.Add(', Frequency = ' + FloatToStr(Frequency));
      SQL.Add(', Scan_Rate = ' + FloatToStr(Scan_Rate));
      SQL.Add(', Pulse_Rep_Freq = ' + FloatToStr(Pulse_Rep_Freq));
      SQL.Add(', Pulse_Width = ' + FloatToStr(Pulse_Width));
      SQL.Add(', Radar_Power = ' + FloatToStr(Radar_Power));
      SQL.Add(', Detection_Range = ' + FloatToStr(Detection_Range));
      SQL.Add(', Known_Cross_Section = ' + FloatToStr(Known_Cross_Section));
      SQL.Add(', Max_Unambig_Detect_Range = ' + FloatToStr(Max_Unambig_Detect_Range));
      SQL.Add(', IFF_Capability = ' + BoolToStr(IFF_Capability));
      SQL.Add(', Altitude_Data_Capability = ' +
        BoolToStr(Altitude_Data_Capability));
      SQL.Add(', Ground_Speed_Data_Capability = ' +
        BoolToStr(Ground_Speed_Data_Capability));
      SQL.Add(', Heading_Data_Capability = ' +
        BoolToStr(Heading_Data_Capability));
      SQL.Add(', Plat_Type_Recog_Capability = ' +
        BoolToStr(Plat_Type_Recog_Capability));
      SQL.Add(', Plat_Class_Recog_Capability = ' +
        BoolToStr(Plat_Class_Recog_Capability));
      SQL.Add(', Clutter_Rejection = ' + FloatToStr(Clutter_Rejection));
      SQL.Add(', Anti_Jamming_Capable = ' + BoolToStr(Anti_Jamming_Capable));
      SQL.Add(', Curve_Definition_Index = ' + IntToStr(Curve_Definition_Index));
      SQL.Add(', Second_Vert_Coverage = ' + BoolToStr(Second_Vert_Coverage));
      SQL.Add(', Jamming_A_Resistant = ' + BoolToStr(Jamming_A_Resistant));
      SQL.Add(', Jamming_B_Resistant = ' + BoolToStr(Jamming_B_Resistant));
      SQL.Add(', Jamming_C_Resistant = ' + BoolToStr(Jamming_C_Resistant));
      SQL.Add(', Anti_Jamming_A_Resistant = ' +
        BoolToStr(Anti_Jamming_A_Resistant));
      SQL.Add(', Anti_Jamming_B_Resistant = ' +
        BoolToStr(Anti_Jamming_B_Resistant));
      SQL.Add(', Anti_Jamming_C_Resistant = ' +
        BoolToStr(Anti_Jamming_C_Resistant));
      SQL.Add(', Anti_Jamming_Range_Reduction = ' +
        FloatToStr(Anti_Jamming_Range_Reduction));
      SQL.Add(', Beam_Width = ' + FloatToStr(Beam_Width));
      SQL.Add(', Sector_Scan_Capable = ' + BoolToStr(Sector_Scan_Capable));
      SQL.Add(', Off_Axis_Jammer_Reduction = ' +
        FloatToStr(Off_Axis_Jammer_Reduction));
      SQL.Add(', Num_FCR_Channels = ' + IntToStr(Num_FCR_Channels));
      SQL.Add(', Radar_Spot_Number = ' + IntToStr(Radar_Spot_Number));
      SQL.Add(', Radar_Horizon_Factor = ' + FloatToStr(Radar_Horizon_Factor));
      SQL.Add(', Main_Lobe_Gain = ' + FloatToStr(Main_Lobe_Gain));
      SQL.Add(', Counter_Detection_Factor = ' +
        FloatToStr(Counter_Detection_Factor));
      SQL.Add(', ECCM_Type = ' + IntToStr(ECCM_Type));
      SQL.Add(', MTI_Capable = ' + BoolToStr(MTI_Capable));
      SQL.Add(', MTI_MinTargetSpeed = ' + FloatToStr(MTI_MinTargetSpeed));
      SQL.Add('WHERE Radar_Index = ' + IntToStr(Radar_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteRadarDef(const aRadarIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM Radar_Definition');
    SQL.Add('WHERE Radar_Index = ' + IntToStr(aRadarIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Sonar Definition '}

function TdmINWO.GetAllSonarDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TSonar_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Sonar_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Sonar_Index = b.Sonar_Index');
    SQL.Add('ORDER BY Sonar_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TSonar_On_Board.Create;

        with rec.FDef do
        begin
          Sonar_Index := FieldByName('Sonar_Index').AsInteger;
          Sonar_Identifier := FieldByName('Sonar_Identifier').AsString;
          Sonar_Category_Index := FieldByName('Sonar_Category_Index').AsInteger;
          Sonar_Classification := FieldByName('Sonar_Classification').AsInteger;
          Passive_Int_Period := FieldByName('Passive_Int_Period').AsInteger;
          Active_Int_Period := FieldByName('Active_Int_Period').AsInteger;
          TIOW_Short_Range := FieldByName('TIOW_Short_Range').AsSingle;
          TIOW_Medium_Range := FieldByName('TIOW_Medium_Range').AsSingle;
          TIOW_Long_Range := FieldByName('TIOW_Long_Range').AsSingle;
          Passive_Detect_Range := FieldByName('Passive_Detect_Range').AsSingle;
          Active_Detect_Range := FieldByName('Active_Detect_Range').AsSingle;
          Max_Detect_Range := FieldByName('Max_Detect_Range').AsSingle;
          Known_Signal_Source := FieldByName('Known_Signal_Source').AsSingle;
          Known_Cross_Section := FieldByName('Known_Cross_Section').AsSingle;
          Sonar_Directivity_Index := FieldByName('Sonar_Directivity_Index')
            .AsSingle;
          Active_Operating_Power := FieldByName('Active_Operating_Power')
            .AsSingle;
          Active_Freq_of_Op := FieldByName('Active_Freq_of_Op').AsSingle;
          Passive_Freq_of_Op := FieldByName('Passive_Freq_of_Op').AsSingle;
          Max_Operating_Depth := FieldByName('Max_Operating_Depth').AsSingle;
          Sonar_Depth_Rate_of_Change := FieldByName
            ('Sonar_Depth_Rate_of_Change').AsSingle;
          Depth_per_Speed := FieldByName('Depth_per_Speed').AsSingle;
          Kinking_Processing := FieldByName('Kinking_Processing').AsBoolean;
          Turn_Rate_2_Kink := FieldByName('Turn_Rate_2_Kink').AsSingle;
          Time_2_Settle_Kinked := FieldByName('Time_2_Settle_Kinked').AsInteger;
          Bearing_Processing := FieldByName('Bearing_Processing').AsBoolean;
          Time_2_Resolve_Bearing := FieldByName('Time_2_Resolve_Bearing')
            .AsInteger;
          Passive_Processing := FieldByName('Passive_Processing').AsBoolean;
          Target_Identification := FieldByName('Target_Identification')
            .AsBoolean;
          Time_2_Identify := FieldByName('Time_2_Identify').AsInteger;
          Curve_Detection_Index := FieldByName('Curve_Detection_Index')
            .AsInteger;
          Track_Analysis := FieldByName('Track_Analysis').AsInteger;
          Time_2_Provide_Track := FieldByName('Time_2_Provide_Track').AsInteger;
          Ownship_Increase_due_to_Active := FieldByName
            ('Ownship_Increase_due_to_Active').AsSingle;
          Tow_Speed := FieldByName('Tow_Speed').AsSingle;
          Minimum_Depth := FieldByName('Minimum_Depth').AsSingle;
          Maximum_Tow_Speed := FieldByName('Maximum_Tow_Speed').AsSingle;
          Maximum_Sonar_Speed := FieldByName('Maximum_Sonar_Speed').AsSingle;
          Depth_Finding_Capable := FieldByName('Depth_Finding_Capable')
            .AsBoolean;
          Tracking_Capable := FieldByName('Tracking_Capable').AsBoolean;
          Surface_Detection_Capable := FieldByName('Surface_Detection_Capable')
            .AsBoolean;
          SubSurface_Detection_Capable := FieldByName
            ('SubSurface_Detection_Capable').AsBoolean;
          Torpedo_Detection_Capable := FieldByName('Torpedo_Detection_Capable')
            .AsBoolean;
          Mine_Detection_Capable := FieldByName('Mine_Detection_Capable')
            .AsBoolean;
          Cable_Length := FieldByName('Cable_Length').AsSingle;
          Maximum_Reported_Bearing_Error := FieldByName
            ('Maximum_Reported_Bearing_Error').AsSingle;
          Average_Beam_Width := FieldByName('Average_Beam_Width').AsSingle;
          Counter_Detection_Factor := FieldByName('Counter_Detection_Factor')
            .AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterSonarDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TSonar_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Sonar_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Sonar_Index = b.Sonar_Index');
    SQL.Add('WHERE Sonar_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Sonar_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TSonar_On_Board.Create;

        with rec.FDef do
        begin
          Sonar_Index := FieldByName('Sonar_Index').AsInteger;
          Sonar_Identifier := FieldByName('Sonar_Identifier').AsString;
          Sonar_Category_Index := FieldByName('Sonar_Category_Index').AsInteger;
          Sonar_Classification := FieldByName('Sonar_Classification').AsInteger;
          Passive_Int_Period := FieldByName('Passive_Int_Period').AsInteger;
          Active_Int_Period := FieldByName('Active_Int_Period').AsInteger;
          TIOW_Short_Range := FieldByName('TIOW_Short_Range').AsSingle;
          TIOW_Medium_Range := FieldByName('TIOW_Medium_Range').AsSingle;
          TIOW_Long_Range := FieldByName('TIOW_Long_Range').AsSingle;
          Passive_Detect_Range := FieldByName('Passive_Detect_Range').AsSingle;
          Active_Detect_Range := FieldByName('Active_Detect_Range').AsSingle;
          Max_Detect_Range := FieldByName('Max_Detect_Range').AsSingle;
          Known_Signal_Source := FieldByName('Known_Signal_Source').AsSingle;
          Known_Cross_Section := FieldByName('Known_Cross_Section').AsSingle;
          Sonar_Directivity_Index := FieldByName('Sonar_Directivity_Index')
            .AsSingle;
          Active_Operating_Power := FieldByName('Active_Operating_Power')
            .AsSingle;
          Active_Freq_of_Op := FieldByName('Active_Freq_of_Op').AsSingle;
          Passive_Freq_of_Op := FieldByName('Passive_Freq_of_Op').AsSingle;
          Max_Operating_Depth := FieldByName('Max_Operating_Depth').AsSingle;
          Sonar_Depth_Rate_of_Change := FieldByName
            ('Sonar_Depth_Rate_of_Change').AsSingle;
          Depth_per_Speed := FieldByName('Depth_per_Speed').AsSingle;
          Kinking_Processing := FieldByName('Kinking_Processing').AsBoolean;
          Turn_Rate_2_Kink := FieldByName('Turn_Rate_2_Kink').AsSingle;
          Time_2_Settle_Kinked := FieldByName('Time_2_Settle_Kinked').AsInteger;
          Bearing_Processing := FieldByName('Bearing_Processing').AsBoolean;
          Time_2_Resolve_Bearing := FieldByName('Time_2_Resolve_Bearing')
            .AsInteger;
          Passive_Processing := FieldByName('Passive_Processing').AsBoolean;
          Target_Identification := FieldByName('Target_Identification')
            .AsBoolean;
          Time_2_Identify := FieldByName('Time_2_Identify').AsInteger;
          Curve_Detection_Index := FieldByName('Curve_Detection_Index')
            .AsInteger;
          Track_Analysis := FieldByName('Track_Analysis').AsInteger;
          Time_2_Provide_Track := FieldByName('Time_2_Provide_Track').AsInteger;
          Ownship_Increase_due_to_Active := FieldByName
            ('Ownship_Increase_due_to_Active').AsSingle;
          Tow_Speed := FieldByName('Tow_Speed').AsSingle;
          Minimum_Depth := FieldByName('Minimum_Depth').AsSingle;
          Maximum_Tow_Speed := FieldByName('Maximum_Tow_Speed').AsSingle;
          Maximum_Sonar_Speed := FieldByName('Maximum_Sonar_Speed').AsSingle;
          Depth_Finding_Capable := FieldByName('Depth_Finding_Capable')
            .AsBoolean;
          Tracking_Capable := FieldByName('Tracking_Capable').AsBoolean;
          Surface_Detection_Capable := FieldByName('Surface_Detection_Capable')
            .AsBoolean;
          SubSurface_Detection_Capable := FieldByName
            ('SubSurface_Detection_Capable').AsBoolean;
          Torpedo_Detection_Capable := FieldByName('Torpedo_Detection_Capable')
            .AsBoolean;
          Mine_Detection_Capable := FieldByName('Mine_Detection_Capable')
            .AsBoolean;
          Cable_Length := FieldByName('Cable_Length').AsSingle;
          Maximum_Reported_Bearing_Error := FieldByName
            ('Maximum_Reported_Bearing_Error').AsSingle;
          Average_Beam_Width := FieldByName('Average_Beam_Width').AsSingle;
          Counter_Detection_Factor := FieldByName('Counter_Detection_Factor')
            .AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetSonarDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Sonar_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Sonar_Index = b.Sonar_Index');
    SQL.Add('WHERE a.Sonar_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertSonarDef(var aRec: TRecSonar_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Sonar_Definition');
    SQL.Add('(Sonar_Identifier, Sonar_Category_Index, Sonar_Classification,');
    SQL.Add('Passive_Int_Period, Active_Int_Period, TIOW_Short_Range,');
    SQL.Add('TIOW_Medium_Range, TIOW_Long_Range, Passive_Detect_Range,');
    SQL.Add('Active_Detect_Range, Max_Detect_Range, Known_Signal_Source,');
    SQL.Add('Known_Cross_Section, Sonar_Directivity_Index,');
    SQL.Add('Active_Operating_Power, Active_Freq_of_Op, Passive_Freq_of_Op,');
    SQL.Add('Max_Operating_Depth, Sonar_Depth_Rate_of_Change,');
    SQL.Add('Depth_per_Speed, Kinking_Processing, Turn_Rate_2_Kink,');
    SQL.Add('Time_2_Settle_Kinked, Bearing_Processing,');
    SQL.Add('Time_2_Resolve_Bearing, Passive_Processing,');
    SQL.Add('Target_Identification, Time_2_Identify, Curve_Detection_Index,');
    SQL.Add('Track_Analysis, Time_2_Provide_Track,');
    SQL.Add('Ownship_Increase_due_to_Active, Tow_Speed, Minimum_Depth,');
    SQL.Add('Maximum_Tow_Speed, Maximum_Sonar_Speed, Depth_Finding_Capable,');
    SQL.Add('Tracking_Capable, Surface_Detection_Capable,');
    SQL.Add('SubSurface_Detection_Capable, Torpedo_Detection_Capable,');
    SQL.Add('Mine_Detection_Capable, Cable_Length,');
    SQL.Add('Maximum_Reported_Bearing_Error, Average_Beam_Width,');
    SQL.Add('Counter_Detection_Factor)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Sonar_Identifier) + ', ');
      SQL.Add(IntToStr(Sonar_Category_Index) + ', ');
      SQL.Add(IntToStr(Sonar_Classification) + ', ');
      SQL.Add(IntToStr(Passive_Int_Period) + ', ');
      SQL.Add(IntToStr(Active_Int_Period) + ', ');
      SQL.Add(FloatToStr(TIOW_Short_Range) + ', ');
      SQL.Add(FloatToStr(TIOW_Medium_Range) + ', ');
      SQL.Add(FloatToStr(TIOW_Long_Range) + ', ');
      SQL.Add(FloatToStr(Passive_Detect_Range) + ', ');
      SQL.Add(FloatToStr(Active_Detect_Range) + ', ');
      SQL.Add(FloatToStr(Max_Detect_Range) + ', ');
      SQL.Add(FloatToStr(Known_Signal_Source) + ', ');
      SQL.Add(FloatToStr(Known_Cross_Section) + ', ');
      SQL.Add(FloatToStr(Sonar_Directivity_Index) + ', ');
      SQL.Add(FloatToStr(Active_Operating_Power) + ', ');
      SQL.Add(FloatToStr(Active_Freq_of_Op) + ', ');
      SQL.Add(FloatToStr(Passive_Freq_of_Op) + ', ');
      SQL.Add(FloatToStr(Max_Operating_Depth) + ', ');
      SQL.Add(FloatToStr(Sonar_Depth_Rate_of_Change) + ', ');
      SQL.Add(FloatToStr(Depth_per_Speed) + ', ');
      SQL.Add(BoolToStr(Kinking_Processing) + ', ');
      SQL.Add(FloatToStr(Turn_Rate_2_Kink) + ', ');
      SQL.Add(IntToStr(Time_2_Settle_Kinked) + ', ');
      SQL.Add(BoolToStr(Bearing_Processing) + ', ');
      SQL.Add(IntToStr(Time_2_Resolve_Bearing) + ', ');
      SQL.Add(BoolToStr(Passive_Processing) + ', ');
      SQL.Add(BoolToStr(Target_Identification) + ', ');
      SQL.Add(IntToStr(Time_2_Identify) + ', ');
      SQL.Add(IntToStr(Curve_Detection_Index) + ', ');
      SQL.Add(IntToStr(Track_Analysis) + ', ');
      SQL.Add(IntToStr(Time_2_Provide_Track) + ', ');
      SQL.Add(FloatToStr(Ownship_Increase_due_to_Active) + ', ');
      SQL.Add(FloatToStr(Tow_Speed) + ', ');
      SQL.Add(FloatToStr(Minimum_Depth) + ', ');
      SQL.Add(FloatToStr(Maximum_Tow_Speed) + ', ');
      SQL.Add(FloatToStr(Maximum_Sonar_Speed) + ', ');
      SQL.Add(BoolToStr(Depth_Finding_Capable) + ', ');
      SQL.Add(BoolToStr(Tracking_Capable) + ', ');
      SQL.Add(BoolToStr(Surface_Detection_Capable) + ', ');
      SQL.Add(BoolToStr(SubSurface_Detection_Capable) + ', ');
      SQL.Add(BoolToStr(Torpedo_Detection_Capable) + ', ');
      SQL.Add(BoolToStr(Mine_Detection_Capable) + ', ');
      SQL.Add(FloatToStr(Cable_Length) + ', ');
      SQL.Add(FloatToStr(Maximum_Reported_Bearing_Error) + ', ');
      SQL.Add(FloatToStr(Average_Beam_Width) + ', ');
      SQL.Add(FloatToStr(Counter_Detection_Factor) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Sonar_Definition');
      SQL.Add('WHERE Sonar_Identifier = ' + QuotedStr(Sonar_Identifier));
      Open;

      Sonar_Index := FieldByName('Sonar_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateSonarDef(var aRec: TRecSonar_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Sonar_Definition');

    with aRec do
    begin
      SQL.Add('SET Sonar_Identifier = ' + QuotedStr(Sonar_Identifier));
      SQL.Add(', Sonar_Category_Index  = ' + IntToStr(Sonar_Category_Index));
      SQL.Add(', Sonar_Classification = ' + IntToStr(Sonar_Classification));
      SQL.Add(', Passive_Int_Period = ' + IntToStr(Passive_Int_Period));
      SQL.Add(', Active_Int_Period = ' + IntToStr(Active_Int_Period));
      SQL.Add(', TIOW_Short_Range = ' + FloatToStr(TIOW_Short_Range));
      SQL.Add(', TIOW_Medium_Range = ' + FloatToStr(TIOW_Medium_Range));
      SQL.Add(', TIOW_Long_Range = ' + FloatToStr(TIOW_Long_Range));
      SQL.Add(', Passive_Detect_Range = ' + FloatToStr(Passive_Detect_Range));
      SQL.Add(', Active_Detect_Range  = ' + FloatToStr(Active_Detect_Range));
      SQL.Add(', Max_Detect_Range = ' + FloatToStr(Max_Detect_Range));
      SQL.Add(', Known_Signal_Source = ' + FloatToStr(Known_Signal_Source));
      SQL.Add(', Known_Cross_Section = ' + FloatToStr(Known_Cross_Section));
      SQL.Add(', Sonar_Directivity_Index = ' +
        FloatToStr(Sonar_Directivity_Index));
      SQL.Add(', Active_Operating_Power = ' +
        FloatToStr(Active_Operating_Power));
      SQL.Add(', Active_Freq_of_Op = ' + FloatToStr(Active_Freq_of_Op));
      SQL.Add(', Passive_Freq_of_Op = ' + FloatToStr(Passive_Freq_of_Op));
      SQL.Add(', Max_Operating_Depth = ' + FloatToStr(Max_Operating_Depth));
      SQL.Add(', Sonar_Depth_Rate_of_Change = ' +
        FloatToStr(Sonar_Depth_Rate_of_Change));
      SQL.Add(', Depth_per_Speed = ' + FloatToStr(Depth_per_Speed));
      SQL.Add(', Kinking_Processing = ' + BoolToStr(Kinking_Processing));
      SQL.Add(', Turn_Rate_2_Kink = ' + FloatToStr(Turn_Rate_2_Kink));
      SQL.Add(', Time_2_Settle_Kinked = ' + IntToStr(Time_2_Settle_Kinked));
      SQL.Add(', Bearing_Processing = ' + BoolToStr(Bearing_Processing));
      SQL.Add(', Time_2_Resolve_Bearing = ' + IntToStr(Time_2_Resolve_Bearing));
      SQL.Add(', Passive_Processing = ' + BoolToStr(Passive_Processing));
      SQL.Add(', Target_Identification = ' + BoolToStr(Target_Identification));
      SQL.Add(', Time_2_Identify = ' + IntToStr(Time_2_Identify));
      SQL.Add(', Curve_Detection_Index = ' + IntToStr(Curve_Detection_Index));
      SQL.Add(', Track_Analysis = ' + IntToStr(Track_Analysis));
      SQL.Add(', Time_2_Provide_Track = ' + IntToStr(Time_2_Provide_Track));
      SQL.Add(', Ownship_Increase_due_to_Active = ' +
        FloatToStr(Ownship_Increase_due_to_Active));
      SQL.Add(', Tow_Speed = ' + FloatToStr(Tow_Speed));
      SQL.Add(', Minimum_Depth = ' + FloatToStr(Minimum_Depth));
      SQL.Add(', Maximum_Tow_Speed = ' + FloatToStr(Maximum_Tow_Speed));
      SQL.Add(', Maximum_Sonar_Speed = ' + FloatToStr(Maximum_Sonar_Speed));
      SQL.Add(', Depth_Finding_Capable = ' + BoolToStr(Depth_Finding_Capable));
      SQL.Add(', Tracking_Capable = ' + BoolToStr(Tracking_Capable));
      SQL.Add(', Surface_Detection_Capable = ' +
        BoolToStr(Surface_Detection_Capable));
      SQL.Add(', SubSurface_Detection_Capable = ' +
        BoolToStr(SubSurface_Detection_Capable));
      SQL.Add(', Torpedo_Detection_Capable = ' +
        BoolToStr(Torpedo_Detection_Capable));
      SQL.Add(', Mine_Detection_Capable = ' +
        BoolToStr(Mine_Detection_Capable));
      SQL.Add(', Cable_Length = ' + FloatToStr(Cable_Length));
      SQL.Add(', Maximum_Reported_Bearing_Error = ' +
        FloatToStr(Maximum_Reported_Bearing_Error));
      SQL.Add(', Average_Beam_Width = ' + FloatToStr(Average_Beam_Width));
      SQL.Add(', Counter_Detection_Factor = ' +
        FloatToStr(Counter_Detection_Factor));
      SQL.Add('WHERE Sonar_Index = ' + IntToStr(Sonar_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteSonarDef(const aSonarIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM Sonar_Definition');
    SQL.Add('WHERE Sonar_Index = ' + IntToStr(aSonarIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' ESM Definition '}

function TdmINWO.GetAllESMDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TESM_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM ESM_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.ESM_Index = b.ESM_Index');
    SQL.Add('ORDER BY a.Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TESM_On_Board.Create;

        with rec.FDef do
        begin
          ESM_Index := FieldByName('ESM_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Low_Detect_Frequency1 := FieldByName('Low_Detect_Frequency1').AsFloat;
          High_Detect_Frequency1 := FieldByName('High_Detect_Frequency1').AsFloat;
          Low_Detect_Frequency2 := FieldByName('Low_Detect_Frequency2').AsFloat;
          High_Detect_Frequency2 := FieldByName('High_Detect_Frequency2').AsFloat;
          ESM_Classification := FieldByName('ESM_Classification').AsInteger;
          Emitter_Detect_Range_Factor := FieldByName('Emitter_Detect_Range_Factor').AsSingle;
          Comm_Intercept_Capable := FieldByName('Comm_Intercept_Capable').AsInteger;
          Frequency_Identify_Range := FieldByName('Frequency_Identify_Range').AsFloat;
          PRF_Identify_Range := FieldByName('PRF_Identify_Range').AsSingle;
          Pulsewidth_Identify_Range := FieldByName('Pulsewidth_Identify_Range').AsSingle;
          Scan_Period_Identify_Range := FieldByName('Scan_Period_Identify_Range').AsSingle;
          Sector_Blank_Detection_Factor := FieldByName('Sector_Blank_Detection_Factor').AsSingle;
          Identification_Period := FieldByName('Identification_Period').AsSingle;
          Classification_Period := FieldByName('Classification_Period').AsSingle;
          Minimum_Bearing_Error_Variance := FieldByName('Minimum_Bearing_Error_Variance').AsSingle;
          Initial_Bearing_Error_Variance := FieldByName('Initial_Bearing_Error_Variance').AsSingle;
//          Second_Frequency_Detection_Capable := FieldByName('Second_Frequency_Detection_Capable').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterESMDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TESM_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM ESM_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.ESM_Index = b.ESM_Index');
    SQL.Add('WHERE a.Class_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TESM_On_Board.Create;

        with rec.FDef do
        begin
          ESM_Index := FieldByName('ESM_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Low_Detect_Frequency1 := FieldByName('Low_Detect_Frequency1').AsFloat;
          High_Detect_Frequency1 := FieldByName('High_Detect_Frequency1').AsFloat;
          Low_Detect_Frequency2 := FieldByName('Low_Detect_Frequency2').AsFloat;
          High_Detect_Frequency2 := FieldByName('High_Detect_Frequency2').AsFloat;
          ESM_Classification := FieldByName('ESM_Classification').AsInteger;
          Emitter_Detect_Range_Factor := FieldByName('Emitter_Detect_Range_Factor').AsSingle;
          Comm_Intercept_Capable := FieldByName('Comm_Intercept_Capable').AsInteger;
          Frequency_Identify_Range := FieldByName('Frequency_Identify_Range').AsFloat;
          PRF_Identify_Range := FieldByName('PRF_Identify_Range').AsSingle;
          Pulsewidth_Identify_Range := FieldByName('Pulsewidth_Identify_Range').AsSingle;
          Scan_Period_Identify_Range := FieldByName('Scan_Period_Identify_Range').AsSingle;
          Sector_Blank_Detection_Factor := FieldByName('Sector_Blank_Detection_Factor').AsSingle;
          Identification_Period := FieldByName('Identification_Period').AsSingle;
          Classification_Period := FieldByName('Classification_Period').AsSingle;
          Minimum_Bearing_Error_Variance := FieldByName('Minimum_Bearing_Error_Variance').AsSingle;
          Initial_Bearing_Error_Variance := FieldByName('Initial_Bearing_Error_Variance').AsSingle;
//          Second_Frequency_Detection_Capable := FieldByName('Second_Frequency_Detection_Capable').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetESMDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM ESM_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.ESM_Index = b.ESM_Index');
    SQL.Add('WHERE a.Class_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertESMDef(var aRec: TRecESM_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO ESM_Definition');
    SQL.Add('(Class_Identifier, Low_Detect_Frequency1,');
    SQL.Add('High_Detect_Frequency1, Low_Detect_Frequency2,');
    SQL.Add('High_Detect_Frequency2, ESM_Classification,');
    SQL.Add('Emitter_Detect_Range_Factor, Comm_Intercept_Capable,');
    SQL.Add('Frequency_Identify_Range, PRF_Identify_Range,');
    SQL.Add('Pulsewidth_Identify_Range, Scan_Period_Identify_Range,');
    SQL.Add('Sector_Blank_Detection_Factor, Identification_Period,');
    SQL.Add('Classification_Period, Minimum_Bearing_Error_Variance,');
    SQL.Add('Initial_Bearing_Error_Variance,');
    SQL.Add('Second_Frequency_Detection_Capable)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Class_Identifier) + ', ');
      SQL.Add(FloatToStr(Low_Detect_Frequency1) + ', ');
      SQL.Add(FloatToStr(High_Detect_Frequency1) + ', ');
      SQL.Add(FloatToStr(Low_Detect_Frequency2) + ', ');
      SQL.Add(FloatToStr(High_Detect_Frequency2) + ', ');
      SQL.Add(IntToStr(ESM_Classification) + ', ');
      SQL.Add(FloatToStr(Emitter_Detect_Range_Factor) + ', ');
      SQL.Add(FloatToStr(Comm_Intercept_Capable) + ', ');
      SQL.Add(FloatToStr(Frequency_Identify_Range) + ', ');
      SQL.Add(FloatToStr(PRF_Identify_Range) + ', ');
      SQL.Add(FloatToStr(Pulsewidth_Identify_Range) + ', ');
      SQL.Add(FloatToStr(Scan_Period_Identify_Range) + ', ');
      SQL.Add(FloatToStr(Sector_Blank_Detection_Factor) + ', ');
      SQL.Add(FloatToStr(Identification_Period) + ', ');
      SQL.Add(FloatToStr(Classification_Period) + ', ');
      SQL.Add(FloatToStr(Minimum_Bearing_Error_Variance) + ', ');
      SQL.Add(FloatToStr(Initial_Bearing_Error_Variance) + ', ');
      SQL.Add(FloatToStr(Second_Frequency_Detection_Capable) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM ESM_Definition');
      SQL.Add('WHERE Class_Identifier = ' + QuotedStr(Class_Identifier));
      Open;

      ESM_Index := FieldByName('ESM_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateESMDef(var aRec: TRecESM_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE ESM_Definition');

    with aRec do
    begin
      SQL.Add('SET Class_Identifier = ' + QuotedStr(Class_Identifier));
      SQL.Add(', Low_Detect_Frequency1 = ' + FloatToStr(Low_Detect_Frequency1));
      SQL.Add(', High_Detect_Frequency1 = ' +
        FloatToStr(High_Detect_Frequency1));
      SQL.Add(', Low_Detect_Frequency2 = ' + FloatToStr(Low_Detect_Frequency2));
      SQL.Add(', High_Detect_Frequency2 = ' +
        FloatToStr(High_Detect_Frequency2));
      SQL.Add(', ESM_Classification = ' + IntToStr(ESM_Classification));
      SQL.Add(', Emitter_Detect_Range_Factor = ' +
        FloatToStr(Emitter_Detect_Range_Factor));
      SQL.Add(', Comm_Intercept_Capable = ' +
        FloatToStr(Comm_Intercept_Capable));
      SQL.Add(', Frequency_Identify_Range = ' +
        FloatToStr(Frequency_Identify_Range));
      SQL.Add(', PRF_Identify_Range = ' + FloatToStr(PRF_Identify_Range));
      SQL.Add(', Pulsewidth_Identify_Range = ' +
        FloatToStr(Pulsewidth_Identify_Range));
      SQL.Add(', Scan_Period_Identify_Range = ' +
        FloatToStr(Scan_Period_Identify_Range));
      SQL.Add(', Sector_Blank_Detection_Factor = ' +
        FloatToStr(Sector_Blank_Detection_Factor));
      SQL.Add(', Identification_Period = ' + FloatToStr(Identification_Period));
      SQL.Add(', Classification_Period = ' + FloatToStr(Classification_Period));
      SQL.Add(', Minimum_Bearing_Error_Variance = ' +
        FloatToStr(Minimum_Bearing_Error_Variance));
      SQL.Add(', Initial_Bearing_Error_Variance = ' +
        FloatToStr(Initial_Bearing_Error_Variance));
      SQL.Add('WHERE ESM_Index = ' + IntToStr(ESM_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteESMDef(const aESMIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM ESM_Definition');
    SQL.Add('WHERE ESM_Index = ' + IntToStr(aESMIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' EOD Definition '}

function TdmINWO.GetAllEODDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TEOD_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM EO_Detection_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.EO_Index = b.EO_Index');
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TEOD_On_Board.Create;

        with rec.FDef do
        begin
          EOD_Index := FieldByName('EOD_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Sensor_Type := FieldByName('Sensor_Type').AsInteger;
          Detection_Range := FieldByName('Detection_Range').AsSingle;
          Known_Cross_Section := FieldByName('Known_Cross_Section').AsSingle;
          Max_Range := FieldByName('Max_Range').AsSingle;
          Scan_Rate := FieldByName('Scan_Rate').AsSingle;
          Num_FC_Channels := FieldByName('Num_FC_Channels').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterEODDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TEOD_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM EO_Detection_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.EO_Index = b.EO_Index');
    SQL.Add('WHERE Class_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TEOD_On_Board.Create;

        with rec.FDef do
        begin
          EOD_Index := FieldByName('EOD_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Sensor_Type := FieldByName('Sensor_Type').AsInteger;
          Detection_Range := FieldByName('Detection_Range').AsSingle;
          Known_Cross_Section := FieldByName('Known_Cross_Section').AsSingle;
          Max_Range := FieldByName('Max_Range').AsSingle;
          Scan_Rate := FieldByName('Scan_Rate').AsSingle;
          Num_FC_Channels := FieldByName('Num_FC_Channels').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetEODDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM EO_Detection_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.EO_Index = b.EO_Index');
    SQL.Add('WHERE a.Class_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertEODDef(var aRec: TRecEOD_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO EO_Detection_Definition');
    SQL.Add('(Class_Identifier, Sensor_Type, Detection_Range,');
    SQL.Add('Known_Cross_Section, Max_Range, Scan_Rate, Num_FC_Channels)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Class_Identifier) + ', ');
      SQL.Add(IntToStr(Sensor_Type) + ', ');
      SQL.Add(FloatToStr(Detection_Range) + ', ');
      SQL.Add(FloatToStr(Known_Cross_Section) + ', ');
      SQL.Add(FloatToStr(Max_Range) + ', ');
      SQL.Add(FloatToStr(Scan_Rate) + ', ');
      SQL.Add(IntToStr(Num_FC_Channels) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM EO_Detection_Definition');
      SQL.Add('WHERE Class_Identifier = ' + QuotedStr(Class_Identifier));
      Open;

      EOD_Index := FieldByName('EOD_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateEODDef(var aRec: TRecEOD_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE EO_Detection_Definition');

    with aRec do
    begin
      SQL.Add('SET Class_Identifier = ' + QuotedStr(Class_Identifier));
      SQL.Add(', Sensor_Type = ' + IntToStr(Sensor_Type));
      SQL.Add(', Detection_Range = ' + FloatToStr(Detection_Range));
      SQL.Add(', Known_Cross_Section = ' + FloatToStr(Known_Cross_Section));
      SQL.Add(', Max_Range = ' + FloatToStr(Max_Range));
      SQL.Add(', Scan_Rate = ' + FloatToStr(Scan_Rate));
      SQL.Add(', Num_FC_Channels = ' + IntToStr(Num_FC_Channels));
      SQL.Add('WHERE EO_Index = ' + IntToStr(EOD_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteEODDef(const aEODIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM EO_Detection_Definition');
    SQL.Add('WHERE EO_Index = ' + IntToStr(aEODIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Sonobuoy Definition '}

function TdmINWO.GetAllSonobuoyDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TSonobuoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Sonobuoy_Definition a LEFT JOIN Sonar_Definition b ');
    SQL.Add('ON a.Sonar_Index = b.Sonar_Index LEFT JOIN Note_Storage c ');
    SQL.Add('ON a.Sonobuoy_Index = c.Sonobuoy_Index ');
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TSonobuoy_On_Board.Create;

        with rec.FDef do
        begin
          Sonobuoy_Index := FieldByName('Sonobuoy_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Sonobuoy_Type := FieldByName('Sonobuoy_Type').AsInteger;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Endurance_Time := FieldByName('Endurance_Time').AsInteger;
          Max_Depth := FieldByName('Max_Depth').AsSingle;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
          CPA_Detection_Capable := FieldByName('CPA_Detection_Capable')
            .AsInteger;
          CPA_Range_Limit := FieldByName('CPA_Range_Limit').AsSingle;
          Sonar_Index := FieldByName('Sonar_Index').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterSonobuoyDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TSonobuoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Sonobuoy_Definition a LEFT JOIN Sonar_Definition b ');
    SQL.Add('ON a.Sonar_Index = b.Sonar_Index LEFT JOIN Note_Storage c ');
    SQL.Add('ON a.Sonobuoy_Index = c.Sonobuoy_Index ');
    SQL.Add('WHERE Class_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TSonobuoy_On_Board.Create;

        with rec.FDef do
        begin
          Sonobuoy_Index := FieldByName('Sonobuoy_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Sonobuoy_Type := FieldByName('Sonobuoy_Type').AsInteger;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Endurance_Time := FieldByName('Endurance_Time').AsInteger;
          Max_Depth := FieldByName('Max_Depth').AsSingle;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Damage_Capacity := FieldByName('Damage_Capacity').AsInteger;
          CPA_Detection_Capable := FieldByName('CPA_Detection_Capable')
            .AsInteger;
          CPA_Range_Limit := FieldByName('CPA_Range_Limit').AsSingle;
          Sonar_Index := FieldByName('Sonar_Index').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetSonobuoyDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Sonobuoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Sonobuoy_Index = b.Sonobuoy_Index');
    SQL.Add('WHERE a.Class_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertSonobuoyDef(var aRec: TRecSonobuoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Sonobuoy_Definition');
    SQL.Add('(Class_Identifier, Sonobuoy_Type, Platform_Domain,');
    SQL.Add('Platform_Category, Platform_Type, Endurance_Time, Max_Depth,');
    SQL.Add('Length, Width, Height, Front_Acoustic_Cross,');
    SQL.Add('Side_Acoustic_Cross, Damage_Capacity, CPA_Detection_Capable,');
    SQL.Add('CPA_Range_Limit, Sonar_Index)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Class_Identifier) + ', ');
      SQL.Add(IntToStr(Sonobuoy_Type) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(IntToStr(Endurance_Time) + ', ');
      SQL.Add(FloatToStr(Max_Depth) + ', ');
      SQL.Add(FloatToStr(Length) + ', ');
      SQL.Add(FloatToStr(Width) + ', ');
      SQL.Add(FloatToStr(Height) + ', ');
      SQL.Add(FloatToStr(Front_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Acoustic_Cross) + ', ');
      SQL.Add(IntToStr(Damage_Capacity) + ', ');
      SQL.Add(IntToStr(CPA_Detection_Capable) + ', ');
      SQL.Add(FloatToStr(CPA_Range_Limit) + ', ');
      SQL.Add(IntToStr(Sonar_Index) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Sonobuoy_Definition');
      SQL.Add('WHERE Class_Identifier = ' + QuotedStr(Class_Identifier));
      Open;

      Sonobuoy_Index := FieldByName('Sonobuoy_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateSonobuoyDef(var aRec: TRecSonobuoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Sonobuoy_Definition');

    with aRec do
    begin
      SQL.Add('SET Class_Identifier = ' + QuotedStr(Class_Identifier));
      SQL.Add(', Sonobuoy_Type = ' + IntToStr(Sonobuoy_Type));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Endurance_Time = ' + IntToStr(Endurance_Time));
      SQL.Add(', Max_Depth = ' + FloatToStr(Max_Depth));
      SQL.Add(', Length = ' + FloatToStr(Length));
      SQL.Add(', Width = ' + FloatToStr(Width));
      SQL.Add(', Height = ' + FloatToStr(Height));
      SQL.Add(', Front_Acoustic_Cross = ' + FloatToStr(Front_Acoustic_Cross));
      SQL.Add(', Side_Acoustic_Cross = ' + FloatToStr(Side_Acoustic_Cross));
      SQL.Add(', Damage_Capacity = ' + IntToStr(Damage_Capacity));
      SQL.Add(', CPA_Detection_Capable = ' + IntToStr(CPA_Detection_Capable));
      SQL.Add(', CPA_Range_Limit = ' + FloatToStr(CPA_Range_Limit));
      SQL.Add(', Sonar_Index = ' + IntToStr(Sonar_Index));
      SQL.Add('WHERE Sonobuoy_Index = ' + IntToStr(Sonobuoy_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteSonobuoyDef(const aSonobuoyIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE FROM Sonobuoy_Definition');
    SQL.Add('WHERE Sonobuoy_Index = ' + IntToStr(aSonobuoyIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' MAD Definition '}

function TdmINWO.GetAllMADDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TMAD_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM MAD_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.MAD_Index = b.MAD_Index ');
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TMAD_On_Board.Create;

        with rec.FDef do
        begin
          MAD_Index := FieldByName('MAD_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Baseline_Detect_Range := FieldByName('Baseline_Detect_Range')
            .AsSingle;
          Known_Cross_Section := FieldByName('Known_Cross_Section').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterMADDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TMAD_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM MAD_Definition a LEFT JOIN Note_Storage b ');
    SQL.Add('ON a.MAD_Index = b.MAD_Index ');
    SQL.Add('WHERE Class_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Class_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TMAD_On_Board.Create;

        with rec.FDef do
        begin
          MAD_Index := FieldByName('MAD_Index').AsInteger;
          Class_Identifier := FieldByName('Class_Identifier').AsString;
          Baseline_Detect_Range := FieldByName('Baseline_Detect_Range')
            .AsSingle;
          Known_Cross_Section := FieldByName('Known_Cross_Section').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetMADDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM MAD_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.MAD_Index = b.MAD_Index');
    SQL.Add('WHERE a.Class_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertMADDef(var aRec: TRecMAD_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO MAD_Definition');
    SQL.Add('(Class_Identifier, Baseline_Detect_Range ,Known_Cross_Section)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Class_Identifier) + ',');
      SQL.Add(FloatToStr(Baseline_Detect_Range) + ',');
      SQL.Add(FloatToStr(Known_Cross_Section) + ')');

      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM MAD_Definition');
      SQL.Add('WHERE Class_Identifier = ' + QuotedStr(Class_Identifier));
      Open;

      MAD_Index := FieldByName('MAD_Index').AsInteger;

    end;
  end;
end;

function TdmINWO.UpdateMADDef(var aRec: TRecMAD_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE MAD_Definition');

    with aRec do
    begin
      SQL.Add('SET Class_Identifier = ' + QuotedStr(Class_Identifier));
      SQL.Add(', Baseline_Detect_Range = ' + FloatToStr(Baseline_Detect_Range));
      SQL.Add(', Known_Cross_Section = ' + FloatToStr(Known_Cross_Section));
      SQL.Add('WHERE MAD_Index = ' + IntToStr(MAD_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteMADDef(const aMADIndex: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE MAD_Definition');
    SQL.Add('WHERE MAD_Index = ' + IntToStr(aMADIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$ENDREGION}

{$REGION ' Countermeasures Section '}

{$REGION ' Chaff '}

function TdmINWO.GetAllChaffDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TChaff_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Chaff_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Chaff_Index = b.Chaff_Index');
    SQL.Add('ORDER BY a.Chaff_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TChaff_On_Board.Create;

        with rec.FDef do
        begin
          Chaff_Index := FieldByName('Chaff_Index').AsInteger;
          Chaff_Identifier := FieldByName('Chaff_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Max_Radar_Cross := FieldByName('Max_Radar_Cross').AsSingle;
          Bloom_Time := FieldByName('Bloom_Time').AsInteger;
          Max_Dissipation_Time := FieldByName('Max_Dissipation_Time').AsInteger;
          Min_Dissipation_Time := FieldByName('Min_Dissipation_Time').AsInteger;
          Descent_Rate := FieldByName('Descent_Rate').AsSingle;
          Max_Radius := FieldByName('Max_Radius').AsSingle;
          Max_Radar_Attenuation := FieldByName('Max_Radar_Attenuation')
            .AsSingle;
          Radar_Affect_Lower_Freq := FieldByName('Radar_Affect_Lower_Freq')
            .AsSingle;
          Radar_Affect_Upper_Freq := FieldByName('Radar_Affect_Upper_Freq')
            .AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterChaffDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TChaff_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Chaff_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Chaff_Index = b.Chaff_Index');
    SQL.Add('WHERE a.Chaff_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Chaff_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TChaff_On_Board.Create;

        with rec.FDef do
        begin
          Chaff_Index := FieldByName('Chaff_Index').AsInteger;
          Chaff_Identifier := FieldByName('Chaff_Identifier').AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Max_Radar_Cross := FieldByName('Max_Radar_Cross').AsSingle;
          Bloom_Time := FieldByName('Bloom_Time').AsInteger;
          Max_Dissipation_Time := FieldByName('Max_Dissipation_Time').AsInteger;
          Min_Dissipation_Time := FieldByName('Min_Dissipation_Time').AsInteger;
          Descent_Rate := FieldByName('Descent_Rate').AsSingle;
          Max_Radius := FieldByName('Max_Radius').AsSingle;
          Max_Radar_Attenuation := FieldByName('Max_Radar_Attenuation')
            .AsSingle;
          Radar_Affect_Lower_Freq := FieldByName('Radar_Affect_Lower_Freq')
            .AsSingle;
          Radar_Affect_Upper_Freq := FieldByName('Radar_Affect_Upper_Freq')
            .AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetChaffDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Chaff_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Chaff_Index = b.Chaff_Index');
    SQL.Add('WHERE Chaff_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertChaffDef(var aRec: TRecChaff_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Chaff_Definition');
    SQL.Add('(Chaff_Identifier, Platform_Domain, Platform_Category,');
    SQL.Add('Platform_Type, Max_Radar_Cross, Bloom_Time,');
    SQL.Add('Max_Dissipation_Time, Min_Dissipation_Time, Descent_Rate,');
    SQL.Add('Max_Radius, Max_Radar_Attenuation, Radar_Affect_Lower_Freq,');
    SQL.Add('Radar_Affect_Upper_Freq)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Chaff_Identifier) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(FloatToStr(Max_Radar_Cross) + ', ');
      SQL.Add(IntToStr(Bloom_Time) + ', ');
      SQL.Add(IntToStr(Max_Dissipation_Time) + ', ');
      SQL.Add(IntToStr(Min_Dissipation_Time) + ', ');
      SQL.Add(FloatToStr(Descent_Rate) + ', ');
      SQL.Add(FloatToStr(Max_Radius) + ', ');
      SQL.Add(FloatToStr(Max_Radar_Attenuation) + ', ');
      SQL.Add(FloatToStr(Radar_Affect_Lower_Freq) + ', ');
      SQL.Add(FloatToStr(Radar_Affect_Upper_Freq) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Chaff_Definition');
      SQL.Add('WHERE Chaff_Identifier = ' + QuotedStr(Chaff_Identifier));
      Open;

      Chaff_Index := FieldByName('Chaff_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateChaffDef(var aRec: TRecChaff_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Chaff_Definition');

    with aRec do
    begin
      SQL.Add('SET Chaff_Identifier = ' + QuotedStr(Chaff_Identifier));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Max_Radar_Cross = ' + FloatToStr(Max_Radar_Cross));
      SQL.Add(', Bloom_Time = ' + IntToStr(Bloom_Time));
      SQL.Add(', Max_Dissipation_Time = ' + IntToStr(Max_Dissipation_Time));
      SQL.Add(', Min_Dissipation_Time = ' + IntToStr(Min_Dissipation_Time));
      SQL.Add(', Descent_Rate = ' + FloatToStr(Descent_Rate));
      SQL.Add(', Max_Radius = ' + FloatToStr(Max_Radius));
      SQL.Add(', Max_Radar_Attenuation = ' + FloatToStr(Max_Radar_Attenuation));
      SQL.Add(', Radar_Affect_Lower_Freq = ' +
        FloatToStr(Radar_Affect_Lower_Freq));
      SQL.Add(', Radar_Affect_Upper_Freq = ' +
        FloatToStr(Radar_Affect_Upper_Freq));
      SQL.Add('WHERE Chaff_Index = ' + IntToStr(Chaff_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteChaffDef(const aChaffIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE Chaff_Definition');
    SQL.Add('WHERE Chaff_Index = ' + IntToStr(aChaffIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Air Bubble '}

function TdmINWO.GetAllAirBubbleDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TAir_Bubble_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Air_Bubble_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Air_Bubble_Index = b.Air_Bubble_Index');
    SQL.Add('ORDER BY a.Air_Bubble_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TAir_Bubble_On_Board.Create;

        with rec.FDef do
        begin
          Air_Bubble_Index := FieldByName('Air_Bubble_Index').AsInteger;
          Air_Bubble_Identifier := FieldByName('Air_Bubble_Identifier')
            .AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Max_Acoustic_Cross := FieldByName('Max_Acoustic_Cross').AsSingle;
          Dissipation_Time := FieldByName('Dissipation_Time').AsSingle;
          Ascent_Rate := FieldByName('Ascent_Rate').AsSingle;
          Descent_Rate := FieldByName('Descent_Rate').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterAirBubbleDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TAir_Bubble_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Air_Bubble_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Air_Bubble_Index = b.Air_Bubble_Index');
    SQL.Add('WHERE a.Air_Bubble_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Air_Bubble_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TAir_Bubble_On_Board.Create;

        with rec.FDef do
        begin
          Air_Bubble_Index := FieldByName('Air_Bubble_Index').AsInteger;
          Air_Bubble_Identifier := FieldByName('Air_Bubble_Identifier')
            .AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Max_Acoustic_Cross := FieldByName('Max_Acoustic_Cross').AsSingle;
          Dissipation_Time := FieldByName('Dissipation_Time').AsSingle;
          Ascent_Rate := FieldByName('Ascent_Rate').AsSingle;
          Descent_Rate := FieldByName('Descent_Rate').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAirBubbleDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Air_Bubble_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Air_Bubble_Index = b.Air_Bubble_Index');
    SQL.Add('WHERE Air_Bubble_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertAirBubbleDef(var aRec: TRecAir_Bubble_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Air_Bubble_Definition');
    SQL.Add('(Air_Bubble_Identifier, Platform_Domain, Platform_Category,');
    SQL.Add('Platform_Type, Max_Acoustic_Cross, Dissipation_Time,');
    SQL.Add('Ascent_Rate, Descent_Rate)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Air_Bubble_Identifier) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(FloatToStr(Max_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Dissipation_Time) + ', ');
      SQL.Add(FloatToStr(Ascent_Rate) + ', ');
      SQL.Add(FloatToStr(Descent_Rate) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Air_Bubble_Definition');
      SQL.Add('WHERE Air_Bubble_Identifier = ' +
        QuotedStr(Air_Bubble_Identifier));
      Open;

      Air_Bubble_Index := FieldByName('Air_Bubble_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateAirBubbleDef(var aRec: TRecAir_Bubble_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Air_Bubble_Definition');

    with aRec do
    begin
      SQL.Add('SET Air_Bubble_Identifier = ' +
        QuotedStr(Air_Bubble_Identifier));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Max_Acoustic_Cross = ' + FloatToStr(Max_Acoustic_Cross));
      SQL.Add(', Dissipation_Time = ' + FloatToStr(Dissipation_Time));
      SQL.Add(', Ascent_Rate = ' + FloatToStr(Ascent_Rate));
      SQL.Add(', Descent_Rate = ' + FloatToStr(Descent_Rate));
      SQL.Add('WHERE Air_Bubble_Index = ' + IntToStr(Air_Bubble_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteAirBubbleDef(const aAirBubbleIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE Air_Bubble_Definition');
    SQL.Add('WHERE Air_Bubble_Index = ' + IntToStr(aAirBubbleIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Acoustic Decoy '}

function TdmINWO.GetAllAcousticDecoyDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TAcoustic_Decoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Acoustic_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Decoy_Index = b.Decoy_Index');
    SQL.Add('ORDER BY a.Decoy_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TAcoustic_Decoy_On_Board.Create;

        with rec.FDef do
        begin
          Decoy_Index := FieldByName('Decoy_Index').AsInteger;
          Decoy_Identifier := FieldByName('Decoy_Identifier').AsString;
          Acoustic_Intensity_Increase := FieldByName
            ('Acoustic_Intensity_Increase').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterAcousticDecoyDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TAcoustic_Decoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Acoustic_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Decoy_Index = b.Decoy_Index');
    SQL.Add('WHERE a.Decoy_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Decoy_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TAcoustic_Decoy_On_Board.Create;

        with rec.FDef do
        begin
          Decoy_Index := FieldByName('Decoy_Index').AsInteger;
          Decoy_Identifier := FieldByName('Decoy_Identifier').AsString;
          Acoustic_Intensity_Increase := FieldByName
            ('Acoustic_Intensity_Increase').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAcousticDecoyDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Acoustic_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Decoy_Index = b.Decoy_Index');
    SQL.Add('WHERE Decoy_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertAcousticDecoyDef(var aRec: TRecAcoustic_Decoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Acoustic_Decoy_Definition');
    SQL.Add('(Decoy_Identifier, Acoustic_Intensity_Increase)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Decoy_Identifier) + ', ');
      SQL.Add(FloatToStr(Acoustic_Intensity_Increase) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Acoustic_Decoy_Definition');
      SQL.Add('WHERE Decoy_Identifier = ' + QuotedStr(Decoy_Identifier));
      Open;

      Decoy_Index := FieldByName('Decoy_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateAcousticDecoyDef(var aRec: TRecAcoustic_Decoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Acoustic_Decoy_Definition');

    with aRec do
    begin
      SQL.Add('SET Decoy_Identifier = ' + QuotedStr(Decoy_Identifier));
      SQL.Add(', Acoustic_Intensity_Increase = ' +
        FloatToStr(Acoustic_Intensity_Increase));
      SQL.Add('WHERE Decoy_Index = ' + IntToStr(Decoy_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteAcousticDecoyDef(const aAcousticDecoyIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE Acoustic_Decoy_Definition');
    SQL.Add('WHERE Decoy_Index = ' + IntToStr(aAcousticDecoyIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Infrared Decoy '}

function TdmINWO.GetAllInfraredDecoyDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TInfrared_Decoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Infrared_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Infrared_Decoy_Index = b.Infrared_Decoy_Index');
    SQL.Add('ORDER BY a.Infrared_Decoy_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TInfrared_Decoy_On_Board.Create;

        with rec.FDef do
        begin
          Infrared_Decoy_Index := FieldByName('Infrared_Decoy_Index').AsInteger;
          Infrared_Decoy_Identifier := FieldByName('Infrared_Decoy_Identifier')
            .AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Max_Infrared_Cross := FieldByName('Max_Infrared_Cross').AsSingle;
          Bloom_Time := FieldByName('Bloom_Time').AsInteger;
          Sustain_Time := FieldByName('Sustain_Time').AsInteger;
          Max_Dissipation_Time := FieldByName('Max_Dissipation_Time').AsInteger;
          Min_Dissipation_Time := FieldByName('Min_Dissipation_Time').AsInteger;
          Descent_Rate := FieldByName('Descent_Rate').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterInfraredDecoyDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TInfrared_Decoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Infrared_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Infrared_Decoy_Index = b.Infrared_Decoy_Index');
    SQL.Add('WHERE a.Infrared_Decoy_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Infrared_Decoy_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TInfrared_Decoy_On_Board.Create;

        with rec.FDef do
        begin
          Infrared_Decoy_Index := FieldByName('Infrared_Decoy_Index').AsInteger;
          Infrared_Decoy_Identifier := FieldByName('Infrared_Decoy_Identifier')
            .AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Max_Infrared_Cross := FieldByName('Max_Infrared_Cross').AsSingle;
          Bloom_Time := FieldByName('Bloom_Time').AsInteger;
          Sustain_Time := FieldByName('Sustain_Time').AsInteger;
          Max_Dissipation_Time := FieldByName('Max_Dissipation_Time').AsInteger;
          Min_Dissipation_Time := FieldByName('Min_Dissipation_Time').AsInteger;
          Descent_Rate := FieldByName('Descent_Rate').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetInfraredDecoyDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Infrared_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Infrared_Decoy_Index = b.Infrared_Decoy_Index');
    SQL.Add('WHERE Infrared_Decoy_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertInfraredDecoyDef(var aRec: TRecInfrared_Decoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Infrared_Decoy_Definition');
    SQL.Add('(Infrared_Decoy_Identifier, Platform_Domain, Platform_Category,');
    SQL.Add('Platform_Type, Max_Infrared_Cross, Bloom_Time, Sustain_Time,');
    SQL.Add('Max_Dissipation_Time, Min_Dissipation_Time, Descent_Rate)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Infrared_Decoy_Identifier) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(FloatToStr(Max_Infrared_Cross) + ', ');
      SQL.Add(IntToStr(Bloom_Time) + ', ');
      SQL.Add(IntToStr(Sustain_Time) + ', ');
      SQL.Add(IntToStr(Max_Dissipation_Time) + ', ');
      SQL.Add(IntToStr(Min_Dissipation_Time) + ', ');
      SQL.Add(FloatToStr(Descent_Rate) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Infrared_Decoy_Definition');
      SQL.Add('WHERE Infrared_Decoy_Identifier = ' +
        QuotedStr(Infrared_Decoy_Identifier));
      Open;

      Infrared_Decoy_Index := FieldByName('Infrared_Decoy_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateInfraredDecoyDef(var aRec: TRecInfrared_Decoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Infrared_Decoy_Definition');

    with aRec do
    begin
      SQL.Add('SET Infrared_Decoy_Identifier = ' +
        QuotedStr(Infrared_Decoy_Identifier));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Max_Infrared_Cross = ' + FloatToStr(Max_Infrared_Cross));
      SQL.Add(', Bloom_Time = ' + IntToStr(Bloom_Time));
      SQL.Add(', Sustain_Time = ' + IntToStr(Sustain_Time));
      SQL.Add(', Max_Dissipation_Time = ' + IntToStr(Max_Dissipation_Time));
      SQL.Add(', Min_Dissipation_Time = ' + IntToStr(Min_Dissipation_Time));
      SQL.Add(', Descent_Rate = ' + FloatToStr(Descent_Rate));
      SQL.Add('WHERE Infrared_Decoy_Index = ' + IntToStr(Infrared_Decoy_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteInfraredDecoyDef(const aInfraredDecoyIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE Infrared_Decoy_Definition');
    SQL.Add('WHERE Infrared_Decoy_Index = ' + IntToStr(aInfraredDecoyIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Floating Decoy '}

function TdmINWO.GetAllFloatingDecoyDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TFloating_Decoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Floating_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Floating_Decoy_Index = b.Floating_Decoy_Index');
    SQL.Add('ORDER BY a.Floating_Decoy_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TFloating_Decoy_On_Board.Create;

        with rec.FDef do
        begin
          Floating_Decoy_Index := FieldByName('Floating_Decoy_Index').AsInteger;
          Floating_Decoy_Identifier := FieldByName('Floating_Decoy_Identifier')
            .AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
          Front_Visual_Cross := FieldByName('Front_Visual_Cross').AsSingle;
          Side_Visual_Cross := FieldByName('Side_Visual_Cross').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Lifetime_Duration := FieldByName('Lifetime_Duration').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.getAllFontTaktis(mList: TList; aFontType: Byte): Integer;
var
  rec: TFontTaktis;
begin
  result := -1;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Font_Taktis ');

    if aFontType = 0 then
      SQL.Add('WHERE FONT_ID >= 221 and FONT_ID <= 404')
    else if aFontType = 1 then
      SQL.Add('WHERE FONT_ID >= 10 and FONT_ID <= 220')
    else if aFontType = 2 then
      SQL.Add('WHERE FONT_ID >= 405 and FONT_ID <= 539');

    SQL.Add('order by FONT_ID');
    Open;

    result := RecordCount;
    if not IsEmpty then
    begin
      First;
      if not Assigned(mList) then
        mList := TList.Create;
    end;

    while not ZQ.Eof do
    begin
      rec := TFontTaktis.Create;
      with rec.FData do
      begin
        FONT_ID := FieldByName('FONT_ID').AsInteger;
        FONT_NAME := FieldByName('FONT_NAME').AsString;
        FONT_INDEX := FieldByName('FONT_INDEX').AsInteger;
        KETERANGAN := FieldByName('KETERANGAN').AsString;

      end;

      mList.Add(rec);
      ZQ.Next;
    end;
  end;
end;

function TdmINWO.GetFilterFloatingDecoyDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TFloating_Decoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Floating_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Floating_Decoy_Index = b.Floating_Decoy_Index');
    SQL.Add('WHERE a.Floating_Decoy_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Floating_Decoy_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TFloating_Decoy_On_Board.Create;

        with rec.FDef do
        begin
          Floating_Decoy_Index := FieldByName('Floating_Decoy_Index').AsInteger;
          Floating_Decoy_Identifier := FieldByName('Floating_Decoy_Identifier')
            .AsString;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
          Front_Visual_Cross := FieldByName('Front_Visual_Cross').AsSingle;
          Side_Visual_Cross := FieldByName('Side_Visual_Cross').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Lifetime_Duration := FieldByName('Lifetime_Duration').AsSingle;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFloatingDecoyDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Floating_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Floating_Decoy_Index = b.Floating_Decoy_Index');
    SQL.Add('WHERE Floating_Decoy_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.getFontByID(const id: Integer; var FontTaktis: TFontTaktis): Integer;
begin
  result := -1;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Font_Taktis ');
    SQL.Add('WHERE FONT_ID = ' + IntToStr(ID));
    Open;

    if not ZQ.IsEmpty then
    begin
      if not Assigned(FontTaktis) then
        FontTaktis := TFontTaktis.Create;

      with FontTaktis.FData do
      begin
        FONT_ID := FieldByName('FONT_ID').AsInteger;
        FONT_NAME := FieldByName('FONT_NAME').AsString;
        FONT_INDEX := FieldByName('FONT_INDEX').AsInteger;
        KETERANGAN := FieldByName('KETERANGAN').AsString;
      end;
    end;
  end;
end;

function TdmINWO.InsertFloatingDecoyDef(var aRec: TRecFloating_Decoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Floating_Decoy_Definition');
    SQL.Add('(Floating_Decoy_Identifier, Platform_Domain, Platform_Category,');
    SQL.Add('Platform_Type, Length, Width, Height, Front_Radar_Cross,');
    SQL.Add('Side_Radar_Cross, Front_Visual_Cross, Side_Visual_Cross,');
    SQL.Add('Front_Acoustic_Cross, Side_Acoustic_Cross, Lifetime_Duration)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Floating_Decoy_Identifier) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(FloatToStr(Length) + ', ');
      SQL.Add(FloatToStr(Width) + ', ');
      SQL.Add(FloatToStr(Height) + ', ');
      SQL.Add(FloatToStr(Front_Radar_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Radar_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Visual_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Visual_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Lifetime_Duration) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Floating_Decoy_Definition');
      SQL.Add('WHERE Floating_Decoy_Identifier = ' +
        QuotedStr(Floating_Decoy_Identifier));
      Open;

      Floating_Decoy_Index := FieldByName('Floating_Decoy_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateFloatingDecoyDef(var aRec: TRecFloating_Decoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Floating_Decoy_Definition');

    with aRec do
    begin
      SQL.Add('SET Floating_Decoy_Identifier = ' +
        QuotedStr(Floating_Decoy_Identifier));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Length = ' + FloatToStr(Length));
      SQL.Add(', Width = ' + FloatToStr(Width));
      SQL.Add(', Height = ' + FloatToStr(Height));
      SQL.Add(', Front_Radar_Cross = ' + FloatToStr(Front_Radar_Cross));
      SQL.Add(', Side_Radar_Cross = ' + FloatToStr(Side_Radar_Cross));
      SQL.Add(', Front_Visual_Cross = ' + FloatToStr(Front_Visual_Cross));
      SQL.Add(', Side_Visual_Cross = ' + FloatToStr(Side_Visual_Cross));
      SQL.Add(', Front_Acoustic_Cross = ' + FloatToStr(Front_Acoustic_Cross));
      SQL.Add(', Side_Acoustic_Cross = ' + FloatToStr(Side_Acoustic_Cross));
      SQL.Add(', Lifetime_Duration = ' + FloatToStr(Lifetime_Duration));
      SQL.Add('WHERE Floating_Decoy_Index = ' + IntToStr(Floating_Decoy_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteFloatingDecoyDef(const aFloatingDecoyIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE Floating_Decoy_Definition');
    SQL.Add('WHERE Floating_Decoy_Index = ' + IntToStr(aFloatingDecoyIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Towed Decoy '}

function TdmINWO.GetAllTowedDecoyDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TTowed_Decoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Towed_Jammer_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Towed_Decoy_Index = b.Towed_Decoy_Index');
    SQL.Add('ORDER BY a.Towed_Decoy_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TTowed_Decoy_On_Board.Create;

        with rec.FDef do
        begin
          Towed_Decoy_Index := FieldByName('Towed_Decoy_Index').AsInteger;
          Towed_Decoy_Identifier := FieldByName('Towed_Decoy_Identifier')
            .AsString;
          Decoy_TARH_Capable := FieldByName('Decoy_TARH_Capable').AsInteger;
          Decoy_SARH_Capable := FieldByName('Decoy_SARH_Capable').AsInteger;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
          Front_Visual_Cross := FieldByName('Front_Visual_Cross').AsSingle;
          Side_Visual_Cross := FieldByName('Side_Visual_Cross').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Type_A_Seducing_Prob := FieldByName('Type_A_Seducing_Prob').AsSingle;
          Type_B_Seducing_Prob := FieldByName('Type_B_Seducing_Prob').AsSingle;
          Type_C_Seducing_Prob := FieldByName('Type_C_Seducing_Prob').AsSingle;
          Activation_Control_Delay := FieldByName('Activation_Control_Delay')
            .AsSingle;
          Tow_Length := FieldByName('Tow_Length').AsSingle;
          ECM_Type := FieldByName('ECM_Type').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterTowedDecoyDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TTowed_Decoy_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Towed_Jammer_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Towed_Decoy_Index = b.Towed_Decoy_Index');
    SQL.Add('WHERE a.Towed_Decoy_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Towed_Decoy_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TTowed_Decoy_On_Board.Create;

        with rec.FDef do
        begin
          Towed_Decoy_Index := FieldByName('Towed_Decoy_Index').AsInteger;
          Towed_Decoy_Identifier := FieldByName('Towed_Decoy_Identifier')
            .AsString;
          Decoy_TARH_Capable := FieldByName('Decoy_TARH_Capable').AsInteger;
          Decoy_SARH_Capable := FieldByName('Decoy_SARH_Capable').AsInteger;
          Platform_Domain := FieldByName('Platform_Domain').AsInteger;
          Platform_Category := FieldByName('Platform_Category').AsInteger;
          Platform_Type := FieldByName('Platform_Type').AsInteger;
          Length := FieldByName('Length').AsSingle;
          Width := FieldByName('Width').AsSingle;
          Height := FieldByName('Height').AsSingle;
          Front_Radar_Cross := FieldByName('Front_Radar_Cross').AsSingle;
          Side_Radar_Cross := FieldByName('Side_Radar_Cross').AsSingle;
          Front_Visual_Cross := FieldByName('Front_Visual_Cross').AsSingle;
          Side_Visual_Cross := FieldByName('Side_Visual_Cross').AsSingle;
          Front_Acoustic_Cross := FieldByName('Front_Acoustic_Cross').AsSingle;
          Side_Acoustic_Cross := FieldByName('Side_Acoustic_Cross').AsSingle;
          Type_A_Seducing_Prob := FieldByName('Type_A_Seducing_Prob').AsSingle;
          Type_B_Seducing_Prob := FieldByName('Type_B_Seducing_Prob').AsSingle;
          Type_C_Seducing_Prob := FieldByName('Type_C_Seducing_Prob').AsSingle;
          Activation_Control_Delay := FieldByName('Activation_Control_Delay')
            .AsSingle;
          Tow_Length := FieldByName('Tow_Length').AsSingle;
          ECM_Type := FieldByName('ECM_Type').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetTowedDecoyDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Towed_Jammer_Decoy_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Towed_Decoy_Index = b.Towed_Decoy_Index');
    SQL.Add('WHERE Towed_Decoy_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertTowedDecoyDef(var aRec: TRecTowed_Decoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Towed_Jammer_Decoy_Definition');
    SQL.Add('(Towed_Decoy_Identifier, Decoy_TARH_Capable, Decoy_SARH_Capable,');
    SQL.Add('Platform_Domain, Platform_Category, Platform_Type, Length,');
    SQL.Add('Width, Height, Front_Radar_Cross, Side_Radar_Cross,');
    SQL.Add('Front_Visual_Cross, Side_Visual_Cross, Front_Acoustic_Cross,');
    SQL.Add('Side_Acoustic_Cross, Type_A_Seducing_Prob, Type_B_Seducing_Prob,');
    SQL.Add('Type_C_Seducing_Prob, Activation_Control_Delay,');
    SQL.Add('Tow_Length,ECM_Type)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Towed_Decoy_Identifier) + ', ');
      SQL.Add(IntToStr(Decoy_TARH_Capable) + ', ');
      SQL.Add(IntToStr(Decoy_SARH_Capable) + ', ');
      SQL.Add(IntToStr(Platform_Domain) + ', ');
      SQL.Add(IntToStr(Platform_Category) + ', ');
      SQL.Add(IntToStr(Platform_Type) + ', ');
      SQL.Add(FloatToStr(Length) + ', ');
      SQL.Add(FloatToStr(Width) + ', ');
      SQL.Add(FloatToStr(Height) + ', ');
      SQL.Add(FloatToStr(Front_Radar_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Radar_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Visual_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Visual_Cross) + ', ');
      SQL.Add(FloatToStr(Front_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Side_Acoustic_Cross) + ', ');
      SQL.Add(FloatToStr(Type_A_Seducing_Prob) + ', ');
      SQL.Add(FloatToStr(Type_B_Seducing_Prob) + ', ');
      SQL.Add(FloatToStr(Type_C_Seducing_Prob) + ', ');
      SQL.Add(FloatToStr(Activation_Control_Delay) + ', ');
      SQL.Add(FloatToStr(Tow_Length) + ', ');
      SQL.Add(IntToStr(ECM_Type) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Towed_Jammer_Decoy_Definition');
      SQL.Add('WHERE Towed_Decoy_Identifier = ' +
        QuotedStr(Towed_Decoy_Identifier));
      Open;

      Towed_Decoy_Index := FieldByName('Towed_Decoy_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateTowedDecoyDef(var aRec: TRecTowed_Decoy_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Towed_Jammer_Decoy_Definition');

    with aRec do
    begin
      SQL.Add('SET Towed_Decoy_Identifier = ' +
        QuotedStr(Towed_Decoy_Identifier));
      SQL.Add(', Decoy_TARH_Capable = ' + IntToStr(Decoy_TARH_Capable));
      SQL.Add(', Decoy_SARH_Capable = ' + IntToStr(Decoy_SARH_Capable));
      SQL.Add(', Platform_Domain = ' + IntToStr(Platform_Domain));
      SQL.Add(', Platform_Category = ' + IntToStr(Platform_Category));
      SQL.Add(', Platform_Type = ' + IntToStr(Platform_Type));
      SQL.Add(', Length = ' + FloatToStr(Length));
      SQL.Add(', Width = ' + FloatToStr(Width));
      SQL.Add(', Height = ' + FloatToStr(Height));
      SQL.Add(', Front_Radar_Cross = ' + FloatToStr(Front_Radar_Cross));
      SQL.Add(', Side_Radar_Cross = ' + FloatToStr(Side_Radar_Cross));
      SQL.Add(', Front_Visual_Cross = ' + FloatToStr(Front_Visual_Cross));
      SQL.Add(', Side_Visual_Cross = ' + FloatToStr(Side_Visual_Cross));
      SQL.Add(', Front_Acoustic_Cross = ' + FloatToStr(Front_Acoustic_Cross));
      SQL.Add(', Side_Acoustic_Cross = ' + FloatToStr(Side_Acoustic_Cross));
      SQL.Add(', Type_A_Seducing_Prob = ' + FloatToStr(Type_A_Seducing_Prob));
      SQL.Add(', Type_B_Seducing_Prob = ' + FloatToStr(Type_B_Seducing_Prob));
      SQL.Add(', Type_C_Seducing_Prob = ' + FloatToStr(Type_C_Seducing_Prob));
      SQL.Add(', Activation_Control_Delay = ' +
        FloatToStr(Activation_Control_Delay));
      SQL.Add(', Tow_Length = ' + FloatToStr(Tow_Length));
      SQL.Add(', ECM_Type = ' + IntToStr(ECM_Type));
      SQL.Add('WHERE Towed_Decoy_Index = ' + IntToStr(Towed_Decoy_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteTowedDecoyDef(const aTowedJammerIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE Towed_Jammer_Decoy_Definition');
    SQL.Add('WHERE Towed_Decoy_Index = ' + IntToStr(aTowedJammerIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Self Defensive Jammer '}

function TdmINWO.GetAllSelfDefensiveJammerDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TDefensive_Jammer_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Defensive_Jammer_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Defensive_Jammer_Index = b.Defensive_Jammer_Index');
    SQL.Add('ORDER BY a.Defensive_Jammer_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TDefensive_Jammer_On_Board.Create;

        with rec.FDef do
        begin
          Defensive_Jammer_Index := FieldByName('Defensive_Jammer_Index')
            .AsInteger;
          Defensive_Jammer_Identifier := FieldByName
            ('Defensive_Jammer_Identifier').AsString;
          Jammer_TARH_Capable := FieldByName('Jammer_TARH_Capable').AsInteger;
          Jammer_SARH_Capable := FieldByName('Jammer_SARH_Capable').AsInteger;
          Type_A_Seducing_Prob := FieldByName('Type_A_Seducing_Prob').AsSingle;
          Type_B_Seducing_Prob := FieldByName('Type_B_Seducing_Prob').AsSingle;
          Type_C_Seducing_Prob := FieldByName('Type_C_Seducing_Prob').AsSingle;
          ECM_Type := FieldByName('ECM_Type').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterSelfDefensiveJammerDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TDefensive_Jammer_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Defensive_Jammer_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Defensive_Jammer_Index = b.Defensive_Jammer_Index');
    SQL.Add('WHERE a.Defensive_Jammer_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY a.Defensive_Jammer_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TDefensive_Jammer_On_Board.Create;

        with rec.FDef do
        begin
          Defensive_Jammer_Index := FieldByName('Defensive_Jammer_Index')
            .AsInteger;
          Defensive_Jammer_Identifier := FieldByName
            ('Defensive_Jammer_Identifier').AsString;
          Jammer_TARH_Capable := FieldByName('Jammer_TARH_Capable').AsInteger;
          Jammer_SARH_Capable := FieldByName('Jammer_SARH_Capable').AsInteger;
          Type_A_Seducing_Prob := FieldByName('Type_A_Seducing_Prob').AsSingle;
          Type_B_Seducing_Prob := FieldByName('Type_B_Seducing_Prob').AsSingle;
          Type_C_Seducing_Prob := FieldByName('Type_C_Seducing_Prob').AsSingle;
          ECM_Type := FieldByName('ECM_Type').AsInteger;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.getFilterSimbol(const aSrch: string; const FontType: Byte; var FontTaktisList: TList): integer;
var select,from,where,group : string;
rec: TFontTaktis;
begin
  result := -1;
  if not ZConn.Connected then
    exit;

 with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Font_Taktis ');

    if FontType = 0 then
      SQL.Add('WHERE FONT_ID >= 221 and FONT_ID <= 404')
    else if FontType = 1 then
      SQL.Add('WHERE FONT_ID >= 10 and FONT_ID <= 220')
    else if FontType = 2 then
      SQL.Add('WHERE FONT_ID >= 405 and FONT_ID <= 539');

    SQL.Add('AND KETERANGAN LIKE' + QuotedStr('%' + aSrch + '%'));
    SQL.Add('order by FONT_ID');
    Open;

    SQL.Add(select);
    Open;
    result := RecordCount;
    if not IsEmpty then
    begin
      First;
      if not Assigned(FontTaktisList) then
        FontTaktisList := TList.Create;
    end;

    while not ZQ.Eof do
    begin
      rec := TFontTaktis.Create;
      with rec.FData do
      begin
        FONT_ID := FieldByName('FONT_ID').AsInteger;
        FONT_NAME := FieldByName('FONT_NAME').AsString;
        FONT_INDEX := FieldByName('FONT_INDEX').AsInteger;
        KETERANGAN := FieldByName('KETERANGAN').AsString;

      end;

      FontTaktisList.Add(rec);
      ZQ.Next;
    end;
    end;
  end;

function TdmINWO.GetSelfDefensiveJammerDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Defensive_Jammer_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Defensive_Jammer_Index = b.Defensive_Jammer_Index');
    SQL.Add('WHERE Defensive_Jammer_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertSelfDefensiveJammerDef(var aRec: TRecDefensive_Jammer_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Defensive_Jammer_Definition');
    SQL.Add('(Defensive_Jammer_Identifier, Jammer_TARH_Capable,');
    SQL.Add('Jammer_SARH_Capable, Type_A_Seducing_Prob, Type_B_Seducing_Prob,');
    SQL.Add('Type_C_Seducing_Prob, ECM_Type)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Defensive_Jammer_Identifier) + ', ');
      SQL.Add(IntToStr(Jammer_TARH_Capable) + ', ');
      SQL.Add(IntToStr(Jammer_SARH_Capable) + ', ');
      SQL.Add(FloatToStr(Type_A_Seducing_Prob) + ', ');
      SQL.Add(FloatToStr(Type_B_Seducing_Prob) + ', ');
      SQL.Add(FloatToStr(Type_C_Seducing_Prob) + ', ');
      SQL.Add(IntToStr(ECM_Type) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Defensive_Jammer_Definition');
      SQL.Add('WHERE Defensive_Jammer_Identifier = ' +
        QuotedStr(Defensive_Jammer_Identifier));
      Open;

      Defensive_Jammer_Index := FieldByName('Defensive_Jammer_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateSelfDefensiveJammerDef(var aRec: TRecDefensive_Jammer_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Defensive_Jammer_Definition');

    with aRec do
    begin
      SQL.Add('SET Defensive_Jammer_Identifier = ' +
        QuotedStr(Defensive_Jammer_Identifier));
      SQL.Add(', Jammer_TARH_Capable = ' + IntToStr(Jammer_TARH_Capable));
      SQL.Add(', Jammer_SARH_Capable = ' + IntToStr(Jammer_SARH_Capable));
      SQL.Add(', Type_A_Seducing_Prob = ' + FloatToStr(Type_A_Seducing_Prob));
      SQL.Add(', Type_B_Seducing_Prob = ' + FloatToStr(Type_B_Seducing_Prob));
      SQL.Add(', Type_C_Seducing_Prob = ' + FloatToStr(Type_C_Seducing_Prob));
      SQL.Add(', ECM_Type = ' + IntToStr(ECM_Type));
      SQL.Add('WHERE Defensive_Jammer_Index = ' +
        IntToStr(Defensive_Jammer_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteSelfDefensiveJammerDef(const aSelfDefensiveJammerIndex: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE Defensive_Jammer_Definition');
    SQL.Add('WHERE Defensive_Jammer_Index = ' +
      IntToStr(aSelfDefensiveJammerIndex));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Radar Noise Jammer '}

function TdmINWO.GetAllRadarNoiseJammerDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TRadar_Noise_Jammer_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Jammer_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Jammer_Index = b.Jammer_Index');
    SQL.Add('ORDER BY Jammer_Identifier ');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TRadar_Noise_Jammer_On_Board.Create;

        with rec.FDef do
        begin
          Jammer_Index := FieldByName('Jammer_Index').AsInteger;
          Jammer_Type := FieldByName('Jammer_Type').AsInteger;
          Jammer_Identifier := FieldByName('Jammer_Identifier').AsString;
          Lower_Freq_Limit := FieldByName('Lower_Freq_Limit').AsFloat;
          Upper_Freq_Limit := FieldByName('Upper_Freq_Limit').AsFloat;
          Jammer_Power_Density := FieldByName('Jammer_Power_Density').AsFloat;
          Max_Effective_Range := FieldByName('Max_Effective_Range').AsFloat;
          Max_Sector_Width := FieldByName('Max_Sector_Width').AsFloat;
          Upper_Vert_Coverage_Angle := FieldByName('Upper_Vert_Coverage_Angle')
            .AsFloat;
          Lower_Vert_Coverage_Angle := FieldByName('Lower_Vert_Coverage_Angle')
            .AsFloat;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFilterRadarNoiseJammerDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TRadar_Noise_Jammer_On_Board;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Jammer_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Jammer_Index = b.Jammer_Index');
    SQL.Add('WHERE Jammer_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Jammer_Identifier ');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TRadar_Noise_Jammer_On_Board.Create;

        with rec.FDef do
        begin
          Jammer_Index := FieldByName('Jammer_Index').AsInteger;
          Jammer_Type := FieldByName('Jammer_Type').AsInteger;
          Jammer_Identifier := FieldByName('Jammer_Identifier').AsString;
          Lower_Freq_Limit := FieldByName('Lower_Freq_Limit').AsFloat;
          Upper_Freq_Limit := FieldByName('Upper_Freq_Limit').AsFloat;
          Jammer_Power_Density := FieldByName('Jammer_Power_Density').AsFloat;
          Max_Effective_Range := FieldByName('Max_Effective_Range').AsFloat;
          Max_Sector_Width := FieldByName('Max_Sector_Width').AsFloat;
          Upper_Vert_Coverage_Angle := FieldByName('Upper_Vert_Coverage_Angle')
            .AsFloat;
          Lower_Vert_Coverage_Angle := FieldByName('Lower_Vert_Coverage_Angle')
            .AsFloat;
        end;

        with rec.FNote do
        begin
          Note_Index := FieldByName('Note_Index').AsInteger;
          Note_Type := FieldByName('Note_Type').AsInteger;
          Notes := FieldByName('Notes').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetRadarNoiseJammerDef(const aClassName: string): Integer;
begin
  Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Jammer_Definition a LEFT JOIN Note_Storage b');
    SQL.Add('ON a.Jammer_Index = b.Jammer_Index');
    SQL.Add('WHERE Jammer_Identifier LIKE ' + QuotedStr(aClassName));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.InsertRadarNoiseJammerDef(var aRec: TRecRadar_Noise_Jammer_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Jammer_Definition');
    SQL.Add('(Jammer_Type, Jammer_Identifier, Lower_Freq_Limit,');
    SQL.Add('Upper_Freq_Limit, Jammer_Power_Density, Max_Effective_Range,');
    SQL.Add('Max_Sector_Width, Upper_Vert_Coverage_Angle,');
    SQL.Add('Lower_Vert_Coverage_Angle)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(IntToStr(Jammer_Type) + ', ');
      SQL.Add(QuotedStr(Jammer_Identifier) + ', ');
      SQL.Add(FloatToStr(Lower_Freq_Limit) + ', ');
      SQL.Add(FloatToStr(Upper_Freq_Limit) + ', ');
      SQL.Add(FloatToStr(Jammer_Power_Density) + ', ');
      SQL.Add(FloatToStr(Max_Effective_Range) + ', ');
      SQL.Add(FloatToStr(Max_Sector_Width) + ', ');
      SQL.Add(FloatToStr(Upper_Vert_Coverage_Angle) + ', ');
      SQL.Add(FloatToStr(Lower_Vert_Coverage_Angle) + ')');
      ExecSQL;

      Result := True;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Jammer_Definition');
      SQL.Add('WHERE Jammer_Identifier = ' + QuotedStr(Jammer_Identifier));
      Open;

      Jammer_Index := FieldByName('Jammer_Index').AsInteger;
    end;
  end;
end;

function TdmINWO.UpdateRadarNoiseJammerDef(var aRec: TRecRadar_Noise_Jammer_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Jammer_Definition');

    with aRec do
    begin
      SQL.Add('SET Jammer_Identifier = ' + QuotedStr(Jammer_Identifier));
      SQL.Add(', Jammer_Type = ' + IntToStr(Jammer_Type));
      SQL.Add(', Lower_Freq_Limit = ' + FloatToStr(Lower_Freq_Limit));
      SQL.Add(', Upper_Freq_Limit = ' + FloatToStr(Upper_Freq_Limit));
      SQL.Add(', Jammer_Power_Density = ' + FloatToStr(Jammer_Power_Density));
      SQL.Add(', Max_Effective_Range = ' + FloatToStr(Max_Effective_Range));
      SQL.Add(', Max_Sector_Width = ' + FloatToStr(Max_Sector_Width));
      SQL.Add(', Upper_Vert_Coverage_Angle = ' +
        FloatToStr(Upper_Vert_Coverage_Angle));
      SQL.Add(', Lower_Vert_Coverage_Angle = ' +
        FloatToStr(Lower_Vert_Coverage_Angle));
      SQL.Add('WHERE Jammer_Index = ' + IntToStr(Jammer_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteRadarNoiseJammerDef(const aRadarNoiseJammer: Integer): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;

    SQL.Clear;
    SQL.Add('DELETE Jammer_Definition');
    SQL.Add('WHERE Jammer_Index = ' + IntToStr(aRadarNoiseJammer));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$ENDREGION}

{$ENDREGION}

{$REGION ' Peta '}

function TdmINWO.GetFilterGameAreaDef(var aList: TList; aFilter: String): Integer;
var
  i : Integer;
  rec : TGame_Area_Definition;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Game_Area_Definition');
    SQL.Add('WHERE Game_Area_Identifier like '  + quotedStr('%' + aFilter + '%'));
    SQL.Add('ORDER BY Game_Area_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TGame_Area_Definition.Create;

        with rec.FData do
        begin
          Game_Area_Index := FieldByName('Game_Area_Index').AsInteger;
          Game_Area_Identifier := FieldByName('Game_Area_Identifier').AsString;
          Game_Centre_Lat := FieldByName('Game_Centre_Lat').AsFloat;
          Game_Centre_Long := FieldByName('Game_Centre_Long').AsFloat;
          Game_X_Dimension := FieldByName('Game_X_Dimension').AsFloat;
          Game_Y_Dimension := FieldByName('Game_Y_Dimension').AsFloat;
          Use_Real_World := FieldByName('Use_Real_World').AsInteger;
          Use_Artificial_Landmass := FieldByName('Use_Artificial_Landmass')
            .AsInteger;
          Detail_Map := FieldByName('Detail_Map').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAllGameAreaDef(var aList: TList): Integer;
var
  i : Integer;
  rec : TGame_Area_Definition;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Game_Area_Definition');
    SQL.Add('ORDER BY Game_Area_Identifier');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        rec := aList.Items[i];
        rec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TGame_Area_Definition.Create;

        with rec.FData do
        begin
          Game_Area_Index := FieldByName('Game_Area_Index').AsInteger;
          Game_Area_Identifier := FieldByName('Game_Area_Identifier').AsString;
          Game_Centre_Lat := FieldByName('Game_Centre_Lat').AsFloat;
          Game_Centre_Long := FieldByName('Game_Centre_Long').AsFloat;
          Game_X_Dimension := FieldByName('Game_X_Dimension').AsFloat;
          Game_Y_Dimension := FieldByName('Game_Y_Dimension').AsFloat;
          Use_Real_World := FieldByName('Use_Real_World').AsInteger;
          Use_Artificial_Landmass := FieldByName('Use_Artificial_Landmass')
            .AsInteger;
          Detail_Map := FieldByName('Detail_Map').AsString;
        end;

        aList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetGameAreaDef(const aAreaIdentifier: string): Integer;
begin
 Result := 0;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Game_Area_Definition');
    SQL.Add('WHERE Game_Area_Identifier = ' +
      QuotedStr(aAreaIdentifier));
    Open;

    Result := RecordCount;
  end;
end;

function TdmINWO.GetGameAreaDef(const aGameAreaID: Integer; var aResult: TRecGame_Area_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *');
    SQL.Add('FROM Game_Area_Definition');
    SQL.Add('WHERE Game_Area_Index = ' + IntToStr(aGameAreaID));
    Open;

    Result := RecordCount > 0;

    if not IsEmpty then
    begin
      First;

//      aResult := TGame_Area_Definition.Create;
      with aResult do
      begin
        Game_Area_Index := FieldByName('Game_Area_Index').AsInteger;
        Game_Area_Identifier := FieldByName('Game_Area_Identifier').AsString;
        Game_Centre_Lat := FieldByName('Game_Centre_Lat').AsFloat;
        Game_Centre_Long := FieldByName('Game_Centre_Long').AsFloat;
        Game_X_Dimension := FieldByName('Game_X_Dimension').AsFloat;
        Game_Y_Dimension := FieldByName('Game_Y_Dimension').AsFloat;
        Use_Real_World := FieldByName('Use_Real_World').AsInteger;
        Use_Artificial_Landmass := FieldByName('Use_Artificial_Landmass').AsInteger;
        Detail_Map := FieldByName('Detail_Map').AsString;
      end;
    end;
  end;
end;

function TdmINWO.InsertGameAreaDef(var aRec: TRecGame_Area_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Game_Area_Definition');
    SQL.Add('(Game_Area_Identifier, Game_Centre_Lat, Game_Centre_Long,');
    SQL.Add('Game_X_Dimension, Game_Y_Dimension, Use_Real_World,');
    SQL.Add('Use_Artificial_Landmass, Detail_Map)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(QuotedStr(Game_Area_Identifier) + ', ');
      SQL.Add(FloatToStr(Game_Centre_Lat) + ', ');
      SQL.Add(FloatToStr(Game_Centre_Long) + ', ');
      SQL.Add(FloatToStr(Game_X_Dimension) + ', ');
      SQL.Add(FloatToStr(Game_Y_Dimension) + ', ');
      SQL.Add(IntToStr(Use_Real_World) + ', ');
      SQL.Add(IntToStr(Use_Artificial_Landmass) + ', ');
      SQL.Add(QuotedStr(Detail_Map) + ')');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SELECT *');
      SQL.Add('FROM Game_Area_Definition');
      SQL.Add('WHERE Game_Area_Identifier = ' +
        QuotedStr(Game_Area_Identifier));
      Open;

      Result := RecordCount > 0;

      if not IsEmpty then
      begin
        First;

        Game_Area_Index := FieldByName('Game_Area_Index').AsInteger;
      end;
    end;
  end;
end;

function TdmINWO.UpdateGameAreaDef(var aRec: TRecGame_Area_Definition): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Game_Area_Definition');

    with aRec do
    begin
      SQL.Add('SET Game_Area_Identifier = ' + QuotedStr(Game_Area_Identifier));
      SQL.Add(', Game_Centre_Lat = ' + FloatToStr(Game_Centre_Lat));
      SQL.Add(', Game_Centre_Long = ' + FloatToStr(Game_Centre_Long));
      SQL.Add(', Game_X_Dimension = ' + FloatToStr(Game_X_Dimension));
      SQL.Add(', Game_Y_Dimension = ' + FloatToStr(Game_Y_Dimension));
      SQL.Add(', Use_Real_World = ' + IntToStr(Use_Real_World));
      SQL.Add(', Use_Artificial_Landmass = ' +
        IntToStr(Use_Artificial_Landmass));
      SQL.Add(', Detail_Map = ' + QuotedStr(Detail_Map));
      SQL.Add('WHERE Game_Area_Index = ' + IntToStr(Game_Area_Index));
    end;

    ExecSQL;

    Result := True;
  end;
end;

function TdmINWO.DeleteGameAreaDef(const aGameAreaID: Integer): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE Game_Area_Definition');
    SQL.Add('WHERE Game_Area_Index = ' + IntToStr(aGameAreaID));
    ExecSQL;

    Result := True;
  end;
end;

{$ENDREGION}

{$REGION ' Tactical Symbol '}

function TdmINWO.GetAllTacticalSymbol(var aList: TList): Integer;
var
  i : Integer;
  aRec : TTactical_Symbol;
begin
  Result := -1;

  if not ZConn.Connected then
    Exit;
  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Simbol_Taktis');
    Open;

    Result := RecordCount;

    if Assigned(aList) then
    begin
      for i  := 0 to aList.Count -1 do
      begin
        aRec := aList.Items[i];
        aRec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        aRec := TTactical_Symbol.Create;

        with aRec.FData do
        begin
          Id_Tactical_Symbol := FieldByName('ID_Simbol').AsInteger;
          Tipe               := FieldByName('Tipe').AsInteger;
          Kategori           := FieldByName('Kategori').AsInteger;
          Keterangan         := FieldByName('Keterangan').AsString;
          Path_Directori     := FieldByName('Directory_Path').AsString;
        end;

        aList.Add(aRec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetSearchTacticalSymbol(var FilterIndex: Integer; SearchContent: string; aList:TList): Integer;
var
  i : Integer;
  aRec : TTactical_Symbol;
begin
   Result := -1;

   if not ZConn.Connected then
      Exit;

  with ZQ do
  begin
     Close;
     SQL.Clear;
     SQL.Add('SELECT * FROM Simbol_Taktis');
     if FilterIndex = 1 then
        SQL.Add('WHERE ID_Simbol = ' + IntToStr(StrToIntDef(SearchContent, 0)))
     else if FilterIndex = 2 then
        SQL.Add('WHERE Tipe = ' + IntToStr(StrToIntDef(SearchContent, 0)))
     else if FilterIndex = 3 then
        SQL.Add('WHERE Kategori like ' + quotedStr('%' + SearchContent + '%'))
     else if FilterIndex = 4 then
        SQL.Add('WHERE Keterangan = ' + quotedStr(SearchContent));

     Open;

     Result := RecordCount;

    if Assigned(aList) then
    begin
      for i := 0 to aList.Count - 1 do
      begin
        aRec := aList.Items[i];
        aRec.Free;
      end;

      aList.Clear;
    end
    else
      aList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        aRec := TTactical_Symbol.Create;

        with aRec.FData do
        begin
          Id_Tactical_Symbol := FieldByName('ID_Simbol').AsInteger;
          Tipe               := FieldByName('Tipe').AsInteger;
          Kategori           := FieldByName('Kategori').AsInteger;
          Keterangan         := FieldByName('Keterangan').AsString;
          Path_Directori     := FieldByName('Directory_Path').AsString;
        end;

        aList.Add(aRec);
        Next;
      end;
     end;
  end;
end;

function TdmINWO.GetFilterByTactical(var aRec: TRecTactical_Symbol): Integer;
begin
   Result := -1;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Simbol_Taktis');
    SQL.Add('WHERE (Tipe = ' + IntToStr(aRec.Tipe) + ') and ' +
        '(ID_Simbol = ' + IntToStr(aRec.Id_Tactical_Symbol) + ') and ' +
        '(Kategori = ' + IntToStr(aRec.Kategori) + ') and ' +
        '(Keterangan = ' + QuotedStr(aRec.Keterangan) + ') and ' +
        '(Directory_Path = ' + QuotedStr(aRec.Path_Directori) + ')');

    Open;

    Result := RecordCount;
  end;
end;


function TdmINWO.InsertTacticalSymbol(var aRec: TRecTactical_Symbol): Boolean;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;

    SQL.Clear;

    SQL.Add('INSERT INTO Simbol_Taktis');
    SQL.Add('(Tipe, Kategori, Keterangan, Directory_Path)');
    SQL.Add('VALUES (');

    with aRec do
    begin
      SQL.Add(IntToStr(Tipe) + ',');
      SQL.Add(IntToStr(Kategori) + ',');
      SQL.Add(QuotedStr(Keterangan) + ',');
      SQL.Add(QuotedStr(Path_Directori) + ')');
    end;
    ExecSQL;

 //   Result := True;

    SQL.Clear;
    SQL.Add('SELECT * FROM Simbol_Taktis');
    SQL.Add('WHERE (Tipe = ' + IntToStr(aRec.Tipe) + ') and ' +
        '(Kategori = ' + IntToStr(aRec.Kategori) + ') and ' +
        '(Keterangan = ' + QuotedStr(aRec.Keterangan) + ') and ' +
        '(Directory_Path = ' + QuotedStr(aRec.Path_Directori) + ')');
    Open;

    Result := RecordCount > 0;

    aRec.Id_Tactical_Symbol := FieldByName('ID_Simbol').AsInteger;
  end;
end;

function TdmINWO.UpdateTacticalSymbol(var aRec: TRecTactical_Symbol): Boolean;
begin
  if not ZConn.Connected then
  Exit;

  with ZQ do
  begin
    with aRec do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE Simbol_Taktis');
      SQL.Add('SET');
      SQL.Add('Tipe=' + IntToStr(aRec.Tipe) + ',');
      SQL.Add('Kategori=' + IntToStr(aRec.Kategori) + ',');
      SQL.Add('Keterangan=' + QuotedStr(aRec.Keterangan) + ',');
      SQL.Add('Directory_Path=' + QuotedStr(aRec.Path_Directori));
      SQL.Add('WHERE (ID_Simbol=' + IntToStr(aRec.Id_Tactical_Symbol) + ')');
      ExecSQL;
    end;
    Result := True;
  end;
end;

function TdmINWO.DeleteTacticalSymbol(const aTacticalSymbolID: Integer): Boolean;
begin
   if not ZConn.Connected then
   Exit;

   with ZQ do
   begin
     Close;
     SQL.Add('DELETE FROM Simbol_Taktis');
     SQL.Add('WHERE(ID_Simbol=' + QuotedStr(IntToStr(aTacticalSymbolID))+')');
     ExecSQL;
     Result := True;
   end;
end;

{$ENDREGION}

{$REGION ' Additional Section '}

{$REGION ' Note Storage '}

function TdmINWO.InsertNoteStorage(const aOwnerType: Byte; const aOwnerIndex: Integer; var aRec: TRecNote_Storage): Boolean;
begin
  result := False;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO Note_Storage');
    SQL.Add('(Note_Type, Notes,');

    with aRec do
    begin
      case TStorageType(aOwnerType) of
        stVehicle           : SQL.Add('Vehicle_Index)');
        stMissile           : SQL.Add('Missile_Index)');
        stTorpedo           : SQL.Add('Torpedo_Index)');
        stGun               : SQL.Add('Gun_Index)');
        stBomb              : SQL.Add('Bomb_Index)');
        stMine              : SQL.Add('Mine_Index)');
        stRadar             : SQL.Add('Radar_Index)');
        stSonar             : SQL.Add('Sonar_Index )');
        stEsm               : SQL.Add('ESM_Index )');
        stMad               : SQL.Add('MAD_Index)');
        stEod               : SQL.Add('EOD_Index)');
        stSonobuoy          : SQL.Add('Sonobuoy_Index)');
        stChaff             : SQL.Add('Chaff_Index)');
        stAirBubble         : SQL.Add('Air_Bubble_Index)');
        stAcousticDecoy     : SQL.Add('Acoustic_Decoy_Index)');
        stInfraredDecoy     : SQL.Add('Infrared_Decoy_Index)');
        stFloatingDecoy     : SQL.Add('Floating_Decoy_Index)');
        stTowedDecoy        : SQL.Add('Towed_Decoy_Index)');
        stDefensiveJammer   : SQL.Add('Defensive_Jammer_Index )');
        stRadarNoiseJammer  : SQL.Add('Radar_Noise_Jammer_Index )');
      end;

      SQL.Add('VALUES (');
      SQL.Add(IntToStr(aOwnerType) + ', ');
      SQL.Add(QuotedStr(Notes) + ', ');
      SQL.Add(IntToStr(aOwnerIndex) + ')');
      ExecSQL;
    end;
  end;
end;

function TdmINWO.UpdateNoteStorage(const aOwnerIndex: Integer; var aRec: TRecNote_Storage): Boolean;
begin
  Result := False;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE Note_Storage');

    with aRec do
    begin
      SQL.Add('SET Notes = ' + QuotedStr(Notes));
      SQL.Add('WHERE Note_Type = ' + IntToStr(Note_Type));

      case TStorageType(Note_Type) of
        stVehicle           : SQL.Add('AND Vehicle_Index = ' + IntToStr(aOwnerIndex));
        stMissile           : SQL.Add('AND Missile_Index = ' + IntToStr(aOwnerIndex));
        stTorpedo           : SQL.Add('AND Torpedo_Index = ' + IntToStr(aOwnerIndex));
        stGun               : SQL.Add('AND Gun_Index = ' + IntToStr(aOwnerIndex));
        stBomb              : SQL.Add('AND Bomb_Index = ' + IntToStr(aOwnerIndex));
        stMine              : SQL.Add('AND Mine_Index = ' + IntToStr(aOwnerIndex));
        stRadar             : SQL.Add('AND Radar_Index = ' + IntToStr(aOwnerIndex));
        stSonar             : SQL.Add('AND Sonar_Index = ' + IntToStr(aOwnerIndex));
        stEsm               : SQL.Add('AND ESM_Index = ' + IntToStr(aOwnerIndex));
        stMad               : SQL.Add('AND MAD_Index = ' + IntToStr(aOwnerIndex));
        stEod               : SQL.Add('AND EOD_Index = ' + IntToStr(aOwnerIndex));
        stSonobuoy          : SQL.Add('AND Sonobuoy_Index = ' + IntToStr(aOwnerIndex));
        stChaff             : SQL.Add('AND Chaff_Index = ' + IntToStr(aOwnerIndex));
        stAirBubble         : SQL.Add('AND Air_Bubble_Index = ' + IntToStr(aOwnerIndex));
        stAcousticDecoy     : SQL.Add('AND Acoustic_Decoy_Index = ' + IntToStr(aOwnerIndex));
        stInfraredDecoy     : SQL.Add('AND Infrared_decoy_Index = ' + IntToStr(aOwnerIndex));
        stFloatingDecoy     : SQL.Add('AND Floating_Decoy_Index = ' + IntToStr(aOwnerIndex));
        stTowedDecoy        : SQL.Add('AND Towed_Decoy_Index = ' + IntToStr(aOwnerIndex));
        stDefensiveJammer   : SQL.Add('AND Defensive_Jammer_Index = ' + IntToStr(aOwnerIndex));
        stRadarNoiseJammer  : SQL.Add('AND Radar_Noise_Jammer_Index = ' + IntToStr(aOwnerIndex));
      end;
    end;

    ExecSQL;
  end;
end;

function TdmINWO.DeleteNoteStorage(const aOwnerType: Integer; const aOwnerIndex: Integer): Integer;
begin
  result := -1;
  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM Note_Storage ');
    SQL.Add('WHERE (');

    case TStorageType(aOwnerType) of
      stVehicle           : SQL.Add('Vehicle_Index)');
      stMissile           : SQL.Add('Missile_Index)');
      stTorpedo           : SQL.Add('Torpedo_Index)');
      stGun               : SQL.Add('Gun_Index)');
      stBomb              : SQL.Add('Bomb_Index)');
      stMine              : SQL.Add('Mine_Index)');
      stRadar             : SQL.Add('Radar_Index)');
      stSonar             : SQL.Add('Sonar_Index )');
      stEsm               : SQL.Add('ESM_Index )');
      stMad               : SQL.Add('MAD_Index)');
      stEod               : SQL.Add('EOD_Index)');
      stSonobuoy          : SQL.Add('Sonobuoy_Index)');
      stChaff             : SQL.Add('Chaff_Index)');
      stAirBubble         : SQL.Add('Air_Bubble_Index)');
      stAcousticDecoy     : SQL.Add('Acoustic_Decoy_Index)');
      stInfraredDecoy     : SQL.Add('Infrared_Decoy_Index)');
      stFloatingDecoy     : SQL.Add('Floating_Decoy_Index)');
      stTowedDecoy        : SQL.Add('Towed_Decoy_Index)');
      stDefensiveJammer   : SQL.Add('Defensive_Jammer_Index )');
      stRadarNoiseJammer  : SQL.Add('Radar_Noise_Jammer_Index )');
    end;
    SQL.Add(' = ' + IntToStr(aOwnerIndex) + ')');
    ExecSQL;
  end;
end;

{$ENDREGION}

{$REGION ' Usage '}

{$REGION ' Usage Platform '}

//function TdmINWO.GetMotionCharacteristicAtMissileDef(const id: Integer; var pList: TList): boolean;
//var
//  i : Integer;
//  rec: TMissile_On_Board;
//
//begin
//  result := false;
//
//  if not ZConn.Connected then
//    exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add( 'SELECT * ');
//    SQL.Add( 'FROM Missile_Definition ');
//    SQL.Add( 'WHERE Motion_Index = ' + IntToStr(id));
//    Open;
//
//    result := RecordCount > 0;
//
//    if Assigned(pList) then
//    begin
//      for i := 0 to pList.Count - 1 do
//      begin
//        rec := pList.Items[i];
//        rec.Free;
//      end;
//
//      pList.Clear;
//    end
//    else
//      pList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TMissile_On_Board.Create;
//
//        with rec.FDef do
//        begin
//          Class_Identifier := FieldByName('Class_Identifier').AsString;
//        end;
//
//        pList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;
//
//function TdmINWO.GetMotionCharacteristicAtTorpedoDef(const id: Integer; var pList: TList): boolean;
//var
//  i : Integer;
//  rec: TTorpedo_On_Board;
//
//begin
//  result := false;
//
//  if not ZConn.Connected then
//    exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add( 'SELECT * ');
//    SQL.Add( 'FROM Torpedo_Definition ');
//    SQL.Add( 'WHERE Motion_Index = ' + IntToStr(id));
//    Open;
//
//    result := RecordCount > 0;
//
//    if Assigned(pList) then
//    begin
//      for i := 0 to pList.Count - 1 do
//      begin
//        rec := pList.Items[i];
//        rec.Free;
//      end;
//
//      pList.Clear;
//    end
//    else
//      pList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TTorpedo_On_Board.Create;
//
//        with rec.FDef do
//        begin
//          Class_Identifier := FieldByName('Class_Identifier').AsString;
//        end;
//
//        pList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;
//
//function TdmINWO.GetMotionCharacteristicAtVehicleDef(const id: Integer; var pList: TList): boolean;
//var
//  i : Integer;
//  rec: TVehicle_Definition;
//begin
//  result := false;
//  if not ZConn.Connected then
//    exit;
//
//  with ZQ do
//  begin
//    Close;
//    SQL.Clear;
//    SQL.Add('SELECT * ');
//    SQL.Add('FROM Vehicle_Definition ');
//    SQL.Add('WHERE Motion_Characteristics = ' + IntToStr(id));
//    SQL.Add(' ORDER BY Vehicle_Identifier ');
//
//    Open;
//
//    result := RecordCount > 0;
//
//    if Assigned(pList) then
//    begin
//      for i := 0 to pList.Count - 1 do
//      begin
//        rec := pList.Items[i];
//        rec.Free;
//      end;
//
//      pList.Clear;
//    end
//    else
//      pList := TList.Create;
//
//    if not IsEmpty then
//    begin
//      First;
//
//      while not Eof do
//      begin
//        rec := TVehicle_Definition.Create;
//
//        with rec.FData do
//        begin
//          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
//          Vehicle_Identifier := FieldByName('Vehicle_Identifier').AsString;
//        end;
//
//        pList.Add(rec);
//        Next;
//      end;
//    end;
//  end;
//end;

{$ENDREGION}


{$REGION ' Usage Sensor '}

function TdmINWO.GetRadarAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TRadar_On_Board;

begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Radar_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Radar_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TRadar_On_Board.Create;
        with rec.FData do
        begin
          Radar_Instance_Index := FieldByName('Radar_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Radar_Index := FieldByName('Radar_Index').AsInteger;
          Rel_Antenna_Height := FieldByName('Rel_Antenna_Height').AsSingle;
          Submerged_Antenna_Height := FieldByName('Submerged_Antenna_Height').AsSingle;
          Max_Operational_Depth := FieldByName('Max_Operational_Depth').AsSingle;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetSonarAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  ssql: string;
  rec: TSonar_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Sonar_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Sonar_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TSonar_On_Board.Create;
        with rec.FData do
        begin
          Sonar_Instance_Index := FieldByName('Sonar_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Sonar_Index := FieldByName('Sonar_Index').AsInteger;
          Minimum_Depth := FieldByName('Minimum_Depth').AsSingle;
          Time_2_Deploy := FieldByName('Time_2_Deploy').AsInteger;
          Time_2_Stow := FieldByName('Time_2_Stow').AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetSonarAtSonobuoyDef(const id: Integer; var pList: TList): boolean;
var
  ssql: string;
  rec: TSonobuoy_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Sonobuoy_Definition ');
    SQL.Add('WHERE (Sonar_Index = ' + IntToStr(id) + ')');

    SQL.Add(ssql);
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TSonobuoy_On_Board.Create;
        with rec.FDef do
        begin
          Class_Identifier := FieldByName('Class_Identifier').AsString;
        end;
        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetESMAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  ssql: string;
  rec: TESM_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM ESM_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.ESM_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TESM_On_Board.Create;
        with rec.FData do
        begin
          ESM_Instance_Index := FieldByName('ESM_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          ESM_Index := FieldByName('ESM_Index').AsInteger;
          Rel_Antenna_Height := FieldByName('Rel_Antenna_Height').AsSingle;
          Max_Operational_Depth := FieldByName('Max_Operational_Depth').AsSingle;
          Submerged_Antenna_Height := FieldByName('Submerged_Antenna_Height').AsSingle;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetEODAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  ssql: string;
  rec: TEOD_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM EOD_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.EOD_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TEOD_On_Board.Create;
        with rec.FData do
        begin
          EOD_Instance_Index := FieldByName('EOD_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          EOD_Index := FieldByName('EOD_Index').AsInteger;
          Antenna_Height := FieldByName('Antenna_Height').AsSingle;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetMADAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  ssql: string;
  rec: TMAD_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM MAD_Sensor_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.MAD_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TMAD_On_Board.Create;
        with rec.FData do
        begin
          MAD_Instance_Index := FieldByName('MAD_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          MAD_Index := FieldByName('MAD_Index').AsInteger;
          Antenna_Height := FieldByName('Antenna_Height').AsSingle;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetSonobuoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  ssql: string;
  rec: TSonobuoy_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Sonobuoy_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Sonobuoy_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TSonobuoy_On_Board.Create;
        with rec.FData do
        begin
          Sonobuoy_Instance_Index := FieldByName('Sonobuoy_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Sonobuoy_Index := FieldByName('Sonobuoy_Index').AsInteger;
          Quantity := FieldByName('Quantity').AsInteger;
          Sonar_Instance_Index := FieldByName('Sonar_Instance_Index').AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' Usage Weapon '}

function TdmINWO.GetFittedWeaponAtVehicleOnBoard(const index, id: Integer; var pList: TList): boolean;
var
  indexField: string;
  rec: TMissile_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  case TStorageType(index) of
    stMissile: indexField := 'a.Missile_Index';
    stTorpedo: indexField := 'a.Torpedo_Index';
    stMine: indexField := 'a.Mine_Index';
  end;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Fitted_Weapon_On_Board a ');
    SQL.Add('LEFT JOIN Vehicle_Definition b on a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE ' + indexField + ' = ' + IntToStr(id));
    SQL.Add(' ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TMissile_On_Board.Create;
        with rec.FData do
        begin
          Fitted_Weap_Index := FieldByName('Fitted_Weap_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Vehicle_Index       := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetTorpedoAtMissileDef(const id: Integer; var pList: TList): boolean;
var
  i : Integer;
  rec : TMissile_On_Board;
begin
  Result := False;

  if not ZConn.Connected then
    Exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Hybrid_definition a LEFT JOIN Missile_Definition b ');
    SQL.Add('ON a.Missile_Index = b.Missile_Index');
    SQL.Add('Where Torpedo_Index = ' + IntToStr(id));
    Open;

    Result := RecordCount > 0;

    if Assigned(pList) then
    begin
      for i := 0 to pList.Count - 1 do
      begin
        rec := pList.Items[i];
        rec.Free;
      end;

      pList.Clear;
    end
    else
      pList := TList.Create;

    if not IsEmpty then
    begin
      First;

      while not Eof do
      begin
        rec := TMissile_On_Board.Create;

        with rec.FDef do
        begin
          Class_Identifier := FieldByName('Class_Identifier').AsString;
        end;

        pList.Add(rec);
        Next;
      end;
    end;
  end;
end;

function TdmINWO.GetPointEffectAtVehicleOnBoard(const index,id: Integer; var pList: TList): boolean;
var
  indexField: string;
  rec: TGun_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  case index of
    10: indexField := 'a.Gun_Index';
    11: indexField := 'a.Bomb_Index';
  end;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('FROM Point_Effect_On_Board a ');
    SQL.Add('LEFT JOIN Vehicle_Definition b on a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE ' + indexField + ' = ' + IntToStr(id));
    SQL.Add(' ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TGun_On_Board.Create;
        with rec.FData do begin
          Point_Effect_Index    := FieldByName('Point_Effect_Index').AsInteger;
          Instance_Identifier   := FieldByName('Instance_Identifier').AsString;
          Vehicle_Index       := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' Usage Countermeasure '}

function TdmINWO.GetChaffAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TChaff_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Chaff_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Chaff_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TChaff_On_Board.Create;
        with rec.FData do
        begin
          Chaff_Instance_Index := FieldByName('Chaff_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Chaff_Qty_On_Board := FieldByName('Chaff_Qty_On_Board').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Chaff_Index := FieldByName('Chaff_Index').AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAirBubbleAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TAir_Bubble_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Air_Bubble_Mount a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Air_Bubble_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TAir_Bubble_On_Board.Create;
        with rec.FData do
        begin
          Air_Bubble_Instance_Index := FieldByName('Air_Bubble_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Vehicle_Index       := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Bubble_Qty_On_Board := FieldByName('Bubble_Qty_On_Board').AsInteger;
          Air_Bubble_Index    := FieldByName('Air_Bubble_Index').AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetAcousticDecoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TAcoustic_Decoy_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Acoustic_Decoy_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Decoy_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      Result := True;
      First;

      while not ZQ.Eof do
      begin
        rec := TAcoustic_Decoy_On_Board.Create;
        with rec.FData do
        begin
          Acoustic_Instance_Index  := FieldByName('Acoustic_Instance_Index').AsInteger;
          Instance_Identifier      := FieldByName('Instance_Identifier').AsString;
          Instance_Type            := FieldByName('Instance_Type').AsInteger;
          Quantity                 := FieldByName('Quantity').AsInteger;
          Vehicle_Index            := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier       := FieldByName('Vehicle_Identifier').AsString;
          Decoy_Index              := FieldByName('Decoy_Index').AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetInfraredDecoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TInfrared_Decoy_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Infrared_Decoy_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Infrared_Decoy_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TInfrared_Decoy_On_Board.Create;
        with rec.FData do
        begin
          Infrared_Decoy_Instance_Index := FieldByName
            ('Infrared_Decoy_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Infrared_Decoy_Qty_On_Board := FieldByName
            ('Infrared_Decoy_Qty_On_Board').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Infrared_Decoy_Index := FieldByName('Infrared_Decoy_Index').AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetFloatingDecoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TFloating_Decoy_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Floating_Decoy_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Floating_Decoy_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TFloating_Decoy_On_Board.Create;
        with rec.FData do
        begin
          Floating_Decoy_Instance_Index := FieldByName('Floating_Decoy_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Quantity := FieldByName('Quantity').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Floating_Decoy_Index := FieldByName('Floating_Decoy_Index').AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetTowedDecoyAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TTowed_Decoy_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Towed_Jammer_Decoy_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Towed_Decoy_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TTowed_Decoy_On_Board.Create;
        with rec.FData do
        begin
          Towed_Decoy_Instance_Index := FieldByName('Towed_Decoy_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Quantity := FieldByName('Quantity').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Towed_Decoy_Index := FieldByName('Towed_Decoy_Index').AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetDefensiveJammerAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TDefensive_Jammer_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Defensive_Jammer_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Defensive_Jammer_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TDefensive_Jammer_On_Board.Create;
        with rec.FData do
        begin
          Defensive_Jammer_Instance_Index := FieldByName
            ('Defensive_Jammer_Instance_Id').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Defensive_Jammer_Index := FieldByName('Defensive_Jammer_Index')
            .AsInteger;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

function TdmINWO.GetRadarNoiseJammerAtVehicleOnBoard(const id: Integer; var pList: TList): boolean;
var
  rec: TRadar_Noise_Jammer_On_Board;
begin
  result := false;
  if not ZConn.Connected then
    exit;

  with ZQ do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM Jammer_On_Board a LEFT JOIN Vehicle_Definition b');
    SQL.Add('ON a.Vehicle_Index = b.Vehicle_Index ');
    SQL.Add('WHERE (a.Jammer_Index = ' + IntToStr(id) + ')');
    SQL.Add('ORDER BY b.Vehicle_Identifier');
    Open;

    result := RecordCount > 0;
    if not Assigned(pList) then
    begin
      pList.Create;
    end
    else
    begin
      pList.Clear;
    end;

    if not IsEmpty then
    begin
      First;

      while not ZQ.Eof do
      begin
        rec := TRadar_Noise_Jammer_On_Board.Create;
        with rec.FData do
        begin
          Jammer_Instance_Index := FieldByName('Jammer_Instance_Index').AsInteger;
          Instance_Identifier := FieldByName('Instance_Identifier').AsString;
          Instance_Type := FieldByName('Instance_Type').AsInteger;
          Vehicle_Index := FieldByName('Vehicle_Index').AsInteger;
          Vehicle_Identifier  := FieldByName('Vehicle_Identifier').AsString;
          Jammer_Index := FieldByName('Jammer_Index').AsInteger;
          Antenna_Height := FieldByName('Antenna_Height').AsSingle;
        end;

        pList.Add(rec);
        ZQ.Next;
      end;
    end;
  end;
end;

{$ENDREGION}

{$ENDREGION}

{$ENDREGION}

end.
