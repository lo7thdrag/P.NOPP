unit ufrmIFFOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,
  uDBAsset_Vehicle, uDBAsset_Sensor, uSimContainers;

type
  TfrmIFFOnBoardPickList = class(TForm)
    lbAllIFFDef: TListBox;
    lbAllIFFOnBoard: TListBox;
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

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllIFFDefClick(Sender: TObject);
    procedure lbAllIFFOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    FAllIFFDefList : TList;
    FAllIFFOnBoardList : TList;

    FSelectedVehicle : TVehicle_Definition;
//    FSelectedIFF : TIFF_Sensor_On_Board;

    procedure UpdateIFFList;

  public
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, btn Cancel di summary menyala}
    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;

  end;


var
  frmIFFOnBoardPickList: TfrmIFFOnBoardPickList;

implementation

uses
  uDataModule, ufrmIFFMount;
{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmIFFOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllIFFDefList);
//  FreeItemsAndFreeList(FAllIFFOnBoardList);
//  Action := cafree;
end;

procedure TfrmIFFOnBoardPickList.FormCreate(Sender: TObject);
//var
//  iff : TIFF_Sensor_On_Board;
begin
//  FAllIFFDefList := TList.Create;
//  FAllIFFOnBoardList := TList.Create;
//
//  iff := TIFF_Sensor_On_Board.Create;
//  iff.FData.Instance_Identifier := 'IFF';
//
//  FAllIFFDefList.Add(iff);
end;

procedure TfrmIFFOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateIFFList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmIFFOnBoardPickList.btnAddClick(Sender: TObject);
begin
//  if lbAllIFFDef.ItemIndex = -1 then
//    Exit;
//
//  frmIFFMount := TfrmIFFMount.Create(Self);
//  try
//    with frmIFFMount do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      SelectedIFF := FSelectedIFF;
//      ShowModal;
//    end;
//    AfterClose := frmIFFMount.AfterClose;
//  finally
//    frmIFFMount.Free;
//  end;
//
//  UpdateIFFList;
end;

procedure TfrmIFFOnBoardPickList.btnEditClick(Sender: TObject);
begin
//  if lbAllIFFOnBoard.ItemIndex = -1 then
//    Exit;
//
//    frmIFFMount := TfrmIFFMount.Create(Self);
//  try
//    with frmIFFMount do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      SelectedIFF := FSelectedIFF;
//      ShowModal;
//    end;
//    AfterClose := frmIFFMount.AfterClose;
//  finally
//    frmIFFMount.Free;
//  end;
//
//  UpdateIFFList;
end;

procedure TfrmIFFOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
//  if lbAllIFFOnBoard.ItemIndex = -1 then
//    Exit;
//
//  with FSelectedIFF.FData do
//  begin
//    dmTTT.DeleteIFFOnBoard(2, IFF_Instance_Index);
//  end;
//
//  UpdateIFFList;
end;

procedure TfrmIFFOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmIFFOnBoardPickList.lbAllIFFDefClick(Sender: TObject);
begin
//  if lbAllIFFDef.ItemIndex = -1 then
//    Exit;
//
//  FSelectedIFF := TIFF_Sensor_On_Board(lbAllIFFDef.Items.Objects[lbAllIFFDef.ItemIndex]);
end;

procedure TfrmIFFOnBoardPickList.lbAllIFFOnBoardClick(Sender: TObject);
begin
//  if lbAllIFFOnBoard.ItemIndex = -1 then
//    Exit;
//
//  FSelectedIFF := TIFF_Sensor_On_Board(lbAllIFFOnBoard.Items.Objects[lbAllIFFOnBoard.ItemIndex]);
end;

procedure TfrmIFFOnBoardPickList.UpdateIFFList;
//var
//  i : Integer;
//  iff : TIFF_Sensor_On_Board;
begin
//  lbAllIFFDef.Items.Clear;
//  lbAllIFFOnBoard.Items.Clear;
//
//  dmTTT.GetIFFOnBoard(FSelectedVehicle.FData.Vehicle_Index, FAllIFFOnBoardList);
//
//  for i := 0 to FAllIFFDefList.Count - 1 do
//  begin
//    iff := FAllIFFDefList.Items[i];
//    lbAllIFFDef.Items.AddObject(iff.FData.Instance_Identifier, iff);
//  end;
//
//  for i := 0 to FAllIFFOnBoardList.Count - 1 do
//  begin
//    iff := FAllIFFOnBoardList.Items[i];
//    lbAllIFFOnBoard.Items.AddObject(iff.FData.Instance_Identifier, iff);
//  end;
end;

{$ENDREGION}

end.
