unit SettingsDlg;

interface

uses
  // Delphi units
  Windows, Messages, SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  // ComDrv32 units
  //CPDrv,
  ComDrv32;

type
  TSettingsForm = class( TForm )
    OkButton: TButton;
    CancelButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    PortComboBox: TComboBox;
    BaudRateComboBox: TComboBox;
    DataBitsComboBox: TComboBox;
    ParityComboBox: TComboBox;
    StopBitsComboBox: TComboBox;
    HwFlowComboBox: TComboBox;
    SwFlowComboBox: TComboBox;
    PacketModeComboBox: TComboBox;
    procedure OkButtonClick(Sender: TObject);
  private
    // TCommPortDriver whose settings must be customized
    FCPDrv: TCommPortDriver;
    // Shows current settings
    procedure UpdateControls;
  public
    // Constructor
    constructor Create( AOwner: TComponent; ACPDrv: TCommPortDriver ); reintroduce; virtual;
  end;

implementation

{$R *.DFM}

// Constructor
constructor TSettingsForm.Create( AOwner: TComponent; ACPDrv: TCommPortDriver );
begin
  // Call inherited constructor
  inherited Create( AOwner );
  // Save the cpDrv reference
  FCPDrv := ACPDrv;
  // Show current settings
  UpdateControls;
end;

// Shows current settings
procedure TSettingsForm.UpdateControls;
begin
  // Base Settings page
  PortComboBox.ItemIndex := ord( FCPDrv.ComPort );
  BaudRateComboBox.ItemIndex := ord( FCPDrv.ComPortSpeed );
  DataBitsComboBox.ItemIndex := ord( FCPDrv.ComPortDataBits );
  ParityComboBox.ItemIndex := ord( FCPDrv.ComPortParity );
  StopBitsComboBox.ItemIndex := ord( FCPDrv.ComPortStopBits );
  // Flow Control page
  HwFlowComboBox.ItemIndex := ord( FCPDrv.ComPortHwHandshaking );
  SwFlowComboBox.ItemIndex := ord( FCPDrv.ComPortSwHandshaking );
  PacketModeComboBox.ItemIndex := ord( FCPDrv.PacketMode );
end;

procedure TSettingsForm.OkButtonClick(Sender: TObject);
var newPortName: string;
    newBaudRate: DWORD;
begin
  // Validate settings
  newPortName := Trim( PortComboBox.Text );
  if newPortName = '' then
  begin
    Application.MessageBox( 'Please, enter a valid port name.',
                            'Error',
                            MB_OK or MB_ICONERROR );
    exit;
  end;
  newBaudRate := DWORD( StrToIntDef( BaudRateComboBox.Text, -1 ) );
  //Sengaja aku biarin gini supaya agak bebas
  if (newBaudRate < 110) or (newBaudRate > 921600) then
  begin
    Application.MessageBox( 'Please, enter a valid baud rate.',
                            'Error',
                            MB_OK or MB_ICONERROR );
    exit;
  end;
  // Apply new settings
  FCPDrv.ComPort := TComPortNumber( PortComboBox.ItemIndex );
  FCPDrv.ComPortSpeed := TComPortBaudRate( BaudRateComboBox.ItemIndex );
  FCPDrv.ComPortDataBits := TComPortDataBits( DataBitsComboBox.ItemIndex );
  FCPDrv.ComPortParity := TComPortParity( ParityComboBox.ItemIndex );
  FCPDrv.ComPortStopBits := TComPortStopBits( StopBitsComboBox.ItemIndex );
  FCPDrv.ComPortHwHandshaking := TComPortHwHandshaking( HwFlowComboBox.ItemIndex );
  FCPDrv.ComPortSwHandshaking := TComPortSwHandshaking( SwFlowComboBox.ItemIndex );
  FCPDrv.PacketMode := TPacketMode( PacketModeComboBox.ItemIndex);
  // Done
  ModalResult := mrOk;
end;

end.
