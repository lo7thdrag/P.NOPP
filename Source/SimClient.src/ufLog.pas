unit ufLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uT3UnitContainer, uBaseCoordSystem, ComCtrls,
  ExtCtrls, VrControls, VrButtons, VrBlinkLed,U_Helper ;

type
  TfrmLog = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    lbPlatform: TListBox;
    Button1: TButton;
    TabSheet3: TTabSheet;
    Memo2: TMemo;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    Button2: TButton;
    Button3: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    Button4: TButton;
    tsDatalink: TTabSheet;
    lblNCS: TLabel;
    lblDL1: TLabel;
    lblDL2: TLabel;
    lblDL3: TLabel;
    mmoDL1: TMemo;
    mmoDL2: TMemo;
    mmoDL3: TMemo;
    tsDataBuffer: TTabSheet;
    mmo1: TMemo;
    btn1: TButton;
    vrblnkld1: TVrBlinkLed;
    lvPlatform: TListView;
    tsStatusPlatform: TTabSheet;
    lvStatusPlatform: TListView;
    pnl1: TPanel;
    btnStart: TButton;
    btnStop: TButton;
    tmrStatePlatform: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
//    procedure ComboBox1DropDown(Sender: TObject);
//    procedure ComboBox1Change(Sender: TObject);
//    procedure Button2Click(Sender: TObject);
//    procedure Button3Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure cbDatalinkChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
//    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
//    procedure tmrStatePlatformTimer(Sender: TObject);
  private
//    FWatchObj : TT3PlatformInstance;
    FStr : TStrings;
    ActiveLogTemporary : Boolean;
    FLogFile: TLogFile;
    { Private declarations }
  public
    { Public declarations }
    procedure LogNetworkEvent(const Value: String);
//    procedure LogStr(const strHeader, strBody: string);
//    procedure NetworkEventLogs(const strHeader, strBody : string);
    procedure ListWeapon(pfs : TT3UnitContainer);
    procedure LogDataBuffer(const s : string);
    procedure DatalinkUpdate(Sender : TObject);
    procedure LogTemporary(const s : string);
    procedure FinishBuffer(const b : Boolean);
    procedure AddedToLogFile(strHeader, strBody: string);
    procedure InsertEmptyLine;

    property LogFile : TLogFile read FLogFile write FLogFile;
  end;

var
  frmLog: TfrmLog;

implementation

uses
  uSimMgr_Client;

{$R *.dfm}
procedure TfrmLog.AddedToLogFile(strHeader, strBody: string);
var
  str : string;
begin
  str := '<'+FormatDateTime('dd mmm yyyy hh:nn:ss',Now)+ '> ['+strHeader+'] '+strBody;

  if Assigned(FLogFile) then
    FLogFile.Log(strHeader, strBody);
end;

procedure TfrmLog.InsertEmptyLine;
begin
  if Assigned(FLogFile) then
    FLogFile.InsertEmptyLine;
end;

procedure TfrmLog.btn1Click(Sender: TObject);
begin
  ActiveLogTemporary := not ActiveLogTemporary;
end;


procedure TfrmLog.btnStopClick(Sender: TObject);
begin
  tmrStatePlatform.Enabled := False;
end;

procedure TfrmLog.Button1Click(Sender: TObject);
var
  i : integer;
  str : string;
begin
  lbPlatform.Clear;

  if Assigned(simMgrClient) then

  for i := 0 to simMgrClient.SimPlatforms.itemCount - 1 do begin
    str := FormatFloat('##.##',simMgrClient.SimPlatforms.getObject(i).getPositionX);
    str := '(' + str + ',' + FormatFloat('##.##',simMgrClient.SimPlatforms.getObject(i).getPositionY);
    str := str + '), alt : ' + FormatAltitude(TT3PlatformInstance(simMgrClient.SimPlatforms.getObject(i)).Altitude);
    str := str + ' m';

    lbPlatform.Items.Add(TT3PlatformInstance(simMgrClient.SimPlatforms.getObject(i)).InstanceName + str);
  end;

end;

//procedure TfrmLog.Button3Click(Sender: TObject);
//begin
//  Timer1.Enabled := false;
//
//end;

procedure TfrmLog.LogDataBuffer(const s: string);
begin
  if ActiveLogTemporary  then
  begin
    if mmo1.Lines.Count > 250 then
    begin
      mmo1.Clear;
    end;

    mmo1.Lines.Insert(0,s)
  end;
end;

procedure TfrmLog.LogNetworkEvent(const Value: String);
begin
  //Memo2.Lines.Add(Value);
end;

procedure TfrmLog.Button4Click(Sender: TObject);
begin
//  Memo2.Clear;
//  if assigned(FStr) then
//    Memo2.Lines.AddStrings(FStr);
//  FStr.Clear;
end;

procedure TfrmLog.cbDatalinkChange(Sender: TObject);
//var
//  i,j : integer;
//  vObject,vSnsr : TObject;
//  vItem    : TT3DLParticipatingUnitItem;
//  vPf      : TT3PlatformInstance;
//  sSensorL : string;
//  datalink : TT3DataLink;
begin
//  mmParticipant.Clear;
//
//  datalink := simMgrClient.DataLinkManager.getDatalink(TComboBox(Sender).ItemIndex + 1);
//
//  if Assigned(datalink) then
//  begin
//    for i:=0 to datalink.ParticipatingUnits.Count - 1 do begin
//      vItem := datalink.ParticipatingUnits.Items[i];
//      mmParticipant.Lines.Add(vItem.PUPlatform.InstanceName);
//    end;
//  end;
//
//  mmDetectedTrack.Lines.Clear;
//  for i:=0 to simMgrClient.SimDetectedTrackList.itemCount - 1 do begin
//    vObject := simMgrClient.SimDetectedTrackList.getObject(i);
//    if Assigned(TT3DetectedTrack(vObject).TrackObject) then begin
//      vPf := TT3DetectedTrack(vObject).TrackObject as TT3PlatformInstance;
//
//      sSensorL := '';
//      for j := 0 to TT3DetectedTrack(vObject).TrackDetectedBy.Count - 1 do begin
//        vSnsr := TT3DetectedTrack(vObject).TrackDetectedBy.Items[j];
//        sSensorL := sSensorL + vSnsr.ClassName;
//        sSensorL := sSensorL + ',';
//      end;
//
//      sSensorL := '(' + sSensorL + ')';
//      sSensorL := vPf.InstanceName + sSensorL;
//
//      mmDetectedTrack.Lines.Add(sSensorL);
//    end;
//  end;

end;

procedure TfrmLog.DatalinkUpdate(Sender: TObject);

begin
  
end;

procedure TfrmLog.FinishBuffer(const b: Boolean);
begin
  if b then
  begin
    //ketika databuffer sudah normal
    vrblnkld1.Palette1.High := clLime;
    vrblnkld1.Palette1.Low := clLime;
  end
  else
  begin
    //ketika databuffer masih melakukan buffer
    vrblnkld1.Palette1.High := clRed;
    vrblnkld1.Palette1.Low := clRed;
  end;
end;

procedure TfrmLog.FormCreate(Sender: TObject);
begin
  //Hide;
  Show;
  FStr := TStringList.Create;
  ActiveLogTemporary := False;
  WindowState := wsMinimized;
  Timer1.Enabled := False;

  FLogFile := TLogFile.Create;
  FLogFile.IsLog := True;

  {$IfDef CLIENT}
  Memo1.Lines.Insert(0, 'CLient Mode');
  {$EndIf}
end;

procedure TfrmLog.FormDestroy(Sender: TObject);
begin
  if Assigned(FLogFile) then FLogFile.Free;
end;

procedure TfrmLog.ListWeapon(pfs: TT3UnitContainer);
begin
//
end;

procedure TfrmLog.LogTemporary(const s: string);
var
  gt : string;
  dt : TDateTime;
begin
  dt := simMgrClient.GameTIME;
  gt := FormatDateTime('hh : nn : ss', dt) + ' : ' + s;

  if Memo2.Lines.Count > 250 then
  begin
    Memo2.Clear;
  end;

  Memo2.Lines.Insert(0,gt)
end;

procedure TfrmLog.Timer2Timer(Sender: TObject);
begin
  {Memo2.Clear;
  if assigned(FStr) then
    Memo2.Lines.AddStrings(FStr);
  FStr.Clear;}
end;

end.
