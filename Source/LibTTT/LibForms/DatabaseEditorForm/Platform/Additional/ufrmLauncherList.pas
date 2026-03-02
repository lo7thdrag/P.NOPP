unit ufrmLauncherList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls{,newClassASTT}, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  {uDBAsset_Weapon,} uSimContainers;

type
  E_LauncherOwner = (loMissile, loTorpedo);

  TfrmLauncherList = class(TForm)
    lbAllLauncher: TListBox;
    ImgBackground: TImage;
    btnNew: TImage;
    btnEdit: TImage;
    btnDelete: TImage;
    lblPlatform: TLabel;
    lblClose: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lstLauncherClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);

  private
    FLauncherOwner : E_LauncherOwner;
    FSelectedWeapon : TObject;

    FLauncherList : TList;
//    FSelectedLauncher : TFitted_Weap_Launcher_On_Board;

    procedure UpdateLauncherList;

  public
    AfterClose : Boolean; {Penanda ketika yg dipilih btn cancel, btn Cancel di summary menyala}
    property LauncherOwner : E_LauncherOwner read FLauncherOwner write FLauncherOwner;
    property SelectedWeapon : TObject read FSelectedWeapon write FSelectedWeapon;
  end;

var
  frmLauncherList: TfrmLauncherList;

implementation

uses
  uDataModule, ufrmMissileLauncher, ufrmTorpedoLauncher;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmLauncherList.FormCreate(Sender: TObject);
begin
  FLauncherList := TList.Create;
end;

procedure TfrmLauncherList.FormShow(Sender: TObject);
begin
  UpdateLauncherList;
end;

procedure TfrmLauncherList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FLauncherList);
//  Action := cafree;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmLauncherList.btnNewClick(Sender: TObject);
begin
//  case FLauncherOwner of
//    loMissile:
//    begin
//      frmMissileLauncher := TfrmMissileLauncher.Create(Self);
//      try
//        with frmMissileLauncher do
//        begin
//          SelectedMissile := TMissile_On_Board(FSelectedWeapon);
//          SelectedLauncher := TFitted_Weap_Launcher_On_Board.Create;
//          SelectedLauncher.FData.Launcher_Type := 1;
//          ShowModal;
//          SelectedLauncher.Free;
//          UpdateLauncherList;
//        end;
//        AfterClose := frmMissileLauncher.AfterClose;
//      finally
//        frmMissileLauncher.Free;
//      end;
//    end;
//    loTorpedo:
//    begin
//      frmTorpedoLauncher := TfrmTorpedoLauncher.Create(Self);
//      try
//        with frmTorpedoLauncher do
//        begin
//          SelectedTorpedo := TTorpedo_On_Board(FSelectedWeapon);
//          SelectedLauncher := TFitted_Weap_Launcher_On_Board.Create;
//          SelectedLauncher.FData.Launcher_Type := 1;
//          ShowModal;
//          SelectedLauncher.Free;
//          UpdateLauncherList;
//        end;
//        AfterClose := frmTorpedoLauncher.AfterClose;
//      finally
//        frmTorpedoLauncher.Free;
//      end;
//    end;
//  end;
end;

procedure TfrmLauncherList.btnEditClick(Sender: TObject);
begin
//  if lbAllLauncher.ItemIndex = -1 then
//    Exit;
//
//  case FLauncherOwner of
//    loMissile:
//    begin
//      frmMissileLauncher := TfrmMissileLauncher.Create(Self);
//      try
//        with frmMissileLauncher do
//        begin
//          SelectedMissile := TMissile_On_Board(FSelectedWeapon);
//          SelectedLauncher := FSelectedLauncher;
//          ShowModal;
//          UpdateLauncherList;
//        end;
//        AfterClose := frmMissileLauncher.AfterClose;
//      finally
//        frmMissileLauncher.Free;
//      end;
//    end;
//    loTorpedo:
//    begin
//      frmTorpedoLauncher := TfrmTorpedoLauncher.Create(Self);
//      try
//        with frmTorpedoLauncher do
//        begin
//          SelectedTorpedo := TTorpedo_On_Board(FSelectedWeapon);
//          SelectedLauncher := FSelectedLauncher;
//          ShowModal;
//          UpdateLauncherList;
//        end;
//        AfterClose := frmTorpedoLauncher.AfterClose;
//      finally
//        frmTorpedoLauncher.Free;
//      end;
//    end;
//  end;
end;

procedure TfrmLauncherList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLauncherList.btnRemoveClick(Sender: TObject);
var
  warning : Integer;

begin
//  if lbAllLauncher.ItemIndex = -1 then
//  begin
//    ShowMessage('Select Launcher Data ... !');
//    Exit;
//  end;
//
//  warning := MessageDlg('Are you sure to delete this item?', mtConfirmation,
//    mbOKCancel, 0);
//
//  if warning = mrOK then
//  begin
//    with FSelectedLauncher.FData do
//      dmTTT.DeleteFittedWeaponLauncherOnBoard(Fitted_Weap_Index, Launcher_Type);
//  end;
//
//  AfterClose := True;
//  UpdateLauncherList;
end;

procedure TfrmLauncherList.lstLauncherClick(Sender: TObject);
begin
//  if lbAllLauncher.ItemIndex = -1 then
//    Exit;
//
//  FSelectedLauncher := TFitted_Weap_Launcher_On_Board(lbAllLauncher.Items.Objects[lbAllLauncher.ItemIndex]);
end;

procedure TfrmLauncherList.UpdateLauncherList;
var
  i : Integer;
//  launcher : TFitted_Weap_Launcher_On_Board;
begin
//  lbAllLauncher.Items.Clear;
//
//  case FLauncherOwner of
//    loMissile: dmTTT.GetFittedWeaponLauncherOnBoard(TMissile_On_Board(FSelectedWeapon).FData.Fitted_Weap_Index,FLauncherList);
//    loTorpedo: dmTTT.GetFittedWeaponLauncherOnBoard(TTorpedo_On_Board(FSelectedWeapon).FData.Fitted_Weap_Index,FLauncherList);
//  end;
//
//  for i := 0 to FLauncherList.Count - 1 do
//  begin
//    launcher := FLauncherList.Items[i];
//
//    with launcher.FData do
//    begin
//      if Launcher_Type <= 8 then
//        lbAllLauncher.Items.AddObject('Launcher ' + IntToStr(Launcher_Type), launcher)
//      else
//      begin
//        case FLauncherOwner of
//          loMissile: lbAllLauncher.Items.AddObject('Missile Cell ' + IntToStr(Launcher_Type - 8), launcher);
//          loTorpedo: lbAllLauncher.Items.AddObject('Torpedo Tube ' + IntToStr(Launcher_Type - 8), launcher);
//        end;
//      end;
//    end;
//  end;
end;

{$ENDREGION}

end.
