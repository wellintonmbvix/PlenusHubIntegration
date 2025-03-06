unit controller.parametros.interfaces;

interface

uses
  model.parametros,

  //** ORMBr
  ormbr.types.blob,
  model.service.interfaces,
  model.service.scripts.interfaces;

type
  IPARAMETROS = interface
    ['{CBD2FE50-8AF2-4671-85BB-4A2C3748405C}']

    function ID_PARAMETROS(value: Integer): IPARAMETROS; overload;
    function ID_PARAMETROS: Integer; overload;

    function ID_EMPRESA(value: Integer): IPARAMETROS; overload;
    function ID_EMPRESA: Integer; overload;

    function FID_EMPRESA_LOJA_VIRTUAL(value: Integer): IPARAMETROS; overload;
    function FID_EMPRESA_LOJA_VIRTUAL: Integer; overload;

    function FID_PRODUTO_TABELA_LOJA_VIRTUAL(value: Integer): IPARAMETROS; overload;
    function FID_PRODUTO_TABELA_LOJA_VIRTUAL: Integer; overload;

    function ID_TRANSPORTADORA_LOJA_VIRTUAL(value: Integer): IPARAMETROS; overload;
    function ID_TRANSPORTADORA_LOJA_VIRTUAL: Integer; overload;

    function ID_SERIE_NFE_LOJA_VIRTUAL(value: Integer): IPARAMETROS; overload;
    function ID_SERIE_NFE_LOJA_VIRTUAL: Integer; overload;

    function REPASSE_ESTOQUE_LOJA_VIRTUAL(value: Currency): IPARAMETROS; overload;
    function REPASSE_ESTOQUE_LOJA_VIRTUAL: Currency; overload;

    function ID_COLABORADOR_LOJA_VIRTUAL(value: Integer): IPARAMETROS; overload;
    function ID_COLABORADOR_LOJA_VIRTUAL: Integer; overload;

    function Build: IService<TPARAMETROS>;
    function Manufactory: IServiceScripts;
  end;

implementation

end.
