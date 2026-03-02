unit uRecordData;

interface

uses
  {Delphi Uses}
  SysUtils, Graphics,

  {Project Uses}
  uTCPDatatype, uConstantaData, uDataTypes;

type
  MyArray = array [0..9] of array [0..2]of Double;

  {$REGION ' UDP Game Record '}
//  CPID_GAMETIME             = CPID_UDP + 3;
  TRecUDP_GameTime = record
    pid         : TPacketID;
    SessionID   : Integer;
    ServerTime  : TDateTime;
    GameTime    : TDateTime;
    GameMS      : LongWord;
    GameSpeed   : single;
    GameStart   : TDateTime;
  end;

//  CPID_UDP_GAMECTRL_INFO    = CPID_UDP + 4;
  TRecUDP_GameCtrl_Info = record
    pid        : TPacketID;
    SessionID   : Integer;
    GameState  : integer;  // game state
    GameSpeed  : double;
    GameTimeMS : LongWord;
    Flag       : word;
  end;

  TRecUDP_ClientState_Info = record
    pid        : TPacketID;
    SessionID   : Integer;
    command: Byte;
  end;
  {$ENDREGION}

  {$REGION ' TCP Game Record '}

  //CPID_CMD_GAME_CTRL;
  TRecCmd_GameCtrl = record
    pid       : TPacketID;
    SessionID : Integer;
    GameCtrl  : word;   {start / stop}
  end;

  // CPID_CMD_LOGIN
  TRecTCP_UserState = record
    pid         : TPacketID;
    SessionID   : Integer;
    OrderID     : Integer;
    UserRoleId  : Integer;
    ConsoleIP   : string[20];
    UserRoleInUse : Boolean;
  end;

  TRecTCP_ClientState_Info = record
    pid         : TPacketID;
    SessionID   : Integer;
    ConsoleName : string[20];
    ClientState : Boolean;
  end;

  //CPID_TCP_REQUEST          = CPID_TCP  + 10;
  TRecTCP_Request = record
    pid         : TPacketID;
    SessionID   : Integer;
    State3D     : Byte;
    reqID       : byte;
    reqParam    : byte;
    reqFlag     : word;
  end;

  // CPID_REMOTE_CMD
  TRecTCPSendRemote = record
    pid         : TPacketID;
    SessionID   : Integer;
    OrderID     : Byte;
    FServer     : LongWord;
    FClient     : LongWord;
    FPort       : Integer;
    FColor      : Byte;
    FControl    : boolean;
  end;

  // CPID_SITUATIONBOARD_TAB_PROPERTIES_CMD
  TRecTCPSendSituationBoardTabProperties = record
    pid         : TPacketID;
    SessionID   : Integer;
    OrderID     : Byte;
    UserRoleId  : Integer;
    TabId       : Integer;
    TabCaption  : string[20];
    TabType     : Byte;
    TabActive   : Boolean;
    TabAddres   : string[255];
    OverlayTab  : Integer;
  end;

  //CPID_CHAT_USER_ROLE_CMD
  TRecTCPSendChatUserRole = record
    pid                 : TPacketID;
    SessionID           : Integer;
    OrderID             : Byte;
    SenderUserRoleId    : Integer;
    ReceiverUserRoleId  : Integer;
    ChatMessage         : string[255];
  end;

  //CPID_TELEGRAM_USER_ROLE_CMD
  TRecTCPSendTelegramUserRole = record
    pid                 : TPacketID;
    SessionID           : Integer;
    OrderID             : Byte;
    SenderUserRoleId    : Integer;
    ReceiverUserRoleId  : Integer;
//    ChatMessage         : string[255];
  end;

  //CPID_CMD_OVERLAYSHAPE
  TRecTCPSendOverlayShape = record
    pid           : TPacketID;
    SessionID     : Integer;
    IdUserRole    : Integer;
    ShapeType     : Byte;
    TemplateId    : Integer;
    OverlayName   : string[20];
    IdAction      : Byte;       {1: add; 2: Edit; 3: Delete}
    IdSelectShape : Byte;
    PostStart     : t2DPoint;   {PostStart/ PostCenter}
    PostEnd       : t2DPoint;
    Words         : string[30];
	  Size          : byte;
    Radius1       : Double;     {Radius/Inner/Height}
    Radius2       : Double;     {Outer/ Width}
    StartAngle    : Integer;
    EndAngle      : Integer;
    Rotasi        : Integer;
    Kolom         : Integer;
    Baris         : Integer;
    color         : Integer;
    lineType      : TPenStyle;
    weight        : Integer;
    BrushStyle    : TBrushStyle;
    ColorFill     : TColor;
    Editable      : Boolean;
    PolyPoint     : array[0..12] of t2DPoint;
    Data          : array[0..12] of string[50];
    Status        : array[0..12] of string[7];
    Simbol        : array[0..12] of string[1];
    Quantity      : array[0..12] of Integer;
    isSelected    : Boolean;
    role          : Byte;
  end;
  {$ENDREGION}

  {$REGION ' Class Data Record '}

  TAnyRecord = record
    pid     : TPacketID;
    anyDATA : Double;
  end;

  TMapPt = record
    Longitude : Double;
    Latitude  : Double;
  end;

  TRecRole = record
    RoleIndex       : Integer;
    RoleAcronim     : string[20];
    RoleIdentifier  : string[75];
  end;

  TRecSubRole = record
    SubRoleIndex      : Integer;
    RoleIndex         : Integer;
    SubRoleAcronim    : string[75];
    SubRoleIdentifier : string[75];
    Perencanaan       : Byte;
    Persiapan         : Byte;
    Pelaksanaan       : Byte;
    Pengakhiran       : Byte;
  end;

  TRecUser_Role = record
    UserRoleIndex       : Integer;
    RoleIndex           : Integer;
    SubRoleIndex        : Integer;
    UserRoleAcronim     : string[20];
    UserRoleIdentifier  : string[75];
    Username            : string[26];
    Password            : string[11];
  end;

  TRecFile_Data = record
    ID_File             : Integer;
    Nama_File           : string[255];
    Directory_Path      : string[255];
    Encripted_File_Name : string[255];
    Tipe_File           : string[5];
    Modified_Date       : string[35];
    Modified_By         : string[25];
    Kategori            : string[255];
    id_User             : Integer;
  end;

  TRecNote_Storage = record
    Note_Index               : integer;
    Note_Type                : byte;
    Notes                    : string;
  end;

  TRecVehicle_Definition =  record
    VehicleIndex          : integer;
    VehicleIdentifier     : string[60];
    VehicleClass          : string[60];
    VehicleNation         : string[60];
    PlatformDomain        : byte;
    PlatformCategory      : byte;
    HullNumber            : string[5];
    CallSign              : string[5];
    LengthDimension       : single;
    WidthDimension        : single;
    HeightDimension       : single;
    WeightDimension       : single;
    DraftDimension        : single;
    VbsClassName          : string[60];

    EnduranceType         : byte;
    LubricantsCapacity    : single;
    WaterCapacity         : single;
    FoodCapacity          : single;
    FuelCapacity          : single;
    MaxRange              : single;
    MaxTime               : single;
    LubricantsConsumption : single;
    WaterConsumption      : single;
    FoodConsumption       : single;
    FuelConsumption       : single;
    MinFuelConsumption    : single;
    MaxFuelConsumption    : single;
    CruiseFuelConsumption : single;
    HighFuelConsumption   : single;

    Officer               : Integer;
    FrontGangway          : ByteBool;
    RearGangway           : ByteBool;
    PortGangway           : ByteBool;
    StarBoardGangway      : ByteBool;
    CarriableUnit         : ByteBool;
    PersonelUnitCarried   : ByteBool;
    MaxPersonelCapacity   : Integer;
    DeckUnitCarried       : ByteBool;
    AmphibiousCarried     : ByteBool;
    LandCarried           : ByteBool;
    MaxWeightDeck         : Single;
    WidthDeck             : Single;
    LengthDeck            : Single;
    HangarUnitCarried     : ByteBool;
    FixWingCarried        : ByteBool;
    RotaryCarried         : ByteBool;
    MaxCapacityHangar     : Integer;
    MaxWeightHangar       : Single;
  end;

  TRecHosted_Platform =  record
    Slave_Index            : integer;      // primary key table
    Vehicle_Index          : integer;      // vehicle induknya
    Hosted_Vehicle_Index   : integer;      // vehicle embarked
    Quantity               : integer;      // jumlah embarked
  end;

  TRecMissile_Definition =  record
    Missile_Index                    : integer;
    Class_Identifier                 : string[60];
    Platform_Domain                  : byte;
    Platform_Category                : byte;
    Platform_Type                    : byte;
    Max_Range                        : single;
    Min_Range                        : single;
    Motion_Index                     : integer;
    Seeker_TurnOn_Range              : single;
    Second_Seeker_Pattern_Capable    : byte;
    Seeker_Bias_Capable              : byte;
    Fixed_Seeker_Turn_On_Range       : byte;
    Lethality                        : integer;
    Prob_of_Hit                      : single;
    Damage_Capacity                  : integer;
    Default_Altitude                 : single;
    Length                           : single;
    Width                            : single;
    Height                           : single;
    Front_Radar_Cross                : single;
    Side_Radar_Cross                 : single;
    Front_Visual_Cross               : single;
    Side_Visual_Cross                : single;
    Front_Infrared_Cross             : single;
    Side_Infrared_Cross              : single;
    Pursuit_Guide_Type               : byte;
    Primary_Guide_Type               : byte;
    Secondary_Guide_Type             : byte;
    Anti_Air_Capable                 : byte;
    Anti_Sur_Capable                 : byte;
    Anti_SubSur_Capable              : byte;
    Anti_Land_Capable                : byte;
    Anti_Amphibious_Capable          : byte;
    Primary_Target_Domain            : byte;
    SARH_POH_Modifier                : single;
    CG_POH_Modifier                  : single;
    TARH_POH_Modifier                : single;
    IR_POH_Modifier                  : single;
    AR_POH_Modifier                  : single;
    Transmitted_Frequency            : double;
    Scan_Rate                        : single;
    Pulse_Rep_Freq                   : single;
    Pulse_Width                      : single;
    Xmit_Power                       : single;
    TARH_Jamming_A_Probability       : single;
    TARH_Jamming_B_Probability       : single;
    TARH_Jamming_C_Probability       : single;
    Wpt_Capable                      : byte;
    Max_Num_Wpts                     : byte;
    Min_Final_Leg_Length             : single;
    Engagement_Range                 : single;
    Max_Firing_Depth                 : single;
    Upper_Received_Freq              : double;
    Lower_Received_Freq              : double;
    Fly_Out_Required                 : byte;
    Fly_Out_Range                    : single;
    Fly_Out_Altitude                 : single;
    Booster_Separation_Required      : byte;
    Booster_Separation_Range         : single;
    Booster_Separation_Box_Width     : single;
    Booster_Separation_Box_Length    : single;
    Term_Guide_Azimuth               : single;
    Term_Guide_Elevation             : single;
    Term_Guide_Range                 : single;
    Terminal_Guidance_Capability     : byte;
    Terminal_Altitude_Required       : byte;
    Terminal_Acquisition_Altitude    : single;
    Terminal_Sinuation_Start_Range   : single;
    Terminal_Sinuation_Period        : single;
    Terminal_Sinuation_Amplitude     : single;
    Terminal_Pop_Up_Range            : single;
    Terminal_Pop_Up_Altitude         : single;
    Mid_Course_Update_Mode           : byte;
    Home_On_Jam_Type_A_Capable       : byte;
    Home_On_Jam_Type_B_Capable       : byte;
    Home_On_Jam_Type_C_Capable       : byte;
    Launch_Method                    : byte;
    Data_Entry_Method                : byte;
    Launch_Speed                     : byte;
    Max_Target_Altitude_Delta        : integer;
    Term_Guide_Azimuth_Narrow        : single;
    Term_Guide_Elevation_Narrow      : single;
    Term_Guide_Range_Narrow          : single;
    Spot_Number                      : integer;
    ECCM_Type                        : byte;
    ECM_Detonation                   : byte;
    ECM_Detection                    : byte;
    Detectability_Type               : byte;
    IRCM_Detonation                  : byte;
    IRCM_Detection                   : byte;
    Sea_State_Modelling_Capable      : byte;
  end;

  TRecTorpedo_Definition =  record
    Torpedo_Index                : integer;
    Class_Identifier             : string[60];
    Platform_Domain              : byte;
    Platform_Category            : byte;
    Platform_Type                : byte;
    Max_Range                    : single;
    Min_Range                    : single;
    Motion_Index                 : integer;
    Seeker_TurnOn_Range          : single;
    Lethality                    : integer;
    Damage_Capacity              : integer;
    Default_Depth                : single;
    Length                       : single;
    Width                        : single;
    Height                       : single;
    Front_Acoustic_Cross         : single;
    Side_Acoustic_Cross          : single;
    LSpeed_Acoustic_Intens       : single;
    Below_Cav_Acoustic_Intens    : single;
    Above_Cav_Acoustic_Intens    : single;
    HSpeed_Acoustic_Intens       : single;
    Cavitation_Switch_Point      : single;
    Term_Guide_Azimuth           : single;
    Term_Guide_Elevation         : single;
    Term_Guide_Range             : single;
    Pursuit_Guidance_Type        : byte;
    Air_Drop_Capable             : byte;
    Use_Terminal_Circle          : byte;
    Terminal_Circle_Radius       : single;
    Fixed_Circle_Radius          : byte;
    Lateral_Deceleration         : single;
    Airborne_Descent_Rate        : double;
    Wire_Angle_Offset            : single;
    Guidance_Type                : byte;
    Anti_Sur_Capable             : byte;
    Anti_SubSur_Capable          : byte;
    Primary_Target_Domain        : byte;
    Active_Acoustic_POH_Mod      : single;
    Passive_Acoustic_POH_Mod     : single;
    Active_Passive_POH_Mod       : single;
    WireGuide_POH_Modifier       : single;
    WakeHome_POH_Modifier        : single;
    Active_Seeker_Power          : single;
    Active_Seeker_Freq           : single;
    Engagement_Range             : single;
    First_Relative_Gyro_Angle    : integer;
    Second_Relative_Gyro_Angle   : integer;
    Max_Torpedo_Gyro_Angle       : single;
    Max_Torpedo_Search_Depth     : single;
    Acoustic_Torp_Ceiling_Depth  : single;
    Fixed_Ceiling_Depth          : byte;
    Fixed_Seeker_TurnOn_Range    : byte;
    Sinuation_Runout             : byte;
    Runout_Sinuation_Period      : single;
    Runout_Sinuation_Amplitude   : single;
    Min_Runout_Range             : single;
    Launch_Method                : byte;
    Data_Entry_Method            : byte;
    Launch_Speed                 : byte;
    Opt_Launch_Range_Nuc_Sub     : single;
    Opt_Launch_Range_Conv_Sub    : single;
    Opt_Launch_Range_Other       : single;
    Detectability_Type           : byte;
  end;

  TRecGun_Definition =  record
    Gun_Index                    : integer;
    Gun_Identifier               : string[60];
    Gun_Category                 : byte;
    Rate_of_Fire                 : integer;
    Lethality_per_Round          : integer;
    Min_Range                    : single;
    Max_Range                    : single;
    Air_Min_Range                : single;
    Air_Max_Range                : single;
    Fire_Cntl_Director_Req       : byte;
    Chaff_Capable_Gun            : byte;
    Anti_Sur_Capable             : byte;
    Anti_Land_Capable            : byte;
    Anti_Air_Capable             : byte;
    Anti_Amphibious_Capable      : byte;
    Automode_Capable             : byte;
    Firearms                     : Byte;
    Max_Target_Altitude_Delta    : integer;
    Gun_Average_Shell_Velocity   : single;
    Man_Gun_Max_Elevation        : single;
    Man_Gun_Min_Elevation        : single;
    Man_Gun_Rotation_Rate        : single;
    Man_Gun_Elevation_Rate       : single;
    Man_Gun_Num_Rounds_Per_Load  : integer;
    Man_Gun_Time_to_Reload       : single;
    Man_Gun_Muzzle_Velocity      : single;
    NGS_Capable                  : byte;
    NGS_MinDeflectionError       : single;
    NGS_MaxDeflectionError       : single;
    NGS_MinRangeError            : single;
    NGS_MaxRangeError            : single;
    NGS_MaxDispersionError       : single;
    NGS_MaxDamageRadius          : single;
    NGS_EffectiveRadius          : single;
    NGS_DamageRating             : integer;
  end;

  TRecBomb_Definition =  record
    Bomb_Index              : integer;
    Bomb_Identifier         : string[60];
    Bomb_Type               : byte;
    Lethality               : integer;
    Damage_Area             : Double;
    Min_Range               : Double;
    Max_Range               : Double;
    Anti_Sur_Capable        : byte;
    Anti_SubSur_Capable     : byte;
    Anti_Land_Capable       : byte;
    Anti_Amphibious_Capable : Byte;
    Rocket_Launcher         : byte;
  end;

  TRecMine_Definition =  record
    Mine_Index             : integer;
    Mine_Identifier        : string[60];
    Platform_Domain        : byte;
    Platform_Category      : byte;
    Platform_Type          : byte;
    Mine_Classification    : byte;        // acoustic, impact, magnetic, pressure
    Length                 : single;
    Width                  : single;
    Height                 : single;
    Mooring_Type           : byte;
    Max_Laying_Depth       : single;
    Front_Acoustic_Cross   : single;
    Side_Acoustic_Cross    : single;
    Mine_Lethality         : integer;
    Engagement_Range       : single;
    Anti_Sur_Capable       : byte;
    Anti_SubSur_Capable    : byte;
    Detectability_Type     : byte;
  end;

  TRecRadar_Definition =  record
    Radar_Index                    : integer;
    Radar_Identifier               : string[60];
    Radar_Emitter                  : string[60];
    Radar_Type                     : byte;
    Frequency                      : single;
    Scan_Rate                      : single;
    Pulse_Rep_Freq                 : single;
    Pulse_Width                    : single;
    Radar_Power                    : single;
    Detection_Range                : single;
    Known_Cross_Section            : single;
    Max_Unambig_Detect_Range       : single;
    IFF_Capability                 : ByteBool;
    Altitude_Data_Capability       : ByteBool;
    Ground_Speed_Data_Capability   : ByteBool;
    Heading_Data_Capability        : ByteBool;
    Plat_Type_Recog_Capability     : ByteBool;
    Plat_Class_Recog_Capability    : ByteBool;
    Clutter_Rejection              : single;
    Anti_Jamming_Capable           : ByteBool;
    Curve_Definition_Index         : integer;
    Second_Vert_Coverage           : ByteBool;
    Jamming_A_Resistant            : ByteBool;
    Jamming_B_Resistant            : ByteBool;
    Jamming_C_Resistant            : ByteBool;
    Anti_Jamming_A_Resistant       : ByteBool;
    Anti_Jamming_B_Resistant       : ByteBool;
    Anti_Jamming_C_Resistant       : ByteBool;
    Anti_Jamming_Range_Reduction   : single;
    Beam_Width                     : single;
    Sector_Scan_Capable            : ByteBool;
    Off_Axis_Jammer_Reduction      : single;
    Num_FCR_Channels               : byte;
    Radar_Spot_Number              : integer;
    Radar_Horizon_Factor           : single;
    Main_Lobe_Gain                 : single;
    Counter_Detection_Factor       : single;
    ECCM_Type                      : byte;
    MTI_Capable                    : ByteBool;
    MTI_MinTargetSpeed             : single;
  end;

  TRecSonar_Definition =  record
    Sonar_Index                      : integer;
    Sonar_Identifier                 : string[60];
    Sonar_Category_Index             : byte;
    Sonar_Classification             : byte;
    Passive_Int_Period               : integer;
    Active_Int_Period                : integer;
    TIOW_Short_Range                 : single;
    TIOW_Medium_Range                : single;
    TIOW_Long_Range                  : single;
    Passive_Detect_Range             : single;
    Active_Detect_Range              : single;
    Max_Detect_Range                 : single;
    Known_Signal_Source              : single;
    Known_Cross_Section              : single;
    Sonar_Directivity_Index          : single;
    Active_Operating_Power           : single;
    Active_Freq_of_Op                : single;
    Passive_Freq_of_Op               : single;
    Max_Operating_Depth              : single;
    Sonar_Depth_Rate_of_Change       : single;
    Depth_per_Speed                  : single;
    Kinking_Processing               : ByteBool;
    Turn_Rate_2_Kink                 : single;
    Time_2_Settle_Kinked             : integer;
    Bearing_Processing               : ByteBool;
    Time_2_Resolve_Bearing           : integer;
    Passive_Processing               : ByteBool;
    Target_Identification            : ByteBool;
    Time_2_Identify                  : integer;
    Curve_Detection_Index            : integer;
    Track_Analysis                   : byte;
    Time_2_Provide_Track             : integer;
    Ownship_Increase_due_to_Active   : single;
    Tow_Speed                        : single;
    Minimum_Depth                    : single;
    Maximum_Tow_Speed                : single;
    Maximum_Sonar_Speed              : single;
    Depth_Finding_Capable            : ByteBool;
    Tracking_Capable                 : ByteBool;
    Surface_Detection_Capable        : ByteBool;
    SubSurface_Detection_Capable     : ByteBool;
    Torpedo_Detection_Capable        : ByteBool;
    Mine_Detection_Capable           : ByteBool;
    Cable_Length                     : single;
    Maximum_Reported_Bearing_Error   : single;
    Average_Beam_Width               : single;
    Counter_Detection_Factor         : single;
  end;

  TRecESM_Definition =  record
    ESM_Index                        : integer;
    Class_Identifier                 : string[60];
    Low_Detect_Frequency1            : double;
    High_Detect_Frequency1           : double;
    Low_Detect_Frequency2            : double;
    High_Detect_Frequency2           : double;
    ESM_Classification               : byte;
    Emitter_Detect_Range_Factor      : single;
    Comm_Intercept_Capable           : byte;
    Frequency_Identify_Range         : double;
    PRF_Identify_Range               : single;
    Pulsewidth_Identify_Range        : single;
    Scan_Period_Identify_Range       : single;
    Sector_Blank_Detection_Factor    : single;
    Identification_Period            : single;
    Classification_Period            : single;
    Minimum_Bearing_Error_Variance   : single;
    Initial_Bearing_Error_Variance   : single;
    Second_Frequency_Detection_Capable: byte;
  end;

  TRecMAD_Definition =  record
    MAD_Index              : integer;
    Class_Identifier       : string[60];
    Baseline_Detect_Range  : single;
    Known_Cross_Section    : single;
  end;

  TRecEOD_Definition =  record
    EOD_Index             : integer;
    Class_Identifier     : string[60];
    Sensor_Type          : byte;
    Detection_Range      : single;
    Known_Cross_Section  : single;
    Max_Range            : single;
    Scan_Rate            : single;
    Num_FC_Channels      : byte;
  end;

  TRecSonobuoy_Definition =  record
    Sonobuoy_Index         : integer;
    Class_Identifier       : string[60];
    Sonobuoy_Type          : byte;
    Platform_Domain        : byte;
    Platform_Category      : byte;
    Platform_Type          : byte;
    Endurance_Time         : integer;
    Max_Depth              : single;
    Length                 : single;
    Width                  : single;
    Height                 : single;
    Front_Acoustic_Cross   : single;
    Side_Acoustic_Cross    : single;
    Damage_Capacity        : integer;
    CPA_Detection_Capable  : byte;
    CPA_Range_Limit        : single;
    Sonar_Index            : integer;
  end;

  TRecChaff_Definition =  record
    Chaff_Index              : integer;
    Chaff_Identifier         : string[60];
    Platform_Domain          : byte;
    Platform_Category        : byte;
    Platform_Type            : byte;
    Max_Radar_Cross          : single;
    Bloom_Time               : integer;
    Max_Dissipation_Time     : integer;
    Min_Dissipation_Time     : integer;
    Descent_Rate             : single;
    Max_Radius               : single;
    Max_Radar_Attenuation    : single;
    Radar_Affect_Lower_Freq  : single;
    Radar_Affect_Upper_Freq  : single;
  end;

  TRecAir_Bubble_Definition =  record
    Air_Bubble_Index       : integer;
    Air_Bubble_Identifier  : string[60];
    Platform_Domain        : byte;
    Platform_Category      : byte;
    Platform_Type          : byte;
    Max_Acoustic_Cross     : single;
    Dissipation_Time       : single;
    Ascent_Rate            : single;
    Descent_Rate           : single;
  end;

  TRecAcoustic_Decoy_Definition =  record
    Decoy_Index                  : integer;
    Decoy_Identifier             : string[60];
    Acoustic_Intensity_Increase  : single;
  end;

  TRecInfrared_Decoy_Definition =  record
    Infrared_Decoy_Index       : integer;
    Infrared_Decoy_Identifier  : string[60];
    Platform_Domain            : byte;
    Platform_Category          : byte;
    Platform_Type              : byte;
    Max_Infrared_Cross         : single;
    Bloom_Time                 : integer;
    Sustain_Time               : integer;
    Max_Dissipation_Time       : integer;
    Min_Dissipation_Time       : integer;
    Descent_Rate               : single;
  end;

  TRecFloating_Decoy_Definition =  record
    Floating_Decoy_Index       : integer;
    Floating_Decoy_Identifier  : string[60];
    Platform_Domain            : byte;
    Platform_Category          : byte;
    Platform_Type              : byte;
    Length                     : single;
    Width                      : single;
    Height                     : single;
    Front_Radar_Cross          : single;
    Side_Radar_Cross           : single;
    Front_Visual_Cross         : single;
    Side_Visual_Cross          : single;
    Front_Acoustic_Cross       : single;
    Side_Acoustic_Cross        : single;
    Lifetime_Duration          : single;
  end;

  TRecTowed_Decoy_Definition =  record
    Towed_Decoy_Index          : integer;
    Towed_Decoy_Identifier     : string[60];
    Decoy_TARH_Capable         : byte;
    Decoy_SARH_Capable         : byte;
    Platform_Domain            : byte;
    Platform_Category          : byte;
    Platform_Type              : byte;
    Length                     : single;
    Width                      : single;
    Height                     : single;
    Front_Radar_Cross          : single;
    Side_Radar_Cross           : single;
    Front_Visual_Cross         : single;
    Side_Visual_Cross          : single;
    Front_Acoustic_Cross       : single;
    Side_Acoustic_Cross        : single;
    Type_A_Seducing_Prob       : single;
    Type_B_Seducing_Prob       : single;
    Type_C_Seducing_Prob       : single;
    Activation_Control_Delay   : single;
    Tow_Length                 : single;
    ECM_Type                   : byte;
  end;

  TRecDefensive_Jammer_Definition =  record
    Defensive_Jammer_Index       : integer;
    Defensive_Jammer_Identifier  : string[60];
    Jammer_TARH_Capable          : byte;
    Jammer_SARH_Capable          : byte;
    Type_A_Seducing_Prob         : single;
    Type_B_Seducing_Prob         : single;
    Type_C_Seducing_Prob         : single;
    ECM_Type                     : byte;
  end;

  TRecRadar_Noise_Jammer_Definition =  record
    Jammer_Index               : integer;
    Jammer_Type                : byte;
    Jammer_Identifier          : string[60];
    Lower_Freq_Limit           : double;
    Upper_Freq_Limit           : double;
    Jammer_Power_Density       : double;
    Max_Effective_Range        : single;
    Max_Sector_Width           : single;
    Upper_Vert_Coverage_Angle  : single;
    Lower_Vert_Coverage_Angle  : single;
  end;

  TRecFitted_Weapon_On_Board =  record
    Fitted_Weap_Index      : integer;
    Instance_Identifier    : string[80];
    Instance_Type          : byte;
    Vehicle_Index          : integer;
    Vehicle_Identifier     : string[80];
    Mount_Type             : byte;
    Launch_Angle           : single;
    Launch_Angle_Required  : byte;
    Quantity               : integer;
    Firing_Delay           : single;
    Missile_Index          : integer;
    Torpedo_Index          : integer;
    Mine_Index             : integer;
    Hybrid_Index           : integer;
  end;

  TRecPoint_Effect_On_Board =  record
    Point_Effect_Index   : integer;
    Instance_Identifier  : string[80];
    Instance_Type        : byte;
    Vehicle_Index        : integer;
    Vehicle_Identifier   : string[80];
    Mount_Type           : byte;
    Quantity             : integer;
    Gun_Index            : integer;
    Bomb_Index           : integer;
    TurretID             : integer;
  end;

  TRecRadar_On_Board =  record
    Radar_Instance_Index       : integer;
    Instance_Identifier        : string[80];
    Instance_Type              : byte;
    Vehicle_Index              : integer;
    Vehicle_Identifier         : string[80];
    Radar_Index                : integer;
    Rel_Antenna_Height         : single;
    Submerged_Antenna_Height   : single;
    Max_Operational_Depth      : single;
  end;

  TRecSonar_On_Board =  record
    Sonar_Instance_Index   : integer;
    Instance_Identifier    : string[80];
    Instance_Type          : byte;
    Vehicle_Index          : integer;
    Vehicle_Identifier     : string[80];
    Sonar_Index            : integer;
    Minimum_Depth          : single;
    Time_2_Deploy          : integer;
    Time_2_Stow            : integer;
  end;

  TRecESM_On_Board =  record
    ESM_Instance_Index         : integer;
    Instance_Identifier        : string[80];
    Instance_Type              : byte;
    Vehicle_Index              : integer;
    Vehicle_Identifier         : string[80];
    ESM_Index                  : integer;
    Rel_Antenna_Height         : single;
    Max_Operational_Depth      : single;
    Submerged_Antenna_Height   : single;
  end;

  TRecEOD_On_Board =  record
    EOD_Instance_Index  : integer;
    Instance_Identifier : string[80];
    Instance_Type       : byte;
    Vehicle_Index       : integer;
    Vehicle_Identifier  : string[80];
    EOD_Index           : integer;
    Antenna_Height      : single;
  end;

  TRecMAD_On_Board =  record
    MAD_Instance_Index   : integer;
    Instance_Identifier  : string[80];
    Instance_Type        : byte;
    Vehicle_Index        : integer;
    Vehicle_Identifier   : string[80];
    MAD_Index            : integer;
    Antenna_Height       : single;
  end;

  TRecSonobuoy_On_Board =  record
    Sonobuoy_Instance_Index  : integer;
    Instance_Identifier      : string[80];
    Instance_Type            : byte;
    Vehicle_Index            : integer;
    Vehicle_Identifier       : string[80];
    Sonobuoy_Index           : integer;
    Quantity                 : integer;
    Sonar_Instance_Index     : integer;
  end;

  TRecChaff_On_Board =  record
    Chaff_Instance_Index   : integer;
    Instance_Identifier    : string[80];
    Instance_Type          : byte;
    Chaff_Qty_On_Board     : integer;
    Vehicle_Index          : integer;
    Vehicle_Identifier     : string[80];
    Chaff_Index            : integer;
  end;

  TRecAir_Bubble_On_Board =  record
    Air_Bubble_Instance_Index  : integer;
    Instance_Identifier        : string[80];
    Instance_Type              : byte;
    Bubble_Qty_On_Board        : integer;
    Vehicle_Index              : integer;
    Vehicle_Identifier         : string[80];
    Air_Bubble_Index           : integer;
  end;

  TRecAcoustic_Decoy_On_Board =  record
    Acoustic_Instance_Index  : integer;
    Instance_Identifier      : string[80];
    Instance_Type            : byte;
    Quantity                 : integer;
    Vehicle_Index            : integer;
    Vehicle_Identifier       : string[80];
    Decoy_Index              : integer;
  end;

  TRecInfrared_Decoy_On_Board =  record
    Infrared_Decoy_Instance_Index  : integer;
    Instance_Identifier            : string[80];
    Instance_Type                  : byte;
    Infrared_Decoy_Qty_On_Board    : integer;
    Vehicle_Index                  : integer;
    Vehicle_Identifier             : string[80];
    Infrared_Decoy_Index           : integer;
  end;

  TRecFloating_Decoy_On_Board =  record
    Floating_Decoy_Instance_Index  : integer;
    Instance_Identifier            : string[80];
    Instance_Type                  : byte;
    Quantity                       : integer;
    Vehicle_Index                  : integer;
    Vehicle_Identifier             : string[80];
    Floating_Decoy_Index           : integer;
  end;

  TRecTowed_Decoy_On_Board =  record
    Towed_Decoy_Instance_Index   : integer;
    Instance_Identifier          : string[80];
    Instance_Type                : byte;
    Quantity                     : integer;
    Vehicle_Index                : integer;
    Vehicle_Identifier           : string[80];
    Towed_Decoy_Index            : integer;
  end;

  TRecDefensive_Jammer_On_Board =  record
    Defensive_Jammer_Instance_Index  : integer;
    Instance_Identifier              : string[80];
    Instance_Type                    : byte;
    Vehicle_Index                    : integer;
    Vehicle_Identifier               : string[80];
    Defensive_Jammer_Index           : integer;
  end;

  TRecRadar_Noise_Jammer_On_Board =  record
    Jammer_Instance_Index  : integer;
    Instance_Identifier    : string[80];
    Instance_Type          : byte;
    Vehicle_Index          : integer;
    Vehicle_Identifier     : string[80];
    Jammer_Index           : integer;
    Antenna_Height         : single;
  end;

  TRecGame_Area_Definition =  record
    Game_Area_Index          : integer;
    Game_Area_Identifier     : string[150];
    Game_Centre_Lat          : double;
    Game_Centre_Long         : double;
    Game_X_Dimension         : single;
    Game_Y_Dimension         : single;
    Use_Real_World           : byte;
    Use_Artificial_Landmass  : byte;
    Detail_Map               : string[50];
  end;

  TRecTactical_Symbol = record
    Id_Tactical_Symbol         : Integer;
    Tipe                       : Integer;
    Kategori                   : Integer;
    Keterangan                 : string[80];
    Path_Directori             : string[80];
  end;

  TRecFontTaktis = record
    FONT_ID                    : integer;
    FONT_NAME                  : string[60];
    FONT_INDEX                 : integer;
    KETERANGAN                 : string[255];
  end;

  {$ENDREGION}

const

//  CPID 30 .. 49 buat GAME UDP;
//  CPID 50 .. 79 buat GAME TCP
  CPID_UDP = 30;
  CPID_TCP = 50;

  {$REGION ' CPID_UDP '}

  CPID_GAMETIME                 = CPID_UDP + 1;
  CPID_UDP_GAMECTRL_INFO        = CPID_UDP + 2;
  CPID_CMD_CLIENT_STATE_INFO    = CPID_UDP + 3;
  CPID_UDP_MAX                  = CPID_UDP + 4;

  {$ENDREGION}

  {$REGION ' CPID_TCP '}

  CPID_CMD_GAME_CTRL                      = CPID_TCP + 1;
    CORD_ID_start = 1;
    CORD_ID_pause = 2;
  CPID_CMD_USER_STATE                     = CPID_TCP + 2;
    CORD_ID_LOGIN = 1;
    CORD_ID_LOGOUT = 2;
  CPID_TCP_REQUEST                        = CPID_TCP + 3;
  CPID_CMD_REMOTE                         = CPID_TCP + 4;
    REMOTE_STATE_FALSE = 0;
    REMOTE_STATE_TRUE  = 1;
    REMOTE_STATE_READY = 3;
  CPID_CMD_SITUATIONBOARD_TAB_PROPERTIES  = CPID_TCP + 5;
    NEW_TAB = 0;
    EDIT_TAB = 1;
    DELETE_TAB = 2;
  CPID_CMD_CHAT_USER_ROLE                 = CPID_TCP + 6;
    SEND_CHAT = 0;
  CPID_CMD_OVERLAYSHAPE                   = CPID_TCP + 7;
  CPID_CMD_TELEGRAM_USER_ROLE             = CPID_TCP + 8;
    SEND_TELEGRAM = 0;
  CPID_TCP_MAX              	            = CPID_TCP + 9;

  {$ENDREGION}

  function getPacketIDname(const cpid: integer): string;
  function getRecString(const r: TRecTCP_Request): string; overload;
  function getRecString(const r: TRecCmd_GameCtrl): string; overload;

  implementation

function getPacketIDname(const cpid: integer): string;
const
  CS_PIDUDP_name : array [CPID_GAMETIME .. CPID_UDP_MAX - 1] of string
  = ( 'CPID_GAMETIME',
      'CPID_UDP_GAMECTRL_INFO',
      'CPID_CMD_CLIENT_STATE_INFO'
  );

 CS_PIDTCP_name : array [CPID_CMD_GAME_CTRL .. CPID_TCP_MAX - 1] of string
  = (
  'CPID_CMD_GAME_CTRL                     ',   // + 1
  'CPID_CMD_LOGIN                         ',   // + 2
  'CPID_TCP_REQUEST                       ',   // + 3
  'CPID_CMD_REMOTE                        ',   // + 4
  'CPID_CMD_SITUATIONBOARD_TAB_PROPERTIES ',   // + 5
  'CPID_CMD_CHAT_USER_ROLE                ',   // + 6
  'CPID_CMD_OVERLAYSHAPE                  ',   // + 7
  'CPID_CMD_TELEGRAM_USER_ROLE            '    // + 8
);

begin
  if (cpid > CPID_TCP) and (cpid < CPID_TCP_MAX) then
    result := CS_PIDTCP_name[cpid]
  else
  if (cpid > CPID_UDP) and (cpid < CPID_UDP_MAX) then
    result := CS_PIDUDP_name[cpid]
  else
    result := 'UNDEFINED (' + IntToStr(cpID) + ')';
end;

function getRecString(const r: TRecTCP_Request): string;
begin
//  case r.reqID of
//    REQ_SYNCH_GAMECTRL_INFO:
//      result := ' Synch Game Ctrl Info';
//    REQ_LAST_PLATFORMID_INFO:
//     result := ' Synch Last Platform ID';
//    REQ_CUBICLE_ASSIGNMENT:
//      result := ' Cubicle Assignment';
//    REQ_MISSED_PACKET:
//      result := ' Synch Missed Packet';
//    REQ_DATA_PLATFORM:
//      result := ' Synch data to vbs';
//    REQ_TERRAIN:
//      result := ' Request Terrain';
//  end;

end;

//function getRecString(const r: TRecUDP_PlatformMovement): string;
//begin
//  result :=  IntToStr(r.PlatformID) + ' ' +
//  FormatFloat('000.000000', r.X) + ' ' +
//  FormatFloat('00.000000', r.Y) + ' ' +
//  FormatFloat('000.0', r.Course) + ' ' +
//  FormatFloat('000.0', r.Speed) + ' ';
//end;

function getRecString(const r: TRecCmd_GameCtrl): string;
begin
  case r.GameCtrl of
    CORD_ID_start       :
    begin
      Result :=' Game Start';
    end;
    CORD_ID_pause       :
    begin
      Result :=' Game Pause';
    end;
  end;
end;

end.
