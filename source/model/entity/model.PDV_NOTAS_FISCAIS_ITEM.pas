unit model.pdv_notas_fiscais_item;

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
  dbcbr.mapping.classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes;

type
  [Entity]
  [Table('PDV_NOTAS_FISCAIS_ITEM', '')]
  [PrimaryKey('ID_PDV_NOTAS_FISCAIS_ITEM', TAutoIncType.AutoInc,
                                           TGeneratorType.TableInc,
                                           TSortingOrder.NoSort,
                                           True, 'Chave primária')]
  [OrderBy('ID_PDV_NOTAS_FISCAIS_ITEM')]
  TPDV_NOTAS_FISCAIS_ITEM = class
  private
    { Private declarations } 
    FID_PDV_NOTAS_FISCAIS_ITEM: Nullable<Integer>;
    FID_PDV_NOTAS_FISCAIS_CAB: Integer;
    FID_DAV_CABECALHO: Nullable<Integer>;
    FID_PRE_VENDA_CABECALHO: Nullable<Integer>;
    FID_PEDIDO_VENDA: Nullable<Integer>;
    FID_CONSIGNACAO: Nullable<Integer>;
    FID_NATUREZA_OPERACAO: Integer;
    FID_COLABORADOR: Int64;
    FITEM: Integer;
    FID_SKU: Integer;
    FGTIN_PRODUTO: Nullable<String>;
    FID_PRODUTO: Integer;
    FDESCRICAO: Nullable<String>;
    FID_UNIDADE_PRODUTO: Integer;
    FQUANTIDADE: Double;
    FVALOR_UNITARIO: Double;
    FPRECO_TABELA: Double;
    FDESCONTO: Double;
    FACRESCIMO: Double;
    FCSOSN: Nullable<String>;
    FPERC_CRED_CSOSN: Double;
    FTOTAL_CRED_CSOSN: Double;
    FCST_ICMS: Nullable<String>;
    FBASE_ICMS: Double;
    FALIQ_ICMS: Double;
    FTOTAL_ICMS: Double;
    FPERC_REDU_BASE: Double;
    FVALOR_REDU_BASE: Double;
    FBASE_ISENTO: Double;
    FCOD_NTRIBUT: String;
    FBASE_NAO_TRIBUT: Double;
    FBASE_SUB_TRIB: Double;
    FMVA_SUB_TRIB: Double;
    FALIQ_SUBTRIB: Double;
    FTOTAL_SUB_TRIB: Double;
    FCST_PIS: Nullable<String>;
    FALIQ_PIS: Double;
    FBASE_PIS: Double;
    FTOTAL_PIS: Double;
    FCST_COFINS: Nullable<String>;
    FBASE_COFINS: Double;
    FALIQ_COFINS: Double;
    FTOTAL_COFINS: Double;
    FCST_IPI: Nullable<String>;
    FBASE_IPI: Double;
    FALIQ_IPI: Double;
    FTOTAL_IPI: Double;
    FBASE_ISSQN: Double;
    FALIQ_ISSQN: Double;
    FTOTAL_ISSQN: Double;
    FBASE_II: Double;
    FALIQ_II: Double;
    FTOTAL_II_ADUANEIRA: Double;
    FTOTAL_II_IOF: Double;
    FTOTAL_II: Double;
    FTOTAL_BRUTO: Double;
    FTOTAL_ACRESCIMO: Double;
    FTOTAL_DESCONTO: Double;
    FTOTAL_CREDITO: Double;
    FTOTAL_COMISSAO: Double;
    FTOTAL_FRETE: Double;
    FTOTAL_SEGURO: Double;
    FTOTAL_DESPESA: Double;
    FPRECO_LIQUIDO: Double;
    FTOTAL_LIQUIDO: Double;
    FPRECO_CUSTO: Double;
    FPRECO_UNITARIO: Double;
    FPRECO_UNITARIO_MEDIO: Double;
    FCUSTO_CONTABIL: Double;
    FCUSTO_LIQUIDO: Double;
    FCUSTO_REAL: Double;
    FCUSTO_MEDIO: Double;
    FIND_MOV: Nullable<String>;
    FCANCELADO: String;
    FFCP: Double;
    FALIQ_INTERNA: Double;
    FALIQ_INTERESTADUAL: Double;
    FBASE_DIF_ALIQ: Double;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;
    FRESERVADO: Boolean;
    FPRESENTE: Boolean;
    FPROMOCAO: Boolean;
    FMARCA: Boolean;
    FBLOQUEADO: Boolean;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

    [Column('ID_PDV_NOTAS_FISCAIS_ITEM', ftInteger)]
    [Dictionary('ID_PDV_NOTAS_FISCAIS_ITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pdv_notas_fiscais_item: Nullable<Integer> read FID_PDV_NOTAS_FISCAIS_ITEM write FID_PDV_NOTAS_FISCAIS_ITEM;

    [Restrictions([NotNull])]
    [Column('ID_PDV_NOTAS_FISCAIS_CAB', ftInteger)]
    [Dictionary('ID_PDV_NOTAS_FISCAIS_CAB', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pdv_notas_fiscais_cab: Integer read FID_PDV_NOTAS_FISCAIS_CAB write FID_PDV_NOTAS_FISCAIS_CAB;

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
    [Column('ID_NATUREZA_OPERACAO', ftInteger)]
    [Dictionary('ID_NATUREZA_OPERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_natureza_operacao: Integer read FID_NATUREZA_OPERACAO write FID_NATUREZA_OPERACAO;

    [Restrictions([NotNull])]
    [Column('ID_COLABORADOR', ftInteger)]
    [Dictionary('ID_COLABORADOR', 'Mensagem de validação', '', '', '', taCenter)]
    property id_colaborador: Int64 read FID_COLABORADOR write FID_COLABORADOR;

    [Restrictions([NotNull])]
    [Column('ITEM', ftInteger)]
    [Dictionary('ITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property item: Integer read FITEM write FITEM;

    [Restrictions([NotNull])]
    [Column('ID_SKU', ftInteger)]
    [Dictionary('ID_SKU', 'Mensagem de validação', '', '', '', taCenter)]
    property id_sku: Integer read FID_SKU write FID_SKU;

    [Column('GTIN_PRODUTO', ftString, 15)]
    [Dictionary('GTIN_PRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property gtin_produto: Nullable<String> read FGTIN_PRODUTO write FGTIN_PRODUTO;

    [Restrictions([NotNull])]
    [Column('ID_PRODUTO', ftInteger)]
    [Dictionary('ID_PRODUTO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_produto: Integer read FID_PRODUTO write FID_PRODUTO;

    [Column('DESCRICAO', ftString, 8000)]
    [Dictionary('DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property descricao: Nullable<String> read FDESCRICAO write FDESCRICAO;

    [Restrictions([NotNull])]
    [Column('ID_UNIDADE_PRODUTO', ftInteger)]
    [Dictionary('ID_UNIDADE_PRODUTO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_unidade_produto: Integer read FID_UNIDADE_PRODUTO write FID_UNIDADE_PRODUTO;

    [Restrictions([NotNull])]
    [Column('QUANTIDADE', ftBCD, 93, 6)]
    [Dictionary('QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property quantidade: Double read FQUANTIDADE write FQUANTIDADE;

    [Restrictions([NotNull])]
    [Column('VALOR_UNITARIO', ftBCD)]
    [Dictionary('VALOR_UNITARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property valor_unitario: Double read FVALOR_UNITARIO write FVALOR_UNITARIO;

    [Restrictions([NotNull])]
    [Column('PRECO_TABELA', ftBCD, 93, 6)]
    [Dictionary('PRECO_TABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property preco_tabela: Double read FPRECO_TABELA write FPRECO_TABELA;

    [Restrictions([NotNull])]
    [Column('DESCONTO', ftBCD, 93, 6)]
    [Dictionary('DESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property desconto: Double read FDESCONTO write FDESCONTO;

    [Restrictions([NotNull])]
    [Column('ACRESCIMO', ftBCD)]
    [Dictionary('ACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property acrescimo: Double read FACRESCIMO write FACRESCIMO;

    [Column('CSOSN', ftString, 5)]
    [Dictionary('CSOSN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property csosn: Nullable<String> read FCSOSN write FCSOSN;

    [Restrictions([NotNull])]
    [Column('PERC_CRED_CSOSN', ftBCD)]
    [Dictionary('PERC_CRED_CSOSN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property perc_cred_csosn: Double read FPERC_CRED_CSOSN write FPERC_CRED_CSOSN;

    [Restrictions([NotNull])]
    [Column('TOTAL_CRED_CSOSN', ftBCD, 93, 6)]
    [Dictionary('TOTAL_CRED_CSOSN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_cred_csosn: Double read FTOTAL_CRED_CSOSN write FTOTAL_CRED_CSOSN;

    [Column('CST_ICMS', ftString, 3)]
    [Dictionary('CST_ICMS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cst_icms: Nullable<String> read FCST_ICMS write FCST_ICMS;

    [Restrictions([NotNull])]
    [Column('BASE_ICMS', ftBCD)]
    [Dictionary('BASE_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_icms: Double read FBASE_ICMS write FBASE_ICMS;

    [Restrictions([NotNull])]
    [Column('ALIQ_ICMS', ftBCD)]
    [Dictionary('ALIQ_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_icms: Double read FALIQ_ICMS write FALIQ_ICMS;

    [Restrictions([NotNull])]
    [Column('TOTAL_ICMS', ftBCD, 93, 6)]
    [Dictionary('TOTAL_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_icms: Double read FTOTAL_ICMS write FTOTAL_ICMS;

    [Restrictions([NotNull])]
    [Column('PERC_REDU_BASE', ftBCD)]
    [Dictionary('PERC_REDU_BASE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property perc_redu_base: Double read FPERC_REDU_BASE write FPERC_REDU_BASE;

    [Restrictions([NotNull])]
    [Column('VALOR_REDU_BASE', ftBCD)]
    [Dictionary('VALOR_REDU_BASE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property valor_redu_base: Double read FVALOR_REDU_BASE write FVALOR_REDU_BASE;

    [Restrictions([NotNull])]
    [Column('BASE_ISENTO', ftBCD)]
    [Dictionary('BASE_ISENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_isento: Double read FBASE_ISENTO write FBASE_ISENTO;

    [Restrictions([NotNull])]
    [Column('COD_NTRIBUT', ftString, 1)]
    [Dictionary('COD_NTRIBUT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cod_ntribut: String read FCOD_NTRIBUT write FCOD_NTRIBUT;

    [Restrictions([NotNull])]
    [Column('BASE_NAO_TRIBUT', ftBCD)]
    [Dictionary('BASE_NAO_TRIBUT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_nao_tribut: Double read FBASE_NAO_TRIBUT write FBASE_NAO_TRIBUT;

    [Restrictions([NotNull])]
    [Column('BASE_SUB_TRIB', ftBCD)]
    [Dictionary('BASE_SUB_TRIB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_sub_trib: Double read FBASE_SUB_TRIB write FBASE_SUB_TRIB;

    [Restrictions([NotNull])]
    [Column('MVA_SUB_TRIB', ftBCD)]
    [Dictionary('MVA_SUB_TRIB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property mva_sub_trib: Double read FMVA_SUB_TRIB write FMVA_SUB_TRIB;

    [Restrictions([NotNull])]
    [Column('ALIQ_SUBTRIB', ftBCD)]
    [Dictionary('ALIQ_SUBTRIB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_subtrib: Double read FALIQ_SUBTRIB write FALIQ_SUBTRIB;

    [Restrictions([NotNull])]
    [Column('TOTAL_SUB_TRIB', ftBCD)]
    [Dictionary('TOTAL_SUB_TRIB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_sub_trib: Double read FTOTAL_SUB_TRIB write FTOTAL_SUB_TRIB;

    [Column('CST_PIS', ftString, 2)]
    [Dictionary('CST_PIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cst_pis: Nullable<String> read FCST_PIS write FCST_PIS;

    [Restrictions([NotNull])]
    [Column('ALIQ_PIS', ftBCD)]
    [Dictionary('ALIQ_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_pis: Double read FALIQ_PIS write FALIQ_PIS;

    [Restrictions([NotNull])]
    [Column('BASE_PIS', ftBCD, 48, 6)]
    [Dictionary('BASE_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_pis: Double read FBASE_PIS write FBASE_PIS;

    [Restrictions([NotNull])]
    [Column('TOTAL_PIS', ftBCD, 93, 6)]
    [Dictionary('TOTAL_PIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_pis: Double read FTOTAL_PIS write FTOTAL_PIS;

    [Column('CST_COFINS', ftString, 2)]
    [Dictionary('CST_COFINS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cst_cofins: Nullable<String> read FCST_COFINS write FCST_COFINS;

    [Restrictions([NotNull])]
    [Column('BASE_COFINS', ftBCD)]
    [Dictionary('BASE_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_cofins: Double read FBASE_COFINS write FBASE_COFINS;

    [Restrictions([NotNull])]
    [Column('ALIQ_COFINS', ftBCD, 495386624, 6)]
    [Dictionary('ALIQ_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_cofins: Double read FALIQ_COFINS write FALIQ_COFINS;

    [Restrictions([NotNull])]
    [Column('TOTAL_COFINS', ftBCD, 93, 6)]
    [Dictionary('TOTAL_COFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_cofins: Double read FTOTAL_COFINS write FTOTAL_COFINS;

    [Column('CST_IPI', ftString, 2)]
    [Dictionary('CST_IPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cst_ipi: Nullable<String> read FCST_IPI write FCST_IPI;

    [Restrictions([NotNull])]
    [Column('BASE_IPI', ftBCD)]
    [Dictionary('BASE_IPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_ipi: Double read FBASE_IPI write FBASE_IPI;

    [Restrictions([NotNull])]
    [Column('ALIQ_IPI', ftBCD, 93, 6)]
    [Dictionary('ALIQ_IPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_ipi: Double read FALIQ_IPI write FALIQ_IPI;

    [Restrictions([NotNull])]
    [Column('TOTAL_IPI', ftBCD)]
    [Dictionary('TOTAL_IPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_ipi: Double read FTOTAL_IPI write FTOTAL_IPI;

    [Restrictions([NotNull])]
    [Column('BASE_ISSQN', ftBCD, 93, 6)]
    [Dictionary('BASE_ISSQN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_issqn: Double read FBASE_ISSQN write FBASE_ISSQN;

    [Restrictions([NotNull])]
    [Column('ALIQ_ISSQN', ftBCD, 93, 6)]
    [Dictionary('ALIQ_ISSQN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_issqn: Double read FALIQ_ISSQN write FALIQ_ISSQN;

    [Restrictions([NotNull])]
    [Column('TOTAL_ISSQN', ftBCD)]
    [Dictionary('TOTAL_ISSQN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_issqn: Double read FTOTAL_ISSQN write FTOTAL_ISSQN;

    [Restrictions([NotNull])]
    [Column('BASE_II', ftBCD)]
    [Dictionary('BASE_II', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_ii: Double read FBASE_II write FBASE_II;

    [Restrictions([NotNull])]
    [Column('ALIQ_II', ftBCD)]
    [Dictionary('ALIQ_II', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_ii: Double read FALIQ_II write FALIQ_II;

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
    [Column('TOTAL_BRUTO', ftBCD)]
    [Dictionary('TOTAL_BRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_bruto: Double read FTOTAL_BRUTO write FTOTAL_BRUTO;

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

    [Restrictions([NotNull])]
    [Column('TOTAL_COMISSAO', ftBCD)]
    [Dictionary('TOTAL_COMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_comissao: Double read FTOTAL_COMISSAO write FTOTAL_COMISSAO;

    [Restrictions([NotNull])]
    [Column('TOTAL_FRETE', ftBCD, 93, 6)]
    [Dictionary('TOTAL_FRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_frete: Double read FTOTAL_FRETE write FTOTAL_FRETE;

    [Restrictions([NotNull])]
    [Column('TOTAL_SEGURO', ftBCD, 93, 6)]
    [Dictionary('TOTAL_SEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_seguro: Double read FTOTAL_SEGURO write FTOTAL_SEGURO;

    [Restrictions([NotNull])]
    [Column('TOTAL_DESPESA', ftBCD)]
    [Dictionary('TOTAL_DESPESA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_despesa: Double read FTOTAL_DESPESA write FTOTAL_DESPESA;

    [Restrictions([NotNull])]
    [Column('PRECO_LIQUIDO', ftBCD, 93, 6)]
    [Dictionary('PRECO_LIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property preco_liquido: Double read FPRECO_LIQUIDO write FPRECO_LIQUIDO;

    [Restrictions([NotNull])]
    [Column('TOTAL_LIQUIDO', ftBCD)]
    [Dictionary('TOTAL_LIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_liquido: Double read FTOTAL_LIQUIDO write FTOTAL_LIQUIDO;

    [Restrictions([NotNull])]
    [Column('PRECO_CUSTO', ftBCD)]
    [Dictionary('PRECO_CUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property preco_custo: Double read FPRECO_CUSTO write FPRECO_CUSTO;

    [Restrictions([NotNull])]
    [Column('PRECO_UNITARIO', ftBCD, 93, 6)]
    [Dictionary('PRECO_UNITARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property preco_unitario: Double read FPRECO_UNITARIO write FPRECO_UNITARIO;

    [Restrictions([NotNull])]
    [Column('PRECO_UNITARIO_MEDIO', ftBCD)]
    [Dictionary('PRECO_UNITARIO_MEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property preco_unitario_medio: Double read FPRECO_UNITARIO_MEDIO write FPRECO_UNITARIO_MEDIO;

    [Restrictions([NotNull])]
    [Column('CUSTO_CONTABIL', ftBCD, 496435200, 6)]
    [Dictionary('CUSTO_CONTABIL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property custo_contabil: Double read FCUSTO_CONTABIL write FCUSTO_CONTABIL;

    [Restrictions([NotNull])]
    [Column('CUSTO_LIQUIDO', ftBCD)]
    [Dictionary('CUSTO_LIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property custo_liquido: Double read FCUSTO_LIQUIDO write FCUSTO_LIQUIDO;

    [Restrictions([NotNull])]
    [Column('CUSTO_REAL', ftBCD)]
    [Dictionary('CUSTO_REAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property custo_real: Double read FCUSTO_REAL write FCUSTO_REAL;

    [Restrictions([NotNull])]
    [Column('CUSTO_MEDIO', ftBCD, 93, 6)]
    [Dictionary('CUSTO_MEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property custo_medio: Double read FCUSTO_MEDIO write FCUSTO_MEDIO;

    [Column('IND_MOV', ftString, 1)]
    [Dictionary('IND_MOV', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ind_mov: Nullable<String> read FIND_MOV write FIND_MOV;

    [Restrictions([NotNull])]
    [Column('RESERVADO', ftBoolean)]
    [Dictionary('RESERVADO', 'Mensagem de validação', 'false', '', '', taLeftJustify)]
    property reservado: Boolean read FRESERVADO write FRESERVADO;

    [Restrictions([NotNull])]
    [Column('PRESENTE', ftBoolean)]
    [Dictionary('PRESENTE', 'Mensagem de validação', 'false', '', '', taLeftJustify)]
    property presente: Boolean read FPRESENTE write FPRESENTE;

    [Restrictions([NotNull])]
    [Column('PROMOCAO', ftBoolean)]
    [Dictionary('PROMOCAO', 'Mensagem de validação', 'false', '', '', taLeftJustify)]
    property promocao: Boolean read FPROMOCAO write FPROMOCAO;

    [Restrictions([NotNull])]
    [Column('CANCELADO', ftString, 1)]
    [Dictionary('CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cancelado: String read FCANCELADO write FCANCELADO;

    [Restrictions([NotNull])]
    [Column('FCP', ftBCD)]
    [Dictionary('FCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property fcp: Double read FFCP write FFCP;

    [Restrictions([NotNull])]
    [Column('ALIQ_INTERNA', ftBCD)]
    [Dictionary('ALIQ_INTERNA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_interna: Double read FALIQ_INTERNA write FALIQ_INTERNA;

    [Restrictions([NotNull])]
    [Column('ALIQ_INTERESTADUAL', ftBCD)]
    [Dictionary('ALIQ_INTERESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property aliq_interestadual: Double read FALIQ_INTERESTADUAL write FALIQ_INTERESTADUAL;

    [Restrictions([NotNull])]
    [Column('BASE_DIF_ALIQ', ftBCD)]
    [Dictionary('BASE_DIF_ALIQ', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property base_dif_aliq: Double read FBASE_DIF_ALIQ write FBASE_DIF_ALIQ;

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
    [Dictionary('MARCA', 'Mensagem de validação', 'false', '', '', taLeftJustify)]
    property marca: Boolean read FMARCA write FMARCA;

    [Restrictions([NotNull])]
    [Column('BLOQUEADO', ftBoolean)]
    [Dictionary('BLOQUEADO', 'Mensagem de validação', 'false', '', '', taLeftJustify)]
    property bloqueado: Boolean read FBLOQUEADO write FBLOQUEADO;

  end;

implementation

constructor TPDV_NOTAS_FISCAIS_ITEM.Create;
begin
  //
end;

destructor TPDV_NOTAS_FISCAIS_ITEM.Destroy;
begin
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TPDV_NOTAS_FISCAIS_ITEM)

end.
