unit ufDebugNet;

interface

uses
  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type

  TfrmDebug = class(TForm)
    PageControl1: TPageControl;
    tsNetLog: TTabSheet;
    PageControl2: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    mmNet: TMemo;
    mmSend: TMemo;
    mmRecv: TMemo;
    Panel1: TPanel;
    tsNetConnect: TTabSheet;
    lvNetState: TListView;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Add_Log(mm: TMemo; const str: string);
    function UpdateConnectionInfo(const aIP: string; const aCon: Boolean): TListItem;
  public
    { Public declarations }
    procedure Add_NetStatusLog(const str: string);
    procedure Add_NetSendLog(const str: string);
    procedure Add_NetRecvLog(const str: string);
    procedure Add_ConnectionStatus(const aIP: string; const aCon: Boolean);
    procedure SetAsServerDebug;
    procedure SetAsClientDebug;
  end;

var
  frmDebug: TfrmDebug;

implementation

{$R *.dfm}
uses
  SysUtils;


procedure TfrmDebug.Add_Log(mm: TMemo; const str: string);
begin
//  if mm.Lines.Count >= 500 then
//    for i := mm.Lines.Count - 1 downto 480 do
//      mm.Lines.Delete(i);
  mm.Lines.Insert(0, str);
end;

procedure TfrmDebug.Add_NetStatusLog(const str: string);
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


function TfrmDebug.UpdateConnectionInfo(const aIP: string; const aCon: Boolean): TListItem;
begin
  result :=  lvNetState.FindCaption(0, aIP, False, True, false);
  if result = nil then begin
    result := lvNetState.Items.Add;
    with result do begin
      Caption := aIP;
      SubItems.Add(' - ');
    end;
  end;
  if aCon then
    Result.SubItems[0] := 'Connected'
  else
    Result.SubItems[0] := 'Closed';
end;

procedure TfrmDebug.Add_ConnectionStatus(const aIP: string; const aCon: Boolean);
begin
  UpdateConnectionInfo(aIP, aCon)
end;

procedure TfrmDebug.FormShow(Sender: TObject);
begin
  Left := Screen.Monitors[0].BoundsRect.Right - frmDebug.Width;
  Top := Screen.Monitors[0].BoundsRect.Bottom - frmDebug.Height;

end;


procedure TfrmDebug.SetAsClientDebug;
begin
  tsNetConnect.Visible := false;
end;

procedure TfrmDebug.SetAsServerDebug;
begin
  tsNetConnect.Visible := true;

end;

end.
