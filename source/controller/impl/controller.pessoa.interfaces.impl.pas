unit controller.pessoa.interfaces.impl;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  controller.pessoa.interfaces,

  ormbr.objects.helper,
  dbcbr.mapping.explorer,
  ormbr.json,
  ormbr.rtti.helper,

  model.PESSOA,
  model.PESSOA_FISICA,
  model.PESSOA_JURIDICA,
  model.CLIENTE,
  model.CONTATO,
  model.ENDERECO,

  model.service.interfaces.impl,
  model.service.interfaces,
  model.service.scripts.interfaces.impl,
  model.service.scripts.interfaces;

type
  TIPESSOA = class(TInterfacedObject, IPESSOA)
    private
    FEntity: TPESSOA;
    FService: IService<TPESSOA>;
    FServiceScripts: IServiceScripts;

    public
    constructor Create;
    destructor Destroy; override;
    class function New: IPESSOA;

    function id_pessoa(value: Integer): IPESSOA; overload;
    function id_pessoa: Integer; overload;

    function nome(value: String): IPESSOA; overload;
    function nome: String; overload;

    function abreviado(value: String): IPESSOA; overload;
    function abreviado: String; overload;

    function tipo(value: String): IPESSOA; overload;
    function tipo: String; overload;

    function site(value: String): IPESSOA; overload;
    function site: String; overload;

    function suframa(value: String): IPESSOA; overload;
    function suframa: String; overload;

    function dt_inc(value: TDateTime): IPESSOA; overload;
    function dt_inc: TDateTime; overload;

    function dt_alt(value: TDateTime): IPESSOA; overload;
    function dt_alt: TDateTime; overload;

    function dt_hab(value: TDateTime): IPESSOA; overload;
    function dt_hab: TDateTime; overload;

    function cliente(value: TCLIENTE): IPESSOA; overload;
    function cliente: TCLIENTE; overload;

    function pessoa_fisica(value: TPESSOA_FISICA): IPESSOA; overload;
    function pessoa_fisica: TPESSOA_FISICA; overload;

    function pessoa_juridica(value: TPESSOA_JURIDICA): IPESSOA; overload;
    function pessoa_juridica: TPESSOA_JURIDICA; overload;

    function contato(value: TObjectList<TCONTATO>): IPESSOA; overload;
    function contato: TObjectList<TCONTATO>; overload;

    function pessoa_guid(value: TGUID): IPESSOA; overload;
    function pessoa_guid: TGUID; overload;

    function endereco(value: TENDERECO): IPESSOA; overload;
    function endereco: TENDERECO; overload;

    function Build: IService<TPESSOA>;
    function Manufacture: IServiceScripts;
  end;

implementation

{ TIPESSOA }

function TIPESSOA.abreviado(value: String): IPESSOA;
begin
  Result := Self;
  FEntity.abreviado := value;
end;

function TIPESSOA.abreviado: String;
begin
  Result := FEntity.abreviado;
end;

function TIPESSOA.Build: IService<TPESSOA>;
begin
  Result := FService;
end;

function TIPESSOA.cliente: TCLIENTE;
begin
  Result := FEntity.CLIENTE;
end;

function TIPESSOA.cliente(value: TCLIENTE): IPESSOA;
begin
  Result := Self;
  FEntity.CLIENTE := value;
end;

function TIPESSOA.contato(value: TObjectList<TCONTATO>): IPESSOA;
begin
  Result := Self;
  FEntity.CONTATO := value;
end;

function TIPESSOA.contato: TObjectList<TCONTATO>;
begin
  Result := FEntity.CONTATO;
end;

constructor TIPESSOA.Create;
begin
  FEntity := TPESSOA.Create;
  FService := TServiceORMBr<TPESSOA>.New(FEntity);
  FServiceScripts := TServiceScripts.New;
end;

destructor TIPESSOA.Destroy;
begin
  FreeAndNil(FEntity);
  inherited;
end;

function TIPESSOA.dt_alt: TDateTime;
begin
  Result := FEntity.dt_alt;
end;

function TIPESSOA.dt_alt(value: TDateTime): IPESSOA;
begin
  Result := Self;
  FEntity.dt_alt := value;
end;

function TIPESSOA.dt_hab: TDateTime;
begin
  Result := FEntity.dt_hab;
end;

function TIPESSOA.dt_hab(value: TDateTime): IPESSOA;
begin
  Result := Self;
  FEntity.dt_hab := value;
end;

function TIPESSOA.dt_inc: TDateTime;
begin
  Result := FEntity.dt_inc;
end;

function TIPESSOA.endereco: TENDERECO;
begin
  Result := FEntity.ENDERECO;
end;

function TIPESSOA.endereco(value: TENDERECO): IPESSOA;
begin
  Result := Self;
  FEntity.ENDERECO := value;
end;

function TIPESSOA.dt_inc(value: TDateTime): IPESSOA;
begin
  Result := Self;
  FEntity.dt_inc := value;
end;

function TIPESSOA.id_pessoa(value: Integer): IPESSOA;
begin
  Result := Self;
  FEntity.id_pessoa := value;
end;

function TIPESSOA.id_pessoa: Integer;
begin
  Result := FEntity.id_pessoa;
end;

function TIPESSOA.Manufacture: IServiceScripts;
begin
  Result := FServiceScripts;
end;

class function TIPESSOA.New: IPESSOA;
begin
  Result := Self.Create;
end;

function TIPESSOA.nome(value: String): IPESSOA;
begin
  Result := Self;
  FEntity.nome := value;
end;

function TIPESSOA.nome: String;
begin
  Result := FEntity.nome;
end;

function TIPESSOA.pessoa_fisica(value: TPESSOA_FISICA): IPESSOA;
begin
  Result := Self;
  FEntity.PESSOA_FISICA := value;
end;

function TIPESSOA.pessoa_fisica: TPESSOA_FISICA;
begin
  Result := FEntity.PESSOA_FISICA;
end;

function TIPESSOA.pessoa_guid: TGUID;
begin
  Result := FEntity.pessoa_guid;
end;

function TIPESSOA.pessoa_guid(value: TGUID): IPESSOA;
begin
  Result := Self;
  FEntity.pessoa_guid := value;
end;

function TIPESSOA.pessoa_juridica: TPESSOA_JURIDICA;
begin
  Result := FEntity.PESSOA_JURIDICA;
end;

function TIPESSOA.pessoa_juridica(value: TPESSOA_JURIDICA): IPESSOA;
begin
  Result := Self;
  FEntity.PESSOA_JURIDICA := value;
end;

function TIPESSOA.site: String;
begin
  Result := FEntity.site;
end;

function TIPESSOA.site(value: String): IPESSOA;
begin
  Result := Self;
  FEntity.site := value;
end;

function TIPESSOA.suframa(value: String): IPESSOA;
begin
  Result := Self;
  FEntity.suframa := value;
end;

function TIPESSOA.suframa: String;
begin
  Result := FEntity.suframa;
end;

function TIPESSOA.tipo(value: String): IPESSOA;
begin
  Result := Self;
  FEntity.tipo := value;
end;

function TIPESSOA.tipo: String;
begin
  Result := FEntity.tipo;
end;

end.
