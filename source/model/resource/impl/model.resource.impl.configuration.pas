unit model.resource.impl.configuration;

interface

uses
  System.IniFiles,
  System.SysUtils,
  System.StrUtils,
  routines,
  model.resource.interfaces;

  type
  TConfiguration = class(TInterfacedObject, IConfiguration)
    private
    FServidor: String;
    FPorta: Integer;
    FUserName: String;
    FPassword: String;
    FDataBase: String;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IConfiguration;

      function DriverID(aValue: String): IConfiguration; overload;
      function DriverID: String; overload;

      function Database(aValue: String): IConfiguration; overload;
      function Database: String; overload;

      function Username(aValue: String): IConfiguration; overload;
      function Username: String; overload;

      function Password(aValue: String): IConfiguration; overload;
      function Password: String; overload;

      function Port(aValue: String): IConfiguration; overload;
      function Port: String; overload;

      function Server(aValue: String): IConfiguration; overload;
      function Server: String; overload;

      function Schema(aValue: String): IConfiguration; overload;
      function Schema: String; overload;
  end;


implementation

{ TConfiguration }

constructor TConfiguration.Create;
var
  arqCfg  : TIniFile;
  servidor,
  usuario,
  senha,
  banco,
  textdecript: String;
  i,
  codigo     : Integer;
  caracter   : Char;
begin
  Try
    arqCfg := TIniFile.Create('C:\CSSISTEMAS\PLENUS\config.ini');
    Try
      servidor := arqCfg.ReadString('Dados','SS1', servidor);
      banco    := arqCfg.ReadString('Dados','SS6', banco);
      usuario  := arqCfg.ReadString('Dados','SS2', usuario);
      senha    := arqCfg.ReadString('Dados','SS3', senha);

      // decriptando value "servidor"
      i := 1;
      while i <= Round(Length(servidor)) do
        begin
          codigo   := StrToInt(Copy(servidor, i, 3));
          caracter := Chr(codigo);
          i := i + 3;
          textdecript := textdecript + caracter;
        end;
      servidor    := ReverseString(textdecript);
      textdecript := EmptyStr;

      // decriptando value "banco"
      i := 1;
      while i <= Round(Length(banco)) do
        begin
          codigo   := StrToInt(Copy(banco, i, 3));
          caracter := Chr(codigo);
          i := i + 3;
          textdecript := textdecript + caracter;
        end;
      banco       := ReverseString(textdecript);
      textdecript := EmptyStr;

      // decriptando value "usuario"
      i := 1;
      while i <= Round(Length(usuario)) do
        begin
          codigo   := StrToInt(Copy(usuario, i, 3));
          caracter := Chr(codigo);
          i := i + 3;
          textdecript := textdecript + caracter;
        end;
      usuario       := ReverseString(textdecript);
      textdecript := EmptyStr;

      // decriptando value "senha"
      i := 1;
      while i <= Round(Length(senha)) do
        begin
          codigo   := StrToInt(Copy(senha, i, 3));
          caracter := Chr(codigo);
          i := i + 3;
          textdecript := textdecript + caracter;
        end;
      senha       := ReverseString(textdecript);
      textdecript := EmptyStr;

      FServidor := servidor;
      FUserName := usuario;
      FPassword := senha;
      FDataBase := banco;
    Except
      on e: Exception do
        begin
          TRoutines.GenerateLogs(tpError, e.Message);
        end;
    End;
  Finally
    FreeAndNil(arqCfg);
  End;
end;

function TConfiguration.Database(aValue: String): IConfiguration;
begin
  Result := Self;
  //Gravar no INI
end;

function TConfiguration.Database: String;
begin
  Result := FDataBase; //Puxar do INI
end;

destructor TConfiguration.Destroy;
begin

  inherited;
end;

function TConfiguration.DriverID: String;
begin
  Result := 'MSSQL'; //Puxar do INI
end;

function TConfiguration.DriverID(aValue: String): IConfiguration;
begin
  Result := Self;
  //Gravar no INI
end;

class function TConfiguration.New: IConfiguration;
begin
  Result := Self.Create;
end;

function TConfiguration.Password(aValue: String): IConfiguration;
begin
  Result := Self;
  //Gravar no INI
end;

function TConfiguration.Password: String;
begin
  Result := FPassword; //Puxar do INI
end;

function TConfiguration.Port(aValue: String): IConfiguration;
begin
  Result := Self;
  //Gravar no INI
end;

function TConfiguration.Port: String;
begin
  Result := '1433'; //Puxar do INI
end;

function TConfiguration.Schema: String;
begin
  Result := ''; //Puxar do INI
end;

function TConfiguration.Schema(aValue: String): IConfiguration;
begin
  Result := Self;
  //Gravar no INI
end;

function TConfiguration.Server(aValue: String): IConfiguration;
begin
  Result := Self;
  //Gravar no INI
end;

function TConfiguration.Server: String;
begin
  Result := FServidor; //Puxar do INI
end;

function TConfiguration.Username: String;
begin
  Result := FUserName; //Puxar do INI
end;

function TConfiguration.Username(aValue: String): IConfiguration;
begin
  Result := Self;
  //Gravar no INI
end;

end.
