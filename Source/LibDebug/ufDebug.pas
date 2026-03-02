unit ufDebug;

interface

uses
  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TRecDebugInfo = record
    NetBufferCount: Integer;
  end;

  TfrmDebug = class(TForm)
    PageControl1: TPageControl;
    TabSheet5: TTabSheet;
    mmApp: TMemo;
    tsNetLog: TTabSheet;
    PageControl2: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    mmNet: TMemo;
    mmSend: TMemo;
    mmRecv: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    lblBuffCount: TLabel;
    tsError: TTabSheet;
    mmNetErr: TMemo;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    FDebugInfo : TRecDebugInfo;
    procedure Add_Log(mm: TMemo; const str: string);
  public
    { Public declarations }
    procedure Add_AppLog(const str: string);
    procedure Add_NetConnectLog(const str: string);
    procedure Add_NetSendLog(const str: string);
    procedure Add_NetRecvLog(const str: string);
    procedure Add_NetErrorLog(const str: string);
    procedure ShowDebug(const dbg: TRecDebugInfo );
  end;

var
  frmDebug: TfrmDebug;

implementation

{$R *.dfm}
uses
  SysUtils ;




procedure TfrmDebug.Add_Log(mm: TMemo; const str: string);
var i: Integer;
begin
  if mm.Lines.Count >= 500 then
    for i := mm.Lines.Count - 1 downto 480 do
      mm.Lines.Delete(i);
  mm.Lines.Insert(0, str);
end;

procedure TfrmDebug.Add_AppLog(const str: string);
begin
  Add_Log(mmApp, str);
end;

procedure TfrmDebug.Add_NetConnectLog(const str: string);
begin
  Add_Log(mmNet, str);
end;

procedure TfrmDebug.Add_NetSendLog(const str: string);
begin
  Add_Log(mmSend, str);
end;

procedure TfrmDebug.Add_NetRecvLog(const str: string);
begin
  Add_Log(mmRecv, str);
end;

procedure TfrmDebug.Add_NetErrorLog(const str: string);
begin
  Add_Log(mmNetErr, str);
end;

procedure TfrmDebug.FormShow(Sender: TObject);
begin
  Left := Screen.Monitors[0].BoundsRect.Right - frmDebug.Width;
  Top := Screen.Monitors[0].BoundsRect.Bottom - frmDebug.Height;

end;

{procedure TfrmDebug.AddClient(const ipAdd: string);
begin

end;
}

procedure TfrmDebug.ShowDebug(const dbg: TRecDebugInfo);
begin

   if Visible  and (FDebugInfo.NetBufferCount <> dbg.NetBufferCount) then begin
     lblBuffCount.Caption := IntToStr(dbg.NetBufferCount);
   end;
   FDebugInfo := dbg;
end;

procedure TfrmDebug.SpeedButton1Click(Sender: TObject);
var spb: TSpeedButton;

begin
  spb   := (sender as  TSpeedButton);

  if spb.Down then begin
      Timer1.Enabled := true;
      spb.Caption := 'stop';

  end
  else begin
    Timer1.Enabled := false;
    spb.Caption := 'start';
    spb.Down := False;

  end;

end;

end.
