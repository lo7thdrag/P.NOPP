unit ufrmEmbarkedInputName;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage,

  uClassData, ufrmEmbarkedOnBoardPickList;

type
  TfrmEmbarkedInputName = class(TForm)
    ImgBackgroundForm: TImage;
    btnOK: TButton;
    btnCancel: TButton;
    pnl1: TPanel;
    lblName: TLabel;
    edtClass: TEdit;
    edtQuantity: TEdit;
    Label1: TLabel;

    procedure FormShow(Sender: TObject);

    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

  private
    FSelectedEmbarkedPlat : THosted_Platform;

  public
    property SelectedEmbarkedPlat : THosted_Platform read FSelectedEmbarkedPlat write FSelectedEmbarkedPlat;

  end;

var
  frmEmbarkedInputName: TfrmEmbarkedInputName;

implementation

uses
  uDataModule;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmEmbarkedInputName.FormShow(Sender: TObject);
begin
  with FSelectedEmbarkedPlat do
  begin
    edtClass.Text := FVehicle.VehicleIdentifier;
    edtQuantity.Text := IntToStr(FData.Quantity);
  end;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmEmbarkedInputName.btnOkClick(Sender: TObject);
begin
  with FSelectedEmbarkedPlat do
  begin
    FData.Vehicle_Index := FVehicle.VehicleIndex;
    FData.Quantity := StrToInt(edtQuantity.Text);

    if FData.Slave_Index = 0 then
      dmINWO.InsertHostedPlatform(FData)
    else
      dmINWO.UpdateHostedPlatform(FData);
  end;

  frmEmbarkedOnBoardPickList.UpdateVehicleList;
  Close;
end;

procedure TfrmEmbarkedInputName.btnCancelClick(Sender: TObject);
begin
  frmEmbarkedOnBoardPickList.UpdateVehicleList;
  Close;
end;

{$ENDREGION}

end.
