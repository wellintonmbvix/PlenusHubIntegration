unit model.pdv_notas_fiscais_cab_prev;

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
  dbcbr.mapping.Classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes;

type

  [Entity]
  [Table('PDV_NOTAS_FISCAIS_CAB', '')]
  [PrimaryKey('ID_PDV_NOTAS_FISCAIS_CAB', TAutoIncType.AutoInc,
    TGeneratorType.TableInc, TSortingOrder.NoSort, True, 'Chave primária')]
  [Sequence('PDV_NOTAS_FISCAIS_CAB')]
  [OrderBy('ID_PDV_NOTAS_FISCAIS_CAB')]
  TPDV_NOTAS_FISCAIS_CAB = class
  private
    FID_PDV_NOTAS_FISCAIS_CAB: Integer;
    FID_PDV_EQUIPAMENTO: nullable<Integer>;
    FID_PDV_MOVIMENTO: nullable<Integer>;
    FCODIGO: Integer;
    FID_TIPO_AMBIENTE_NFE: Integer;
    FID_TIPO_EMISSAO_NFE: Integer;
    FTIPO_CADASTRO: String;
    FID_CLI_FOR: nullable<Integer>;
    FID_COLABORADOR: Integer;
    FID_EMPRESA: Integer;
    FDT_EMISSAO: TDateTime;
    FOPERACAO: String;
    FID_TIPO_VENDA: nullable<Integer>;
    FID_PRODUTO_TABELA: nullable<Integer>;
    FMODELO: String;
    FSERIE: String;
    FSUBSERIE: String;
    FNUM_NOTA: nullable<Integer>;
    FNOME_DESTINATARIO: nullable<String>;
    FCPF_CNPJ_DESTINATARIO: nullable<String>;
    FTELEFONE_DESTINATARIO: nullable<String>;
    FENDERECO_DESTINATARIO: nullable<String>;
    FSITUACAO: String;
    FCIF_FOB: Boolean;
    FTRAN_FRETE_POR_CONTA: Boolean;
    FTRAN_PESO_BRUTO: Currency;
    FTRAN_PESO_LIQUIDO: Currency;
    FTOTAL_QUANTIDADE: Currency;
    FTOTAL_BRUTO: Currency;
    FTOTAL_CRED_CSOSN: Currency;
    FTOTAL_BASE_ICMS: Currency;
    FTOTAL_ICMS: Currency;
    FTOTAL_REDU_BASE: Currency;
    FTOTAL_BASE_SUBTRIB: Currency;
    FTOTAL_SUB_TRIB: Currency;
    FTOTAL_BASE_PIS: Currency;
    FTOTAL_PIS: Currency;
    FTOTAL_BASE_COFINS: Currency;
    FTOTAL_COFINS: Currency;
    FTOTAL_BASE_IPI: Currency;
    FTOTAL_BASE_ISSQN: Currency;
    FTOTAL_IPI: Currency;
    FTOTAL_II_ADUANEIRA: Currency;
    FTOTAL_BASE_II: Currency;
    FTOTAL_ISSQN: Currency;
    FTOTAL_ACRESCIMO: Currency;
    FTOTAL_II: Currency;
    FTOTAL_II_IOF: Currency;
    FTOTAL_DESCONTO: Currency;
    FTOTAL_CREDITO: Currency;
    FPERC_COMISSAO: Currency;
    FTOTAL_COMISSAO: Currency;
    FTOTAL_SEGURO: Currency;
    FTOTAL_FRETE: Currency;
    FTOTAL_LIQUIDO: Currency;
    FTOTAL_DESPESA: Currency;
    FTOTAL_CANCELADO: Currency;
    FTOTAL_ISENTO: Currency;
    FTOTAL_NAO_TRIBUT: Currency;
    FCK_IPINAODEDUZDESCONTO: Boolean;
    FNFE_NRO_PROTOCOLO: nullable<String>;
    FNFE_CHAVE: nullable<String>;
    FNFE_DTH_PROTOCOLO: nullable<TDateTime>;
    FNFE_FINALIDADE: nullable<String>;
    FNFE_INDFINAL: Integer;
    FIND_EMITENTE: nullable<Integer>;
    FNFE_INDPRES: nullable<Integer>;
    FIND_PGTO: nullable<Integer>;
    FIND_FRETE: nullable<Integer>;
    FIND_NAT_FRETE: nullable<Integer>;
    FCK_CSOSN: Boolean;
    FCTE_TIPO: nullable<String>;
    FICMSNAOSOMADESPESAS: Boolean;
    FIPINAOSOMADESPESAS: Boolean;
    FIPIDEDUZDESCONTO: Boolean;
    FID_USUARIO_ALT: nullable<Integer>;
    FCOMISSAO: Currency;
    FID_ORIGEM: Integer;
    FREVENDA: Boolean;
    FCANCELADA: String;
    FSTATUS: String;
    FOBS: nullable<String>;
    FVALOR_FCP: Currency;
    FVALOR_ICMS_UF_DEST: Currency;
    FVALOR_ICMS_UF_REMET: Currency;
    FTROCO: Currency;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: nullable<TDateTime>;
    FBLOQUEADO: Boolean;

  public
    constructor Create;
    destructor Destroy; override;

    [Column('ID_PDV_NOTAS_FISCAIS_CAB', ftInteger)]
    [Dictionary('ID_PDV_NOTAS_FISCAIS_CAB', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_PDV_NOTAS_FISCAIS_CAB: Integer read FID_PDV_NOTAS_FISCAIS_CAB
      write FID_PDV_NOTAS_FISCAIS_CAB;

    [Column('ID_PDV_EQUIPAMENTO', ftInteger)]
    [Dictionary('ID_PDV_EQUIPAMENTO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_PDV_EQUIPAMENTO: nullable<Integer> read FID_PDV_EQUIPAMENTO
      write FID_PDV_EQUIPAMENTO;

    [Column('ID_PDV_MOVIMENTO', ftInteger)]
    [Dictionary('ID_PDV_MOVIMENTO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_PDV_MOVIMENTO: nullable<Integer> read FID_PDV_MOVIMENTO
      write FID_PDV_MOVIMENTO;

    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taRightJustify)]
    property CODIGO: Integer read FCODIGO write FCODIGO;

    [Column('ID_TIPO_AMBIENTE_NFE', ftInteger)]
    [Dictionary('ID_TIPO_AMBIENTE_NFE', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_TIPO_AMBIENTE_NFE: Integer read FID_TIPO_AMBIENTE_NFE
      write FID_TIPO_AMBIENTE_NFE;

    [Column('ID_TIPO_EMISSAO_NFE', ftInteger)]
    [Dictionary('ID_TIPO_EMISSAO_NFE', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_TIPO_EMISSAO_NFE: Integer read FID_TIPO_EMISSAO_NFE
      write FID_TIPO_EMISSAO_NFE;

    [Column('TIPO_CADASTRO', ftString)]
    [Dictionary('TIPO_CADASTRO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property TIPO_CADASTRO: String read FTIPO_CADASTRO write FTIPO_CADASTRO;

    [Column('ID_CLI_FOR', ftInteger)]
    [Dictionary('ID_CLI_FOR', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_CLI_FOR: nullable<Integer> read FID_CLI_FOR write FID_CLI_FOR;

    [Column('ID_COLABORADOR', ftInteger)]
    [Dictionary('ID_COLABORADOR', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_COLABORADOR: Integer read FID_COLABORADOR write FID_COLABORADOR;

    [Column('ID_EMPRESA', ftInteger)]
    [Dictionary('ID_EMPRESA', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_EMPRESA: Integer read FID_EMPRESA write FID_EMPRESA;

    [Column('DT_EMISSAO', ftDateTime)]
    [Dictionary('DT_EMISSAO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property DT_EMISSAO: TDateTime read FDT_EMISSAO write FDT_EMISSAO;

    [Column('OPERACAO', ftString)]
    [Dictionary('OPERACAO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property OPERACAO: String read FOPERACAO write FOPERACAO;

    [Column('ID_TIPO_VENDA', ftInteger)]
    [Dictionary('ID_TIPO_VENDA', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_TIPO_VENDA: nullable<Integer> read FID_TIPO_VENDA
      write FID_TIPO_VENDA;

    [Column('ID_PRODUTO_TABELA', ftInteger)]
    [Dictionary('ID_PRODUTO_TABELA', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_PRODUTO_TABELA: nullable<Integer> read FID_PRODUTO_TABELA
      write FID_PRODUTO_TABELA;

    [Column('MODELO', ftString)]
    [Dictionary('MODELO', 'Mensagem de validação', '', '', '', taLefthJustify)]
    property MODELO: String read FMODELO write FMODELO;

    [Column('SERIE', ftString)]
    [Dictionary('SERIE', 'Mensagem de validação', '', '', '', taLefthJustify)]
    property SERIE: String read FSERIE write FSERIE;

    [Column('SUBSERIE', ftString)]
    [Dictionary('SUBSERIE', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property SUBSERIE: String read FSUBSERIE write FSUBSERIE;

    [Column('NUM_NOTA', ftInteger)]
    [Dictionary('NUM_NOTA', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property NUM_NOTA: nullable<Integer> read FNUM_NOTA write FNUM_NOTA;

    [Column('NOME_DESTINATARIO', ftString)]
    [Dictionary('NOME_DESTINATARIO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property NOME_DESTINATARIO: nullable<String> read FNOME_DESTINATARIO
      write FNOME_DESTINATARIO;

    [Column('CPF_CNPJ_DESTINATARIO', ftString)]
    [Dictionary('CPF_CNPJ_DESTINATARIO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property CPF_CNPJ_DESTINATARIO: nullable<String> read FCPF_CNPJ_DESTINATARIO
      write FCPF_CNPJ_DESTINATARIO;

    [Column('TELEFONE_DESTINATARIO', ftString)]
    [Dictionary('TELEFONE_DESTINATARIO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property TELEFONE_DESTINATARIO: nullable<String> read FTELEFONE_DESTINATARIO
      write FTELEFONE_DESTINATARIO;

    [Column('ENDERECO_DESTINATARIO', ftString)]
    [Dictionary('ENDERECO_DESTINATARIO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property ENDERECO_DESTINATARIO: nullable<String> read FENDERECO_DESTINATARIO
      write FENDERECO_DESTINATARIO;

    [Column('SITUACAO', ftString)]
    [Dictionary('SITUACAO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property SITUACAO: String read FSITUACAO write FSITUACAO;

    [Column('CIF_FOB', ftBoolean)]
    [Dictionary('CIF_FOB', 'Mensagem de validação', '', '', '', taCenter)]
    property CIF_FOB: Boolean read FCIF_FOB write FCIF_FOB;

    [Column('TRAN_FRETE_POR_CONTA', ftBoolean)]
    [Dictionary('TRAN_FRETE_POR_CONTA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property TRAN_FRETE_POR_CONTA: Boolean read FTRAN_FRETE_POR_CONTA
      write FTRAN_FRETE_POR_CONTA;

    [Column('TRAN_PESO_BRUTO', ftCurrency)]
    [Dictionary('TRAN_PESO_BRUTO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TRAN_PESO_BRUTO: Currency read FTRAN_PESO_BRUTO
      write FTRAN_PESO_BRUTO;

    [Column('TRAN_PESO_LIQUIDO', ftCurrency)]
    [Dictionary('TRAN_PESO_LIQUIDO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TRAN_PESO_LIQUIDO: Currency read FTRAN_PESO_LIQUIDO
      write FTRAN_PESO_LIQUIDO;

    [Column('TOTAL_QUANTIDADE', ftCurrency)]
    [Dictionary('TOTAL_QUANTIDADE', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_QUANTIDADE: Currency read FTOTAL_QUANTIDADE
      write FTOTAL_QUANTIDADE;

    [Column('TOTAL_BRUTO', ftCurrency)]
    [Dictionary('TOTAL_BRUTO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_BRUTO: Currency read FTOTAL_BRUTO write FTOTAL_BRUTO;

    [Column('TOTAL_CRED_CSOSN', ftCurrency)]
    [Dictionary('TOTAL_CRED_CSOSN', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_CRED_CSOSN: Currency read FTOTAL_CRED_CSOSN
      write FTOTAL_CRED_CSOSN;

    [Column('TOTAL_BASE_ICMS', ftCurrency)]
    [Dictionary('TOTAL_BASE_ICMS', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_BASE_ICMS: Currency read FTOTAL_BASE_ICMS
      write FTOTAL_BASE_ICMS;

    [Column('TOTAL_ICMS', ftCurrency)]
    [Dictionary('TOTAL_ICMS', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_ICMS: Currency read FTOTAL_ICMS write FTOTAL_ICMS;

    [Column('TOTAL_REDU_BASE', ftCurrency)]
    [Dictionary('TOTAL_REDU_BASE', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_REDU_BASE: Currency read FTOTAL_REDU_BASE
      write FTOTAL_REDU_BASE;

    [Column('TOTAL_BASE_SUBTRIB', ftCurrency)]
    [Dictionary('TOTAL_BASE_SUBTRIB', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_BASE_SUBTRIB: Currency read FTOTAL_BASE_SUBTRIB
      write FTOTAL_BASE_SUBTRIB;

    [Column('TOTAL_SUB_TRIB', ftCurrency)]
    [Dictionary('TOTAL_SUB_TRIB', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_SUB_TRIB: Currency read FTOTAL_SUB_TRIB
      write FTOTAL_SUB_TRIB;

    [Column('TOTAL_BASE_PIS', ftCurrency)]
    [Dictionary('TOTAL_BASE_PIS', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_BASE_PIS: Currency read FTOTAL_BASE_PIS
      write FTOTAL_BASE_PIS;

    [Column('TOTAL_PIS', ftCurrency)]
    [Dictionary('TOTAL_PIS', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_PIS: Currency read FTOTAL_PIS write FTOTAL_PIS;

    [Column('TOTAL_BASE_COFINS', ftCurrency)]
    [Dictionary('TOTAL_BASE_COFINS', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_BASE_COFINS: Currency read FTOTAL_BASE_COFINS
      write FTOTAL_BASE_COFINS;

    [Column('TOTAL_COFINS', ftCurrency)]
    [Dictionary('TOTAL_COFINS', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_COFINS: Currency read FTOTAL_COFINS write FTOTAL_COFINS;

    [Column('TOTAL_BASE_IPI', ftCurrency)]
    [Dictionary('TOTAL_BASE_IPI', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_BASE_IPI: Currency read FTOTAL_BASE_IPI
      write FTOTAL_BASE_IPI;

    [Column('TOTAL_IPI', ftCurrency)]
    [Dictionary('TOTAL_IPI', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_IPI: Currency read FTOTAL_IPI write FTOTAL_IPI;

    [Column('TOTAL_BASE_ISSQN', ftCurrency)]
    [Dictionary('TOTAL_BASE_ISSQN', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_BASE_ISSQN: Currency read FTOTAL_BASE_ISSQN
      write FTOTAL_BASE_ISSQN;

    [Column('TOTAL_ISSQN', ftCurrency)]
    [Dictionary('TOTAL_ISSQN', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_ISSQN: Currency read FTOTAL_ISSQN write FTOTAL_ISSQN;

    [Column('TOTAL_BASE_II', ftCurrency)]
    [Dictionary('TOTAL_BASE_II', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_BASE_II: Currency read FTOTAL_BASE_II write FTOTAL_BASE_II;

    [Column('TOTAL_II_ADUANEIRA', ftCurrency)]
    [Dictionary('TOTAL_II_ADUANEIRA', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_II_ADUANEIRA: Currency read FTOTAL_II_ADUANEIRA
      write FTOTAL_II_ADUANEIRA;

    [Column('TOTALTOTAL_II_IOF_ISSQN', ftCurrency)]
    [Dictionary('TOTAL_II_IOF', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_II_IOF: Currency read FTOTAL_II_IOF write FTOTAL_II_IOF;

    [Column('TOTAL_II', ftCurrency)]
    [Dictionary('TOTAL_II', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_II: Currency read FTOTAL_II write FTOTAL_II;

    [Column('TOTAL_ACRESCIMO', ftCurrency)]
    [Dictionary('TOTAL_ACRESCIMO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_ACRESCIMO: Currency read FTOTAL_ACRESCIMO
      write FTOTAL_ACRESCIMO;

    [Column('TOTAL_DESCONTO', ftCurrency)]
    [Dictionary('TOTAL_DESCONTO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_DESCONTO: Currency read FTOTAL_DESCONTO
      write FTOTAL_DESCONTO;

    [Column('TOTAL_CREDITO', ftCurrency)]
    [Dictionary('TOTAL_CREDITO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_CREDITO: Currency read FTOTAL_CREDITO write FTOTAL_CREDITO;

    [Column('PERC_COMISSAO', ftCurrency)]
    [Dictionary('PERC_COMISSAO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property PERC_COMISSAO: Currency read FPERC_COMISSAO write FPERC_COMISSAO;

    [Column('TOTAL_COMISSAO', ftCurrency)]
    [Dictionary('TOTAL_COMISSAO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_COMISSAO: Currency read FTOTAL_COMISSAO
      write FTOTAL_COMISSAO;

    [Column('TOTAL_FRETE', ftCurrency)]
    [Dictionary('TOTAL_FRETE', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_FRETE: Currency read FTOTAL_FRETE write FTOTAL_FRETE;

    [Column('TOTAL_SEGURO', ftCurrency)]
    [Dictionary('TOTAL_SEGURO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_SEGURO: Currency read FTOTAL_SEGURO write FTOTAL_SEGURO;

    [Column('TOTAL_DESPESA', ftCurrency)]
    [Dictionary('TOTAL_DESPESA', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_DESPESA: Currency read FTOTAL_DESPESA write FTOTAL_DESPESA;

    [Column('TOTAL_LIQUIDO', ftCurrency)]
    [Dictionary('TOTAL_LIQUIDO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_LIQUIDO: Currency read FTOTAL_LIQUIDO write FTOTAL_LIQUIDO;

    [Column('TOTAL_ISENTO', ftCurrency)]
    [Dictionary('TOTAL_ISENTO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_ISENTO: Currency read FTOTAL_ISENTO write FTOTAL_ISENTO;

    [Column('TOTAL_NAO_TRIBUT', ftCurrency)]
    [Dictionary('TOTAL_NAO_TRIBUT', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_NAO_TRIBUT: Currency read FTOTAL_NAO_TRIBUT
      write FTOTAL_NAO_TRIBUT;

    [Column('TOTAL_CANCELADO', ftCurrency)]
    [Dictionary('TOTAL_CANCELADO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TOTAL_CANCELADO: Currency read FTOTAL_CANCELADO
      write FTOTAL_CANCELADO;

    [Column('CK_IPINAODEDUZDESCONTO', ftBoolean)]
    [Dictionary('CK_IPINAODEDUZDESCONTO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property CK_IPINAODEDUZDESCONTO: Boolean read FCK_IPINAODEDUZDESCONTO
      write FCK_IPINAODEDUZDESCONTO;

    [Column('NFE_CHAVE', ftString)]
    [Dictionary('NFE_CHAVE', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property NFE_CHAVE: nullable<String> read FNFE_CHAVE write FNFE_CHAVE;

    [Column('NFE_NRO_PROTOCOLO', ftString)]
    [Dictionary('NFE_NRO_PROTOCOLO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property NFE_NRO_PROTOCOLO: nullable<String> read FNFE_NRO_PROTOCOLO
      write FNFE_NRO_PROTOCOLO;

    [Column('NFE_DTH_PROTOCOLO', ftString)]
    [Dictionary('NFE_DTH_PROTOCOLO', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property NFE_DTH_PROTOCOLO: nullable<TDateTime> read FNFE_DTH_PROTOCOLO
      write FNFE_DTH_PROTOCOLO;

    [Column('NFE_FINALIDADE', ftString)]
    [Dictionary('NFE_FINALIDADE', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property NFE_FINALIDADE: nullable<String> read FNFE_FINALIDADE
      write FNFE_FINALIDADE;

    [Column('NFE_INDFINAL', ftInteger)]
    [Dictionary('NFE_INDFINAL', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property NFE_INDFINAL: Integer read FNFE_INDFINAL write FNFE_INDFINAL;

    [Column('NFE_INDPRES', ftInteger)]
    [Dictionary('NFE_INDPRES', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property NFE_INDPRES: Integer read FNFE_INDPRES write FNFE_INDPRES;

    [Column('IND_EMITENTE', ftInteger)]
    [Dictionary('IND_EMITENTE', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property IND_EMITENTE: nullable<Integer> read FIND_EMITENTE
      write FIND_EMITENTE;

    [Column('IND_PGTO', ftInteger)]
    [Dictionary('IND_PGTO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property IND_PGTO: nullable<Integer> read FIND_PGTO write FIND_PGTO;

    [Column('IND_FRETE', ftInteger)]
    [Dictionary('IND_FRETE', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property IND_FRETE: nullable<Integer> read FIND_FRETE write FIND_FRETE;

    [Column('IND_NAT_FRETE', ftInteger)]
    [Dictionary('IND_NAT_FRETE', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property IND_NAT_FRETE: nullable<Integer> read FIND_NAT_FRETE
      write FIND_NAT_FRETE;

    [Column('CK_CSOSN', ftBoolean)]
    [Dictionary('CK_CSOSN', 'Mensagem de validação', '', '', '',
      taCenter)]
    property CK_CSOSN: Boolean read FCK_CSOSN write FCK_CSOSN;

    [Column('CTE_TIPO', ftString)]
    [Dictionary('CTE_TIPO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property CTE_TIPO: nullable<String> read FCTE_TIPO write FCTE_TIPO;

    [Column('ICMSNAOSOMADESPESAS', ftBoolena)]
    [Dictionary('ICMSNAOSOMADESPESAS', 'Mensagem de validação', '', '', '',
      taCenter)]
    property ICMSNAOSOMADESPESAS: Boolean read FICMSNAOSOMADESPESAS
      write FICMSNAOSOMADESPESAS;

    [Column('IPINAOSOMADESPESAS', ftBoolena)]
    [Dictionary('IPINAOSOMADESPESAS', 'Mensagem de validação', '', '', '',
      taCenter)]
    property IPINAOSOMADESPESAS: Boolean read FIPINAOSOMADESPESAS
      write FIPINAOSOMADESPESAS;

    [Column('IPIDEDUZDESCONTO', ftBoolena)]
    [Dictionary('IPIDEDUZDESCONTO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property IPIDEDUZDESCONTO: Boolean read FIPIDEDUZDESCONTO
      write FIPIDEDUZDESCONTO;

    [Column('ID_USUARIO_ALT', ftInteger)]
    [Dictionary('ID_USUARIO_ALT', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_USUARIO_ALT: nullable<Integer> read FID_USUARIO_ALT
      write FID_USUARIO_ALT;

    [Column('COMISSAO', ftCurrency)]
    [Dictionary('COMISSAO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property COMISSAO: Currency read FCOMISSAO write FCOMISSAO;

    [Column('ID_ORIGEM', ftInteger)]
    [Dictionary('ID_ORIGEM', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property ID_ORIGEM: Integer read FID_ORIGEM write FID_ORIGEM;

    [Column('REVENDA', ftCenter)]
    [Dictionary('REVENDA', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property REVENDA: Boolean read FREVENDA write FREVENDA;

    [Column('CANCELADA', ftString)]
    [Dictionary('CANCELADA', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property CANCELADA: String read FCANCELADA write FCANCELADA;

    [Column('STATUS', ftString)]
    [Dictionary('STATUS', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property STATUS: String read FSTATUS write FSTATUS;

    [Column('OBS', ftString)]
    [Dictionary('OBS', 'Mensagem de validação', '', '', '',
      taLefthJustify)]
    property OBS: nullable<String> read FOBS write FOBS;

    [Column('VALOR_FCP', ftCurrency)]
    [Dictionary('VALOR_FCP', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property VALOR_FCP: Currency read FVALOR_FCP write FVALOR_FCP;

    [Column('VALOR_ICMS_UF_DEST', ftCurrency)]
    [Dictionary('VALOR_ICMS_UF_DEST', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property VALOR_ICMS_UF_DEST: Currency read FVALOR_ICMS_UF_DEST
      write FVALOR_ICMS_UF_DEST;

    [Column('VALOR_ICMS_UF_REMET', ftCurrency)]
    [Dictionary('VALOR_ICMS_UF_REMET', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property VALOR_ICMS_UF_REMET: Currency read FVALOR_ICMS_UF_REMET
      write FVALOR_ICMS_UF_REMET;

    [Column('TROCO', ftCurrency)]
    [Dictionary('TROCO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property TROCO: Currency read FTROCO write FTROCO;

    [Column('DT_INC', ftDateTime)]
    [Dictionary('DT_INC', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property DT_INC: TDateTime read FDT_INC write FDT_INC;

    [Column('DT_ALT', ftDateTime)]
    [Dictionary('DT_ALT', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property DT_ALT: TDateTime read FDT_ALT write FDT_ALT;

    [Column('DT_HAB', ftDateTime)]
    [Dictionary('DT_HAB', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property DT_HAB: nullable<TDateTime> read FDT_HAB write FDT_HAB;

    [Column('BLOQUEADO', ftInteger)]
    [Dictionary('BLOQUEADO', 'Mensagem de validação', '', '', '',
      taRightJustify)]
    property BLOQUEADO: Boolean read FBLOQUEADO write FBLOQUEADO;

  end;

implementation

{ TPDV_NOTAS_FISCAIS_CAB }

constructor TPDV_NOTAS_FISCAIS_CAB.Create;
begin

end;

destructor TPDV_NOTAS_FISCAIS_CAB.Destroy;
begin

  inherited;
end;

end.
