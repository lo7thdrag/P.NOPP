unit uBaseSimObjects;

(*
  andySu, 2008 11 07
*)

interface

type

  TBaseSimObject = class
  private
    FAbsoluteFree: Boolean;
    FDeleteFromSnapshot: Boolean;
    procedure SetAbsoluteFree(const Value: Boolean);
    procedure SetDeleteFromSnapshot(const Value: Boolean);
  protected
    FEnable: boolean;
    FFreeMe: boolean;
    procedure SetEnable(const Value: boolean);virtual;
    procedure SetFreeMe(const Value: boolean);virtual;

  public
    UniqueID: string;

    constructor Create;
    destructor Destroy; override;

    property Enable : boolean read FEnable write SetEnable;
    //FreeMe hanya untuk invisible Oject dari display, tapi object tetap ada didalam container;
    property FreeMe : boolean read FFreeMe write SetFreeMe;
    //AbsoluteFree hanya untuk invisible Oject dari display, tapi object didelete dari conatiner;
    property AbsoluteFree : Boolean read FAbsoluteFree write SetAbsoluteFree;
    //DeleteFromSnapshot untuk delete object setelah file snapshot selesai diload;
    property DeleteFromSnapshot : Boolean  read FDeleteFromSnapshot write SetDeleteFromSnapshot;

  end;

implementation

{ TBaseSimClass }

constructor TBaseSimObject.Create;
begin
  FreeMe := False;
  FEnable := false;
  AbsoluteFree := False;
  DeleteFromSnapshot := False;
end;

destructor TBaseSimObject.Destroy;
begin

  inherited;
end;

procedure TBaseSimObject.SetAbsoluteFree(const Value: Boolean);
begin
  FAbsoluteFree := Value;
end;

procedure TBaseSimObject.SetDeleteFromSnapshot(const Value: Boolean);
begin
  FDeleteFromSnapshot := Value;
end;

procedure TBaseSimObject.SetEnable(const Value: boolean);
begin
  FEnable := Value;
end;

procedure TBaseSimObject.SetFreeMe(const Value: boolean);
begin
  FFreeMe := Value;
end;

end.
