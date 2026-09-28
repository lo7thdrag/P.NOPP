unit uRemoteData;

interface

uses
  Windows, Classes, SysUtils, Graphics, Math  ;

const
  BUFF_SIZE = 8192;
  BSIZE     = 16;
  BNUMS     = BSIZE * BSIZE;

  ///order id
  C_RMT_COMMAND           = 01 ;
  C_RMT_MOUSE_MOVE        = 11 ;
  C_RMT_MOUSE_LEFT_DOWN   = 12 ;
  C_RMT_MOUSE_RIGHT_DOWN  = 13 ;
  C_RMT_MOUSE_LEFT_UP     = 14 ;
  C_RMT_MOUSE_RIGHT_UP    = 15 ;
  C_RMT_MOUSE_WHEEL16     = 16 ;
  C_RMT_MOUSE_WHEEL17     = 17 ;
  C_RMT_FormKey_DOWN      = 18 ;
  C_RMT_FormKey_UP        = 19 ;

  {
  12: mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
  13: mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
  14: mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
  15: mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
  16: mouse_event(MOUSEEVENTF_WHEEL, 0, 0, 4294967176, 0);
  17: mouse_event(MOUSEEVENTF_WHEEL, 0, 0, 120, 0);
  18: keybd_event(Byte(TCtlCmd(FCmd).X), MapVirtualKey(Byte(TCtlCmd(FCmd).X), 0), 0, 0);
  19: keybd_event(Byte(TCtlCmd(FCmd).X), MapVirtualKey(Byte(TCtlCmd(FCmd).X), 0), 2, 0);
  }

type
  PRemoteCmd = ^TRemoteCmd;
  TRemoteCmd = packed record
    Cmd:  Byte;
    Size: Integer;
  end;

  PRemoteCtlCmd = ^TRemoteCtlCmd;
  TRemoteCtlCmd = packed record
    Cmd:  Byte;
    X, Y: Word;
  end;

  PRemoteInfo = ^TRemoteInfo;
  TRemoteInfo = packed record
    Head: Boolean;
    Size: Integer;
    Rec:  Integer;
    Buf:  array[0..BUFF_SIZE - 1] of Byte;
    Pos:  Integer;
    Cmd:  array[0..SizeOf(TRemoteCmd) - 1] of Byte;
  end;


implementation

end.
