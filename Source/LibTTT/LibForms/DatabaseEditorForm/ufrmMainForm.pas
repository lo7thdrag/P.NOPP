unit ufrmMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.jpeg, ufrmAvailableUserRole, ufrmAvailablePlatform, ufrmAvailableTacticalSyimbol, ufrmAvailableGameArea,
  ufrmShortcutAOTC;

type
  TfrmMainForm = class(TForm)
    pnlHeader: TPanel;
    pnlLeft: TPanel;
    imgResources: TImage;
    imgQuit: TImage;
    imgLeftBackground: TImage;
    pnlRight: TPanel;
    imgRightBackground: TImage;
    lblPlatform: TLabel;
    lblGameArea: TLabel;
    lblTacticalSymbol: TLabel;
    lblSubMenu4: TLabel;
    lblSubMenu5: TLabel;
    Timer1: TTimer;
    lblPRINCE: TLabel;
    imgHeaderBackground: TImage;
    imgServices: TImage;
    lblSubMenu6: TLabel;
    btnResources: TImage;
    btnServices: TImage;
    btnQuit: TImage;
    pnlMainRight: TPanel;
    pnlResource: TPanel;
    Image4: TImage;
    pnlServices: TPanel;
    Image5: TImage;
    Label5: TLabel;
    Label6: TLabel;
    pnlLogo: TPanel;
    Image6: TImage;
    lblUserRole: TLabel;
    Image1: TImage;
    lblJanganDipencet: TLabel;

    procedure FormShow(Sender: TObject);

    procedure btnResourcesClick(Sender: TObject);
    procedure btnShutdownClick(Sender: TObject);
    procedure btnServicesClick(Sender: TObject);

    procedure ImgLoginClick(Sender: TObject);

    procedure IconMenuMouseEnter(Sender: TObject);
    procedure IconMenuMouseLeave(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlLogoClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure lblUserRoleClick(Sender: TObject);
    procedure lblTacticalSymbolClick(Sender: TObject);
    procedure lblGameAreaClick(Sender: TObject);
    procedure lblPlatformClick(Sender: TObject);
    procedure lblJangandipencetClick(Sender: TObject);

  private
    isShutdown : Boolean;
    isLogin : Boolean;
    iconName : string;
    filePath, imgChoice : string;
    FpanelKlik : Integer; {1: btnScenario; 2: btnResources; 3: btnServices; 4: btnQuit}

    procedure IconLoad;
    procedure InitPosition;

  public
    { Public declarations }
  end;

var
  frmMainForm: TfrmMainForm;

implementation


//  ufrmScenario;//, uFrmUtility, uFrmExercise, uFrmExit, ufrmNewAdminMainForm;

{$R *.dfm}

{$Region ' Form Handle '}

procedure TfrmMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMainForm.FormShow(Sender: TObject);
begin
  InitPosition;
//  self.BorderStyle := bsNone;
//  self.Width := 1300;//1485;
//  self.Height := 700;//800;
end;

{$ENDREGION}

{$Region ' Button Handle '}
procedure TfrmMainForm.btnResourcesClick(Sender: TObject);
begin
  pnlResource.BringToFront;
  pnlLogo.BringToFront;

  InitPosition;
  FpanelKlik := 1;
  Timer1.Enabled := True;
end;

procedure TfrmMainForm.btnServicesClick(Sender: TObject);
begin
  pnlServices.BringToFront;
  pnlLogo.BringToFront;

  InitPosition;
  FpanelKlik := 2;
  Timer1.Enabled := True;
end;

procedure TfrmMainForm.ImgLoginClick(Sender: TObject);
begin
//  with frmLogin do
//  begin
//    ShowModal;
//    isLogin := CloseState;
//  end;
//
//  if isLogin then
//  begin
//    Self.Hide;
//
//    frmNewAdminMainForm := TfrmNewAdminMainForm.Create(Self);
//    try
//      frmNewAdminMainForm.ShowModal;
//    finally
//      frmNewAdminMainForm.Free;
//    end;
//
//    Self.Show;
//  end;
end;

procedure TfrmMainForm.InitPosition;
begin
  imgResources.Top := 62;
  imgServices.Top := 211;
  imgQuit.Top := 360;

  btnResources.Top := 145;
  btnServices.Top := 292;
  btnQuit.Top := 443;

  lblPlatform.Visible := False;
  lblGameArea.Visible := False;
  lblTacticalSymbol.Visible := False;
  lblUserRole.Visible := False;
  lblSubMenu4.Visible := False;
  lblSubMenu5.Visible := False;
  lblSubMenu6.Visible := False;
end;

procedure TfrmMainForm.lblGameAreaClick(Sender: TObject);
begin

  frmAvailableGameArea := TfrmAvailableGameArea.Create(Self);

  try
    frmAvailableGameArea.ShowModal;
  finally
    frmAvailableGameArea.Free
  end;


end;

procedure TfrmMainForm.lblJangandipencetClick(Sender: TObject);
begin
  frmShortcutAOTC := TfrmShortcutAOTC.Create(Self);

  try
    frmShortcutAOTC.ShowModal;
  finally
    frmShortcutAOTC.Free;
  end;

end;

procedure TfrmMainForm.lblPlatformClick(Sender: TObject);
begin
 frmAvailablePlatform := TfrmAvailablePlatform.Create(Self);

  try
    frmAvailablePlatform.ShowModal;
  finally
    frmAvailablePlatform.Free
  end;

end;

procedure TfrmMainForm.lblTacticalSymbolClick(Sender: TObject);
begin
  frmAvailableTacticalSymbol := TfrmAvailableTacticalSymbol.Create(Self);

  try
    frmAvailableTacticalSymbol.ShowModal;
  finally
    frmAvailableTacticalSymbol.Free
  end;

end;

procedure TfrmMainForm.lblUserRoleClick(Sender: TObject);
begin
  frmAvailableUserRole := TfrmAvailableUserRole.Create(Self);

  try
    frmAvailableUserRole.ShowModal;
  finally
    frmAvailableUserRole.Free
  end;
end;

procedure TfrmMainForm.pnlLogoClick(Sender: TObject);
begin
  InitPosition;

  pnlMainRight.BringToFront;
  pnlLogo.BringToFront;
end;

procedure TfrmMainForm.Timer1Timer(Sender: TObject);
begin
  case FpanelKlik of
    1:
    begin
      if imgServices.Top < 333 then
      begin
        imgServices.Top := imgServices.Top + 5;
        imgQuit.Top := imgQuit.Top + 5;

        btnServices.Top := btnServices.Top + 5;
        btnQuit.Top := btnQuit.Top + 5;
      end
      else
      begin
        lblPlatform.Visible := True;
        lblGameArea.Visible := True;
        lblTacticalSymbol.Visible := True;
        lblUserRole.Visible := True;
        Timer1.Enabled := False;
      end;

      lblSubMenu4.Visible := False;
      lblSubMenu5.Visible := False;
      lblSubMenu6.Visible := False;
    end;
    2:
    begin
      if imgQuit.Top < 439 then
      begin
        imgQuit.Top := imgQuit.Top + 5;

        btnQuit.Top := btnQuit.Top + 5;
      end
      else
      begin
        lblSubMenu4.Visible := True;
        lblSubMenu5.Visible := True;
        lblSubMenu6.Visible := True;
        Timer1.Enabled := False;
      end;

      lblPlatform.Visible := False;
      lblGameArea.Visible := False;
      lblTacticalSymbol.Visible := False;
      lblUserRole.Visible := False;
    end;
  end;
end;

procedure TfrmMainForm.btnShutdownClick(Sender: TObject);
begin
  Close;
end;

{$ENDREGION}

{$Region ' Button Hover Handle '}

procedure TfrmMainForm.IconMenuMouseEnter(Sender: TObject);
begin
  iconName := TImage(sender).Name;
  filePath := 'data\Image DBEditor\Interface\Background\';
  imgChoice := '_Select.png';

  IconLoad;
end;

procedure TfrmMainForm.IconMenuMouseLeave(Sender: TObject);
begin
  iconName := TImage(sender).Name;
  filePath := 'data\Image DBEditor\Interface\Background\';
  imgChoice := '.png';

  IconLoad;
end;

procedure TfrmMainForm.IconLoad;
begin
  if (iconName = 'btnResources') then
  begin
    imgResources.Picture.LoadFromFile(filePath + 'btnResources' + imgChoice);
  end
  else if (iconName = 'btnServices') then
  begin
    imgServices.Picture.LoadFromFile(filePath + 'btnServices' + imgChoice);
  end
  else if (iconName = 'btnQuit') then
  begin
    imgQuit.Picture.LoadFromFile(filePath + 'btnQuit' + imgChoice);
  end;
end;
{$ENDREGION}

end.
