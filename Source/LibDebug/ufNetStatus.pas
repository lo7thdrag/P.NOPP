unit ufNetStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons;

type
  TfrmNetStatus = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    StatusBar1: TStatusBar;
    lvNetState: TListView;
    Panel5: TPanel;
    Label1: TLabel;
    RichEdit2: TRichEdit;
    Splitter2: TSplitter;
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    lblIncoming: TLabel;
    lblOutGoing: TLabel;
    lblServerState: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    function UpdateMeshNode (const aIP: string; const aCon: Boolean;
      const id: integer): TListItem;
  public
    { Public declarations }
    procedure UpdateSocketList;

  end;

var
  frmNetStatus: TfrmNetStatus;

implementation

{$R *.dfm}

uses
  uTCP_Common, uTCP_Client_Mesh;

function TfrmNetStatus.UpdateMeshNode(const aIP: string; const aCon: Boolean;
  const id: integer): TListItem;
begin
  result :=  lvNetState.FindCaption(0, aIP, False, True, false);
  if result = nil then begin
    result := lvNetState.Items.Add;
    with result do begin
      Caption := aIP;
      SubItems.Add(' - ');
      SubItems.Add(' - ');
      SubItems.Add(' - ');
    end;
  end;
  if aCon then
    Result.SubItems[id] := 'Connected'
  else
    Result.SubItems[id] := 'Closed';
end;


//------------------------------------------------------------------------------
procedure TfrmNetStatus.FormCreate(Sender: TObject);
begin
  //  Show;
  //timer1.enabled := true;

end;

procedure TfrmNetStatus.Timer1Timer(Sender: TObject);
begin
  UpdateSocketList;
end;

procedure TfrmNetStatus.UpdateSocketList;
var i, count: integer;
    ip : string;
    cStat: Boolean;
    li : TListItem;
begin
  if netClient_Mesh = nil then Exit;

  count := netClient_Mesh.ClientCount;
  lblOutGoing.Caption := IntToStr(count);
  for i := 0 to count-1 do begin
     ip := netClient_Mesh.ClientsIP[i];
     cStat := netClient_Mesh.ClientConected[i];

     li := UpdateMeshNode(ip, cStat, 1 );
     li.SubItems[2] := netClient_Mesh.GetCallsignFromIP(ip);
     li.SubItems[0] := '';

  end;

  count :=  netClient_Mesh.SvrClientCount;
  lblIncoming.Caption := IntToStr(count);

  for i := 0 to count-1 do begin
     ip := netClient_Mesh.SvrClientIP[i];
     cStat := netClient_Mesh.SvrClientConnected[i];
     UpdateMeshNode(ip, cStat, 0 );
  end;

end;

end.
