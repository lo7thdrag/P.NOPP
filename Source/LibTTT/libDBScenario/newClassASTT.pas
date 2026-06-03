unit newClassASTT;

interface

uses
  uRecordData, Windows;

type

  ////====================================================
  TAcoustic_Decoy_Definition = class
  public
    FData : TRecAcoustic_Decoy_Definition;
  end;

  ////====================================================

  TAir_Bubble_Definition = class
  public
    FData  : TRecAir_Bubble_Definition;
  end;

  ////====================================================
  TAsset_Deployment_Definition = class
  public
    FData  : TRecAsset_Deployment_Definition;
  end;
  ////====================================================
 
  TChaff_Definition = class
  public
    FData  : TRecChaff_Definition;
  end;
  ////====================================================

  TCloud_Effects_On_ESM = class
  public
    FData  : TRecCloud_Effects_On_ESM;
  end;
  ////====================================================
  TCloud_Effects_On_Radar = class
  public
    FData  : TRecCloud_Effects_On_Radar;
  end;
  ////====================================================

  TConditional_Event_List = class
  public
    FData  : TRecConditional_Event_List;
  end;
  ////====================================================
 
  ////====================================================
  TDefault_Definition = class
  public
    FData  : TRecDefault_Definition;
  end;
  ////====================================================
  TDefault_IFF_Mode_Code = class
  public
    FData  : TRecDefault_IFF_Mode_Code;
  end;
  ////====================================================
  TDefensive_Jammer_Definition = class
  public
    FData  : TRecDefensive_Jammer_Definition;
  end;
  ////====================================================
  ////====================================================
  TDIS_Category_Definition = class
  public
    FData  : TRecDIS_Category_Definition;
  end;
  ////====================================================
  TDIS_Country_Definition = class
  public
    FData  : TRecDIS_Country_Definition;
  end;
  ////====================================================
  TDIS_Domain_Country_Mapping = class
  public
    FData  : TRecDIS_Domain_Country_Mapping;
  end;
  ////====================================================
  TDIS_Domain_Definition = class
  public
    FData  : TRecDIS_Domain_Definition;
  end;
  ////====================================================
  TDIS_Kind_Definition = class
  public
    FData  : TRecDIS_Kind_Definition;
  end;
  ////====================================================
  TDIS_Kind_Domain_Mapping = class
  public
    FData  : TRecDIS_Kind_Domain_Mapping;
  end;
  ////====================================================
  TDIS_Specific_Definition = class
  public
    FData  : TRecDIS_Specific_Definition;
  end;
  ////====================================================
  TDIS_Subcategory_Definition = class
  public
    FData  : TRecDIS_Subcategory_Definition;
  end;
  ////====================================================
  TEO_Detection_Definition = class
  public
    FData  : TRecEO_Detection_Definition;
  end;
  ////====================================================
  ////====================================================
  TESM_Definition = class
  public
    FData  : TRecESM_Definition;
  end;
  ////====================================================
  ////====================================================
  TExternal_Communication_Channel = class
  public
    FData  : TRecExternal_Communication_Channel;
  end;
  ////====================================================
  TFCR_Definition = class
  public
    FData  : TRecFCR_Definition;
  end;
  ////====================================================
  ////====================================================
  TFitted_Weap_Launcher_On_Board = class
  public
    FData  : TRecFitted_Weap_Launcher_On_Board;
  end;
  ////====================================================

  TFloating_Decoy_Definition = class
  public
    FData  : TRecFloating_Decoy_Definition;
  end;
  ////====================================================
  ////====================================================
  TFormation_Assignment = class
  public
    FData  : TRecFormation_Assignment;
  end;
  ////====================================================
  TFormation_Definition = class
  public
    FData  : TRecFormation_Definition;
  end;
  ////====================================================

  ////====================================================
  TGame_Cloud_On_ESM = class
  public
    FData  : TRecGame_Cloud_On_ESM;
  end;
  ////====================================================
  TGame_Cloud_On_Radar = class
  public
    FData  : TRecGame_Cloud_On_Radar;
  end;
  ////====================================================
  TGame_Default_IFF_Mode_Code = class
  public
    FData  : TRecGame_Default_IFF_Mode_Code;
  end;
  ////====================================================
  TGame_Rainfall_On_ESM = class
  public
    FData  : TRecGame_Rainfall_On_ESM;
  end;
  ////====================================================
  TGame_Rainfall_On_Missile_Seeker = class
  public
    FData  : TRecGame_Rainfall_On_Missile_Seeker;
  end;
  ////====================================================
  TGame_Rainfall_On_Radar = class
  public
    FData  : TRecGame_Rainfall_On_Radar;
  end;
  ////====================================================
  TGame_Rainfall_On_Sonar = class
  public
    FData  : TRecGame_Rainfall_On_Sonar;
  end;
  ////====================================================
  TGame_Sea_On_Missile_Safe_Altitude = class
  public
    FData  : TRecGame_Sea_On_Missile_Safe_Altitude;
  end;
  ////====================================================
  TGame_Sea_On_Radar = class
  public
    FData  : TRecGame_Sea_On_Radar;
  end;
  ////====================================================
  TGame_Sea_On_Sonar = class
  public
    FData  : TRecGame_Sea_On_Sonar;
  end;
  ////====================================================
  TGame_Ship_On_Sonar = class
  public
    FData  : TRecGame_Ship_On_Sonar;
  end;
  ////====================================================

  ////====================================================
  TGlobal_Convergence_Zone = class
  public
    FData  : TRecGlobal_Convergence_Zone;
  end;

  ////====================================================
  
//  THelicopter_Land_Launch_Limits = class
//  public
//    FData  : TRecHelicopter_Land_Launch_Limits;
//  end;
  ////====================================================
 ////====================================================
  TInfrared_Decoy_Definition = class
  public
    FData  : TRecInfrared_Decoy_Definition;
  end;
  ////====================================================
  ////====================================================
  TJammer_Definition = class
  public
    FData  : TRecRadar_Noise_Jammer_Definition;
  end;
  ////====================================================
 
  
  ////====================================================
  TList_Conditional_Event_Mapping = class
  public
    FData  : TRecList_Conditional_Event_Mapping;
  end;
  ////====================================================
  TMAD_Definition = class
  public
    FData  : TRecMAD_Definition;
  end;
  ////====================================================
 
  ////====================================================
  {TMotion_Characteristics = class
  public
    FData  : TRecMotion_Characteristics;
  end; }
  ////====================================================
  TNote_Storage = class
  public
    FData  : TRecNote_Storage;
  end;
  ////====================================================
  TOverlay_Definition = class
  public
    FData  : TRecOverlay_Definition;
  end;
  ////====================================================

  TPattern_Infrared_Decoy_Event = class
  public
    FData  : TRecPattern_Infrared_Decoy_Event;
    end;
  ////====================================================
  TPattern_Point = class
  public
    FData  : TRecPattern_Point;
  end;
  ////====================================================

  TPattern_Weapon_Event = class
  public
    FData  : TRecPattern_Weapon_Event;
  end;
  ////====================================================
  TPlatform_Activation = class
  public
    FData  : TRecPlatform_Activation;
  end;
  ////====================================================
  TPlatform_DIS_Definition = class
  public
    FData  : TRecPlatform_DIS_Definition;
  end;
  ////====================================================
  TPlatform_IFF_Activation = class
  public
    FData  : TRecPlatform_IFF_Activation;
  end;
  ////====================================================
  TPlatform_IFF_Mode_Code = class
  public
    FData  : TRecPlatform_IFF_Mode_Code;
  end;
  ////====================================================
  {TPlatform_Library_Entry = class
  public
    FData  : TRecPlatform_Library_Entry;
  end;
  }
  ////====================================================
  TPOD_vs_SNR_Curve_Definition = class
  public
    FData  : TRecPOD_vs_SNR_Curve_Definition;
  end;
  ////====================================================
  TPOD_vs_SNR_Point = class
  public
    FData  : TRecPOD_vs_SNR_Point;
    X : Integer;
    Y : Integer;
  end;
  ////====================================================
  ////====================================================
  TRadar_Interval_Definition = class
  public
    FData  : TRecRadar_Interval_Definition;
  end;

  ////====================================================
  TRadar_Interval_List = class
  public
    FData  : TRecRadar_Interval_List;
  end;

  ////====================================================
  TRadar_Vertical_Coverage = class
  public
    FData  : TRecRadar_Vertical_Coverage;
  end;

  ////====================================================
  TRainfall_On_ESM = class
  public
    FData  : TRecRainfall_On_ESM;
  end;
  ////====================================================
  TRainfall_On_Missile_Seeker = class
  public
    FData : TRecRainfall_On_Missile_Seeker;
  end;
  ////====================================================
  TRainfall_On_Radar = class
  public
    FData : TRecRainfall_On_Radar;
  end;
  ////====================================================
  TRainfall_On_Sonar = class
  public
    FData : TRecRainfall_On_Sonar;
  end;
  ////====================================================
  TReference_Point = class
  public
    FData : TRecReference_Point;
  end;
  ////====================================================
  TResource_Cond_List_Mapping = class
  public
    FData : TRecResource_Cond_List_Mapping;
  end;
  ////====================================================
  TResource_Geo_Area_Mapping = class
  public
    FData : TRecResource_Geo_Area_Mapping;
  end;
  ////====================================================
  TResource_Interval_List_Mapping = class
  public
    FData : TRecResource_Interval_List_Mapping;
  end;
  ////====================================================
  TResource_Library_Mapping = class
  public
    FData : TRecResource_Library_Mapping;
  end;
  ////====================================================
  TResource_Overlay_Mapping = class
  public
    FData : TRecResource_Overlay_Mapping;
    FResource_Allocation   : TRecResource_Allocation;
  end;
  ////====================================================
  TResource_Pattern_Mapping = class
  public
    FData : TRecResource_Pattern_Mapping;
  end;
  ////====================================================
  TResource_Sonobuoy_Mapping = class
  public
    FData : TRecResource_Sonobuoy_Mapping;
  end;
  ////====================================================
  TResource_Template_Mapping = class
  public
    FData : TRecResource_Template_Mapping;
  end;
  ////====================================================
 { TRuntime_Platform_Library = class
  public
    FData : TRecRuntime_Platform_Library;
  end; }
  ////====================================================
  
  
  ////====================================================
  TScripted_Infrared_Decoy_Event = class
  public
    FData : TRecScripted_Infrared_Decoy_Event;
  end;
  ////====================================================
  TScripted_Sonar_Event = class
  public
    FData : TRecScripted_Sonar_Event;
  end;
  ////====================================================
  TScripted_Weapon_Event = class
  public
    FData : TRecScripted_Weapon_Event;
  end;
  ////====================================================
  TSea_State_On_Missile_Safe_Altitude = class
  public
    FData : TRecSea_State_On_Missile_Safe_Altitude;
  end;
  ////====================================================
  TSea_State_On_Radar = class
  public
    FData : TRecSea_State_On_Radar;
  end;
  ////====================================================
  TSea_State_On_Sonar = class
  public
    FData : TRecSea_State_On_Sonar;
  end;
  ////====================================================
  TShip_Noise_On_Sonar = class
  public
    FData : TRecShip_Noise_On_Sonar;
  end;
  ////====================================================
  TSonar_Definition = class
  public
    FData : TRecSonar_Definition;
  end;
  ////====================================================
  ////====================================================
  {TSonobuoy_On_Board = class
  public
    FData : TRecSonobuoy_On_Board;
  end;          }
  ////====================================================
  TStudent_Role_Definition = class
  public
    FData : TRecStudent_Role_Definition;
  end;
  ////====================================================
  {TStudent_Role_List = class
  public
    FData : TRecStudent_Role_List;
  end;}
  ////====================================================
  TText_Message_Template = class
  public
    FData : TRecText_Message_Template;
  end;
  ////====================================================
  ////====================================================
  TTorpedo_POH_Modifier = class
  public
    FData : TRecTorpedo_POH_Modifier;
  end;
  ////====================================================
  TTowed_Jammer_Decoy_Definition = class
  public
    FData : TRecTowed_Jammer_Decoy_Definition;
  end;
  ////====================================================
  ////====================================================
//  TVehicle_Definition = class
  ////====================================================
  ////====================================================
  ///

implementation


end.
