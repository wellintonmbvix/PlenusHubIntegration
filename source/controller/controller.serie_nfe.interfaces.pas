unit controller.serie_nfe.interfaces;

interface

uses
  model.SERIE_NFE,

  //** ORMBr
  ormbr.types.blob,
  model.service.interfaces;

type
  ISERIE_NFE = interface
    ['{00DB54BB-85A7-47CC-AA0D-EE20A9B420FD}']

    function id_serie_nfe(value: Integer): ISERIE_NFE; overload;
    function id_serie_nfe: Integer; overload;

    function id_empresa(value: Integer): ISERIE_NFE; overload;
    function id_empresa: Integer; overload;

    function modelo(value: String): ISERIE_NFE; overload;
    function modelo: String; overload;

    function numero_serie(value: String): ISERIE_NFE; overload;
    function numero_serie: String; overload;

    function ativa(value: Boolean): ISERIE_NFE; overload;
    function ativa: Boolean; overload;

    function ultima_nfe(value: String): ISERIE_NFE; overload;
    function ultima_nfe: String; overload;

    function data_cadastro(value: TDateTime): ISERIE_NFE; overload;
    function data_cadastro: TDateTime; overload;

    function usr_cadastro(value: String): ISERIE_NFE; overload;
    function usr_cadastro: String; overload;

    function data_alteracao(value: TDateTime): ISERIE_NFE; overload;
    function data_alteracao: TDateTime; overload;

    function usr_alteracao(value: String): ISERIE_NFE; overload;
    function usr_alteracao: String; overload;

    function id_tipo_ambiente_nfe(value: Integer): ISERIE_NFE; overload;
    function id_tipo_ambiente_nfe: Integer; overload;

    function id_tipo_emissao_nfe(value: Integer): ISERIE_NFE; overload;
    function id_tipo_emissao_nfe: Integer; overload;

    function data_hora_contingencia(value: TDateTime): ISERIE_NFE; overload;
    function data_hora_contingencia: TDateTime; overload;

    function motivo_contingencia(value: String): ISERIE_NFE; overload;
    function motivo_contingencia: String; overload;

    function dt_inc(value: TDateTime): ISERIE_NFE; overload;
    function dt_inc: TDateTime; overload;

    function dt_alt(value: TDateTime): ISERIE_NFE; overload;
    function dt_alt: TDateTime; overload;

    function Build: IService<TSERIE_NFE>;
  end;

implementation

end.
