unit model.serie_nfe;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  // ormbr
  ormbr.types.blob,
  ormbr.types.lazy,
  ormbr.objects.helper,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes;

type
  [Entity]
  [Table('SERIE_NFE', '')]
  TSERIE_NFE = class
  private
    { Private declarations } 
    FID_SERIE_NFE: Nullable<Integer>;
    FID_EMPRESA: Integer;
    FMODELO: String;
    FNUMERO_SERIE: String;
    FATIVA: Boolean;
    FULTIMA_NFE: String;
    FDATA_CADASTRO: TDateTime;
    FUSR_CADASTRO: String;
    FDATA_ALTERACAO: TDateTime;
    FUSR_ALTERACAO: String;
    FID_TIPO_AMBIENTE_NFE: Integer;
    FID_TIPO_EMISSAO_NFE: Integer;
    FDATA_HORA_CONTINGENCIA: Nullable<TDateTime>;
    FMOTIVO_CONTINGENCIA: Nullable<String>;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;
    FMARCA: Boolean;
    FBLOQUEADO: Boolean;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Column('ID_SERIE_NFE', ftInteger)]
    [Dictionary('ID_SERIE_NFE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_serie_nfe: Nullable<Integer> read FID_SERIE_NFE write FID_SERIE_NFE;

    [Restrictions([NotNull])]
    [Column('ID_EMPRESA', ftInteger)]
    [Dictionary('ID_EMPRESA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_empresa: Integer read FID_EMPRESA write FID_EMPRESA;

    [Restrictions([NotNull])]
    [Column('MODELO', ftString, 3)]
    [Dictionary('MODELO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property modelo: String read FMODELO write FMODELO;

    [Restrictions([NotNull])]
    [Column('NUMERO_SERIE', ftString, 3)]
    [Dictionary('NUMERO_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property numero_serie: String read FNUMERO_SERIE write FNUMERO_SERIE;

    [Restrictions([NotNull])]
    [Column('ATIVA', ftBoolean)]
    [Dictionary('ATIVA', 'Mensagem de validação', 'false', '', '', taCenter)]
    property ativa: Boolean read FATIVA write FATIVA;

    [Restrictions([NotNull])]
    [Column('ULTIMA_NFE', ftString, 10)]
    [Dictionary('ULTIMA_NFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ultima_nfe: String read FULTIMA_NFE write FULTIMA_NFE;

    [Restrictions([NotNull])]
    [Column('DATA_CADASTRO', ftDateTime)]
    [Dictionary('DATA_CADASTRO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property data_cadastro: TDateTime read FDATA_CADASTRO write FDATA_CADASTRO;

    [Restrictions([NotNull])]
    [Column('USR_CADASTRO', ftString, 100)]
    [Dictionary('USR_CADASTRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property usr_cadastro: String read FUSR_CADASTRO write FUSR_CADASTRO;

    [Restrictions([NotNull])]
    [Column('DATA_ALTERACAO', ftDateTime)]
    [Dictionary('DATA_ALTERACAO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property data_alteracao: TDateTime read FDATA_ALTERACAO write FDATA_ALTERACAO;

    [Restrictions([NotNull])]
    [Column('USR_ALTERACAO', ftString, 100)]
    [Dictionary('USR_ALTERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property usr_alteracao: String read FUSR_ALTERACAO write FUSR_ALTERACAO;

    [Restrictions([NotNull])]
    [Column('ID_TIPO_AMBIENTE_NFE', ftInteger)]
    [Dictionary('ID_TIPO_AMBIENTE_NFE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_ambiente_nfe: Integer read FID_TIPO_AMBIENTE_NFE write FID_TIPO_AMBIENTE_NFE;

    [Restrictions([NotNull])]
    [Column('ID_TIPO_EMISSAO_NFE', ftInteger)]
    [Dictionary('ID_TIPO_EMISSAO_NFE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_emissao_nfe: Integer read FID_TIPO_EMISSAO_NFE write FID_TIPO_EMISSAO_NFE;

    [Column('DATA_HORA_CONTINGENCIA', ftDateTime)]
    [Dictionary('DATA_HORA_CONTINGENCIA', 'Mensagem de validação', '', '', '', taCenter)]
    property data_hora_contingencia: Nullable<TDateTime> read FDATA_HORA_CONTINGENCIA write FDATA_HORA_CONTINGENCIA;

    [Column('MOTIVO_CONTINGENCIA', ftString, 200)]
    [Dictionary('MOTIVO_CONTINGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property motivo_contingencia: Nullable<String> read FMOTIVO_CONTINGENCIA write FMOTIVO_CONTINGENCIA;

    [Restrictions([NotNull])]
    [Column('DT_INC', ftDateTime)]
    [Dictionary('DT_INC', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property dt_inc: TDateTime read FDT_INC write FDT_INC;

    [Restrictions([NotNull])]
    [Column('DT_ALT', ftDateTime)]
    [Dictionary('DT_ALT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property dt_alt: TDateTime read FDT_ALT write FDT_ALT;

    [Column('DT_HAB', ftDateTime)]
    [Dictionary('DT_HAB', 'Mensagem de validação', '', '', '', taCenter)]
    property dt_hab: Nullable<TDateTime> read FDT_HAB write FDT_HAB;

    [Restrictions([NotNull])]
    [Column('MARCA', ftBoolean)]
    [Dictionary('MARCA', 'Mensagem de validação', 'false', '', '', taCenter)]
    property marca: Boolean read FMARCA write FMARCA;

    [Restrictions([NotNull])]
    [Column('BLOQUEADO', ftBoolean)]
    [Dictionary('BLOQUEADO', 'Mensagem de validação', 'false', '', '', taCenter)]
    property bloqueado: Boolean read FBLOQUEADO write FBLOQUEADO;
  end;

implementation

constructor TSERIE_NFE.Create;
begin
  //
end;

destructor TSERIE_NFE.Destroy;
begin
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TSERIE_NFE)

end.
