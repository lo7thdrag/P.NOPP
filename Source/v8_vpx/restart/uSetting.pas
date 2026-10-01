unit uSetting;

interface

uses
  System.IOUtils,
  System.JSON;

type
  TSetting = class
  strict private
    FAppName: string;
    FPath: string;
    FKillTimeout: Integer;
  public
    property AppName: string read FAppName;
    property Path: string read FPath;
    property KillTimeout: Integer read FKillTimeout;
    procedure LoadFromFile;
  end;

implementation

{ TSetting }

procedure TSetting.LoadFromFile;
var
  sjson: string;
  LJson: TJSONObject;
begin
  sjson:= TFile.ReadAllText('launcher.json');
  LJson := TJSONObject.ParseJSONValue(sjson) as TJSONObject;
  try
    FAppName := LJson.GetValue<string>('AppName');
    FPath := LJson.GetValue<string>('ExePath');
    FKillTimeout := LJson.GetValue<Integer>('KillTimeout');
  finally
    LJson.Free;
  end;
end;

end.
