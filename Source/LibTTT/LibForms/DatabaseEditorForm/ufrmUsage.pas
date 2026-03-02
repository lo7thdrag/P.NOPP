unit ufrmUsage;

interface

uses
  {Delphi Uses}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls,

  {Project Uses}
  uDataModule, uConstantaData, uDBAsset_Vehicle, uDBAsset_Weapon, uDBAsset_Sensor, uDBAsset_Countermeasure;

type
  TfrmUsage = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ListView1: TListView;
    btnOk: TButton;
    btnPrint: TButton;
    PrintDialog1: TPrintDialog;
    lbl1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);

  private

  public

    uList1 : Tlist;

    AssetIndex : integer;
    AssetType : TStorageType;
    AssetTitle, AssetName: string;

    procedure getDataUsage;
    procedure showDataUsage;
  end;

var
  frmUsage: TfrmUsage;

implementation

{$R *.dfm}

procedure TfrmUsage.btnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsage.FormCreate(Sender: TObject);
begin
  uList1 := TList.Create;

end;

procedure TfrmUsage.FormShow(Sender: TObject);
begin
  uList1.Clear;

  getDataUsage;
end;

procedure TfrmUsage.getDataUsage;
begin

  case TStorageType(AssetType) of

    {$REGION ' Weapon '}
    stMissile :
    begin
      dmINWO.GetFittedWeaponAtVehicleOnBoard (Integer(stMissile), AssetIndex, uList1);
    end;
    stTorpedo:
    begin
      dmINWO.GetFittedWeaponAtVehicleOnBoard  (Integer(stTorpedo), AssetIndex, uList1);
//      dmINWO.GetTorpedoAtMissileDef (UId,uList2);
    end;
    stGun:
    begin
      dmINWO.GetPointEffectAtVehicleOnBoard(Integer(stGun),AssetIndex,uList1);
    end;
    stBomb:
    begin
      dmINWO.GetPointEffectAtVehicleOnBoard(Integer(stBomb),AssetIndex,uList1);
    end;
    stMine:
    begin
      dmINWO.GetFittedWeaponAtVehicleOnBoard  (Integer(stMine), AssetIndex, uList1);
    end;
    {$ENDREGION}

    {$REGION ' Sensor '}
    stRadar: dmINWO.GetRadarAtVehicleOnBoard (AssetIndex,uList1);
    stSonar: dmINWO.GetSonarAtVehicleOnBoard (AssetIndex,uList1);
    stEsm: dmINWO.GetESMAtVehicleOnBoard(AssetIndex,uList1);
    stMad: dmINWO.GetMADAtVehicleOnBoard(AssetIndex,uList1);
    stEod: dmINWO.GetEODAtVehicleOnBoard(AssetIndex,uList1);
    stSonobuoy: dmINWO.GetSonobuoyAtVehicleOnBoard(AssetIndex,uList1);
    {$ENDREGION}

    {$REGION ' Countermeasure '}
    stAirBubble: dmINWO.GetAirBubbleAtVehicleOnBoard(AssetIndex,uList1);
    stChaff: dmINWO.GetChaffAtVehicleOnBoard(AssetIndex,uList1);
    stAcousticDecoy: dmINWO.GetAcousticDecoyAtVehicleOnBoard(AssetIndex,uList1);
    stInfraredDecoy: dmINWO.GetInfraredDecoyAtVehicleOnBoard(AssetIndex,uList1);
    stFloatingDecoy: dmINWO.GetFloatingDecoyAtVehicleOnBoard(AssetIndex,uList1);
    stTowedDecoy: dmINWO.GetTowedDecoyAtVehicleOnBoard (AssetIndex,uList1);
    stDefensiveJammer: dmINWO.GetDefensiveJammerAtVehicleOnBoard(AssetIndex,uList1);
    stRadarNoiseJammer: dmINWO.GetRadarNoiseJammerAtVehicleOnBoard(AssetIndex,uList1);
    {$ENDREGION}

  end;

  showDataUsage;
end;

procedure TfrmUsage.showDataUsage;
var
  ListItem: TListItem;
  i : Integer;

begin
  ListView1.Clear;

  {$REGION ' Print List 1 '}
  for I := 0 to uList1.Count - 1 do
  begin
    ListItem := ListView1.Items.Add;
    ListItem.Caption := AssetTitle;

    case TStorageType(AssetType) of

      {$REGION ' Weapon '}
      stMissile, stTorpedo, stMine :
      begin
        with TMissile_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stGun, stBomb:
      begin
        with TGun_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      {$ENDREGION}

      {$REGION ' Sensor '}
      stRadar:
      begin
        with TRadar_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stSonar:
      begin
        with TSonar_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stEsm:
      begin
        with TESM_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stMad:
      begin
        with TMAD_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stEod:
      begin
        with TEOD_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stSonobuoy:
      begin
        with TSonobuoy_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      {$ENDREGION}

      {$REGION ' Countermeasure '}
      stChaff:
      begin
        with TChaff_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stAirBubble:
      begin
        with TAir_Bubble_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stAcousticDecoy:
      begin
        with TAcoustic_Decoy_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stInfraredDecoy:
      begin
        with TInfrared_Decoy_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stFloatingDecoy:
      begin
        with TFloating_Decoy_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stTowedDecoy:
      begin
        with TTowed_Decoy_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stDefensiveJammer:
      begin
        with TDefensive_Jammer_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      stRadarNoiseJammer:
      begin
        with TRadar_Noise_Jammer_On_Board(uList1[i]) do
        begin
          ListItem.SubItems.Add('Class Name : '+ FData.Vehicle_Identifier);
          ListItem.SubItems.Add('Mount Name : ' + FData.Instance_Identifier);
        end;
      end;
      {$ENDREGION}

    end;
  end;
  {$ENDREGION}

end;

end.
