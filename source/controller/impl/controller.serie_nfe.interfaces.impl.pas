unit controller.serie_nfe.interfaces.impl;

interface

uses
  System.SysUtils,

  controller.serie_nfe.interfaces,

  ormbr.objects.helper,
  dbcbr.mapping.explorer,
  ormbr.json,
  ormbr.rtti.helper,

  model.service.interfaces,
  model.service.interfaces.impl,
  model.serie_nfe;

type
  TISERIE_NFE = class(TInterfacedObject, ISERIE_NFE)
  private
    FEntity: TSERIE_NFE;
    FService: IService<TSERIE_NFE>;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: ISERIE_NFE;

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

{ TISERIE_NFE }

function TISERIE_NFE.ativa(value: Boolean): ISERIE_NFE;
begin
  Result := Self;
  FEntity.ativa := value;
end;

function TISERIE_NFE.ativa: Boolean;
begin
  Result := FEntity.ativa;
end;

function TISERIE_NFE.Build: IService<TSERIE_NFE>;
begin
  Result := FService;
end;

constructor TISERIE_NFE.Create;
begin
  FEntity := TSERIE_NFE.Create;
  FService := TServiceORMBr<TSERIE_NFE>.New(FEntity);
end;

function TISERIE_NFE.data_alteracao(value: TDateTime): ISERIE_NFE;
begin
  Result := Self;
  FEntity.data_alteracao := value;
end;

function TISERIE_NFE.data_cadastro(value: TDateTime): ISERIE_NFE;
begin
  Result := Self;
  FEntity.data_cadastro := value;
end;

function TISERIE_NFE.data_alteracao: TDateTime;
begin
  Result := FEntity.data_alteracao;
end;

function TISERIE_NFE.data_cadastro: TDateTime;
begin
  Result := FEntity.data_cadastro;
end;

function TISERIE_NFE.data_hora_contingencia(value: TDateTime): ISERIE_NFE;
begin
  Result := Self;
  FEntity.data_hora_contingencia := value;
end;

function TISERIE_NFE.data_hora_contingencia: TDateTime;
begin
  Result := FEntity.data_hora_contingencia;
end;

destructor TISERIE_NFE.Destroy;
begin
  FreeAndNil(FEntity);
  inherited;
end;

function TISERIE_NFE.dt_alt: TDateTime;
begin
  Result := FEntity.dt_alt;
end;

function TISERIE_NFE.dt_alt(value: TDateTime): ISERIE_NFE;
begin
  Result := Self;
  FEntity.dt_alt := value;
end;

function TISERIE_NFE.dt_inc: TDateTime;
begin
  Result := FEntity.dt_inc;
end;

function TISERIE_NFE.dt_inc(value: TDateTime): ISERIE_NFE;
begin
  Result := Self;
  FEntity.dt_inc := value;
end;

function TISERIE_NFE.id_empresa(value: Integer): ISERIE_NFE;
begin
  Result := Self;
  FEntity.id_empresa := value;
end;

function TISERIE_NFE.id_empresa: Integer;
begin
  Result := FEntity.id_empresa;
end;

function TISERIE_NFE.id_serie_nfe: Integer;
begin
  Result := FEntity.id_serie_nfe;
end;

function TISERIE_NFE.id_serie_nfe(value: Integer): ISERIE_NFE;
begin
  Result := Self;
  FEntity.id_serie_nfe := value;
end;

function TISERIE_NFE.id_tipo_ambiente_nfe(value: Integer): ISERIE_NFE;
begin
  Result := Self;
  FEntity.id_tipo_ambiente_nfe := value;
end;

function TISERIE_NFE.id_tipo_ambiente_nfe: Integer;
begin
  Result := FEntity.id_tipo_ambiente_nfe;
end;

function TISERIE_NFE.id_tipo_emissao_nfe: Integer;
begin
  Result := FEntity.id_tipo_emissao_nfe;
end;

function TISERIE_NFE.id_tipo_emissao_nfe(value: Integer): ISERIE_NFE;
begin
  Result := Self;
  FEntity.id_tipo_emissao_nfe := value;
end;

function TISERIE_NFE.modelo(value: String): ISERIE_NFE;
begin
  Result := Self;
  FEntity.modelo := value;
end;

function TISERIE_NFE.modelo: String;
begin
  Result := FEntity.modelo;
end;

function TISERIE_NFE.motivo_contingencia: String;
begin
  Result := FEntity.motivo_contingencia;
end;

function TISERIE_NFE.motivo_contingencia(value: String): ISERIE_NFE;
begin
  Result := Self;
  FEntity.motivo_contingencia := value;
end;

class function TISERIE_NFE.New: ISERIE_NFE;
begin
  Result := Self.Create;
end;

function TISERIE_NFE.numero_serie: String;
begin
  Result := FEntity.numero_serie;
end;

function TISERIE_NFE.numero_serie(value: String): ISERIE_NFE;
begin
  Result := Self;
  FEntity.numero_serie := value;
end;

function TISERIE_NFE.ultima_nfe: String;
begin
  Result := FEntity.ultima_nfe;
end;

function TISERIE_NFE.ultima_nfe(value: String): ISERIE_NFE;
begin
  Result := Self;
  FEntity.ultima_nfe := value;
end;

function TISERIE_NFE.usr_alteracao: String;
begin
  Result := FEntity.usr_alteracao;
end;

function TISERIE_NFE.usr_cadastro(value: String): ISERIE_NFE;
begin
  Result := Self;
  FEntity.usr_cadastro := value;
end;

function TISERIE_NFE.usr_alteracao(value: String): ISERIE_NFE;
begin
  Result := Self;
  FEntity.usr_alteracao := value;
end;

function TISERIE_NFE.usr_cadastro: String;
begin
  Result := FEntity.usr_cadastro;
end;

end.
