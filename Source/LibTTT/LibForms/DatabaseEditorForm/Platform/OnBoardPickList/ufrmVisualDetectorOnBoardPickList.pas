unit ufrmVisualDetectorOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,
  uDBAsset_Vehicle, uDBAsset_Sensor, uSimContainers;

type
  TfrmVisualDetectorOnBoardPickList = class(TForm)
    lbAllVisualDetectorDef: TListBox;
    lbAllVisualDetectorOnBoard: TListBox;
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

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllVisualDetectorDefClick(Sender: TObject);
    procedure lbAllVisualDetectorOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

  private
    FAllVisualDefList : TList;
    FAllVisualOnBoardList : TList;

    FSelectedVehicle : TVehicle_Definition;
//    FSelectedVisual : TVisual_Sensor_On_Board;

    procedure UpdateVisualList;

  public
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, btn Cancel di summary menyala}
    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmVisualDetectorOnBoardPickList: TfrmVisualDetectorOnBoardPickList;

implementation

uses
  uDataModule, ufrmVisualDetectorMount{, tttData};

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmVisualDetectorOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllVisualOnBoardList);
//  FreeItemsAndFreeList(FAllVisualDefList);
//  Action := cafree;
end;

procedure TfrmVisualDetectorOnBoardPickList.FormCreate(Sender: TObject);
//var
//  visual : TVisual_Sensor_On_Board;
begin
//  FAllVisualOnBoardList := TList.Create;
//  FAllVisualDefList := TList.Create;
//
//  visual := TVisual_Sensor_On_Board.Create;
//  visual.FData.Instance_Identifier := 'Visual';
//
//  FAllVisualDefList.Add(visual);
end;

procedure TfrmVisualDetectorOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateVisualList;
end;


{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmVisualDetectorOnBoardPickList.btnAddClick(Sender: TObject);
begin
//  if lbAllVisualDetectorDef.ItemIndex = -1 then
//    Exit;
//
//  frmVisualDetectorMount := TfrmVisualDetectorMount.Create(Self);
//  try
//    with frmVisualDetectorMount do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      SelectedVisual := FSelectedVisual;
//      ShowModal;
//    end;
//    AfterClose := frmVisualDetectorMount.AfterClose;
//  finally
//    frmVisualDetectorMount.Free;
//  end;
//
//  UpdateVisualList;
end;

 procedure TfrmVisualDetectorOnBoardPickList.btnEditClick(Sender: TObject);
begin
//  if lbAllVisualDetectorOnBoard.ItemIndex = -1 then
//    Exit;
//
//  frmVisualDetectorMount := TfrmVisualDetectorMount.Create(Self);
//  try
//    with frmVisualDetectorMount do
//    begin
//      SelectedVehicle := FSelectedVehicle;
//      SelectedVisual := FSelectedVisual;
//      ShowModal;
//    end;
//    AfterClose := frmVisualDetectorMount.AfterClose;
//  finally
//    frmVisualDetectorMount.Free;
//  end;
//
//  UpdateVisualList;
end;

 procedure TfrmVisualDetectorOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
//  if lbAllVisualDetectorOnBoard.ItemIndex = -1 then
//    Exit;
//
//  with FSelectedVisual.FData do
//  begin
//    dmTTT.DeleteBlindZone(Ord(bzcVisual), Visual_Instance_Index);
//    dmTTT.DeleteVisualOnBoard(2, Visual_Instance_Index);
//  end;
//
//  UpdateVisualList;
end;

procedure TfrmVisualDetectorOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmVisualDetectorOnBoardPickList.lbAllVisualDetectorDefClick(Sender: TObject);
begin
// if lbAllVisualDetectorDef.ItemIndex = -1 then
//    Exit;
//
//  FSelectedVisual := TVisual_Sensor_On_Board(lbAllVisualDetectorDef.Items.Objects[lbAllVisualDetectorDef.ItemIndex]);
end;

procedure TfrmVisualDetectorOnBoardPickList.lbAllVisualDetectorOnBoardClick(Sender: TObject);
begin
// if lbAllVisualDetectorOnBoard.ItemIndex = -1 then
//    Exit;
//
//  FSelectedVisual := TVisual_Sensor_On_Board(lbAllVisualDetectorOnBoard.Items.Objects[lbAllVisualDetectorOnBoard.ItemIndex]);
end;

procedure TfrmVisualDetectorOnBoardPickList.UpdateVisualList;
//var
//  i : Integer;
//  visual : TVisual_Sensor_On_Board;
begin
//  lbAllVisualDetectorDef.Items.Clear;
//  lbAllVisualDetectorOnBoard.Items.Clear;
//
//  dmTTT.GetVisualOnBoard(FSelectedVehicle.FData.Vehicle_Index,FAllVisualOnBoardList);
//
//  for i := 0 to FAllVisualDefList.Count - 1 do
//  begin
//    visual := FAllVisualDefList.Items[i];
//    lbAllVisualDetectorDef.Items.AddObject(visual.FData.Instance_Identifier, visual);
//  end;
//
//  for i := 0 to FAllVisualOnBoardList.Count - 1 do
//  begin
//    visual := FAllVisualOnBoardList.Items[i];
//    lbAllVisualDetectorOnBoard.Items.AddObject(visual.FData.Instance_Identifier, visual);
//  end;
end;

{$ENDREGION}

end.
