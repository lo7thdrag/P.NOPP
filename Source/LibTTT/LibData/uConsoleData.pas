unit uConsoleData;

interface

uses
  Classes, GmXml, GmXMLInterface;

type

  TRoleInfo = class
  public
    RoleID  : string;
    RoleName: string;
    ConsoleIPs : TStrings;

    constructor Create;
    destructor Destroy; override;
  end;

  TConsoleInfo = class
  public
    IPAddress: string;
    ConsoleName: string;
    RoleName: string;
    State : Boolean;
  end;

  TNodeGroup = class(TXMLObjInterface)
  private
    function getValue(const Index: Integer): string;
  public
    property RoleID: string index 1 read getValue;
    property RoleName: string index 2 read getValue;
  end;

  TNodeConsole = class(TXMLObjInterface)
  private
    function getValue(const Index: Integer): string;
  public
    property IPAddress  : string index 1 read getValue;
    property ConsoleName: string index 2 read getValue;
  end;

  TConsoleContainer = class
  protected
    FXML    : TGmXML;
    FLoaded : Boolean;

    FNodeInstructor : TGmXmlNode;
    FNodeSituationBoard : TGmXmlNode;
    FNodeOfficer : TGmXmlNode;

  public
    RoleGroupList : TStringList;
    ConsoleList : TStringList;

    constructor Create;
    destructor Destroy; override;

    procedure LoadFromFile(const fName: string);
    procedure CloseFile;

    function IsGroupMember(const ipAdd: string): boolean;
    function GetIPAddress(const cbName: string): string;
    function GetConsoleName(const ipAdd: string): string;
    function GetConsoleRoleName(const ipAdd: string): string;
    function GetConsoleRole(const cbName: string): TRoleInfo;
    function GetConsoleInfo(const ipAdd: string): TConsoleInfo;

    procedure GetListConsole(var al : TStringList);

  end;

implementation

const
  cTag_instructor  = 'instructor';
  cTag_situationboard  = 'situationboard';
  cTag_officer     = 'officer';

procedure ClearAndFreeItems(var sl: TStringList);
var
  i: integer;
  o: TObject;
begin
  for i := sl.Count - 1 downto 0 do begin
    o := sl.Objects[i];
    o.Free;
  end;
  sl.Clear;
end;


{ TNodeCubicles }

function TNodeGroup.getValue(const Index: Integer): string;
begin
  case index of
    1 : //CubicleID
    result := getAttribValueByName('id');
    2 : //CubicleName
    result := getAttribValueByName('name');
  end;
end;

{ TNodeConsoles }

function TNodeConsole.getValue(const Index: Integer): string;
begin
  case index of
    1 : result := getAttribValueByName('ip');
    2 : result := getAttribValueByName('name');
  end;
end;


{ T3GroupList }

constructor TConsoleContainer.Create;
begin
  FNodeInstructor := nil;
  FNodeSituationBoard  := nil;
  FNodeOfficer     := nil;

  FXML := nil;
  FLoaded := False;

  RoleGroupList := TStringList.Create;
  RoleGroupList.Sorted := true;

  ConsoleList := TStringList.Create;
  ConsoleList.Sorted := true;

end;

destructor TConsoleContainer.Destroy;
begin
  ConsoleList.Clear;
  ConsoleList.Free;

  RoleGroupList.Clear;
  RoleGroupList.Free;

  FNodeInstructor := nil;
  FNodeSituationBoard := nil;
  FNodeOfficer := nil;

  FXML.Free;

  inherited;
end;


procedure TConsoleContainer.LoadFromFile(const fName: string);
var
  i : integer;
  consoleNodeTemp: TNodeConsole;
  groupNodeTemp: TNodeGroup;
  con:  TConsoleInfo;
  groupRoleTemp: TRoleInfo;

begin

  ClearAndFreeItems(ConsoleList);
  ClearAndFreeItems(RoleGroupList);

  FXML := TGmXML.Create(nil);
  FXML.LoadFromFile(fName);

  groupNodeTemp  := TNodeGroup.Create;
  consoleNodeTemp  := TNodeConsole.Create;

  {$REGION ' Instructor '}
  FNodeInstructor := FXML.Nodes.Node[0].Children.NodeByName[cTag_instructor];
  groupNodeTemp.Assign(FNodeInstructor);

  groupRoleTemp := TRoleInfo.Create;
  groupRoleTemp.RoleID   := groupNodeTemp.RoleID;
  groupRoleTemp.RoleName := groupNodeTemp.RoleName;

  if Assigned(FNodeInstructor) then
  begin
    for i := 0 to FNodeInstructor.Children.Count-1 do
    begin
      consoleNodeTemp.Assign(FNodeInstructor.Children.Node[i]);

      con :=  TConsoleInfo.Create;
      con.IPAddress   := consoleNodeTemp.IPAddress;
      con.ConsoleName := consoleNodeTemp.ConsoleName;
      con.RoleName := groupNodeTemp.RoleName;

      ConsoleList.AddObject(con.IPAddress, con);
      groupRoleTemp.ConsoleIPs.Add(con.IPAddress);
    end;
    RoleGroupList.AddObject(groupRoleTemp.RoleName, groupRoleTemp);

  end;
  {$ENDREGION}

  {$REGION ' Situation Board '}
  FNodeSituationBoard := FXML.Nodes.Node[0].Children.NodeByName[cTag_situationboard];
  groupNodeTemp.Assign(FNodeSituationBoard);

  groupRoleTemp := TRoleInfo.Create;
  groupRoleTemp.RoleID   := groupNodeTemp.RoleID;
  groupRoleTemp.RoleName := groupNodeTemp.RoleName;

  if Assigned(FNodeSituationBoard) then
  begin
    for i := 0 to FNodeSituationBoard.Children.Count-1 do
    begin
      consoleNodeTemp.Assign(FNodeSituationBoard.Children.Node[i]);

      con :=  TConsoleInfo.Create;
      con.IPAddress   := consoleNodeTemp.IPAddress;
      con.ConsoleName := consoleNodeTemp.ConsoleName;
      con.RoleName := groupNodeTemp.RoleName;

      ConsoleList.AddObject(con.IPAddress, con);
      groupRoleTemp.ConsoleIPs.Add(con.IPAddress);
    end;
    RoleGroupList.AddObject(groupRoleTemp.RoleName, groupRoleTemp);

  end;
  {$ENDREGION}

  {$REGION ' Officer Board '}
  FNodeOfficer    := FXML.Nodes.Node[0].Children.NodeByName[cTag_officer];
  groupNodeTemp.Assign(FNodeOfficer);

  groupRoleTemp := TRoleInfo.Create;
  groupRoleTemp.RoleID   := groupNodeTemp.RoleID;
  groupRoleTemp.RoleName := groupNodeTemp.RoleName;

  if Assigned(FNodeOfficer) then
  begin
    for i := 0 to FNodeOfficer.Children.Count-1 do
    begin
      consoleNodeTemp.Assign(FNodeOfficer.Children.Node[i]);

      con :=  TConsoleInfo.Create;
      con.IPAddress   := consoleNodeTemp.IPAddress;
      con.ConsoleName := consoleNodeTemp.ConsoleName;
      con.RoleName := groupNodeTemp.RoleName;

      ConsoleList.AddObject(con.IPAddress, con);

      groupRoleTemp.ConsoleIPs.Add(con.IPAddress);
    end;
    RoleGroupList.AddObject(groupRoleTemp.RoleName, groupRoleTemp);

  end;
  {$ENDREGION}

  consoleNodeTemp.Free;
  groupNodeTemp.Free;
end;


procedure TConsoleContainer.CloseFile;
begin
  FXML.Free;
  FXML := nil;

  FNodeInstructor := nil;
  FNodeSituationBoard  := nil;
  FNodeOfficer     := nil;

  ClearAndFreeItems(ConsoleList);
  ClearAndFreeItems(RoleGroupList);
end;

function TConsoleContainer.GetConsoleInfo(const ipAdd: string): TConsoleInfo;
var
  i: integer;
begin
  Result := nil;

  if ConsoleList.Find(ipAdd, i) then
    Result := ConsoleList.Objects[i] as TConsoleInfo;

end;

function TConsoleContainer.GetConsoleName(const ipAdd: string): string;
var
  i: integer;
  con:  TConsoleInfo;
begin
  if ConsoleList.Find(ipAdd, i) then
  begin
    con     := ConsoleList.Objects[i] as TConsoleInfo;
    result  := con.ConsoleName;
  end
  else
    result := '';
end;

function TConsoleContainer.GetConsoleRoleName(const ipAdd: string): string;
var
  i: integer;
  con:  TConsoleInfo;
begin
  result := '';
  if ConsoleList.Find(ipAdd, i) then
  begin
    con :=  ConsoleList.Objects[i] as TConsoleInfo;
    result := con.RoleName;
  end;
end;

function TConsoleContainer.GetIPAddress(const cbName: string): string;
var
  i : integer;
  con :  TConsoleInfo;
begin
  result := '';

  for i := 0 to ConsoleList.Count - 1 do
  begin
    con :=  ConsoleList.Objects[i] as TConsoleInfo;

    if con.ConsoleName =  cbName then
    begin
      result := con.IPAddress;
      Break;
    end;
  end;
end;

procedure TConsoleContainer.GetListConsole(var al: TStringList);
var
    i: integer;
    con:  TConsoleInfo;
begin
  if al = nil then exit;
  for i := 0 to ConsoleList.Count - 1 do
  begin
     con :=  ConsoleList.Objects[i] as TConsoleInfo;
     al.AddObject(con.IPAddress,con);
  end;
end;

function TConsoleContainer.GetConsoleRole(const cbName: string): TRoleInfo;
var
  i: integer;
begin
  Result := nil;

  if RoleGroupList.Find(cbName, i) then
    Result := RoleGroupList.Objects[i] as TRoleInfo;

end;

function TConsoleContainer.IsGroupMember(const ipAdd: string): boolean;
var i: integer;
begin
  result := ConsoleList.Find(ipAdd, i);
end;

{ TCubicleInfo }

constructor TRoleInfo.Create;
begin
  inherited;

  ConsoleIPs := TStringList.Create;
end;

destructor TRoleInfo.Destroy;
begin
  ConsoleIPs.Clear;
  ConsoleIPs.Free;

  inherited;
end;

end.
