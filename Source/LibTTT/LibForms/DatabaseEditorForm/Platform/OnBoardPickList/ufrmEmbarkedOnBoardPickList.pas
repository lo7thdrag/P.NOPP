unit ufrmEmbarkedOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uSimContainers, uClassData;

type
  TfrmEmbarkedOnBoardPickList = class(TForm)
    lbAllVehicleOnBoard: TListBox;
    lbAllVehicleDef: TListBox;
    btnAdd: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lblClose: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllVehicleDefClick(Sender: TObject);
    procedure lbAlVehicleOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);


  private
    FAllVehicleDefList : TList;
    FAllVehicleOnBoardList : TList;

    FSelectedVehicle : TAsset; {Base Vehicle}
    FVehicleOnDef : TAsset;    {Vehicle in List Def}
    FSelectedEmbarked : THosted_Platform;   {Embarked Vehicle}

  public
    procedure UpdateVehicleList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;

  end;

var
  frmEmbarkedOnBoardPickList: TfrmEmbarkedOnBoardPickList;

implementation

uses
  uDataModule, ufrmEmbarkedInputName, ufrmAsset;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmEmbarkedOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllVehicleDefList);
//  FreeItemsAndFreeList(FAllVehicleOnBoardList);
//  Action := cafree;
end;

procedure TfrmEmbarkedOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllVehicleDefList := TList.Create;
  FAllVehicleOnBoardList := TList.Create;

//  AfterClose := False;
end;

procedure TfrmEmbarkedOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateVehicleList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmEmbarkedOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllVehicleDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmEmbarkedInputName) then
    frmEmbarkedInputName := TfrmEmbarkedInputName.Create(Self);

  try
    with frmEmbarkedInputName do
    begin
      SelectedEmbarkedPlat := THosted_Platform.Create;

      with SelectedEmbarkedPlat do
      begin
        FData.Hosted_Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
        FVehicle := FVehicleOnDef.FData;
        Show;
      end;
    end;
  finally
  end;
end;

procedure TfrmEmbarkedOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllVehicleOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedEmbarked.FData do
    dmINWO.DeleteHostedPlatform(2, Slave_Index);

  UpdateVehicleList;
end;

procedure TfrmEmbarkedOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateOnBoardData;
  Close;
end;

procedure TfrmEmbarkedOnBoardPickList.lbAllVehicleDefClick(Sender: TObject);
begin
  if lbAllVehicleDef.ItemIndex = -1 then
    Exit;

  FVehicleOnDef := TAsset(lbAllVehicleDef.Items.Objects[lbAllVehicleDef.ItemIndex]);
end;

procedure TfrmEmbarkedOnBoardPickList.lbAlVehicleOnBoardClick(Sender: TObject);
begin
  if lbAllVehicleOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedEmbarked := THosted_Platform(lbAllVehicleOnBoard.Items.Objects[lbAllVehicleOnBoard.ItemIndex]);
end;

procedure TfrmEmbarkedOnBoardPickList.UpdateVehicleList;
var
  i, j : Integer;
  vehicle : TAsset;
  embarkedPlat : THosted_Platform;
  found : Boolean;
begin
  lbAllVehicleDef.Items.Clear;
  lbAllVehicleOnBoard.Items.Clear;

  dmINWO.GetAllVehicleDefCarriableUnit(FAllVehicleDefList);
  dmINWO.GetAllVehicleAtHostPlatform(FSelectedVehicle.FData.VehicleIndex,FAllVehicleOnBoardList);

  for i := 0 to FAllVehicleDefList.Count - 1 do
  begin
    vehicle := FAllVehicleDefList.Items[i];

    if vehicle.FData.VehicleIndex = FSelectedVehicle.FData.VehicleIndex then
      Continue;

    found := False;
    for j := 0 to FAllVehicleOnBoardList.Count - 1 do
    begin
      embarkedPlat := FAllVehicleOnBoardList.Items[j];

      if embarkedPlat.FData.Vehicle_Index = vehicle.FData.VehicleIndex then
      begin
        found := True;
        Break;
      end;
    end;

    if found then
      lbAllVehicleOnBoard.Items.AddObject(embarkedPlat.FVehicle.VehicleIdentifier,embarkedPlat)
    else
      lbAllVehicleDef.Items.AddObject(vehicle.FData.VehicleIdentifier, vehicle);
  end;
end;

{$ENDREGION}

end.
