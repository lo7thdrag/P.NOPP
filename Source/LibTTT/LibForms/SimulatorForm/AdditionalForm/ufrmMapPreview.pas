unit ufrmMapPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.OleCtrls, MapXLib_TLB,
  Vcl.ExtCtrls,

  uClassData, uCoordConvertor, uLibSetting ;

type
  E_MapCursor = (mcSelect, mcMultiSelect, mcZoom, mcGameCenter, mcPan);

  TfrmMapPreview = class(TForm)
    pnlMap: TPanel;
    ENCMap: TMap;
    pnlToolBar: TPanel;
    pnlAlignToolBar: TPanel;
    ToolBar1: TToolBar;
    btnDecrease: TToolButton;
    cbSetScale: TComboBox;
    btnIncrease: TToolButton;
    btnSelect: TToolButton;
    btnCenterGame: TToolButton;
    btnZoom: TToolButton;
    btnPan: TToolButton;
    ImageList1: TImageList;
    btnout: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDecreaseClick(Sender: TObject);
    procedure cbSetScaleChange(Sender: TObject);
    procedure btnIncreaseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnCenterGameClick(Sender: TObject);
    procedure btnZoomClick(Sender: TObject);
    procedure btnPanClick(Sender: TObject);
    procedure btnoutclick(Sender: TObject);

  private
    FSelectedGameArea : TGame_Area_Definition;

    FCanvas: TCanvas;
    FLyrDraw: CMapXLayer;
    FConverter: TCoordConverter;
    FMapCursor : E_MapCursor;

  public
    procedure LoadMap(Geoset: String);

    property SelectedGameArea : TGame_Area_Definition read FSelectedGameArea write FSelectedGameArea;

  end;

var
  frmMapPreview: TfrmMapPreview;

implementation

{$R *.dfm}


procedure InitOleVariant(var TheVar: OleVariant);
begin
  TVarData(TheVar).vType := varError;
  TVarData(TheVar).vError := DISP_E_PARAMNOTFOUND;
end;


procedure TfrmMapPreview.btnCenterGameClick(Sender: TObject);
begin
  FMapCursor := mcGameCenter;

  ENCMap.CurrentTool := miArrowTool;
  ENCMap.MousePointer := miCrossCursor;
end;

procedure TfrmMapPreview.btnDecreaseClick(Sender: TObject);
begin
  if cbSetScale.ItemIndex = 16 then
    Exit;

  cbSetScale.ItemIndex := cbSetScale.ItemIndex + 1;
  cbSetScaleChange(cbSetScale);
end;

procedure TfrmMapPreview.btnIncreaseClick(Sender: TObject);
begin
  if cbSetScale.ItemIndex = 0 then
    Exit;

  cbSetScale.ItemIndex := cbSetScale.ItemIndex - 1;
  cbSetScaleChange(cbSetScale);
end;

procedure TfrmMapPreview.btnoutclick(Sender: TObject);
begin
    btnZoom.Down := False;

  btnout.Down := not btnout.Down;
  btnPan.Down := false;

  FMapCursor := mcSelect;

  ENCMap.CurrentTool := miZoomoutTool;
  ENCMap.MousePointer := miZoomoutCursor;

  btnout.ImageIndex := 8;
end;

procedure TfrmMapPreview.btnPanClick(Sender: TObject);
begin
  FMapCursor := mcPan;

  ENCMap.CurrentTool := miPanTool;
  ENCMap.MousePointer := miPanCursor;
end;

procedure TfrmMapPreview.btnSelectClick(Sender: TObject);
begin
  FMapCursor := mcSelect;

  ENCmap.CurrentTool := miSelectTool;
  ENCmap.MousePointer := miDefaultCursor;
end;

procedure TfrmMapPreview.btnZoomClick(Sender: TObject);
begin
  FMapCursor := mcZoom;

  ENCMap.CurrentTool := miZoomInTool;
  ENCMap.MousePointer := miZoomInCursor;
end;

procedure TfrmMapPreview.cbSetScaleChange(Sender: TObject);
var
  z : Double;
  s : string;
begin
  ENCMap.OnMapViewChanged := nil;

  if cbSetScale.ItemIndex < 0  then Exit;

  if (cbSetScale.ItemIndex <= 500) then
  begin
   s := cbSetScale.Items[cbSetScale.ItemIndex];
   try
     z := StrToFloat(s);
     ENCMap.ZoomTo(z, ENCMap.CenterX, ENCMap.CenterY);
   finally

   end;
  end
  else cbSetScale.ItemIndex := cbSetScale.ItemIndex -1 ;
end;

procedure TfrmMapPreview.FormCreate(Sender: TObject);
begin
  FCanvas := TCanvas.Create;
  FConverter := TCoordConverter.Create;
end;

procedure TfrmMapPreview.FormResize(Sender: TObject);
begin
  WindowState := wsMaximized;
  pnlAlignToolBar.Width := round((pnlToolBar.Width - 433) / 2);
end;

procedure TfrmMapPreview.FormShow(Sender: TObject);
var
  aGeoset, ENCGeoset, VektorGeoset, GameAreaName: string;
begin
  LoadMap(vGameAreaSetting.MapGSTGame + '\' + SelectedGameArea.FData.Game_Area_Identifier + '\' + SelectedGameArea.FData.Game_Area_Identifier + '.gst');

  FConverter.FMap := ENCMap;

  cbSetScale.ItemIndex := cbSetScale.Items.Count - 1;
  cbSetScaleChange(Sender);

  cbSetScale.Text := cbSetScale.Items.Strings[cbSetScale.ItemIndex];
  btnSelect.OnClick(btnSelect);

  cbSetScaleChange(Sender);
end;

procedure TfrmMapPreview.LoadMap(Geoset: String);
var
  i: Integer;
  z: OleVariant;
  mInfo: CMapXLayerInfo;
begin
  if ENCMap = nil then
    Exit;

  InitOleVariant(z);
  ENCMap.Layers.RemoveAll;

  ENCMap.Geoset := Geoset;

  if Geoset <> '' then
  begin
    for i := 1 to ENCMap.Layers.Count do
    begin
      ENCMap.Layers.Item(i).Selectable := false;
      ENCMap.Layers.Item(i).Editable := false;
    end;

    mInfo := CoLayerInfo.Create;
    mInfo.type_ := miLayerInfoTypeUserDraw;
    mInfo.AddParameter('Name', 'LYR_DRAW');
    FLyrDraw := ENCMap.Layers.Add(mInfo, 1);

    ENCMap.Layers.AnimationLayer := FLyrDraw;
    ENCMap.MapUnit := miUnitNauticalMile;
  end;

  ENCMap.BackColor := RGB(192, 224, 255);
end;

end.
