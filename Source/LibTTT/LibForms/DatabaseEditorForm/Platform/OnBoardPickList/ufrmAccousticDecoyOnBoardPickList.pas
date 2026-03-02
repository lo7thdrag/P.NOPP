unit ufrmAccousticDecoyOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.Imaging.pngimage,
  uDBAsset_Vehicle, uDBAsset_Countermeasure ;

type
  TfrmAccousticDecoyOnBoardPickList = class(TForm)
    lbAllAcousticDecoyDef: TListBox;
    lbAllAcousticDecoyOnBoard: TListBox;
    btnAdd: TImage;
    btnClose: TImage;
    btnEdit: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label1: TLabel;
    Label2: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllAcousticDecoyDefClick(Sender: TObject);
    procedure lbAllAcousticDecoyOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

  private
    FAllAcousticDecoyDefList : TList;
    FAllAcousticDecoyOnBoardList : TList;

    FSelectedVehicle : TVehicle_Definition;
    FSelectedAcousticDecoy : TAcoustic_Decoy_On_Board;

    procedure UpdateAcousticDecoyList;

  public
    property SelectedVehicle : TVehicle_Definition read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmAccousticDecoyOnBoardPickList: TfrmAccousticDecoyOnBoardPickList;

implementation

{$R *.dfm}

uses
  uDataModule{, ufrmAccousticDecoyMount};

{$REGION ' Form Handle '}

procedure TfrmAccousticDecoyOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllAcousticDecoyDefList := TList.Create;
  FAllAcousticDecoyOnBoardList := TList.Create;
end;

procedure TfrmAccousticDecoyOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateAcousticDecoyList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmAccousticDecoyOnBoardPickList.btnAddClick(Sender: TObject);
begin
//  if lbAllAcousticDecoyDef.ItemIndex = -1 then
//    Exit;
//
//  with frmAccousticDecoyMount do
//  begin
//    SelectedVehicle := FSelectedVehicle;
////    SelectedAcousticDecoy := FSelectedAcousticDecoy;
//    ShowModal;
//  end;
//
//  UpdateAcousticDecoyList;
end;

procedure TfrmAccousticDecoyOnBoardPickList.btnEditClick(Sender: TObject);
begin
//  if lbAllAcousticDecoyOnBoard.ItemIndex = -1 then
//    Exit;
//
//  with frmAccousticDecoyMount do
//  begin
//    SelectedVehicle := FSelectedVehicle;
////    SelectedAcousticDecoy := FSelectedAcousticDecoy;
//    ShowModal;
//  end;
//
//  UpdateAcousticDecoyList;
end;

procedure TfrmAccousticDecoyOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
//  if lbAllAcousticDecoyOnBoard.ItemIndex = -1 then
//    Exit;
//
//  with FSelectedAcousticDecoy.FData do
//  begin
//    dmTTT.DeleteAcousticDecoyOnBoard(2, Acoustic_Instance_Index);
//  end;
//
//  UpdateAcousticDecoyList;
end;

procedure TfrmAccousticDecoyOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAccousticDecoyOnBoardPickList.lbAllAcousticDecoyDefClick(Sender: TObject);
begin
  if lbAllAcousticDecoyDef.ItemIndex = -1 then
    Exit;

  FSelectedAcousticDecoy := TAcoustic_Decoy_On_Board(lbAllAcousticDecoyDef.Items.Objects[lbAllAcousticDecoyDef.ItemIndex]);
end;

procedure TfrmAccousticDecoyOnBoardPickList.lbAllAcousticDecoyOnBoardClick(Sender: TObject);
begin
  if lbAllAcousticDecoyOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedAcousticDecoy := TAcoustic_Decoy_On_Board(lbAllAcousticDecoyOnBoard.Items.Objects[lbAllAcousticDecoyOnBoard.ItemIndex]);
end;

procedure TfrmAccousticDecoyOnBoardPickList.UpdateAcousticDecoyList;
var
  i : Integer;
  acousticdecoy : TAcoustic_Decoy_On_Board;
begin
//  lbAllAcousticDecoyDef.Items.Clear;
//  lbAllAcousticDecoyOnBoard.Items.Clear;
//
//  dmTTT.GetAllAcousticDecoyDef(FAllAcousticDecoyDefList);
//  dmTTT.GetAcousticDecoyOnBoard(FSelectedVehicle.FData.Vehicle_Index,FAllAcousticDecoyOnBoardList);
//
//  for i := 0 to FAllAcousticDecoyDefList.Count - 1 do
//  begin
//    acousticdecoy := FAllAcousticDecoyDefList.Items[i];
//    lbAllAcousticDecoyDef.Items.AddObject(acousticdecoy.FAccousticDecoy_Def.Decoy_Identifier, acousticdecoy);
//  end;
//
//  for i := 0 to FAllAcousticDecoyOnBoardList.Count - 1 do
//  begin
//    acousticdecoy := FAllAcousticDecoyOnBoardList.Items[i];
//    lbAllAcousticDecoyOnBoard.Items.AddObject(acousticdecoy.FData.Instance_Identifier, acousticdecoy);
//  end;
end;

{$ENDREGION}

end.
