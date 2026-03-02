unit ufrmRadarNoiseJammerOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,

  uClassData, uDBAsset_Countermeasure, uSimContainers ;

type
  TfrmRadarNoiseJammerOnBoardPickList = class(TForm)
    lbAllRadarJammerDef: TListBox;
    lbAllRadarJammerOnBoard: TListBox;
    btnAdd: TImage;
    btnEdit: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lblClose: TLabel;
    btnDelete: TImage;
    btnUpdate: TImage;
    btnNew: TImage;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllRadarJammerDefClick(Sender: TObject);
    procedure lbAllRadarJammerOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);


  private
    FAllRadarJammerDefList : TList;
    FAllRadarJammerOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedRadarJammer : TRadar_Noise_Jammer_On_Board;



  public
    procedure UpdateRadarJammerList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;

  end;

var
  frmRadarNoiseJammerOnBoardPickList: TfrmRadarNoiseJammerOnBoardPickList;

implementation

{$R *.dfm}

uses
  uDataModule,ufrmRadarJammerMount, ufrmAsset, ufrmSummaryRadarNoiseJammer;

{$REGION ' Form Handle '}

procedure TfrmRadarNoiseJammerOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllRadarJammerDefList);
//  FreeItemsAndFreeList(FAllRadarJammerOnBoardList);
//  Action := cafree;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllRadarJammerDefList := TList.Create;
  FAllRadarJammerOnBoardList := TList.Create;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateRadarJammerList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmRadarNoiseJammerOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllRadarJammerDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmRadarJammerMount) then
    frmRadarJammerMount := TfrmRadarJammerMount.Create(Self);
  try
    with frmRadarJammerMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedRadarJammer := FSelectedRadarJammer;
      Show;
    end;
  finally
  end;

//  UpdateRadarJammerList;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllRadarJammerOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmRadarJammerMount) then
    frmRadarJammerMount := TfrmRadarJammerMount.Create(Self);
  try
    with frmRadarJammerMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedRadarJammer := FSelectedRadarJammer;
      Show;
    end;
  finally
  end;

//  UpdateRadarJammerList;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.btnNewClick(Sender: TObject);
begin
  if not Assigned(frmSummaryRadarNoiseJammer) then
    frmSummaryRadarNoiseJammer := TfrmSummaryRadarNoiseJammer.Create(Self);

  try
    with frmSummaryRadarNoiseJammer do
    begin
      SelectedRadarJammer := TRadar_Noise_Jammer_On_Board.Create;
      Show;
    end;
  finally
  end;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllRadarJammerOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedRadarJammer.FData do
  begin
    dmINWO.DeleteRadarNoiseJammerOnBoard(2, Jammer_Instance_Index);
  end;

//  UpdateRadarJammerList;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.btnUpdateClick(Sender: TObject);
begin
  if lbAllRadarJammerDef.ItemIndex = -1 then
  begin
    ShowMessage('Select RadarNoiseJammer Data ... !');
    Exit;
  end;

  if not Assigned(frmSummaryRadarNoiseJammer) then
    frmSummaryRadarNoiseJammer := TfrmSummaryRadarNoiseJammer.Create(Self);

  try
    with frmSummaryRadarNoiseJammer do
    begin
      SelectedRadarJammer := FSelectedRadarJammer;
      Show;
    end;
  finally
  end;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateCountermeasureData;
  Close;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.btnDeleteClick(Sender: TObject);
var
  warning : Integer;
  tempList: TList;
begin
  if lbAllRadarJammerDef.ItemIndex = -1 then
  begin
    ShowMessage('Select RadarNoiseJammer Data ... !');
    Exit;
  end;

  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation, mbOKCancel, 0);

  if warning = mrOK then
  begin
    with FSelectedRadarJammer.FDef do
    begin

      {Pengecekan Relasi Dengan Tabel On Board}
      if dmINWO.GetCountermeasure_On_Board_By_Index(8, Jammer_Index) then
      begin
        ShowMessage('Cannot delete, because is already in used by some vehicles');
        Exit;
      end;

      if dmINWO.DeleteRadarNoiseJammerDef(Jammer_Index) then
        ShowMessage('Data has been deleted');

    end;

    UpdateRadarJammerList;
  end;
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.lbAllRadarJammerDefClick(Sender: TObject);
begin
  if lbAllRadarJammerDef.ItemIndex = -1 then
    Exit;

  FSelectedRadarJammer := TRadar_Noise_Jammer_On_Board(lbAllRadarJammerDef.Items.Objects[lbAllRadarJammerDef.ItemIndex]);
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.lbAllRadarJammerOnBoardClick(Sender: TObject);
begin
  if lbAllRadarJammerOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedRadarJammer := TRadar_Noise_Jammer_On_Board(lbAllRadarJammerOnBoard.Items.Objects[lbAllRadarJammerOnBoard.ItemIndex]);
end;

procedure TfrmRadarNoiseJammerOnBoardPickList.UpdateRadarJammerList;
var
  i : Integer;
  radarjammer : TRadar_Noise_Jammer_On_Board;
begin
  lbAllRadarJammerDef.Items.Clear;
  lbAllRadarJammerOnBoard.Items.Clear;

  dmINWO.GetAllRadarNoiseJammerDef(FAllRadarJammerDefList);
  dmINWO.GetRadarNoiseJammerOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllRadarJammerOnBoardList);

  for i := 0 to FAllRadarJammerDefList.Count - 1 do
  begin
    radarjammer := FAllRadarJammerDefList.Items[i];
    lbAllRadarJammerDef.Items.AddObject(radarjammer.FDef.Jammer_Identifier, radarjammer);
  end;

  for i := 0 to FAllRadarJammerOnBoardList.Count - 1 do
  begin
    radarjammer := FAllRadarJammerOnBoardList.Items[i];
    lbAllRadarJammerOnBoard.Items.AddObject(radarjammer.FData.Instance_Identifier, radarjammer);
  end;
end;

{$ENDREGION}

end.
