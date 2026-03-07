unit ufrmOverlayTools;

interface

uses
  MapXLib_TLB, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.ColorGrd, Vcl.Imaging.pngimage, RzBmpBtn,

  uConstantaData, uRecordData, uSimMgr_Client, uBaseCoordSystem, uClassData, uDataTypes, uFormula, ufrmSelectSimbolTaktis;

type
  E_ShapeColor = (scOutline, scFill);

  TfrmOverlayTools = class(TForm)
    pnlShape: TPanel;
    pnlMainTop: TPanel;
    cbbTypeTools: TComboBox;
    grpText: TGroupBox;
    lblTextPosition: TLabel;
    lblTextField: TLabel;
    lblTextSize: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl92: TLabel;
    bvl12: TBevel;
    bvl13: TBevel;
    lbl96: TLabel;
    lbl97: TLabel;
    SpeedButton: TSpeedButton;
    edtTextField: TEdit;
    cbbTextSize: TComboBox;
    edtTextPosLAt: TEdit;
    edtTextPosLong: TEdit;
    grpArc: TGroupBox;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl9: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    btn1: TSpeedButton;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl39: TLabel;
    lbl75: TLabel;
    lbl77: TLabel;
    lbl78: TLabel;
    lbl12: TLabel;
    bvl1: TBevel;
    lbl13: TLabel;
    bvl2: TBevel;
    edtArcPosLat: TEdit;
    edtArcPosLong: TEdit;
    edtArcRadius: TEdit;
    edtArcStartAngle: TEdit;
    edtArcEndAngle: TEdit;
    grpCircle: TGroupBox;
    lbl34: TLabel;
    lbl35: TLabel;
    lbl36: TLabel;
    btn2: TSpeedButton;
    lbl14: TLabel;
    lbl15: TLabel;
    bvl3: TBevel;
    lbl84: TLabel;
    lbl86: TLabel;
    lbl87: TLabel;
    lbl16: TLabel;
    edtCirclePosLong: TEdit;
    edtCircleRadius: TEdit;
    edtCirclePosLat: TEdit;
    grpEllipse: TGroupBox;
    lbl17: TLabel;
    lblHorizontal: TLabel;
    lbl18: TLabel;
    lblVertical: TLabel;
    lbl19: TLabel;
    bvl4: TBevel;
    lbl20: TLabel;
    btn3: TSpeedButton;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl105: TLabel;
    lbl106: TLabel;
    lbl107: TLabel;
    lbl108: TLabel;
    edtEllipsePosLat: TEdit;
    edtEllipsePosLong: TEdit;
    edtHorizontal: TEdit;
    edtVertical: TEdit;
    grpGrid: TGroupBox;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl28: TLabel;
    lbl29: TLabel;
    bvl5: TBevel;
    lbl30: TLabel;
    lbl31: TLabel;
    btn4: TSpeedButton;
    lbl32: TLabel;
    lbl33: TLabel;
    lbl117: TLabel;
    lbl118: TLabel;
    lbl37: TLabel;
    bvl7: TBevel;
    lbl38: TLabel;
    lbl40: TLabel;
    edtTablePosLat: TEdit;
    edtTablePosLong: TEdit;
    edtTableWidth: TEdit;
    edtTableColumn: TEdit;
    edtTableRow: TEdit;
    edtTableRotationAngle: TEdit;
    edtTableHeight: TEdit;
    grpLine: TGroupBox;
    btn5: TSpeedButton;
    lbl41: TLabel;
    lbl42: TLabel;
    btn6: TSpeedButton;
    lbl43: TLabel;
    lbl44: TLabel;
    lbl45: TLabel;
    lbl46: TLabel;
    lbl47: TLabel;
    lbl48: TLabel;
    lbl94: TLabel;
    lbl99: TLabel;
    bvl8: TBevel;
    edtLineStartPosLat: TEdit;
    edtLineStartPosLong: TEdit;
    edtLineEndPosLat: TEdit;
    edtLineEndPosLong: TEdit;
    grpPolygon: TGroupBox;
    lbl49: TLabel;
    SpeedButton10: TSpeedButton;
    lbl50: TLabel;
    lbl51: TLabel;
    lbl122: TLabel;
    lbl123: TLabel;
    edtPolyPosLat: TEdit;
    edtPolyPosLong: TEdit;
    lvPolyVertex: TListView;
    btnDelPoly: TButton;
    btnEditPoly: TButton;
    btnDeletePoly: TButton;
    grpRectangle: TGroupBox;
    lbl60: TLabel;
    lbl61: TLabel;
    btn9: TSpeedButton;
    btn10: TSpeedButton;
    lbl62: TLabel;
    lbl63: TLabel;
    lbl64: TLabel;
    lbl65: TLabel;
    bvl11: TBevel;
    lbl100: TLabel;
    lbl101: TLabel;
    lbl102: TLabel;
    lbl103: TLabel;
    lbl104: TLabel;
    edtRectStartPosLat: TEdit;
    edtRectStartPosLong: TEdit;
    edtRectEndPosLat: TEdit;
    edtRectEndPosLong: TEdit;
    grpSector: TGroupBox;
    lblSectorCenter: TLabel;
    lblSectorInner: TLabel;
    lblSectorOuter: TLabel;
    lblSectorStartAngle: TLabel;
    lblSectorEndAngle: TLabel;
    lbl52: TLabel;
    lbl53: TLabel;
    lbl54: TLabel;
    lbl55: TLabel;
    bvlAngle: TBevel;
    lbl56: TLabel;
    lbl57: TLabel;
    btn8: TSpeedButton;
    lbl58: TLabel;
    lbl59: TLabel;
    bvl9: TBevel;
    lbl109: TLabel;
    lbl110: TLabel;
    lbl111: TLabel;
    lbl112: TLabel;
    lbl113: TLabel;
    lbl114: TLabel;
    edtSectorPosLat: TEdit;
    edtSectorInner: TEdit;
    edtSectorOuter: TEdit;
    edtSectorStartAngle: TEdit;
    edtSectorEndAngle: TEdit;
    edtSectorPosLong: TEdit;
    grpShapeSymbol: TGroupBox;
    grpColorEditing: TGroupBox;
    pnlOutline: TPanel;
    pnlFill: TPanel;
    grbColour: TGroupBox;
    colorChoose: TColorGrid;
    pnl1: TPanel;
    btnNoFill: TStaticText;
    grpLineEditing: TGroupBox;
    pnlPenEditing: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    cbbWeightPen: TComboBox;
    cbbDashesPen: TComboBox;
    Label34: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label35: TLabel;
    Bevel4: TBevel;
    Label36: TLabel;
    Bevel5: TBevel;
    Label37: TLabel;
    Label38: TLabel;
    Bevel6: TBevel;
    Label39: TLabel;
    Label40: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label41: TLabel;
    Bevel9: TBevel;
    Label42: TLabel;
    Bevel10: TBevel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Label46: TLabel;
    pnlObject: TPanel;
    pnlMain: TPanel;
    grpColorForce: TGroupBox;
    grpObjectSymbol: TGroupBox;
    Label63: TLabel;
    pnlMainBottom: TPanel;
    btnApply: TButton;
    btnDelete: TButton;
    btnClose: TButton;
    grpIntelegent: TGroupBox;
    Label17: TLabel;
    Label52: TLabel;
    edtLongIntel: TEdit;
    btnPositionIntel: TSpeedButton;
    Label18: TLabel;
    Label53: TLabel;
    edtLattIntel: TEdit;
    Label19: TLabel;
    mmoInfo: TMemo;
    Label64: TLabel;
    Bevel16: TBevel;
    rbRed: TRadioButton;
    rbBlue: TRadioButton;
    grpNone: TGroupBox;
    grpRadar: TGroupBox;
    Label68: TLabel;
    grpArrow: TGroupBox;
    Label15: TLabel;
    grplogistik: TGroupBox;
    Label16: TLabel;
    Label22: TLabel;
    edtLongLog: TEdit;
    Label23: TLabel;
    Label62: TLabel;
    edtLattLog: TEdit;
    btnPosLog: TSpeedButton;
    Label24: TLabel;
    lvLogistic: TListView;
    edtNameLogistic: TEdit;
    cbbStatusLogistic: TComboBox;
    Label26: TLabel;
    Label25: TLabel;
    btnAddLogistic: TButton;
    btnEditLogistic: TButton;
    btnDeleteLogistic: TButton;
    btnClearLogistic: TButton;
    Label65: TLabel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    grpBase: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Bevel17: TBevel;
    Label9: TLabel;
    Label48: TLabel;
    edtLongBase: TEdit;
    btnPosBase: TSpeedButton;
    edtLattBase: TEdit;
    Label47: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lvEmbark: TListView;
    Label12: TLabel;
    edtPlatform: TEdit;
    Label13: TLabel;
    edtQty: TEdit;
    lblSymbolTaktis: TLabel;
    btnplatform: TButton;
    btnAddPlatform: TButton;
    btnEditPlatform: TButton;
    btnDeletePlatform: TButton;
    btnClearPlatform: TButton;
    Bevel18: TBevel;
    Label3: TLabel;
    Label54: TLabel;
    edtStartLatt: TEdit;
    btnStartPos: TSpeedButton;
    Label4: TLabel;
    Label55: TLabel;
    edtStartLong: TEdit;
    Label5: TLabel;
    Label56: TLabel;
    Label6: TLabel;
    Label57: TLabel;
    edtEndLatt: TEdit;
    edtEndLong: TEdit;
    btnEndPos: TSpeedButton;
    Label1: TLabel;
    Bevel19: TBevel;
    Label2: TLabel;
    Bevel20: TBevel;
    Label29: TLabel;
    Label58: TLabel;
    edtLongRadar: TEdit;
    btnPosRadar: TSpeedButton;
    edtLattRadar: TEdit;
    Label59: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edtRadius: TEdit;
    Label7: TLabel;
    grpObjNone: TGroupBox;
    Label8: TLabel;
    btnIntelegent: TRzBmpButton;
    btnLogistik: TRzBmpButton;
    btnBase: TRzBmpButton;
    btnArrow: TRzBmpButton;
    btnSelect: TRzBmpButton;
    btnPolygon: TRzBmpButton;
    btnGrid: TRzBmpButton;
    btnSector: TRzBmpButton;
    btnArc: TRzBmpButton;
    btnEllipse: TRzBmpButton;
    btnCircle: TRzBmpButton;
    btnRectangle: TRzBmpButton;
    btnLine: TRzBmpButton;
    btnText: TRzBmpButton;
    btnOutline: TRzBmpButton;
    btnFill: TRzBmpButton;
    btnSelectObj: TRzBmpButton;
    btnRadar: TRzBmpButton;
    Label27: TLabel;
    Label28: TLabel;
    Bevel21: TBevel;
    Label67: TLabel;
    Bevel1: TBevel;
    Label61: TLabel;
    edtLogIdentifier: TEdit;
    Label69: TLabel;
    Bevel22: TBevel;
    Label14: TLabel;
    edtBaseIdentifier: TEdit;
    Bevel23: TBevel;
    Label49: TLabel;
    Label60: TLabel;
    RzBmpButton1: TRzBmpButton;
    grpPlatform: TGroupBox;
    Label70: TLabel;
    Label71: TLabel;
    Bevel25: TBevel;
    Label72: TLabel;
    btnPosPlatform: TSpeedButton;
    Label74: TLabel;
    Label75: TLabel;
    Label79: TLabel;
    Bevel26: TBevel;
    edtLongPlatform: TEdit;
    edtLattPlatform: TEdit;
    lblTacticalSymbolPlatform: TLabel;
    Button1: TButton;
    Label50: TLabel;
    Bevel15: TBevel;
    edtPlatformIdentifier: TEdit;
    Label51: TLabel;
    Label66: TLabel;
    Bevel24: TBevel;
    edtRadarIdentifier: TEdit;
    Label76: TLabel;
    Label77: TLabel;
    edtHeading: TEdit;
    Label73: TLabel;
    procedure btnHandleShape(Sender: TObject);
    procedure cbbTypeToolsChange(Sender: TObject);
    procedure btnOutlineClick(Sender: TObject);
    procedure btnHandleShapePosition(Sender: TObject);
    procedure btnHandleObjectEditor(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFillClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure colorChooseChange(Sender: TObject);
    procedure btnPlatformHandle(Sender: TObject);
    procedure btnLogistichandle(Sender: TObject);
    procedure lvEmbarkSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvLogisticSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnplatformClick(Sender: TObject);
    procedure MoveTableShape(OldX, OldY, NewX, NewY: Double);
  private
    FShapeType : Integer;
    FisInputProblem : Boolean;
    FTagTombolPosition : Integer;
    FShapeColor : E_ShapeColor;
//    FMapCursor: TMapCursor;
    FSelectedOverlayTab : TOverlayTab;
    FAction : Byte;
    FIdSelectedLogistic, FIdSelectedEmbark : Integer;
  protected
    procedure CreateParams(var Params : TCreateParams); override;
  public
    IsEditObject : Boolean;
    isNoFill : Boolean;
    IdAction: Byte; { 1: add; 2: Edit; 3: Delete }

    FShapeId : Integer;

    FSelectedShape : TMainShape;
    FSelectIntelijenShape: TIntelijenShape;
    FSelectLogisticShape : TLogisticShape;
    FSelectBaseShape     : TPangkalanShape;
    FSelectPlatformShape : TPlatformShape;

    procedure Apply;
    procedure Deleted;
    procedure Canceled;

//    procedure RefreshMousePointer;
    procedure ClearFlagPoint;
    procedure ClearEditText;
    procedure LoadPanelText;
    procedure LoadPanelLine;
    procedure LoadPanelRectangle;
    procedure LoadPanelCircle;
    procedure LoadPanelEllipse;
    procedure LoadPanelArc;
    procedure LoadPanelSector;
    procedure LoadPanelGrid;
    procedure LoadPanelPolygon;
    procedure LoadPanelIntelijen;
    procedure LoadPanelLogistic;
    procedure LoadPanelRadar;
    procedure LoadPanelPangkalan;
    procedure LoadPanelPanah;
    procedure LoadPanelPlatform;

    procedure SetNoFill(val: Boolean);

    procedure GbrText;
    procedure GbrLine;
    procedure GbrRectangle;
    procedure GbrCircle;
    procedure GbrEllipse;
    procedure GbrArc;
    procedure GbrSector;
    procedure GbrGrid;
    procedure GbrPolygon;
    procedure GbrIntelejen;
    procedure GbrLogistic;
    procedure GbrRadar;
    procedure GbrPangkalan;
    procedure GbrPanah;
    procedure GbrPlatform;
    procedure GbrFlagPoint(mx, my :Double);
    procedure EditFlagPoint(id: Integer; mx, my: Double);

    procedure SelectShape(mx, my :Double);
    procedure SetPosition(mx, my :Double);

    function FindIdSelectedShape: Boolean;
    function GetPlottingColor:Integer;
    function CekInput(IdObject : Integer): Boolean;
    procedure RefreshLvPolyVertexList;
    procedure RefreshLogistic;
    procedure RefreshEmbark;

    property SelectedOverlayTab : TOverlayTab read FSelectedOverlayTab write  FSelectedOverlayTab;
    property ShapeType : Integer read FShapeType write  FShapeType;
    property TagTombolPosition : Integer read FTagTombolPosition write  FTagTombolPosition;

  end;

var
  frmOverlayTools: TfrmOverlayTools;

implementation

uses
  ufrmSituationBoard, ufrmTacticalDisplay, uSimbolTaktis;
{$R *.dfm}


{ TfrmOverlayTools }

procedure TfrmOverlayTools.Apply;
begin
  case FShapeType of
    ovText : GbrText;
    ovLine : GbrLine;
    ovRectangle : GbrRectangle;
    ovCircle : GbrCircle;
    ovEllipse : GbrEllipse;
    ovArc : GbrArc;
    ovSector : GbrSector;
    ovGrid : GbrGrid;
    ovPolygon : GbrPolygon;
    ovIntelijen : GbrIntelejen;
    ovLogistic : GbrLogistic;
    ovRadar : GbrRadar;
    ovPangkalan : GbrPangkalan;
    ovPanah : GbrPanah;
    ovPlatform : GbrPlatform;
  end;
end;

procedure TfrmOverlayTools.btnHandleObjectEditor(Sender: TObject);
begin
  case TButton(Sender).Tag of
    0: {Apply}
    begin
      Apply;
      if FisInputProblem  then
        Exit
      else
      begin
        btnHandleShape(btnSelect);
        btnHandleShape(btnSelectObj);
      end;
    end;
    1: {Delete}
    begin
      Deleted;
      btnHandleShape(btnSelect);
    end;
    2: {Cancel}
    begin
      Canceled;
      btnHandleShape(btnSelect);
    end;
    3: {Close}
    begin
      Canceled;
    end;
  end;
  ClearEditText;
  ClearFlagPoint;
end;

procedure TfrmOverlayTools.btnCloseClick(Sender: TObject);
begin
  frmSituationBoard.btnOverlayTools.ImageIndex := 12;
  frmSituationBoard.MapCursor := mcSelect;
  Close;
end;

procedure TfrmOverlayTools.btnFillClick(Sender: TObject);
begin
  FShapeColor := scFill;
end;

procedure TfrmOverlayTools.btnHandleShape(Sender: TObject);
begin
  ClearFlagPoint;
  ClearEditText;
  FAction := caAdd;

  FShapeType := TRzBmpButton(Sender).Tag;

  case FShapeType of
    0: { Select }
      begin
        grpNone.BringToFront;
        grpObjNone.BringToFront;

        { merubah cursor }
        frmSituationBoard.MapCursor := mcEdit;

        {$REGION ' Button Handle '}
        btnOutline.Visible := false;
        btnFill.Visible := false;
        pnlPenEditing.Visible := false;
        btnSelect.Down := True;
        btnSelectObj.Down := True;
        {$ENDREGION}
      end;
    ovText:
      LoadPanelText;
    ovLine:
      LoadPanelLine;
    ovRectangle:
      LoadPanelRectangle;
    ovCircle:
      LoadPanelCircle;
    ovEllipse:
      LoadPanelEllipse;
    ovArc:
      LoadPanelArc;
    ovSector:
      LoadPanelSector;
    ovGrid:
      LoadPanelGrid;
    ovPolygon:
      LoadPanelPolygon;
    ovIntelijen:
      LoadPanelIntelijen;
    ovLogistic:
      LoadPanelLogistic;
    ovRadar :
      LoadPanelRadar;
    ovPangkalan :
      LoadPanelPangkalan;
    ovPanah :
      LoadPanelPanah;
    ovPlatform :
      LoadPanelPlatform;
  end;
end;

procedure TfrmOverlayTools.btnOutlineClick(Sender: TObject);
begin
  FShapeColor := scOutline;
end;

procedure TfrmOverlayTools.btnplatformClick(Sender: TObject);
begin
  if not Assigned(frmSelectSimbolTaktis) then
    frmSelectSimbolTaktis := TfrmSelectSimbolTaktis.Create(self) ;

  try
    with frmSelectSimbolTaktis do
    begin
      drwgrdFontTaktis.RowCount := 184;
      Show;
    end;
  finally
  end;
end;

procedure TfrmOverlayTools.Canceled;
var
  j: Integer;
//  ShapeStatic: TMainStaticShape;
//  ShapeDynamic: TMainDynamicShape;
begin
//  for j := 0 to DrawOverlay.DynamicList.Count - 1 do
//  begin
//    ShapeDynamic := DrawOverlay.DynamicList.Items[j];
//    ShapeDynamic.isSelected := false;
//  end;
//
//  for j := 0 to DrawOverlay.StaticList.Count - 1 do
//  begin
//    ShapeStatic := DrawOverlay.StaticList.Items[j];
//    ShapeStatic.isSelected := false;
//  end;
//
//  Map1.Repaint;
end;

procedure TfrmOverlayTools.cbbTypeToolsChange(Sender: TObject);
begin
  if cbbTypeTools.ItemIndex = 0 then
  begin
    pnlShape.BringToFront;
    grpNone.BringToFront;
  end
  else if cbbTypeTools.ItemIndex = 1 then
  begin
    pnlObject.BringToFront;
    grpObjNone.BringToFront;
  end;
end;

function TfrmOverlayTools.CekInput(IdObject: Integer): Boolean;
begin
  Result := False;


  case IdObject of
    ovText:{Text}
    begin
      {$REGION ' Text '}
      if(edtTextPosLong.Text = '') or (edtTextPosLAt.Text= '')or
        (edtTextField.Text = '')or(cbbTextSize.Text = '')then
      begin
        ShowMessage('Data yang dimasukkan tidak lengkap');
        Result := True;
      end
      else if (StrToInt(cbbTextSize.Text) > 72 )or (StrToInt(cbbTextSize.Text) = 0 )then
      begin
        ShowMessage('Ukuran tulisan tidak sesuai');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovLine:{Line}
    begin
      {$REGION ' Line '}
      if (edtLineStartPosLong.Text ='') or (edtLineStartPosLat.Text = '')or
      (edtLineEndPosLong.Text = '') or (edtLineEndPosLat.Text = '')then
      begin
        ShowMessage('Data yang dimasukkan tidak lengkap');
        Result := True;
      end
      else if (edtLineStartPosLong.Text = edtLineEndPosLong.Text) and (edtLineStartPosLat.Text = edtLineEndPosLat.Text)then
      begin
        ShowMessage('Data yang dimasukkan tidak sesuai, Posisi Start dan End tidak boleh sama');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovRectangle:{Rectangle}
    begin
      {$REGION ' Rectangle '}
      if (edtRectStartPosLong.Text = '')or(edtRectStartPosLat.Text = '')or
      (edtRectEndPosLong.Text = '')or (edtRectEndPosLat.Text = '')or
      (edtRectStartPosLong.Text= '')or (edtRectStartPosLat.Text= '')or
      (edtRectEndPosLat.Text= '')or(edtRectEndPosLong.Text= '') then
      begin
        ShowMessage('Data yang dimasukkan tidak lengkap');
        Result := True;
      end
      else if (edtRectStartPosLong.Text = edtRectEndPosLong.Text ) and (edtRectStartPosLat.Text = edtRectEndPosLat.Text )then
      begin
        ShowMessage('Data yang dimasukkan tidak sesuai, Posisi Top-Left dan Bottom-Right tidak boleh sama');
        Result := True;;
      end;
      {$ENDREGION}
    end;
    ovCircle:{Circle}
    begin
      {$REGION ' Circle '}
      if (edtCirclePosLong.Text = '')or (edtCirclePosLat.Text = '') or
      (edtCircleRadius.Text = '')or(edtCirclePosLong.text='')or
      (edtCirclePosLat.Text= '') then
      begin
        ShowMessage('Data yang dimasukan tidak lengkap');
        Result := True;
      end
      else if (edtCircleRadius.Text = '0' ) then
      begin
        ShowMessage('Data radius yang dimasukan tidak sesuai, radius minimum > 0');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovEllipse:{Ellipse}
    begin
      {$REGION ' Ellipse '}
      if (edtEllipsePosLong.Text = '')or (edtEllipsePosLat.Text = '')
      or(edtHorizontal.Text = '') or (edtVertical.Text = '')or
      (edtEllipsePosLat.text= '')or
      (edtEllipsePosLong.Text= '') then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end
      else if (edtHorizontal.Text = '0') or (edtVertical.Text = '0')then
      begin
        ShowMessage ('Data radius yang dimasukan tidak sesuai, radius minimum > 0');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovArc:{Arc}
    begin
      {$REGION ' Arc '}
      if (edtArcPosLong.Text = '') or (edtArcPosLat.Text = '')or
      (edtArcRadius.Text = '')or(edtArcStartAngle.Text = '')or
      (edtArcEndAngle.Text = '')then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end
      else if (edtArcRadius.Text = '0') then
      begin
        ShowMessage ('Data radius yang dimasukan tidak sesuai, radius minimum > 0');
        Result := True;
      end
      else if (edtArcEndAngle.Text = edtArcStartAngle.Text) then
      begin
        ShowMessage ('Data yang dimasukkan tidak sesuai, Posisi Start dan End Angle tidak boleh sama');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovSector:{Sector}
    begin
      {$REGION ' Sector '}
      if(edtSectorInner.Text = '') or (edtSectorOuter.Text = '')or
      (edtSectorStartAngle.Text = '') or (edtSectorEndAngle.Text = '')or
      (edtSectorPosLat.Text = '')or (edtSectorPosLong.Text = '')then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end
      else if (edtSectorInner.Text = '0')or (edtSectorOuter.Text = '0')then
      begin
        ShowMessage ('Data radius yang dimasukan tidak sesuai, radius minimum > 0');
        Result := True;
      end
      else if (edtSectorStartAngle.Text = edtSectorEndAngle.Text) then
      begin
        ShowMessage('Data yang dimasukkan tidak sesuai, Posisi Start dan End Angle tidak boleh sama');
        Result := True;
      end
      else if (edtSectorInner.Text = edtSectorOuter.Text) then
      begin
        ShowMessage ('Data Inner, Outer atau Radius yang dimasukan tidak sesuai');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovGrid:{Grid}
    begin
      {$REGION ' Grid '}
      if (edtTablePosLong.Text = '')or (edtTablePosLat.Text ='') or
      (edtTableHeight.Text = '')or (edtTableColumn.Text = '') or
      (edtTableWidth.Text = '') or (edtTableRow.Text = '')or
      (edtTableRotationAngle.Text = '')or(edtTablePosLat.Text ='')
      or(edtTablePosLong.Text='') then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end
      else if (edtTableHeight.Text = '0') or (edtTableColumn.Text = '0') or (edtTableWidth.Text = '0')
      or (edtTableRow.Text = '0') then
      begin
        ShowMessage ('Data Col, Row atau Height yang dimasukan tidak sesuai');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovPolygon:{Polygon}
    begin
      {$REGION ' Polygon '}
      if lvPolyVertex.Items.Count < 1 then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovIntelijen:
    begin
      {$REGION ' Intelijen '}
      if (edtLattIntel.Text = '') or (edtLongIntel.Text = '') or (mmoInfo.Text = '')then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovLogistic:
    begin
      {$REGION ' Logistic '}
      if (edtLattLog.Text = '') or (edtLongLog.Text = '') or (lvLogistic.Items.Count < 1) then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovRadar:
    begin
      {$REGION ' Radar '}
      if (edtLattRadar.Text = '') or (edtLongRadar.Text = '') or (edtRadius.Text = '') then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovPangkalan:
    begin
      {$REGION ' Pangkalan '}
      if (edtLattBase.Text = '') or (edtLongBase.Text = '') or (lvEmbark.Items.Count < 1) then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovPanah:
    begin
      {$REGION ' Panah '}
      if (edtStartLatt.Text = '') or (edtStartLong.Text = '') or (edtEndLatt.Text = '') or (edtEndLong.Text = '') then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end;
      {$ENDREGION}
    end;
    ovPlatform:
    begin
      {$REGION ' Platform'}
      if (edtLattPlatform.Text = '') or (edtLongPlatform.Text = '') or (lblTacticalSymbolPlatform.Caption = '') or (edtHeading.Text = '') then
      begin
        ShowMessage ('Data yang dimasukan tidak lengkap');
        Result := True;
      end;
      {$ENDREGION}
    end;
  end;

  if Result then
  begin
    FisInputProblem := True;
  end;
end;

procedure TfrmOverlayTools.ClearEditText;
begin
  // reset data & set button buat ambil koordinat down jadi false

  {$REGION ' Text '}
  edtTextPosLAt.Text := '';
  edtTextPosLong.Text := '';
  edtTextField.Text := 'None';
  {$ENDREGION}

  {$REGION ' Line '}
  edtLineStartPosLong.Text := '';
  edtLineStartPosLat.Text := '';
  edtLineEndPosLong.Text := '';
  edtLineEndPosLat.Text := '';
  {$ENDREGION}

  {$REGION ' Rectangle '}
  edtRectStartPosLong.Text := '';
  edtRectStartPosLat.Text := '';
  edtRectEndPosLong.Text := '';
  edtRectEndPosLat.Text := '';
  {$ENDREGION}

  {$REGION ' Circle '}
  edtCircleRadius.Text := '1';
  edtCirclePosLong.Text := '';
  edtCirclePosLat.Text := '';
  {$ENDREGION}

  {$REGION ' Ellipse '}
  edtHorizontal.Text := '1';
  edtVertical.Text := '1';
  edtEllipsePosLong.Text := '';
  edtEllipsePosLat.Text := '';
  {$ENDREGION}

  {$REGION ' Arc '}
  edtArcRadius.Text := '1';
  edtArcPosLong.Text := '';
  edtArcPosLat.Text := '';
  edtArcStartAngle.Text := '0';
  edtArcEndAngle.Text := '0';
  {$ENDREGION}

  {$REGION ' Sector '}
  edtSectorInner.Text := '1';
  edtSectorOuter.Text := '1';
  edtSectorPosLong.Text := '';
  edtSectorPosLat.Text := '';
  edtSectorStartAngle.Text := '0';
  edtSectorEndAngle.Text := '0';
  {$ENDREGION}

  {$REGION ' Grid '}
  edtTableHeight.Text := '1';
  edtTableWidth.Text := '1';
  edtTablePosLong.Text := '';
  edtTablePosLat.Text := '';
  edtTableColumn.Text := '1';
  edtTableRow.Text := '1';
  edtTableRotationAngle.Text := '0';
  {$ENDREGION}

  {$REGION ' Polygon '}
  edtPolyPosLat.Text := '';
  edtPolyPosLong.Text := '';
  lvPolyVertex.Clear;
  {$ENDREGION}

  {$REGION ' Intelejen '}
  edtLattIntel.Text := '';
  edtLongIntel.Text := '';
  mmoInfo.Lines.Clear;
  {$ENDREGION}

  {$REGION ' Logistic '}
  edtLogIdentifier.Text := '';
  edtLattLog.Text := '';
  edtLongLog.Text := '';
  edtNameLogistic.Text := '';
  cbbStatusLogistic.Text := '';
  lvLogistic.Clear;
  {$ENDREGION}

  {$REGION ' Radar '}
  edtLattRadar.Text := '';
  edtLongRadar.Text := '';
  edtRadius.Text := '';
  {$ENDREGION}

  {$REGION ' Pangkalan '}
  edtBaseIdentifier.Text := '';
  edtLattBase.Text := '';
  edtLongBase.Text := '';
  edtPlatform .Text := '';
  edtQty.Text := '';
  lvEmbark.Clear;
  {$ENDREGION}

  {$REGION ' Panah '}
  edtStartLatt.Text := '';
  edtStartLong.Text := '';
  edtEndLatt.Text := '';
  edtEndLong.Text := '';
  {$ENDREGION}

  {$REGION ' Platform '}
  edtPlatformIdentifier.Text := '';
  edtLattPlatform.Text := '';
  edtLongPlatform.Text := '';
  lblTacticalSymbolPlatform.Caption := '';
  {$ENDREGION}

//  SpeedButton10.Down := false;

end;

procedure TfrmOverlayTools.ClearFlagPoint;
begin
  simMgrClient.DrawFlagPoint.FlagList.Clear;
  frmSituationBoard.Map1.Refresh;
  frmSituationBoard.Map1.Repaint;
end;

procedure TfrmOverlayTools.colorChooseChange(Sender: TObject);
begin
  if FShapeColor = scOutline then
  begin
    pnlOutline.Color := colorChoose.ForegroundColor;
  end
  else
  begin
    isNoFill := False;
    pnlFill.Caption := '';
    pnlFill.Color := colorChoose.ForegroundColor;
  end;
end;

procedure TfrmOverlayTools.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent:= 0;
  Params.Style := WS_POPUPWINDOW or WS_CAPTION or WS_CLIPCHILDREN;
end;

procedure TfrmOverlayTools.Deleted;
var
  recShape : TRecTCPSendOverlayShape;

begin

  if not FindIdSelectedShape then
      Exit;

  if Assigned(FSelectedOverlayTab) then
  begin
    recShape.IdAction := caDelete;
    recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
    recShape.IdSelectShape := FShapeId;
    recShape.ShapeType := FShapeType;

    simMgrClient.netSend_CmdOverlayShape(recShape);
  end;

end;

function TfrmOverlayTools.FindIdSelectedShape: Boolean;
var
  i : Integer;
  overlaTabTemp : TOverlayTab;
  mainShapeTemp : TMainShape;

begin
  Result := False;

  if Assigned(FSelectedOverlayTab) then
  begin
    for I := 0 to FSelectedOverlayTab.MemberList.Count - 1 do
    begin
      mainShapeTemp := FSelectedOverlayTab.MemberList[i];
      if (mainShapeTemp.isSelected) or (mainShapeTemp = FSelectIntelijenShape) then
      begin
        FShapeId := i;
        Result := True;
        break;
      end;
      if (mainShapeTemp.isSelected) or (mainShapeTemp = FSelectLogisticShape) then
      begin
        FShapeId := i;
        Result := True;
        break;
      end;
      if (mainShapeTemp.isSelected) or (mainShapeTemp = FSelectBaseShape) then
      begin
        FShapeId := i;
        Result := True;
        break;
      end;
    end;
  end;

  if Result = false then
  begin
    MessageDlg('Gambar yang anda pilih tidak valid', mtWarning, [mbOK], 0);
  end;

end;

procedure TfrmOverlayTools.FormShow(Sender: TObject);
begin
  cbbTypeTools.ItemIndex := 0;
  cbbTypeToolsChange(nil);
  btnHandleShape(btnSelect);
end;

{$REGION ' Procedure Gbr '}

procedure TfrmOverlayTools.GbrText;
var
  Size : Byte;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovText) then
    Exit;

  Size := 10;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovText;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.PostStart.X := dmsToLong(edtTextPosLong.Text);
  recShape.PostStart.Y := dmsToLatt(edtTextPosLat.Text);
  recShape.Size := StrToInt(cbbTextSize.Text);
  recShape.Words := edtTextField.Text;
  recShape.color := pnlOutline.Color;

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrLine;
var
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovLine) then
    Exit;

//  if IsEditObject then
//  begin
//      Action := 2;
//    if not FindIdSelectedShape then
//      Exit;
//  end
//  else
//    Action := 1;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovLine;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.postStart.X := dmsToLong(edtLineStartPosLong.Text);
  recShape.postStart.Y := dmsToLatt(edtLineStartPosLat.Text);
  recShape.postEnd.X := dmsToLong(edtLineEndPosLong.Text);
  recShape.postEnd.Y := dmsToLatt(edtLineEndPosLat.Text);

  recShape.color := pnlOutline.color;
  recShape.lineType :=  TPenStyle(cbbDashesPen.ItemIndex);
  recShape.weight := StrToInt(cbbWeightPen.Text);

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrRectangle;
var
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovRectangle) then
    Exit;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovRectangle;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.postStart.X := dmsToLong(edtRectStartPosLong.Text);
  recShape.postStart.Y := dmsToLatt(edtRectStartPosLat.Text);
  recShape.postEnd.X := dmsToLong(edtRectEndPosLong.Text);
  recShape.postEnd.Y := dmsToLatt(edtRectEndPosLat.Text);

  recShape.color := pnlOutline.Color;

  if isNoFill  then
  begin
    recShape.BrushStyle := bsClear;
  end
  else
  begin
    recShape.BrushStyle := bsSolid;
    recShape.ColorFill := pnlFill.Color;
  end;

  recShape.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
  recShape.Weight := StrToInt(cbbWeightPen.Text);

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrCircle;
var
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovCircle) then
    Exit;

//  if IsEditObject then
//    begin
//      Action := 2;
//    if not FindIdSelectedShape then
//      Exit;
//    end
//  else
//    FAction := 1;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovCircle;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.PostStart.X := dmsToLong(edtCirclePosLong.Text);
  recShape.PostStart.Y := dmsToLatt(edtCirclePosLat.Text);
  recShape.Radius1 := StrToFloat(edtCircleRadius.Text);
  recShape.color := pnlOutline.Color;

  if isNoFill  then
    recShape.BrushStyle := bsClear
  else
  begin
    recShape.BrushStyle := bsSolid;
    recShape.ColorFill := pnlFill.Color;
  end;

  recShape.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
  recShape.Weight := StrToInt(cbbWeightPen.Text);

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrEllipse;
var
  recShape : TRecTCPSendOverlayShape;
begin
  if CekInput(ovEllipse) then
    Exit;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovEllipse;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.PostStart.X := dmsToLong(edtEllipsePosLong.Text);
  recShape.PostStart.Y := dmsToLatt(edtEllipsePosLat.Text);
  recShape.Radius1 := StrToFloat(edtHorizontal.Text);
  recShape.Radius2 := StrToFloat(edtVertical.Text);
  recShape.color := pnlOutline.Color;

  if isNoFill  then
    recShape.BrushStyle := bsClear
  else
  begin
    recShape.BrushStyle := bsSolid;
    recShape.ColorFill := pnlFill.Color;
  end;

  recShape.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
  recShape.Weight := StrToInt(cbbWeightPen.Text);

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrArc;
var
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovArc) then
    Exit;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovArc;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.PostStart.X := dmsToLong(edtArcPosLong.Text);
  recShape.PostStart.Y := dmsToLatt(edtArcPosLat.Text);
  recShape.radius1 := StrToFloat(edtArcRadius.Text);
  recShape.StartAngle := StrToInt(edtArcStartAngle.Text);
  recShape.EndAngle := StrToInt(edtArcEndAngle.Text);
  recShape.color := pnlOutline.Color;

  recShape.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
  recShape.Weight := StrToInt(cbbWeightPen.Text);

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrSector;
var
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovSector) then
    Exit;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovSector;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.PostStart.X := dmsToLong(edtSectorPosLong.Text);
  recShape.PostStart.Y := dmsToLatt(edtSectorPosLat.Text);
  recShape.Radius1 := StrToFloat(edtSectorOuter.Text);
  recShape.Radius2 := StrToFloat(edtSectorInner.Text);
  recShape.StartAngle := StrToInt(edtSectorStartAngle.Text);
  recShape.EndAngle := StrToInt(edtSectorEndAngle.Text);
  recShape.color := pnlOutline.Color;

  recShape.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
  recShape.Weight := StrToInt(cbbWeightPen.Text);

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrGrid;
var
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovGrid) then
    Exit;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovGrid;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;

  recShape.PostStart.X := dmsToLong(edtTablePosLong.Text);
  recShape.PostStart.Y := dmsToLatt(edtTablePosLat.Text);
  recShape.Radius1 := StrToFloat(edtTableHeight.Text);
  recShape.Radius2 := StrToFloat(edtTableWidth.Text);
  recShape.Kolom := StrToInt(edtTableColumn.Text);
  recShape.Baris := StrToInt(edtTableRow.Text);
  recShape.Rotasi := StrToInt(edtTableRotationAngle.Text);
  recShape.color := pnlOutline.Color;

  if isNoFill  then
    recShape.BrushStyle := bsClear
  else
  begin
    recShape.BrushStyle := bsSolid;
    recShape.ColorFill := pnlFill.Color;
  end;

  recShape.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
  recShape.Weight := StrToInt(cbbWeightPen.Text);

  {Kirim data disini}
  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrPolygon;
var
  i : Integer;
  li : TListItem;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovPolygon) then
    Exit;

  recShape.IdUserRole := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType := ovPolygon;
  recShape.IdSelectShape := FShapeId;
  recShape.IdAction := FAction;
  recShape.color := pnlOutline.Color;

  if isNoFill  then
  begin
    recShape.BrushStyle := bsClear;
  end
  else
  begin
    recShape.BrushStyle := bsSolid;
    recShape.ColorFill := pnlFill.Color;
  end;

  recShape.LineType :=  TPenStyle(cbbDashesPen.ItemIndex);
  recShape.Weight := StrToInt(cbbWeightPen.Text);

  for i := 0 to 12 do
  begin
    li := lvPolyVertex.Items[i];

    recShape.PolyPoint[i].X := 0;
    recShape.PolyPoint[i].Y := 0;
  end;

  for i := 0 to lvPolyVertex.Items.Count - 1 do
  begin
    li := lvPolyVertex.Items[i];

    recShape.PolyPoint[i].X := dmsToLong(li.SubItems[0]);
    recShape.PolyPoint[i].Y := dmsToLatt(li.SubItems[1]);
  end;

  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrIntelejen;
var
  i : Integer;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovIntelijen) then
    Exit;

  recShape.IdUserRole   := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId   := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType    := ovIntelijen;
  recShape.PostStart.X  := dmsToLong(edtLongIntel.Text);
  recShape.PostStart.Y  := dmsToLatt(edtLattIntel.Text);
  recShape.IdSelectShape:= FShapeId;
  recShape.IdAction     := FAction;
  recShape.color        := GetPlottingColor;

  for i := 0 to 12 do
  begin
    recShape.Data[i] := '';
    recShape.Status[i] := '';
    recShape.Simbol[i] := '';
    recShape.Quantity[i] := 0;
  end;

  for I := 0 to mmoInfo.Lines.Count - 1 do
  begin
    recShape.Data[i] := mmoInfo.Lines.Strings[i];
  end;

  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrLogistic;
var
  i : Integer;
  li : TListItem;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovLogistic) then
    Exit;

  recShape.IdUserRole   := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId   := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType    := ovLogistic;
  recShape.OverlayName  := edtLogIdentifier.Text;
  recShape.PostStart.X  := dmsToLong(edtLongLog.Text);
  recShape.PostStart.Y  := dmsToLatt(edtLattLog.Text);
  recShape.IdSelectShape:= FShapeId;
  recShape.IdAction     := FAction;
  recShape.color        := GetPlottingColor;

  for i := 0 to 12 do
  begin
    recShape.Data[i] := '';
    recShape.Status[i] := '';
    recShape.Simbol[i] := '';
    recShape.Quantity[i] := 0;
  end;

  for i := 0 to lvLogistic.Items.Count - 1 do
  begin
    li := lvLogistic.Items[i];
    recShape.Data[i] := li.Caption;
    recShape.Status[i] := li.SubItems[0];
  end;

  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrPangkalan;
var
  i : Integer;
  li : TListItem;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovPangkalan) then
    Exit;

  recShape.IdUserRole   := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId   := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType    := ovPangkalan;
  recShape.OverlayName  := edtBaseIdentifier.Text;
  recShape.PostStart.X  := dmsToLong(edtLongBase.Text);
  recShape.PostStart.Y  := dmsToLatt(edtLattBase.Text);
  recShape.IdSelectShape:= FShapeId;
  recShape.IdAction     := FAction;
  recShape.color        := GetPlottingColor;

  for i := 0 to 12 do
  begin
    recShape.Data[i] := '';
    recShape.Status[i] := '';
    recShape.Simbol[i] := '';
    recShape.Quantity[i] := 0;
  end;

  for i := 0 to lvEmbark.Items.Count - 1 do
  begin
    li := lvEmbark.Items[i];
    recShape.Data[i] := li.Caption;
    recShape.Quantity[i] := StrToInt(li.SubItems[0]);
    recShape.Simbol[i] := li.SubItems[1];
  end;

  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrPlatform;
var
  i : Integer;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovPlatform) then
    Exit;

  recShape.IdUserRole   := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId   := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType    := ovPlatform;
  recShape.OverlayName  := edtPlatformIdentifier.Text;
  recShape.PostStart.X  := dmsToLong(edtLongPlatform.Text);
  recShape.PostStart.Y  := dmsToLatt(edtLattPlatform.Text);
  recShape.Rotasi       := Round(ValidateDegree(StrToFloat(edtHeading.Text)));
  recShape.IdSelectShape:= FShapeId;
  recShape.IdAction     := FAction;
  recShape.color        := GetPlottingColor;

  for i := 0 to 12 do
  begin
    recShape.Data[i] := '';
    recShape.Status[i] := '';
    recShape.Simbol[i] := '';
    recShape.Quantity[i] := 0;
  end;

  recShape.Words := lblTacticalSymbolPlatform.Caption;

  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrRadar;
var
  i : Integer;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovRadar) then
    Exit;

  recShape.IdUserRole   := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId   := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType    := ovRadar;
  recShape.OverlayName  := edtRadarIdentifier.Text;
  recShape.PostStart.X  := dmsToLong(edtLongRadar.Text);
  recShape.PostStart.Y  := dmsToLatt(edtLattRadar.Text);
  recShape.IdSelectShape:= FShapeId;
  recShape.IdAction     := FAction;
  recShape.color        := GetPlottingColor;

  for i := 0 to 12 do
  begin
    recShape.Data[i] := '';
    recShape.Status[i] := '';
    recShape.Simbol[i] := '';
    recShape.Quantity[i] := 0;
  end;

  recShape.Radius1 := StrToFloat(edtRadius.Text);

  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrPanah;
var
  i : Integer;
  recShape : TRecTCPSendOverlayShape;

begin
  if CekInput(ovPanah) then
    Exit;

  recShape.IdUserRole   := FSelectedOverlayTab.IdUserRole;
  recShape.TemplateId   := FSelectedOverlayTab.IdOverlayTab;
  recShape.ShapeType    := ovPanah;
  recShape.PostStart.X  := dmsToLong(edtStartLong.Text);
  recShape.PostStart.Y  := dmsToLatt(edtStartLatt.Text);
  recShape.PostEnd.X    := dmsToLong(edtEndLong.Text);
  recShape.PostEnd.Y    := dmsToLatt(edtEndLatt.Text);
  recShape.IdSelectShape:= FShapeId;
  recShape.IdAction     := FAction;
  recShape.color        := GetPlottingColor;

  for i := 0 to 12 do
  begin
    recShape.Data[i] := '';
    recShape.Status[i] := '';
    recShape.Simbol[i] := '';
    recShape.Quantity[i] := 0;
  end;

  simMgrClient.netSend_CmdOverlayShape(recShape);
  FisInputProblem := False;
end;

procedure TfrmOverlayTools.GbrFlagPoint(mx, my: Double);
var
  flagPointTemp : TFlagPoint;
begin
  flagPointTemp := TFlagPoint.Create(simMgrClient.Converter);
  flagPointTemp.Post.X := mx;
  flagPointTemp.Post.Y := my;
  simMgrClient.DrawFlagPoint.FlagList.Add(flagPointTemp);
end;

procedure TfrmOverlayTools.EditFlagPoint(id: Integer; mx, my: Double);
var
  flagPointTemp: TFlagPoint;
begin
  flagPointTemp := TFlagPoint.Create(simMgrClient.Converter);
  flagPointTemp.Post.X := mx;
  flagPointTemp.Post.Y := my;

  if (id = 1) or (id = 3) then
  begin
    simMgrClient.DrawFlagPoint.FlagList.Delete(0);
    simMgrClient.DrawFlagPoint.FlagList.Insert(0, flagPointTemp);
  end
  else
  begin
    simMgrClient.DrawFlagPoint.FlagList.Delete(1);
    simMgrClient.DrawFlagPoint.FlagList.Insert(1, flagPointTemp);
  end;
end;

procedure TfrmOverlayTools.RefreshEmbark;
begin
  edtPlatform.Text := '';
  edtQty.Text := '';
  lblSymbolTaktis.Caption := '';
  btnEditPlatform.Enabled := False;
  btnDeletePlatform.Enabled := False;
end;

procedure TfrmOverlayTools.RefreshLogistic;
begin
  edtNameLogistic.Text := '';
  cbbStatusLogistic.ItemIndex := 0;
  btnEditLogistic.Enabled := False;
  btnDeleteLogistic.Enabled := False;
end;

procedure TfrmOverlayTools.RefreshLvPolyVertexList;
var
  j: Integer;
  flagPointTemp: TFlagPoint;
  li: TListItem;
begin
  lvPolyVertex.Items.BeginUpdate;
  try
    simMgrClient.DrawFlagPoint.FlagList.Clear;

    for j := 0 to lvPolyVertex.Items.Count - 1 do
    begin
      lvPolyVertex.Items.Item[j].Caption := IntToStr(j + 1);

      li := lvPolyVertex.Items[j];

      flagPointTemp := TFlagPoint.Create(simMgrClient.Converter);
      flagPointTemp.Post.X := dmsToLong(li.SubItems[0]);
      flagPointTemp.Post.Y := dmsToLatt(li.SubItems[1]);

      simMgrClient.DrawFlagPoint.FlagList.Add(flagPointTemp);
    end;
  finally
    lvPolyVertex.Items.EndUpdate;
  end;
end;

{$ENDREGION}

procedure TfrmOverlayTools.LoadPanelArc;
begin
  grpArc.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelCircle;
begin
  grpCircle.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelEllipse;
begin
  grpEllipse.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelGrid;
begin
  grpGrid.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelIntelijen;
begin
  grpIntelegent.BringToFront;

  {$REGION ' Button Handle '}
  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelLogistic;
begin
   grplogistik.BringToFront;

  {$REGION ' Button Handle '}
  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelLine;
begin
  grpLine.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelPanah;
begin
  grpArrow.BringToFront;

  {$REGION ' Button Handle '}
  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelPangkalan;
begin
  grpBase.BringToFront;

  {$REGION ' Button Handle '}
  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelPlatform;
begin
  grpPlatform.BringToFront;

  {$REGION ' Button Handle '}
  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelPolygon;
begin
  grpPolygon.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelRadar;
begin
  grpRadar.BringToFront;

  {$REGION ' Button Handle '}
  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelRectangle;
begin
  grpRectangle.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelSector;
begin
  grpSector.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := True;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.LoadPanelText;
begin
  grpText.BringToFront;

  {$REGION ' Button Handle '}
  btnOutline.Visible := True;
  btnFill.Visible := False;
  pnlPenEditing.Visible := True;
  SetNoFill(True);
  btnOutlineClick(nil);

  btnDelete.Enabled := FAction = caEdit;
  {$ENDREGION}
end;

procedure TfrmOverlayTools.lvEmbarkSelectItem(Sender: TObject; Item: TListItem;Selected: Boolean);
var
  li : TListItem;
begin
  if Selected then
  begin
    FIdSelectedEmbark := lvEmbark.Selected.Index;

    li := lvEmbark.Items[FIdSelectedEmbark];
    edtPlatform.Text := li.Caption;
    edtQty.Text := li.SubItems[0];
    lblSymbolTaktis.Caption := li.SubItems[1];

    btnEditPlatform.Enabled := True;
    btnDeletePlatform.Enabled := True;
  end
  else
  begin
    btnEditPlatform.Enabled := False;
    btnDeletePlatform.Enabled := False;
  end;
end;

procedure TfrmOverlayTools.lvLogisticSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  li : TListItem;
begin
  if Selected then
  begin
    FIdSelectedLogistic := lvLogistic.Selected.Index;

    li := lvLogistic.Items[FIdSelectedLogistic];
    edtNameLogistic.Text := li.Caption;
    cbbStatusLogistic.Text := li.SubItems[0];

    btnEditLogistic.Enabled := True;
    btnDeleteLogistic.Enabled := True;
  end
  else
  begin
    btnEditLogistic.Enabled := False;
    btnDeleteLogistic.Enabled := False;
  end;
end;

function TfrmOverlayTools.GetPlottingColor: Integer;
begin
  if rbBlue.Checked then
    Result := clBlue
  else
    Result := clRed;
end;

procedure TfrmOverlayTools.SelectShape(mx, my :Double);
var
  i, j, k, Hr,Vr, r,
  x1, x2, x3, x4, x5,
  y1, y2, y3, y4, y5 : Integer;

  Idx, Idy, Odx, Ody,
  RKiAts, RKaAts, RKiBwh, RKaBwh,
  BKiAts, BKaAts, BKiBwh, BKaBwh : Double;

  IptS, IptE, OptS, OptE, ptPos : t2DPoint;

  rect1, rect2, rect3, rect4 : TRect;

  mainShapeTemp  : TMainShape;
  textTemp       : TTextShape;
  lineTemp       : TLineShape;
  rectangleTemp  : TRectangleShape;
  circleTemp     : TCircleShape;
  ellipseTemp    : TEllipseShape;
  arcTemp        : TArcShape;
  sectorTemp     : TSectorShape;
  gridTemp       : TGridShape;
  polygonTemp    : TPolygonShape;

  IntelijenTemp : TIntelijenShape;
  LogisticTemp  : TLogisticShape;
  RadarTemp     : TRadarShape;
  BaseTemp      : TPangkalanShape;
  ArrowTemp     : TPanahShape;
  PlatformTemp  : TPlatformShape;

  intelDataTemp : TIntelijenInfo;
  shipDataTemp  : TVehicleOnBase;
  logDataTemp   : TLogisticOnBase;

  polyPoint : Array of TPoint;
  point : TDotShape;

  countList : Integer;
  pos: TPoint;
  TempShapeId: Integer;
  isSelectShape : Boolean;

begin
  isSelectShape := False;

  if Assigned(SelectedOverlayTab) then
  begin
    for i := 0 to SelectedOverlayTab.MemberList.Count - 1 do
    begin
      mainShapeTemp := SelectedOverlayTab.MemberList[i];
      mainShapeTemp.isSelected := False;
    end;

    FSelectedShape := nil;

    for countList := SelectedOverlayTab.MemberList.Count-1 downto 0 do
    begin
      mainShapeTemp := SelectedOverlayTab.MemberList[countList];

      simMgrClient.Converter.ConvertToScreen(mx, my, pos.X, pos.Y);
      ptPos := SelectedOverlayTab.Formula.PointTo2D(pos.X, pos.Y);

      if mainShapeTemp is TTextShape then
      begin
        {$REGION ' Text Section '}
        textTemp := TTextShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(textTemp.postStart.X, textTemp.postStart.Y, x1, y1);

        rect1 := SelectedOverlayTab.Formula.checkText(x1, y1, textTemp.Size, textTemp.words);

        if ptToArea(rect1, ptPos) then
        begin
          isSelectShape := True;

          FShapeType := ovText;
          FShapeId := textTemp.ShapeId;
          FAction := caEdit;
          edtTextPosLat.Text  := formatDMS_latt(textTemp.postStart.Y);
          edtTextPosLong.Text := formatDMS_long(textTemp.postStart.X);
          cbbTextSize.Text    := IntToStr(textTemp.size);
          edtTextField.Text   := textTemp.words;
          pnlOutline.color    := textTemp.ShapeOutline;
          textTemp.isSelected := true;
          LoadPanelText;
          pnlShape.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TLineShape then
      begin
        {$REGION ' Line Section '}
        lineTemp := TLineShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(lineTemp.postStart.X, lineTemp.postStart.Y, x1, y1);
        simMgrClient.Converter.ConvertToScreen(lineTemp.postEnd.X, lineTemp.postEnd.Y, x2, y2 );

        IptS  := SelectedOverlayTab.Formula.PointTo2D(x1, y1);
        IptE  := SelectedOverlayTab.Formula.PointTo2D(x2, y2);

        if ptToLine(IptS,IptE,ptPos) then
        begin
          isSelectShape := True;

          FShapeType:= ovLine;
          FShapeId := lineTemp.ShapeId;
          FAction := caEdit;
          edtLineStartPosLat.Text := formatDMS_latt(lineTemp.postStart.Y);
          edtLineStartPosLong.Text := formatDMS_long(lineTemp.postStart.X);
          edtLineEndPosLat.Text := formatDMS_latt(lineTemp.postEnd.Y);
          edtLineEndPosLong.Text := formatDMS_long(lineTemp.postEnd.X);
          pnlOutline.Color := lineTemp.ShapeOutline;
          cbbDashesPen.ItemIndex :=  SetLineType(lineTemp.LineType);
          cbbWeightPen.Text := IntToStr(lineTemp.LineWeight);
          lineTemp.isSelected := true;
          LoadPanelLine;
          pnlShape.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TRectangleShape then
      begin
        {$REGION ' Rectangle Section '}
        rectangleTemp := TRectangleShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(rectangleTemp.postStart.X, rectangleTemp.postStart.Y, x1, y1);
        simMgrClient.Converter.ConvertToScreen(rectangleTemp.postEnd.X, rectangleTemp.postEnd.Y, x2, y2 );

        rect1.Left    := x1;
        rect1.Top     := Y1;
        rect1.Right   := x2;
        rect1.Bottom  := Y2;

        rect2 := SelectedOverlayTab.Formula.checkXYPosition(rect1.Left, rect1.Top, rect1.Right, rect1.Bottom);

        if ptToArea(rect2, ptPos) then
        begin
          isSelectShape := True;

          FShapeType := ovRectangle;
          FShapeId := rectangleTemp.ShapeId;
          FAction := caEdit;
          edtRectStartPosLong.Text  := formatDMS_long(rectangleTemp.postStart.X);
          edtRectStartPosLat.Text   := formatDMS_latt(rectangleTemp.postStart.Y);
          edtRectEndPosLong.Text    := formatDMS_long(rectangleTemp.postEnd.X);
          edtRectEndPosLat.Text     := formatDMS_latt(rectangleTemp.postEnd.Y);
          pnlOutline.Color      := rectangleTemp.ShapeOutline;
          cbbDashesPen.ItemIndex :=  SetLineType(rectangleTemp.LineType);
          cbbWeightPen.Text := IntToStr(rectangleTemp.LineWeight);

          if rectangleTemp.BrushStyle = bsClear then
          begin
            SetNoFill(True);
          end
          else
          begin
            SetNoFill(False);
            PnlFill.Color := rectangleTemp.ShapeFill;
          end;

          rectangleTemp.isSelected := true;
          LoadPanelRectangle;
          pnlShape.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TCircleShape then
      begin
        {$REGION ' Circle Section '}
        circleTemp := TCircleShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToMap(pos.X, pos.Y, ptPos.X, ptPos.Y);

        if ptToCircle(circleTemp.postCenter, ptPos, circleTemp.radius) then
        begin
          isSelectShape := True;

          FShapeType := ovCircle;
          FShapeId := circleTemp.ShapeId;
          FAction := caEdit;
          edtCirclePosLong.Text := formatDMS_long(circleTemp.postCenter.X);
          edtCirclePosLat.Text := formatDMS_latt(circleTemp.postCenter.Y);
          edtCircleRadius.Text := FloatToStr(circleTemp.radius);
          pnlOutline.Color := circleTemp.ShapeOutline;
          cbbDashesPen.ItemIndex :=  SetLineType(circleTemp.LineType);
          cbbWeightPen.Text := IntToStr(circleTemp.LineWeight);

          if circleTemp.BrushStyle = bsClear then
          begin
            SetNoFill(True);
          end
          else
          begin
            SetNoFill(False);
            pnlFill.Color := circleTemp.ShapeFill;
          end;

          circleTemp.isSelected := true;
          LoadPanelCircle;
          pnlShape.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TEllipseShape then
      begin
        {$REGION ' Ellipse Section '}
        ellipseTemp := TEllipseShape(mainShapeTemp);

        Idx := ellipseTemp.postCenter.X + ellipseTemp.Hradius/60;
        Idy := ellipseTemp.postCenter.Y + ellipseTemp.Vradius/60;

        simMgrClient.Converter.ConvertToScreen(ellipseTemp.postCenter.X, ellipseTemp.postCenter.Y, x1, y1);
        simMgrClient.Converter.ConvertToScreen(Idx, Idy, x2, y2);

        Hr := Abs(x1 - x2);
        Vr := Abs(y1 - y2);

        rect1.Left    := x1 - Hr;
        rect1.Top     := Y1 - Vr;
        rect1.Right   := x1 + Hr;
        rect1.Bottom  := Y1 + Vr;

        rect2 := SelectedOverlayTab.Formula.checkXYPosition(rect1.Left, rect1.Top, rect1.Right, rect1.Bottom);

        if ptToArea(rect2, ptPos) then
        begin
          isSelectShape := True;

          FShapeType := ovEllipse;
          FShapeId := ellipseTemp.ShapeId;
          FAction := caEdit;
          edtEllipsePosLong.Text  := formatDMS_long(ellipseTemp.postCenter.X);
          edtEllipsePosLat.Text   := formatDMS_latt(ellipseTemp.postCenter.Y);
          edtHorizontal.Text      := FloatToStr(ellipseTemp.Hradius);
          edtVertical.Text        := FloatToStr(ellipseTemp.Vradius);
          pnlOutline.Color        := ellipseTemp.ShapeOutline;

          cbbDashesPen.ItemIndex :=  SetLineType(ellipseTemp.LineType);
          cbbWeightPen.Text := IntToStr(ellipseTemp.LineWeight);

          if ellipseTemp.BrushStyle = bsClear then
          begin
            SetNoFill(True);
          end
          else
          begin
            SetNoFill(False);
            pnlFill.Color := ellipseTemp.ShapeFill;
          end;

          ellipseTemp.isSelected := true;
          LoadPanelEllipse;
          pnlShape.BringToFront;

          break;
        end;
         {$ENDREGION}
      end
      else if mainShapeTemp is TArcShape then
      begin
        {$REGION ' Arc Section '}
        arcTemp := TArcShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToMap(pos.X, pos.Y, ptPos.X, ptPos.Y);

        if ptToArc(arcTemp.postCenter, ptPos, arcTemp.radius, arcTemp.radius, arcTemp.StartAngle, arcTemp.EndAngle, 1) then
        begin
          isSelectShape := True;

          FShapeType := ovArc;
          FShapeId := arcTemp.ShapeId;
          FAction := caEdit;
          edtArcPosLong.Text := formatDMS_long(arcTemp.postCenter.X);
          edtArcPosLat.Text := formatDMS_latt(arcTemp.postCenter.Y);
          edtArcRadius.Text := FloatToStr(arcTemp.radius);
          edtArcStartAngle.Text := IntToStr(arcTemp.StartAngle);
          edtArcEndAngle.Text := IntToStr(arcTemp.EndAngle);
          pnlOutline.Color := arcTemp.ShapeOutline;
          cbbDashesPen.ItemIndex :=  SetLineType(arcTemp.LineType);
          cbbWeightPen.Text := IntToStr(arcTemp.LineWeight);

          arcTemp.isSelected  := true;
          LoadPanelArc;
          pnlShape.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TSectorShape then
      begin
        {$REGION ' Sector Section '}
        sectorTemp := TSectorShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToMap(pos.X, pos.Y, ptPos.X, ptPos.Y);

        if ptToArc(sectorTemp.postCenter, ptPos, sectorTemp.Iradius, sectorTemp.Oradius, sectorTemp.StartAngle, sectorTemp.EndAngle, 2) then
        begin
          isSelectShape := True;

          FShapeType := ovSector;
          FShapeId := sectorTemp.ShapeId;
          FAction := caEdit;
          edtSectorPosLong.Text     := formatDMS_long(sectorTemp.postCenter.X);
          edtSectorPosLat.Text      := formatDMS_latt(sectorTemp.postCenter.Y);
          edtSectorInner.Text       := FloatToStr(sectorTemp.Iradius);
          edtSectorOuter.Text       := FloatToStr(sectorTemp.Oradius);
          edtSectorStartAngle.Text  := IntToStr(sectorTemp.StartAngle);
          edtSectorEndAngle.Text    := IntToStr(sectorTemp.EndAngle);
          pnlOutline.Color      := sectorTemp.ShapeOutline;

          cbbDashesPen.ItemIndex :=  SetLineType(sectorTemp.LineType);
          cbbWeightPen.Text := IntToStr(sectorTemp.LineWeight);

          sectorTemp.isSelected  := true;
          LoadPanelSector;
          pnlShape.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TGridShape then
      begin
        {$REGION ' Grid Section '}
        gridTemp := TGridShape(mainShapeTemp);

        //Point Kiri Atas
        IptS.X := gridTemp.postCenter.X - ((gridTemp.Width/60)*(gridTemp.WCount/2));
        IptS.Y := gridTemp.postCenter.Y + ((gridTemp.Height/60)*(gridTemp.HCount)/2);

        //Point Kanan Atas
        IptE.X := gridTemp.postCenter.X + ((gridTemp.Width/60)*(gridTemp.WCount/2));
        IptE.Y := gridTemp.postCenter.Y + ((gridTemp.Height/60)*(gridTemp.HCount)/2);

        //Point Kanan Bawah
        OptS.X := gridTemp.postCenter.X + ((gridTemp.Width/60)*(gridTemp.WCount/2));
        OptS.Y := gridTemp.postCenter.Y - ((gridTemp.Height/60)*(gridTemp.HCount)/2);

        //Point Kiri Bawah
        OptE.X := gridTemp.postCenter.X - ((gridTemp.Width/60)*(gridTemp.WCount/2));
        OptE.Y := gridTemp.postCenter.Y - ((gridTemp.Height/60)*(gridTemp.HCount)/2);

        BKiAts   := CalcBearing(gridTemp.postCenter.X, gridTemp.postCenter.Y, IptS.X, IptS.Y);
        BKaAts  := CalcBearing(gridTemp.postCenter.X, gridTemp.postCenter.Y, IptE.X, IptE.Y);
        BKaBwh := CalcBearing(gridTemp.postCenter.X, gridTemp.postCenter.Y, OptS.X, OptS.Y);
        BKiBwh  := CalcBearing(gridTemp.postCenter.X, gridTemp.postCenter.Y, OptE.X, OptE.Y);

        RKiAts     := CalcRange(gridTemp.postCenter.X, gridTemp.postCenter.Y, IptS.X, IptS.Y);
        RKaAts    := CalcRange(gridTemp.postCenter.X, gridTemp.postCenter.Y, IptE.X, IptE.Y);
        RKaBwh   := CalcRange(gridTemp.postCenter.X, gridTemp.postCenter.Y, OptS.X, OptS.Y);
        RKiBwh    := CalcRange(gridTemp.postCenter.X, gridTemp.postCenter.Y, OptE.X, OptE.Y);

        FindPoint(gridTemp.postCenter, IptS, RKiAts, BKiAts + gridTemp.Rotation);
        FindPoint(gridTemp.postCenter, IptE, RKaAts, BKaAts + gridTemp.Rotation);
        FindPoint(gridTemp.postCenter, OptS, RKaBwh, BKaBwh + gridTemp.Rotation);
        FindPoint(gridTemp.postCenter, OptE, RKiBwh, BKiBwh + gridTemp.Rotation);

        simMgrClient.Converter.ConvertToScreen(IptS.X, IptS.Y, x1, y1);
        simMgrClient.Converter.ConvertToScreen(IptE.X, IptE.Y, x2, y2);
        simMgrClient.Converter.ConvertToScreen(OptS.X, OptS.Y, x3, y3);
        simMgrClient.Converter.ConvertToScreen(OptE.X, OptE.Y, x4, y4);

        rect1 := SelectedOverlayTab.Formula.assignRect(x1, y1);
        rect2 := SelectedOverlayTab.Formula.assignRect(x2, y2);
        rect3 := SelectedOverlayTab.Formula.assignRect(x3, y3);
        rect4 := SelectedOverlayTab.Formula.assignRect(x4, y4);

        rect1.Left    := x1;
        rect1.Top     := Y1;
        rect1.Right   := x3;
        rect1.Bottom  := Y3;

        rect2 := SelectedOverlayTab.Formula.checkXYPosition(rect1.Left, rect1.Top, rect1.Right, rect1.Bottom);

        if ptToArea(rect2, ptPos) then
        begin
          isSelectShape := True;

          FShapeType := ovGrid;
          FShapeId := gridTemp.ShapeId;
          FAction := caEdit;
          edtTablePosLong.Text        := formatDMS_long(gridTemp.postCenter.X);
          edtTablePosLat.Text         := formatDMS_latt(gridTemp.postCenter.Y);
          edtTableColumn.Text         := IntToStr(gridTemp.HCount);
          edtTableRow.Text            := IntToStr(gridTemp.WCount);
          edtTableWidth.Text          := FloatToStr(gridTemp.Width);
          edtTableHeight.Text         := FloatToStr(gridTemp.Height);
          edtTableRotationAngle.Text  := IntToStr(gridTemp.Rotation);
          pnlOutline.Color        := gridTemp.ShapeOutline;

          cbbDashesPen.ItemIndex :=  SetLineType(gridTemp.LineType);
          cbbWeightPen.Text := IntToStr(gridTemp.LineWeight);

          gridTemp.isSelected := true;
          LoadPanelGrid;
          pnlShape.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TPolygonShape then
      begin
        {$REGION ' Polygon Section '}
        polygonTemp := TPolygonShape(mainShapeTemp);

        SetLength(polyPoint, polygonTemp.polyList.Count);

        for j := 0 to polygonTemp.polyList.Count - 1 do
        begin
          point := polygonTemp.polyList.Items[j];

          simMgrClient.Converter.ConvertToScreen(point.X, point.Y, x1, y1);
          polyPoint[j].x := x1;
          polyPoint[j].y := y1;
        end;

        for j := 0 to polygonTemp.polyList.Count - 1 do
        begin
          rect1 := SelectedOverlayTab.Formula.assignRect(polyPoint[j].x, polyPoint[j].y);

          if ptToArea(rect1, ptPos) then
          begin

            lvPolyVertex.Clear;

            ShapeType := ovPolygon;

            for k := 0 to polygonTemp.polyList.Count - 1 do
            begin
              point := polygonTemp.polyList.Items[k];

              with lvPolyVertex.Items.Add do
              begin
                SubItems.Add(formatDMS_long(point.X));
                SubItems.Add(formatDMS_latt(point.Y));
              end;
            end;

            lvPolyVertex.Items.BeginUpdate;
            try
             for k := 0 to lvPolyVertex.Items.Count-1 do
               lvPolyVertex.Items.Item[k].Caption:=IntToStr(k+1);
            finally
              lvPolyVertex.Items.EndUpdate;
            end;
            pnlOutline.Color := polygonTemp.ShapeOutline;

            cbbDashesPen.ItemIndex := SetLineType(polygonTemp.LineType);
            cbbWeightPen.Text := IntToStr(polygonTemp.LineWeight);

            if polygonTemp.BrushStyle = bsClear then
            begin
              SetNoFill(True);
            end
            else
            begin
              SetNoFill(False);
              pnlFill.Color := polygonTemp.ShapeFill;
            end;

            polygonTemp.isSelected := true;
            LoadPanelPolygon;
            pnlShape.BringToFront;

            break;
          end;
        end;
      {$ENDREGION}
      end
      else if mainShapeTemp is TIntelijenShape then
      begin
        {$REGION ' Intelijen Section '}
        IntelijenTemp := TIntelijenShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(IntelijenTemp.postCenter.X, IntelijenTemp.postCenter.Y, x1, y1);
        rect1 := SelectedOverlayTab.Formula.assignRect(x1, y1);

        if ptToArea(rect1, ptPos) then
        begin
           IntelijenTemp.isSelected := True;
           isSelectShape := True;

           if IntelijenTemp.isSelected then
           begin
              FSelectIntelijenShape := IntelijenTemp;
              FSelectLogisticShape := nil;
              FSelectBaseShape := nil;

              FSelectIntelijenShape := IntelijenTemp;
              FShapeType := ovIntelijen;
              FShapeId := IntelijenTemp.ShapeId;
              FAction := caEdit;
              edtLongIntel.Text := formatDMS_long(IntelijenTemp.postCenter.X);
              edtLattIntel.Text := formatDMS_latt(IntelijenTemp.postCenter.Y);
              pnlOutline.Color  := IntelijenTemp.ShapeOutline;

              if IntelijenTemp.ShapeOutline = clBlue  then
              begin
                rbBlue.Checked := True;
                rbRed.Checked := False;
              end
              else
              begin
                rbBlue.Checked := False;
                rbRed.Checked := True;
              end;

              mmoInfo.Clear;
              for k := 0 to IntelijenTemp.InfoList.Count - 1 do
              begin
                 intelDataTemp := IntelijenTemp.InfoList[k];
                 mmoInfo.Lines.Add(intelDataTemp.Info)
              end;

              LoadPanelIntelijen;
              pnlObject.BringToFront;
           end
           else
           begin
              FAction := caAdd;
              grpNone.BringToFront;
              pnlObject.SendToBack;
           end;

        end;

        {$ENDREGION}
      end
      else if mainShapeTemp is TLogisticShape then
      begin
        {$REGION ' Logistic Section '}
        LogisticTemp := TLogisticShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(LogisticTemp.postCenter.X, LogisticTemp.postCenter.Y, x1, y1);
        rect1 := SelectedOverlayTab.Formula.assignRect(x1, y1);

        if ptToArea(rect1, ptPos) then
        begin
          LogisticTemp.isSelected := True;

          isSelectShape := True;

          if LogisticTemp.isSelected then
          begin
            FSelectLogisticShape := LogisticTemp;
            FSelectIntelijenShape := nil;
            FSelectBaseShape := nil;

            FShapeType := ovLogistic;
            FShapeId := LogisticTemp.ShapeId;
            FAction := caEdit;
            edtLogIdentifier.Text := LogisticTemp.Identifier;
            edtLongLog.Text := formatDMS_long(LogisticTemp.postCenter.X);
            edtLattLog.Text := formatDMS_latt(LogisticTemp.postCenter.Y);
            pnlOutline.Color := LogisticTemp.ShapeOutline;

            if LogisticTemp.ShapeOutline = clBlue  then
            begin
              rbBlue.Checked := True;
              rbRed.Checked := False;
            end
            else
            begin
              rbBlue.Checked := False;
              rbRed.Checked := True;
            end;

            lvLogistic.Clear;
            for k := 0 to LogisticTemp.LogisticList.Count - 1 do
            begin
              logDataTemp := LogisticTemp.LogisticList[k];

              with lvLogistic.Items.Add do
              begin
                Caption := logDataTemp.Name;
                SubItems.Add(logDataTemp.Status);
              end;
            end;
            LoadPanelLogistic;
            pnlObject.BringToFront;
          end
          else
          begin
            FAction := caAdd;
            grpNone.BringToFront;
            pnlObject.SendToBack;
          end;
        end;

        {$ENDREGION}
      end
      else if mainShapeTemp is TRadarShape then
      begin
        {$REGION ' Radar Section '}
         RadarTemp := TRadarShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(RadarTemp.postCenter.X, RadarTemp.postCenter.Y, x1, y1);
        rect1 := SelectedOverlayTab.Formula.assignRect(x1, y1);

        if ptToArea(rect1, ptPos) then
        begin
          isSelectShape := True;

          FShapeType := ovRadar;
          FShapeId := RadarTemp.ShapeId;
          FAction := caEdit;
          edtLongRadar.Text := formatDMS_long(RadarTemp.postCenter.X);
          edtLattRadar.Text := formatDMS_latt(RadarTemp.postCenter.Y);
          edtRadius.Text := FloatToStr(RadarTemp.Radius);
          pnlOutline.Color := RadarTemp.ShapeOutline;

          if RadarTemp.ShapeOutline = clBlue  then
          begin
            rbBlue.Checked := True;
            rbRed.Checked := False;
          end
          else
          begin
            rbBlue.Checked := False;
            rbRed.Checked := True;
          end;

          RadarTemp.isSelected := true;
          LoadPanelRadar;
          pnlObject.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TPangkalanShape then
      begin
        {$REGION ' Base Section '}
        BaseTemp := TPangkalanShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(BaseTemp.postCenter.X, BaseTemp.postCenter.Y, x1, y1);
        rect1 := SelectedOverlayTab.Formula.assignRect(x1, y1);

        if ptToArea(rect1, ptPos) then
        begin
          BaseTemp.isSelected := True;
          isSelectShape := True;

          if BaseTemp.isSelected then
          begin
            FSelectBaseShape := BaseTemp;
            FSelectLogisticShape := nil;
            FSelectIntelijenShape := nil;

            FShapeType := ovPangkalan;
            FShapeId := BaseTemp.ShapeId;
            FAction := caEdit;
            edtBaseIdentifier.Text := BaseTemp.Identifier;
            edtLongBase.Text := formatDMS_long(BaseTemp.postCenter.X);
            edtLattBase.Text := formatDMS_latt(BaseTemp.postCenter.Y);
            pnlOutline.Color := BaseTemp.ShapeOutline;

            if BaseTemp.ShapeOutline = clBlue  then
            begin
              rbBlue.Checked := True;
              rbRed.Checked := False;
            end
            else
            begin
              rbBlue.Checked := False;
              rbRed.Checked := True;
            end;

            lvEmbark.Clear;
            for k := 0 to BaseTemp.VehiclesList.Count - 1 do
            begin
              shipDataTemp := BaseTemp.VehiclesList[k];

              if (FIdSelectedEmbark >= 0) and (FIdSelectedEmbark < lvEmbark.Items.Count) then
              begin
                with lvEmbark.Items[FIdSelectedEmbark] do
                begin
                  Caption := shipDataTemp.Name;
                  SubItems[0] := IntToStr(shipDataTemp.Quantity);
                  SubItems[1] := shipDataTemp.Simbol;
                end;
              end
              else
              begin
                while lvEmbark.Items.Count <= FIdSelectedEmbark do
                lvEmbark.Items.Add;

                with lvEmbark.Items[FIdSelectedEmbark] do
                begin
                  Caption := shipDataTemp.Name;
                  SubItems.Add(IntToStr(shipDataTemp.Quantity));
                  SubItems.Add(shipDataTemp.Simbol);
                end;
              end;
            end;

            LoadPanelPangkalan;
            pnlObject.BringToFront;
          end
          else
          begin
            FAction := caAdd;
            grpNone.BringToFront;
            pnlObject.SendToBack;
          end;
        end;

        {$ENDREGION}
      end
      else if mainShapeTemp is TPanahShape then
      begin
        {$REGION ' Arrow Section '}
         ArrowTemp := TPanahShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(ArrowTemp.postCenter.X, ArrowTemp.postCenter.Y, x1, y1);
        rect1 := SelectedOverlayTab.Formula.assignRect(x1, y1);

        if ptToArea(rect1, ptPos) then
        begin
          isSelectShape := True;

          FShapeType := ovPanah;
          FShapeId := ArrowTemp.ShapeId;
          FAction := caEdit;
          edtStartLong.Text := formatDMS_long(ArrowTemp.postCenter.X);
          edtStartLatt.Text := formatDMS_latt(ArrowTemp.postCenter.Y);
          edtEndLong.Text := formatDMS_long(ArrowTemp.postCenter.X);
          edtEndLatt.Text := formatDMS_latt(ArrowTemp.postCenter.Y);
          pnlOutline.Color := ArrowTemp.ShapeOutline;

          if ArrowTemp.ShapeOutline = clBlue  then
          begin
            rbBlue.Checked := True;
            rbRed.Checked := False;
          end
          else
          begin
            rbBlue.Checked := False;
            rbRed.Checked := True;
          end;

          ArrowTemp.isSelected := true;
          LoadPanelPanah;
          pnlObject.BringToFront;

          break;
        end;
        {$ENDREGION}
      end
      else if mainShapeTemp is TPlatformShape then
      begin
        {$REGION ' Platform Section '}
          PlatformTemp := TPlatformShape(mainShapeTemp);

        simMgrClient.Converter.ConvertToScreen(PlatformTemp.postCenter.X, PlatformTemp.postCenter.Y, x1, y1);
        rect1 := SelectedOverlayTab.Formula.checkText(x1, y1, 20, PlatformTemp.simbol);

        if ptToArea(rect1, ptPos) then
        begin
          PlatformTemp.isSelected := True;
          isSelectShape := True;

          FSelectPlatformShape := PlatformTemp;
          FSelectIntelijenShape := nil;
          FSelectBaseShape := nil;
          FSelectLogisticShape := nil;

          FShapeType := ovPlatform;
          FShapeId := PlatformTemp.ShapeId;
          FAction := caEdit;
          edtPlatformIdentifier.Text := PlatformTemp.Identifier;
          edtLongPlatform.Text := formatDMS_long(PlatformTemp.postCenter.X);
          edtLattPlatform.Text := formatDMS_latt(PlatformTemp.postCenter.Y);

          lblTacticalSymbolPlatform.Caption := PlatformTemp.simbol;

          pnlOutline.Color := PlatformTemp.ShapeOutline;

          if PlatformTemp.ShapeOutline = clBlue  then
          begin
            rbBlue.Checked := True;
            rbRed.Checked := False;
          end
          else
          begin
            rbBlue.Checked := False;
            rbRed.Checked := True;
          end;

          PlatformTemp.isSelected := true;
          LoadPanelPlatform;
          pnlObject.BringToFront;

          break;
        end;
        {$ENDREGION}
      end;
    end;

    frmSituationBoard.LoadOverlay(SelectedOverlayTab.IdOverlayTab);
  end
  else
  begin
    IsEditObject := False;
  end;

  if isSelectShape then
  begin
    FSelectedShape := mainShapeTemp;
    Show;
  end;

end;

procedure TfrmOverlayTools.MoveTableShape(OldX, OldY, NewX, NewY: Double);
begin
  if Assigned(FSelectIntelijenShape) then
  begin
    FSelectIntelijenShape.TableProp.X := FSelectIntelijenShape.TableProp.X + (NewX - OldX);
    FSelectIntelijenShape.TableProp.Y := FSelectIntelijenShape.TableProp.Y + (NewY - OldY);
  end
  else if Assigned(FSelectLogisticShape) then
  begin
    FSelectLogisticShape.TableProp.X := FSelectLogisticShape.TableProp.X + (NewX - OldX);
    FSelectLogisticShape.TableProp.Y := FSelectLogisticShape.TableProp.Y + (NewY - OldY);
  end
  else if Assigned(FSelectBaseShape) then
  begin
    FSelectBaseShape.TableProp.X := FSelectBaseShape.TableProp.X + (NewX - OldX);
    FSelectBaseShape.TableProp.Y := FSelectBaseShape.TableProp.Y + (NewY - OldY);
  end
  else if Assigned(FSelectPlatformShape) then
  begin
    FSelectPlatformShape.postCenter.X := FSelectPlatformShape.postCenter.X + (NewX - OldX);
    FSelectPlatformShape.postCenter.Y := FSelectPlatformShape.postCenter.Y + (NewY - OldY);

    edtLattPlatform.Text := formatDMS_latt(FSelectPlatformShape.postCenter.Y);
    edtLongPlatform.Text := formatDMS_long(FSelectPlatformShape.postCenter.X);
  end;

  frmSituationBoard.Map1.Repaint;
end;

procedure TfrmOverlayTools.SetNoFill(val: Boolean);
begin
  if val then
  begin
    isNoFill := True;
    pnlFill.Caption := 'No Fill';
    pnlFill.Color := $00383534;
  end
  else
  begin
    isNoFill := False;
    pnlFill.Caption := '';
    pnlFill.Color := $00383534;
  end;
end;

procedure TfrmOverlayTools.SetPosition(mx, my: Double);
begin
  case FTagTombolPosition of
    0:
      begin
        edtTextPosLAt.Text := formatDMS_latt(my);
        edtTextPosLong.Text := formatDMS_long(mx);
      end;
    1:
      begin
        edtLineStartPosLat.Text := formatDMS_latt(my);
        edtLineStartPosLong.Text := formatDMS_long(mx);
      end;
    2:
      begin
        edtLineEndPosLat.Text := formatDMS_latt(my);
        edtLineEndPosLong.Text := formatDMS_long(mx);
      end;
    3:
      begin
        edtRectStartPosLat.Text := formatDMS_latt(my);
        edtRectStartPosLong.Text := formatDMS_long(mx);
      end;
    4:
      begin
        edtRectEndPosLat.Text := formatDMS_latt(my);
        edtRectEndPosLong.Text := formatDMS_long(mx);
      end;
    5:
      begin
        edtCirclePosLat.Text := formatDMS_latt(my);
        edtCirclePosLong.Text := formatDMS_long(mx);
      end;
    6:
      begin
        edtEllipsePosLat.Text := formatDMS_latt(my);
        edtEllipsePosLong.Text := formatDMS_long(mx);
      end;
    7:
      begin
        edtArcPosLat.Text := formatDMS_latt(my);
        edtArcPosLong.Text := formatDMS_long(mx);
      end;
    8:
      begin
        edtSectorPosLat.Text := formatDMS_latt(my);
        edtSectorPosLong.Text := formatDMS_long(mx);
      end;
    9:
      begin
        edtTablePosLat.Text := formatDMS_latt(my);
        edtTablePosLong.Text := formatDMS_long(mx);
      end;
    10:
      begin
        edtPolyPosLat.Text := formatDMS_latt(my);
        edtPolyPosLong.Text := formatDMS_long(mx);
      end;
    11:
      begin
        edtLattIntel.Text := formatDMS_latt(my);
        edtLongIntel.Text := formatDMS_long(mx);
      end;
    12:
      begin
        edtLattRadar.Text := formatDMS_latt(my);
        edtLongRadar.Text := formatDMS_long(mx);
      end;
    13:
      begin
        edtStartLatt.Text := formatDMS_latt(my);
        edtStartLong.Text := formatDMS_long(mx);
      end;
    14:
      begin
        edtEndLatt.Text := formatDMS_latt(my);
        edtEndLong.Text := formatDMS_long(mx);
      end;
    15:
      begin
        edtLattLog.Text := formatDMS_latt(my);
        edtLongLog.Text := formatDMS_long(mx);
      end;
    16:
      begin
        edtLattBase.Text := formatDMS_latt(my);
        edtLongBase.Text := formatDMS_long(mx);
      end;
    17:
      begin
        edtLattPlatform.Text := formatDMS_latt(my);
        edtLongPlatform.Text := formatDMS_long(mx);
      end;
  end;
  show
end;

procedure TfrmOverlayTools.btnHandleShapePosition(Sender: TObject);
begin
  if (Sender is TSpeedButton) then
  begin
    FTagTombolPosition := TSpeedButton(Sender).Tag;

    if FTagTombolPosition = 10 then
    begin
//      if not SpeedButton10.Down then
//        frmSituationBoard.Map1.CurrentTool := mtSelectObject
//      else
//        frmSituationBoard.Map1.CurrentTool := mtAddOverlay;
    end
    else
    begin
      frmSituationBoard.MapCursor := mcAdd;
//      frmSituationBoard.Map1.MousePointer := miCrossCursor;
    end;
  end;
end;

procedure TfrmOverlayTools.btnLogistichandle(Sender: TObject);
begin
  if ((edtNameLogistic.Text = '') or (cbbStatusLogistic.Text = '')) and
     (TSpeedButton(Sender).Tag <> 4) then
  begin
    ShowMessage('Incomplete data input');
    Exit;
  end;

  case TSpeedButton(Sender).Tag of
    1: {Add}
    begin
      with lvLogistic.Items.Add do
      begin
        Caption := edtNameLogistic.Text;
        SubItems.Add(cbbStatusLogistic.Text);
      end;
    end;
    2:{Edit}
    begin
      with lvLogistic.Items[FIdSelectedLogistic] do
      begin
        Caption := edtNameLogistic.Text;
        SubItems[0] := cbbStatusLogistic.Text;
      end;

    end;
    3:{Delete}
    begin
      lvLogistic.Items.Delete(FIdSelectedLogistic);
    end;
    4:{Clear}
    begin
      lvLogistic.Items.Clear;
    end;
  end;

  RefreshLogistic;
end;

procedure TfrmOverlayTools.btnPlatformHandle(Sender: TObject);
begin
  if (edtPlatform.Text = '') or (edtQty.Text = '') and
     (TSpeedButton(Sender).Tag <> 4) then
  begin
    ShowMessage('Incomplete data input');
    Exit;
  end;

  case TSpeedButton(Sender).Tag of
    1: {Add}
    begin
      with lvEmbark.Items.Add do
      begin
        Caption := edtPlatform.Text;
        SubItems.Add(edtQty.Text);
        SubItems.Add(lblSymbolTaktis.Caption);
      end;
    end;
    2:{Edit}
    begin
      with lvEmbark.Items[FIdSelectedEmbark] do
      begin
        Caption := edtPlatform.Text;
        SubItems[0] := edtQty.Text;
        SubItems[1] := lblSymbolTaktis.Caption;
      end;
    end;
    3:{Delete}
    begin
      lvEmbark.Items.Delete(FIdSelectedEmbark);
    end;
    4:{Clear}
    begin
      lvEmbark.Items.Clear;
    end;
  end;
  RefreshEmbark;
end;

end.
