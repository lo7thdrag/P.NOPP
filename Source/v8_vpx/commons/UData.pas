unit UData;

interface

const
// Command bytes
  ID_NOP = 0;
  ID_IMG = 1;
  ID_STR = 2;
  ID_REC = 3;
  ID_PING = 4;

  ID_IMG_ACK = 101;
  ID_STR_ACK = 102;
  ID_REC_ACK = 103;
  ID_PING_ACK = 104;

type
  TClientRec = packed record
    Name: array [0 .. 49] of byte;
    Address: array [0 .. 14] of byte;
    Port: Integer;
  end;

implementation

end.
