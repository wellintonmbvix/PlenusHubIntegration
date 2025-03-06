unit model.resource.impl.connection.firedac;

interface

uses
  FireDAC.UI.Intf,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Param,

  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.MSSQLWrapper,

  FireDAC.DatS,

  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Comp.DataSet,
  FireDAC.DApt,
  FireDAC.DApt.Intf,

  Data.DB,
  model.resource.interfaces;

type
  TConnection = class(TInterfacedObject, IConnection)
    private
      FConfiguration: IConfiguration;
      FConn: TFDConnection;
      FDPhysMSSQLDriverLink : TFDPhysMSSQLDriverLink;
    public
      constructor Create(aConfiguration: IConfiguration);
      destructor Destroy; override;
      class function New(aConfiguration: IConfiguration): IConnection;

      function Connect: TCustomConnection;
  end;

implementation

uses
  SysUtils;

{ TConnection }

function TConnection.Connect: TCustomConnection;
begin
  try
    FConn.Params.DriverID := FConfiguration.DriverID;
    FConn.Params.Database := FConfiguration.Database;
    FConn.Params.UserName := FConfiguration.Username;
    FConn.Params.Password := FConfiguration.Password;
    FConn.Params.Add('Port=' + FConfiguration.Port);
    FConn.Params.Add('Server=' + FConfiguration.Server);

    if not FConfiguration.Schema.IsEmpty then
    begin
      FConn.Params.Add('MetaCurSchema=' + FConfiguration.Schema);
      FConn.Params.Add('MetaDefSchema=' + FConfiguration.Schema);
    end;

    FConn.Connected := True;
    Result := FConn;
  except
    On e: Exception do
      raise Exception.Create(#13'Não foi possível realizar a conexão. ' + e.Message);
  end;
end;

constructor TConnection.Create(aConfiguration: IConfiguration);
begin
  FConn := TFDConnection.Create(nil);
  FDPhysMSSQLDriverLink := TFDPhysMSSQLDriverLink.Create(nil);
//  FDPhysMSSQLDriverLink.VendorLib := GetCurrentDir + '\libpq.dll';
  FConfiguration := aConfiguration;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(FDPhysMSSQLDriverLink);
  FreeAndNil(FConn);
  inherited;
end;

class function TConnection.New(aConfiguration: IConfiguration): IConnection;
begin
  Result := Self.Create(aConfiguration);
end;

end.
