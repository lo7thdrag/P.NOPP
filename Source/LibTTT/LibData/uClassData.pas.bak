unit uClassData;

interface

uses
  System.Classes, MapXLib_TLB, Winapi.Windows, Vcl.Graphics, System.SysUtils,

  uRecordData, uConstantaData, uCoordConvertor, uDataTypes, uFormula, uBaseCoordSystem,
  uLibSetting;

type

  TRole = class
  private

  public
    FData  : TRecRole;

    constructor Create;
    destructor Destroy;override;

  end;

  TRoleContainer = class
  private
    FRoleList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function  getRoleByID(Id : Integer): TRole;

    procedure addRole(Val : TRole);
    procedure deleteRole(Val : TRole);

    property RoleList : TList read FRoleList write FRoleList;
  end;

  TSubRole = class
  private

  public
    FData  : TRecSubRole;

    constructor Create;
    destructor Destroy;override;

  end;

  TSubRoleContainer = class
  private
    FSubRoleList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function  getSubRoleByID(Id : Integer): TSubRole;

    procedure addSubRole(Val : TSubRole);
    procedure deleteSubRole(Val : TSubRole);

    property SubRoleList : TList read FSubRoleList write FSubRoleList;
  end;

  TUserRole = class
  private
    FConsoleIP : string;
    FisInUse : Boolean;

  public
    FData  : TRecUser_Role;
    FSubRoleData  : TRecSubRole;
    FRoleData  : TRecRole;

    constructor Create;
    destructor Destroy;override;

    property ConsoleIP: string read FConsoleIP write FConsoleIP;
    property isInUse: Boolean read FisInUse write FisInUse;
  end;

  TUserRoleContainer = class
  private
    FUserList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function  getUserRoleByUsernamePassword(username, password : string): TUserRole;
    function  getUserRoleByID(Id : Integer): TUserRole;
    function  getUserRoleByIPAddress(IpAddress : string): TUserRole;

    procedure addUserRole(Val : TUserRole);
    procedure deleteUserRole(Val : TUserRole);

    property UserList : TList read FUserList write FUserList;
  end;

  TConsoleData = class
  private
    FIdentifier : string;
    FIpAdrres : string;
    FGroup : TConsoleGroup;
    FUserRoleData : TUserRole;

  public
    constructor Create;
    destructor  Destroy; override;

    procedure assignUserRoleData(Val : TUserRole);
    procedure UnassignUserRoleData(Val : TUserRole);

    property Identifier : string read FIdentifier write FIdentifier;
    property IpAdrres : string read FIpAdrres write FIpAdrres;
    property Group : TConsoleGroup read FGroup write FGroup;
    property UserRoleData : TUserRole read FUserRoleData write FUserRoleData;
  end;

  TFile_Data = class
  private

  public
    FData  : TRecFile_Data;

    constructor Create;
    destructor  Destroy; override;
  end;

  TTabProperties = class

  private
    FIdTab : Integer;
    FIdUserRoleTab : Integer;
    FIdOverlayTab : Integer;
    FCaptionTab : string;
    FActiveTab : Boolean;
    FTypeTab : Byte;
    FAddressTab : string;

  public
    constructor Create;
    destructor Destroy;override;

    property IdTab: Integer read FIdTab write FIdTab;
    property IdUserRoleTab: Integer read FIdUserRoleTab write FIdUserRoleTab;
    property IdOverlayTab: Integer read FIdOverlayTab write FIdOverlayTab;
    property CaptionTab: string read FCaptionTab write FCaptionTab;
    property ActiveTab: Boolean read FActiveTab write FActiveTab;
    property TypeTab: Byte read FTypeTab write FTypeTab;
    property AddressTab: string read FAddressTab write FAddressTab;

  end;

  TTabPropertiesContainer = class
  private
    FTabList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function GetCountActiveTab(IdRole : Integer): Integer;
    function GetActiveTab(IdRole, IdTag : Integer): Boolean;
    function GetCaptionTab(IdRole, IdTag : Integer): string;
    function GetTapProperties(IdRole, IdTag : Integer): TTabProperties;

    property TabList : TList read FTabList write FTabList;
  end;

  TChatting = class

  private
    FIdChat : Integer;
    FIdUserRoleSending : Integer;
    FIdUserRoleReceive : Integer;
    FChatMessage : string;

  public
    constructor Create;
    destructor Destroy;override;

    property IdChat: Integer read FIdChat write FIdChat;
    property IdUserRoleSending: Integer read FIdUserRoleSending write FIdUserRoleSending;
    property IdUserRoleReceive: Integer read FIdUserRoleReceive write FIdUserRoleReceive;
    property ChatMessage: string read FChatMessage write FChatMessage;

  end;

  TChattingContainer = class
  private
    FChattingList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function GetChattingBySending(IdRoleReceiving, IdRoleSending : Integer; var chatList : TList): Boolean;
    function GetChattingByUserRole(UserRoleId : Integer; var chatList : TList): Boolean;

    property ChattingList : TList read FChattingList write FChattingList;
  end;

  TGame_Area_Definition = class
  private

  public
    FData : TRecGame_Area_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TTactical_Symbol = class
  private
   FImagePath: string;

  public
    FData  : TRecTactical_Symbol;
    property ImagePath: string read FImagePath write FImagePath;

    constructor Create;
    destructor Destroy;override;
  end;

  TAsset = class
  public
    FData : TRecVehicle_Definition;
    FNote : TRecNote_Storage;

    constructor Create;
    destructor Destroy;override;
  end;

  TVehicleOnBase = class
  public
    Name : string;
    Quantity : Integer;
    Simbol : string;
    IndexTaktisSymbol : Integer;
    constructor create;
    destructor Destroy; override;
  end;

  TLogisticOnBase = class
  public
    Name : string;
    Status : string;

    constructor create;
    destructor Destroy; override;
  end;

  TIntelijenInfo = class
  public
    Info : string;

    constructor create;
    destructor Destroy; override;
  end;

  TMainShape = class
  private
    FShapeId : Integer;
    FShapeOutline: Integer;
    FConverter: TCoordConverter;
    FShapeFill: Integer;
    FLineType: TPenStyle;
    FLineWeight: Integer;
    FBrushStyle: TBrushStyle;
    FIdentifier : string;
    FisSelected: Boolean;
    FisShow : Boolean;

    function SetTempHuruf(Huruf : TFont; id : Byte): TFont;
    procedure SetStyleHuruf(iCvs: TCanvas; iStyle: TFontStyle; iSize, iColor: Integer; iName: string);
    procedure SetLineProp(var gx: Integer;  x, gx1, gx2: Integer);
    procedure changeBitmapColor(bmp: TBitmap; clr: TColor);
    procedure drawObjek(FCanvas: TCanvas; id, x, y : Integer);

  public
    postCenter : t2DPoint;
    TableProp : t2DPoint;
    TempHuruf : TFont;

    constructor Create(cvt : TCoordConverter); virtual;
    destructor Destroy; virtual;

    function PackingName(OldName : string): string;
    function PackingQty(OldQty : Integer): string;
    function PackingInfo(OldStatus : string): string;

    procedure Clear;
    procedure Draw(aCnv: TCanvas); virtual;

    procedure Normalized(aCnv : TCanvas);

    property Identifier : string read FIdentifier write FIdentifier;
    property ShapeId : Integer read FShapeId write FShapeId;
    property ShapeOutline : Integer read FShapeOutline write FShapeOutline;
    property ShapeFill : Integer read FShapeFill write FShapeFill;
    property isSelected : Boolean read FisSelected write FisSelected;
    property isShow : Boolean read FisShow write FisShow;
    property Converter : TCoordConverter read FConverter write FConverter;
    property LineType : TPenStyle read FLineType write FLineType;
    property LineWeight : Integer read FLineWeight write FLineWeight;
    property BrushStyle : TBrushStyle read FBrushStyle write FBrushStyle;

  end;

  TTextShape = class(TMainShape)
  public
    postStart : t2DPoint;
    size : Integer;
    words : String;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter); override;
    destructor Destroy; override;
  end;

  TLineShape = class(TMainShape)
  public
    postStart : t2DPoint;
    postEnd : t2DPoint;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TRectangleShape = class(TMainShape)
  public
    postStart : t2DPoint;
    postEnd : t2DPoint;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TCircleShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    radius : Double;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TEllipseShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    Hradius, Vradius : Double;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TArcShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    radius : Double;
    StartAngle, EndAngle : Integer;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TSectorShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    Oradius, Iradius : Double;
    StartAngle, EndAngle : Integer;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TGridShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    HCount, WCount, Rotation : Integer;
    Height, Width : Double;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TPolygonShape = class(TMainShape)
  public
    polyPoint : Array of TPoint;
    polyList : TList;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TIntelijenShape = class (TMainShape)
  public
    InfoList   : TList;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TLogisticShape = class (TMainShape)
  public
    LogisticList   : TList;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TPangkalanShape = class (TMainShape)
  public
    VehiclesList   : TList;
    idTaktis : Integer;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TRadarShape = class (TMainShape)
  public
    Radius : Double;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TPanahShape = class (TMainShape)
  public
    postEnd  : t2DPoint;
    isPostEnd : Boolean;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TOverlayTab = class
  private
    FIdOverlayTab : Integer;
    FIdUserRole : Integer;
    FRoleName : string;
    FMemberList : TList;

  public
    Formula : TFormula;
    constructor create;
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); virtual;

    function GetShapeById(IdShape : Integer): TMainShape;

    property IdOverlayTab : Integer read FIdOverlayTab write FIdOverlayTab;
    property IdUserRole : Integer read FIdUserRole write FIdUserRole;
    property RoleName : string read FRoleName write FRoleName;
    property MemberList : TList read FMemberList write FMemberList;
  end;

  TOverlayTabContainer = class
  private
    FTabList : TList;

  public

    constructor Create;
    destructor Destroy; override;

    function GetOverlayTabByID(IdOverlay: Integer): TOverlayTab;

    procedure Draw(FCanvas: TCanvas; Map1: TMap; IdOverlayTab : Integer);

    procedure AddOverlayTab(OvelayTab : TOverlayTab);
    procedure RemoveOverlayTab(OvelayTab : TOverlayTab);

    property TabList : TList read FTabList write FTabList;

  end;

  TDotShape = class
  public
    X, Y : Double;
    constructor Create;
    destructor Destroy; override;
  end;

  TFlagPoint = class
  private
    FPointId : Integer;
    FConverter: TCoordConverter;

  public
    Post : t2DPoint;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy;
    procedure Draw(aCnv : TCanvas);

    property PointId : Integer read FPointId write FPointId;
    property Converter : TCoordConverter read FConverter write FConverter;
  end;

  TFlagPointbContainer = class
  private
    FConverter: TCoordConverter;
    FFlagList : TList;

  public

    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Draw(FCanvas: TCanvas);

    function GetFlagPoint(FlagPointId : Integer): TFlagPoint;

    property FlagList : TList read FFlagList write FFlagList;
    property Converter : TCoordConverter read FConverter write FConverter;

  end;

  TRuler = class
  private
    FConverter: TCoordConverter;

  protected

  public
    postStart : t2DPoint;
    postEnd : t2DPoint;
    IsVisible : Boolean;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas);

    property Converter : TCoordConverter read FConverter write FConverter;
  end;

  TFontTaktis = class
  public
    FData : TRecFontTaktis;

    constructor Create;
    destructor Destroy;override;

  end;

implementation

{$REGION ' TRole '}

constructor TRole.Create;
begin

end;

destructor TRole.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TRoleContainer '}

procedure TRoleContainer.addRole(Val: TRole);
begin
  FRoleList.Add(Val);
end;

constructor TRoleContainer.Create;
begin
  FRoleList := TList.Create;
end;

procedure TRoleContainer.deleteRole(Val: TRole);
begin
  FRoleList.Remove(Val);
end;

destructor TRoleContainer.Destroy;
begin
  FRoleList.Free;
  inherited;
end;

function TRoleContainer.getRoleByID(Id: Integer): TRole;
var
  i : Integer;
  roleTemp : TRole;
begin
  Result := nil;

  for i := 0 to FRoleList.Count-1 do
  begin
    roleTemp := FRoleList.Items[i];

    if roleTemp.FData.RoleIndex = Id then
    begin
      Result := roleTemp;
      Exit;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TSubRole '}

constructor TSubRole.Create;
begin

end;

destructor TSubRole.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TSubRoleContainer '}

procedure TSubRoleContainer.addSubRole(Val: TSubRole);
begin
  FSubRoleList.Add(Val);
end;

constructor TSubRoleContainer.Create;
begin
  FSubRoleList := TList.Create;
end;

procedure TSubRoleContainer.deleteSubRole(Val: TSubRole);
begin
  FSubRoleList.Remove(Val);
end;

destructor TSubRoleContainer.Destroy;
begin
  FSubRoleList.Free;
  inherited;
end;

function TSubRoleContainer.getSubRoleByID(Id: Integer): TSubRole;
var
  i : Integer;
  subRoleTemp : TSubRole;
begin
  Result := nil;

  for i := 0 to FSubRoleList.Count-1 do
  begin
    subRoleTemp := FSubRoleList.Items[i];

    if subRoleTemp.FData.SubRoleIndex = Id then
    begin
      Result := subRoleTemp;
      Exit;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TUser_Role '}

constructor TUserRole.Create;
begin
  FisInUse := False;
  FConsoleIP := '';
end;

destructor TUserRole.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TUserRoleContainer '}

procedure TUserRoleContainer.addUserRole(Val: TUserRole);
begin
  FUserList.Add(Val);
end;

constructor TUserRoleContainer.Create;
begin
  FUserList := TList.Create;
end;

procedure TUserRoleContainer.deleteUserRole(Val: TUserRole);
begin
  FUserList.Remove(Val);
end;

destructor TUserRoleContainer.Destroy;
begin
  FUserList.Free;
  inherited;
end;

function TUserRoleContainer.getUserRoleByID(Id: Integer): TUserRole;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  Result := nil;

  for i := 0 to FUserList.Count-1 do
  begin
    userRoleTemp := FUserList.Items[i];

    if userRoleTemp.FData.UserRoleIndex = Id then
    begin
      Result := userRoleTemp;
      Exit;
    end;
  end;
end;

function TUserRoleContainer.getUserRoleByIPAddress(IpAddress : string): TUserRole;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  Result := nil;

  for i := 0 to FUserList.Count-1 do
  begin
    userRoleTemp := FUserList.Items[i];

    if (userRoleTemp.FConsoleIP = IpAddress) then
    begin
      Result := userRoleTemp;
      Exit;
    end;
  end;
end;

function TUserRoleContainer.getUserRoleByUsernamePassword(username, password: string): TUserRole;
var
  i : Integer;
  userRoleTemp : TUserRole;
begin
  Result := nil;

  for i := 0 to FUserList.Count-1 do
  begin
    userRoleTemp := FUserList.Items[i];

    if (userRoleTemp.FData.Username = username) and (userRoleTemp.FData.Password = password) then
    begin
      Result := userRoleTemp;
      Exit;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TConsoleData '}

constructor TConsoleData.Create;
begin
  FUserRoleData := TUserRole.Create;
end;

destructor TConsoleData.Destroy;
begin
  FUserRoleData.Free;
  inherited;
end;

procedure TConsoleData.assignUserRoleData(Val: TUserRole);
begin
  FUserRoleData.FConsoleIP                      := IpAdrres;
  FUserRoleData.isInUse                         := Val.isInUse;

  FUserRoleData.FData.UserRoleIndex             := Val.FData.UserRoleIndex;
  FUserRoleData.FData.RoleIndex                 := Val.FData.RoleIndex;
  FUserRoleData.FData.SubRoleIndex              := Val.FData.SubRoleIndex;
  FUserRoleData.FData.UserRoleAcronim           := Val.FData.UserRoleAcronim;
  FUserRoleData.FData.UserRoleIdentifier        := Val.FData.UserRoleIdentifier;
  FUserRoleData.FData.Username                  := Val.FData.Username;
  FUserRoleData.FData.Password                  := Val.FData.Password;

  FUserRoleData.FSubRoleData.SubRoleIndex       := Val.FSubRoleData.SubRoleIndex;
  FUserRoleData.FSubRoleData.RoleIndex          := Val.FSubRoleData.RoleIndex;
  FUserRoleData.FSubRoleData.SubRoleAcronim     := Val.FSubRoleData.SubRoleAcronim;
  FUserRoleData.FSubRoleData.SubRoleIdentifier  := Val.FSubRoleData.SubRoleIdentifier;
  FUserRoleData.FSubRoleData.Perencanaan        := Val.FSubRoleData.Perencanaan;
  FUserRoleData.FSubRoleData.Persiapan          := Val.FSubRoleData.Persiapan;
  FUserRoleData.FSubRoleData.Pelaksanaan        := Val.FSubRoleData.Pelaksanaan;
  FUserRoleData.FSubRoleData.Pengakhiran        := Val.FSubRoleData.Pengakhiran;

  FUserRoleData.FRoleData.RoleIndex             := Val.FRoleData.RoleIndex;
  FUserRoleData.FRoleData.RoleAcronim           := Val.FRoleData.RoleAcronim;
  FUserRoleData.FRoleData.RoleIdentifier        := Val.FRoleData.RoleIdentifier;
end;

procedure TConsoleData.UnassignUserRoleData(Val: TUserRole);
begin
  FUserRoleData.FConsoleIP                      := '';
  FUserRoleData.isInUse                         := False;

  FUserRoleData.FData.UserRoleIndex             := 0;
  FUserRoleData.FData.RoleIndex                 := 0;
  FUserRoleData.FData.SubRoleIndex              := 0;
  FUserRoleData.FData.UserRoleAcronim           := '';
  FUserRoleData.FData.UserRoleIdentifier        := '';
  FUserRoleData.FData.Username                  := '';
  FUserRoleData.FData.Password                  := '';

  FUserRoleData.FSubRoleData.SubRoleIndex       := 0;
  FUserRoleData.FSubRoleData.RoleIndex          := 0;
  FUserRoleData.FSubRoleData.SubRoleAcronim     := '';
  FUserRoleData.FSubRoleData.SubRoleIdentifier  := '';
  FUserRoleData.FSubRoleData.Perencanaan        := 0;
  FUserRoleData.FSubRoleData.Persiapan          := 0;
  FUserRoleData.FSubRoleData.Pelaksanaan        := 0;
  FUserRoleData.FSubRoleData.Pengakhiran        := 0;

  FUserRoleData.FRoleData.RoleIndex             := 0;
  FUserRoleData.FRoleData.RoleAcronim           := '';
  FUserRoleData.FRoleData.RoleIdentifier        := '';
end;

{$ENDREGION}

{$REGION ' TFile_Data '}

constructor TFile_Data.Create;
begin

end;

destructor TFile_Data.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TTabProperties '}

constructor TTabProperties.Create;
begin

end;

destructor TTabProperties.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TTabPropertiesContainer '}

constructor TTabPropertiesContainer.Create;
begin
  TabList := TList.Create;
end;

destructor TTabPropertiesContainer.Destroy;
begin
  TabList.Free;
  inherited;
end;

function TTabPropertiesContainer.GetActiveTab(IdRole, IdTag : Integer): Boolean;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin
  Result := False;

  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if (tabPropertiesTemp.FIdUserRoleTab = IdRole) and (tabPropertiesTemp.FIdTab = IdTag) then
    begin
      if tabPropertiesTemp.FActiveTab then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

end;

function TTabPropertiesContainer.GetCaptionTab(IdRole, IdTag : Integer): string;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin
  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if (tabPropertiesTemp.FIdUserRoleTab = IdRole) and (tabPropertiesTemp.FIdTab = IdTag) then
      Result := tabPropertiesTemp.FCaptionTab;
  end;
end;

function TTabPropertiesContainer.GetCountActiveTab(IdRole : Integer): Integer;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin
  Result := 0;

  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if tabPropertiesTemp.FActiveTab then
      inc(Result)
  end;

end;

function TTabPropertiesContainer.GetTapProperties(IdRole, IdTag : Integer): TTabProperties;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin

  Result := nil;

  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if (tabPropertiesTemp.FIdUserRoleTab = IdRole) and (tabPropertiesTemp.FIdTab = IdTag) then
    begin
      Result := tabPropertiesTemp;
      Break;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TChatting '}

constructor TChatting.Create;
begin

end;

destructor TChatting.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TChattingContainer '}

constructor TChattingContainer.Create;
begin
  ChattingList := TList.Create;
end;

destructor TChattingContainer.Destroy;
begin
  ChattingList.Free;
  inherited;
end;

function TChattingContainer.GetChattingBySending(IdRoleReceiving, IdRoleSending : Integer; var chatList : TList): Boolean;
var
  i : Integer;
  chattingTemp : TChatting;
begin
  for i := 0 to FChattingList.Count - 1 do
  begin
    chattingTemp := FChattingList.Items[i];

//    if (chattingTemp.FIdUserRoleReceive = IdRoleReceiving) and (chattingTemp.FIdUserRoleSending = IdRoleReceiving) then
      if (chattingTemp.FIdUserRoleReceive = IdRoleReceiving) or (chattingTemp.FIdUserRoleSending = IdRoleSending) then
      chatList.Add(chattingTemp);

  end;
end;

function TChattingContainer.GetChattingByUserRole(UserRoleId: Integer; var chatList: TList): Boolean;
var
  i : Integer;
  chattingTemp : TChatting;
begin
  for i := 0 to FChattingList.Count - 1 do
  begin
    chattingTemp := FChattingList.Items[i];

    if (chattingTemp.FIdUserRoleReceive = UserRoleId) then
      chatList.Add(chattingTemp);
  end;
end;

{$ENDREGION}

{$REGION ' TGame_Area_Definition '}

constructor TGame_Area_Definition.Create;
begin

end;

destructor TGame_Area_Definition.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$Region ' TTactical_Symbol ' }

constructor TTactical_Symbol.Create;
begin

end;

destructor TTactical_Symbol.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TOverlayContainer '}

constructor TOverlayTabContainer.Create;
begin
  FTabList := TList.Create;
end;

destructor TOverlayTabContainer.Destroy;
begin
  FTabList.Free;
  inherited;
end;

procedure TOverlayTabContainer.Draw(FCanvas: TCanvas; Map1: TMap; IdOverlayTab : Integer);
var
  i : Integer;
  overlayTabTemp : TOverlayTab;

begin
  for I := 0 to FTabList.Count - 1 do
  begin
    overlayTabTemp := FTabList[I];

    if overlayTabTemp.FIdOverlayTab = IdOverlayTab  then
      overlayTabTemp.Draw(FCanvas);
  end;
end;

function TOverlayTabContainer.GetOverlayTabByID(IdOverlay: Integer): TOverlayTab;
var
  i : Integer;
  overlayTabTemp : TOverlayTab;

begin
  Result := nil;

  for i := 0 to FTabList.Count - 1 do
  begin
    overlayTabTemp := TOverlayTab(FTabList.Items[i]);

    if overlayTabTemp.FIdOverlayTab = IdOverlay then
    begin
      Result := overlayTabTemp;
    end;
  end;
end;

procedure TOverlayTabContainer.AddOverlayTab(OvelayTab: TOverlayTab);
begin
  FTabList.Add(OvelayTab);
end;

procedure TOverlayTabContainer.RemoveOverlayTab(OvelayTab: TOverlayTab);
begin
  FTabList.Remove(OvelayTab);
end;

{$ENDREGION}

{$REGION ' TOverlayTab '}

constructor TOverlayTab.create;
begin
  FMemberList := TList.Create;
end;

destructor TOverlayTab.Destroy;
begin
  FMemberList.Free;
  inherited;
end;

procedure TOverlayTab.Draw(FCanvas: TCanvas);
var
  i : Integer;
  mainShape : TMainShape;

begin
  for i := 0 to FMemberList.Count - 1 do
  begin
    mainShape := FMemberList[i];
    mainShape.Draw(FCanvas);
  end;
end;

function TOverlayTab.GetShapeById(IdShape: Integer): TMainShape;
var
  i : Integer;
  mainShapeTemp : TMainShape;

begin
  Result := nil;

  for i := 0 to MemberList.Count - 1 do
  begin
    mainShapeTemp := TMainShape(MemberList.Items[i]);

    if mainShapeTemp.ShapeId = IdShape then
    begin
      Result := mainShapeTemp;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TMainShape '}

procedure TMainShape.changeBitmapColor(bmp: TBitmap; clr: TColor);
type
    TArrayByte = array[0..255] of Byte;
    PAByte = ^TArrayByte;
var i, j: Integer;
    pB : PAByte;
    hPal: HPALETTE;
    dClr, bClr : byte;
begin
  bmp.PixelFormat := pf8bit;
  hPal   := bmp.Palette;
  bClr := GetNearestPaletteIndex(hPal, clBlack);
  dClr := GetNearestPaletteIndex(hPal, clr);

  for j := 0 to bmp.Height - 1 do begin
    pb := bmp.ScanLine[j];
    for i := 0 to bmp.Width-1  do  begin
      if pB[i] = bClr then
        pB[i] := dClr;
    end;
  end;
end;

procedure TMainShape.Clear;
begin

end;

constructor TMainShape.Create(cvt: TCoordConverter);
begin
  FConverter := cvt;
  TempHuruf := TFont.Create;
end;

destructor TMainShape.Destroy;
begin
  TempHuruf.Free;

  inherited;
end;

procedure TMainShape.Draw(aCnv: TCanvas);
begin

end;

procedure TMainShape.drawObjek(FCanvas: TCanvas; id, x, y: Integer);
var
  x1, y1 : Integer;
  lengthName : Integer;
  bmp : TBitmap;

begin
  with FCanvas do
  begin
    Pen.Style := psSolid;
    Brush.Style := bsClear;

    {draw lambang}
    bmp := TBitmap.Create;
    case id of
      ovIntelijen, ovLogistic :
      begin
        bmp.Transparent := true;
        bmp.LoadFromFile(vGameDataSetting.ImgPath + pctLogisticPoint + '.bmp');
      end;
      ovRadar: bmp.LoadFromFile(vGameDataSetting.ImgPath + pctBaseRadar + '.bmp');
      ovPangkalan: bmp.LoadFromFile(vGameDataSetting.ImgPath + pctBaseAL + '.bmp');
      ovPanah:
      begin
        bmp.Transparent := true;
        bmp.LoadFromFile(vGameDataSetting.ImgPath + pctPanah + '.bmp');
      end;
    end;
    changeBitmapColor(bmp, ShapeOutline);

    x1 := x - (bmp.Width div 2);
    y1 := y - (bmp.Height div 2);

    Draw(x1, y1, bmp);

    {draw name}
    if not isShow then
    begin
      lengthName := (length(Identifier) div 2) * 8;
      SetStyleHuruf(FCanvas, fsBold, 10, ShapeOutline, 'Maiandra GD');
      TextOut(round(x-lengthName), round(y + (bmp.Height/2)), Identifier);
    end;

    bmp.Free;
  end;
end;

procedure TMainShape.Normalized(aCnv: TCanvas);
begin
  with aCnv do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := psSolid;
  end;
end;

function TMainShape.PackingInfo(OldStatus: string): string;
var
  s, i : Integer;
begin
  Result := OldStatus;

  s := Length(OldStatus);
  if s < 40 then
  begin
    for i := s to 39 do
    begin
      Result := Result + ' ';
    end;
  end;
end;

function TMainShape.PackingName(OldName: string): string;
var
  s, i : Integer;
begin
  Result := OldName;

  s := Length(OldName);
  if s < 16 then
  begin
    for i := s to 20 do
    begin
      Result := Result + ' ';
    end;
  end;
end;

function TMainShape.PackingQty(OldQty: Integer): string;
var
  NewQty : Double;
begin
  Result := IntToStr(OldQty);

  if OldQty > 999 then
  begin
    NewQty := OldQty div 1000;
    OldQty := Round(NewQty);
    Result := IntToStr(OldQty) + 'K';
  end;
end;

procedure TMainShape.SetLineProp(var gx: Integer; x, gx1, gx2: Integer);
var
  range1, range2 : Integer;

begin
  range1 := Abs(x - (gx1));
  range2 := Abs(x - (gx2));

  if range1 < range2 then
    gx := gx1
  else
    gx := gx2;
end;

procedure TMainShape.SetStyleHuruf(iCvs: TCanvas; iStyle: TFontStyle; iSize, iColor: Integer; iName: string);
begin
  with iCvs do
  begin
    Brush.Style := bsClear;
    Font.Style  := [iStyle];

    if iStyle <> fsBold then
      Font.Style  := [];

    Font.Size   := iSize;
    Font.Color  := iColor;
    Font.Name   := iName;
  end;
end;

function TMainShape.SetTempHuruf(Huruf: TFont; id: Byte): TFont;
begin
  case id of
    0:
    begin
      TempHuruf.Style  := Huruf.Style;
      TempHuruf.Name   := Huruf.Name;
      TempHuruf.Size   := Huruf.Size;
      TempHuruf.Color  := Huruf.Color;
    end;
    1:
    begin
      Huruf.Style := TempHuruf.Style;
      Huruf.Name  := TempHuruf.Name;
      Huruf.Size  := TempHuruf.Size;
      Huruf.Color := TempHuruf.Color;
    end;
  end;

  Result := Huruf;
end;

{$ENDREGION}

{$REGION ' TTextShape }

constructor TTextShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TTextShape.Destroy;
begin

  inherited;
end;

procedure TTextShape.Draw(aCnv: TCanvas);
var
  sx, sy: Integer;
begin
  inherited;

  with aCnv do
  begin
    Converter.ConvertToScreen(postStart.X, postStart.Y, sx, sy);

    Brush.Style := bsClear;

    Font.Color := ShapeOutline;
    Font.Size := size;

    if isSelected then
     Font.Color  := clWhite;

    TextOut(sx, sy, words);

    {font dinormalkan lagi}
    Font.Size := 10;
  end;
end;

{$ENDREGION}

{$REGION ' TLineShape '}
constructor TLineShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TLineShape.Destroy;
begin
   inherited;
end;

procedure TLineShape.Draw(aCnv: TCanvas);
var
  sx, sy, ex, ey: Integer;
begin
  inherited;

  Converter.ConvertToScreen(postStart.X, postStart.Y, sx, sy);
  Converter.ConvertToScreen(postEnd.X, postEnd.Y, ex, ey);

  with aCnv do
  begin
    Brush.Style := bsClear;
    Pen.Width := LineWeight;
    Pen.Style := LineType;
    Pen.Color := ShapeOutline;

    if isSelected then
     Pen.color   := clWhite;

    MoveTo(sx, sy);
    LineTo(ex, ey);
  end;
  Normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TRectangleShape '}
constructor TRectangleShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TRectangleShape.Destroy;
begin
  inherited;
end;

procedure TRectangleShape.Draw(aCnv: TCanvas);
var
  sx, sy, ex, ey: Integer;
begin
  inherited;

  Converter.ConvertToScreen(postStart.X, postStart.Y, sx, sy);
  Converter.ConvertToScreen(postEnd.X, postEnd.Y, ex, ey);

  with aCnv do
  begin
    Pen.Color := ShapeOutline;
    Pen.Width := LineWeight;
    Pen.Style := LineType;

    if BrushStyle = bsClear then
    begin
      Brush.Style := BrushStyle
    end
    else
    begin
      Brush.Style := BrushStyle;
      Brush.Color := ShapeFill;
    end;

    if isSelected then
     Pen.color   := clWhite;

    Rectangle(sx, sy, ex, ey);
  end;
  Normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TCircleShape' }
constructor TCircleShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TCircleShape.Destroy;
begin
  inherited;
end;

procedure TCircleShape.Draw(aCnv: TCanvas);
var
  cx, cy, ex, ey, r: Integer;
  dx, dy : Double;
  point : TRect;
  bmp : TBitmap;
begin
  inherited;

  dx := postCenter.X + radius/60;
  dy := postCenter.Y;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(dx, dy, ex, ey);

  r := Abs(cx - ex);

  point.Left    := cx - r;
  point.Top     := cy - r;
  point.Right   := cx + r;
  point.Bottom  := cy + r;

  with aCnv do
  begin
    Brush.Style := bsClear;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
    bmp.LoadFromFile(vGameDataSetting.ImgPath + pctFlagPoint + '.bmp');

    cx := cx - (bmp.Width div 2);
    cy := cy - (bmp.Height div 2);

    Draw(cx, cy, bmp);
    bmp.Free;

    Pen.Color := ShapeOutline;
    Pen.Width := LineWeight;
    Pen.Style := LineType;

    if BrushStyle = bsClear then
    begin
      Brush.Style := BrushStyle
    end
    else
    begin
      Brush.Style := BrushStyle;
      Brush.Color := ShapeFill;
    end;

    if isSelected then
     Pen.color   := clWhite;

    Ellipse(point.Left, point.Top, point.Right, point.Bottom);

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TEllipseShape '}

constructor TEllipseShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TEllipseShape.Destroy;
begin
   inherited;
end;

procedure TEllipseShape.Draw(aCnv: TCanvas);
var
  cx, cy, ex, ey, Hr, Vr: Integer;
  dx, dy : Double;
  point : TRect;
  bmp : TBitmap;
begin
  inherited;

  dx := postCenter.X + Hradius/60;
  dy := postCenter.Y + Vradius/60;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(dx, dy, ex, ey);

  Hr := Abs(cx - ex);
  Vr := Abs(cy - ey);

  point.Left    := cx - Hr;
  point.Top     := cy - Vr;
  point.Right   := cx + Hr;
  point.Bottom  := cy + Vr;

  with aCnv do
  begin
    Brush.Style := bsClear;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
    bmp.LoadFromFile(vGameDataSetting.ImgPath + pctFlagPoint + '.bmp');

    cx := cx - (bmp.Width div 2);
    cy := cy - (bmp.Height div 2);

    Draw(cx, cy, bmp);
    bmp.Free;

    Pen.Color := ShapeOutline;
    Pen.Width := LineWeight;
    Pen.Style := LineType;

    if BrushStyle = bsClear then
    begin
      Brush.Style := BrushStyle
    end
    else
    begin
      Brush.Style := BrushStyle;
      Brush.Color := ShapeFill;
    end;

    if isSelected then
     Pen.color   := clWhite;

    Ellipse(point.Left, point.Top, point.Right, point.Bottom);

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TArcShape '}
constructor TArcShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TArcShape.Destroy;
begin
  inherited;
end;

procedure TArcShape.Draw(aCnv: TCanvas);
var
  cx, cy, sx, sy, ex, ey,
  tx, ty, r: Integer;
  dx, dy : Double;
  StartPoint, EndPoint  :  t2DPoint;
  point : TRect;
  bmp : TBitmap;
begin
  inherited;

  FindPoint(postCenter, StartPoint, radius, StartAngle);  {Start Angle}
  FindPoint(postCenter, EndPoint, radius, EndAngle);      {End Angle}

  dx := postCenter.X + radius/60;
  dy := postCenter.Y ;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(StartPoint.X, StartPoint.Y, sx, sy);
  Converter.ConvertToScreen(EndPoint.X, EndPoint.Y, ex, ey);

  Converter.ConvertToScreen(dx, dy, tx, ty);
  r := Abs(cx - tx);

  point.Left    := cx - r;
  point.Top     := cy - r;
  point.Right   := cx + r;
  point.Bottom  := cy + r;

  with aCnv do
  begin
    Brush.Style := bsClear;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
    bmp.LoadFromFile(vGameDataSetting.ImgPath + pctFlagPoint + '.bmp');

    cx := cx - (bmp.Width div 2);
    cy := cy - (bmp.Height div 2);

    Draw(cx, cy, bmp);
    bmp.Free;

    Pen.Color := ShapeOutline;
    Pen.Width := LineWeight;
    Pen.Style := LineType;

    Brush.Style := bsClear;

    if isSelected then
     Pen.color   := clWhite;

    Arc(point.Left, point.Top, point.Right, point.Bottom, ex, ey, sx, sy);

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TSectorShape '}
constructor TSectorShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TSectorShape.Destroy;
begin
  inherited;
end;

procedure TSectorShape.Draw(aCnv: TCanvas);
var
  cx, cy,
  Isx, Isy, Iex, Iey,
  Osx, Osy, Oex, Oey,
  tx, ty, rIn, rOut  : Integer;
  Idx, Idy, Odx, Ody : Double;
  IStartPoint, IEndPoint : t2DPoint;
  OStartPoint, OEndPoint : t2DPoint;
  Ipoint, Opoint : TRect;
  bmp : TBitmap;
begin
  inherited;

  FindPoint(postCenter, IStartPoint, Iradius, StartAngle);  {Start Angle}
  FindPoint(postCenter, IEndPoint, Iradius, EndAngle);      {End Angle}

  FindPoint(postCenter, OStartPoint, Oradius, StartAngle);  {Start Angle}
  FindPoint(postCenter, OEndPoint, Oradius, EndAngle);      {End Angle}

  Idx := postCenter.X + Iradius/60;
  Idy := postCenter.Y;

  Odx := postCenter.X + Oradius/60;
  Ody := postCenter.Y;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(IStartPoint.X, IStartPoint.Y, Isx, Isy);
  Converter.ConvertToScreen(IEndPoint.X, IEndPoint.Y, Iex, Iey);
  Converter.ConvertToScreen(Idx, Idy, tx, ty);

  rIn := Abs(cx - tx);
  Ipoint.Left    := cx - rIn;
  Ipoint.Top     := cy - rIn;
  Ipoint.Right   := cx + rIn;
  Ipoint.Bottom  := cy + rIn;

  Converter.ConvertToScreen(OStartPoint.X, OStartPoint.Y, Osx, Osy);
  Converter.ConvertToScreen(OEndPoint.X, OEndPoint.Y, Oex, Oey);
  Converter.ConvertToScreen(Odx, Ody, tx, ty);

  rOut := Abs(cx - tx);
  Opoint.Left    := cx - rOut;
  Opoint.Top     := cy - rOut;
  Opoint.Right   := cx + rOut;
  Opoint.Bottom  := cy + rOut;

  with aCnv do
  begin
    Brush.Style := bsClear;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
    bmp.LoadFromFile(vGameDataSetting.ImgPath + pctFlagPoint + '.bmp');

    cx := cx - (bmp.Width div 2);
    cy := cy - (bmp.Height div 2);

    Draw(cx, cy, bmp);
    bmp.Free;

    Pen.Color := ShapeOutline;
    Pen.Width := LineWeight;
    Pen.Style := LineType;

    Brush.Style := bsClear;

    if isSelected then
     Pen.color   := clWhite;

    Arc(Ipoint.Left, Ipoint.Top, Ipoint.Right, Ipoint.Bottom, Iex, Iey, Isx, Isy);
    Arc(Opoint.Left, Opoint.Top, Opoint.Right, Opoint.Bottom, Oex, Oey, Osx, Osy);
    MoveTo(Iex, Iey); LineTo(Oex, Oey);
    MoveTo(Isx, Isy); LineTo(Osx, Osy);

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TGridShape '}

constructor TGridShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TGridShape.Destroy;
begin
  inherited;
end;

procedure TGridShape.Draw(aCnv: TCanvas);
var
  i,
  Isx, Isy, Iex, Iey,
  Osx, Osy, Oex, Oey : Integer;

  TempX, TempY,
  Idx, Idy, Odx, Ody : Double;

  IStart, IEnd, OStart, OEnd,
  Row1, Row2, Row3, Row4,
  Col1, Col2, Col3, Col4  : t2DPoint;

  NewBearing, NewRange,
  RKiAts, RKaAts, RKiBwh, RKaBwh,
  BKiAts, BKaAts, BKiBwh, BKaBwh : Double;

begin
  inherited;

  //Point Kiri Atas
  IStart.X := postCenter.X - ((Width/60)*(WCount/2));
  IStart.Y := postCenter.Y + ((Height/60)*(HCount)/2);

  //Point Kanan Atas
  IEnd.X := postCenter.X + ((Width/60)*(WCount/2));
  IEnd.Y := postCenter.Y + ((Height/60)*(HCount)/2);

  //Point Kanan Bawah
  OStart.X := postCenter.X + ((Width/60)*(WCount/2));
  OStart.Y := postCenter.Y - ((Height/60)*(HCount)/2);

  //Point Kiri Bawah
  OEnd.X := postCenter.X - ((Width/60)*(WCount/2));
  OEnd.Y := postCenter.Y - ((Height/60)*(HCount)/2);

  BKiAts   := CalcBearing(postCenter.X, postCenter.Y, IStart.X, IStart.Y);
  BKaAts  := CalcBearing(postCenter.X, postCenter.Y, IEnd.X, IEnd.Y);
  BKaBwh := CalcBearing(postCenter.X, postCenter.Y, OStart.X, OStart.Y);
  BKiBwh  := CalcBearing(postCenter.X, postCenter.Y, OEnd.X, OEnd.Y);

  RKiAts     := CalcRange(postCenter.X, postCenter.Y, IStart.X, IStart.Y);
  RKaAts    := CalcRange(postCenter.X, postCenter.Y, IEnd.X, IEnd.Y);
  RKaBwh   := CalcRange(postCenter.X, postCenter.Y, OStart.X, OStart.Y);
  RKiBwh    := CalcRange(postCenter.X, postCenter.Y, OEnd.X, OEnd.Y);

  FindPoint(postCenter, IStart, RKiAts, BKiAts + Rotation);
  FindPoint(postCenter, IEnd, RKaAts, BKaAts + Rotation);
  FindPoint(postCenter, OStart, RKaBwh, BKaBwh + Rotation);
  FindPoint(postCenter, OEnd, RKiBwh, BKiBwh + Rotation);

  // Point 1
  Row1 := IStart;
  Col1 := IStart;

  // Point 2
  Row2 := IEnd;
  Col2 := IEnd;

  // Point 3
  Row3 := OEnd;
  Col3 := OEnd;

  // Point 4
  Row4 := OStart;
  Col4 := OStart;

  Converter.ConvertToScreen(IStart.X,  IStart.Y,  Isx, Isy);
  Converter.ConvertToScreen(IEnd.X,    IEnd.Y,    Iex, Iey);
  Converter.ConvertToScreen(OStart.X,  OStart.Y,  Osx, Osy);
  Converter.ConvertToScreen(OEnd.X,    OEnd.Y,    Oex, Oey);

  with aCnv do
  begin
    Pen.Color := ShapeOutline;
    Pen.Width := LineWeight;
    Pen.Style := LineType;

    Brush.Style := bsClear;

    if isSelected then
     Pen.color   := clWhite;

    MoveTo(Isx, Isy); LineTo(Iex, Iey);
  end;

  for i := 1 to HCount do // loop for baris
  begin
    // Point 3
    TempX := Row1.X;
    TempY := Row1.Y - (Height / 60);

    NewBearing := CalcBearing(Row1.X, Row1.Y, TempX, TempY);
    NewRange := CalcRange(Row1.X, Row1.Y, TempX, TempY);
    FindPoint(Row1, Row3, NewRange, NewBearing + Rotation);

    // Point 4
    TempX := Row2.X;
    TempY := Row2.Y - (Height / 60);

    NewBearing := CalcBearing(Row2.X, Row2.Y, TempX, TempY);
    NewRange := CalcRange(Row2.X, Row2.Y, TempX, TempY);
    FindPoint(Row2, Row4, NewRange, NewBearing + Rotation);

    Converter.ConvertToScreen(Row1.X, Row1.Y, Isx, Isy);
    Converter.ConvertToScreen(Row2.X, Row2.Y, Iex, Iey);
    Converter.ConvertToScreen(Row3.X, Row3.Y, Osx, Osy);
    Converter.ConvertToScreen(Row4.X, Row4.Y, Oex, Oey);

    with aCnv do
    begin
      MoveTo(Isx, Isy); LineTo(Osx, Osy);
      MoveTo(Osx, Osy); LineTo(Oex, Oey);
      MoveTo(Iex, Iey); LineTo(Oex, Oey);
    end;

    Row1.X := Row3.X;
    Row1.Y := Row3.Y;
    Row2.X := Row4.X;
    Row2.Y := Row4.Y;
  end;

  for i := 1 to WCount do // loop for kolom
  begin
    // Point 2
    TempX := Col1.X + (Width / 60);
    TempY := Col1.Y;

    NewBearing := CalcBearing(Col1.X, Col1.Y, TempX, TempY);
    NewRange := CalcRange(Col1.X, Col1.Y, TempX, TempY);
    FindPoint(Col1, Col2, NewRange, NewBearing + Rotation);

    // Point 4
    TempX := Col3.X + (Width / 60);
    TempY := Col3.Y;

    NewBearing := CalcBearing(Col3.X, Col3.Y, TempX, TempY);
    NewRange := CalcRange(Col3.X, Col3.Y, TempX, TempY);
    FindPoint(Col3, Col4, NewRange, NewBearing + Rotation);

    Converter.ConvertToScreen(Col1.X, Col1.Y, Isx, Isy);
    Converter.ConvertToScreen(Col2.X, Col2.Y, Iex, Iey);
    Converter.ConvertToScreen(Col3.X, Col3.Y, Osx, Osy);
    Converter.ConvertToScreen(Col4.X, Col4.Y, Oex, Oey);

    with aCnv do
    begin
      MoveTo(Isx, Isy); LineTo(Iex, Iey);
      MoveTo(Iex, Iey); LineTo(Oex, Oey);
      MoveTo(Osx, Osy); LineTo(Oex, Oey);
    end;

    Col1.X := Col2.X;
    Col1.Y := Col2.Y;
    Col3.X := Col4.X;
    Col3.Y := Col4.Y;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TPolygonShape '}

constructor TPolygonShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TPolygonShape.Destroy;
begin
  inherited;
end;

procedure TPolygonShape.Draw(aCnv: TCanvas);
var
  i,
  Isx, Isy : Integer;
  point : TDotShape;
  polyPoint : Array of TPoint;
begin
  inherited;
  SetLength(polyPoint, polyList.Count);

  for i := 0 to polyList.Count - 1 do
  begin
    point := polyList.Items[i];

    Converter.ConvertToScreen(point.X, point.Y, Isx, Isy);
    polyPoint[i].x := Isx;
    polyPoint[i].y := Isy;
  end;

  with aCnv do
  begin
    Pen.Color := ShapeOutline;
    Pen.Width := LineWeight;
    Pen.Style := LineType;

    if BrushStyle = bsClear then
      Brush.Style := BrushStyle
    else
    begin
      Brush.Style := BrushStyle;;
      Brush.Color := ShapeFill;
    end;

    if isSelected then
     Pen.color   := clWhite;

    Polygon(polyPoint);
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TDotShape '}

constructor TDotShape.Create;
begin
//  inherited;
end;

destructor TDotShape.Destroy;
begin
  inherited;
end;

{$ENDREGION}

{$REGION ' TFlagPoint '}

constructor TFlagPoint.Create(cvt: TCoordConverter);
begin
  FConverter := cvt;
end;

destructor TFlagPoint.Destroy;
begin
  inherited;
end;

procedure TFlagPoint.Draw(aCnv: TCanvas);
var
  x, y : Integer;
  bmp : TBitmap;
begin
  with aCnv do
  begin
    Converter.ConvertToScreen(Post.X, Post.Y, x, y);

    Brush.Style := bsClear;
    Pen.Style := psSolid;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
    bmp.LoadFromFile(vGameDataSetting.ImgPath + pctFlagPoint + '.bmp');

    x := x - (bmp.Width div 2);
    y := y - (bmp.Height div 2);

    Draw(x, y, bmp);
    bmp.Free;

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
end;

{$ENDREGION}

{$REGION ' TIntelijenShape '}

constructor TIntelijenShape.Create(cvt: TCoordConverter);
begin
  inherited;
  InfoList := TList.Create;
end;

destructor TIntelijenShape.Destroy;
begin
  inherited;
  InfoList.Free;
end;

procedure TIntelijenShape.Draw(FCanvas: TCanvas);
var
  i, x, y, cx, cy, gx, lengthName : Integer;
  infoIntel : TIntelijenInfo;
  Point : array of TPoint;
begin
  inherited;
  SetTempHuruf(FCanvas.Font, 0);
  Converter.ConvertToScreen(postCenter.X, postCenter.Y, x, y);
  drawObjek(FCanvas, ovIntelijen, x, y);

  Converter.ConvertToScreen(TableProp.X, TableProp.Y, cx, cy);
  with FCanvas do
  begin
    if isShow then
    begin
      {Table}
      Pen.Color := ShapeOutline;
      Pen.Style := psSolid;

      {$REGION ' Menggambar callout dari titik ke table '}
      SetLineProp(gx, x, Round(cx+50), Round(cx+370));
      Brush.Color := ShapeOutline;
      SetLength(Point, 3);
      Point[0].X := x;
      Point[0].Y := y;
      Point[1].X := gx;
      Point[1].Y := cy-50;
      Point[2].X := gx;
      Point[2].Y := cy-30;
      Polygon(Point);
      {$ENDREGION}

      Pen.Style := psSolid;

      {$REGION ' Background Table '}
      Brush.Color := clWhite;
      Rectangle(cx+50, cy-50, cx+370, cy +((InfoList.Count-1) * 16));
      {$ENDREGION}

      {$REGION ' Header Table '}
      lengthName := (length(Identifier) div 2) * 11;

      SetStyleHuruf(FCanvas, fsBold, 12, clWhite, 'Maiandra GD');
      Brush.Color := ShapeOutline;
      Rectangle(cx+50, cy-50, cx+370, cy - 30);
      TextOut(round(cx + (210 - lengthName)), cy-50, Identifier);
      {$ENDREGION}

      {$REGION ' Isi Table '}
      SetStyleHuruf(FCanvas, fsItalic, 10, ShapeOutline, 'Courier New');
      for I := 0 to InfoList.Count - 1 do
      begin
        infoIntel := InfoList[i];
        TextOut(cx+60, cy-25, PackingInfo(infoIntel.Info));
        cy:= cy + 16;
      end;
      {$ENDREGION}

    end;

    Font := SetTempHuruf(Font, 1);
  end;
end;

{$ENDREGION}

{$REGION ' TLogisticShape '}

constructor TLogisticShape.Create(cvt: TCoordConverter);
begin
  inherited;
  LogisticList := TList.Create;
end;

destructor TLogisticShape.Destroy;
begin
  inherited;
  LogisticList.Free;
end;

procedure TLogisticShape.Draw(FCanvas: TCanvas);
var
  i, x, y, cx, cy, gx, lengthName : Integer;
  LogisticOnBase : TLogisticOnBase;
  Point : array of TPoint;
begin
  inherited;
  SetTempHuruf(FCanvas.Font, 0);

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, x, y);
  drawObjek(FCanvas, ovLogistic, x, y);
  Converter.ConvertToScreen(TableProp.X, TableProp.Y, cx, cy);

  with FCanvas do
  begin
    if isShow then
    begin
      {Table}
      Pen.Color := ShapeOutline;
      Pen.Style := psSolid;

      {$REGION ' Menggambar callout dari titik ke table '}
      SetLineProp(gx, x, Round(cx+50), Round(cx+280));
      Brush.Color := ShapeOutline;
      SetLength(Point, 3);
      Point[0].X := x;
      Point[0].Y := y;
      Point[1].X := gx;
      Point[1].Y := cy-50;
      Point[2].X := gx;
      Point[2].Y := cy-30;
      Polygon(Point);
      {$ENDREGION}

      Pen.Style := psSolid;

      {$REGION ' Background Table '}
      Brush.Color := clWhite;
      Rectangle(cx+50, cy-50, cx+280, cy +((LogisticList.Count-1)*16));
      MoveTo(cx+220, cy-50); LineTo(cx+220, cy +((LogisticList.Count-1)*16));
      {$ENDREGION}

      {$REGION ' Header Table '}
      lengthName := (length(Identifier) div 2) * 11;

      SetStyleHuruf(FCanvas, fsBold, 12, clWhite, 'Maiandra GD');
      Brush.Color := ShapeOutline;
      Rectangle(cx+50, cy-50, cx+280, cy-30);
      TextOut(round(cx + (170 - lengthName)), cy-50, Identifier);
      {$ENDREGION}

      {$REGION ' Isi Table '}
      SetStyleHuruf(FCanvas, fsItalic, 10, ShapeOutline, 'Courier New');
      for I := 0 to LogisticList.Count - 1 do
      begin
        LogisticOnBase := LogisticList[i];
        TextOut(cx+60, cy-25, PackingName(LogisticOnBase.Name));
        TextOut(cx+225, cy-25, LogisticOnBase.Status);

        cy:= cy + 16;
      end;
      {$ENDREGION}

    end;

    Font := SetTempHuruf(Font, 1);
  end;
end;

{$ENDREGION}

{$REGION ' TPangkalanShape '}

constructor TPangkalanShape.Create(cvt: TCoordConverter);
begin
  inherited;
  VehiclesList := TList.Create;
end;

destructor TPangkalanShape.Destroy;
begin
  inherited;
  VehiclesList.Free;
end;

procedure TPangkalanShape.Draw(FCanvas: TCanvas);
var
  i, x, y, cx, cy, gx, lengthName : Integer;
  vehicleOnBase : TVehicleOnBase;
  Point : array of TPoint;
begin
  inherited;
  SetTempHuruf(FCanvas.Font, 0);
  Converter.ConvertToScreen(postCenter.X, postCenter.Y, x, y);
  drawObjek(FCanvas, ovPangkalan, x, y);
  Converter.ConvertToScreen(TableProp.X, TableProp.Y, cx, cy);

  with FCanvas do
  begin
    if isShow then
    begin
      {Table}
      Pen.Color := ShapeOutline;
      Pen.Style := psSolid;

      {$REGION ' Menggambar callout dari titik ke table '}
      SetLineProp(gx, x, Round(cx+50), Round(cx+300));
      Brush.Color := ShapeOutline;
      SetLength(Point, 3);
      Point[0].X := x;
      Point[0].Y := y;
      Point[1].X := gx;
      Point[1].Y := cy-50;
      Point[2].X := gx;
      Point[2].Y := cy-30;
      Polygon(Point);
      {$ENDREGION}

      Pen.Style := psSolid;

      {$REGION ' Background Table '}
      Brush.Color := clWhite;
      Rectangle(cx+50, cy-50, cx+300, cy +((VehiclesList.Count-1)*16));
      MoveTo(cx+220, cy-50); LineTo(cx+220, cy +((VehiclesList.Count-1)*16));
      MoveTo(cx+260, cy-50); LineTo(cx+260, cy +((VehiclesList.Count-1)*16));
      {$ENDREGION}

      {$REGION ' Header Table '}
      lengthName := (length(Identifier) div 2) * 11;

      SetStyleHuruf(FCanvas, fsBold, 12, clWhite, 'Maiandra GD');
      Brush.Color := ShapeOutline;
      Rectangle(cx+50, cy-50, cx+300, cy-30);
      TextOut(round(cx + (180 - lengthName)), cy-50, Identifier);
      {$ENDREGION}

      {$REGION ' Isi Table '}
      for I := 0 to VehiclesList.Count - 1 do
      begin
        vehicleOnBase := VehiclesList[i];
        SetStyleHuruf(FCanvas, fsItalic, 10, ShapeOutline, 'Courier New');
        TextOut(cx+60, cy-25, PackingName(vehicleOnBase.Name));
        TextOut(cx+230, cy-25, PackingQty(vehicleOnBase.Quantity));

        SetStyleHuruf(FCanvas, fsBold, 15, ShapeOutline, 'TAKTIS_AL');
        TextOut(cx+270, cy-26,((vehicleOnBase.Simbol)));

        cy:= cy + 16;
      end;
      {$ENDREGION}

    end;
    Font := SetTempHuruf(Font, 1);
  end;
end;

{$ENDREGION}

{$REGION ' TRadarShape '}

constructor TRadarShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TRadarShape.Destroy;
begin

  inherited;
end;

procedure TRadarShape.Draw(FCanvas: TCanvas);
var
  cx, cy, ex, ey, r: Integer;
  dx, dy : Double;
  point : TRect;
begin
  inherited;
  SetTempHuruf(FCanvas.Font, 0);
  dx := postCenter.X + radius/60;
  dy := postCenter.Y;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(dx, dy, ex, ey);

  r := Abs(cx - ex);

  point.Left    := cx - r;
  point.Top     := cy - r;
  point.Right   := cx + r;
  point.Bottom  := cy + r;

  drawObjek(FCanvas, ovRadar, cx, cy);

  with FCanvas do
  begin
    Brush.Style := bsClear;

    Pen.Style := psSolid;
    Pen.Color := ShapeOutline;

    Brush.Color := clGray;
    Brush.Style := bsDiagCross;

    {draw range radar}
    if isShow then
      Ellipse(point.Left, point.Top, point.Right, point.Bottom);

    drawObjek(FCanvas, ovRadar, cx, cy);

    Font := SetTempHuruf(Font, 1);
  end;
end;

{$ENDREGION}

{$REGION ' TPanahShape '}

constructor TPanahShape.Create(cvt: TCoordConverter);
begin
  inherited;

end;

destructor TPanahShape.Destroy;
begin

  inherited;
end;

procedure TPanahShape.Draw(FCanvas: TCanvas);
var
   x, y : Integer;

  ROffset, BOffset : Double;

  p1, p2, p3, p4, p6, p7 : t2DPoint;
  x1, x2, x3, x4, x5, x6, x7, xe,
  y1, y2, y3, y4, y5, y6, y7, ye : Integer;

  bmp : TBitmap;
begin
  inherited;
  SetTempHuruf(FCanvas.Font, 0);

  BOffset := CalcBearing(postCenter.X, postCenter.Y, postEnd.X, postEnd.Y);
  ROffset := CalcRange(postCenter.X, postCenter.Y, postEnd.X, postEnd.Y);

  FindPoint(postCenter, p1, ROffset*0.20, ValidateDegree(BOffset-90));
  FindPoint(postCenter, p2, ROffset*0.20, ValidateDegree(BOffset+90));

  FindPoint(p1, p7, ROffset*0.75, BOffset);
  FindPoint(p2, p3, ROffset*0.75, BOffset);

  FindPoint(p7, p6, ROffset*0.30, ValidateDegree(BOffset-90));
  FindPoint(p3, p4, ROffset*0.30, ValidateDegree(BOffset+90));

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, x, y);
  Converter.ConvertToScreen(p1.X, p1.Y, x1, y1);
  Converter.ConvertToScreen(p2.X, p2.Y, x2, y2);
  Converter.ConvertToScreen(p3.X, p3.Y, x3, y3);
  Converter.ConvertToScreen(p4.X, p4.Y, x4, y4);
  Converter.ConvertToScreen(postEnd.X, postEnd.Y, x5, y5);
  Converter.ConvertToScreen(p6.X, p6.Y, x6, y6);
  Converter.ConvertToScreen(p7.X, p7.Y, x7, y7);

  drawObjek(FCanvas, ovPanah, x, y);

  with FCanvas do
  begin
    if isShow then
    begin
      {Table}
      Pen.Style := psSolid;
      Pen.Color := ShapeOutline;

      MoveTo(x1, y1); LineTo(x2, y2);
      MoveTo(x2, y2); LineTo(x3, y3);
      MoveTo(x3, y3); LineTo(x4, y4);
      MoveTo(x4, y4); LineTo(x5, y5);
      MoveTo(x5, y5); LineTo(x6, y6);
      MoveTo(x6, y6); LineTo(x7, y7);
      MoveTo(x7, y7); LineTo(x1, y1);

      {draw lambang}
      bmp := TBitmap.Create;
      bmp.Transparent := true;
      bmp.LoadFromFile(vGameDataSetting.ImgPath + pctPanah + '.bmp');
      changeBitmapColor(bmp, ShapeOutline);

      xe := x5 - (bmp.Width div 2);
      ye := y5 - (bmp.Height div 2);

      Draw(xe, ye, bmp);
      bmp.Free;
    end;
    Font := SetTempHuruf(Font, 1);
  end;
end;

{$ENDREGION}

{$REGION ' TVehicleOnBase '}

constructor TVehicleOnBase.create;
begin

end;

destructor TVehicleOnBase.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TLogisticOnBase '}

constructor TLogisticOnBase.create;
begin

end;

destructor TLogisticOnBase.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TIntelijenInfo '}

constructor TIntelijenInfo.create;
begin

end;

destructor TIntelijenInfo.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TFlagPointbContainer '}

procedure TFlagPointbContainer.Clear;
begin
  FFlagList.Clear;
end;

constructor TFlagPointbContainer.Create;
begin
  FFlagList := TList.Create;
end;

destructor TFlagPointbContainer.Destroy;
begin
  FFlagList.Free;

  inherited;
end;

procedure TFlagPointbContainer.Draw(FCanvas: TCanvas);
var
  i : Integer;
  item : TFlagPoint;
begin
  for i := 0 to FFlagList.Count - 1 do
  begin
    item := FFlagList[i];
    item.Draw(FCanvas);
  end;
end;

function TFlagPointbContainer.GetFlagPoint(FlagPointId: Integer): TFlagPoint;
var
  i : Integer;
  item : TFlagPoint;
begin
  Result := nil;
  for i := 0 to FFlagList.Count - 1 do
  begin
    item := FFlagList[i];

    if item.PointId = FlagPointId then
    begin
      Result := item;
      Exit;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TRuler '}

constructor TRuler.Create(cvt: TCoordConverter);
begin
  FConverter := cvt;
end;

destructor TRuler.Destroy;
begin

  inherited;
end;

procedure TRuler.Draw(FCanvas: TCanvas);
var
  sx, sy, ex, ey: Integer;
begin
  inherited;

  Converter.ConvertToScreen(postStart.X, postStart.Y, sx, sy);
  Converter.ConvertToScreen(postEnd.X, postEnd.Y, ex, ey);

  with FCanvas do
  begin
    Brush.Style := bsClear;

    Pen.Style := psDash;
    Pen.Width := 2;
    Pen.color := clYellow;
    if not IsVisible then
      Exit;
    MoveTo(sx, sy);
    LineTo(ex, ey);
    Pen.Color := clGreen;
    Rectangle(sx-1,sy-1,sx+1,sy+1);
    Pen.Color := clRed;
    Rectangle(ex-1,ey-1,ex+1,ey+1);
  end;
end;

{$ENDREGION}

{$REGION ' TAsset '}

constructor TAsset.Create;
begin

end;

destructor TAsset.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TFontTaktis '}

constructor TFontTaktis.Create;
begin

end;

destructor TFontTaktis.Destroy;
begin

  inherited;
end;

{$ENDREGION}

end.
