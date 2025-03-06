unit model.cliente;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,

  // ormbr
  ormbr.types.blob,
  ormbr.types.lazy,
  ormbr.objects.helper,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.Classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes;

type

  [Entity]
  [Table('CLIENTE', '')]
  [PrimaryKey('CLIENTE_GUID', TAutoIncType.NotInc,
                            TGeneratorType.Guid32Inc,
                            TSortingOrder.Ascending,
                            True, 'Chave primária')]
  [OrderBy('CLIENTE_GUID')]
  TCLIENTE = class
  private
    { Private declarations }
    FID_CLIENTE: nullable<Integer>;
    FCODIGO: Integer;
    FCONTA_CONTABIL: nullable<Integer>;
    FID_EMPRESA: nullable<Integer>;
    FID_PESSOA: Integer;
    FID_ATIVIDADE_FOR_CLI: nullable<Integer>;
    FID_SITUACAO_FOR_CLI: nullable<Integer>;
    FDESDE: nullable<TDateTime>;
    FID_VENDEDOR_PREF: nullable<Integer>;
    FID_EMPRESA_PREF: nullable<Integer>;
    FLIMITE_CREDITO: Double;
    FCOMISSAO_VENDEDOR: Double;
    FDESCONTO_PADRAO: nullable<Double>;
    FCONTA_TOMADOR: nullable<String>;
    FOBSERVACOES: nullable<String>;
    FDATA_ULTIMA_COMPRA: nullable<TDateTime>;
    FVALOR_ULTIMA_COMPRA: nullable<Double>;
    FDATA_CADASTRO: nullable<TDateTime>;
    FUSUARIO_CADASTRO: Integer;
    FDATA_ALTERACAO: nullable<TDateTime>;
    FUSUARIO_ALTERACAO: nullable<Integer>;
    FM_BLUSA: String;
    FM_CALCA: String;
    FM_CALCADO: String;
    FID_LOCAL_COBRANCA: nullable<Integer>;
    FID_TIPO_COBRANCA: nullable<Integer>;
    FID_ZONA_VENDA: nullable<Integer>;
    FID_COND_PGTO_VENDA: nullable<Integer>;
    FID_TIPO_VENDA: nullable<Integer>;
    FMARKUP_MIN: Double;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: nullable<TDateTime>;
    FLIMITE_PERSONALIZADO: Boolean;
    FDESCONSIDERAR_CHEQ_LIMITE_CREDITO: Boolean;
    FFATURAR: Boolean;
    FSUSPENSO: Boolean;
    FMARCA: Boolean;
    FBLOQUEADO: Boolean;
    FCLIENTE_GUID: nullable<TGUID>;
    FID_PESSOA_GUID: TGUID;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    [Column('ID_CLIENTE', ftInteger)]
    [Dictionary('ID_CLIENTE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_cliente: nullable<Integer> read FID_CLIENTE write FID_CLIENTE;

    [Restrictions([NotNull])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property codigo: Integer read FCODIGO write FCODIGO;

    [Column('CONTA_CONTABIL', ftInteger)]
    [Dictionary('CONTA_CONTABIL', 'Mensagem de validação', '', '', '',
      taCenter)]
    property conta_contabil: nullable<Integer> read FCONTA_CONTABIL
      write FCONTA_CONTABIL;

    [Column('ID_EMPRESA', ftInteger)]
    [Dictionary('ID_EMPRESA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_empresa: nullable<Integer> read FID_EMPRESA write FID_EMPRESA;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA', ftInteger)]
    [ForeignKey('FK__CLIENTE__PESSOA', 'ID_PESSOA', 'PESSOA', 'ID_PESSOA',
      Cascade, Cascade)]
    [Dictionary('ID_PESSOA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa: Integer read FID_PESSOA write FID_PESSOA;

    [Column('ID_ATIVIDADE_FOR_CLI', ftInteger)]
    [Dictionary('ID_ATIVIDADE_FOR_CLI', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_atividade_for_cli: nullable<Integer> read FID_ATIVIDADE_FOR_CLI
      write FID_ATIVIDADE_FOR_CLI;

    [Column('ID_SITUACAO_FOR_CLI', ftInteger)]
    [Dictionary('ID_SITUACAO_FOR_CLI', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_situacao_for_cli: nullable<Integer> read FID_SITUACAO_FOR_CLI
      write FID_SITUACAO_FOR_CLI;

    [Column('DESDE', ftDateTime)]
    [Dictionary('DESDE', 'Mensagem de validação', '', '', '', taCenter)]
    property desde: nullable<TDateTime> read FDESDE write FDESDE;

    [Column('ID_VENDEDOR_PREF', ftInteger)]
    [Dictionary('ID_VENDEDOR_PREF', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_vendedor_pref: nullable<Integer> read FID_VENDEDOR_PREF
      write FID_VENDEDOR_PREF;

    [Column('ID_EMPRESA_PREF', ftInteger)]
    [Dictionary('ID_EMPRESA_PREF', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_empresa_pref: nullable<Integer> read FID_EMPRESA_PREF
      write FID_EMPRESA_PREF;

    [Column('LIMITE_PERSONALIZADO', ftBoolean)]
    [Dictionary('LIMITE_PERSONALIZADO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property limite_personalizado: Boolean read FLIMITE_PERSONALIZADO
      write FLIMITE_PERSONALIZADO;

    [Restrictions([NotNull])]
    [Column('LIMITE_CREDITO', ftBCD)]
    [Dictionary('LIMITE_CREDITO', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property limite_credito: Double read FLIMITE_CREDITO write FLIMITE_CREDITO;

    [Column('DESCONSIDERAR_CHEQ_LIMITE_CREDITO', ftBoolean)]
    [Dictionary('DESCONSIDERAR_CHEQ_LIMITE_CREDITO', 'Mensagem de validação',
      '', '', '', taCenter)]
    property desconsiderar_cheq_limite_credito: Boolean
      read FDESCONSIDERAR_CHEQ_LIMITE_CREDITO
      write FDESCONSIDERAR_CHEQ_LIMITE_CREDITO;

    [Restrictions([NotNull])]
    [Column('COMISSAO_VENDEDOR', ftBCD)]
    [Dictionary('COMISSAO_VENDEDOR', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property comissao_vendedor: Double read FCOMISSAO_VENDEDOR
      write FCOMISSAO_VENDEDOR;

    [Column('FATURAR', ftBoolean)]
    [Dictionary('FATURAR', 'Mensagem de validação',
      '', '', '', taCenter)]
    property faturar: Boolean read FFATURAR write FFATURAR;

    [Column('DESCONTO_PADRAO', ftBCD)]
    [Dictionary('DESCONTO_PADRAO', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property desconto_padrao: nullable<Double> read FDESCONTO_PADRAO
      write FDESCONTO_PADRAO;

    [Column('CONTA_TOMADOR', ftString, 50)]
    [Dictionary('CONTA_TOMADOR', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property conta_tomador: nullable<String> read FCONTA_TOMADOR
      write FCONTA_TOMADOR;

    [Column('OBSERVACOES', ftString, 8000)]
    [Dictionary('OBSERVACOES', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property observacoes: nullable<String> read FOBSERVACOES write FOBSERVACOES;

    [Column('DATA_ULTIMA_COMPRA', ftDateTime)]
    [Dictionary('DATA_ULTIMA_COMPRA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property data_ultima_compra: nullable<TDateTime> read FDATA_ULTIMA_COMPRA
      write FDATA_ULTIMA_COMPRA;

    [Column('VALOR_ULTIMA_COMPRA', ftBCD)]
    [Dictionary('VALOR_ULTIMA_COMPRA', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property valor_ultima_compra: nullable<Double> read FVALOR_ULTIMA_COMPRA
      write FVALOR_ULTIMA_COMPRA;

    [Column('DATA_CADASTRO', ftDateTime)]
    [Dictionary('DATA_CADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property data_cadastro: nullable<TDateTime> read FDATA_CADASTRO
      write FDATA_CADASTRO;

    [Restrictions([NotNull])]
    [Column('USUARIO_CADASTRO', ftInteger)]
    [Dictionary('USUARIO_CADASTRO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property usuario_cadastro: Integer read FUSUARIO_CADASTRO
      write FUSUARIO_CADASTRO;

    [Column('DATA_ALTERACAO', ftDateTime)]
    [Dictionary('DATA_ALTERACAO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property data_alteracao: nullable<TDateTime> read FDATA_ALTERACAO
      write FDATA_ALTERACAO;

    [Column('USUARIO_ALTERACAO', ftInteger)]
    [Dictionary('USUARIO_ALTERACAO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property usuario_alteracao: nullable<Integer> read FUSUARIO_ALTERACAO
      write FUSUARIO_ALTERACAO;

    [Restrictions([NotNull])]
    [Column('M_BLUSA', ftString, 5)]
    [Dictionary('M_BLUSA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property m_blusa: String read FM_BLUSA write FM_BLUSA;

    [Restrictions([NotNull])]
    [Column('M_CALCA', ftString, 5)]
    [Dictionary('M_CALCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property m_calca: String read FM_CALCA write FM_CALCA;

    [Restrictions([NotNull])]
    [Column('M_CALCADO', ftString, 5)]
    [Dictionary('M_CALCADO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property m_calcado: String read FM_CALCADO write FM_CALCADO;

    [Column('SUSPENSO', ftBoolean)]
    [Dictionary('SUSPENSO', 'Mensagem de validação',
      '', '', '', taCenter)]
    property suspenso: Boolean read FSUSPENSO write FSUSPENSO;

    [Column('ID_LOCAL_COBRANCA', ftInteger)]
    [Dictionary('ID_LOCAL_COBRANCA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_local_cobranca: nullable<Integer> read FID_LOCAL_COBRANCA
      write FID_LOCAL_COBRANCA;

    [Column('ID_TIPO_COBRANCA', ftInteger)]
    [Dictionary('ID_TIPO_COBRANCA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_tipo_cobranca: nullable<Integer> read FID_TIPO_COBRANCA
      write FID_TIPO_COBRANCA;

    [Column('ID_ZONA_VENDA', ftInteger)]
    [Dictionary('ID_ZONA_VENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_zona_venda: nullable<Integer> read FID_ZONA_VENDA
      write FID_ZONA_VENDA;

    [Column('ID_COND_PGTO_VENDA', ftInteger)]
    [Dictionary('ID_COND_PGTO_VENDA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_cond_pgto_venda: nullable<Integer> read FID_COND_PGTO_VENDA
      write FID_COND_PGTO_VENDA;

    [Column('ID_TIPO_VENDA', ftInteger)]
    [Dictionary('ID_TIPO_VENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_venda: nullable<Integer> read FID_TIPO_VENDA
      write FID_TIPO_VENDA;

    [Restrictions([NotNull])]
    [Column('MARKUP_MIN', ftBCD, 495386624, 6)]
    [Dictionary('MARKUP_MIN', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property markup_min: Double read FMARKUP_MIN write FMARKUP_MIN;

    [Restrictions([NotNull])]
    [Column('DT_INC', ftDateTime)]
    [Dictionary('DT_INC', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_',
      taCenter)]
    property dt_inc: TDateTime read FDT_INC write FDT_INC;

    [Restrictions([NotNull])]
    [Column('DT_ALT', ftDateTime)]
    [Dictionary('DT_ALT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_',
      taCenter)]
    property dt_alt: TDateTime read FDT_ALT write FDT_ALT;

    [Column('DT_HAB', ftDateTime)]
    [Dictionary('DT_HAB', 'Mensagem de validação', '', '', '', taCenter)]
    property dt_hab: nullable<TDateTime> read FDT_HAB write FDT_HAB;

    [Column('MARCA', ftBoolean)]
    [Dictionary('MARCA', 'Mensagem de validação',
      '', '', '', taCenter)]
    property marca: Boolean read FMARCA write FMARCA;

    [Column('BLOQUEADO', ftBoolean)]
    [Dictionary('BLOQUEADO', 'Mensagem de validação',
      '', '', '', taCenter)]
    property bloqueado: Boolean read FBLOQUEADO write FBLOQUEADO;

    [Column('CLIENTE_GUID', ftGuid)]
    [Dictionary('CLIENTE_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cliente_guid: nullable<TGUID> read FCLIENTE_GUID write FCLIENTE_GUID;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA_GUID', ftGuid)]
    [ForeignKey('FK__CLIENTE__ID_PESS__3CB77382', 'ID_PESSOA_GUID', 'PESSOA', 'PESSOA_GUID',
      Cascade, Cascade)]
    [Dictionary('ID_PESSOA_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property id_pessoa_guid: TGUID read FID_PESSOA_GUID write FID_PESSOA_GUID;

  end;

implementation

constructor TCLIENTE.Create;
begin
  //
end;

destructor TCLIENTE.Destroy;
begin
  inherited;
end;

initialization

TRegisterClass.RegisterEntity(TCLIENTE)

end.
