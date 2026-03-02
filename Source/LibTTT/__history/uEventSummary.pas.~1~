unit uEventSummary;

interface

uses
  MapXLib_TLB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ImgList, ComCtrls, ToolWin,
  OleCtrls, uCoordConvertor, uLibSettingTTT, tttData, uBaseCoordSystem, uGameData_TTT,
  {TeCanvas,} ColorGrd, uDataTypes, uObjectVisuals, uSnapshotData;

type
  TEventSummary = class
  private
    FTime: TDateTime;
    FAction: string;
    FVehicleIdentifier: string;
    FForce: Integer;

    procedure SetAction(const Value: string);
    procedure SetForce(const Value: Integer);
    procedure SetTime(const Value: TDateTime);
    procedure SetVehicleIdentifier(const Value: string);

  public
    constructor create;
    destructor Destroy; override;

    property Time   : TDateTime read FTime write SetTime;
    property VehicleIdentifier  : string read FVehicleIdentifier write SetVehicleIdentifier;
    property Force : Integer read FForce write SetForce;
    property Action : string read FAction write SetAction;
  end;

implementation

{ TEventSummary }

constructor TEventSummary.create;
begin

end;

destructor TEventSummary.Destroy;
begin

  inherited;
end;

procedure TEventSummary.SetAction(const Value: string);
begin
  FAction := Value;
end;

procedure TEventSummary.SetForce(const Value: Integer);
begin
  FForce := Value;
end;

procedure TEventSummary.SetTime(const Value: TDateTime);
begin
  FTime := Value;
end;

procedure TEventSummary.SetVehicleIdentifier(const Value: string);
begin
  FVehicleIdentifier := Value;
end;

end.
