unit ufrmSummaryAirBubble;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, {uDBAsset_Vehicle,} Vcl.Imaging.pngimage,
  uDBAsset_Countermeasure;

type
  TfrmSummaryAirBubble = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    lblMaxAcousticCross: TLabel;
    lbl1: TLabel;
    lblDissipationTime: TLabel;
    lbl2: TLabel;
    lblAscentRate: TLabel;
    lbl3: TLabel;
    lblDescentRate: TLabel;
    lbl4: TLabel;
    edtMaxAcousticCross: TEdit;
    edtDissipationTime: TEdit;
    edtAscentRate: TEdit;
    edtDescentRate: TEdit;
    tsNotes: TTabSheet;
    mmoNotes: TMemo;
    imgBackgroundForm: TImage;
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


  private
    FSelectedAirBubble : TAir_Bubble_On_Board;

    function CekInput: Boolean;
    procedure UpdateAirBubbleData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedAirBubble : TAir_Bubble_On_Board read FSelectedAirBubble write FSelectedAirBubble;
  end;

var
  frmSummaryAirBubble: TfrmSummaryAirBubble;

implementation

uses
  uDataModule, ufrmAirBubbleOnBoardPickList;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmSummaryAirBubble.FormShow(Sender: TObject);
begin
  tsGeneral.Show;
  UpdateAirBubbleData;

  with FSelectedAirBubble.FDef do
    btnApply.Enabled := Air_Bubble_Index = 0;

  isOK := True;
  AfterClose := True;
  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryAirBubble.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmAirBubbleOnBoardPickList.UpdateAirBubbleList;
  Close;
end;

procedure TfrmSummaryAirBubble.btnApplyClick(Sender: TObject);
begin
  with FSelectedAirBubble do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Air_Bubble_Identifier := edtClass.Text;
    FDef.Max_Acoustic_Cross := StrToFloat(edtMaxAcousticCross.Text);
    FDef.Dissipation_Time := StrToFloat(edtDissipationTime.Text);
    FDef.Ascent_Rate := StrToFloat(edtAscentRate.Text);
    FDef.Descent_Rate := StrToFloat(edtDescentRate.Text);

    {Catatan : Field ini tidak ada inputannya}
    FDef.Platform_Domain := 0;
    FDef.Platform_Category := 0;
    FDef.Platform_Type := 0;
    {$ENDREGION}
    if FDef.Air_Bubble_Index = 0 then
    begin
      if dmINWO.InsertAirBubbleDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateAirBubbleDef(FDef) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;
  end;

  isOK := True;
  AfterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSummaryAirBubble.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummaryAirBubble.UpdateAirBubbleData;
begin
  with FSelectedAirBubble do
  begin
    if FDef.Air_Bubble_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Air_Bubble_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;
    edtMaxAcousticCross.Text := FormatFloat('0.00', FDef.Max_Acoustic_Cross);
    edtDissipationTime.Text := FormatFloat('0', FDef.Dissipation_Time);
    edtAscentRate.Text := FormatFloat('0.00', FDef.Ascent_Rate);
    edtDescentRate.Text := FormatFloat('0.00', FDef.Descent_Rate);
    {$ENDREGION}
  end;
end;

function TfrmSummaryAirBubble.CekInput: Boolean;
var
  i, chkSpace, numSpace: Integer;
begin
  Result := False;

  {Jika inputan class name kosong}
  if (edtClass.Text = '')then
  begin
    ShowMessage('Please insert class name');
    Exit;
  end;

  {Jika berisi spasi semua}
  if Copy(edtClass.Text, 1, 1) = ' ' then
  begin
    chkSpace := Length(edtClass.Text);
    numSpace := 0;

    for i := 1 to chkSpace do
    begin
      if edtClass.Text[i] = #32 then
      numSpace := numSpace + 1;
    end;

    if chkSpace = numSpace then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  {Jika Class Name sudah ada}
  if (dmINWO.GetAirBubbleDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedAirBubble.FDef.Air_Bubble_Index = 0 then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end
    else if LastName <> edtClass.Text then
    begin
      ShowMessage('Please use another class name');
      Exit;
    end;
  end;

  Result := True;
end;

{$ENDREGION}

{$REGION ' Filter Input '}

function TfrmSummaryAirBubble.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummaryAirBubble.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryAirBubble.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryAirBubble.ValidationFormatInput;
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
