unit ufrmSummaryPlatform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AdvCombo,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmSummaryPlatform = class(TForm)
    lblClass: TLabel;
    EdtClass: TEdit;
    TbsGeneral: TTabSheet;
    TbsModel: TTabSheet;
    TbsPhysical: TTabSheet;
    TbsCharacteristic: TTabSheet;
    TbsModifier: TTabSheet;
    TbsAssets: TTabSheet;
    TbsPeriscope: TTabSheet;
    TbsNotes: TTabSheet;
    PgcSummaryPlatform: TPageControl;
    Label1: TLabel;
    btnDelete: TImage;
    btnEdit: TImage;
    btnAdd: TImage;
    GrpCommunications: TGroupBox;
    ChkHfLink: TCheckBox;
    ChkHfVoice: TCheckBox;
    ChkHfMessage: TCheckBox;
    ChkUhfLink: TCheckBox;
    ChkUhfVhfVoice: TCheckBox;
    ChkUhfMessage: TCheckBox;
    ChkSatcomMessage: TCheckBox;
    ChkSatcomVoice: TCheckBox;
    ChkUwt: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    AdvCategoryGeneral: TAdvComboBox;
    AdvTypeGeneral: TAdvComboBox;
    AdvDetectabilityTypeGeneral: TAdvComboBox;
    Label6: TLabel;
    Label7: TLabel;
    EdtAntennaHeigthAboveWater: TEdit;
    EdtMaximumCommunication: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    GrpDamageSustainability: TGroupBox;
    TbDamageSustainability: TTrackBar;
    EdtDamageSustainability: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    GrpCapabilities: TGroupBox;
    chkNavigationLight: TCheckBox;
    ChkBarrierChaff: TCheckBox;
    AdvDomainGeneral: TAdvComboBox;
    EdtAntennaHeight: TEdit;
    btnOk: TButton;
    BtnApply: TButton;
    BtnCancel: TButton;
    lstSummaryPlatformGeneral: TListBox;
    GroupBox1: TGroupBox;
    ImgDefaultModel: TImage;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    AdvTacticalSymbol: TAdvComboBox;
    edtFontIDTacticalSymbol: TEdit;
    edtModelIDTacticalSyimbol: TEdit;
    Label26: TLabel;
    Edit1: TEdit;
    Label27: TLabel;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    btnTacticalSyimbolModel: TButton;
    btnTacticalSyimbolFont: TButton;
    GroupBox5: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtRadarFront: TEdit;
    edtRadarSide: TEdit;
    advRadarFront: TAdvComboBox;
    advRadarSide: TAdvComboBox;
    Label31: TLabel;
    Label32: TLabel;
    EdtAcousticFront: TEdit;
    EdtAcousticSide: TEdit;
    Label33: TLabel;
    Label34: TLabel;
    GroupBox6: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    EdtVisualFront: TEdit;
    EdtVisualSide: TEdit;
    GroupBox7: TGroupBox;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    EdtInfraredFront: TEdit;
    EdtInfraredSide: TEdit;
    GroupBox8: TGroupBox;
    EdtMagnetic: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSummaryPlatform: TfrmSummaryPlatform;

implementation

{$R *.dfm}

end.
