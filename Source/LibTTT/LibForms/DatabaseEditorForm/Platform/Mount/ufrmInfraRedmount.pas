unit ufrmInfraRedmount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Countermeasure, uClassData, uSimContainers;

type
  TfrmInfraredmount = class(TForm)
    pnl1Title: TPanel;
    edtName: TEdit;
    pnl2ControlPage: TPanel;
    pgc1: TPageControl;
    tsGeneral: TTabSheet;
    edtQuantity: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    lblPlatform: TLabel;


    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    FSelectedVehicle : TAsset;
    FSelectedInfraredDecoy : TInfrared_Decoy_On_Board;

    function CekInput: Boolean;
    procedure UpdateInfraredDecoyData;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedInfraredDecoy : TInfrared_Decoy_On_Board read FSelectedInfraredDecoy write FSelectedInfraredDecoy;

  end;

var
  frmInfraredmount: TfrmInfraredmount;

implementation

uses
  uDataModule, ufrmInfraredDecoyOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmInfraredmount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action := cafree;
end;

procedure TfrmInfraredmount.FormShow(Sender: TObject);
begin
  UpdateInfraredDecoyData;

  with FSelectedInfraredDecoy.FData do
    btnApply.Enabled := Infrared_Decoy_Instance_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmInfraredmount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

    frmInfraredDecoyOnBoardPickList.UpdateInfraredDecoyList;
    Close;
end;

procedure TfrmInfraredmount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedInfraredDecoy do
  begin
    LastName := edtName.Text;

    FData.Instance_Identifier := edtName.Text;
    FData.Instance_Type := 1;
    FData.Infrared_Decoy_Qty_On_Board := StrToInt(edtQuantity.Text);
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Infrared_Decoy_Index := FDef.Infrared_Decoy_Index;

    if FData.Infrared_Decoy_Instance_Index = 0 then
      dmINWO.InsertInfraredDecoyOnBoard(FData)
    else
      dmINWO.UpdateInfraredDecoyOnBoard(FData);
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmInfraredmount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmInfraredmount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetInfraredDecoyOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtName.Text) then
  begin
    {Jika inputan baru}
    if FSelectedInfraredDecoy.FData.Infrared_Decoy_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate InfraredDecoy!' + Char(13) + 'Choose Infrared Decoy to continue.');
      Exit;
    end
    else if LastName <> edtName.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmInfraredmount.UpdateInfraredDecoyData;
begin
  with FSelectedInfraredDecoy do
  begin
    if FData.Infrared_Decoy_Instance_Index = 0 then
      edtName.Text := FDef.Infrared_Decoy_Identifier
    else
      edtName.Text := FData.Instance_Identifier;

    LastName := edtName.Text;
    edtQuantity.Text := IntToStr(FData.Infrared_Decoy_Qty_On_Board);
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmInfraredmount.GetNumberOfKoma(s: string): Boolean;
var
  a, i : Integer;
begin
  Result := False;
  a := 0;

  for i := 1 to length(s) do
  begin
    if s[i] = '.' then
      a := a + 1;
  end;

  if a > 0 then
    Result := True;
end;

procedure TfrmInfraredmount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
var
  value : Double;
begin
  if not (Key in[#48 .. #57, #8, #13, #46]) then
  begin
    Key := #0;
    Exit;
  end;

  if GetNumberOfKoma(TEdit(sender).Text) then
  begin
    if Key = #46 then
      Key := #0;
  end;

  if Key = #13 then
  begin
    if TEdit(Sender).Text = '' then
      TEdit(Sender).Text := '0';

    value := StrToFloat(TEdit(Sender).Text);

    case TEdit(Sender).Tag of
      0: TEdit(Sender).Text := FormatFloat('0', value);
      1: TEdit(Sender).Text := FormatFloat('0.0', value);
      2: TEdit(Sender).Text := FormatFloat('0.00', value);
      3: TEdit(Sender).Text := FormatFloat('0.000', value);
    end;

    btnApply.Enabled := True;
  end;
end;

procedure TfrmInfraredmount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmInfraredmount.ValidationFormatInput;
var
  i: Integer;
  value : Double;

begin
  for i:=0 to ComponentCount-1 do
  begin
    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Tag = 4 then
        continue;

      if TEdit(Components[i]).Text = '' then
        TEdit(Components[i]).Text := '0';

      value := StrToFloat(TEdit(Components[i]).Text);

      case TEdit(Components[i]).Tag of
        0: TEdit(Components[i]).Text := FormatFloat('0', value);
        1: TEdit(Components[i]).Text := FormatFloat('0.0', value);
        2: TEdit(Components[i]).Text := FormatFloat('0.00', value);
        3: TEdit(Components[i]).Text := FormatFloat('0.000', value);
      end;
    end;
  end;
end;

{$ENDREGION}

end.
