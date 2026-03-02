unit ufT3NetListen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, uNetClient_Mgr;

type

  TfrmNetListen = class(TForm)
    sgDistance: TStringGrid;
    Panel1: TPanel;
    btnGetDistance: TButton;
    Label1: TLabel;
    Label2: TLabel;
    lblGameState: TLabel;
    lblSelectedPID: TLabel;
    network: TLabel;
    lblSockState: TLabel;
    lblConsole: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure btnGetDistanceClick(Sender: TObject);
  private
    { Private declarations }
    function FindPlatform(const pid: integer): integer;
  public
    { Public declarations }
    procedure event_OnConnected(Sender: TObject);
    procedure event_OnDisConnected(Sender: TObject);

    procedure event_OnCtrlConnected(Sender: TObject);
    procedure event_OnCtrlDisConnected(Sender: TObject);

    procedure event_OnGameState (const newState: TGamePlayState);

    procedure event_OnSelectPlatform(const selPID: integer);
    procedure event_OnGetPlatformData(const selPID: integer);

    procedure event_OnNetLog(const s: string);
  end;

var
  frmNetListen: TfrmNetListen;

implementation

{$R *.dfm}

uses
   uT3netPlatform;


procedure TfrmNetListen.btnGetDistanceClick(Sender: TObject);
var i, j, pid1, pid2: integer;
   p1, p2: TT3NetPlatform;
   dist: double;
begin
   if netMgr.PlatformCount = 0 then
     exit;

   sgDistance.RowCount := netMgr.PlatformCount + 1;
   sgDistance.ColCount := netMgr.PlatformCount + 1;

   for I := 0 to netMgr.PlatformCount - 1 do begin
     p1 := netMgr.Platforms[i];
     sgDistance.Cells[0, i + 1] :=  Format('%4d', [p1.MovementData.PlatformID]);
     sgDistance.Cells[i + 1, 0] :=  Format('%4d', [p1.MovementData.PlatformID]);


     pid1 := p1.MovementData.PlatformID;
     for j := 0 to i do begin
       p2   := netMgr.Platforms[j];
       pid2 := p2.MovementData.PlatformID;

       if pid1 <> pid2  then begin
         dist := netMgr.getDistance(pid1, pid2);
         sgDistance.Cells[j + 1, i + 1] := Format('%4.2f', [dist]);
       end
       else begin
         sgDistance.Cells[j + 1, i + 1] := '0.0';
       end;
     end;

   end;

end;
function TfrmNetListen.FindPlatform(const pid: integer): integer;
begin
  result := sgDistance.Cols[0].IndexOf(IntToStr(pid));
end;

procedure TfrmNetListen.event_OnConnected(Sender: TObject);
begin
//  btnGetDistance.Enabled := true;
  lblSockState.Caption := 'Connected';
end;

procedure TfrmNetListen.event_OnDisConnected(Sender: TObject);
begin
//  btnGetDistance.Enabled := false;
  lblSockState.Caption := 'Disconnected';

end;

procedure TfrmNetListen.event_OnCtrlConnected(Sender: TObject);
begin
  lblConsole.Caption := 'Connected';

end;

procedure TfrmNetListen.event_OnCtrlDisConnected(Sender: TObject);
begin
  lblConsole.Caption := 'Disconnected';

end;

procedure TfrmNetListen.event_OnGameState(const newState: TGamePlayState);
begin
  case newState of
    gsStop      : lblGameState.caption := 'Stopped';
    gsPlaying   : lblGameState.Caption := 'Playing';
  end;
end;

procedure TfrmNetListen.event_OnSelectPlatform(const selPID: integer);
begin
  lblSelectedPID.Caption := IntToStr(selPID);
end;

procedure TfrmNetListen.event_OnGetPlatformData(const selPID: integer);
var i: integer;
begin
//  Memo1.Lines.Add(IntToStr(selPID));
{  i := sgDistance.Cols[0].IndexOf(IntToStr(selPID));
  if i < 0 then  then
    exit;
}
//  sgDistance.CellRect].


end;
procedure TfrmNetListen.event_OnNetLog(const s: string);
begin
  Memo1.Lines.Add(s);
end;


end.
