unit model.empresa;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections,

  model.ENDERECO,

  /// orm
  ormbr.types.blob, 
  ormbr.types.lazy, 
  dbcbr.types.mapping, 
  ormbr.types.nullable, 
  dbcbr.mapping.classes, 
  dbcbr.mapping.register, 
  dbcbr.mapping.attributes; 

type
  [Entity]
  [Table('EMPRESA', '')]
  TEMPRESA = class
  private
    { Private declarations } 
    FID_EMPRESA: Nullable<Integer>;
    FCODIGO: Integer;
    FCODIGO_CONTABIL: Integer;
    FID_RESPONSAVEL_LEGAL_EMPRESA: Nullable<Integer>;
    FID_CONTADOR: Nullable<Integer>;
    FID_PESSOA: Integer;
    FINSCRICAO_ESTADUAL_ST: Nullable<String>;
    FTIPO: String;
    FDATA_CADASTRO: TDateTime;
    FDATA_INICIO_ATIVIDADES: TDateTime;
    FTIPO_REGIME: Nullable<String>;
    FALIQUOTA_PIS: Double;
    FALIQUOTA_COFINS: Double;
    FCODIGO_IBGE_MUNICIPIO: Integer;
    FCODIGO_IBGE_UF: Integer;
    FIMAGEM_LOGOTIPO: TBlob;
    FJUROS_FATURA: Double;
    FDESCONTO_FATURA: Double;
    FNUM_ULTIMA_FATURA: String;
    FID_CONFIG_NFE: Nullable<Integer>;
    FULTIMO_CLIENTE: Integer;
    FULTIMO_DEPENDENTE: Integer;
    FULTIMO_CRED1: Integer;
    FULTIMO_CRED2: Integer;
    FULTIMO_ACORDO: Integer;
    FULTIMO_CONTRATO: Integer;
    FINCIDENCIA_TRIBUT: Nullable<String>;
    FTIPO_CONTRIBUICAO: Nullable<String>;
    FAPROPRIA_CREDITO: Nullable<String>;
    FCRITERIO_ESCRITU: Nullable<String>;
    FPERFIL_EFD: Nullable<String>;
    FID_GRUPO_EMPRESA: Integer;
    FID_REGIAO: Nullable<Integer>;
    FMETRO_QUADRADO: Double;
    FMARKUP_DESEJADO: Double;
    FOBS: Nullable<String>;
    FSMTPDISPLAYNAME: Nullable<String>;
    FSMTPMAIL: Nullable<String>;
    FSMTPSERVER: Nullable<String>;
    FSMTPPORT: Nullable<Integer>;
    FSMTPUSER: Nullable<String>;
    FSMTPPASSWORD: Nullable<String>;
    FSMTPSSL: Integer;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;
    FENDERECO: TENDERECO;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Column('ID_EMPRESA', ftInteger)]
    [Dictionary('ID_EMPRESA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_empresa: Nullable<Integer> read FID_EMPRESA write FID_EMPRESA;

    [Restrictions([NotNull])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property codigo: Integer read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('CODIGO_CONTABIL', ftInteger)]
    [Dictionary('CODIGO_CONTABIL', 'Mensagem de validação', '', '', '', taCenter)]
    property codigo_contabil: Integer read FCODIGO_CONTABIL write FCODIGO_CONTABIL;

    [Column('ID_RESPONSAVEL_LEGAL_EMPRESA', ftInteger)]
    [Dictionary('ID_RESPONSAVEL_LEGAL_EMPRESA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_responsavel_legal_empresa: Nullable<Integer> read FID_RESPONSAVEL_LEGAL_EMPRESA write FID_RESPONSAVEL_LEGAL_EMPRESA;

    [Column('ID_CONTADOR', ftInteger)]
    [Dictionary('ID_CONTADOR', 'Mensagem de validação', '', '', '', taCenter)]
    property id_contador: Nullable<Integer> read FID_CONTADOR write FID_CONTADOR;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA', ftInteger)]
    [Dictionary('ID_PESSOA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa: Integer read FID_PESSOA write FID_PESSOA;

    [Column('INSCRICAO_ESTADUAL_ST', ftString, 30)]
    [Dictionary('INSCRICAO_ESTADUAL_ST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property inscricao_estadual_st: Nullable<String> read FINSCRICAO_ESTADUAL_ST write FINSCRICAO_ESTADUAL_ST;

    [Restrictions([NotNull])]
    [Column('TIPO', ftString, 1)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tipo: String read FTIPO write FTIPO;

    [Restrictions([NotNull])]
    [Column('DATA_CADASTRO', ftDateTime)]
    [Dictionary('DATA_CADASTRO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property data_cadastro: TDateTime read FDATA_CADASTRO write FDATA_CADASTRO;

    [Restrictions([NotNull])]
    [Column('DATA_INICIO_ATIVIDADES', ftDateTime)]
    [Dictionary('DATA_INICIO_ATIVIDADES', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property data_inicio_atividades: TDateTime read FDATA_INICIO_ATIVIDADES write FDATA_INICIO_ATIVIDADES;

    [Column('TIPO_REGIME', ftString, 1)]
    [Dictionary('TIPO_REGIME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tipo_regime: Nullable<String> read FTIPO_REGIME write FTIPO_REGIME;

    [Restrictions([NotNull])]
    [Column('ALIQUOTA_PIS', ftBCD)]
    [Dictionary('ALIQUOTA_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliquota_pis: Double read FALIQUOTA_PIS write FALIQUOTA_PIS;

    [Restrictions([NotNull])]
    [Column('ALIQUOTA_COFINS', ftBCD)]
    [Dictionary('ALIQUOTA_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliquota_cofins: Double read FALIQUOTA_COFINS write FALIQUOTA_COFINS;

    [Restrictions([NotNull])]
    [Column('CODIGO_IBGE_MUNICIPIO', ftInteger)]
    [Dictionary('CODIGO_IBGE_MUNICIPIO', 'Mensagem de validação', '', '', '', taCenter)]
    property codigo_ibge_municipio: Integer read FCODIGO_IBGE_MUNICIPIO write FCODIGO_IBGE_MUNICIPIO;

    [Restrictions([NotNull])]
    [Column('CODIGO_IBGE_UF', ftInteger)]
    [Dictionary('CODIGO_IBGE_UF', 'Mensagem de validação', '', '', '', taCenter)]
    property codigo_ibge_uf: Integer read FCODIGO_IBGE_UF write FCODIGO_IBGE_UF;

    [Column('IMAGEM_LOGOTIPO', ftBlob)]
    [Dictionary('IMAGEM_LOGOTIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property imagem_logotipo: TBlob read FIMAGEM_LOGOTIPO write FIMAGEM_LOGOTIPO;

    [Restrictions([NotNull])]
    [Column('JUROS_FATURA', ftBCD)]
    [Dictionary('JUROS_FATURA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property juros_fatura: Double read FJUROS_FATURA write FJUROS_FATURA;

    [Restrictions([NotNull])]
    [Column('DESCONTO_FATURA', ftBCD)]
    [Dictionary('DESCONTO_FATURA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property desconto_fatura: Double read FDESCONTO_FATURA write FDESCONTO_FATURA;

    [Restrictions([NotNull])]
    [Column('NUM_ULTIMA_FATURA', ftString, 6)]
    [Dictionary('NUM_ULTIMA_FATURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property num_ultima_fatura: String read FNUM_ULTIMA_FATURA write FNUM_ULTIMA_FATURA;

    [Column('ID_CONFIG_NFE', ftInteger)]
    [Dictionary('ID_CONFIG_NFE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_config_nfe: Nullable<Integer> read FID_CONFIG_NFE write FID_CONFIG_NFE;

    [Restrictions([NotNull])]
    [Column('ULTIMO_CLIENTE', ftInteger)]
    [Dictionary('ULTIMO_CLIENTE', 'Mensagem de validação', '', '', '', taCenter)]
    property ultimo_cliente: Integer read FULTIMO_CLIENTE write FULTIMO_CLIENTE;

    [Restrictions([NotNull])]
    [Column('ULTIMO_DEPENDENTE', ftInteger)]
    [Dictionary('ULTIMO_DEPENDENTE', 'Mensagem de validação', '', '', '', taCenter)]
    property ultimo_dependente: Integer read FULTIMO_DEPENDENTE write FULTIMO_DEPENDENTE;

    [Restrictions([NotNull])]
    [Column('ULTIMO_CRED1', ftInteger)]
    [Dictionary('ULTIMO_CRED1', 'Mensagem de validação', '', '', '', taCenter)]
    property ultimo_cred1: Integer read FULTIMO_CRED1 write FULTIMO_CRED1;

    [Restrictions([NotNull])]
    [Column('ULTIMO_CRED2', ftInteger)]
    [Dictionary('ULTIMO_CRED2', 'Mensagem de validação', '', '', '', taCenter)]
    property ultimo_cred2: Integer read FULTIMO_CRED2 write FULTIMO_CRED2;

    [Restrictions([NotNull])]
    [Column('ULTIMO_ACORDO', ftInteger)]
    [Dictionary('ULTIMO_ACORDO', 'Mensagem de validação', '', '', '', taCenter)]
    property ultimo_acordo: Integer read FULTIMO_ACORDO write FULTIMO_ACORDO;

    [Restrictions([NotNull])]
    [Column('ULTIMO_CONTRATO', ftInteger)]
    [Dictionary('ULTIMO_CONTRATO', 'Mensagem de validação', '', '', '', taCenter)]
    property ultimo_contrato: Integer read FULTIMO_CONTRATO write FULTIMO_CONTRATO;

    [Column('INCIDENCIA_TRIBUT', ftString, 5)]
    [Dictionary('INCIDENCIA_TRIBUT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property incidencia_tribut: Nullable<String> read FINCIDENCIA_TRIBUT write FINCIDENCIA_TRIBUT;

    [Column('TIPO_CONTRIBUICAO', ftString, 5)]
    [Dictionary('TIPO_CONTRIBUICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tipo_contribuicao: Nullable<String> read FTIPO_CONTRIBUICAO write FTIPO_CONTRIBUICAO;

    [Column('APROPRIA_CREDITO', ftString, 5)]
    [Dictionary('APROPRIA_CREDITO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property apropria_credito: Nullable<String> read FAPROPRIA_CREDITO write FAPROPRIA_CREDITO;

    [Column('CRITERIO_ESCRITU', ftString, 5)]
    [Dictionary('CRITERIO_ESCRITU', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property criterio_escritu: Nullable<String> read FCRITERIO_ESCRITU write FCRITERIO_ESCRITU;

    [Column('PERFIL_EFD', ftString, 5)]
    [Dictionary('PERFIL_EFD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property perfil_efd: Nullable<String> read FPERFIL_EFD write FPERFIL_EFD;


    [Restrictions([NotNull])]
    [Column('ID_GRUPO_EMPRESA', ftInteger)]
    [Dictionary('ID_GRUPO_EMPRESA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_grupo_empresa: Integer read FID_GRUPO_EMPRESA write FID_GRUPO_EMPRESA;

    [Column('ID_REGIAO', ftInteger)]
    [Dictionary('ID_REGIAO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_regiao: Nullable<Integer> read FID_REGIAO write FID_REGIAO;

    [Restrictions([NotNull])]
    [Column('METRO_QUADRADO', ftBCD)]
    [Dictionary('METRO_QUADRADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property metro_quadrado: Double read FMETRO_QUADRADO write FMETRO_QUADRADO;

    [Restrictions([NotNull])]
    [Column('MARKUP_DESEJADO', ftBCD, 48, 6)]
    [Dictionary('MARKUP_DESEJADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property markup_desejado: Double read FMARKUP_DESEJADO write FMARKUP_DESEJADO;

    [Column('OBS', ftString, 200)]
    [Dictionary('OBS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property obs: Nullable<String> read FOBS write FOBS;

    [Column('SMTPDISPLAYNAME', ftString, 100)]
    [Dictionary('SMTPDISPLAYNAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property smtpdisplayname: Nullable<String> read FSMTPDISPLAYNAME write FSMTPDISPLAYNAME;

    [Column('SMTPMAIL', ftString, 100)]
    [Dictionary('SMTPMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property smtpmail: Nullable<String> read FSMTPMAIL write FSMTPMAIL;

    [Column('SMTPSERVER', ftString, 100)]
    [Dictionary('SMTPSERVER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property smtpserver: Nullable<String> read FSMTPSERVER write FSMTPSERVER;

    [Column('SMTPPORT', ftInteger)]
    [Dictionary('SMTPPORT', 'Mensagem de validação', '', '', '', taCenter)]
    property smtpport: Nullable<Integer> read FSMTPPORT write FSMTPPORT;

    [Column('SMTPUSER', ftString, 100)]
    [Dictionary('SMTPUSER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property smtpuser: Nullable<String> read FSMTPUSER write FSMTPUSER;

    [Column('SMTPPASSWORD', ftString, 200)]
    [Dictionary('SMTPPASSWORD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property smtppassword: Nullable<String> read FSMTPPASSWORD write FSMTPPASSWORD;

    [Restrictions([NotNull])]
    [Column('SMTPSSL', ftInteger)]
    [Dictionary('SMTPSSL', 'Mensagem de validação', '', '', '', taCenter)]
    property smtpssl: Integer read FSMTPSSL write FSMTPSSL;

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

    [Association(TMultiplicity.OneToOne, 'ID_PESSOA',
    'ENDERECO', 'ID_PESSOA')]
    property ENDERECO: TENDERECO read FENDERECO write FENDERECO;
  end;

implementation

constructor TEMPRESA.Create;
begin
  FENDERECO := TENDERECO.Create;
end;

destructor TEMPRESA.Destroy;
begin
  FreeAndNil(FENDERECO);
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TEMPRESA)

end.
