unit ufrmChaffMount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Countermeasure, uClassData, uSimContainers;

type
  TfrmChaffMount = class(TForm)
    pnl1Title: TPanel;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    General: TTabSheet;
    edtQuantity: TEdit;
    lb1: TLabel;
    cbbName: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    ImgBackgroundForm: TImage;
    edtClassName: TLabel;
    lblPlatform: TLabel;
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    procedure cbbNameChange(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);


  private
    FSelectedVehicle : TAsset;
    FSelectedChaff : TChaff_On_Board;

    function CekInput: Boolean;
    procedure UpdateChaffData;

  public
    LastName : string;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
    property SelectedChaff : TChaff_On_Board read FSelectedChaff write FSelectedChaff;
  end;

var
  frmChaffMount: TfrmChaffMount;

implementation

uses
  uDataModule, ufrmChaffOnBoardPickList ;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmChaffMount.FormShow(Sender: TObject);
begin
  UpdateChaffData;

  with FSelectedChaff.FData do
    btnApply.Enabled := Chaff_Instance_Index = 0;

  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmChaffMount.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmChaffOnBoardPickList.UpdateChaffList;
  Close;
end;

procedure TfrmChaffMount.btnApplyClick(Sender: TObject);
begin
  if not CekInput then
  begin
    Exit;
  end;

  ValidationFormatInput;

  with FSelectedChaff do
  begin
    LastName := edtClassName.Caption;
    FData.Instance_Identifier := edtClassName.Caption;
    FData.Instance_Type := cbbName.ItemIndex;
    FData.Chaff_Qty_On_Board := StrToInt(edtQuantity.Text);
    FData.Vehicle_Index := FSelectedVehicle.FData.VehicleIndex;
    FData.Chaff_Index := FDef.Chaff_Index;

    if FData.Chaff_Instance_Index = 0 then
      dmINWO.InsertChaffOnBoard(FData)
    else
      dmINWO.UpdateChaffOnBoard(FData);
  end;

  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

function TfrmChaffMount.CekInput: Boolean;
begin
  Result := False;

  {Jika Mount Name sudah ada}
  if dmINWO.GetChaffOnBoardCount(FSelectedVehicle.FData.VehicleIndex, edtClassName.Caption) then
  begin
    {Jika inputan baru}
    if FSelectedChaff.FData.Chaff_Instance_Index = 0 then
    begin
      ShowMessage('Duplicate Chaff!' + Char(13) + 'Choose different Chaff to continue.');
      Exit;
    end
    else if LastName <> edtClassName.Caption then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmChaffMount.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChaffMount.cbbNameChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  edtClassName.Caption := FSelectedChaff.FDef.Chaff_Identifier + ' ' + cbbName.Text;

  btnApply.Enabled := True;
end;

procedure TfrmChaffMount.UpdateChaffData;
begin
  with FSelectedChaff do
  begin
    cbbName.ItemIndex := FData.Instance_Type;

    if FData.Chaff_Instance_Index = 0 then
      edtClassName.Caption := FDef.Chaff_Identifier + ' ' + cbbName.Text
    else
      edtClassName.Caption := FData.Instance_Identifier;

    LastName := edtClassName.Caption;

    edtQuantity.Text := FormatFloat('0', FData.Chaff_Qty_On_Board);
  end;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmChaffMount.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmChaffMount.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

    if (StrToFloat(TEdit(Sender).Text) > 465000)  then
    begin
      ShowMessage('Incorrect value');
      edtQuantity.Text := '465000';
    end;

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

procedure TfrmChaffMount.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmChaffMount.ValidationFormatInput;
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

      if (StrToFloat(TEdit(Components[i]).Text) > 465000) then
        TEdit(Components[i]).Text := '465000';

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
