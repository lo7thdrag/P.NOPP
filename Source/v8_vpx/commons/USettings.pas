unit USettings;

interface

uses
  System.Types,
  System.Classes,
  System.SysUtils,
  System.IOUtils,
  System.JSON,
  Vcl.Dialogs;

type
  TControllerSetting = class
  strict private
  private
    FPort: Integer;
    FConsoles: TStringList;
    procedure SetPort(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    function LoadFromFile(AFileName: string): Boolean;
    property Port: Integer read FPort write SetPort;
    property Consoles: TStringList read FConsoles;
  end;

  TCasterSetting = class
  strict private
  private
    FID: Integer;
    FPort: Integer;
    FControllerPort: Integer;
    FControllerAddress: string;
    FCastFPS: Integer;
    FSrcRegion: TRect;
    FDestRegion: TRect;
    procedure SetPort(const Value: Integer);
    procedure SetControllerAddress(const Value: string);
    procedure SetControllerPort(const Value: Integer);
    procedure SetID(const Value: Integer);
    procedure SetCastFPS(const Value: Integer);
  public
    function LoadFromFile(AFileName: string): Boolean;
    property ID: Integer read FID write SetID;
    property Port: Integer read FPort write SetPort;
    property ControllerAddress: string read FControllerAddress write SetControllerAddress;
    property ControllerPort: Integer read FControllerPort write SetControllerPort;
    property CastFPS: Integer read FCastFPS write SetCastFPS;
    property SourceRegion: TRect read FSrcRegion;
    property DestinationRegion: TRect read FDestRegion;
  end;

  TViewerSetting = class
  strict private
  private
    FID: Integer;
    FControllerPort: Integer;
    FControllerAddress: string;

    FTitleText: string;
    FTitleFontName: string;
    FTitleFontSize: Integer;
    FTitlePosX: Integer;
    FTitlePosY: Integer;

    procedure SetControllerAddress(const Value: string);
    procedure SetControllerPort(const Value: Integer);
    procedure SetID(const Value: Integer);
  public
    function LoadFromFile(AFileName: string): Boolean;
    property ID: Integer read FID write SetID;
    property ControllerAddress: string read FControllerAddress write SetControllerAddress;
    property ControllerPort: Integer read FControllerPort write SetControllerPort;

    property TitleText: string read FTitleText write FTitleText;
    property TitleFontName: string read FTitleFontName write FTitleFontName;
    property TitleFontSize: Integer read FTitleFontSize write FTitleFontSize;
    property TitlePosX: Integer read FTitlePosX write FTitlePosX;
    property TitlePosY: Integer read FTitlePosY write FTitlePosY;
  end;

implementation

{ TControllerSetting }

constructor TControllerSetting.Create;
begin
  FConsoles:= TStringList.Create;
end;

destructor TControllerSetting.Destroy;
begin
  FConsoles.Free;
  inherited;
end;

function TControllerSetting.LoadFromFile(AFileName: string): Boolean;
var
  sJson: string;
  jo: TJSONObject;
  NValue: TJSONNumber;
  ja: TJSONArray;
  SValue: TJSONString;
  i: Integer;
begin
  Result:= False;
  try
    sJson:= TFile.ReadAllText(AFileName);
    jo := TJSONObject.ParseJSONValue(sJson) as TJSONObject;
    if jo<>nil then begin
      try
        if jo.TryGetValue<TJSONNumber>('port', NValue) then
        begin
          FPort:= NValue.AsInt;
        end;

        if jo.TryGetValue<TJSONArray>('consoles', ja) then
        begin
          for i := 0 to ja.Count-1 do
          begin
            if ja.A[i].TryGetValue<TJSONString>(SValue) then
              FConsoles.Add(SValue.Value)
          end;
        end;
        Result:= True;
      finally
        jo.Free
      end;
    end;
  except on E: Exception do
    ShowMessage(E.Message);
  end;

end;

procedure TControllerSetting.SetPort(const Value: Integer);
begin
  FPort := Value;
end;

{ TCasterSetting }

function TCasterSetting.LoadFromFile(AFileName: string): Boolean;
var
  sJson: string;
  jo, joController, joSR, joDR: TJSONObject;
  SValue: TJSONString;
  NValue: TJSONNumber;
begin
  Result:= False;
  try
    sJson:= TFile.ReadAllText(AFileName);
    jo := TJSONObject.ParseJSONValue(sJson) as TJSONObject;
    if jo<>nil then begin
      try
        if jo.TryGetValue<TJSONNumber>('id', NValue) then
        begin
          FID:= NValue.AsInt;
        end;

        if jo.TryGetValue<TJSONNumber>('port', NValue) then
        begin
          FPort:= NValue.AsInt;
        end;

        if jo.TryGetValue<TJSONNumber>('cast fps', NValue) then
        begin
          FCastFPS:= NValue.AsInt;
        end;

        if jo.TryGetValue<TJSONObject>('source region', joSR) then
        begin
          if joSR.TryGetValue<TJSONNumber>('left', NValue) then
          begin
            FSrcRegion.Left:= NValue.AsInt;
          end;
          if joSR.TryGetValue<TJSONNumber>('top', NValue) then
          begin
            FSrcRegion.Top:= NValue.AsInt;
          end;
          if joSR.TryGetValue<TJSONNumber>('width', NValue) then
          begin
            FSrcRegion.Width:= NValue.AsInt;
          end;
          if joSR.TryGetValue<TJSONNumber>('height', NValue) then
          begin
            FSrcRegion.Height:= NValue.AsInt;
          end;
        end;

        if jo.TryGetValue<TJSONObject>('destination region', joDR) then
        begin
          if joDR.TryGetValue<TJSONNumber>('left', NValue) then
          begin
            FDestRegion.Left:= NValue.AsInt;
          end;
          if joDR.TryGetValue<TJSONNumber>('top', NValue) then
          begin
            FDestRegion.Top:= NValue.AsInt;
          end;
          if joDR.TryGetValue<TJSONNumber>('width', NValue) then
          begin
            FDestRegion.Width:= NValue.AsInt;
          end;
          if joDR.TryGetValue<TJSONNumber>('height', NValue) then
          begin
            FDestRegion.Height:= NValue.AsInt;
          end;
        end;

        if jo.TryGetValue<TJSONObject>('controller', joController) then
        begin
          if joController.TryGetValue<TJSONString>('address', SValue) then
          begin
            FControllerAddress:= SValue.Value;
          end;

          if joController.TryGetValue<TJSONNumber>('port', NValue) then
          begin
            FControllerPort:= NValue.AsInt;
          end;
        end;
        Result:= True;
      finally
        jo.Free;
      end;
    end
  except
  end;
end;

procedure TCasterSetting.SetCastFPS(const Value: Integer);
begin
  FCastFPS := Value;
end;

procedure TCasterSetting.SetControllerAddress(const Value: string);
begin
  FControllerAddress := Value;
end;

procedure TCasterSetting.SetControllerPort(const Value: Integer);
begin
  FControllerPort := Value;
end;

procedure TCasterSetting.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TCasterSetting.SetPort(const Value: Integer);
begin
  FPort := Value;
end;

{ TViewerSetting }

function TViewerSetting.LoadFromFile(AFileName: string): Boolean;
var
  sJson: string;
  jo, joController, joTitle, joFont: TJSONObject;
  SValue: TJSONString;
  NValue: TJSONNumber;
begin
  Result:= False;
  try
    sJson:= TFile.ReadAllText(AFileName);
    jo := TJSONObject.ParseJSONValue(sJson) as TJSONObject;
    if jo<>nil then begin
      try
        if jo.TryGetValue<TJSONNumber>('id', NValue) then
        begin
          FID:= NValue.AsInt;
        end;

        if jo.TryGetValue<TJSONObject>('controller', joController) then
        begin
          if joController.TryGetValue<TJSONString>('address', SValue) then
          begin
            FControllerAddress:= SValue.Value;
          end;

          if joController.TryGetValue<TJSONNumber>('port', NValue) then
          begin
            FControllerPort:= NValue.AsInt;
          end;
        end;

        if jo.TryGetValue<TJSONObject>('title', joTitle) then
        begin
          if joTitle.TryGetValue<TJSONString>('text', SValue) then
          begin
            FTitleText:= SValue.Value;
          end;

          if joTitle.TryGetValue<TJSONObject>('font', joFont) then
          begin
            if joFont.TryGetValue<TJSONString>('name', SValue) then
            begin
              FTitleFontName := SValue.Value;
            end;
            if joFont.TryGetValue<TJSONNumber>('size', NValue) then
            begin
              FTitleFontSize:= NValue.AsInt;
            end;
          end;

          if joTitle.TryGetValue<TJSONNumber>('posx', NValue) then
          begin
            FTitlePosX:= NValue.AsInt;
          end;

          if joTitle.TryGetValue<TJSONNumber>('posy', NValue) then
          begin
            FTitlePosY:= NValue.AsInt;
          end;
        end;

        Result:= True;
      finally
        jo.Free;
      end;
    end
  except
  end;
end;

procedure TViewerSetting.SetControllerAddress(const Value: string);
begin
  FControllerAddress := Value;
end;

procedure TViewerSetting.SetControllerPort(const Value: Integer);
begin
  FControllerPort := Value;
end;

procedure TViewerSetting.SetID(const Value: Integer);
begin
  FID := Value;
end;

end.
