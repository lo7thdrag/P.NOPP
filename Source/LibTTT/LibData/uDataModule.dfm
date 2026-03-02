object dmINWO: TdmINWO
  OldCreateOrder = False
  Height = 203
  Width = 443
  object ZConn: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    DesignConnection = True
    HostName = '192.168.1.100'
    Port = 1433
    Database = 'runtime_db'
    User = 'sa'
    Password = 'sa'
    Protocol = 'mssql'
    Left = 40
    Top = 24
  end
  object ZQ: TZQuery
    Connection = ZConn
    Params = <>
    Left = 104
    Top = 24
  end
end
