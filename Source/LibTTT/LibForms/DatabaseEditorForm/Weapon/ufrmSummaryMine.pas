unit ufrmSummaryMine;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Vcl.Imaging.pngimage,
  {Project Uses}
  uDBAsset_Weapon{, tttData};

type
  TfrmSummaryMine = class(TForm)
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    pnl1Title: TPanel;
    txtClass: TLabel;
    edtClass: TEdit;
    pnl2ControlPage: TPanel;
    imgBackgroundForm: TImage;
    lblPlatform: TLabel;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    lblCategory: TLabel;
    lblMooringType: TLabel;
    lblDetectabilityType: TLabel;
    lbl1: TLabel;
    lblMaxLayingDepth: TLabel;
    cbbCategory: TComboBox;
    cbbMooringType: TComboBox;
    cbbDetectabilityType: TComboBox;
    edtMaxLayingDepth: TEdit;
    grbProbOfDetonationCurve: TGroupBox;
    btnEditProbOfDetonanationCurve: TButton;
    grpDimensions: TGroupBox;
    lblLength: TLabel;
    lbl2: TLabel;
    lblWidth: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblEngagementRange: TLabel;
    lbl5: TLabel;
    lblHeight: TLabel;
    edtLength: TEdit;
    edtWidth: TEdit;
    edtHeight: TEdit;
    edtEngagementRange: TEdit;
    grpCapabilities: TGroupBox;
    chkAntiSubSurface: TCheckBox;
    chkAntiSurface: TCheckBox;
    grpAcousticCrossSection: TGroupBox;
    lblAcousticFront: TLabel;
    lblAcousticSide: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtAcousticFront: TEdit;
    edtAcousticSide: TEdit;
    grpLethality: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    trckbrLethality: TTrackBar;
    edtLethality: TEdit;
    procedure FormShow(Sender: TObject);

    //Global
    function GetNumberOfKoma(s : string): Boolean;
    procedure edtNumeralKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxDataChange(Sender: TObject);
    procedure CheckBoxDataClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure ValidationFormatInput();

    //General
    procedure trckbrGeneralChange(Sender: TObject);
    procedure edtGeneralChange(Sender: TObject);
    procedure btnEditProbOfDetonanationCurveClick(Sender: TObject);

    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);

  private
    FSelectedMine : TMine_On_Board;

    function CekInput:Boolean;
    procedure UpdateMineData;

  public
    isOK  : Boolean; {Penanda jika gagal cek input, btn OK tidak langsung close}
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, list tdk perlu di update }
    LastName : string;

    property SelectedMine : TMine_On_Board read FSelectedMine write FSelectedMine;
  end;

var
  frmSummaryMine: TfrmSummaryMine;

implementation

uses
   uDataModule, ufrmMineOnBoardPickList{, uProbabilityGraph, ufrmMinePODGraphic};

 {$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmSummaryMine.FormShow(Sender: TObject);
begin
//  tsGeneral.Show;
//  UpdateMineData;
//
//  with FSelectedMine.FMine_Def do
//    btnApply.Enabled := Mine_Index = 0;
//
//  isOK := True;
//  AfterClose := True;
//  btnCancel.Enabled := True;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmSummaryMine.btnOKClick(Sender: TObject);
begin
  if btnApply.Enabled then
    btnApply.Click;

  frmMineOnBoardPickList.UpdateMineList;
  Close;
end;

procedure TfrmSummaryMine.btnApplyClick(Sender: TObject);
begin

  with FSelectedMine do
  begin
    if not CekInput then
    begin
      isOK := False;
      Exit;
    end;

    ValidationFormatInput;

    {$REGION ' General '}
    LastName := edtClass.Text;
    FDef.Mine_Identifier := edtClass.Text;

    FDef.Anti_Sur_Capable := Ord(chkAntiSurface.Checked);
    FDef.Anti_SubSur_Capable := Ord(chkAntiSubSurface.Checked);

    FDef.Platform_Category := cbbCategory.ItemIndex;
    FDef.Mooring_Type := cbbMooringType.ItemIndex;
    FDef.Detectability_Type := cbbDetectabilityType.ItemIndex;
    FDef.Max_Laying_Depth := StrToFloat(edtMaxLayingDepth.Text);

    FDef.Length := StrToFloat(edtLength.Text);
    FDef.Width := StrToFloat(edtWidth.Text);
    FDef.Height := StrToFloat(edtHeight.Text);
    FDef.Engagement_Range := StrToFloat(edtEngagementRange.Text);

    FDef.Front_Acoustic_Cross := StrToFloat(edtAcousticFront.Text);
    FDef.Side_Acoustic_Cross := StrToFloat(edtAcousticSide.Text);

    FDef.Mine_Lethality := trckbrLethality.Position;
    {$ENDREGION}
    if FDef.Mine_Index = 0 then
    begin
      if dmINWO.InsertMineDef(FDef) then
      begin
        ShowMessage('Data has been saved');
      end;
    end
    else
    begin
      if dmINWO.UpdateMineDef(FDef) then
      begin
        ShowMessage('Data has been updated');
      end;
    end;

  end;

  UpdateMineData;

//  isOK := True;
//  AfterClose := True;
  btnApply.Enabled := False;
  btnCancel.Enabled := False;
end;

procedure TfrmSummaryMine.btnCancelClick(Sender: TObject);
begin
  AfterClose := False;
  Close;
end;

procedure TfrmSummaryMine.btnEditProbOfDetonanationCurveClick(Sender: TObject);
begin
//  frmMinePODGraphic := TfrmMinePODGraphic.Create(Self);
//  try
//    with frmMinePODGraphic do
//    begin
//      ProbabilityGraph := pgGunAir;
//      SelectedProbObj := FSelectedMine;
//      ShowModal;
//    end;
//    AfterClose := frmMinePODGraphic.AfterClose;
//  finally
//    frmMinePODGraphic.Free;
//  end;
//
//  btnCancel.Enabled := not AfterClose;
//  btnApply.Enabled := AfterClose;
end;

procedure TfrmSummaryMine.trckbrGeneralChange(Sender: TObject);
begin
  edtLethality.Text := IntToStr(TTrackBar(Sender).Position);
end;

procedure TfrmSummaryMine.edtGeneralChange(Sender: TObject);
begin
  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';

  if (StrToInt(TEdit(Sender).Text) > 100) then
    TEdit(Sender).Text := '100';

  trckbrLethality.Position := StrToInt(TEdit(Sender).Text);

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMine.UpdateMineData;
begin
  with FSelectedMine do
  begin
    if FDef.Mine_Index = 0 then
      edtClass.Text := '(Unnamed)'
    else
      edtClass.Text := FDef.Mine_Identifier;

    {$REGION ' General '}
    LastName := edtClass.Text;

    chkAntiSurface.Checked := Boolean(FDef.Anti_Sur_Capable);
    chkAntiSubSurface.Checked := Boolean(FDef.Anti_SubSur_Capable);

    cbbCategory.ItemIndex := FDef.Platform_Category;
    cbbMooringType.ItemIndex := FDef.Mooring_Type;
    cbbDetectabilityType.ItemIndex := FDef.Detectability_Type;
    edtMaxLayingDepth.Text := FormatFloat('0', FDef.Max_Laying_Depth);

    btnEditProbOfDetonanationCurve.Enabled := FDef.Mine_Index <> 0;

    edtLength.Text := FormatFloat('0', FDef.Length);
    edtWidth.Text := FormatFloat('0', FDef.Width);
    edtHeight.Text := FormatFloat('0', FDef.Height);
    edtEngagementRange.Text := FormatFloat('0', FDef.Engagement_Range);

    edtAcousticFront.Text := FormatFloat('0.00', FDef.Front_Acoustic_Cross);
    edtAcousticSide.Text := FormatFloat('0.00', FDef.Side_Acoustic_Cross);

    trckbrLethality.Position := FDef.Mine_Lethality;
    {$ENDREGION}
  end;
end;

function TfrmSummaryMine.CekInput: Boolean;
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
  if (dmINWO.GetMineDef(edtClass.Text)>0) then
  begin
    {Jika inputan baru}
    if FSelectedMine.FDef.Mine_Index = 0 then
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

function TfrmSummaryMine.GetNumberOfKoma(s: string): Boolean;
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

procedure TfrmSummaryMine.edtNumeralKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSummaryMine.CheckBoxDataClick(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryMine.ComboBoxDataChange(Sender: TObject);
begin
  if TComboBox(Sender).ItemIndex = -1 then
    TComboBox(Sender).ItemIndex := 0;

  btnApply.Enabled := True;
end;

procedure TfrmSummaryMine.edtChange(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmSummaryMine.ValidationFormatInput;
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
