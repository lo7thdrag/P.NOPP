unit uT3netPlatform;

interface

type


  TPlatformData = record
    PlatformID : Integer;
    X, Y, Z  : double;
    Course,
    Speed    : single;
  end;

  TT3NetPlatform = class
  private

  public
    MovementData : TPlatformData;



  end;

implementation

end.
