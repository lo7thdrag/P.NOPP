unit ufDebugReplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  uSimMgr_Server,
  StdCtrls, ComCtrls, Grids, ExtCtrls,
  uNewReplay , uCommonLogReplay ;

type
  TfrmDebugReplay = class(TForm)
    btnOpenFile: TButton;
    OpenDlg: TOpenDialog;
    btnStartReplay: TButton;
    btnPause: TButton;
    btnResume: TButton;
    rgReplayGameSpeed: TRadioGroup;
    sGrid: TStringGrid;
    Panel2: TPanel;
    btnStopReplay: TButton;
    btnClose: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    lblFrameInfo: TLabel;
    ScrollBar1: TScrollBar;
    procedure btnOpenFileClick(Sender: TObject);
    procedure sGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure btnStartReplayClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnResumeClick(Sender: TObject);
    procedure rgReplayGameSpeedClick(Sender: TObject);
    procedure sGridClick(Sender: TObject);
    procedure btnStopReplayClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
  public
    procedure ReplayOnEnd;
    procedure ReplayOnGetFrame(
       var mtick, mprevTick, mprevDataTick  : LongWord );
  end;

var
  frmDebugReplay: TfrmDebugReplay;
    ScrollBar1: TScrollBar;

implementation

uses Math ;

{$R *.dfm}

procedure TfrmDebugReplay.ReplayOnEnd;
begin

end;

procedure TfrmDebugReplay.ReplayOnGetFrame(
    var mtick, mprevTick, mprevDataTick  : LongWord );
var i,j     : integer;
begin
  with simMgrServer do
  begin
    lblFrameInfo.Caption:= Format('Frame %d of %d',
       [NReplay.CurrentFrame, NReplay.MaxFrame ]);

    if NReplay.AfterSeek then begin
      for i := NReplay.CurrentFrame to sGrid.RowCount-1 do
        for j := 0 to sGrid.ColCount-1 do
          SGrid.Cells[j, i] := '';
    end;

    SGrid.Cells[0, NReplay.CurrentFrame+1] := IntToStr(NReplay.CurrentFrame);
    SGrid.Cells[1, NReplay.CurrentFrame+1] := IntToStr(NReplay.DataTick);
    SGrid.Cells[2, NReplay.CurrentFrame+1] := IntToStr(GetTickCount);
    (***)
    SGrid.Cells[3, NReplay.CurrentFrame+1] :=
        IntToStr(NReplay.DataTick );

    SGrid.Cells[4, NReplay.CurrentFrame+1] := IntToStr(NReplay.FrameSpeedMultiply
    [NReplay.CurrentFrame] );

    SGrid.Cells[5, NReplay.CurrentFrame+1] := IntToStr(mtick - mprevTick);

    ScrollBar1.OnChange := nil;
    ScrollBar1.Position := NReplay.CurrentFrame;
    ScrollBar1.OnChange := ScrollBar1Change;

    mprevTick := mtick;
    mprevDataTick := NReplay.DataTick;

  end;

end;

procedure TfrmDebugReplay.rgReplayGameSpeedClick(Sender: TObject);
var pw: integer;
    gs : integer;
begin
  pw := (sender as TRadioGroup).ItemIndex;
  gs := Round(IntPower(2,pw));

  simMgrServer.NReplay.ReplaySpeedMultiplier := gs;
end;

procedure TfrmDebugReplay.ScrollBar1Change(Sender: TObject);
begin
  simMgrServer.NReplay.SeekPlay(ScrollBar1.Position);
end;

procedure TfrmDebugReplay.btnCloseClick(Sender: TObject);
begin
  simMgrServer.NReplay.CloseFileReplay;
end;

procedure TfrmDebugReplay.btnPauseClick(Sender: TObject);
begin
  simMgrServer.GamePause;
end;

procedure TfrmDebugReplay.btnResumeClick(Sender: TObject);
begin
  simMgrServer.GameStart;
end;

procedure TfrmDebugReplay.btnStartReplayClick(Sender: TObject);
begin
  ScrollBar1.Max := simMgrServer.NReplay.MaxFrame;

  simMgrServer.GameStart;

end;

procedure TfrmDebugReplay.btnStopReplayClick(Sender: TObject);
begin
  simMgrServer.GamePause;
end;

procedure TfrmDebugReplay.btnOpenFileClick(Sender: TObject);
var
  i : integer ;
begin
  if openDlg.Execute then begin
    if not simMgrServer.NReplay.OpenFileReplay(openDlg.FileName) then begin
      ShowMessage('Failed to Open File Replay');
      exit;
    end;

    ScrollBar1.Max := simMgrServer.NReplay.MaxFrame;

    sGrid.RowCount := simMgrServer.NReplay.MaxFrame+1;

    for i := 1 to sGrid.RowCount-1 do begin
      sGrid.Rows[i].Clear;

    end;

  end;
end;

procedure TfrmDebugReplay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree ;
end;

procedure TfrmDebugReplay.FormCreate(Sender: TObject);
begin
  SGrid.Cells[0, 0] := 'Frame';
  SGrid.Cells[1, 0] := 'LogTime';
  SGrid.Cells[2, 0] := 'RealTime';
  SGrid.Cells[3, 0] := 'LogDelay';
  SGrid.Cells[4, 0] := 'Multiply';
  SGrid.Cells[5, 0] := 'RealDelay';
end;

procedure TfrmDebugReplay.FormDestroy(Sender: TObject);
begin
   frmDebugReplay := nil ;
end;

procedure TfrmDebugReplay.sGridClick(Sender: TObject);
  procedure ShowDataInfo;
  begin
  end;

  procedure ShowHistoryInfo;
  begin
  end;

var
  selIndex : integer;
begin
  selIndex :=  sGrid.Selection.Top -1;
  simMgrServer.NReplay.SeekPlay(selIndex);

  ShowDataInfo;
  ShowHistoryInfo;

end;

procedure TfrmDebugReplay.sGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const DEF_CLR = $000008ff;
      DEF_CHAR = ['1', '2',  '4',  '8'];
var clr : TColor;
    trm : string;
    i: integer;
    ch : char;
begin
  trm := Trim(sGrid.Cells[4, ARow]);

  if (Length(trm)=1) then
    if trm[1] in DEF_CHAR then begin
      i := StrToInt(trm);

      clr := DEF_CLR shl i shl i;

      sGrid.Canvas.Font.Color := clr;

      sGrid.Canvas.TextOut(
        Rect.Left+2, Rect.Top+1, sGrid.Cells[ACol, ARow]);
    end;

end;

end.
