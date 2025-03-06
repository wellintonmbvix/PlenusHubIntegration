unit model.pdv_notas_fiscais_cab;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,

  model.PDV_NOTAS_FISCAIS_ITEM,

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
  [Table('PDV_NOTAS_FISCAIS_CAB', '')]
  [PrimaryKey('ID_PDV_NOTAS_FISCAIS_CAB', TAutoIncType.AutoInc,
                                          TGeneratorType.TableInc,
                                          TSortingOrder.NoSort,
                                          True, 'Chave primária')]
  [OrderBy('ID_PDV_NOTAS_FISCAIS_CAB')]
  TPDV_NOTAS_FISCAIS_CAB = class
  private
    { Private declarations } 
    FID_PDV_NOTAS_FISCAIS_CAB: Integer;
    FID_PDV_EQUIPAMENTO: Nullable<Integer>;
    FID_PDV_MOVIMENTO: Nullable<Integer>;
    FID_DAV_CABECALHO: Nullable<Integer>;
    FID_PRE_VENDA_CABECALHO: Nullable<Integer>;
    FID_PEDIDO_VENDA: Nullable<Integer>;
    FID_CONSIGNACAO: Nullable<Integer>;
    FCODIGO: Integer;
    FID_TIPO_AMBIENTE_NFE: Integer;
    FID_TIPO_EMISSAO_NFE: Integer;
    FTIPO_CADASTRO: String;
    FID_CLI_FOR: Nullable<Integer>;
    FID_INDICACAO: Nullable<Integer>;
    FID_COLABORADOR: Int64;
    FID_EMPRESA: Integer;
    FDT_EMISSAO: TDateTime;
    FID_FORMA_PAGAMENTO: Nullable<Integer>;
    FID_COND_PGTO_VENDA: Nullable<Integer>;
    FOPERACAO: String;
    FID_TIPO_VENDA: Nullable<Integer>;
    FID_PRODUTO_TABELA: Nullable<Integer>;
    FIEST: Nullable<String>;
    FMODELO: String;
    FSERIE: String;
    FSUBSERIE: String;
    FNUM_NOTA: Nullable<Integer>;
    FDT_NOTA: TDateTime;
    FNOME_DESTINATARIO: Nullable<String>;
    FCPF_CNPJ_DESTINATARIO: Nullable<String>;
    FTELEFONE_DESTINATARIO: Nullable<String>;
    FENDERECO_DESTINATARIO: Nullable<String>;
    FSITUACAO: String;
    FID_TRANSPORTADORA: Nullable<Integer>;
    FTRAN_FRETE_POR_CONTA: Integer;
    FTRAN_COD_ANTT: Nullable<String>;
    FTRAN_PLACA_VEICULO: Nullable<String>;
    FTRAN_UF: Nullable<String>;
    FTRAN_QTDE_VOLUMES: Double;
    FTRAN_ESPECIE: Nullable<String>;
    FTRAN_MARCA: Nullable<String>;
    FTRAN_NUMERACAO: Nullable<String>;
    FTRAN_PESO_BRUTO: Double;
    FTRAN_PESO_LIQUIDO: Double;
    FTOTAL_QUANTIDADE: Double;
    FTOTAL_BRUTO: Double;
    FTOTAL_CRED_CSOSN: Double;
    FTOTAL_BASE_ICMS: Double;
    FTOTAL_ICMS: Double;
    FTOTAL_REDU_BASE: Double;
    FTOTAL_BASE_SUBTRIB: Double;
    FTOTAL_SUB_TRIB: Double;
    FTOTAL_BASE_PIS: Double;
    FTOTAL_PIS: Double;
    FTOTAL_BASE_COFINS: Double;
    FTOTAL_COFINS: Double;
    FTOTAL_BASE_IPI: Double;
    FTOTAL_IPI: Double;
    FTOTAL_BASE_ISSQN: Double;
    FTOTAL_ISSQN: Double;
    FTOTAL_BASE_II: Double;
    FTOTAL_II_ADUANEIRA: Double;
    FTOTAL_II_IOF: Double;
    FTOTAL_II: Double;
    FTOTAL_ACRESCIMO: Double;
    FTOTAL_DESCONTO: Double;
    FTOTAL_CREDITO: Double;
    FCREDITO_DESC: Nullable<String>;
    FPERC_COMISSAO: Double;
    FTOTAL_COMISSAO: Double;
    FTOTAL_FRETE: Double;
    FTOTAL_SEGURO: Double;
    FTOTAL_DESPESA: Double;
    FTOTAL_LIQUIDO: Double;
    FTOTAL_ISENTO: Double;
    FTOTAL_NAO_TRIBUT: Double;
    FTOTAL_CANCELADO: Double;
    FNFE_CHAVE: Nullable<String>;
    FNFE_NRO_PROTOCOLO: Nullable<String>;
    FNFE_DTH_PROTOCOLO: Nullable<TDateTime>;
    FNFE_FINALIDADE: Nullable<String>;
    FIND_EMITENTE: Nullable<String>;
    FIND_PGTO: Nullable<String>;
    FIND_FRETE: Nullable<String>;
    FIND_NAT_FRETE: Nullable<String>;
    FCTE_TIPO: Nullable<String>;
    FID_USUARIO_ALT: Nullable<Integer>;
    FCOMISSAO: Double;
    FEXP_UF_SAIDA: Nullable<String>;
    FEXP_LOC_EXPORTA: Nullable<String>;
    FEXP_LOCAL_DESPACHO: Nullable<String>;
    FID_ORIGEM: Integer;
    FST_TABELA: Nullable<String>;
    FID_COD_TABELA: Nullable<Integer>;
    FCANCELADA: String;
    FMOTIVO_CANC: Nullable<String>;
    FSTATUS: String;
    FOBS: Nullable<String>;
    FVALOR_FCP: Double;
    FVALOR_ICMS_UF_DEST: Double;
    FVALOR_ICMS_UF_REMET: Double;
    FCOD_DOC_IMP: Nullable<String>;
    FNUM_DOC_IMP: Nullable<String>;
    FNUM_ACDRAW: Nullable<String>;
    FTROCO: Double;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;
    FID_INTERMEDIADOR: Nullable<Int64>;

    FPDV_NOTAS_FISCAIS_ITEM: TObjectList<TPDV_NOTAS_FISCAIS_ITEM>;
    FCIF_FOB: Boolean;
    FCK_IPINAODEDUZDESCONTO: Boolean;
    FNFE_INDFINAL: Boolean;
    FNFE_INDPRES: Integer;
    FCK_CSOSN: Boolean;
    FICMSNAOSOMADESPESAS: Boolean;
    FIPINAOSOMADESPESAS: Boolean;
    FIPIDEDUZDESCONTO: Boolean;
    FREVENDA: Boolean;
    FCONTIGENCIA: Boolean;
    FBLOQUEADO: Boolean;
    FMARCA: Boolean;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

    [Column('ID_PDV_NOTAS_FISCAIS_CAB', ftInteger)]
    [Dictionary('ID_PDV_NOTAS_FISCAIS_CAB', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pdv_notas_fiscais_cab: Integer read FID_PDV_NOTAS_FISCAIS_CAB write FID_PDV_NOTAS_FISCAIS_CAB;

    [Column('ID_PDV_EQUIPAMENTO', ftInteger)]
    [Dictionary('ID_PDV_EQUIPAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pdv_equipamento: Nullable<Integer> read FID_PDV_EQUIPAMENTO write FID_PDV_EQUIPAMENTO;

    [Column('ID_PDV_MOVIMENTO', ftInteger)]
    [Dictionary('ID_PDV_MOVIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pdv_movimento: Nullable<Integer> read FID_PDV_MOVIMENTO write FID_PDV_MOVIMENTO;

    [Column('ID_DAV_CABECALHO', ftInteger)]
    [Dictionary('ID_DAV_CABECALHO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_dav_cabecalho: Nullable<Integer> read FID_DAV_CABECALHO write FID_DAV_CABECALHO;

    [Column('ID_PRE_VENDA_CABECALHO', ftInteger)]
    [Dictionary('ID_PRE_VENDA_CABECALHO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pre_venda_cabecalho: Nullable<Integer> read FID_PRE_VENDA_CABECALHO write FID_PRE_VENDA_CABECALHO;

    [Column('ID_PEDIDO_VENDA', ftInteger)]
    [Dictionary('ID_PEDIDO_VENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pedido_venda: Nullable<Integer> read FID_PEDIDO_VENDA write FID_PEDIDO_VENDA;

    [Column('ID_CONSIGNACAO', ftInteger)]
    [Dictionary('ID_CONSIGNACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_consignacao: Nullable<Integer> read FID_CONSIGNACAO write FID_CONSIGNACAO;

    [Restrictions([NotNull])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property codigo: Integer read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('ID_TIPO_AMBIENTE_NFE', ftInteger)]
    [Dictionary('ID_TIPO_AMBIENTE_NFE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_ambiente_nfe: Integer read FID_TIPO_AMBIENTE_NFE write FID_TIPO_AMBIENTE_NFE;

    [Restrictions([NotNull])]
    [Column('ID_TIPO_EMISSAO_NFE', ftInteger)]
    [Dictionary('ID_TIPO_EMISSAO_NFE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_emissao_nfe: Integer read FID_TIPO_EMISSAO_NFE write FID_TIPO_EMISSAO_NFE;

    [Restrictions([NotNull])]
    [Column('TIPO_CADASTRO', ftString, 1)]
    [Dictionary('TIPO_CADASTRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tipo_cadastro: String read FTIPO_CADASTRO write FTIPO_CADASTRO;

    [Column('ID_CLI_FOR', ftInteger)]
    [Dictionary('ID_CLI_FOR', 'Mensagem de validação', '', '', '', taCenter)]
    property id_cli_for: Nullable<Integer> read FID_CLI_FOR write FID_CLI_FOR;

    [Column('ID_INDICACAO', ftInteger)]
    [Dictionary('ID_INDICACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_indicacao: Nullable<Integer> read FID_INDICACAO write FID_INDICACAO;

    [Restrictions([NotNull])]
    [Column('ID_COLABORADOR', ftInteger)]
    [Dictionary('ID_COLABORADOR', 'Mensagem de validação', '', '', '', taCenter)]
    property id_colaborador: Int64 read FID_COLABORADOR write FID_COLABORADOR;

    [Restrictions([NotNull])]
    [Column('ID_EMPRESA', ftInteger)]
    [Dictionary('ID_EMPRESA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_empresa: Integer read FID_EMPRESA write FID_EMPRESA;

    [Restrictions([NotNull])]
    [Column('DT_EMISSAO', ftDateTime)]
    [Dictionary('DT_EMISSAO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property dt_emissao: TDateTime read FDT_EMISSAO write FDT_EMISSAO;

    [Column('ID_FORMA_PAGAMENTO', ftInteger)]
    [Dictionary('ID_FORMA_PAGAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_forma_pagamento: Nullable<Integer> read FID_FORMA_PAGAMENTO write FID_FORMA_PAGAMENTO;

    [Column('ID_COND_PGTO_VENDA', ftInteger)]
    [Dictionary('ID_COND_PGTO_VENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_cond_pgto_venda: Nullable<Integer> read FID_COND_PGTO_VENDA write FID_COND_PGTO_VENDA;

    [Restrictions([NotNull])]
    [Column('OPERACAO', ftString, 1)]
    [Dictionary('OPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property operacao: String read FOPERACAO write FOPERACAO;

    [Column('ID_TIPO_VENDA', ftInteger)]
    [Dictionary('ID_TIPO_VENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_venda: Nullable<Integer> read FID_TIPO_VENDA write FID_TIPO_VENDA;

    [Column('ID_PRODUTO_TABELA', ftInteger)]
    [Dictionary('ID_PRODUTO_TABELA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_produto_tabela: Nullable<Integer> read FID_PRODUTO_TABELA write FID_PRODUTO_TABELA;

    [Column('IEST', ftString, 30)]
    [Dictionary('IEST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property iest: Nullable<String> read FIEST write FIEST;

    [Restrictions([NotNull])]
    [Column('MODELO', ftString, 3)]
    [Dictionary('MODELO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property modelo: String read FMODELO write FMODELO;

    [Restrictions([NotNull])]
    [Column('SERIE', ftString, 3)]
    [Dictionary('SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property serie: String read FSERIE write FSERIE;

    [Restrictions([NotNull])]
    [Column('SUBSERIE', ftString, 3)]
    [Dictionary('SUBSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property subserie: String read FSUBSERIE write FSUBSERIE;

    [Column('NUM_NOTA', ftInteger)]
    [Dictionary('NUM_NOTA', 'Mensagem de validação', '', '', '', taCenter)]
    property num_nota: Nullable<Integer> read FNUM_NOTA write FNUM_NOTA;

    [Restrictions([NotNull])]
    [Column('DT_NOTA', ftDateTime)]
    [Dictionary('DT_NOTA', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property dt_nota: TDateTime read FDT_NOTA write FDT_NOTA;

    [Column('NOME_DESTINATARIO', ftString, 100)]
    [Dictionary('NOME_DESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nome_destinatario: Nullable<String> read FNOME_DESTINATARIO write FNOME_DESTINATARIO;

    [Column('CPF_CNPJ_DESTINATARIO', ftString, 18)]
    [Dictionary('CPF_CNPJ_DESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cpf_cnpj_destinatario: Nullable<String> read FCPF_CNPJ_DESTINATARIO write FCPF_CNPJ_DESTINATARIO;

    [Column('TELEFONE_DESTINATARIO', ftString, 20)]
    [Dictionary('TELEFONE_DESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property telefone_destinatario: Nullable<String> read FTELEFONE_DESTINATARIO write FTELEFONE_DESTINATARIO;

    [Column('ENDERECO_DESTINATARIO', ftString, 300)]
    [Dictionary('ENDERECO_DESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property endereco_destinatario: Nullable<String> read FENDERECO_DESTINATARIO write FENDERECO_DESTINATARIO;

    [Restrictions([NotNull])]
    [Column('SITUACAO', ftString, 1)]
    [Dictionary('SITUACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property situacao: String read FSITUACAO write FSITUACAO;

    [Column('ID_TRANSPORTADORA', ftInteger)]
    [Dictionary('ID_TRANSPORTADORA', 'Mensagem de validação', '', '', '', taRightJustify)]
    property id_transportadora: Nullable<Integer> read FID_TRANSPORTADORA write FID_TRANSPORTADORA;

    [Restrictions([NotNull])]
    [Column('CIF_FOB', ftBoolean)]
    [Dictionary('CIF_FOB', 'Mensagem de validação', '', '', '', taCenter)]
    property cif_fob: Boolean read FCIF_FOB write FCIF_FOB;

    [Restrictions([NotNull])]
    [Column('TRAN_FRETE_POR_CONTA', ftInteger)]
    [Dictionary('TRAN_FRETE_POR_CONTA', 'Mensagem de validação', '', '', '', taCenter)]
    property tran_frete_por_conta: Integer read FTRAN_FRETE_POR_CONTA write FTRAN_FRETE_POR_CONTA;

    [Column('TRAN_COD_ANTT', ftString, 50)]
    [Dictionary('TRAN_COD_ANTT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tran_cod_antt: Nullable<String> read FTRAN_COD_ANTT write FTRAN_COD_ANTT;

    [Column('TRAN_PLACA_VEICULO', ftString, 8)]
    [Dictionary('TRAN_PLACA_VEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tran_placa_veiculo: Nullable<String> read FTRAN_PLACA_VEICULO write FTRAN_PLACA_VEICULO;

    [Column('TRAN_UF', ftString, 2)]
    [Dictionary('TRAN_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tran_uf: Nullable<String> read FTRAN_UF write FTRAN_UF;

    [Restrictions([NotNull])]
    [Column('TRAN_QTDE_VOLUMES', ftBCD, 93, 6)]
    [Dictionary('TRAN_QTDE_VOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property tran_qtde_volumes: Double read FTRAN_QTDE_VOLUMES write FTRAN_QTDE_VOLUMES;

    [Column('TRAN_ESPECIE', ftString, 100)]
    [Dictionary('TRAN_ESPECIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tran_especie: Nullable<String> read FTRAN_ESPECIE write FTRAN_ESPECIE;

    [Column('TRAN_MARCA', ftString, 100)]
    [Dictionary('TRAN_MARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tran_marca: Nullable<String> read FTRAN_MARCA write FTRAN_MARCA;

    [Column('TRAN_NUMERACAO', ftString, 100)]
    [Dictionary('TRAN_NUMERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tran_numeracao: Nullable<String> read FTRAN_NUMERACAO write FTRAN_NUMERACAO;

    [Restrictions([NotNull])]
    [Column('TRAN_PESO_BRUTO', ftBCD, 93, 6)]
    [Dictionary('TRAN_PESO_BRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property tran_peso_bruto: Double read FTRAN_PESO_BRUTO write FTRAN_PESO_BRUTO;

    [Restrictions([NotNull])]
    [Column('TRAN_PESO_LIQUIDO', ftBCD)]
    [Dictionary('TRAN_PESO_LIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property tran_peso_liquido: Double read FTRAN_PESO_LIQUIDO write FTRAN_PESO_LIQUIDO;

    [Restrictions([NotNull])]
    [Column('TOTAL_QUANTIDADE', ftBCD)]
    [Dictionary('TOTAL_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_quantidade: Double read FTOTAL_QUANTIDADE write FTOTAL_QUANTIDADE;

    [Restrictions([NotNull])]
    [Column('TOTAL_BRUTO', ftBCD, 93, 6)]
    [Dictionary('TOTAL_BRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_bruto: Double read FTOTAL_BRUTO write FTOTAL_BRUTO;

    [Restrictions([NotNull])]
    [Column('TOTAL_CRED_CSOSN', ftBCD)]
    [Dictionary('TOTAL_CRED_CSOSN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_cred_csosn: Double read FTOTAL_CRED_CSOSN write FTOTAL_CRED_CSOSN;

    [Restrictions([NotNull])]
    [Column('TOTAL_BASE_ICMS', ftBCD, 93, 6)]
    [Dictionary('TOTAL_BASE_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_base_icms: Double read FTOTAL_BASE_ICMS write FTOTAL_BASE_ICMS;

    [Restrictions([NotNull])]
    [Column('TOTAL_ICMS', ftBCD, 93, 6)]
    [Dictionary('TOTAL_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_icms: Double read FTOTAL_ICMS write FTOTAL_ICMS;

    [Restrictions([NotNull])]
    [Column('TOTAL_REDU_BASE', ftBCD)]
    [Dictionary('TOTAL_REDU_BASE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_redu_base: Double read FTOTAL_REDU_BASE write FTOTAL_REDU_BASE;

    [Restrictions([NotNull])]
    [Column('TOTAL_BASE_SUBTRIB', ftBCD, 495386624, 6)]
    [Dictionary('TOTAL_BASE_SUBTRIB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_base_subtrib: Double read FTOTAL_BASE_SUBTRIB write FTOTAL_BASE_SUBTRIB;

    [Restrictions([NotNull])]
    [Column('TOTAL_SUB_TRIB', ftBCD, 93, 6)]
    [Dictionary('TOTAL_SUB_TRIB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_sub_trib: Double read FTOTAL_SUB_TRIB write FTOTAL_SUB_TRIB;

    [Restrictions([NotNull])]
    [Column('TOTAL_BASE_PIS', ftBCD)]
    [Dictionary('TOTAL_BASE_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_base_pis: Double read FTOTAL_BASE_PIS write FTOTAL_BASE_PIS;

    [Restrictions([NotNull])]
    [Column('TOTAL_PIS', ftBCD, 93, 6)]
    [Dictionary('TOTAL_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_pis: Double read FTOTAL_PIS write FTOTAL_PIS;

    [Restrictions([NotNull])]
    [Column('TOTAL_BASE_COFINS', ftBCD)]
    [Dictionary('TOTAL_BASE_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_base_cofins: Double read FTOTAL_BASE_COFINS write FTOTAL_BASE_COFINS;

    [Restrictions([NotNull])]
    [Column('TOTAL_COFINS', ftBCD, 93, 6)]
    [Dictionary('TOTAL_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_cofins: Double read FTOTAL_COFINS write FTOTAL_COFINS;

    [Restrictions([NotNull])]
    [Column('TOTAL_BASE_IPI', ftBCD, 93, 6)]
    [Dictionary('TOTAL_BASE_IPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_base_ipi: Double read FTOTAL_BASE_IPI write FTOTAL_BASE_IPI;

    [Restrictions([NotNull])]
    [Column('TOTAL_IPI', ftBCD)]
    [Dictionary('TOTAL_IPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_ipi: Double read FTOTAL_IPI write FTOTAL_IPI;

    [Restrictions([NotNull])]
    [Column('TOTAL_BASE_ISSQN', ftBCD)]
    [Dictionary('TOTAL_BASE_ISSQN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_base_issqn: Double read FTOTAL_BASE_ISSQN write FTOTAL_BASE_ISSQN;

    [Restrictions([NotNull])]
    [Column('TOTAL_ISSQN', ftBCD)]
    [Dictionary('TOTAL_ISSQN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_issqn: Double read FTOTAL_ISSQN write FTOTAL_ISSQN;

    [Restrictions([NotNull])]
    [Column('TOTAL_BASE_II', ftBCD)]
    [Dictionary('TOTAL_BASE_II', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_base_ii: Double read FTOTAL_BASE_II write FTOTAL_BASE_II;

    [Restrictions([NotNull])]
    [Column('TOTAL_II_ADUANEIRA', ftBCD)]
    [Dictionary('TOTAL_II_ADUANEIRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_ii_aduaneira: Double read FTOTAL_II_ADUANEIRA write FTOTAL_II_ADUANEIRA;

    [Restrictions([NotNull])]
    [Column('TOTAL_II_IOF', ftBCD)]
    [Dictionary('TOTAL_II_IOF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_ii_iof: Double read FTOTAL_II_IOF write FTOTAL_II_IOF;

    [Restrictions([NotNull])]
    [Column('TOTAL_II', ftBCD)]
    [Dictionary('TOTAL_II', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_ii: Double read FTOTAL_II write FTOTAL_II;

    [Restrictions([NotNull])]
    [Column('TOTAL_ACRESCIMO', ftBCD, 93, 6)]
    [Dictionary('TOTAL_ACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_acrescimo: Double read FTOTAL_ACRESCIMO write FTOTAL_ACRESCIMO;

    [Restrictions([NotNull])]
    [Column('TOTAL_DESCONTO', ftBCD)]
    [Dictionary('TOTAL_DESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_desconto: Double read FTOTAL_DESCONTO write FTOTAL_DESCONTO;

    [Restrictions([NotNull])]
    [Column('TOTAL_CREDITO', ftBCD, 48, 6)]
    [Dictionary('TOTAL_CREDITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_credito: Double read FTOTAL_CREDITO write FTOTAL_CREDITO;

    [Column('CREDITO_DESC', ftString, 100)]
    [Dictionary('CREDITO_DESC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property credito_desc: Nullable<String> read FCREDITO_DESC write FCREDITO_DESC;

    [Restrictions([NotNull])]
    [Column('PERC_COMISSAO', ftBCD)]
    [Dictionary('PERC_COMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property perc_comissao: Double read FPERC_COMISSAO write FPERC_COMISSAO;

    [Restrictions([NotNull])]
    [Column('TOTAL_COMISSAO', ftBCD, 93, 6)]
    [Dictionary('TOTAL_COMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_comissao: Double read FTOTAL_COMISSAO write FTOTAL_COMISSAO;

    [Restrictions([NotNull])]
    [Column('TOTAL_FRETE', ftBCD, 93, 6)]
    [Dictionary('TOTAL_FRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_frete: Double read FTOTAL_FRETE write FTOTAL_FRETE;

    [Restrictions([NotNull])]
    [Column('TOTAL_SEGURO', ftBCD)]
    [Dictionary('TOTAL_SEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_seguro: Double read FTOTAL_SEGURO write FTOTAL_SEGURO;

    [Restrictions([NotNull])]
    [Column('TOTAL_DESPESA', ftBCD, 93, 6)]
    [Dictionary('TOTAL_DESPESA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_despesa: Double read FTOTAL_DESPESA write FTOTAL_DESPESA;

    [Restrictions([NotNull])]
    [Column('TOTAL_LIQUIDO', ftBCD)]
    [Dictionary('TOTAL_LIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_liquido: Double read FTOTAL_LIQUIDO write FTOTAL_LIQUIDO;

    [Restrictions([NotNull])]
    [Column('TOTAL_ISENTO', ftBCD)]
    [Dictionary('TOTAL_ISENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_isento: Double read FTOTAL_ISENTO write FTOTAL_ISENTO;

    [Restrictions([NotNull])]
    [Column('TOTAL_NAO_TRIBUT', ftBCD, 93, 6)]
    [Dictionary('TOTAL_NAO_TRIBUT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_nao_tribut: Double read FTOTAL_NAO_TRIBUT write FTOTAL_NAO_TRIBUT;

    [Restrictions([NotNull])]
    [Column('TOTAL_CANCELADO', ftBCD)]
    [Dictionary('TOTAL_CANCELADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_cancelado: Double read FTOTAL_CANCELADO write FTOTAL_CANCELADO;

    [Restrictions([NotNull])]
    [Column('CK_IPINAODEDUZDESCONTO', ftBoolean)]
    [Dictionary('CK_IPINAODEDUZDESCONTO', 'Mensagem de validação', 'false', '', '', taCenter)]
    property ck_ipinaodeduzdesconto: Boolean read FCK_IPINAODEDUZDESCONTO write FCK_IPINAODEDUZDESCONTO;

    [Column('NFE_CHAVE', ftString, 50)]
    [Dictionary('NFE_CHAVE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nfe_chave: Nullable<String> read FNFE_CHAVE write FNFE_CHAVE;

    [Column('NFE_NRO_PROTOCOLO', ftString, 15)]
    [Dictionary('NFE_NRO_PROTOCOLO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nfe_nro_protocolo: Nullable<String> read FNFE_NRO_PROTOCOLO write FNFE_NRO_PROTOCOLO;

    [Column('NFE_DTH_PROTOCOLO', ftDateTime)]
    [Dictionary('NFE_DTH_PROTOCOLO', 'Mensagem de validação', '', '', '', taCenter)]
    property nfe_dth_protocolo: Nullable<TDateTime> read FNFE_DTH_PROTOCOLO write FNFE_DTH_PROTOCOLO;

    [Column('NFE_FINALIDADE', ftString, 1)]
    [Dictionary('NFE_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nfe_finalidade: Nullable<String> read FNFE_FINALIDADE write FNFE_FINALIDADE;

    [Restrictions([NotNull])]
    [Column('NFE_INDFINAL', ftBoolean)]
    [Dictionary('NFE_INDFINAL', 'Mensagem de validação', 'false', '', '', taCenter)]
    property nfe_indfinal: Boolean read FNFE_INDFINAL write FNFE_INDFINAL;

    [Restrictions([NotNull])]
    [Column('NFE_INDPRES', ftInteger)]
    [Dictionary('NFE_INDPRES', 'Mensagem de validação', '0', '', '', taCenter)]
    property nfe_indpres: Integer read FNFE_INDPRES write FNFE_INDPRES;

    [Column('IND_EMITENTE', ftString, 1)]
    [Dictionary('IND_EMITENTE', 'Mensagem de validação', '0', '', '', taLeftJustify)]
    property ind_emitente: Nullable<String> read FIND_EMITENTE write FIND_EMITENTE;

    [Column('IND_PGTO', ftString, 1)]
    [Dictionary('IND_PGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ind_pgto: Nullable<String> read FIND_PGTO write FIND_PGTO;

    [Column('IND_FRETE', ftString, 1)]
    [Dictionary('IND_FRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ind_frete: Nullable<String> read FIND_FRETE write FIND_FRETE;

    [Column('IND_NAT_FRETE', ftString, 1)]
    [Dictionary('IND_NAT_FRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ind_nat_frete: Nullable<String> read FIND_NAT_FRETE write FIND_NAT_FRETE;

    [Restrictions([NotNull])]
    [Column('CK_CSOSN', ftBoolean)]
    [Dictionary('CK_CSOSN', 'Mensagem de validação', 'false', '', '', taCenter)]
    property ck_csosn: Boolean read FCK_CSOSN write FCK_CSOSN;

    [Restrictions([NotNull])]
    [Column('ICMSNAOSOMADESPESAS', ftBoolean)]
    [Dictionary('ICMSNAOSOMADESPESAS', 'Mensagem de validação', 'false', '', '', taCenter)]
    property icmsnaosomadespesas: Boolean read FICMSNAOSOMADESPESAS write FICMSNAOSOMADESPESAS;

    [Restrictions([NotNull])]
    [Column('IPINAOSOMADESPESAS', ftBoolean)]
    [Dictionary('IPINAOSOMADESPESAS', 'Mensagem de validação', 'false', '', '', taCenter)]
    property ipinaosomadespesas: Boolean read FIPINAOSOMADESPESAS write FIPINAOSOMADESPESAS;

    [Restrictions([NotNull])]
    [Column('IPIDEDUZDESCONTO', ftBoolean)]
    [Dictionary('IPIDEDUZDESCONTO', 'Mensagem de validação', 'false', '', '', taCenter)]
    property ipideduzdesconto: Boolean read FIPIDEDUZDESCONTO write FIPIDEDUZDESCONTO;

    [Column('CTE_TIPO', ftString, 1)]
    [Dictionary('CTE_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cte_tipo: Nullable<String> read FCTE_TIPO write FCTE_TIPO;

    [Column('ID_USUARIO_ALT', ftInteger)]
    [Dictionary('ID_USUARIO_ALT', 'Mensagem de validação', '', '', '', taCenter)]
    property id_usuario_alt: Nullable<Integer> read FID_USUARIO_ALT write FID_USUARIO_ALT;

    [Restrictions([NotNull])]
    [Column('COMISSAO', ftBCD)]
    [Dictionary('COMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property comissao: Double read FCOMISSAO write FCOMISSAO;

    [Column('EXP_UF_SAIDA', ftString, 2)]
    [Dictionary('EXP_UF_SAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property exp_uf_saida: Nullable<String> read FEXP_UF_SAIDA write FEXP_UF_SAIDA;

    [Column('EXP_LOC_EXPORTA', ftString, 100)]
    [Dictionary('EXP_LOC_EXPORTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property exp_loc_exporta: Nullable<String> read FEXP_LOC_EXPORTA write FEXP_LOC_EXPORTA;

    [Column('EXP_LOCAL_DESPACHO', ftString, 100)]
    [Dictionary('EXP_LOCAL_DESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property exp_local_despacho: Nullable<String> read FEXP_LOCAL_DESPACHO write FEXP_LOCAL_DESPACHO;

    [Restrictions([NotNull])]
    [Column('ID_ORIGEM', ftInteger)]
    [Dictionary('ID_ORIGEM', 'Mensagem de validação', '', '', '', taCenter)]
    property id_origem: Integer read FID_ORIGEM write FID_ORIGEM;

    [Restrictions([NotNull])]
    [Column('REVENDA', ftBoolean)]
    [Dictionary('REVENDA', 'Mensagem de validação', 'false', '', '', taCenter)]
    property revenda: Boolean read FREVENDA write FREVENDA;

    [Column('ST_TABELA', ftString, 100)]
    [Dictionary('ST_TABELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property st_tabela: Nullable<String> read FST_TABELA write FST_TABELA;

    [Column('ID_COD_TABELA', ftInteger)]
    [Dictionary('ID_COD_TABELA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_cod_tabela: Nullable<Integer> read FID_COD_TABELA write FID_COD_TABELA;

    [Restrictions([NotNull])]
    [Column('CANCELADA', ftString, 1)]
    [Dictionary('CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cancelada: String read FCANCELADA write FCANCELADA;

    [Restrictions([NotNull])]
    [Column('CONTIGENCIA', ftBoolean)]
    [Dictionary('CONTIGENCIA', 'Mensagem de validação', 'false', '', '', taCenter)]
    property contigencia: Boolean read FCONTIGENCIA write FCONTIGENCIA;

    [Column('MOTIVO_CANC', ftString, 8000)]
    [Dictionary('MOTIVO_CANC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property motivo_canc: Nullable<String> read FMOTIVO_CANC write FMOTIVO_CANC;

    [Restrictions([NotNull])]
    [Column('STATUS', ftString, 1)]
    [Dictionary('STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property status: String read FSTATUS write FSTATUS;

    [Column('OBS', ftString, 8000)]
    [Dictionary('OBS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property obs: Nullable<String> read FOBS write FOBS;

    [Restrictions([NotNull])]
    [Column('VALOR_FCP', ftBCD, 2555944, 6)]
    [Dictionary('VALOR_FCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property valor_fcp: Double read FVALOR_FCP write FVALOR_FCP;

    [Restrictions([NotNull])]
    [Column('VALOR_ICMS_UF_DEST', ftBCD, 5242957, 6)]
    [Dictionary('VALOR_ICMS_UF_DEST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property valor_icms_uf_dest: Double read FVALOR_ICMS_UF_DEST write FVALOR_ICMS_UF_DEST;

    [Restrictions([NotNull])]
    [Column('VALOR_ICMS_UF_REMET', ftBCD, 4259920, 6)]
    [Dictionary('VALOR_ICMS_UF_REMET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property valor_icms_uf_remet: Double read FVALOR_ICMS_UF_REMET write FVALOR_ICMS_UF_REMET;

    [Column('COD_DOC_IMP', ftString, 1)]
    [Dictionary('COD_DOC_IMP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cod_doc_imp: Nullable<String> read FCOD_DOC_IMP write FCOD_DOC_IMP;

    [Column('NUM_DOC_IMP', ftString, 15)]
    [Dictionary('NUM_DOC_IMP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property num_doc_imp: Nullable<String> read FNUM_DOC_IMP write FNUM_DOC_IMP;

    [Column('NUM_ACDRAW', ftString, 50)]
    [Dictionary('NUM_ACDRAW', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property num_acdraw: Nullable<String> read FNUM_ACDRAW write FNUM_ACDRAW;

    [Restrictions([NotNull])]
    [Column('TROCO', ftBCD, 852027, 6)]
    [Dictionary('TROCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property troco: Double read FTROCO write FTROCO;

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

    [Column('ID_INTERMEDIADOR', ftInteger)]
    [Dictionary('ID_INTERMEDIADOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property id_intermediador: Nullable<Int64> read FID_INTERMEDIADOR write FID_INTERMEDIADOR;

    [Association(TMultiplicity.OneToMany, 'ID_PDV_NOTAS_FISCAIS_CAB',
    'PDV_NOTAS_FISCAIS_ITEM', 'ID_PDV_NOTAS_FISCAIS_CAB')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property PDV_NOTAS_FISCAIS_ITEM: TObjectList<TPDV_NOTAS_FISCAIS_ITEM> read FPDV_NOTAS_FISCAIS_ITEM write FPDV_NOTAS_FISCAIS_ITEM;
  end;

implementation

constructor TPDV_NOTAS_FISCAIS_CAB.Create;
begin
  FPDV_NOTAS_FISCAIS_ITEM := TObjectList<TPDV_NOTAS_FISCAIS_ITEM>.Create;
end;

destructor TPDV_NOTAS_FISCAIS_CAB.Destroy;
begin
  FreeAndNil(FPDV_NOTAS_FISCAIS_ITEM);
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TPDV_NOTAS_FISCAIS_CAB)

end.
