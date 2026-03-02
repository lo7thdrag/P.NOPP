unit ufrmSelfDefensiveJammerOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uClassData, uDBAsset_Countermeasure, uSimContainers ;

type
  TfrmSelfDefensiveJammerOnBoardPickList = class(TForm)
    lbAllDefensiveJammerDef: TListBox;
    lbAllDefensiveJammerOnBoard: TListBox;
    btnAdd: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ImgBackgroundForm: TImage;
    lblClose: TLabel;
    btnNew: TImage;
    btnUpdate: TImage;
    btnDelete: TImage;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllDefensiveJammerDefClick(Sender: TObject);
    procedure lbAllDefensiveJammerOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);

  private
    FAllDefensiveJammerDefList : TList;
    FAllDefensiveJammerOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedDefensiveJammer : TDefensive_Jammer_On_Board;

    function CekInput: Boolean;

  public
    procedure UpdateDefensiveJammerList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;

  end;

var
  frmSelfDefensiveJammerOnBoardPickList: TfrmSelfDefensiveJammerOnBoardPickList;

implementation

uses
  uDataModule, ufrmAsset, ufrmSummarySelfDefensiveJammer;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmSelfDefensiveJammerOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllDefensiveJammerDefList := TList.Create;
  FAllDefensiveJammerOnBoardList := TList.Create;
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateDefensiveJammerList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSelfDefensiveJammerOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllDefensiveJammerDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmSelfDefensiveJammerOnBoardPickList) then
    frmSelfDefensiveJammerOnBoardPickList := TfrmSelfDefensiveJammerOnBoardPickList.Create(Self);

  with FSelectedDefensiveJammer do
  begin
    FData.Instance_Identifier := FDef
    .Defensive_Jammer_Identifier;
    FData.Instance_Type := 0;
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Defensive_Jammer_Index := FDef.Defensive_Jammer_Index;

    if FData.Defensive_Jammer_Instance_Index = 0 then
      dmINWO.InsertSelfDefensiveJammerOnBoard(FData)
    else
      dmINWO.UpdateSelfDefensiveJammerOnBoard(FData);
  end;

  UpdateDefensiveJammerList;
end;


function TfrmSelfDefensiveJammerOnBoardPickList.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetSelfDefensiveJammerOnBoardCount(FSelectedVehicle.FData.VehicleIndex, FSelectedDefensiveJammer.FDef.Defensive_Jammer_Identifier) then
  begin
    {Jika inputan baru}
    if FSelectedDefensiveJammer.FData.Defensive_Jammer_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate Defensive Jammer!' + Char(13) + 'Choose another Defensive Jammer to continue.');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllDefensiveJammerOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedDefensiveJammer.FData do
  begin
    dmINWO.DeleteSelfDefensiveJammerOnBoard(2, Defensive_Jammer_Instance_Index);
  end;

//  UpdateDefensiveJammerList;
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.btnUpdateClick(
  Sender: TObject);
begin
  if lbAllDefensiveJammerDef.ItemIndex = -1 then
  begin
    ShowMessage('Select SelfDefensiveJammer Data ... !');
    Exit;
  end;

  if not Assigned(frmSummarySelfDefensiveJammer) then
    frmSummarySelfDefensiveJammer := TfrmSummarySelfDefensiveJammer.Create(Self);

  try
    with frmSummarySelfDefensiveJammer do
    begin
      SelectedDefensiveJammer := FSelectedDefensiveJammer;
      Show;
    end;
  finally
  end;
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateCountermeasureData;
  Close;
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.btnDeleteClick(
  Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllDefensiveJammerDef.ItemIndex = -1 then
  begin
    ShowMessage('Select SelfDefensiveJammer Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedDefensiveJammer.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetCountermeasure_On_Board_By_Index(6, Defensive_Jammer_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteSelfDefensiveJammerDef(Defensive_Jammer_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateDefensiveJammerList;
  end;
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummarySelfDefensiveJammer) then
    frmSummarySelfDefensiveJammer := TfrmSummarySelfDefensiveJammer.Create(Self);

  try
    with frmSummarySelfDefensiveJammer do
    begin
      SelectedDefensiveJammer := TDefensive_Jammer_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.lbAllDefensiveJammerDefClick(Sender: TObject);
begin
  if lbAllDefensiveJammerDef.ItemIndex = -1 then
    Exit;

  FSelectedDefensiveJammer := TDefensive_Jammer_On_Board(lbAllDefensiveJammerDef.Items.Objects[lbAllDefensiveJammerDef.ItemIndex]);
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.lbAllDefensiveJammerOnBoardClick(Sender: TObject);
begin
  if lbAllDefensiveJammerOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedDefensiveJammer := TDefensive_Jammer_On_Board(lbAllDefensiveJammerOnBoard.Items.Objects[lbAllDefensiveJammerOnBoard.ItemIndex]);
end;

procedure TfrmSelfDefensiveJammerOnBoardPickList.UpdateDefensiveJammerList;
var
  i : Integer;
  definsivejammer : TDefensive_Jammer_On_Board;
begin
  lbAllDefensiveJammerDef.Items.Clear;
  lbAllDefensiveJammerOnBoard.Items.Clear;

  dmINWO.GetAllSelfDefensiveJammerDef(FAllDefensiveJammerDefList);
  dmINWO.GetSelfDefensiveJammerOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllDefensiveJammerOnBoardList);

  for i := 0 to FAllDefensiveJammerDefList.Count - 1 do
  begin
    definsivejammer := FAllDefensiveJammerDefList.Items[i];
    lbAllDefensiveJammerDef.Items.AddObject(definsivejammer.FDef.Defensive_Jammer_Identifier, definsivejammer);
  end;

  for i := 0 to FAllDefensiveJammerOnBoardList.Count - 1 do
  begin
    definsivejammer := FAllDefensiveJammerOnBoardList.Items[i];
    lbAllDefensiveJammerOnBoard.Items.AddObject(definsivejammer.FData.Instance_Identifier, definsivejammer);
  end;
end;

{$ENDREGION}

end.
