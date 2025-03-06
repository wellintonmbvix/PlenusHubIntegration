unit controller.parametros.interfaces.impl;

interface

uses
  System.SysUtils,

  controller.parametros.interfaces,

  ormbr.objects.helper,
  dbcbr.mapping.explorer,
  ormbr.json,
  ormbr.rtti.helper,

  model.service.interfaces,
  model.service.interfaces.impl,
  model.service.scripts.interfaces,
  model.service.scripts.interfaces.impl,
  model.parametros;

type
  TIPARAMETROS = class(TInterfacedObject, IPARAMETROS)
  private
    FEntity: TPARAMETROS;
    FService: IService<TPARAMETROS>;
    FServiceScripts: IServiceScripts;

  public
    constructor Create;
    destructor Destroy; override;
    class function New: IPARAMETROS;

    function ID_PARAMETROS(value: Integer): IPARAMETROS; overload;
    function ID_PARAMETROS: Integer; overload;

    function ID_EMPRESA(value: Integer): IPARAMETROS; overload;
    function ID_EMPRESA: Integer; overload;

    function FID_EMPRESA_LOJA_VIRTUAL(value: Integer): IPARAMETROS; overload;
    function FID_EMPRESA_LOJA_VIRTUAL: Integer; overload;

    function FID_PRODUTO_TABELA_LOJA_VIRTUAL(value: Integer)
      : IPARAMETROS; overload;
    function FID_PRODUTO_TABELA_LOJA_VIRTUAL: Integer; overload;

    function ID_TRANSPORTADORA_LOJA_VIRTUAL(value: Integer)
      : IPARAMETROS; overload;
    function ID_TRANSPORTADORA_LOJA_VIRTUAL: Integer; overload;

    function ID_SERIE_NFE_LOJA_VIRTUAL(value: Integer): IPARAMETROS; overload;
    function ID_SERIE_NFE_LOJA_VIRTUAL: Integer; overload;

    function REPASSE_ESTOQUE_LOJA_VIRTUAL(value: Currency)
      : IPARAMETROS; overload;
    function REPASSE_ESTOQUE_LOJA_VIRTUAL: Currency; overload;

    function ID_COLABORADOR_LOJA_VIRTUAL(value: Integer): IPARAMETROS; overload;
    function ID_COLABORADOR_LOJA_VIRTUAL: Integer; overload;

    function Build: IService<TPARAMETROS>;
    function Manufactory: IServiceScripts;
  end;

implementation

{ TIPARAMETROS }

function TIPARAMETROS.Build: IService<TPARAMETROS>;
begin
  Result := FService;
end;

constructor TIPARAMETROS.Create;
begin
  FEntity := TPARAMETROS.Create;
  FService := TServiceORMBr<TPARAMETROS>.New(FEntity);
  FServiceScripts := TServiceScripts.New;
end;

destructor TIPARAMETROS.Destroy;
begin
  FreeAndNil(FEntity);
  inherited;
end;

function TIPARAMETROS.FID_EMPRESA_LOJA_VIRTUAL(value: Integer): IPARAMETROS;
begin
  Result := Self;
  FEntity.ID_EMPRESA_LOJA_VIRTUAL := value;
end;

function TIPARAMETROS.FID_EMPRESA_LOJA_VIRTUAL: Integer;
begin
  Result := FEntity.ID_EMPRESA_LOJA_VIRTUAL;
end;

function TIPARAMETROS.FID_PRODUTO_TABELA_LOJA_VIRTUAL: Integer;
begin
  Result := FEntity.ID_PRODUTO_TABELA_LOJA_VIRTUAL;
end;

function TIPARAMETROS.FID_PRODUTO_TABELA_LOJA_VIRTUAL(value: Integer)
  : IPARAMETROS;
begin
  Result := Self;
  FEntity.ID_PRODUTO_TABELA_LOJA_VIRTUAL := value;
end;

function TIPARAMETROS.ID_COLABORADOR_LOJA_VIRTUAL(value: Integer): IPARAMETROS;
begin
  Result := Self;
  FEntity.ID_COLABORADOR_LOJA_VIRTUAL := value;
end;

function TIPARAMETROS.ID_COLABORADOR_LOJA_VIRTUAL: Integer;
begin
  Result := FEntity.ID_COLABORADOR_LOJA_VIRTUAL;
end;

function TIPARAMETROS.ID_EMPRESA(value: Integer): IPARAMETROS;
begin
  Result := Self;
  FEntity.ID_EMPRESA := value;
end;

function TIPARAMETROS.ID_EMPRESA: Integer;
begin
  Result := FEntity.ID_EMPRESA;
end;

function TIPARAMETROS.ID_PARAMETROS(value: Integer): IPARAMETROS;
begin
  Result := Self;
  FEntity.ID_PARAMETROS := value;
end;

function TIPARAMETROS.ID_PARAMETROS: Integer;
begin
  Result := FEntity.ID_PARAMETROS;
end;

function TIPARAMETROS.ID_SERIE_NFE_LOJA_VIRTUAL: Integer;
begin
  Result := FEntity.ID_SERIE_NFE_LOJA_VIRTUAL;
end;

function TIPARAMETROS.ID_TRANSPORTADORA_LOJA_VIRTUAL: Integer;
begin
  Result := FEntity.ID_TRANSPORTADORA_LOJA_VIRTUAL;
end;

function TIPARAMETROS.Manufactory: IServiceScripts;
begin
  Result := FServiceScripts;
end;

function TIPARAMETROS.ID_TRANSPORTADORA_LOJA_VIRTUAL(
  value: Integer): IPARAMETROS;
begin
  Result := Self;
  FEntity.ID_TRANSPORTADORA_LOJA_VIRTUAL := value;
end;

function TIPARAMETROS.ID_SERIE_NFE_LOJA_VIRTUAL(value: Integer): IPARAMETROS;
begin
  Result := Self;
  FEntity.ID_SERIE_NFE_LOJA_VIRTUAL := value;
end;

class function TIPARAMETROS.New: IPARAMETROS;
begin
  Result := Self.Create;
end;

function TIPARAMETROS.REPASSE_ESTOQUE_LOJA_VIRTUAL(value: Currency)
  : IPARAMETROS;
begin
  Result := Self;
  FEntity.REPASSE_ESTOQUE_LOJA_VIRTUAL := value;
end;

function TIPARAMETROS.REPASSE_ESTOQUE_LOJA_VIRTUAL: Currency;
begin
  Result := FEntity.REPASSE_ESTOQUE_LOJA_VIRTUAL;
end;

end.
