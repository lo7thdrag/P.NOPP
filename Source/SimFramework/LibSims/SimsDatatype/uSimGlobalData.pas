unit uSimGlobalData;

(*
  ho.ho.ho... sudah 2010 05 11
  
  andySu, 2008 11 10
  Load Setting dari File di pindah di sini.

*)

interface

uses
  Graphics;

const

  CMin_Epsilon = 0.0000000001;

type

//  HC_RECID_STRING = 0;

{  TRecString = record
    pid : TPacketID;                     //
    data: string[255];
    sender  : string[16];                    //12345678901234567890
    receiver: string[16];                    //255.255.255.255
  end;

 }
  TRecShipClassData = record
    ShipClassName: string[31];
    //- Engine.
    RateAccell,
      RateDeccel: double;
    MinShipSpeed,
      MaxShipSpeed: double;
    Minruder,
      MaxRuder,
      RateRuder: double;
    EngineFactor,
      RudderFactor: double;
    //- Display
    CharSymb: char;
  end;

//==============================================================================
  TRecShipFixData = record
    idClass: byte; // ref to TRecShipClassData
    idShip: byte; // ship
    ShipName: string[32];
    ShortName: string[3];
    ShipNumber: string[3];
  end;

//==============================================================================
  //HC_RECID_SHIPSTATE = 1;
  TRecShipStateData = record
    pid: TPacketID; // for send receive
    ixShip: byte; //uniqueIndex
    X, Y: double;
    Course: single;
    LSpeed,
      LSpeedTo: single;
    RSpeed,
      RSpeedTo: single;
    Rudder,
      Rudderto: single;
    //enginestate : longword;
    //callsign
    //ipaddress
  end;

//==============================================================================
  //HC_RECID_SHIPASSIGN     = 2;       // ini paket untuk create ship
  TRecShipAssign = record
    pid: TPacketID;
    ixShip: byte; //uniqueIndex
    ipaddress: string[15];
    callsign: string[32];
    X, Y: double;
    Course, Speed: single;
  end;

  //  HC_RECID_REQ            = 4;
  TRecREQ = record
    pid: TPacketID;
    cmd, param: byte;
  end;

  //  HC_RECID_ACK            = 5;
  TRecACK = record
    pid: TPacketID;
    ack: byte;
    sender: string[16];
  end;

//==============================================================================
  //HC_RECID_SCENARIO        = 8;
  TRecScenario = record
    pid: TPacketID;
    cmd: Byte;

    SName,
      SLocation,
      SGeoset: string[255];
    sZoom: Single;

    sDate, sTime: TDateTime;
    SLanguage: Byte;
  end;

  //  HC_RECID_SHIP_COMMAND   = 9;
  TRecShipCommand = record
    pid: TPacketID;
    ixShip: Byte;
    cmd: byte;
    param: Single;
  end;

  //  HC_RECID_PLOT_COMMAND   = 10;
  TRecPlotCMD = record
    pid: TPacketID; // for send receive
    ixShip: Byte; // sender ship
    plotCMD: Byte;
    plotSym: byte;
    plotID: byte;
    X,
      Y: Double;
    text: string[32];
  end;

  //  HC_RECID_WAYPOINT   = 12;
  TRecWayPoint = record
    pid: TPacketID; // for send receive
    ixShip: Byte; // sender ship
    cmd: Byte; // add del edit
    param1: Byte; // del index

    X, Y: Double;
    course, speed: Single;
  end;

  //HC_RECID_SHIP_REPOS = 14;
  TRecShipRepos = record
    pid: TPacketID;
    ixShip: byte; //uniqueIndex
    cmdRepos: Byte;
    X, Y: double;
  end;

  // synchronizer
  // HC_RECID_GAME_STATE = 15;
  TRecGameState = record
    pid: TPacketID;
    cmd: Byte; // reserve
    GameSpeed: Byte;
    VTimeTick: LongWord;
    PlayState: Byte; // reserve; play pause stop
  end;

  //HC_RECID_SYNCHTIME = 16;
  TRecSyncTime = record
    pid: TPacketID;
    cmd: Byte; // reserve
    DDateTime: Double;
  end;

  //=============================================================================
  TShipData = class
  private
    function getShipN: string;
    function getSpeed: single;
    procedure setSpeed(const Value: single);
    function getPos(index: integer): double;
    procedure setPos(index: integer; const Value: double);
  public
    StateData: TRecShipStateData;

    constructor Create;
    destructor Destroy; override;
  public
    property ShipName: string read getShipN;

    property Speed: single read getSpeed write setSpeed;
    property Course: single read StateData.Course write StateData.Course;
    property X: double index 1 read getPos write setPos;
    property Y: double index 2 read getPos write setPos;
  end;

const

//  HC_RECID_STRING         = 0;

  HC_RECID_SHIPSTATE  = 1;
  HC_RECID_SHIPASSIGN = 2;

  HC_RECID_REQ = 4;
    hc_req_time = 1;

  HC_RECID_ACK = 5;
    hc_ack_join = 1;
    hc_ack_disjoin = 2;
//    hc_ack_

  HC_RECID_SCENARIO = 8; // server send scenario
    hc_Scenario_ADD = 1;
    hc_Scenario_DEL = 2;

  HC_RECID_SHIP_COMMAND = 9; //client send ship state
    hc_ship_left = 1;
    hc_ship_right = 2;
    hc_ship_rudder = 3;
    hc_ship_set_speed = 4;
    hc_ship_set_course = 5;

  HC_RECID_PLOT_COMMAND = 10;
   {CTool_Plot_Add   = 21;
   CTool_Plot_Del   = 22;
   CTool_Plot_Edit  = 23;
   CTool_Plot_Move  = 24;}

  HC_RECID_WAYPOINT = 12;
    hc_wp_add = 1;
    hc_wp_del = 2;
    hc_wp_edit = 3;

  HC_RECID_SHIP_REPOS = 14;

  HC_RECID_GAME_STATE = 15;
 // Record and Replay

  HC_RECID_SYNCHTIME = 16;

  CONST_CRLF = #13#10;

implementation

uses
  SysUtils, uShipDBase;

{ TShipFixData }

constructor TShipData.Create;
begin
//
end;

destructor TShipData.Destroy;
begin

  inherited;
end;

function TShipData.getPos(index: integer): double;
begin
  result := 0.0;
  case index of
    1: result := StateData.X;
    2: result := StateData.Y;
  end;
end;

procedure TShipData.setPos(index: integer; const Value: double);
begin
  case index of
    1: StateData.X := Value;
    2: StateData.Y := Value;
  end;
end;

function TShipData.getShipN: string;
begin
//  result := getShipName(StateData.ixShip);
  result := ShipDataBase.getShipName(StateData.ixShip);
  if Result = '' then
    result := IntToStr(StateData.ixShip);

end;

function TShipData.getSpeed: single;
begin
  result := (StateData.LSpeed + StateData.RSpeed)
end;

procedure TShipData.setSpeed(const Value: single);
begin
  StateData.LSpeed := 0.5 * Value;
  StateData.RSpeed := 0.5 * Value;
end;

end.
