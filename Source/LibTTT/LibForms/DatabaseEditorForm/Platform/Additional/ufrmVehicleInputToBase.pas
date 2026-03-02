unit ufrmVehicleInputToBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage
  {uDBAssetObject, uDBAsset_Base};

type
  TfrmVehicleInputToBase = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
//    FSelectedVehicle : TVehicle_On_Base;

  public
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, btn Cancel di summary menyala}
//    property SelectedVehicle : TVehicle_On_Base read FSelectedVehicle write FSelectedVehicle;

  end;

var
  frmVehicleInputToBase: TfrmVehicleInputToBase;

implementation

uses
  uDataModule;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmVehicleInputToBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmVehicleInputToBase.FormShow(Sender: TObject);
begin
//  with FSelectedVehicle do
//  begin
//    edtClass.Text := FData.Vehicle_Identifier;
//    edtQuantity.Text := IntToStr(FData.Quantity);
//  end;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmVehicleInputToBase.btnOkClick(Sender: TObject);
begin
//  with FSelectedVehicle do
//  begin
//    FData.Vehicle_Index := FData.Vehicle_Index;
//    FData.Quantity := StrToInt(edtQuantity.Text);
//
//    if FData.Vehicle_OnBase_Index = 0 then
//      dmTTT.InsertVehicle_OnBase(FData)
//    else
//      dmTTT.UpdateVehicle_OnBase(FData);
//  end;
//  AfterClose := True;
//  Close;
end;

procedure TfrmVehicleInputToBase.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

{$ENDREGION}

end.
