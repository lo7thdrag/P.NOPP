unit uCommTTT;

interface

uses
     Classes, SysUtils, Menus, Grids, Dialogs,
     uGameData_TTT, uDataModuleTTT, newClassASTT, {uSimMgr_Client,} uDBCubicles,
     uDBAssetObject, uNetUDPnode, tttData;

type
  TGridCracker = Class( TStringgrid );

  TCommTTT = class
    private
      ListGroupCub : TStrings;
      ListGroupCubID : Tstrings;

      //Add List For Group Com
      procedure AddGroupList(AGName : string; AGID : Integer;
        AChnNumberAva, AChnNameAva, AChnCodeAva, AChnRoomAva, AChnBandAva,
        AChnNumberMap, AChnNameMap, AChnCodeMap, AChnRoomMap, AChnBandMap : string);
      //Add List Comm Definition
      procedure AddChannelDefinintion(AChnNumber, AChnName, AChnCode, AChnRoom,
          AChnBand: string);
    public
      CubName : string;
      ConsName : string;

      isClick : Boolean;
      isEnter : Boolean;

      //Group Name n ID
      AGroupName : string;
      AGroupID : Integer;

      AId : Integer;
      ListGroup : Tlist;

      ListChnDef : Tlist;

      ListGroupCubicle : T3CubicleGroupList;
      ExternComm : TList;

      ExCom: TExternal_Communication_Channel;
      communication : TExternal_Communication_Channel;
      cList,comList,excomList  : TList;

      //Pop Up For Group
      PopUpMenu : TPopUpMenu;
      ItemPopUp : TMenuItem;
      //Copy Pop Up For Group
      CpPopUpMenu : TPopupMenu;
      CpItemPopUp : TMenuItem;

      //Broadcaster
      BroadcasterSender: TNetUDPNode;
      BroadcasterListen: TNetUDPNode;

      //Mapping Chanel
      NumberMap : TStrings;
      NameMap : TStrings;
      ChannelMap : TStrings;
      RoomMap : TStrings;
      BandMap : TStrings;
      SendNumberMap : string;
      SendNameMap : string;
      SendChannelMap : string;
      SendRoomMap : string;
      SendBandMap : string;

      //Available Channel
      NumberAvl : TStrings;
      NameAvl : TStrings;
      ChannelAvl : TStrings;
      RoomAvl : TStrings;
      BandAvl : Tstrings;
      RemainsNumberAvl : string;
      RemainsNameAvl : string;
      RemainsChannelAvl : string;
      RemainsRoomAvl : string;
      RemainsBandAvl : string;

      constructor create;
      destructor Destroy; override;

      procedure SetChnDef;
      procedure SetCommUtil;
      Procedure CloseCommUtil;
      procedure GetChannelCub(AgrpID : Integer);

      //Broadcaster
      procedure Setbroadcast;
      procedure CloseBroadCast;
      procedure Listen(Aid : Integer);  //1 : Controller, 2 : Cubicle
      procedure BroadcastDataCub(AIdGrp : string);
      procedure BroadcastDataCon(AIdGrp : string);
      procedure BroadcastDataDef(AConsName : string; ACol, Arow : Integer;
                AField : string; isCheck, isEdit : Boolean);
      procedure ReceiveChannel(apRec: PAnsiChar; aSize: Word);
      procedure ReceiveConAv(apRec: PAnsiChar; aSize: Word);
      procedure ReceiveConMp(apRec: PAnsiChar; aSize: Word);
      procedure ReceiveConDef(apRec: PAnsiChar; aSize: Word);
      procedure ReceiveMessage(apRec: PAnsiChar; aSize: Word);
      procedure UDPSendChannel(apRec: PAnsiChar; aSize: Word);
      procedure UDPSendConAv(apRec: PAnsiChar; aSize: Word);
      procedure UDPSendConMp(apRec: PAnsiChar; aSize: Word);
      procedure UDPSendConDef(apRec: PAnsiChar; aSize: Word);
      procedure UDPSendMessage(apRec: PAnsiChar; aSize: Word);
      procedure UDPSendJam(apRec: PAnsiChar; aSize: Word);

      //Channel Def
      procedure strgrdCheckBox(acol, arow: Integer);
      procedure strgrdKeypress(aKey : char; AId : integer);

      //Pop Up
      procedure ClickItemPopUp(Sender : TObject);
      procedure ClickCpItemPopUp(Sender : TObject);

      //After Get from Database Save to List
      procedure AddItemData(AListId : Integer);

      //Check Channel Online
      procedure CheckOnlineChannel;
  end;

implementation

uses ufToteDisplay, ufTacticalDisplay, uSimMgr_Client;

{ TCommTTT }

constructor TCommTTT.create;
begin
  inherited create;
end;

destructor TCommTTT.Destroy;
begin
  inherited destroy;
end;

//=============================================================================
//====================BroadCast Message n Channel==============================
procedure TCommTTT.Setbroadcast;
begin
  // Communication
  // Sender
  BroadcasterSender := TNetUDPNode.Create;
  BroadcasterSender.RegisterProcedure(CPID_RecSendChannel, UDPSendChannel,
    SizeOf(TRecSendChannel));
  BroadcasterSender.RegisterProcedure(CPID_RecSendControllerAv, UDPSendConAv,
    SizeOf(TrecSendControllerAv));
  BroadcasterSender.RegisterProcedure(CPID_RecSendControllerMp, UDPSendConMp,
    SizeOf(TrecSendControllerMp));
  BroadcasterSender.RegisterProcedure(CPID_RecSendControllerDef, UDPSendConDef,
    SizeOf(TrecSendControllerDef));
  BroadcasterSender.RegisterProcedure(CPID_REC_MESSAGE, UDPSendMessage,
    SizeOf(TRecSendMessage));
  BroadcasterSender.RegisterProcedure(CPID_Jamming, UDPSendJam,
    SizeOf(TRecJamming));

  // Listener
  BroadcasterListen := TNetUDPNode.Create;
  BroadcasterListen.RegisterProcedure(CPID_RecSendChannel, ReceiveChannel,
    SizeOf(TRecSendChannel));
  BroadcasterListen.RegisterProcedure(CPID_RecSendControllerAv, ReceiveConAv,
    SizeOf(TrecSendControllerAv));
  BroadcasterListen.RegisterProcedure(CPID_RecSendControllerMp, ReceiveConMp,
    SizeOf(TrecSendControllerMp));
  BroadcasterListen.RegisterProcedure(CPID_RecSendControllerDef, ReceiveConDef,
    SizeOf(TrecSendControllerDef));
  BroadcasterListen.RegisterProcedure(CPID_REC_MESSAGE, ReceiveMessage,
    SizeOf(TRecSendMessage));
end;

procedure TCommTTT.Listen(Aid: Integer);
begin
  if Aid = 1 then
  begin
    BroadcasterListen.Listen('44144');
  end
  else
  if Aid = 2 then
  begin
    BroadcasterListen.Listen('44444');
  end;
end;

procedure TCommTTT.UDPSendMessage(apRec: PAnsiChar; aSize: Word);
//var
//  SendMessage: ^TRecSendMessage;
//
//  SendFrom: string;
//  Sendto: string;
//  Subject: string;
//  Priority: string;
//  Band: string;
//  UDPMessage: string;
//  IsCommand: Boolean;
begin
//  SendMessage := @apRec^;
//
//  SendFrom := SendMessage^.SendFrom;
//  Sendto := SendMessage^.Sendto;
//  Subject := SendMessage^.Subject;
//  Priority := SendMessage^.Priority;
//  Band := SendMessage^.Band;
//  UDPMessage := SendMessage^.UDPMessage;
//  IsCommand := SendMessage^.IsCommand;
end;

procedure TCommTTT.ReceiveMessage(apRec: PAnsiChar; aSize: Word);
//var
//  UDPReceiveMessage: ^TRecSendMessage;
//
//  SendFrom: string;
//  Sendto: string;
//  Subject: string;
//  Priority: string;
//  Band: string;
//  UDPMessage: string;
//  IsCommand: Boolean;
begin
{
  UDPReceiveMessage := @apRec^;

  SendFrom := UDPReceiveMessage^.SendFrom;
  Sendto := UDPReceiveMessage^.Sendto;
  Subject := UDPReceiveMessage^.Subject;
  Priority := UDPReceiveMessage^.Priority;
  Band := UDPReceiveMessage^.Band;
  UDPMessage := UDPReceiveMessage^.UDPMessage;
  IsCommand := UDPReceiveMessage^.IsCommand;

  if (IsCommand) and (Sendto = frmToteDisplay.CubName) then
  begin
    frmTacticalDisplay.addStatus('RECEIVE MESSAGE');

    with frmToteDisplay.lvReceive.Items.Add do
    begin
      Caption := SendFrom;
      SubItems.Add(UDPMessage);
      SubItems.Add(Subject);
      SubItems.Add(Priority);
    end;
  end;
}
end;

procedure TCommTTT.UDPSendChannel(apRec: PAnsiChar; aSize: Word);
//var
//  SendChannel: ^TRecSendChannel;
//
//  GroupName: string;
//  GroupID: Integer;
//  Channel: string;
//  Room: string;
begin
//  SendChannel := @apRec^;
//
//  GroupName := SendChannel^.GroupName;
// GroupID := SendChannel^.GroupID;
//  Channel := SendChannel^.Channel;
//  Room := SendChannel^.Room;
end;

procedure TCommTTT.UDPSendConAv(apRec: PAnsiChar; aSize: Word);
//var
//  SendConAv : ^TRecSendControllerAv;
//  GroupName : string;
//  GroupID : Integer;
//  AvNumber : string;
//  AvName : string;
//  AvCode : string;
//  AvRoom : string;
//  AvBand : string;
begin
//  SendConAv := @aprec^;

//  GroupName := SendConAv^.GroupName;
//  GroupID := SendConAv^.GroupID;
//  AvNumber := SendConAv^.AvNumber;
//  AvName := SendConAv^.AvName;
//  AvCode := SendConAv^.AvCode;
//  AvRoom := SendConAv^.AvCode;
//  AvBand := SendConAv^.AvBand;
end;

procedure TCommTTT.UDPSendConMp(apRec: PAnsiChar; aSize: Word);
//var
//  SendConMp : ^TRecSendControllerMp;

//  GroupName : string;
//  GroupID : Integer;
//  MpNumber : string;
//  MpName : string;
//  MpCode : string;
//  MpRoom : string;
//  MpBand : string;
begin
//  SendConMp := @aprec^;
//
//  GroupName := SendConMp^.GroupName;
//  GroupID := SendConMp^.GroupID;
//  MpNumber := SendConMp^.MpNumber;
//  MpName := SendConMp^.MpName;
//  MpCode := SendConMp^.MpCode;
//  MpRoom := SendConMp^.MpRoom;
//  MpBand := SendConMp^.MpBand;
end;

procedure TCommTTT.UDPSendJam(apRec: PAnsiChar; aSize: Word);
//var
//  SendJam : ^TrecJamming;
//  Cmd : string;
//  Channel : string;
//  Mode : Integer;
//  Volume : Integer;
begin
//  SendJam := @aprec^;
//  Cmd := SendJam^.Cmd;
//  Channel := SendJam^.Channel;
//  Mode := SendJam^.Mode;
//  Volume := SendJam^.Mode;
end;

procedure TCommTTT.UDPSendConDef(apRec: PAnsiChar; aSize: Word);
//var
//  SendConDef : ^TRecSendControllerDef;
//
//  ConsoleName : string;
//  AColumn : Integer;
//  ARow : Integer;
//  EditField : string;
//  isCheck : Boolean;
//  isEdit : Boolean;
begin
//  SendConDef := @aprec^;

//  ConsoleName := SendConDef^.ConsoleName;
//  AColumn := SendConDef^.AColumn;
//  ARow := SendConDef^.ARow;
//  EditField := SendConDef^.EditField;
//  isCheck := SendConDef^.isCheck;
//  isEdit := SendConDef^.isEdit;
end;

procedure TCommTTT.ReceiveChannel(apRec: PAnsiChar; aSize: Word);
var
  UDPReceiveChannel: ^TRecSendChannel;

  GroupName: string;
  GroupID : Integer;
  Number : string;
  Name : string;
  Channel : string;
  Room: string;
  BandChannel: string;

  i : Integer;

  ReceiveChannelNumberMap : TStrings;
  ReceiveChannelNameMap : TStrings;
  ReceiveChannelCodeMap : TStrings;
  ReceiveChannelRoomMap : TStrings;
  ReceiveChannelBandMap : Tstrings;
begin
  UDPReceiveChannel := @apRec^;

  GroupName := UDPReceiveChannel^.GroupName;
  GroupID := UDPReceiveChannel^.GroupID;
  Number := UDPReceiveChannel^.Number;
  Name := UDPReceiveChannel^.Name;
  Channel := UDPReceiveChannel^.Channel;
  Room := UDPReceiveChannel^.Room;
  BandChannel := UDPReceiveChannel^.BandChannel;

  ReceiveChannelNumberMap := nil;
  ReceiveChannelNameMap   := nil;
  ReceiveChannelCodeMap   := nil;
  ReceiveChannelRoomMap   := nil;
  ReceiveChannelBandMap   := nil;

  try
    ReceiveChannelNumberMap := TStringList.Create;
    ReceiveChannelNumberMap.Delimiter := ';';
    ReceiveChannelNameMap := TStringList.Create;
    ReceiveChannelNameMap.Delimiter := ';';
    ReceiveChannelCodeMap := TStringList.Create;
    ReceiveChannelCodeMap.Delimiter := ';';
    ReceiveChannelRoomMap := TStringList.Create;
    ReceiveChannelRoomMap.Delimiter := ';';
    ReceiveChannelBandMap := TStringList.Create;
    ReceiveChannelBandMap.Delimiter := ';';

    if simMgrClient.FMyCubGroup.FData.Group_Index =  GroupID then
    begin
      for i := 0 to frmToteDisplay.sgCommChannelDef.RowCount do
      begin
        frmToteDisplay.sgCommChannelDef.Objects[0, i+1] := TObject(0);
        frmToteDisplay.sgCommChannelDef.Cells[2, i+1] := '';
        frmToteDisplay.sgCommChannelDef.Cells[3, i+1] := '';
        frmToteDisplay.sgCommChannelDef.Cells[4, i+1] := 'VHF/UHF';
        frmToteDisplay.sgCommChannelDef.Cells[5, i+1] := '300';
      end;

      ReceiveChannelNumberMap.DelimitedText := Number;
      ReceiveChannelNameMap.DelimitedText := Name;
      ReceiveChannelCodeMap.DelimitedText := Channel;
      ReceiveChannelRoomMap.DelimitedText := Room;
      ReceiveChannelBandMap.DelimitedText := BandChannel;

      for i := 0 to ReceiveChannelNumberMap.Count - 1 do
      begin
        with frmToteDisplay.sgCommChannelDef do
        begin
          Objects[0, StrToInt(ReceiveChannelNumberMap[i])+1] := TObject(1);
          Cells[2, StrToInt(ReceiveChannelNumberMap[i])+1] := ReceiveChannelNameMap[i];
          Cells[3, StrToInt(ReceiveChannelNumberMap[i])+1] := ReceiveChannelCodeMap[i];
          Cells[4, StrToInt(ReceiveChannelNumberMap[i])+1] := ReceiveChannelBandMap[i];
        end;
      end;
    end;
  finally
    ReceiveChannelNumberMap.Free;
    ReceiveChannelNameMap.Free;
    ReceiveChannelCodeMap.Free;
    ReceiveChannelRoomMap.Free;
    ReceiveChannelBandMap.Free;
  end;

end;

procedure TCommTTT.ReceiveConAv(apRec: PAnsiChar; aSize: Word);
var
  UDPreceiveConAv : ^TRecSendControllerAv;

  GroupName : string;
  GroupID : Integer;

  AvNumber : string;
  AvName : string;
  AvCode : string;
  AvRoom : string;
  AvBand : string;

  i : Integer;
  Map : PRecGroupCom;
begin
  UDPreceiveConAv := @aprec^;

  GroupName := UDPreceiveConAv^.GroupName;
  GroupID := UDPreceiveConAv^.GroupID;

  AvNumber := UDPreceiveConAv^.AvNumber;
  AvName := UDPreceiveConAv^.AvName;
  AvCode := UDPreceiveConAv^.AvCode;
  AvRoom := UDPreceiveConAv^.AvRoom;
  AvBand := UDPreceiveConAv^.AvBand;

  for i := 0 to ListGroup.Count - 1 do
  begin
    Map := PRecGroupCom(ListGroup[i]);

    if map^.GroupID = GroupID then
    begin
       Map^.ChannelNumberAvailable := AvNumber;
       Map^.ChannelNameAvailable := AvName;
       Map^.ChannelCodeAvailable := AvCode;
       Map^.ChannelRoomAvailable := AvRoom;
       Map^.ChannelBandAvailable := AvBand;

       AddItemData(0);
    end;
  end;
end;

procedure TCommTTT.ReceiveConMp(apRec: PAnsiChar; aSize: Word);
var
  UDPreceiveConMp : ^TRecSendControllerMp;

  GroupName : string;
  GroupID : Integer;

  MpNumber : string;
  MpName : string;
  MpCode : string;
  MpRoom : string;
  MpBand : string;

  i : Integer;
  Map : PRecGroupCom;
begin
  UDPreceiveConMp := @aprec^;

  GroupName := UDPreceiveConMp^.GroupName;
  GroupID := UDPreceiveConMp^.GroupID;

  MpNumber := UDPreceiveConMp^.MpNumber;
  MpName := UDPreceiveConMp^.MpName;
  MpCode := UDPreceiveConMp^.MpCode;
  MpRoom := UDPreceiveConMp^.MpRoom;
  MpBand := UDPreceiveConMp^.MpBand;

  for i := 0 to ListGroup.Count - 1 do
  begin
    Map := PRecGroupCom(ListGroup[i]);

    if map^.GroupID = GroupID then
    begin
       Map^.ChannelNumberMapping := MpNumber;
       Map^.ChannelNameMapping := MpName;
       Map^.ChannelCodeMapping := MpCode;
       Map^.ChannelRoomMapping := MpRoom;
       Map^.ChannelBandMapping := MpBand;

       AddItemData(0);
    end;
  end;
end;

procedure TCommTTT.ReceiveConDef(apRec: PAnsiChar; aSize: Word);
var
  ReceiveConDef : ^TRecSendControllerDef;

  ConsoleName : string;
  AColumn : Integer;
  ARow : Integer;

  EditField : string;

  isCheck : Boolean;
  isEdit : Boolean;

  Volume : Integer;
  Mode : integer;
begin
  isClick := False;
  isEnter := False;

  ReceiveConDef := @aprec^;

  ConsoleName := ReceiveConDef.ConsoleName;
  AColumn := ReceiveConDef^.AColumn;
  ARow := ReceiveConDef^.ARow;

  EditField := ReceiveConDef^.EditField;

  isCheck := ReceiveConDef^.isCheck;
  isEdit := ReceiveConDef^.isEdit;

  if (isCheck) and (not isEdit) and (ConsName = ConsoleName) then
  begin
    strgrdCheckBox(AColumn, ARow);
  end;

  if (not isCheck) and (isEdit) and (ConsName = ConsoleName) then
  begin
    frmToteDisplay.sgCommChannelDef.Cells[AColumn, ARow] := EditField;
    strgrdKeypress(#13, ARow);
  end;

  if (not isCheck) and (not isEdit) and (ConsName = ConsoleName) then
  begin
    frmToteDisplay.sgComInInjection.Cells[AColumn,  ARow] := EditField;
  end;

  if (isCheck) and (isEdit) and (ConsName = ConsoleName) then
  begin
    //For This One
    //Acolumn = Mode, Arow = Volume
    Mode := AColumn;
    Volume := ARow;

    if Mode = 1 then
    begin
      frmToteDisplay.tbJamming.Position := frmToteDisplay.tbJamming.Max - Volume;
    end
    else
    if Mode = 2 then
    begin
      frmToteDisplay.tbNoise.Position := frmToteDisplay.tbNoise.Max - Volume;
    end
    else
    if Mode = 3 then
    begin
      frmToteDisplay.tbMHStones.Position := frmToteDisplay.tbMHStones.Max - Volume;
    end;
  end;

end;

//=============================================================================

procedure TCommTTT.SetChnDef;
var
  i : Integer;
  DefChnNumber, DefChnName, DefChnCode, DefChnRoom, DefChnBand: string;
begin
  ListChnDef := Tlist.Create;

  with frmToteDisplay.sgCommChannelDef do
  begin
    Cells[0, 0] := 'Enable';
    Cells[1, 0] := 'Channel';
    Cells[2, 0] := 'Name';
    Cells[3, 0] := 'Code';
    Cells[4, 0] := 'Band';
    Cells[5, 0] := 'Frequency (MHz)';
    Cells[6, 0] := 'Secure';
  end;

  for i := 0 to frmToteDisplay.sgCommChannelDef.RowCount do
  begin
    frmToteDisplay.sgCommChannelDef.Cells[1, i + 1] := IntToStr(i); // Channel Number
    frmToteDisplay.sgCommChannelDef.Cells[4, i + 1] := 'VHF/UHF'; // Channel Band
    frmToteDisplay.sgCommChannelDef.Cells[5, i + 1] := '300'; // Channel Frekuensi

    DefChnNumber := IntToStr(i);
    DefChnName := 'Channel ' + IntToStr(i);
    DefChnCode := 'Ch-' + IntToStr(i);
    DefChnRoom := IntToStr(3000 + i);
    DefChnBand := 'VHF/UHF';

    AddChannelDefinintion(DefChnNumber, DefChnName, DefChnCode, DefChnRoom,
      DefChnBand);
  end;
end;

procedure TCommTTT.SetCommUtil;
var
  Band: byte;

  ListID : TStrings;
  AvaChnNumber, AvaChnName, AvaChnCode, AvaChnRoom, AvaChnBand : TStrings;
  MapChnNumber, MapChnName, MapChnCode, MapChnRoom, MapChnBand : TStrings;

  AvaChnNumberStr, AvaChnNameStr, AvaChnCodeStr, AvaChnRoomStr, AvaChnBandStr : string;
  MapChnNumberStr, MapChnNameStr, MapChnCodeStr, MapChnRoomStr, MapChnBandStr : string;

  grp: T3CubicleGroup;
  grpMember: T3CubicleGroup;

  GroupName : string;
  GroupID : Integer;

  i,j,k,l,m : Integer;
  id,idx : Integer;

  AExternalCom: TExternal_Communication_Channel;

  ii, p : integer;
  isselected: Boolean;

begin
  //Mapping Channel
  NumberMap := TStringList.Create;
  NameMap := TStringList.Create;
  ChannelMap := TStringList.Create;
  RoomMap := TStringList.Create;
  BandMap := TStringList.Create;

  //Available Channel
  NumberAvl := TStringList.Create;
  NameAvl := TStringList.Create;
  ChannelAvl := TStringList.Create;
  RoomAvl := TStringList.Create;
  BandAvl := TStringList.Create;

  cList      := TList.Create;
  comList    := TList.Create;
  excomList  := TList.Create;

  AvaChnNumberStr := '';  MapChnNumberStr := '';
  AvaChnNameStr := '';    MapChnNameStr := '';
  AvaChnCodeStr := '';    MapChnCodeStr := '';
  AvaChnRoomStr := '';    MapChnRoomStr := '';
  AvaChnBandStr := '';    MapChnBandStr := '';

  ListGroup := TList.Create;

  ListGroupCub := TStringList.Create;
  ListGroupCubID := TStringList.Create;

  for i := 0 to ListGroupCubicle.Count - 1 do
  begin
    grp := ListGroupCubicle.Items[i] as T3CubicleGroup;
    if grp = nil then
      continue;

    if grp.FData.Group_Identifier = 'Controller' then
      Continue;

    ListGroupCub.Add(grp.FData.Group_Identifier);
    ListGroupCubID.Add(IntToStr(grp.FData.Group_Index));
  end;

  PopUpMenu := TPopupMenu.Create(nil);
  CpPopUpMenu := TPopupMenu.Create(nil);

  for i := 1 to ListGroupCub.Count  do
  begin
    CpItemPopUp := TMenuItem.Create(CpPopUpMenu);
    CpItemPopUp.Caption := ListGroupCub[i-1];
    CpItemPopUp.Tag := i;
    CpItemPopUp.OnClick := ClickCpItemPopUp;
    CpPopUpMenu.Items.Add(CpItemPopUp);
  end;

  AvaChnNumber  := nil;
  AvaChnName    := nil;
  AvaChnCode    := nil;
  AvaChnRoom    := nil;
  AvaChnBand    := nil;

  MapChnNumber  := nil;
  MapChnName    := nil;
  MapChnCode    := nil;
  MapChnRoom    := nil;
  MapChnBand    := nil;

  //For Controller
  ItemPopUp := TMenuItem.Create(PopUpMenu);
  ItemPopUp.Caption := 'Controller';
  GroupName := 'Controller';
  ItemPopUp.Tag := 0;
  GroupID := 0;
  ItemPopUp.OnClick := ClickItemPopUp;
  PopUpMenu.Items.Add(ItemPopUp);

  //Save Parameter For Mapped Channel
  //Add Mapping Channel
  try
    MapChnNumber := TStringList.Create;   //Number
    MapChnName := TStringList.Create;     //Name
    MapChnCode := TStringList.Create;     //Code
    MapChnRoom := TStringList.Create;     //Room
    MapChnBand := TStringList.Create;     //Band

    MapChnNumber.Delimiter := ';';
    MapChnName.Delimiter := ';';
    MapChnCode.Delimiter := ';';
    MapChnRoom.Delimiter := ';';
    MapChnBand.Delimiter := ';';

    for i := 0 to ExternComm.Count - 1 do
    begin
      AExternalCom := TExternal_Communication_Channel(ExternComm[i]);

      MapChnNumber.Add(IntToStr(AExternalCom.FData.Channel_Number));
      MapChnNumberStr := MapChnNumber.DelimitedText;

      MapChnName.Add(AExternalCom.FData.Channel_Identifier);
      MapChnNameStr := MapChnName.DelimitedText;

      MapChnCode.Add(AExternalCom.FData.Channel_Code);
      MapChnCodeStr := MapChnCode.DelimitedText;

      MapChnRoom.Add(IntToStr(3010 + i));
      MapChnRoomStr := MapChnRoom.DelimitedText;

      Band := AExternalCom.FData.Comms_Band;

      case Band of
        0 : MapChnBand.Add('HF');
        1 : MapChnBand.Add('VHF/UHF');
        2 : MapChnBand.Add('SATCOM');
        3 : MapChnBand.Add('UWT');
        4 : MapChnBand.Add('FM');
      end;

      MapChnBandStr := MapChnBand.DelimitedText;
    end;
  finally
    MapChnNumber.Free;
    MapChnName.Free;
    MapChnCode.Free;
    MapChnRoom.Free;
    MapChnBand.Free;
  end;

  AddGroupList(GroupName, GroupID,
     AvaChnNumberStr, AvaChnNameStr, AvaChnCodeStr, AvaChnRoomStr, AvaChnBandStr,
     MapChnNumberStr, MapChnNameStr, MapChnCodeStr, MapChnRoomStr, MapChnBandStr);

  //For Cubicle
  for i := 1 to ListGroupCub.Count  do
  begin
    ItemPopUp := TMenuItem.Create(PopUpMenu);
    ItemPopUp.Caption := ListGroupCub[i-1];
    GroupName := ListGroupCub[i-1];
    ItemPopUp.Tag := i;
    GroupID := StrToInt(ListGroupCubID[i-1]);
    ItemPopUp.OnClick := ClickItemPopUp;
    PopUpMenu.Items.Add(ItemPopUp);

    ListID        := nil;

    dmTTT.GetAllCubicle_Group_Channel_Assgnmnt(StrToInt(ListGroupCubID[i-1]),comList);
    try
      ListID := TStringList.Create;

      AvaChnNumber := TStringList.Create;
      AvaChnName := TStringList.Create;
      AvaChnCode := TStringList.Create;
      AvaChnRoom := TStringList.Create;
      AvaChnBand := TStringList.Create;

      MapChnNumber := TStringList.Create;
      MapChnName := TStringList.Create;
      MapChnCode := TStringList.Create;
      MapChnRoom := TStringList.Create;
      MapChnBand := TStringList.Create;

      ListID.Delimiter := ';';

      AvaChnNumber.Delimiter := ';';
      AvaChnName.Delimiter := ';';
      AvaChnCode.Delimiter := ';';
      AvaChnRoom.Delimiter := ';';
      AvaChnBand.Delimiter := ';';

      MapChnNumber.Delimiter := ';';
      MapChnName.Delimiter := ';';
      MapChnCode.Delimiter := ';';
      MapChnRoom.Delimiter := ';';
      MapChnBand.Delimiter := ';';

      for k := 0 to comList.Count - 1 do
      begin
        id := TCubicle_Group_Assignment(comList[k]).FChannel.Comms_Channel_Index;
        dmTTT.GetExternal_Communication_Channel(excomList,'',IntToStr(id),communication);

        if communication = nil then Continue;

        MapChnNumber.Add(IntToStr(communication.FData.Channel_Number));
        MapChnNumberStr := MapChnNumber.DelimitedText;

        MapChnName.Add(communication.FData.Channel_Identifier);
        MapChnNameStr := MapChnName.DelimitedText;

        MapChnCode.Add(communication.FData.Channel_Code);
        MapChnCodeStr := MapChnCode.DelimitedText;

        MapChnRoom.Add(IntToStr(3000 + communication.FData.Channel_Number));
        MapChnRoomStr := MapChnRoom.DelimitedText;

        Band := communication.FData.Comms_Band;

        case Band of
          0 : MapChnBand.Add('HF');
          1 : MapChnBand.Add('VHF/UHF');
          2 : MapChnBand.Add('FM');
          3 : MapChnBand.Add('SATCOM');
          4 : MapChnBand.Add('UWT');
        end;

        MapChnBandStr := MapChnBand.DelimitedText;
      end;

      for k := 0 to ExternComm.Count - 1 do
      begin
        AExternalCom := TExternal_Communication_Channel(ExternComm[k]);

        AvaChnNumber.Add(IntToStr(AExternalCom.FData.Channel_Number));
        AvaChnNumberStr := AvaChnNumber.DelimitedText;

        AvaChnName.Add(AExternalCom.FData.Channel_Identifier);
        AvaChnNameStr := AvaChnName.DelimitedText;

        AvaChnCode.Add(AExternalCom.FData.Channel_Code);
        AvaChnCodeStr := AvaChnCode.DelimitedText;

        AvaChnRoom.Add(IntToStr(3010 + AExternalCom.FData.Channel_Number));
        AvaChnroomStr := AvaChnRoom.DelimitedText;

        Band := AExternalCom.FData.Comms_Band;

        case Band of
          0 : AvaChnBand.Add('HF');
          1 : AvaChnBand.Add('VHF/UHF');
          2 : AvaChnBand.Add('FM');
          3 : AvaChnBand.Add('SATCOM');
          4 : AvaChnBand.Add('UWT');
        end;

        AvaChnBandStr := AvaChnBand.DelimitedText;
      end;

      repeat
        isselected:= false;
        p := -1;
        for k := 0 to AvaChnNumber.Count - 1 do
        begin
          for ii := 0 to MapChnNumber.Count - 1 do
          begin
            if AvaChnNumber[k] = MapChnNumber[ii] then
            begin
              p:= k;
              isselected:= true;
              Break;
            end;
          end;
        end;

        if isselected and (p <> -1) then
        begin
          AvaChnNumber.Delete(p);
          AvaChnName.Delete(p);
          AvaChnCode.Delete(p);
          AvaChnRoom.Delete(p);
          AvaChnBand.Delete(p);

          AvaChnNumberStr := AvaChnNumber.DelimitedText;
          AvaChnNameStr := AvaChnName.DelimitedText;
          AvaChnCodeStr := AvaChnCode.DelimitedText;
          AvaChnRoomStr := AvaChnRoom.DelimitedText;
          AvaChnBandStr := AvaChnBand.DelimitedText;
        end;
      until not isselected;

    finally
      ListID.Free;

      AvaChnNumber.Free;
      AvaChnName.Free;
      AvaChnCode.Free;
      AvaChnRoom.Free;
      AvaChnBand.Free;

      MapChnNumber.Free;
      MapChnName.Free;
      MapChnCode.Free;
      MapChnRoom.Free;
      MapChnBand.Free;
    end;

    AddGroupList(GroupName, GroupID,
       AvaChnNumberStr, AvaChnNameStr, AvaChnCodeStr, AvaChnRoomStr, AvaChnBandStr,
       MapChnNumberStr, MapChnNameStr, MapChnCodeStr, MapChnRoomStr, MapChnBandStr);
  end;
end;

procedure TCommTTT.GetChannelCub(AgrpID: Integer);
var
  i,ii : Integer;

  ComListCub : Tlist;
  ExComListCub : Tlist;
  band : Byte;
  AExternalCom: TExternal_Communication_Channel;
begin
  try
    ComListCub := TList.Create;
    ExComListCub := TList.Create;

    dmTTT.GetAllCubicle_Group_Channel_Assgnmnt(AgrpID,ComListCub);

    for i := 0 to frmToteDisplay.sgCommChannelDef.RowCount do
    begin
      frmToteDisplay.sgCommChannelDef.Objects[0, i+1] := TObject(0);
      frmToteDisplay.sgCommChannelDef.Cells[2, i+1] := '';
      frmToteDisplay.sgCommChannelDef.Cells[3, i+1] := '';
      frmToteDisplay.sgCommChannelDef.Cells[4, i+1] := 'VHF/UHF';
      frmToteDisplay.sgCommChannelDef.Cells[5, i+1] := '300';
    end;

    for i := 0 to ComListCub.Count - 1 do
    begin
      ii := TCubicle_Group_Assignment(ComListCub[i]).FChannel.Comms_Channel_Index;
      dmTTT.GetExternal_Communication_Channel(ExComListCub,'',IntToStr(ii),AExternalCom);

      if AExternalCom = nil then Continue;

      with  frmToteDisplay.sgCommChannelDef do
      begin
//        Objects[0, i+1] := TObject(1);
//        Cells[1, i+1] := IntToStr(i);
//        Cells[2, i+1] := AExternalCom.FData.Channel_Identifier;
//        Cells[3, i+1] := AExternalCom.FData.Channel_Code;

        Objects[0, AExternalCom.FData.Channel_Number+1] := TObject(1);
//        Cells[1, AExternalCom.FData.Channel_Number+1] := IntToStr(i);
        Cells[2, AExternalCom.FData.Channel_Number+1] := AExternalCom.FData.Channel_Identifier;
        Cells[3, AExternalCom.FData.Channel_Number+1] := AExternalCom.FData.Channel_Code;

        band := AExternalCom.FData.Comms_Band;
        case Band of
//          0 : Cells[4, i+1] := 'HF';
//          1 : Cells[4, i+1] := 'VHF/UHF';
//          2 : Cells[4, i+1] := 'FM';
//          3 : Cells[4, i+1] := 'SATCOM';
//          4 : Cells[4, i+1] := 'UWT';

          0 : Cells[4, AExternalCom.FData.Channel_Number+1] := 'HF';
          1 : Cells[4, AExternalCom.FData.Channel_Number+1] := 'VHF/UHF';
          2 : Cells[4, AExternalCom.FData.Channel_Number+1] := 'FM';
          3 : Cells[4, AExternalCom.FData.Channel_Number+1] := 'SATCOM';
          4 : Cells[4, AExternalCom.FData.Channel_Number+1] := 'UWT';
        end;
      end;
    end;
  finally
    ComListCub.Free;
    ExComListCub.Free;
  end;
end;

procedure TCommTTT.AddItemData(AListId: Integer);
var
  Map, Map2 : PRecGroupCom;
  i : Integer;

  //Available Channel
  AvailableChannelNumberStr : string;
  AvailableChannelNumberLst : TStrings;
  AvailableChannelNameStr : string;
  AvailableChannelNameLst : TStrings;
  AvailableChannelCodeStr : string;
  AvailableChannelCodeLst : Tstrings;
  AvailableRoomStr : string;
  AvailableRoomLst : TStrings;
  AvailableBandStr : string;
  AvailableBandLst : TStrings;

  //Mapped Channel
  MapChannelNumberStr : string;
  MapChannelNumberLst : TStrings;
  MapChannelNameStr : string;
  MapChannelNameLst : Tstrings;
  MapChannelCodeStr : string;
  MapChannelCodeLst : Tstrings;
  MapRoomStr : string;
  MapRoomLst : TStrings;
  MapBandStr : string;
  MapBandLst : TStrings;
begin
  frmToteDisplay.lbIn.Items.Clear;
  frmToteDisplay.lbOut.Items.Clear;
  frmToteDisplay.lbRoomIn.Items.Clear;
  frmToteDisplay.lbRoomOut.Items.Clear;

  frmToteDisplay.lvIn.Items.Clear;
  frmToteDisplay.lvOut.Items.Clear;

  AvailableChannelNumberLst := nil;
  AvailableChannelNameLst   := nil;
  AvailableChannelCodeLst   := nil;
  AvailableRoomLst          := nil;

  MapChannelNumberLst       := nil;
  MapChannelNameLst         := nil;
  MapChannelCodeLst         := nil;
  MapRoomLst                := nil;

  Try
    //Available Channel
    AvailableChannelNumberLst := TStringList.Create;
    AvailableChannelNumberLst.Delimiter := ';';
    AvailableChannelNameLst := TStringList.Create;
    AvailableChannelNameLst.Delimiter := ';';
    AvailableChannelCodeLst := TStringList.Create;
    AvailableChannelCodeLst.Delimiter := ';';
    AvailableRoomLst := TStringList.Create;
    AvailableRoomLst.Delimiter := ';';
    AvailableBandLst := TStringList.Create;
    AvailableBandLst.Delimiter := ';';

    //Mapping Channel
    MapChannelNumberLst := TStringList.Create;
    MapChannelNumberLst.Delimiter := ';';
    MapChannelNameLst := TStringList.Create;
    MapChannelNameLst.Delimiter := ';';
    MapChannelCodeLst := TStringList.Create;
    MapChannelCodeLst.Delimiter := ';';
    MapRoomLst := TStringList.Create;
    MapRoomLst.Delimiter := ';';
    MapBandLst := TStringList.Create;
    MapBandLst.Delimiter := ';';

    Map := PRecGroupCom(ListGroup[Aid]);
    Map2 := PRecGroupCom(ListGroup[AListId]);

    if AListId = 0 then
    begin
      //Group ID
      AGroupName := Map^.GroupName;
      AGroupId := map^.GroupID;
      frmToteDisplay.edtGroupName.Text := AGroupName;
    end;
    if AListId <> 0 then
    begin
      //Available Channel
      Map^.ChannelNumberAvailable := Map2^.ChannelNumberAvailable;
      Map^.ChannelNameAvailable   := Map2^.ChannelNameAvailable;
      Map^.ChannelCodeAvailable   := Map2^.ChannelCodeAvailable;
      Map^.ChannelRoomAvailable   := Map2^.ChannelRoomAvailable;
      map^.ChannelBandAvailable   := Map2^.ChannelBandAvailable;
      //Mapping Channel
      Map^.ChannelNumberMapping := Map2^.ChannelNumberMapping;
      Map^.ChannelNameMapping   := Map2^.ChannelNameMapping;
      Map^.ChannelCodeMapping   := Map2^.ChannelCodeMapping;
      Map^.ChannelRoomMapping   := Map2^.ChannelRoomMapping;
      Map^.ChannelBandMapping   := Map2^.ChannelBandMapping;
    end;

    //Available Channel
    AvailableChannelNumberStr := Map^.ChannelNumberAvailable;
    AvailableChannelNameStr   := Map^.ChannelNameAvailable;
    AvailableChannelCodeStr   := map^.ChannelCodeAvailable;
    AvailableRoomStr          := map^.ChannelRoomAvailable;
    AvailableBandStr          := Map^.ChannelBandAvailable;

    AvailableChannelNumberLst.DelimitedText := AvailableChannelNumberStr;
    AvailableChannelNameLst.DelimitedText := AvailableChannelNameStr;
    AvailableChannelCodeLst.DelimitedText := AvailableChannelCodeStr;
    AvailableRoomLst.DelimitedText := AvailableRoomStr;
    AvailableBandLst.DelimitedText := AvailableBandStr;

    frmToteDisplay.lbIn.Items.Assign(AvailableChannelCodeLst);
    frmToteDisplay.lbRoomIn.Items.Assign(AvailableRoomLst);

    NumberAvl.Assign(AvailableChannelNumberLst);
    NumberAvl.Delimiter := ';';
    RemainsNumberAvl := NumberAvl.DelimitedText;
    NameAvl.Assign(AvailableChannelNameLst);
    NameAvl.Delimiter := ';';
    RemainsNameAvl := NameAvl.DelimitedText;
    ChannelAvl.Assign(AvailableChannelCodeLst);
    ChannelAvl.Delimiter := ';';
    RemainsChannelAvl := ChannelAvl.DelimitedText;
    RoomAvl.Assign(AvailableRoomLst);
    RoomAvl.Delimiter := ';';
    RemainsRoomAvl := RoomAvl.DelimitedText;
    BandAvl.Assign(AvailableBandLst);
    BandAvl.Delimiter := ';';
    RemainsBandAvl := BandAvl.DelimitedText;

    for i := 0 to  AvailableChannelCodeLst.Count - 1 do
    begin
      with frmToteDisplay.lvIn.Items.Add do
      begin
         Caption := AvailableChannelNumberLst[i];
         SubItems.Add(AvailableChannelNameLst[i]);
         SubItems.Add(AvailableChannelCodeLst[i]);
      end;
    end;

    //Mapped Channel
    MapChannelNumberStr    := Map^.ChannelNumberMapping;
    MapChannelNameStr      := Map^.ChannelNameMapping;
    MapChannelCodeStr      := Map^.ChannelCodeMapping;
    MapRoomStr             := Map^.ChannelRoomMapping;
    MapBandStr             := Map^.ChannelBandMapping;

    MapChannelNumberLst.DelimitedText := MapChannelNumberStr;
    MapChannelNameLst.DelimitedText := MapChannelNameStr;
    MapChannelCodeLst.DelimitedText := MapChannelCodeStr;
    MapRoomLst.DelimitedText := MapRoomStr;
    MapBandLst.DelimitedText := MapBandStr;

    frmToteDisplay.lbOut.Items.Assign(MapChannelCodeLst);
    frmToteDisplay.lbRoomOut.Items.Assign(MapRoomLst);

    NumberMap.Assign(MapChannelNumberLst);
    NumberMap.Delimiter := ';';
    SendNumberMap := NumberMap.DelimitedText;
    NameMap.Assign(MapChannelNameLst);
    NameMap.Delimiter := ';';
    SendNameMap := NameMap.DelimitedText;
    ChannelMap.Assign(MapChannelCodeLst);
    ChannelMap.Delimiter := ';';
    SendChannelMap := ChannelMap.DelimitedText;
    RoomMap.Assign(MapRoomLst);
    RoomMap.Delimiter := ';';
    SendRoomMap := RoomMap.DelimitedText;
    BandMap.Assign(MapBandLst);
    BandMap.Delimiter := ';';
    SendBandMap := BandMap.DelimitedText;

    for i := 0 to MapChannelCodeLst.Count - 1 do
    begin
      with frmToteDisplay.lvOut.Items.Add do
      begin
        Caption := MapChannelNumberLst[i];
        SubItems.Add(MapChannelNameLst[i]);
        SubItems.Add(MapChannelCodeLst[i]);
      end;
    end;

  Finally
    AvailableChannelNumberLst.Free;
    AvailableChannelNameLst.Free;
    AvailableChannelCodeLst.Free;
    AvailableRoomLst.Free;

    MapChannelNumberLst.Free;
    MapChannelNameLst.Free;
    MapChannelCodeLst.Free;
    MapRoomLst.Free;
  End;
end;

procedure TCommTTT.BroadcastDataCon(AIdGrp : string);
var
  UDPChannelConAv : TRecSendControllerAv;
  UDPChannelConMp : TRecSendControllerMp;

  i : Integer;
  Map : PRecGroupCom;
begin
    for i := 0 to ListGroup.Count - 1 do
    begin
      Map := PRecGroupCom(ListGroup[i]);
      if Map^.GroupID = StrToInt(AIdGrp) then
      begin
        //Available Channel
        UDPChannelConAv.GroupName := Map^.GroupName;
        UDPChannelConAv.GroupID := Map^.GroupID;
        UDPChannelConAv.AvNumber := Map^.ChannelNumberAvailable;
        UDPChannelConAv.AvName := Map^.ChannelNameAvailable;
        UDPChannelConAv.AvCode := Map^.ChannelCodeAvailable;
        UDPChannelConAv.AvRoom := Map^.ChannelRoomAvailable;
        UDPChannelConAv.AvBand := Map^.ChannelBandAvailable;

        //Mapped Channel
        UDPChannelConMp.GroupName := Map^.GroupName;
        UDPChannelConMp.GroupID := Map^.GroupID;
        UDPChannelConMp.MpNumber := Map^.ChannelNumberMapping;
        UDPChannelConMp.MpName := Map ^.ChannelNameMapping;
        UDPChannelConMp.MpCode := Map^.ChannelCodeMapping;
        UDPChannelConMp.MpRoom := Map^.ChannelRoomMapping;
        UDPChannelConMp.MpBand := map^.ChannelBandMapping;

        BroadcasterSender.Connect('44144');
        BroadcasterSender.SendData(CPID_RecSendControllerAv, @UDPChannelConAv);
        BroadcasterSender.Close;

        BroadcasterSender.Connect('44144');
        BroadcasterSender.SendData(CPID_RecSendControllerMp, @UDPChannelConMp);
        BroadcasterSender.Close;
      end;
    end;
end;

procedure TCommTTT.BroadcastDataCub(AIdGrp : string);
var
  UDPChannel : TRecSendChannel;
  Map : PRecGroupCom;

  i : Integer;

begin
  UDPChannel.GroupID := StrToInt(AIdGrp);

  for i := 0 to ListGroup.Count - 1 do
  begin
    Map := PRecGroupCom(ListGroup[i]);
    if Map^.GroupID = StrToInt(AIdGrp) then
    begin
      UDPChannel.Number := Map^.ChannelNumberMapping;
      UDPChannel.Name := Map^.ChannelNameMapping;
      UDPChannel.Channel := Map^.ChannelCodeMapping;
      UDPChannel.Room := Map^.ChannelRoomMapping;
      UDPChannel.BandChannel := Map^.ChannelBandMapping;
      Break;
    end;
  end;

  BroadcasterSender.Connect('44444');
  BroadcasterSender.SendData(CPID_RecSendChannel, @UDPChannel);
  BroadcasterSender.Close;
end;

procedure TCommTTT.BroadcastDataDef(AConsName : string; ACol, Arow: Integer;
          AField: string; isCheck, isEdit : Boolean);
var
  UDPChannelDef : TrecSendControllerDef;
begin
  UDPChannelDef.ConsoleName := AConsName;
  UDPChannelDef.AColumn := ACol;
  UDPChannelDef.ARow := Arow;
  UDPChannelDef.isCheck := isCheck;
  UDPChannelDef.isEdit := isEdit;

  UDPChannelDef.EditField := AField;

  BroadcasterSender.Connect('44144');
  BroadcasterSender.SendData(CPID_RecSendControllerDef, @UDPChannelDef);
  BroadcasterSender.Close;
end;

procedure TCommTTT.CheckOnlineChannel;
var
  i : Integer;

  ListJam : TStrings;
begin
  frmToteDisplay.lvRecordIn.Items.Clear;

  ListJam := TStringList.Create;
  ListJam.Delimiter := ';';

  for i := 0 to frmToteDisplay.sgComInInjection.RowCount do
  begin
    frmToteDisplay.sgComInInjection.Cells[0, i+1] := '';
    frmToteDisplay.sgComInInjection.Cells[1, i+1] := '';
    frmToteDisplay.sgComInInjection.Cells[2, i+1] := '';
    frmToteDisplay.sgComInInjection.Cells[3, i+1] := '';
    frmToteDisplay.sgComInInjection.Cells[4, i+1] := '';
  end;

  for i := 0 to frmToteDisplay.sgCommChannelDef.RowCount do
  begin
    with frmToteDisplay.sgCommChannelDef do
    begin
      If Assigned(Objects[0, i]) Then
      begin
        ListJam.Add(IntToStr(i));

        {
        frmToteDisplay.sgComInInjection.Cells[0, i ] := frmToteDisplay.sgCommChannelDef.Cells[1, i];
        frmToteDisplay.sgComInInjection.Cells[1, i ] := frmToteDisplay.sgCommChannelDef.Cells[2, i];
        frmToteDisplay.sgComInInjection.Cells[2, i ] := frmToteDisplay.sgCommChannelDef.Cells[3, i];
        frmToteDisplay.sgComInInjection.Cells[3, i ] := 'Clear';
        frmToteDisplay.sgComInInjection.Cells[4, i ] := '[None]';
        }

        with frmToteDisplay.lvRecordIn.Items.Add do
        begin
          Caption := frmToteDisplay.sgCommChannelDef.Cells[1, i];
          SubItems.Add(frmToteDisplay.sgCommChannelDef.Cells[2, i]);
          SubItems.Add(frmToteDisplay.sgCommChannelDef.Cells[3, i]);
        end;
      end;
    end;
  end;

  for i := 0 to ListJam.Count - 1 do
  begin
    frmToteDisplay.sgComInInjection.Cells[0, i+1 ] := frmToteDisplay.sgCommChannelDef.Cells[1, StrToInt(ListJam[i])];
    frmToteDisplay.sgComInInjection.Cells[1, i+1 ] := frmToteDisplay.sgCommChannelDef.Cells[2, StrToInt(ListJam[i])];
    frmToteDisplay.sgComInInjection.Cells[2, i+1 ] := frmToteDisplay.sgCommChannelDef.Cells[3, StrToInt(ListJam[i])];
    frmToteDisplay.sgComInInjection.Cells[3, i+1 ] := 'Clear';
    frmToteDisplay.sgComInInjection.Cells[4, i+1 ] := '[None]';
  end;
end;

procedure TCommTTT.ClickCpItemPopUp(Sender: TObject);
var
  CpPpMenu : TMenuItem;
  TagCpPpMenu : Integer;
begin
  CpPpMenu := TMenuItem(Sender);
  TagCpPpMenu := CpPpMenu.Tag;

  AddItemData(TagCpPpMenu);

  BroadcastDataCub(IntToStr(AGroupId));
  BroadcastDataCon(IntToStr(AGroupId));
end;

procedure TCommTTT.ClickItemPopUp(Sender: TObject);
var
  PpMenu : TMenuItem;
  TagPpMenu : Integer;
begin
  PpMenu := TMenuItem(Sender);
  TagPpMenu := PpMenu.Tag;
  AId := TagPpMenu;

  AddItemData(0);
end;

procedure TCommTTT.AddChannelDefinintion(AChnNumber, AChnName, AChnCode,
  AChnRoom, AChnBand: string);
var
  Map: PRecChannelDefinition;
begin
  new(Map);
  Map^.ChannelNumber := AChnNumber;
  Map^.ChannelName := AChnName;
  Map^.ChannelCode := AChnCode;
  Map^.ChannelRoom := AChnRoom;
  Map^.ChannelBand := AChnBand;

  ListChnDef.Add(Map);
end;

procedure TCommTTT.AddGroupList(AGName: string; AGID: Integer; AChnNumberAva,
  AChnNameAva, AChnCodeAva, AChnRoomAva, AChnBandAva, AChnNumberMap,
  AChnNameMap, AChnCodeMap, AChnRoomMap, AChnBandMap: string);
var
  Map : PRecGroupCom;
begin
  New(Map);
  //Group Name n ID
  Map^.GroupName := AGName;
  Map^.GroupID := AGID;
  //Available Channel
  Map^.ChannelNumberAvailable := AChnNumberAva;
  Map^.ChannelNameAvailable := AChnNameAva;
  Map^.ChannelCodeAvailable := AChnCodeAva;
  Map^.ChannelRoomAvailable := AChnRoomAva;
  Map^.ChannelBandAvailable := AChnBandAva;
  //Mapping Channel
  Map^.ChannelNumberMapping := AChnNumberMap;
  Map^.ChannelNameMapping := AChnNameMap;
  Map^.ChannelCodeMapping := AChnCodeMap;
  Map^.ChannelRoomMapping := AChnRoomMap;
  Map^.ChannelBandMapping := AChnBandMap;

  listGroup.Add(Map);
end;

procedure TCommTTT.strgrdCheckBox(acol, arow: Integer);
var
  Map  : PRecChannelDefinition;
  Map2 : PRecGroupCom;

  AvaChnNumber, AvaChnName, AvaChnCode, AvaChnRoom, AvaChnBand : TStrings;
  MapChnNumber, MapChnName, MapChnCode, MapChnRoom, MapChnBand : TStrings;

  AvaChnNumberStr, AvaChnNameStr, AvaChnCodeStr, AvaChnRoomStr, AvaChnBandStr : string;
  MapChnNumberStr, MapChnNameStr, MapChnCodeStr, MapChnRoomStr, MapChnBandStr : string;

  DefChnNumber, DefChnName, DefChnCode, DefChnRoom, DefChnBand : string;
  i,j : integer;
  number_chanel : Integer;

  RemoveComm : TRecModifComm;
begin
  If aCol = 0 Then
  With frmToteDisplay.sgCommChannelDef Do
  Begin
    AvaChnNumber  := nil;
    AvaChnName    := nil;
    AvaChnCode    := nil;
    AvaChnRoom    := nil;
    AvaChnBand    := nil;

    MapChnNumber  := nil;
    MapChnName    := nil;
    MapChnCode    := nil;
    MapChnRoom    := nil;
    MapChnBand    := nil;

    If Assigned( Objects[aCol, aRow] ) Then
    begin
      Objects[aCol, aRow] := Nil;

      if isClick then
      begin
        for i := 1 to 4 do
        begin
          if ConsName = 'Controller ' + IntToStr(i)  then
          Continue;

          BroadcastDataDef('Controller ' + IntToStr(i) , acol, arow, '', True, False);
          Sleep(100);
        end;
      end;
      //CheckOnlineChannel;

      number_chanel := StrToInt(frmToteDisplay.sgCommChannelDef.Cells[1, arow]);

      for i := 0 to ListGroup.Count - 1 do
      begin
        Map2 := PRecGroupCom(ListGroup[i]);

        try
          //Check In Available Channel
          AvaChnNumber := TStringList.Create;
          AvaChnNumber.Delimiter := ';';
          AvaChnNumber.DelimitedText := Map2^.ChannelNumberAvailable;

          AvaChnName   := TStringList.Create;
          AvaChnName.Delimiter := ';';
          AvaChnName.DelimitedText := Map2^.ChannelNameAvailable;

          AvaChnCode   := TStringList.Create;
          AvaChnCode.Delimiter := ';';
          AvaChnCode.DelimitedText := Map2^.ChannelCodeAvailable;

          AvaChnRoom   := TStringList.Create;
          AvaChnRoom.Delimiter := ';';
          AvaChnRoom.DelimitedText := Map2^.ChannelRoomAvailable;

          AvaChnBand   := TStringList.Create;
          AvaChnBand.Delimiter := ';';
          AvaChnBand.DelimitedText := Map2^.ChannelBandAvailable;

          for j := 0 to AvaChnNumber.Count - 1 do
          begin
            if AvaChnNumber[j] = IntToStr(number_chanel) then
            begin
              AvaChnName.Delete(j);
              AvaChnCode.Delete(j);
              AvaChnRoom.Delete(j);
              AvaChnBand.Delete(j);
              Break;
            end;
          end;
          AvaChnNameStr := AvaChnName.DelimitedText;
          AvaChnCodeStr := AvaChnCode.DelimitedText;
          AvaChnRoomStr := AvaChnRoom.DelimitedText;
          AvaChnBandStr := AvaChnBand.DelimitedText;

          for j := 0 to AvaChnNumber.Count - 1 do
          begin
            if AvaChnNumber[j] = IntToStr(number_chanel) then
            begin
              AvaChnNumber.Delete(j);
              Break;
            end;
          end;
          AvaChnNumberStr := AvaChnNumber.DelimitedText;

          //Check In Mapped Channel
          MapChnNumber := TStringList.Create;
          MapChnNumber.Delimiter := ';';
          MapChnNumber.DelimitedText := Map2^.ChannelNumberMapping;

          MapChnName   := TStringList.Create;
          MapChnName.Delimiter := ';';
          MapChnName.DelimitedText := Map2^.ChannelNameMapping;

          MapChnCode   := TStringList.Create;
          MapChnCode.Delimiter := ';';
          MapChnCode.DelimitedText := Map2^.ChannelCodeMapping;

          MapChnRoom   := TStringList.Create;
          MapChnRoom.Delimiter := ';';
          MapChnRoom.DelimitedText := Map2^.ChannelRoomMapping;

          MapChnBand   := TStringList.Create;
          MapChnBand.Delimiter := ';';
          MapChnBand.DelimitedText := Map2^.ChannelBandMapping;

          for j := 0 to MapChnNumber.Count - 1 do
          begin
            if MapChnNumber[j] = IntToStr(number_chanel) then
            begin
              //sebelum didelete. di matikan dulu phone nya
              RemoveComm.GroupID := Map2^.GroupID;
              RemoveComm.Channel_Number := StrToInt(MapChnNumber[j]);
              RemoveComm.Channel_Code := MapChnCode[j];
              RemoveComm.Channel_Frek := StrToInt(MapChnRoom[j]);
              if MapChnBand[j] = 'HF' then
                RemoveComm.Channel_band := 0
              else if MapChnBand[j] = 'VHF/UHF' then
                RemoveComm.Channel_band := 1
              else if MapChnBand[j] = 'FM' then
                RemoveComm.Channel_band := 2
              else if MapChnBand[j] = 'SATCOM' then
                RemoveComm.Channel_band := 3
              else if MapChnBand[j] = 'UWT' then
                RemoveComm.Channel_band := 4;
              RemoveComm.ModifStat := mcsRemove;

              MapChnName.Delete(j);
              MapChnCode.Delete(j);
              MapChnRoom.Delete(j);
              MapChnBand.Delete(j);
              Break;
            end;
          end;
          MapChnNameStr := MapChnName.DelimitedText;
          MapChnCodeStr := MapChnCode.DelimitedText;
          MapChnRoomStr := MapChnRoom.DelimitedText;
          MapChnBandStr := MapChnBand.DelimitedText;

          for j := 0 to MapChnNumber.Count - 1 do
          begin
            if MapChnNumber[j] = IntToStr(number_chanel) then
            begin
              MapChnNumber.Delete(j);
              Break;
            end;
          end;
          MapChnNumberStr := MapChnNumber.DelimitedText;

          Map2^.ChannelNumberAvailable := AvaChnNumberStr;
          Map2^.ChannelNameAvailable   := AvaChnNameStr;
          Map2^.ChannelCodeAvailable   := AvaChnCodeStr;
          Map2^.ChannelRoomAvailable   := AvaChnRoomStr;
          Map2^.ChannelBandAvailable   := AvaChnBandStr;

          Map2^.ChannelNumberMapping   := MapChnNumberStr;
          Map2^.ChannelNameMapping     := MapChnNameStr;
          Map2^.ChannelCodeMapping     := MapChnCodeStr;
          Map2^.ChannelRoomMapping     := MapChnRoomStr;
          Map2^.ChannelBandMapping     := MapChnBandStr;

          AddItemData(0);
          CheckOnlineChannel;
        finally
          AvaChnNumber.Free;
          AvaChnName.Free;
          AvaChnCode.Free;
          AvaChnRoom.Free;
          AvaChnBand.Free;

          MapChnNumber.Free;
          MapChnName.Free;
          MapChnCode.Free;
          MapChnRoom.Free;
          MapChnBand.Free;
        end;
      end;

//      for i := 0 to frmToteDisplay.ListGroupCubID.Count - 1 do
//      begin
//        //BroadcastDataCub(ListGroupCubID[i]);
//      end;
    end
    Else
    begin
      Objects[aCol, aRow] := TObject(1);

      if isClick then
      begin
        for i := 1 to 4 do
        begin
          if ConsName = 'Controller ' + IntToStr(i)  then
          Continue;

          BroadcastDataDef('Controller ' + IntToStr(i) , acol, arow, '', True, False);
          Sleep(100);
        end;
      end;
      //CheckOnlineChannel;

      if (frmToteDisplay.sgCommChannelDef.Cells[2 , aRow]  = '')
          or (frmToteDisplay.sgCommChannelDef.Cells[3 , aRow] = '') then
      begin
        DefChnNumber := IntToStr(aRow-1);
        DefChnName   := 'Channel ' + IntToStr(aRow-1);
        DefChnCode   := 'Ch-' + IntToStr(aRow-1);
        DefChnRoom   := IntToStr(3000 + aRow-1);
        DefChnBand   := 'VHF/UHF';

        Map := PRecChannelDefinition(ListChnDef[aRow-1]);
        Map^.ChannelNumber := DefChnNumber;
        Map^.ChannelName   := DefChnName;
        Map^.ChannelCode   := DefChnCode;
        Map^.ChannelRoom   := DefChnRoom;
        Map^.ChannelBand   := DefChnBand;

        frmToteDisplay.sgCommChannelDef.Cells[2 , aRow] := Map^.ChannelName;
        frmToteDisplay.sgCommChannelDef.Cells[3 , aRow] :=  Map^.ChannelCode;

        for i := 0 to ListGroup.Count-1 do
        begin
          Map2 := PRecGroupCom(ListGroup[i]);

          try
            AvaChnNumber := TStringList.Create;
            AvaChnNumber.Delimiter := ';';
            AvaChnNumber.DelimitedText := Map2^.ChannelNumberAvailable;
            AvaChnNumber.Add(Map^.ChannelNumber);
            AvaChnNumberStr := AvaChnNumber.DelimitedText;

            AvaChnName   := TStringList.Create;
            AvaChnName.Delimiter := ';';
            AvaChnName.DelimitedText := Map2^.ChannelNameAvailable;
            AvaChnName.Add(Map^.ChannelName);
            AvaChnNameStr := AvaChnName.DelimitedText;

            AvaChnCode   := TStringList.Create;
            AvaChnCode.Delimiter := ';';
            AvaChnCode.DelimitedText := Map2^.ChannelCodeAvailable;
            AvaChnCode.Add(Map^.ChannelCode);
            AvaChnCodeStr := AvaChnCode.DelimitedText;

            AvaChnRoom   := TStringList.Create;
            AvaChnRoom.Delimiter := ';';
            AvaChnRoom.DelimitedText := Map2^.ChannelRoomAvailable;
            AvaChnRoom.Add(Map^.ChannelRoom);
            AvaChnRoomStr := AvaChnRoom.DelimitedText;

            AvaChnBand   := TStringList.Create;
            AvaChnBand.Delimiter := ';';
            AvaChnBand.DelimitedText := Map2^.ChannelBandAvailable;
            AvaChnBand.Add(Map^.ChannelBand);
            AvaChnBandStr := AvaChnBand.DelimitedText;

            Map2^.ChannelNumberAvailable := AvaChnNumberStr;
            Map2^.ChannelNameAvailable   := AvaChnNameStr;
            Map2^.ChannelCodeAvailable   := AvaChnCodeStr;
            Map2^.ChannelRoomAvailable   := AvaChnRoomStr;
            Map2^.ChannelBandAvailable   := AvaChnBandStr;

            AddItemData(0);
            CheckOnlineChannel;
          finally
            AvaChnNumber.Free;
            AvaChnName.Free;
            AvaChnCode.Free;
            AvaChnRoom.Free;
            AvaChnBand.Free;
          end;
        end;
      end
      else
      begin
        Map := PRecChannelDefinition(ListChnDef.Items[aRow-1]);

        for i := 0 to ListGroup.Count-1 do
        begin
          Map2 := PRecGroupCom(ListGroup[i]);

          try
            AvaChnNumber := TStringList.Create;
            AvaChnNumber.Delimiter := ';';
            AvaChnNumber.DelimitedText := Map2^.ChannelNumberAvailable;
            AvaChnNumber.Add(Map^.ChannelNumber);
            AvaChnNumberStr := AvaChnNumber.DelimitedText;

            AvaChnName   := TStringList.Create;
            AvaChnName.Delimiter := ';';
            AvaChnName.DelimitedText := Map2^.ChannelNameAvailable;
            AvaChnName.Add(Map^.ChannelName);
            AvaChnNameStr := AvaChnName.DelimitedText;

            AvaChnCode   := TStringList.Create;
            AvaChnCode.Delimiter := ';';
            AvaChnCode.DelimitedText := Map2^.ChannelCodeAvailable;
            AvaChnCode.Add(Map^.ChannelCode);
            AvaChnCodeStr := AvaChnCode.DelimitedText;

            AvaChnRoom   := TStringList.Create;
            AvaChnRoom.Delimiter := ';';
            AvaChnRoom.DelimitedText := Map2^.ChannelRoomAvailable;
            AvaChnRoom.Add(Map^.ChannelRoom);
            AvaChnRoomStr := AvaChnRoom.DelimitedText;

            AvaChnBand   := TStringList.Create;
            AvaChnBand.Delimiter := ';';
            AvaChnBand.DelimitedText := Map2^.ChannelBandAvailable;
            AvaChnBand.Add(Map^.ChannelBand);
            AvaChnBandStr := AvaChnBand.DelimitedText;

            Map2^.ChannelNumberAvailable := AvaChnNumberStr;
            Map2^.ChannelNameAvailable   := AvaChnNameStr;
            Map2^.ChannelCodeAvailable   := AvaChnCodeStr;
            Map2^.ChannelRoomAvailable   := AvaChnRoomStr;
            Map2^.ChannelBandAvailable   := AvaChnBandStr;

            AddItemData(0);
            CheckOnlineChannel;
          finally
            AvaChnNumber.Free;
            AvaChnName.Free;
            AvaChnCode.Free;
            AvaChnRoom.Free;
            AvaChnBand.Free;
          end;
        end;
      end;

    end;

    TGridCracker(frmToteDisplay.sgCommChannelDef).InvalidateCell( aCol, aRow);
  End;

  If aCol = 6 Then
  With frmToteDisplay.sgCommChannelDef Do
  Begin
     If Assigned( Objects[aCol, aRow] ) Then
     begin
        Objects[aCol, aRow] := Nil;
     end
     Else
     begin
        Objects[aCol, aRow] := TObject(1);
     end;

     TGridCracker(frmToteDisplay.sgCommChannelDef).InvalidateCell( aCol, aRow);
  End;
end;

procedure TCommTTT.strgrdKeypress(aKey : char; AId : integer);
var
  Map : PRecChannelDefinition;
  Map2 : PRecGroupCom;

  AvaChnNumber, AvaChnName, AvaChnCode : TStrings;
  MapChnNumber, MapChnName, MapChnCode : TStrings;
  AvaChnNameStr, AvaChnCodeStr : string;
  MapChnNameStr, MapChnCodeStr : string;

  i,j: Integer;
  ii,iii : Integer;
  AColumn : Integer;
  ARowmn : Integer;

  ss : string;
begin
  if AKey = #13 then
  begin
    AvaChnNumber  := nil;
    AvaChnName    := nil;
    AvaChnCode    := nil;

    MapChnNumber  := nil;
    MapChnName    := nil;
    MapChnCode    := nil;

    with frmToteDisplay.sgCommChannelDef do
    begin
      if AId = 0 then
      begin
        ii := Row-1;
        iii := Row;
      end
      else
      begin
        ii := Aid-1;
        iii := AId;
      end;

      Map := PRecChannelDefinition(ListChnDef[iii-1]);

      for i := 0 to ListGroup.Count - 1 do
      begin
        Map2 := PRecGroupCom(ListGroup[i]);
        try
          //Check Edit in Available Channel
          AvaChnNumber := TStringList.Create;
          AvaChnNumber.Delimiter := ';';
          AvaChnNumber.DelimitedText := Map2^.ChannelNumberAvailable;
          AvaChnName := TStringList.Create;
          AvaChnName.Delimiter := ';';
          AvaChnName.DelimitedText := Map2^.ChannelNameAvailable;
          for j := 0 to AvaChnNumber.Count - 1 do
          begin
            if AvaChnNumber[j] = IntToStr(ii) then
            begin
              AvaChnName[j] :=  frmToteDisplay.sgCommChannelDef.Cells[2 , iii];
              Break;
            end;
          end;
          AvaChnNameStr := AvaChnName.DelimitedText;

          MapChnNumber := TStringList.Create;
          MapChnNumber.Delimiter := ';';
          MapChnNumber.DelimitedText := Map2^.ChannelNumberMapping;
          AvaChnCode := TStringList.Create;
          AvaChnCode.Delimiter := ';';
          AvaChnCode.DelimitedText := Map2^.ChannelCodeAvailable;
          for j := 0 to AvaChnNumber.Count - 1 do
          begin
            if AvaChnNumber[j] = IntToStr(ii) then
            begin
              AvaChnCode[j] :=  frmToteDisplay.sgCommChannelDef.Cells[3 , iii];
              Break;
            end;
          end;
          AvaChnCodeStr := AvaChnCode.DelimitedText;

          //Check Edit in Mapped Channel
          MapChnNumber := TStringList.Create;
          MapChnNumber.Delimiter := ';';
          MapChnNumber.DelimitedText := Map2^.ChannelNumberMapping;
          MapChnName := TStringList.Create;
          MapChnName.Delimiter := ';';
          MapChnName.DelimitedText := Map2^.ChannelNameMapping;
          for j := 0 to MapChnNumber.Count - 1 do
          begin
            if MapChnNumber[j] = IntToStr(ii) then
            begin
              MapChnName[j] :=  frmToteDisplay.sgCommChannelDef.Cells[2 , iii];
              Break;
            end;
          end;
          MapChnNameStr := MapChnName.DelimitedText;

          MapChnNumber := TStringList.Create;
          MapChnNumber.Delimiter := ';';
          MapChnNumber.DelimitedText := Map2^.ChannelNumberMapping;
          MapChnCode := TStringList.Create;
          MapChnCode.Delimiter := ';';
          MapChnCode.DelimitedText := map2^.ChannelCodeMapping;
          for j := 0 to MapChnNumber.Count - 1 do
          begin
            if MapChnNumber[j] = IntToStr(ii) then
            begin
              MapChnCode[j] :=  frmToteDisplay.sgCommChannelDef.Cells[3 , iii];
              Break;
            end;
          end;
          MapChnCodeStr := MapChnCode.DelimitedText;

          Map2^.ChannelNameAvailable := AvaChnNameStr;
          Map2^.ChannelCodeAvailable := AvaChnCodeStr;
          Map2^.ChannelNameMapping := MapChnNameStr;
          Map2^.ChannelCodeMapping := MapChnCodeStr;

        finally
          AvaChnNumber.Free;
          AvaChnName.Free;
          AvaChnCode.Free;

          MapChnNumber.Free;
          MapChnName.Free;
          MapChnCode.Free;
        end;

        AddItemData(0);
        CheckOnlineChannel;
      end;

//      for jj := 0 to frmToteDisplay.ListGroupCubID.Count - 1 do
//      begin
//        BroadcastDataCub(ListGroupCubID[jj]);
//        sleep(100);
//      end;

      AColumn := Col;
      ARowmn := Row;

      ss := frmToteDisplay.sgCommChannelDef.Cells[AColumn, ARowmn];

      if isEnter then
      begin
        for i := 1 to 4 do
        begin
          if ConsName = 'Controller ' + IntToStr(i)  then
          Continue;

          BroadcastDataDef('Controller ' + IntToStr(i) , AColumn, ARowmn,
                          ss , False, True);
          Sleep(100);
        end;
      end;

      Map^.ChannelName := frmToteDisplay.sgCommChannelDef.Cells[2 , Row];
      Map^.ChannelCode := frmToteDisplay.sgCommChannelDef.Cells[3 , Row];
    end;
  end;
end;

procedure TCommTTT.CloseBroadCast;
begin

end;

procedure TCommTTT.CloseCommUtil;
begin
  //Mapping Channel
  NumberMap.Free;
  NameMap.Free;
  ChannelMap.Free;
  RoomMap.Free;
  BandMap.Free;

  //Available Channel
  NumberAvl.Free;
  NameAvl.Free;
  ChannelAvl.Free;
  RoomAvl.Free;
  BandAvl.Free;

  cList.Free;
  comList.Free;
  excomList.Free;

  ListGroupCub.Free;
  ListGroupCubID.Free;

  ListChnDef.Free;

  PopUpMenu.Free;
  ItemPopUp.Free;
end;

end.

