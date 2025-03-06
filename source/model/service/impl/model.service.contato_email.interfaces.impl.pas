unit model.service.contato_email.interfaces.impl;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  model.service.contato_email.interfaces,
  model.CONTATO_EMAIL,
  model.resource.impl.factory,
  model.resource.interfaces;

type
  TIServicoCONTATO_EMAIL = class(TInterfacedObject, IServiceCONTATO_EMAIL)
    private
      FConnection: IConnection;
     function Insert(contato_email: TObjectList<TCONTATO_EMAIL>; var msg: String): Boolean;
    constructor Create;
    public
      destructor Destroy; override;
      class function New: IServiceCONTATO_EMAIL;
      function Save(contato_email: TObjectList<TCONTATO_EMAIL>; var msg: String): Boolean;
  end;

implementation

uses
  FireDAC.Comp.Client;

{ TIServicoCONTATO_EMAIL }

constructor TIServicoCONTATO_EMAIL.Create;
begin
  FConnection := TResource.New.Connection;
end;

destructor TIServicoCONTATO_EMAIL.Destroy;
begin
  inherited;
end;

function TIServicoCONTATO_EMAIL.Insert(
  contato_email: TObjectList<TCONTATO_EMAIL>; var msg: String): Boolean;
var
  lQry : TFDQuery;
begin
  lQry := TFDQuery(FConnection.Connect);
  Result := False;
  Try
    Try
      With lQry Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO CONTATO_EMAIL(');
          SQL.Add('ID_PESSOA,');
          SQL.Add('ID_TIPO_TELEFONE,');
          SQL.Add('TELEFONE,');
          SQL.Add('DT_INC,');
          SQL.Add('DT_ALT');
          SQL.Add(')VALUES(');
          SQL.Add('(SELECT SCOPE_IDENTITY()),');
          SQL.Add(':ID_TIPO_TELEFONE,');
          SQL.Add(':TELEFONE,');
          SQL.Add('SYSDATETIME(),');
          SQL.Add('SYSDATETIME());');

          Params.ArraySize := 0;
          for var i := 0 to contato_email.Count - 1 do
              begin
                Params.ArraySize := Params.ArraySize - 1;
                ParamByName('ID_TIPO_TELEFONE').AsIntegers[i] :=
                (contato_email.Items[i] as TCONTATO_EMAIL).id_tipo_email;
              end;
        End;
    Except
      On E: Exception Do
        msg := E.Message;
    End;
  Finally
    FreeAndNil(lQry);
  End;
end;

class function TIServicoCONTATO_EMAIL.New: IServiceCONTATO_EMAIL;
begin
  Result := Self.Create;
end;

function TIServicoCONTATO_EMAIL.Save(
  contato_email: TObjectList<TCONTATO_EMAIL>; var msg: String): Boolean;
begin
  Result := Insert(contato_email, msg);
end;

end.
