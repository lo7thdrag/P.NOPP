unit uT3SimManager;

interface

uses
  Classes, SysUtils, System.Win.Registry, System.Variants, Graphics, WbemScripting_TLB, Dialogs,
  Windows, forms, StrUtils, Math, DateUtils,

  MapXLib_TLB, uThreadTimer,  uVirtualTime, uLibSetting, uSimManager , uSimObjects, uT3UnitContainer,
  uT3EventManager, uT3Listener, uSteppers, uNetBaseSocket, uConsoleData, uClassData, uRecordData,
  uCoordConvertor, uConstantaData, uDataModule;

type

  TT3SimManager = class(TSimManager)
  protected

    FShapeID  : Integer;
    FTabSituationBoardID  : Integer;
    FChatId : Integer;

    procedure FGameThread_OnTerminate(sender: TObject);
    procedure FGameThread_OnRunning(const dt: double); virtual;
    procedure FGameThread_OnPaused(const dt: double); virtual;

    procedure FNetworkThread_OnRunning(const dt: double);virtual;
    procedure FNetworkThread_OnPaused(const dt: double); virtual;
    procedure FNetworkThread_OnTerminate(sender: TObject);

    procedure CreateMapConverter(Map : TMap);

  private

    FReg       : TRegistry;
    FConverter : TCoordConverter;

    function GetConsoleIdentification : Boolean;

  protected
    FSessionID : integer;

    procedure setSessionID(const Value: integer);

    { use by goto time }
    procedure Run(const dt : Double);virtual;

  public

    SimConsole : TConsoleContainer; {load dari xml}
    SimRole : TRoleContainer; {load dari database}
    SimSubRole : TSubRoleContainer; {load dari database}
    SimUserRole : TUserRoleContainer; {load dari database}
    SimTabProperties : TTabPropertiesContainer; {load saat running}
    SimChatting : TChattingContainer; {load saat running}
    SimOverlay : TOverlayTabContainer; {load saat running}

    EventManager    : TT3EventManager;

    constructor Create(Map : TMap);
    destructor Destroy; override;

    {$REGION ' Event Inherited '}
    function GetGameState: Boolean; virtual;

    procedure LoadConsoleID; virtual;
    procedure LoadDataAsset(const vSet: TGameDataSetting); virtual;

    procedure OnUserStateChange(const rec : TRecTCP_UserState); virtual;
    procedure OnSituationBoardTabPropertiesChange(const rec : TRecTCPSendSituationBoardTabProperties); virtual;
    procedure OnUserRoleChatChange(const rec : TRecTCPSendChatUserRole); virtual;
    procedure OnOverlayShape(const rec : TRecTCPSendOverlayShape); virtual;
    {$ENDREGION}

    function GetSerialTabSituationBoardID : Integer;
    function GetSerialShapeID : Integer;
    function GetSerialChatID : Integer;

    procedure GameStart; override;
    procedure GamePause; override;
    procedure GameTerminate; override;

    procedure InitNetwork; virtual;
    procedure StopNetwork;  virtual;

    property SessionID: integer read FSessionID write setSessionID;

    property Converter : TCoordConverter read FConverter;

end;

var
  SimManager: TT3SimManager;

implementation

{ TT3SimManager }

constructor TT3SimManager.Create(Map : TMap);
begin
  inherited Create;

  CreateMapConverter(Map);

  FShapeID := 0;
  FTabSituationBoardID := 0;
  FChatId := 0;

  FGameThread.Interval := 10;
  FGameThread.OnRunning   := FGameThread_OnRunning;
  FGameThread.OnTerminate := FGameThread_OnTerminate;
  FGameThread.Enabled := True;

  FNetworkThread.OnRunning := FNetworkThread_OnRunning;
  FNetworkThread.OnTerminate := FNetworkThread_OnTerminate;
  FNetworkThread.Enabled := True;

  SimConsole := TConsoleContainer.Create;
  SimRole := TRoleContainer.Create;
  SimSubRole := TSubRoleContainer.Create;
  SimUserRole := TUserRoleContainer.Create;
  SimTabProperties := TTabPropertiesContainer.Create;

  SimOverlay := TOverlayTabContainer.Create;

  SimChatting := TChattingContainer.Create;
//  SimOverlay.Converter := Converter;
end;

procedure TT3SimManager.CreateMapConverter(Map: TMap);
begin
  FConverter      := TCoordConverter.Create;
  FConverter.FMap := Map;
end;

destructor TT3SimManager.Destroy;
begin

  SimConsole.Free;
  SimRole.Free;
  SimSubRole.Free;
  SimUserRole.Free;
  SimTabProperties.Free;
  SimChatting.Free;

  inherited;
end;

procedure TT3SimManager.FGameThread_OnTerminate(sender: TObject);
begin

end;

procedure TT3SimManager.FGameThread_OnPaused(const dt: double);
begin

end;

procedure TT3SimManager.FGameThread_OnRunning(const dt: double);
begin
  if SimManager.GetGameState then
    FMainVTime.IncreaseMillisecond(dt * 1000.0 );
end;

procedure TT3SimManager.GameStart;
begin
//  inherited;
  if FGameState = gsStop then
  begin
    FGameThread.OnRunning := FGameThread_OnRunning;
    FGameState := gsPlaying;
  end;
end;

procedure TT3SimManager.GamePause;
begin
  if FGameState = gsPlaying then
  begin

    FGameThread.OnRunning := FGameThread_OnPaused;
    // thread do nothing. :P
    FGameState := gsStop;
  end;
end;

procedure TT3SimManager.GameTerminate;
begin
  FGameState := gsTerminated;
  FGameThread.Terminate;
end;

procedure TT3SimManager.Run(const dt: Double);
begin
  FMainVTime.IncreaseMillisecond(dt * 1000.0 );
end;

procedure TT3SimManager.setSessionID(const Value: integer);
begin
  FSessionID := Value;
end;

procedure TT3SimManager.LoadConsoleID;
begin
  if GetConsoleIdentification then
    SimConsole.LoadFromFile(vGameDataSetting.GroupSetting);
end;

procedure TT3SimManager.LoadDataAsset(const vSet: TGameDataSetting);
var
  i : Integer;
  listTemp : TList;
  roleTemp : TRole;
  subRoleTemp : TSubRole;
  userRoleTemp : TUserRole;

begin
  FMainVTime.Reset(0);
  FMainVTime.DateTimeOffset := 0;

  if GetConsoleIdentification then
  begin

    {$REGION ' Load Role '}
    listTemp := TList.Create;
    dmINWO.GetAllRole(listTemp);

    for i := 0 to listTemp.Count-1 do
    begin
      roleTemp := listTemp.Items[i];

      if Assigned(roleTemp) then
      begin
        SimRole.addRole(roleTemp);
      end;
    end;
    listTemp.Clear;
    {$ENDREGION}

    {$REGION ' Load SubRole '}
    listTemp := TList.Create;
    dmINWO.GetAllSubRole(listTemp);

    for i := 0 to listTemp.Count-1 do
    begin
      subRoleTemp := listTemp.Items[i];

      if Assigned(subRoleTemp) then
      begin
        SimSubRole.addSubRole(subRoleTemp);
      end;
    end;
    listTemp.Clear;
    {$ENDREGION}

    {$REGION ' Load UserRole '}
    listTemp := TList.Create;
    dmINWO.GetAllUserRole(listTemp);

    for i := 0 to listTemp.Count-1 do
    begin
      userRoleTemp := listTemp.Items[i];

      if Assigned(userRoleTemp) then
      begin
        subRoleTemp := SimSubRole.getSubRoleByID(userRoleTemp.FData.SubRoleIndex);

        if Assigned(subRoleTemp) then
          userRoleTemp.FSubRoleData := subRoleTemp.FData;

        roleTemp := SimRole.getRoleByID(userRoleTemp.FData.RoleIndex);

        if Assigned(roleTemp) then
          userRoleTemp.FRoleData := roleTemp.FData;

        SimUserRole.addUserRole(userRoleTemp);
      end;
    end;
    listTemp.Free;
    {$ENDREGION}
  end;
end;

procedure TT3SimManager.OnOverlayShape(const rec: TRecTCPSendOverlayShape);
var
  i, j : Integer;
  Point1 : TDotShape;
  TextShape : TTextShape;
  LineShape : TLineShape;
  RectangleShape : TRectangleShape;
  CircleShape : TCircleShape;
  EllipseShape : TEllipseShape;
  ArcShape : TArcShape;
  SectorShape : TSectorShape;
  GridShape : TGridShape;
  PolygonShape : TPolygonShape;
  overlayTabTemp : TOverlayTab;

  shipDataTemp  : TVehicleOnBase;
  logDataTemp : TLogisticOnBase;
  intelDataTemp : TIntelijenInfo;

  IntelijenShape : TIntelijenShape;
  LogisticShape : TLogisticShape;
  RadarShape : TRadarShape;
  BaseShape : TPangkalanShape;
  ArrowShape : TPanahShape;
  platformShape : TPlatformShape;

begin
  overlayTabTemp := SimOverlay.GetOverlayTabByID(rec.TemplateId);

  if Assigned(overlayTabTemp) then
  begin
    case rec.IdAction of
      caAdd, caEdit :
      begin
        case rec.ShapeType of
          ovText :
          begin
            {$Region' Text '}
            if rec.IdAction = caAdd then
            begin
              TextShape := TTextShape.Create(Converter);
              TextShape.ShapeId := GetSerialShapeID
            end
            else
              TextShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TTextShape;

            if Assigned(TextShape) then
            begin
              TextShape.postStart := rec.PostStart;
              TextShape.size := rec.Size;
              TextShape.words := rec.Words;
              TextShape.ShapeOutline := rec.color;
              TextShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(TextShape);
            end;

            {$ENDREGION}
          end;
          ovLine :
          begin
            {$Region' Line '}
            if rec.IdAction = caAdd then
            begin
              LineShape := TLineShape.Create(Converter);
              LineShape.ShapeId := GetSerialShapeID
            end
            else
              LineShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TLineShape;

            if Assigned(LineShape) then
            begin
              LineShape.postStart := rec.PostStart;
              LineShape.postEnd := rec.PostEnd;
              LineShape.ShapeOutline := rec.color;
              LineShape.ShapeFill := rec.ColorFill;
              LineShape.LineType := rec.lineType;
              LineShape.LineWeight := rec.weight;
              LineShape.BrushStyle := rec.BrushStyle;
              LineShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(LineShape);
            end;

            {$ENDREGION}
          end;
          ovRectangle :
          begin
            {$Region' Rectangle '}
            if rec.IdAction = caAdd then
            begin
              RectangleShape := TRectangleShape.Create(Converter);
              RectangleShape.ShapeId := GetSerialShapeID
            end
            else
              RectangleShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TRectangleShape;

            if Assigned(RectangleShape) then
            begin
              RectangleShape.postStart := rec.PostStart;
              RectangleShape.postEnd := rec.PostEnd;
              RectangleShape.ShapeOutline := rec.color;
              RectangleShape.ShapeFill := rec.ColorFill;
              RectangleShape.LineType := rec.lineType;
              RectangleShape.LineWeight := rec.weight;
              RectangleShape.BrushStyle := rec.BrushStyle;
              RectangleShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(RectangleShape);
            end;

            {$ENDREGION}
          end;
          ovCircle :
          begin
            {$Region' Circle '}
            if rec.IdAction = caAdd then
            begin
              CircleShape := TCircleShape.Create(Converter);
              CircleShape.ShapeId := GetSerialShapeID
            end
            else
              CircleShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TCircleShape;

            if Assigned(CircleShape) then
            begin
              CircleShape.postCenter := rec.PostStart;
              CircleShape.radius := rec.Radius1;
              CircleShape.ShapeOutline := rec.color;
              CircleShape.ShapeFill := rec.ColorFill;
              CircleShape.LineType := rec.lineType;
              CircleShape.LineWeight := rec.weight;
              CircleShape.BrushStyle := rec.BrushStyle;
              CircleShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(CircleShape);
            end;

            {$ENDREGION}
          end;
          ovEllipse :
          begin
            {$Region' Ellipse '}
            if rec.IdAction = caAdd then
            begin
              EllipseShape := TEllipseShape.Create(Converter);
              EllipseShape.ShapeId := GetSerialShapeID
            end
            else
             EllipseShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TEllipseShape;

            if Assigned(EllipseShape) then
            begin
              EllipseShape.postCenter := rec.PostStart;
              EllipseShape.Hradius := rec.Radius1;
              EllipseShape.Vradius := rec.Radius2;
              EllipseShape.ShapeOutline := rec.color;
              EllipseShape.ShapeFill := rec.ColorFill;
              EllipseShape.LineType := rec.lineType;
              EllipseShape.LineWeight := rec.weight;
              EllipseShape.BrushStyle := rec.BrushStyle;
              EllipseShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(EllipseShape);
            end;

            {$ENDREGION}
          end;
          ovArc :
          begin
            {$Region' Arc '}
            if rec.IdAction = caAdd then
            begin
              ArcShape := TArcShape.Create(Converter);
              ArcShape.ShapeId := GetSerialShapeID
            end
            else
              ArcShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TArcShape;

            if Assigned(ArcShape) then
            begin
              ArcShape.postCenter := rec.PostStart;
              ArcShape.radius := rec.Radius1;
              ArcShape.StartAngle := rec.StartAngle;
              ArcShape.EndAngle := rec.EndAngle;
              ArcShape.ShapeOutline := rec.color;
              ArcShape.LineType := rec.lineType;
              ArcShape.LineWeight := rec.weight;
              ArcShape.BrushStyle := rec.BrushStyle;
              ArcShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(ArcShape);
            end;

            {$ENDREGION}
          end;
          ovSector :
          begin
            {$Region' Sector '}
            if rec.IdAction = caAdd then
            begin
              SectorShape := TSectorShape.Create(Converter);
              SectorShape.ShapeId := GetSerialShapeID
            end
            else
              SectorShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TSectorShape;

            if Assigned(SectorShape) then
            begin
              SectorShape.postCenter := rec.PostStart;
              SectorShape.Oradius := rec.Radius1;
              SectorShape.Iradius := rec.Radius2;
              SectorShape.StartAngle := rec.StartAngle;
              SectorShape.EndAngle := rec.EndAngle;
              SectorShape.ShapeOutline := rec.color;
              SectorShape.LineType := rec.lineType;
              SectorShape.LineWeight := rec.weight;
              SectorShape.BrushStyle := rec.BrushStyle;
              SectorShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(SectorShape);
            end;

            {$ENDREGION}
          end;
          ovGrid :
          begin
            {$Region' Grid '}
            if rec.IdAction = caAdd then
            begin
              GridShape := TGridShape.Create(Converter);
              GridShape.ShapeId := GetSerialShapeID
            end
            else
              GridShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TGridShape;

            if Assigned(GridShape) then
            begin
              GridShape.postCenter := rec.PostStart;
              GridShape.Height := rec.Radius1;
              GridShape.Width := rec.Radius2;
              GridShape.HCount := rec.Kolom;
              GridShape.WCount := rec.Baris;
              GridShape.Rotation := rec.Rotasi;
              GridShape.ShapeOutline := rec.color;
              GridShape.ShapeFill := rec.ColorFill;
              GridShape.LineType := rec.lineType;
              GridShape.LineWeight := rec.weight;
              GridShape.BrushStyle := rec.BrushStyle;
              GridShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(GridShape);
            end;

            {$ENDREGION}
          end;
          ovPolygon  :
          begin
            {$Region' Polygon '}
            case rec.IdAction of
              caAdd :
              begin
                PolygonShape := TPolygonShape.Create(Converter);
                PolygonShape.ShapeId := GetSerialShapeID
              end;
              caEdit :
              begin
                PolygonShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TPolygonShape;
                PolygonShape.polyList.Clear;
              end;
            end;

            if Assigned(PolygonShape) then
            begin
              PolygonShape.ShapeOutline := rec.color;
              PolygonShape.ShapeFill := rec.ColorFill;
              PolygonShape.LineType := rec.lineType;
              PolygonShape.LineWeight := rec.weight;
              PolygonShape.BrushStyle := rec.BrushStyle;
              PolygonShape.isSelected := False;

              for i := 0 to 12 do
              begin
                if (rec.polyPoint[i].X = 0) and (rec.polyPoint[i].Y = 0) then
                  Continue;

                Point1 := TDotShape.Create;
                Point1.X := rec.polyPoint[i].X;
                Point1.Y := rec.polyPoint[i].Y;
                PolygonShape.polyList.Add(Point1);
              end;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(PolygonShape);
            end;

            {$ENDREGION}
          end;
          ovIntelijen:
          begin
            {$REGION ' Intelijen '}
            if rec.IdAction = caAdd then
            begin
              IntelijenShape := TIntelijenShape.Create(Converter);
              IntelijenShape.ShapeId := GetSerialShapeID;
            end
            else
              IntelijenShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TIntelijenShape;

            if Assigned(IntelijenShape) then
            begin
              IntelijenShape.Identifier := '';
              IntelijenShape.postCenter := rec.PostStart;
              IntelijenShape.TableProp := rec.PostStart;
              IntelijenShape.ShapeOutline := rec.color;
              IntelijenShape.isShow := True;
              IntelijenShape.isSelected := False;

              if IntelijenShape.InfoList.Count > 0 then
                IntelijenShape.InfoList.Clear;

              for i := 0 to 12 do
              begin
                if (rec.Data[i] = '') then
                  Continue;

                intelDataTemp := TIntelijenInfo.create;
                intelDataTemp.Info := rec.Data[i];
                IntelijenShape.InfoList.Add(intelDataTemp);
              end;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(IntelijenShape);
            end;

            {$ENDREGION}
          end;
          ovLogistic:
          begin
            {$REGION ' Logistic '}
            if rec.IdAction = caAdd then
            begin
              LogisticShape := TLogisticShape.Create(Converter);
              LogisticShape.ShapeId := GetSerialShapeID;
            end
            else
              LogisticShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TLogisticShape;

            if Assigned(LogisticShape) then
            begin
              LogisticShape.Identifier := rec.OverlayName;
              LogisticShape.postCenter := rec.PostStart;
              LogisticShape.TableProp := rec.PostStart;
              LogisticShape.ShapeOutline := rec.color;
              LogisticShape.isShow := True;

              if LogisticShape.LogisticList.Count > 0 then
                LogisticShape.LogisticList.Clear;

              for i := 0 to 12 do
              begin
                if (rec.Data[i] = '') then
                  Continue;

                logDataTemp := TLogisticOnBase.create;
                logDataTemp.Name := rec.Data[i];
                logDataTemp.Status := rec.Status[i];
                LogisticShape.LogisticList.Add(logDataTemp);
              end;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(LogisticShape);
            end;
            {$ENDREGION}
          end;
          ovRadar:
          begin
            {$REGION ' Radar '}
            if rec.IdAction = caAdd then
            begin
              RadarShape := TRadarShape.Create(Converter);
              RadarShape.ShapeId := GetSerialShapeID;
            end
            else
              RadarShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TRadarShape;

            if Assigned(RadarShape) then
            begin
              RadarShape.Identifier := rec.OverlayName;
              RadarShape.postCenter := rec.PostStart;
              RadarShape.TableProp := rec.PostStart;
              RadarShape.Radius := rec.Radius1;
              RadarShape.ShapeOutline := rec.color;
              RadarShape.isShow := True;
              RadarShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(RadarShape);
            end;

            {$ENDREGION}
          end;
          ovPangkalan:
          begin
            {$REGION ' Pangkalan '}
            if rec.IdAction = caAdd then
            begin
              BaseShape := TPangkalanShape.Create(Converter);
              BaseShape.ShapeId := GetSerialShapeID;
            end
            else
              BaseShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TPangkalanShape;

             if Assigned(BaseShape) then
            begin
              BaseShape.Identifier := rec.OverlayName;
              BaseShape.postCenter := rec.PostStart;
              BaseShape.TableProp := rec.PostStart;
              BaseShape.ShapeOutline := rec.color;
              BaseShape.isShow := True;
              BaseShape.isSelected := False;

              if BaseShape.VehiclesList.Count > 0 then
                BaseShape.VehiclesList.Clear;

              for i := 0 to 12 do
              begin
                if (rec.Data[i] = '') then
                  Continue;

                shipDataTemp := TVehicleOnBase.create;
                shipDataTemp.Name := rec.Data[i];
                shipDataTemp.Quantity := rec.Quantity[i];
                shipDataTemp.Simbol := rec.Simbol[i];
                BaseShape.VehiclesList.Add(shipDataTemp);
              end;

              if rec.IdAction = caAdd then
                 overlayTabTemp.MemberList.Add(BaseShape);
            end;

            {$ENDREGION}
          end;
          ovPanah:
          begin
            {$REGION ' Panah '}
            if rec.IdAction = caAdd then
            begin
              ArrowShape := TPanahShape.Create(Converter);
              ArrowShape.ShapeId := GetSerialShapeID;
            end
            else
              ArrowShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TPanahShape;

            if Assigned(ArrowShape) then
            begin
              ArrowShape.Identifier := '';
              ArrowShape.postCenter := rec.PostStart;
              ArrowShape.postEnd := rec.PostEnd;
              ArrowShape.ShapeOutline := rec.color;
              ArrowShape.isShow := True;
              ArrowShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(ArrowShape);
            end;
            {$ENDREGION}
          end;
          ovPlatform:
          begin
            {$REGION ' Platform '}
            if rec.IdAction = caAdd then
            begin
              platformShape := TPlatformShape.Create(Converter);
              platformShape.ShapeId := GetSerialShapeID;
            end
            else
              platformShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TPlatformShape;

            if Assigned(platformShape) then
            begin
              platformShape.Identifier := rec.OverlayName;
              platformShape.postCenter := rec.PostStart;
              platformShape.heading := rec.Rotasi;
              platformShape.simbol := rec.Words;
              platformShape.ShapeOutline := rec.color;
              platformShape.isShow := True;
              platformShape.isSelected := False;

              if rec.IdAction = caAdd then
                overlayTabTemp.MemberList.Add(platformShape);
            end;
            {$ENDREGION}
          end;
        end;
      end;
      caDelete :
      begin
        overlayTabTemp.MemberList.Delete(rec.IdSelectShape);
      end;
    end;
  end;
end;

procedure TT3SimManager.OnSituationBoardTabPropertiesChange(const rec: TRecTCPSendSituationBoardTabProperties);
var
  IdTemp : Integer;
  tabPropertiesTemp : TTabProperties;
  tabOverlayTemp : TOverlayTab;

begin

  case rec.OrderID of
    NEW_TAB :
    begin
      IdTemp := GetSerialTabSituationBoardID;

      tabPropertiesTemp := TTabProperties.Create;
      tabPropertiesTemp.IdTab := rec.TabId;
      tabPropertiesTemp.IdUserRoleTab := rec.UserRoleId;
      tabPropertiesTemp.IdOverlayTab := IdTemp;
      tabPropertiesTemp.CaptionTab := rec.TabCaption;
      tabPropertiesTemp.TypeTab := rec.TabType;
      tabPropertiesTemp.ActiveTab := True;
      tabPropertiesTemp.AddressTab := rec.TabAddres;

      SimTabProperties.TabList.Add(tabPropertiesTemp);

      tabOverlayTemp := TOverlayTab.Create;
      tabOverlayTemp.IdOverlayTab := IdTemp;
      tabOverlayTemp.IdUserRole := rec.UserRoleId;

      SimOverlay.TabList.Add(tabOverlayTemp);
    end;
    EDIT_TAB :
    begin
      tabPropertiesTemp := SimTabProperties.GetTapProperties(rec.UserRoleId, rec.TabId);

      if Assigned(tabPropertiesTemp) then
      begin
        tabPropertiesTemp.AddressTab := rec.TabAddres;
        tabPropertiesTemp.CaptionTab := rec.TabCaption;
      end;
    end;
    DELETE_TAB :
    begin
      SimTabProperties.DeleteTapProperties(rec.OverlayTab);

      tabOverlayTemp := SimOverlay.GetOverlayTabByID(rec.OverlayTab);
      SimOverlay.RemoveOverlayTab(tabOverlayTemp);
    end;
  end;
end;

procedure TT3SimManager.OnUserRoleChatChange(const rec: TRecTCPSendChatUserRole);
var
chatTemp : Tchatting;
begin
  case rec.OrderID of
    SEND_CHAT :
    begin
      chatTemp := TChatting.Create;
      chatTemp.IdChat := GetSerialChatID;
      chatTemp.IdUserRoleSending := rec.SenderUserRoleId;
      chatTemp.IdUserRoleReceive := rec.ReceiverUserRoleId;
      chatTemp.ChatMessage := rec.ChatMessage;

      SimChatting.ChattingList.Add(chatTemp);
    end;
  end;

end;

procedure TT3SimManager.OnUserStateChange(const rec: TRecTCP_UserState);
var
  userRoleTemp : TUserRole;

begin

  {$REGION ' Merubah data yang ada di list user role '}
  userRoleTemp := SimUserRole.getUserRoleByID(rec.UserRoleId);

  if Assigned(userRoleTemp) then
  begin
    case rec.OrderID of
      CORD_ID_LOGIN :
      begin
        userRoleTemp.isInUse := True;
        userRoleTemp.ConsoleIP := rec.ConsoleIP;
      end;
      CORD_ID_LOGOUT :
      begin
        userRoleTemp.isInUse := False;
        userRoleTemp.ConsoleIP := '';
      end;
    end;
  end;
  {$ENDREGION}

end;

procedure TT3SimManager.InitNetwork;
begin
  // some of register packet
end;

function TT3SimManager.GetConsoleIdentification: Boolean;
var
  WMIServices : ISWbemServices;
  Root        : ISWbemObjectSet;
  Item        : Variant;
  snTemp      : string;
  regTemp     : string;
  Address     : string;
  dateTemp    : string;
  stop, start : TDateTime;
  selisih     : Double;
  Tahun, Bulan, Hari : Word;
begin
  snTemp :=  '';
  regTemp := '';

  WMIServices := CoSWbemLocator.Create.ConnectServer('.', 'root\cimv2','', '', '', '', 0, nil);
  Root  := WMIServices.ExecQuery('Select SerialNumber From Win32_DiskDrive','WQL', 0, nil);
  Item := Root.ItemIndex(0);
  snTemp:=VarToStr(Item.SerialNumber);

  snTemp := ReplaceStr(snTemp, '_', '');
  snTemp := ReplaceStr(snTemp, '.', '');
  snTemp := RightStr(snTemp,8);

  Address := 'Software\CmPack\CmLogin';
  try
    try
      FReg := Tregistry.Create;
      FReg.OpenKey(Address,False);
      regTemp := FReg.ReadString('LockID');
      dateTemp := FReg.ReadString('Date');
    except on ERegistryException do
    end;
  finally
    FReg.CloseKey;
  end;

  DecodeDate(Now, Tahun, Bulan, Hari);
  start := EncodeDate(Tahun, Bulan, Hari);

  Stop := StrToFloat(dateTemp);
  selisih := Stop - start;

  if dateTemp = 'U' then
  begin
    Result := snTemp = regTemp;
  end
  else
  begin
    if selisih < 0 then
      Result := False
    else
      Result := snTemp = regTemp;
  end;
end;


function TT3SimManager.GetGameState: Boolean;
begin
  if FGameState = gsPlaying then
    Result := True
  else
    Result := False;
end;

function TT3SimManager.GetSerialChatID: Integer;
begin
  Result := FChatId;
  Inc(FChatId);
end;

function TT3SimManager.GetSerialShapeID: Integer;
begin
  Result := FShapeID;
  Inc(FShapeID);
end;

function TT3SimManager.GetSerialTabSituationBoardID: Integer;
begin
  Result := FTabSituationBoardID;
  Inc(FTabSituationBoardID);
end;

procedure TT3SimManager.StopNetwork;
begin
 // unregister all packet
end;

procedure TT3SimManager.FNetworkThread_OnPaused(const dt: double);
begin
//x
end;

procedure TT3SimManager.FNetworkThread_OnRunning(const dt: double);
begin
//x
end;

procedure TT3SimManager.FNetworkThread_OnTerminate(sender: TObject);
begin
//x
end;

end.
