unit model.pedido_venda_item;

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
  [Table('PEDIDO_VENDA_ITEM', '')]
  [PrimaryKey('ID_PEDIDO_VENDA_ITEM', TAutoIncType.AutoInc,
                                          TGeneratorType.TableInc,
                                          TSortingOrder.NoSort,
                                          True, 'Chave primária')]
  [OrderBy('ID_PEDIDO_VENDA_ITEM')]
  TPEDIDO_VENDA_ITEM = class
  private
    { Private declarations } 
    FID_PEDIDO_VENDA_ITEM: Nullable<Integer>;
    FID_PEDIDO_VENDA: Integer;
    FID_SKU: Integer;
    FID_PRODUTO: Integer;
    FID_NATUREZA_OPERACAO: Integer;
    FID_PRODUTO_TABELA: Integer;
    FITEM: Integer;
    FCOD_PEDIDO_COMPRA: Nullable<String>;
    FITEM_PEDIDO_COMPRA: Nullable<Integer>;
    FESPECIFICACAO: Nullable<String>;
    FQUANTIDADE: Double;
    FQUANTIDADE_FATURAR: Double;
    FQUANTIDADE_ATENDIDA: Double;
    FPRECO_TABELA: Double;
    FPRECO_VENDA: Double;
    FDESCONTO: Double;
    FACRESCIMO: Double;
    FARREDONDAMENTO: Double;
    FFRETE: Double;
    FSEGURO: Double;
    FDESPESAS: Double;
    FTOTAL_BRUTO: Double;
    FTOTAL_DESCONTO: Double;
    FTOTAL_ACRESCIMO: Double;
    FTOTAL_ARREDONDAMENTO: Double;
    FTOTAL_FRETE: Double;
    FTOTAL_SEGURO: Double;
    FTOTAL_DESPESA: Double;
    FTOTAL_LIQUIDO: Double;
    FDT_INC: TDateTime;
    FDT_ALT: Nullable<TDateTime>;
    FDT_HAB: Nullable<TDateTime>;
    FATUALIZADO: Boolean;
    FMARCA: Boolean;
    FBLOQUEADO: Boolean;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

    [Column('ID_PEDIDO_VENDA_ITEM', ftInteger)]
    [Dictionary('ID_PEDIDO_VENDA_ITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pedido_venda_item: Nullable<Integer> read FID_PEDIDO_VENDA_ITEM write FID_PEDIDO_VENDA_ITEM;

    [Restrictions([NotNull])]
    [Column('ID_PEDIDO_VENDA', ftInteger)]
    [Dictionary('ID_PEDIDO_VENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pedido_venda: Integer read FID_PEDIDO_VENDA write FID_PEDIDO_VENDA;

    [Restrictions([NotNull])]
    [Column('ID_SKU', ftInteger)]
    [Dictionary('ID_SKU', 'Mensagem de validação', '', '', '', taCenter)]
    property id_sku: Integer read FID_SKU write FID_SKU;

    [Restrictions([NotNull])]
    [Column('ID_PRODUTO', ftInteger)]
    [Dictionary('ID_PRODUTO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_produto: Integer read FID_PRODUTO write FID_PRODUTO;

    [Restrictions([NotNull])]
    [Column('ID_NATUREZA_OPERACAO', ftInteger)]
    [Dictionary('ID_NATUREZA_OPERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_natureza_operacao: Integer read FID_NATUREZA_OPERACAO write FID_NATUREZA_OPERACAO;

    [Restrictions([NotNull])]
    [Column('ID_PRODUTO_TABELA', ftInteger)]
    [Dictionary('ID_PRODUTO_TABELA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_produto_tabela: Integer read FID_PRODUTO_TABELA write FID_PRODUTO_TABELA;

    [Restrictions([NotNull])]
    [Column('ITEM', ftInteger)]
    [Dictionary('ITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property item: Integer read FITEM write FITEM;

    [Column('COD_PEDIDO_COMPRA', ftString, 50)]
    [Dictionary('COD_PEDIDO_COMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cod_pedido_compra: Nullable<String> read FCOD_PEDIDO_COMPRA write FCOD_PEDIDO_COMPRA;

    [Column('ITEM_PEDIDO_COMPRA', ftInteger)]
    [Dictionary('ITEM_PEDIDO_COMPRA', 'Mensagem de validação', '', '', '', taCenter)]
    property item_pedido_compra: Nullable<Integer> read FITEM_PEDIDO_COMPRA write FITEM_PEDIDO_COMPRA;

    [Column('ESPECIFICACAO', ftString, 8000)]
    [Dictionary('ESPECIFICACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property especificacao: Nullable<String> read FESPECIFICACAO write FESPECIFICACAO;

    [Restrictions([NotNull])]
    [Column('QUANTIDADE', ftBCD)]
    [Dictionary('QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property quantidade: Double read FQUANTIDADE write FQUANTIDADE;

    [Restrictions([NotNull])]
    [Column('QUANTIDADE_FATURAR', ftBCD, 93, 6)]
    [Dictionary('QUANTIDADE_FATURAR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property quantidade_faturar: Double read FQUANTIDADE_FATURAR write FQUANTIDADE_FATURAR;

    [Restrictions([NotNull])]
    [Column('QUANTIDADE_ATENDIDA', ftBCD)]
    [Dictionary('QUANTIDADE_ATENDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property quantidade_atendida: Double read FQUANTIDADE_ATENDIDA write FQUANTIDADE_ATENDIDA;

    [Restrictions([NotNull])]
    [Column('PRECO_TABELA', ftBCD)]
    [Dictionary('PRECO_TABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property preco_tabela: Double read FPRECO_TABELA write FPRECO_TABELA;

    [Restrictions([NotNull])]
    [Column('PRECO_VENDA', ftBCD)]
    [Dictionary('PRECO_VENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property preco_venda: Double read FPRECO_VENDA write FPRECO_VENDA;

    [Restrictions([NotNull])]
    [Column('DESCONTO', ftBCD, 93, 6)]
    [Dictionary('DESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property desconto: Double read FDESCONTO write FDESCONTO;

    [Restrictions([NotNull])]
    [Column('ACRESCIMO', ftBCD)]
    [Dictionary('ACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property acrescimo: Double read FACRESCIMO write FACRESCIMO;

    [Restrictions([NotNull])]
    [Column('ARREDONDAMENTO', ftBCD)]
    [Dictionary('ARREDONDAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property arredondamento: Double read FARREDONDAMENTO write FARREDONDAMENTO;

    [Restrictions([NotNull])]
    [Column('FRETE', ftBCD)]
    [Dictionary('FRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property frete: Double read FFRETE write FFRETE;

    [Restrictions([NotNull])]
    [Column('SEGURO', ftBCD)]
    [Dictionary('SEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property seguro: Double read FSEGURO write FSEGURO;

    [Restrictions([NotNull])]
    [Column('DESPESAS', ftBCD)]
    [Dictionary('DESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property despesas: Double read FDESPESAS write FDESPESAS;

    [Restrictions([NotNull])]
    [Column('TOTAL_BRUTO', ftBCD)]
    [Dictionary('TOTAL_BRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_bruto: Double read FTOTAL_BRUTO write FTOTAL_BRUTO;

    [Restrictions([NotNull])]
    [Column('TOTAL_DESCONTO', ftBCD)]
    [Dictionary('TOTAL_DESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_desconto: Double read FTOTAL_DESCONTO write FTOTAL_DESCONTO;

    [Restrictions([NotNull])]
    [Column('TOTAL_ACRESCIMO', ftBCD)]
    [Dictionary('TOTAL_ACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_acrescimo: Double read FTOTAL_ACRESCIMO write FTOTAL_ACRESCIMO;

    [Restrictions([NotNull])]
    [Column('TOTAL_ARREDONDAMENTO', ftBCD)]
    [Dictionary('TOTAL_ARREDONDAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_arredondamento: Double read FTOTAL_ARREDONDAMENTO write FTOTAL_ARREDONDAMENTO;

    [Restrictions([NotNull])]
    [Column('TOTAL_FRETE', ftBCD, 48, 6)]
    [Dictionary('TOTAL_FRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_frete: Double read FTOTAL_FRETE write FTOTAL_FRETE;

    [Restrictions([NotNull])]
    [Column('TOTAL_SEGURO', ftBCD)]
    [Dictionary('TOTAL_SEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_seguro: Double read FTOTAL_SEGURO write FTOTAL_SEGURO;

    [Restrictions([NotNull])]
    [Column('TOTAL_DESPESA', ftBCD)]
    [Dictionary('TOTAL_DESPESA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_despesa: Double read FTOTAL_DESPESA write FTOTAL_DESPESA;

    [Restrictions([NotNull])]
    [Column('TOTAL_LIQUIDO', ftBCD)]
    [Dictionary('TOTAL_LIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_liquido: Double read FTOTAL_LIQUIDO write FTOTAL_LIQUIDO;

    [Restrictions([NotNull])]
    [Column('ATUALIZADO', ftBoolean)]
    [Dictionary('ATUALIZADO', 'Mensagem de validação', 'false', '', '', taCenter)]
    property atualizado: Boolean read FATUALIZADO write FATUALIZADO;

    [Restrictions([NotNull])]
    [Column('DT_INC', ftDateTime)]
    [Dictionary('DT_INC', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property dt_inc: TDateTime read FDT_INC write FDT_INC;

    [Column('DT_ALT', ftDateTime)]
    [Dictionary('DT_ALT', 'Mensagem de validação', '', '', '', taCenter)]
    property dt_alt: Nullable<TDateTime> read FDT_ALT write FDT_ALT;

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

constructor TPEDIDO_VENDA_ITEM.Create;
begin
  //
end;

destructor TPEDIDO_VENDA_ITEM.Destroy;
begin
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TPEDIDO_VENDA_ITEM)

end.
