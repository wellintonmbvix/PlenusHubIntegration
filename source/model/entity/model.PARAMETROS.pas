unit model.parametros;

interface

uses
  DB,
  Classes,
  SysUtils,
  Generics.Collections,

  /// orm
  ormbr.types.blob,
  ormbr.types.lazy,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.Classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes;

type

  [Entity]
  [Table('PARAMETROS', '')]
  TPARAMETROS = class
  private
    FCAMINHO_IMP_MATRICIAL_ROMANEIO: String;
    FFTP_PADRAO_CAMINHO: nullable<String>;
    FCTG_CCD_INFORMAR_QTD: Boolean;
    FMAXIMO_PARCELAS_COMPRA_FUNC: nullable<Integer>;
    FID_TRANSPORTADORA_LOJA_VIRTUAL: nullable<Integer>;
    FCODIGO_NBS: nullable<String>;
    FCI_NFCE: Boolean;
    FCONSIDERAR_FATURAMENTO_COLABORADOR_COMISSAO: Integer;
    FID_SUBCLASSE_CONTA_CRECEBER: Integer;
    FULTIMO_CAMINHO_XML_NFE: nullable<String>;
    FID_SUBCLASSE_CONTA_CREDITO_ACORDO: Integer;
    FQTD_MESES_MEDIA_VENDA: Integer;
    FMARKUP_MINIMO_ORCAMENTO: Double;
    FMOSTRAR_MARKUP_ORCAMENTO: Boolean;
    FLIB_VENDA_SEM_CLI_CART: Boolean;
    FCOMERCIALIZA_LOJA_VIRTUAL: Boolean;
    FMARKUP_PRECO_EQUILIBRIO: Double;
    FBLOQ_ALT_CREDITO_SUSPENSO: Boolean;
    FDIAS_INTERVALO_FINANCEIRA: Integer;
    FCALCULA_PRECO_POR_MARKUP: Boolean;
    FETQ_PRAZO_TROCA: Integer;
    FCRECEBER_PERC_MULTA2: Double;
    FLIB_ITEM_SERVICO_ECF: Boolean;
    FLIB_NFE_PFISICA: Boolean;
    FCRECEBER_PERC_MULTA3: Double;
    FCRECEBER_PERC_ANTECIPACAO_DIA: Double;
    FBLOQ_ALT_PRECOVENDA_ENTRADA: Boolean;
    FUTILIZAR_MULTIPLOS_CAIXAS: Boolean;
    FINIBIR_ACRESCIMO_ITEM: Boolean;
    FHORARIO_VERAO: Boolean;
    FNFCE_SEM_ACAO_POS_AUTORIZACAO: Boolean;
    FCRECEBER_COMPETENCIA_POR: nullable<String>;
    FLIB_VENDA_SEM_ESTOQUE: Boolean;
    FSENHA_NAPP: nullable<String>;
    FATUALIZA_NCM_CEST_PRODUTO: Integer;
    FNFCE_IMP_POS_AUTORIZACAO: Boolean;
    FID_SUBCLASSE_CONTA_CREDITO_ACRESCIMO: Integer;
    FID_SUBCLASSE_CONTA_CREDITO_DESCONTO: Integer;
    FID_SUBCLASSE_CONTA_DEBITO_ANTECIPACAO: Integer;
    FFTP_PROPRIO_SENHA: nullable<String>;
    FCRECEBER_ATRASO_ATE2: Integer;
    FCRECEBER_PERC_MULTA1: Double;
    FCRECEBER_PERC_MAXIMO_ARREDONDAMENTO: Double;
    FMARKUP_PADRAO: Double;
    FCONTROLAR_GAVETA: Boolean;
    FDESCONTAR_CHQ_DEV_COMISSAO: Boolean;
    FLIB_TRANSF_SEM_ESTOQUE: Boolean;
    FCRECEBER_ATRASO_ATE3: Integer;
    FCUPOM_NEGATIVO_COMISSAO: Boolean;
    FBLOQ_LIMITE_CREDITO: Boolean;
    FID_COLABORADOR_LOJA_VIRTUAL: nullable<Int64>;
    FDT_ALT: TDateTime;
    FID_SUBCLASSE_CONTA_DEBITO_ACORDO: Integer;
    FCRECEBER_ATRASO_ATE1: Integer;
    FID_PRODUTO_TABELA_COMPRA_FUNC: Integer;
    FTIPO_PESQUISAPRODUTO: Integer;
    FDT_INC: TDateTime;
    FID_PRODUTO_TABELA_PADRAO: Integer;
    FID_SUBCLASSE_CONTA_CPAGAR: Integer;
    FCAMINHO_PADRAO_XML_NFE: nullable<String>;
    FDESTACA_DESCONTO_PROMOCAO: Boolean;
    FID_PARAMETROS: nullable<Integer>;
    FIMP_APLICACAO_PROD_NFE: Boolean;
    FCTG_CCD_CANC_QTD_TOTAL: Boolean;
    FVALIDAR_TIPOVENDA_CLIENTE: Boolean;
    FID_CONTA_BANCO: nullable<Integer>;
    FEXPORTA_NAPP: Integer;
    FCRECEBER_ATRASO_DE2: Integer;
    FLIB_VENDA_SEM_CLI_CHEQ: Boolean;
    FUSUARIO_NAPP: nullable<String>;
    FBLOQ_ABERTURA_CAIXA_SALDO_DIFERENTE: Boolean;
    FCAMINHO_BACKUP_BD: TBlob;
    FID_SUBCLASSE_CONTA_FRETE: Integer;
    FETQ_TEMPERATURA: Integer;
    FFTP_PROPRIO_USUARIO: nullable<String>;
    FCRECEBER_ATRASO_DE3: Integer;
    FID_EMPRESA_LOJA_VIRTUAL: nullable<Integer>;
    FID_SUBCLASSE_CONTA_DEBITO_ACRESCIMO: Integer;
    FID_SUBCLASSE_CONTA_DEBITO_DESCONTO: Integer;
    FDT_HAB: nullable<TDateTime>;
    FFTP_PROPRIO_ENDERECO: nullable<String>;
    FCRECEBER_ATRASO_DE1: Integer;
    FMAXIMO_PECAS_ITEM_VENDA: Integer;
    FCODIGO_NCM: nullable<String>;
    FBLOQUEADO: Boolean;
    FTIPO_DATA_CRECEBER: Integer;
    FFTP_TIPO: Boolean;
    FCRECEBER_PERC_JUROS_DIA2: Double;
    FCRECEBER_CONTRATO: nullable<String>;
    FMAXIMO_DIAS_ALT_VENC_VENDA: Integer;
    FBLOQ_VENDA_SEM_INDICACAO: Boolean;
    FALIQ_ISS: Double;
    FID_EMPRESA_SERVICO: nullable<Integer>;
    FUTILIZAR_IMP_MATRICIAL_ROMANEIO: Boolean;
    FETQ_MENSAGEM: nullable<String>;
    FCRECEBER_PERC_JUROS_DIA3: Double;
    FIMP_DESCRICAO_RESUMIDA_PROD_NFE: Boolean;
    FPEDIDO_COMPRA_OBRIGATORIO: Boolean;
    FDESCONSIDERAR_CHEQ_LIMITE_CREDITO: Boolean;
    FBLOQ_LIST_FECH_CAIXA: Boolean;
    FFTP_NAPP: nullable<String>;
    FUTILIZA_COR: Boolean;
    FID_SUBCLASSE_CONTA_CREDITO_JUROS: Integer;
    FID_SUBCLASSE_CONTA_CREDITO_MULTA: Integer;
    FCRECEBER_PERC_JUROS_DIA1: Double;
    FFTP_PROPRIO_CAMINHO: nullable<String>;
    FID_TIPO_VENDA: Integer;
    FALIQUOTA_ISSQN: Double;
    FQUITAR_CRECEBER_OUTRA_EMPRESA: Boolean;
    FID_EMPRESA: Integer;
    FID_SERIE_NFE_LOJA_VIRTUAL: nullable<Integer>;
    FFTP_MODO_PASSIVO: Boolean;
    FBLOQ_DESC_ACRES_ITEM_PREVENDA: Boolean;
    FMARCA: Boolean;
    FUTILIZA_GRADE: Boolean;
    FLEITURA_CCD_VENDA: Integer;
    FID_PRODUTO_TABELA_LOJA_VIRTUAL: nullable<Integer>;
    FCI_NFE: Boolean;
    FETQ_EMPRESA_LOGO: TBlob;
    FCALC_PRECOVENDA_ENTRADA: Boolean;
    FLEITURA_CCD_TRANSF: Integer;
    FNFCE_VIS_POS_AUTORIZACAO: Boolean;
    FID_SUBCLASSE_CONTA_DEBITO_JUROS: Integer;
    FID_SUBCLASSE_CONTA_DEBITO_MULTA: Integer;
    FSEMPRE_ATU_DT_ALT_PRECOVENDA_ENTRADA: Boolean;
    FID_CONTA_CAIXA: Integer;
    FETQ_IMPRESSORA_PADRAO: nullable<Integer>;
    FCOMP_FISCAL_IMP_RECIBO: Boolean;
    FID_SUBCLASSE_CONTA_DEBITO_TARIFA_BANCARIA: Integer;
    FMAXIMO_DIAS_SEM_ATUALIZAR_CAD_CLIENTE: Integer;
    FPERC_DESCONTO_MAXIMO: Double;
    FREPASSE_ESTOQUE_LOJA_VIRTUAL: nullable<Double>;
    FID_SUBCLASSE_CONTA_CREDITO_ANTECIPACAO: Integer;
    FMAXIMO_DIAS_ATRASO_BLOQ_VENDA: Integer;
    FLIB_CUPOM_FISCAL_PJURIDICA: Boolean;
    { Private declarations }

  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    [Column('ID_PARAMETROS', ftInteger)]
    [Dictionary('ID_PARAMETROS', 'Mensagem de validação', '', '', '', taCenter)]
    property id_parametros: nullable<Integer> read FID_PARAMETROS
      write FID_PARAMETROS;

    [Restrictions([NotNull])]
    [Column('ID_EMPRESA', ftInteger)]
    [Dictionary('ID_EMPRESA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_empresa: Integer read FID_EMPRESA write FID_EMPRESA;

    [Column('ID_EMPRESA_SERVICO', ftInteger)]
    [Dictionary('ID_EMPRESA_SERVICO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_empresa_servico: nullable<Integer> read FID_EMPRESA_SERVICO
      write FID_EMPRESA_SERVICO;

    [Restrictions([NotNull])]
    [Column('ID_TIPO_VENDA', ftInteger)]
    [Dictionary('ID_TIPO_VENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_venda: Integer read FID_TIPO_VENDA write FID_TIPO_VENDA;

    [Restrictions([NotNull])]
    [Column('ID_CONTA_CAIXA', ftInteger)]
    [Dictionary('ID_CONTA_CAIXA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_conta_caixa: Integer read FID_CONTA_CAIXA write FID_CONTA_CAIXA;

    [Restrictions([NotNull])]
    [Column('ALIQ_ISS', ftBCD, 3145774, 6)]
    [Dictionary('ALIQ_ISS', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property aliq_iss: Double read FALIQ_ISS write FALIQ_ISS;

    [Restrictions([NotNull])]
    [Column('HORARIO_VERAO', ftBoolean)]
    [Dictionary('HORARIO_VERAO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property horario_verao: Boolean read FHORARIO_VERAO write FHORARIO_VERAO;

    [Column('CODIGO_NCM', ftString, 10)]
    [Dictionary('CODIGO_NCM', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property codigo_ncm: nullable<String> read FCODIGO_NCM write FCODIGO_NCM;

    [Column('CODIGO_NBS', ftString, 10)]
    [Dictionary('CODIGO_NBS', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property codigo_nbs: nullable<String> read FCODIGO_NBS write FCODIGO_NBS;

    [Restrictions([NotNull])]
    [Column('LEITURA_CCD_VENDA', ftInteger)]
    [Dictionary('LEITURA_CCD_VENDA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property leitura_ccd_venda: Integer read FLEITURA_CCD_VENDA
      write FLEITURA_CCD_VENDA;

    [Restrictions([NotNull])]
    [Column('LEITURA_CCD_TRANSF', ftInteger)]
    [Dictionary('LEITURA_CCD_TRANSF', 'Mensagem de validação', '', '', '',
      taCenter)]
    property leitura_ccd_transf: Integer read FLEITURA_CCD_TRANSF
      write FLEITURA_CCD_TRANSF;

    [Restrictions([NotNull])]
    [Column('LIB_TRANSF_SEM_ESTOQUE', ftBoolean)]
    [Dictionary('LIB_TRANSF_SEM_ESTOQUE', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property lib_transf_sem_estoque: Boolean read FLIB_TRANSF_SEM_ESTOQUE write FLIB_TRANSF_SEM_ESTOQUE;

    [Restrictions([NotNull])]
    [Column('LIB_VENDA_SEM_ESTOQUE', ftBoolean)]
    [Dictionary('LIB_VENDA_SEM_ESTOQUE', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property lib_venda_sem_estoque: Boolean read FLIB_VENDA_SEM_ESTOQUE write FLIB_VENDA_SEM_ESTOQUE;

    [Restrictions([NotNull])]
    [Column('LIB_VENDA_SEM_CLI_CART', ftBoolean)]
    [Dictionary('LIB_VENDA_SEM_CLI_CART', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property lib_venda_sem_cli_cart: Boolean read FLIB_VENDA_SEM_CLI_CART write FLIB_VENDA_SEM_CLI_CART;

    [Restrictions([NotNull])]
    [Column('LIB_VENDA_SEM_CLI_CHEQ', ftBoolean)]
    [Dictionary('LIB_VENDA_SEM_CLI_CHEQ', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property lib_venda_sem_cli_cheq: Boolean read FLIB_VENDA_SEM_CLI_CHEQ write FLIB_VENDA_SEM_CLI_CHEQ;

    [Restrictions([NotNull])]
    [Column('LIB_CUPOM_FISCAL_PJURIDICA', ftBoolean)]
    [Dictionary('LIB_CUPOM_FISCAL_PJURIDICA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property lib_cupom_fiscal_pjuridica: Boolean read FLIB_CUPOM_FISCAL_PJURIDICA write FLIB_CUPOM_FISCAL_PJURIDICA;

    [Restrictions([NotNull])]
    [Column('LIB_NFE_PFISICA', ftBoolean)]
    [Dictionary('LIB_NFE_PFISICA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property lib_nfe_pfisica: Boolean read FLIB_NFE_PFISICA write FLIB_NFE_PFISICA;

    [Restrictions([NotNull])]
    [Column('LIB_ITEM_SERVICO_ECF', ftBoolean)]
    [Dictionary('LIB_ITEM_SERVICO_ECF', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property lib_item_servico_ecf: Boolean read FLIB_ITEM_SERVICO_ECF write FLIB_ITEM_SERVICO_ECF;

    [Restrictions([NotNull])]
    [Column('BLOQ_VENDA_SEM_INDICACAO', ftBoolean)]
    [Dictionary('BLOQ_VENDA_SEM_INDICACAO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property bloq_venda_sem_indicacao: Boolean read FBLOQ_VENDA_SEM_INDICACAO write FBLOQ_VENDA_SEM_INDICACAO;

    [Restrictions([NotNull])]
    [Column('BLOQ_LIMITE_CREDITO', ftBoolean)]
    [Dictionary('BLOQ_LIMITE_CREDITO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property bloq_limite_credito: Boolean read FBLOQ_LIMITE_CREDITO write FBLOQ_LIMITE_CREDITO;

    [Restrictions([NotNull])]
    [Column('BLOQ_ALT_CREDITO_SUSPENSO', ftBoolean)]
    [Dictionary('BLOQ_ALT_CREDITO_SUSPENSO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property bloq_alt_credito_suspenso: Boolean read FBLOQ_ALT_CREDITO_SUSPENSO write FBLOQ_ALT_CREDITO_SUSPENSO;

    [Restrictions([NotNull])]
    [Column('BLOQ_DESC_ACRES_ITEM_PREVENDA', ftBoolean)]
    [Dictionary('BLOQ_DESC_ACRES_ITEM_PREVENDA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property bloq_desc_acres_item_prevenda: Boolean read FBLOQ_DESC_ACRES_ITEM_PREVENDA write FBLOQ_DESC_ACRES_ITEM_PREVENDA;

    [Restrictions([NotNull])]
    [Column('BLOQ_LIST_FECH_CAIXA', ftBoolean)]
    [Dictionary('BLOQ_LIST_FECH_CAIXA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property bloq_list_fech_caixa: Boolean read FBLOQ_LIST_FECH_CAIXA write FBLOQ_LIST_FECH_CAIXA;

    [Restrictions([NotNull])]
    [Column('INIBIR_ACRESCIMO_ITEM', ftBoolean)]
    [Dictionary('INIBIR_ACRESCIMO_ITEM', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property inibir_acrescimo_item: Boolean read FINIBIR_ACRESCIMO_ITEM write FINIBIR_ACRESCIMO_ITEM;

    [Restrictions([NotNull])]
    [Column('VALIDAR_TIPOVENDA_CLIENTE', ftBoolean)]
    [Dictionary('VALIDAR_TIPOVENDA_CLIENTE', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property validar_tipovenda_cliente: Boolean read FVALIDAR_TIPOVENDA_CLIENTE write FVALIDAR_TIPOVENDA_CLIENTE;

    [Restrictions([NotNull])]
    [Column('UTILIZAR_MULTIPLOS_CAIXAS', ftBoolean)]
    [Dictionary('UTILIZAR_MULTIPLOS_CAIXAS', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property utilizar_multiplos_caixas: Boolean read FUTILIZAR_MULTIPLOS_CAIXAS write FUTILIZAR_MULTIPLOS_CAIXAS;

    [Restrictions([NotNull])]
    [Column('DESCONSIDERAR_CHEQ_LIMITE_CREDITO', ftBoolean)]
    [Dictionary('DESCONSIDERAR_CHEQ_LIMITE_CREDITO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property desconsiderar_cheq_limite_credito: Boolean read FDESCONSIDERAR_CHEQ_LIMITE_CREDITO write FDESCONSIDERAR_CHEQ_LIMITE_CREDITO;

    [Restrictions([NotNull])]
    [Column('CUPOM_NEGATIVO_COMISSAO', ftBoolean)]
    [Dictionary('CUPOM_NEGATIVO_COMISSAO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property cupom_negativo_comissao: Boolean read FCUPOM_NEGATIVO_COMISSAO write FCUPOM_NEGATIVO_COMISSAO;

    [Restrictions([NotNull])]
    [Column('DESCONTAR_CHQ_DEV_COMISSAO', ftBoolean)]
    [Dictionary('DESCONTAR_CHQ_DEV_COMISSAO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property descontar_chq_dev_comissao: Boolean read FDESCONTAR_CHQ_DEV_COMISSAO write FDESCONTAR_CHQ_DEV_COMISSAO;

    [Restrictions([NotNull])]
    [Column('ID_PRODUTO_TABELA_COMPRA_FUNC', ftInteger)]
    [Dictionary('ID_PRODUTO_TABELA_COMPRA_FUNC', 'Mensagem de validação', '',
      '', '', taCenter)]
    property id_produto_tabela_compra_func: Integer
      read FID_PRODUTO_TABELA_COMPRA_FUNC write FID_PRODUTO_TABELA_COMPRA_FUNC;

    [Column('MAXIMO_PARCELAS_COMPRA_FUNC', ftInteger)]
    [Dictionary('MAXIMO_PARCELAS_COMPRA_FUNC', 'Mensagem de validação', '', '',
      '', taCenter)]
    property maximo_parcelas_compra_func: nullable<Integer>
      read FMAXIMO_PARCELAS_COMPRA_FUNC write FMAXIMO_PARCELAS_COMPRA_FUNC;

    [Restrictions([NotNull])]
    [Column('PERC_DESCONTO_MAXIMO', ftBCD, 7012436, 6)]
    [Dictionary('PERC_DESCONTO_MAXIMO', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property perc_desconto_maximo: Double read FPERC_DESCONTO_MAXIMO
      write FPERC_DESCONTO_MAXIMO;

    [Restrictions([NotNull])]
    [Column('MAXIMO_DIAS_SEM_ATUALIZAR_CAD_CLIENTE', ftInteger)]
    [Dictionary('MAXIMO_DIAS_SEM_ATUALIZAR_CAD_CLIENTE',
      'Mensagem de validação', '', '', '', taCenter)]
    property maximo_dias_sem_atualizar_cad_cliente: Integer
      read FMAXIMO_DIAS_SEM_ATUALIZAR_CAD_CLIENTE
      write FMAXIMO_DIAS_SEM_ATUALIZAR_CAD_CLIENTE;

    [Restrictions([NotNull])]
    [Column('MAXIMO_DIAS_ATRASO_BLOQ_VENDA', ftInteger)]
    [Dictionary('MAXIMO_DIAS_ATRASO_BLOQ_VENDA', 'Mensagem de validação', '',
      '', '', taCenter)]
    property maximo_dias_atraso_bloq_venda: Integer
      read FMAXIMO_DIAS_ATRASO_BLOQ_VENDA write FMAXIMO_DIAS_ATRASO_BLOQ_VENDA;

    [Restrictions([NotNull])]
    [Column('MAXIMO_DIAS_ALT_VENC_VENDA', ftInteger)]
    [Dictionary('MAXIMO_DIAS_ALT_VENC_VENDA', 'Mensagem de validação', '', '',
      '', taCenter)]
    property maximo_dias_alt_venc_venda: Integer
      read FMAXIMO_DIAS_ALT_VENC_VENDA write FMAXIMO_DIAS_ALT_VENC_VENDA;

    [Restrictions([NotNull])]
    [Column('MAXIMO_PECAS_ITEM_VENDA', ftInteger)]
    [Dictionary('MAXIMO_PECAS_ITEM_VENDA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property maximo_pecas_item_venda: Integer read FMAXIMO_PECAS_ITEM_VENDA
      write FMAXIMO_PECAS_ITEM_VENDA;

    [Restrictions([NotNull])]
    [Column('CTG_CCD_INFORMAR_QTD', ftBoolean)]
    [Dictionary('CTG_CCD_INFORMAR_QTD', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property ctg_ccd_informar_qtd: Boolean read FCTG_CCD_INFORMAR_QTD write FCTG_CCD_INFORMAR_QTD;

    [Restrictions([NotNull])]
    [Column('CTG_CCD_CANC_QTD_TOTAL', ftBoolean)]
    [Dictionary('CTG_CCD_CANC_QTD_TOTAL', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property ctg_ccd_canc_qtd_total: Boolean read FCTG_CCD_CANC_QTD_TOTAL write FCTG_CCD_CANC_QTD_TOTAL;

    [Restrictions([NotNull])]
    [Column('CONTROLAR_GAVETA', ftBoolean)]
    [Dictionary('CONTROLAR_GAVETA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property controlar_gaveta: Boolean read FCONTROLAR_GAVETA write FCONTROLAR_GAVETA;

    [Restrictions([NotNull])]
    [Column('QUITAR_CRECEBER_OUTRA_EMPRESA', ftBoolean)]
    [Dictionary('QUITAR_CRECEBER_OUTRA_EMPRESA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property quitar_creceber_outra_empresa: Boolean read FQUITAR_CRECEBER_OUTRA_EMPRESA write FQUITAR_CRECEBER_OUTRA_EMPRESA;

    [Restrictions([NotNull])]
    [Column('MOSTRAR_MARKUP_ORCAMENTO', ftBoolean)]
    [Dictionary('MOSTRAR_MARKUP_ORCAMENTO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property mostrar_markup_orcamento: Boolean read FMOSTRAR_MARKUP_ORCAMENTO write FMOSTRAR_MARKUP_ORCAMENTO;

    [Restrictions([NotNull])]
    [Column('MARKUP_MINIMO_ORCAMENTO', ftBCD, 7602224, 6)]
    [Dictionary('MARKUP_MINIMO_ORCAMENTO', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property markup_minimo_orcamento: Double read FMARKUP_MINIMO_ORCAMENTO
      write FMARKUP_MINIMO_ORCAMENTO;

    [Restrictions([NotNull])]
    [Column('MARKUP_PRECO_EQUILIBRIO', ftBCD, 4980816, 6)]
    [Dictionary('MARKUP_PRECO_EQUILIBRIO', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property markup_preco_equilibrio: Double read FMARKUP_PRECO_EQUILIBRIO
      write FMARKUP_PRECO_EQUILIBRIO;

    [Restrictions([NotNull])]
    [Column('MARKUP_PADRAO', ftBCD, 5505111, 6)]
    [Dictionary('MARKUP_PADRAO', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property markup_padrao: Double read FMARKUP_PADRAO write FMARKUP_PADRAO;

    [Restrictions([NotNull])]
    [Column('BLOQ_ALT_PRECOVENDA_ENTRADA', ftBoolean)]
    [Dictionary('BLOQ_ALT_PRECOVENDA_ENTRADA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property bloq_alt_precovenda_entrada: Boolean read FBLOQ_ALT_PRECOVENDA_ENTRADA write FBLOQ_ALT_PRECOVENDA_ENTRADA;

    [Restrictions([NotNull])]
    [Column('CALC_PRECOVENDA_ENTRADA', ftBoolean)]
    [Dictionary('CALC_PRECOVENDA_ENTRADA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property calc_precovenda_entrada: Boolean read FCALC_PRECOVENDA_ENTRADA write FCALC_PRECOVENDA_ENTRADA;

    [Restrictions([NotNull])]
    [Column('SEMPRE_ATU_DT_ALT_PRECOVENDA_ENTRADA', ftBoolean)]
    [Dictionary('SEMPRE_ATU_DT_ALT_PRECOVENDA_ENTRADA', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property sempre_atu_dt_alt_precovenda_entrada: Boolean read FSEMPRE_ATU_DT_ALT_PRECOVENDA_ENTRADA write FSEMPRE_ATU_DT_ALT_PRECOVENDA_ENTRADA;

    [Restrictions([NotNull])]
    [Column('IMP_DESCRICAO_RESUMIDA_PROD_NFE', ftBoolean)]
    [Dictionary('IMP_DESCRICAO_RESUMIDA_PROD_NFE', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property imp_descricao_prod_resumida_nfe: Boolean read FIMP_DESCRICAO_RESUMIDA_PROD_NFE write FIMP_DESCRICAO_RESUMIDA_PROD_NFE;

    [Restrictions([NotNull])]
    [Column('IMP_APLICACAO_PROD_NFE', ftBoolean)]
    [Dictionary('IMP_APLICACAO_PROD_NFE', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property imp_aplicacao_prod_nfe: Boolean read FIMP_APLICACAO_PROD_NFE write FIMP_APLICACAO_PROD_NFE;

    [Restrictions([NotNull])]
    [Column('QTD_MESES_MEDIA_VENDA', ftInteger)]
    [Dictionary('QTD_MESES_MEDIA_VENDA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property qtd_meses_media_venda: Integer read FQTD_MESES_MEDIA_VENDA
      write FQTD_MESES_MEDIA_VENDA;

    [Column('CRECEBER_CONTRATO', ftString, 15)]
    [Dictionary('CRECEBER_CONTRATO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property creceber_contrato: nullable<String> read FCRECEBER_CONTRATO
      write FCRECEBER_CONTRATO;

    [Column('CRECEBER_COMPETENCIA_POR', ftString, 1)]
    [Dictionary('CRECEBER_COMPETENCIA_POR', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property creceber_competencia_por: nullable<String>
      read FCRECEBER_COMPETENCIA_POR write FCRECEBER_COMPETENCIA_POR;

    [Restrictions([NotNull])]
    [Column('CRECEBER_PERC_MAXIMO_ARREDONDAMENTO', ftBCD)]
    [Dictionary('CRECEBER_PERC_MAXIMO_ARREDONDAMENTO', 'Mensagem de validação',
      '0', '', '', taRightJustify)]
    property creceber_perc_maximo_arredondamento: Double
      read FCRECEBER_PERC_MAXIMO_ARREDONDAMENTO
      write FCRECEBER_PERC_MAXIMO_ARREDONDAMENTO;

    [Restrictions([NotNull])]
    [Column('CRECEBER_PERC_ANTECIPACAO_DIA', ftBCD)]
    [Dictionary('CRECEBER_PERC_ANTECIPACAO_DIA', 'Mensagem de validação', '0',
      '', '', taRightJustify)]
    property creceber_perc_antecipacao_dia: Double
      read FCRECEBER_PERC_ANTECIPACAO_DIA write FCRECEBER_PERC_ANTECIPACAO_DIA;

    [Restrictions([NotNull])]
    [Column('CRECEBER_PERC_JUROS_DIA1', ftBCD)]
    [Dictionary('CRECEBER_PERC_JUROS_DIA1', 'Mensagem de validação', '0', '',
      '', taRightJustify)]
    property creceber_perc_juros_dia1: Double read FCRECEBER_PERC_JUROS_DIA1
      write FCRECEBER_PERC_JUROS_DIA1;

    [Restrictions([NotNull])]
    [Column('CRECEBER_PERC_MULTA1', ftBCD)]
    [Dictionary('CRECEBER_PERC_MULTA1', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property creceber_perc_multa1: Double read FCRECEBER_PERC_MULTA1
      write FCRECEBER_PERC_MULTA1;

    [Restrictions([NotNull])]
    [Column('CRECEBER_ATRASO_DE1', ftInteger)]
    [Dictionary('CRECEBER_ATRASO_DE1', 'Mensagem de validação', '', '', '',
      taCenter)]
    property creceber_atraso_de1: Integer read FCRECEBER_ATRASO_DE1
      write FCRECEBER_ATRASO_DE1;

    [Restrictions([NotNull])]
    [Column('CRECEBER_ATRASO_ATE1', ftInteger)]
    [Dictionary('CRECEBER_ATRASO_ATE1', 'Mensagem de validação', '', '', '',
      taCenter)]
    property creceber_atraso_ate1: Integer read FCRECEBER_ATRASO_ATE1
      write FCRECEBER_ATRASO_ATE1;

    [Restrictions([NotNull])]
    [Column('CRECEBER_PERC_JUROS_DIA2', ftBCD)]
    [Dictionary('CRECEBER_PERC_JUROS_DIA2', 'Mensagem de validação', '0', '',
      '', taRightJustify)]
    property creceber_perc_juros_dia2: Double read FCRECEBER_PERC_JUROS_DIA2
      write FCRECEBER_PERC_JUROS_DIA2;

    [Restrictions([NotNull])]
    [Column('CRECEBER_PERC_MULTA2', ftBCD, 1544711144, 6)]
    [Dictionary('CRECEBER_PERC_MULTA2', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property creceber_perc_multa2: Double read FCRECEBER_PERC_MULTA2
      write FCRECEBER_PERC_MULTA2;

    [Restrictions([NotNull])]
    [Column('CRECEBER_ATRASO_DE2', ftInteger)]
    [Dictionary('CRECEBER_ATRASO_DE2', 'Mensagem de validação', '', '', '',
      taCenter)]
    property creceber_atraso_de2: Integer read FCRECEBER_ATRASO_DE2
      write FCRECEBER_ATRASO_DE2;

    [Restrictions([NotNull])]
    [Column('CRECEBER_ATRASO_ATE2', ftInteger)]
    [Dictionary('CRECEBER_ATRASO_ATE2', 'Mensagem de validação', '', '', '',
      taCenter)]
    property creceber_atraso_ate2: Integer read FCRECEBER_ATRASO_ATE2
      write FCRECEBER_ATRASO_ATE2;

    [Restrictions([NotNull])]
    [Column('CRECEBER_PERC_JUROS_DIA3', ftBCD)]
    [Dictionary('CRECEBER_PERC_JUROS_DIA3', 'Mensagem de validação', '0', '',
      '', taRightJustify)]
    property creceber_perc_juros_dia3: Double read FCRECEBER_PERC_JUROS_DIA3
      write FCRECEBER_PERC_JUROS_DIA3;

    [Restrictions([NotNull])]
    [Column('CRECEBER_PERC_MULTA3', ftBCD)]
    [Dictionary('CRECEBER_PERC_MULTA3', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property creceber_perc_multa3: Double read FCRECEBER_PERC_MULTA3
      write FCRECEBER_PERC_MULTA3;

    [Restrictions([NotNull])]
    [Column('CRECEBER_ATRASO_DE3', ftInteger)]
    [Dictionary('CRECEBER_ATRASO_DE3', 'Mensagem de validação', '', '', '',
      taCenter)]
    property creceber_atraso_de3: Integer read FCRECEBER_ATRASO_DE3
      write FCRECEBER_ATRASO_DE3;

    [Restrictions([NotNull])]
    [Column('CRECEBER_ATRASO_ATE3', ftInteger)]
    [Dictionary('CRECEBER_ATRASO_ATE3', 'Mensagem de validação', '', '', '',
      taCenter)]
    property creceber_atraso_ate3: Integer read FCRECEBER_ATRASO_ATE3
      write FCRECEBER_ATRASO_ATE3;

    [Restrictions([NotNull])]
    [Column('FTP_TIPO', ftBoolean)]
    [Dictionary('FTP_TIPO', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property ftp_tipo: Boolean read FFTP_TIPO write FFTP_TIPO;

    [Restrictions([NotNull])]
    [Column('FTP_MODO_PASSIVO', ftBoolean)]
    [Dictionary('FTP_MODO_PASSIVO', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property ftp_modo_passivo: Boolean read FFTP_MODO_PASSIVO write FFTP_MODO_PASSIVO;

    [Column('FTP_PROPRIO_ENDERECO', ftString, 150)]
    [Dictionary('FTP_PROPRIO_ENDERECO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property ftp_proprio_endereco: nullable<String> read FFTP_PROPRIO_ENDERECO
      write FFTP_PROPRIO_ENDERECO;

    [Column('FTP_PROPRIO_USUARIO', ftString, 50)]
    [Dictionary('FTP_PROPRIO_USUARIO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property ftp_proprio_usuario: nullable<String> read FFTP_PROPRIO_USUARIO
      write FFTP_PROPRIO_USUARIO;

    [Column('FTP_PROPRIO_SENHA', ftString, 15)]
    [Dictionary('FTP_PROPRIO_SENHA', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property ftp_proprio_senha: nullable<String> read FFTP_PROPRIO_SENHA
      write FFTP_PROPRIO_SENHA;

    [Column('FTP_PROPRIO_CAMINHO', ftString, 200)]
    [Dictionary('FTP_PROPRIO_CAMINHO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property ftp_proprio_caminho: nullable<String> read FFTP_PROPRIO_CAMINHO
      write FFTP_PROPRIO_CAMINHO;

    [Column('FTP_PADRAO_CAMINHO', ftString, 200)]
    [Dictionary('FTP_PADRAO_CAMINHO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property ftp_padrao_caminho: nullable<String> read FFTP_PADRAO_CAMINHO
      write FFTP_PADRAO_CAMINHO;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_DEBITO_TARIFA_BANCARIA', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_DEBITO_TARIFA_BANCARIA',
      'Mensagem de validação', '', '', '', taCenter)]
    property id_subclasse_conta_debito_tarifa_bancaria: Integer
      read FID_SUBCLASSE_CONTA_DEBITO_TARIFA_BANCARIA
      write FID_SUBCLASSE_CONTA_DEBITO_TARIFA_BANCARIA;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_DEBITO_DESCONTO', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_DEBITO_DESCONTO', 'Mensagem de validação',
      '', '', '', taCenter)]
    property id_subclasse_conta_debito_desconto: Integer
      read FID_SUBCLASSE_CONTA_DEBITO_DESCONTO
      write FID_SUBCLASSE_CONTA_DEBITO_DESCONTO;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_DEBITO_ACRESCIMO', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_DEBITO_ACRESCIMO', 'Mensagem de validação',
      '', '', '', taCenter)]
    property id_subclasse_conta_debito_acrescimo: Integer
      read FID_SUBCLASSE_CONTA_DEBITO_ACRESCIMO
      write FID_SUBCLASSE_CONTA_DEBITO_ACRESCIMO;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_DEBITO_MULTA', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_DEBITO_MULTA', 'Mensagem de validação', '',
      '', '', taCenter)]
    property id_subclasse_conta_debito_multa: Integer
      read FID_SUBCLASSE_CONTA_DEBITO_MULTA
      write FID_SUBCLASSE_CONTA_DEBITO_MULTA;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_DEBITO_JUROS', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_DEBITO_JUROS', 'Mensagem de validação', '',
      '', '', taCenter)]
    property id_subclasse_conta_debito_juros: Integer
      read FID_SUBCLASSE_CONTA_DEBITO_JUROS
      write FID_SUBCLASSE_CONTA_DEBITO_JUROS;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_DEBITO_ANTECIPACAO', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_DEBITO_ANTECIPACAO',
      'Mensagem de validação', '', '', '', taCenter)]
    property id_subclasse_conta_debito_antecipacao: Integer
      read FID_SUBCLASSE_CONTA_DEBITO_ANTECIPACAO
      write FID_SUBCLASSE_CONTA_DEBITO_ANTECIPACAO;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_DEBITO_ACORDO', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_DEBITO_ACORDO', 'Mensagem de validação', '',
      '', '', taCenter)]
    property id_subclasse_conta_debito_acordo: Integer
      read FID_SUBCLASSE_CONTA_DEBITO_ACORDO
      write FID_SUBCLASSE_CONTA_DEBITO_ACORDO;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_CREDITO_DESCONTO', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_CREDITO_DESCONTO', 'Mensagem de validação',
      '', '', '', taCenter)]
    property id_subclasse_conta_credito_desconto: Integer
      read FID_SUBCLASSE_CONTA_CREDITO_DESCONTO
      write FID_SUBCLASSE_CONTA_CREDITO_DESCONTO;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_CREDITO_ACRESCIMO', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_CREDITO_ACRESCIMO', 'Mensagem de validação',
      '', '', '', taCenter)]
    property id_subclasse_conta_credito_acrescimo: Integer
      read FID_SUBCLASSE_CONTA_CREDITO_ACRESCIMO
      write FID_SUBCLASSE_CONTA_CREDITO_ACRESCIMO;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_CREDITO_MULTA', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_CREDITO_MULTA', 'Mensagem de validação', '',
      '', '', taCenter)]
    property id_subclasse_conta_credito_multa: Integer
      read FID_SUBCLASSE_CONTA_CREDITO_MULTA
      write FID_SUBCLASSE_CONTA_CREDITO_MULTA;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_CREDITO_JUROS', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_CREDITO_JUROS', 'Mensagem de validação', '',
      '', '', taCenter)]
    property id_subclasse_conta_credito_juros: Integer
      read FID_SUBCLASSE_CONTA_CREDITO_JUROS
      write FID_SUBCLASSE_CONTA_CREDITO_JUROS;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_CREDITO_ANTECIPACAO', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_CREDITO_ANTECIPACAO',
      'Mensagem de validação', '', '', '', taCenter)]
    property id_subclasse_conta_credito_antecipacao: Integer
      read FID_SUBCLASSE_CONTA_CREDITO_ANTECIPACAO
      write FID_SUBCLASSE_CONTA_CREDITO_ANTECIPACAO;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_CREDITO_ACORDO', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_CREDITO_ACORDO', 'Mensagem de validação',
      '', '', '', taCenter)]
    property id_subclasse_conta_credito_acordo: Integer
      read FID_SUBCLASSE_CONTA_CREDITO_ACORDO
      write FID_SUBCLASSE_CONTA_CREDITO_ACORDO;

    [Column('ETQ_EMPRESA_LOGO', ftBlob)]
    [Dictionary('ETQ_EMPRESA_LOGO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property etq_empresa_logo: TBlob read FETQ_EMPRESA_LOGO
      write FETQ_EMPRESA_LOGO;

    [Column('ETQ_MENSAGEM', ftString, 50)]
    [Dictionary('ETQ_MENSAGEM', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property etq_mensagem: nullable<String> read FETQ_MENSAGEM
      write FETQ_MENSAGEM;

    [Restrictions([NotNull])]
    [Column('ETQ_PRAZO_TROCA', ftInteger)]
    [Dictionary('ETQ_PRAZO_TROCA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property etq_prazo_troca: Integer read FETQ_PRAZO_TROCA
      write FETQ_PRAZO_TROCA;

    [Restrictions([NotNull])]
    [Column('ETQ_TEMPERATURA', ftInteger)]
    [Dictionary('ETQ_TEMPERATURA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property etq_temperatura: Integer read FETQ_TEMPERATURA
      write FETQ_TEMPERATURA;

    [Column('ETQ_IMPRESSORA_PADRAO', ftInteger)]
    [Dictionary('ETQ_IMPRESSORA_PADRAO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property etq_impressora_padrao: nullable<Integer>
      read FETQ_IMPRESSORA_PADRAO write FETQ_IMPRESSORA_PADRAO;

    [Restrictions([NotNull])]
    [Column('UTILIZAR_IMP_MATRICIAL_ROMANEIO', ftBoolean)]
    [Dictionary('UTILIZAR_IMP_MATRICIAL_ROMANEIO', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property utilizar_imp_matricial_romaneio: Boolean read FUTILIZAR_IMP_MATRICIAL_ROMANEIO write FUTILIZAR_IMP_MATRICIAL_ROMANEIO;

    [Restrictions([NotNull])]
    [Column('CAMINHO_IMP_MATRICIAL_ROMANEIO', ftString, 50)]
    [Dictionary('CAMINHO_IMP_MATRICIAL_ROMANEIO', 'Mensagem de validação', '',
      '', '', taLeftJustify)]
    property caminho_imp_matricial_romaneio: String
      read FCAMINHO_IMP_MATRICIAL_ROMANEIO
      write FCAMINHO_IMP_MATRICIAL_ROMANEIO;

    [Restrictions([NotNull])]
    [Column('DESTACA_DESCONTO_PROMOCAO', ftBoolean)]
    [Dictionary('DESTACA_DESCONTO_PROMOCAO', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property destaca_desconto_promocao: Boolean read FDESTACA_DESCONTO_PROMOCAO write FDESTACA_DESCONTO_PROMOCAO;

    [Restrictions([NotNull])]
    [Column('CALCULA_PRECO_POR_MARKUP', ftBoolean)]
    [Dictionary('CALCULA_PRECO_POR_MARKUP', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property calcula_preco_por_markup: Boolean read FCALCULA_PRECO_POR_MARKUP write FCALCULA_PRECO_POR_MARKUP;

    [Restrictions([NotNull])]
    [Column('PEDIDO_COMPRA_OBRIGATORIO', ftBoolean)]
    [Dictionary('PEDIDO_COMPRA_OBRIGATORIO', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property pedido_compra_obrigatorio: Boolean read FPEDIDO_COMPRA_OBRIGATORIO write FPEDIDO_COMPRA_OBRIGATORIO;

    [Column('CAMINHO_PADRAO_XML_NFE', ftString, 200)]
    [Dictionary('CAMINHO_PADRAO_XML_NFE', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property caminho_padrao_xml_nfe: nullable<String>
      read FCAMINHO_PADRAO_XML_NFE write FCAMINHO_PADRAO_XML_NFE;

    [Column('ULTIMO_CAMINHO_XML_NFE', ftString, 200)]
    [Dictionary('ULTIMO_CAMINHO_XML_NFE', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property ultimo_caminho_xml_nfe: nullable<String>
      read FULTIMO_CAMINHO_XML_NFE write FULTIMO_CAMINHO_XML_NFE;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_FRETE', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_FRETE', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_subclasse_conta_frete: Integer read FID_SUBCLASSE_CONTA_FRETE
      write FID_SUBCLASSE_CONTA_FRETE;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_CRECEBER', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_CRECEBER', 'Mensagem de validação', '', '',
      '', taCenter)]
    property id_subclasse_conta_creceber: Integer
      read FID_SUBCLASSE_CONTA_CRECEBER write FID_SUBCLASSE_CONTA_CRECEBER;

    [Restrictions([NotNull])]
    [Column('ID_SUBCLASSE_CONTA_CPAGAR', ftInteger)]
    [Dictionary('ID_SUBCLASSE_CONTA_CPAGAR', 'Mensagem de validação', '', '',
      '', taCenter)]
    property id_subclasse_conta_cpagar: Integer read FID_SUBCLASSE_CONTA_CPAGAR
      write FID_SUBCLASSE_CONTA_CPAGAR;

    [Restrictions([NotNull])]
    [Column('TIPO_DATA_CRECEBER', ftInteger)]
    [Dictionary('TIPO_DATA_CRECEBER', 'Mensagem de validação', '', '', '',
      taCenter)]
    property tipo_data_creceber: Integer read FTIPO_DATA_CRECEBER
      write FTIPO_DATA_CRECEBER;

    [Restrictions([NotNull])]
    [Column('ID_PRODUTO_TABELA_PADRAO', ftInteger)]
    [Dictionary('ID_PRODUTO_TABELA_PADRAO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_produto_tabela_padrao: Integer read FID_PRODUTO_TABELA_PADRAO
      write FID_PRODUTO_TABELA_PADRAO;

    [Restrictions([NotNull])]
    [Column('CONSIDERAR_FATURAMENTO_COLABORADOR_COMISSAO', ftInteger)]
    [Dictionary('CONSIDERAR_FATURAMENTO_COLABORADOR_COMISSAO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property considerar_faturamento_colaborador_comissao: Integer read FCONSIDERAR_FATURAMENTO_COLABORADOR_COMISSAO
      write FCONSIDERAR_FATURAMENTO_COLABORADOR_COMISSAO;

    [Restrictions([NotNull])]
    [Column('DIAS_INTERVALO_FINANCEIRA', ftInteger)]
    [Dictionary('DIAS_INTERVALO_FINANCEIRA', 'Mensagem de validação', '', '',
      '', taCenter)]
    property dias_intervalo_financeira: Integer read FDIAS_INTERVALO_FINANCEIRA
      write FDIAS_INTERVALO_FINANCEIRA;

    [Restrictions([NotNull])]
    [Column('UTILIZA_COR', ftBoolean)]
    [Dictionary('UTILIZA_COR', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property utiliza_cor: Boolean read FUTILIZA_COR write FUTILIZA_COR;

    [Restrictions([NotNull])]
    [Column('UTILIZA_GRADE', ftBoolean)]
    [Dictionary('UTILIZA_GRADE', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property utiliza_grade: Boolean read FUTILIZA_GRADE write FUTILIZA_GRADE;

    [Column('CAMINHO_BACKUP_BD', ftBlob)]
    [Dictionary('CAMINHO_BACKUP_BD', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property caminho_backup_bd: TBlob read FCAMINHO_BACKUP_BD
      write FCAMINHO_BACKUP_BD;

    [Restrictions([NotNull])]
    [Column('ALIQUOTA_ISSQN', ftBCD, 3145776, 6)]
    [Dictionary('ALIQUOTA_ISSQN', 'Mensagem de validação', '0', '', '',
      taRightJustify)]
    property aliquota_issqn: Double read FALIQUOTA_ISSQN write FALIQUOTA_ISSQN;

    [Restrictions([NotNull])]
    [Column('BLOQ_ABERTURA_CAIXA_SALDO_DIFERENTE', ftBoolean)]
    [Dictionary('BLOQ_ABERTURA_CAIXA_SALDO_DIFERENTE', 'Mensagem de validação',
      '0', '', '', taCenter)]
    property bloq_abertura_caixa_saldo_diferente: Boolean
      read FBLOQ_ABERTURA_CAIXA_SALDO_DIFERENTE
      write FBLOQ_ABERTURA_CAIXA_SALDO_DIFERENTE;

    [Restrictions([NotNull])]
    [Column('COMP_FISCAL_IMP_RECIBO', ftBoolean)]
    [Dictionary('COMP_FISCAL_IMP_RECIBO', 'Mensagem de validação', '0', '', '',
      taCenter)]
    property comp_fiscal_imp_recibo: Boolean read FCOMP_FISCAL_IMP_RECIBO
      write FCOMP_FISCAL_IMP_RECIBO;

    [Restrictions([NotNull])]
    [Column('NFCE_IMP_POS_AUTORIZACAO', ftBoolean)]
    [Dictionary('NFCE_IMP_POS_AUTORIZACAO', 'Mensagem de validação', '0', '',
      '', taCenter)]
    property nfce_imp_pos_autorizacao: Boolean read FNFCE_IMP_POS_AUTORIZACAO
      write FNFCE_IMP_POS_AUTORIZACAO;

    [Restrictions([NotNull])]
    [Column('NFCE_VIS_POS_AUTORIZACAO', ftBoolean)]
    [Dictionary('NFCE_VIS_POS_AUTORIZACAO', 'Mensagem de validação', '0', '',
      '', taCenter)]
    property nfce_vis_pos_autorizacao: Boolean read FNFCE_VIS_POS_AUTORIZACAO
      write FNFCE_VIS_POS_AUTORIZACAO;

    [Restrictions([NotNull])]
    [Column('NFCE_SEM_ACAO_POS_AUTORIZACAO', ftBoolean)]
    [Dictionary('NFCE_SEM_ACAO_POS_AUTORIZACAO', 'Mensagem de validação', '0',
      '', '', taCenter)]
    property nfce_sem_acao_pos_autorizacao: Boolean
      read FNFCE_SEM_ACAO_POS_AUTORIZACAO write FNFCE_SEM_ACAO_POS_AUTORIZACAO;

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

    [Restrictions([NotNull])]
    [Column('MARCA', ftBoolean)]
    [Dictionary('MARCA', 'Mensagem de validação', '0', '', '', taCenter)]
    property marca: Boolean read FMARCA write FMARCA;

    [Restrictions([NotNull])]
    [Column('BLOQUEADO', ftBoolean)]
    [Dictionary('BLOQUEADO', 'Mensagem de validação', '0', '', '', taCenter)]
    property bloqueado: Boolean read FBLOQUEADO write FBLOQUEADO;

    [Restrictions([NotNull])]
    [Column('CI_NFE', ftBoolean)]
    [Dictionary('CI_NFE', 'Mensagem de validação', '0', '', '', taCenter)]
    property ci_nfe: Boolean read FCI_NFE write FCI_NFE;

    [Restrictions([NotNull])]
    [Column('CI_NFCE', ftBoolean)]
    [Dictionary('CI_NFCE', 'Mensagem de validação', '0', '', '', taCenter)]
    property ci_nfce: Boolean read FCI_NFCE write FCI_NFCE;

    [Column('ID_EMPRESA_LOJA_VIRTUAL', ftInteger)]
    [Dictionary('ID_EMPRESA_LOJA_VIRTUAL', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_empresa_loja_virtual: nullable<Integer>
      read FID_EMPRESA_LOJA_VIRTUAL write FID_EMPRESA_LOJA_VIRTUAL;

    [Column('ID_PRODUTO_TABELA_LOJA_VIRTUAL', ftInteger)]
    [Dictionary('ID_PRODUTO_TABELA_LOJA_VIRTUAL', 'Mensagem de validação', '',
      '', '', taCenter)]
    property id_produto_tabela_loja_virtual: nullable<Integer>
      read FID_PRODUTO_TABELA_LOJA_VIRTUAL
      write FID_PRODUTO_TABELA_LOJA_VIRTUAL;

    [Column('ID_TRANSPORTADORA_LOJA_VIRTUAL', ftInteger)]
    [Dictionary('ID_TRANSPORTADORA_LOJA_VIRTUAL', 'Mensagem de validação', '',
      '', '', taCenter)]
    property id_transportadora_loja_virtual: nullable<Integer>
      read FID_TRANSPORTADORA_LOJA_VIRTUAL
      write FID_TRANSPORTADORA_LOJA_VIRTUAL;

    [Column('ID_SERIE_NFE_LOJA_VIRTUAL', ftInteger)]
    [Dictionary('ID_SERIE_NFE_LOJA_VIRTUAL', 'Mensagem de validação', '', '',
      '', taCenter)]
    property id_serie_nfe_loja_virtual: nullable<Integer>
      read FID_SERIE_NFE_LOJA_VIRTUAL write FID_SERIE_NFE_LOJA_VIRTUAL;

    [Column('REPASSE_ESTOQUE_LOJA_VIRTUAL', ftBCD, 7471188, 6)]
    [Dictionary('REPASSE_ESTOQUE_LOJA_VIRTUAL', 'Mensagem de validação', '0',
      '', '', taRightJustify)]
    property repasse_estoque_loja_virtual: nullable<Double>
      read FREPASSE_ESTOQUE_LOJA_VIRTUAL write FREPASSE_ESTOQUE_LOJA_VIRTUAL;

    [Restrictions([NotNull])]
    [Column('COMERCIALIZA_LOJA_VIRTUAL', ftBoolean)]
    [Dictionary('COMERCIALIZA_LOJA_VIRTUAL', 'Mensagem de validação', '0', '',
      '', taCenter)]
    property comercializa_loja_virtual: Boolean read FCOMERCIALIZA_LOJA_VIRTUAL
      write FCOMERCIALIZA_LOJA_VIRTUAL;

    [Column('ID_COLABORADOR_LOJA_VIRTUAL', ftWord)]
    [Dictionary('ID_COLABORADOR_LOJA_VIRTUAL', 'Mensagem de validação', '', '',
      '', taCenter)]
    property id_colaborador_loja_virtual: nullable<Int64>
      read FID_COLABORADOR_LOJA_VIRTUAL write FID_COLABORADOR_LOJA_VIRTUAL;

    [Restrictions([NotNull])]
    [Column('TIPO_PESQUISAPRODUTO', ftInteger)]
    [Dictionary('TIPO_PESQUISAPRODUTO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property tipo_pesquisaproduto: Integer read FTIPO_PESQUISAPRODUTO
      write FTIPO_PESQUISAPRODUTO;

    [Restrictions([NotNull])]
    [Column('ATUALIZA_NCM_CEST_PRODUTO', ftInteger)]
    [Dictionary('ATUALIZA_NCM_CEST_PRODUTO', 'Mensagem de validação', '', '',
      '', taCenter)]
    property atualiza_ncm_cest_produto: Integer read FATUALIZA_NCM_CEST_PRODUTO
      write FATUALIZA_NCM_CEST_PRODUTO;

    [Restrictions([NotNull])]
    [Column('EXPORTA_NAPP', ftInteger)]
    [Dictionary('EXPORTA_NAPP', 'Mensagem de validação', '', '', '', taCenter)]
    property exporta_napp: Integer read FEXPORTA_NAPP write FEXPORTA_NAPP;

    [Column('FTP_NAPP', ftString, 120)]
    [Dictionary('FTP_NAPP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ftp_napp: nullable<String> read FFTP_NAPP write FFTP_NAPP;

    [Column('USUARIO_NAPP', ftString, 50)]
    [Dictionary('USUARIO_NAPP', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property usuario_napp: nullable<String> read FUSUARIO_NAPP
      write FUSUARIO_NAPP;

    [Column('SENHA_NAPP', ftString, 40)]
    [Dictionary('SENHA_NAPP', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property senha_napp: nullable<String> read FSENHA_NAPP write FSENHA_NAPP;

    [Column('ID_CONTA_BANCO', ftInteger)]
    [Dictionary('ID_CONTA_BANCO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property id_conta_banco: nullable<Integer> read FID_CONTA_BANCO
      write FID_CONTA_BANCO;

  end;

implementation

constructor TPARAMETROS.Create;
begin
  //
end;

destructor TPARAMETROS.Destroy;
begin
  inherited;
end;

initialization

TRegisterClass.RegisterEntity(TPARAMETROS)

end.
