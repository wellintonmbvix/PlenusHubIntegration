unit model.pedido_venda;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections,

  model.PEDIDO_VENDA_ITEM,

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
  [Table('PEDIDO_VENDA', '')]
  [PrimaryKey('ID_PEDIDO_VENDA', TAutoIncType.AutoInc,
                                          TGeneratorType.TableInc,
                                          TSortingOrder.NoSort,
                                          True, 'Chave primária')]
  [OrderBy('ID_PEDIDO_VENDA')]
  TPEDIDO_VENDA = class
  private
    { Private declarations } 
    FID_PEDIDO_VENDA: Nullable<Integer>;
    FCODIGO: Integer;
    FID_EMPRESA: Integer;
    FID_COLABORADOR: Integer;
    FID_CLIENTE: Integer;
    FID_NATUREZA_OPERACAO: Integer;
    FID_TRANSPORTADORA: Nullable<Integer>;
    FID_LOCAL_COBRANCA: Integer;
    FID_PRODUTO_TABELA: Integer;
    FID_FORNECEDOR: Nullable<Integer>;
    FID_PEDIDO_COMPRA: Nullable<Integer>;
    FID_PEDIDO_VENDA_REF: Nullable<Integer>;
    FSTATUS: Integer;
//    FTOTAL_QUANTIDADE: Double;
//    FTOTAL_BRUTO: Double;
//    FTOTAL_DESCONTO: Double;
//    FTOTAL_ACRESCIMO: Double;
//    FTOTAL_ARREDONDAMENTO: Double;
//    FTOTAL_FRETE: Double;
    FTOTAL_SEGURO: Double;
    FTOTAL_DESPESA: Double;
    FTOTAL_LIQUIDO: Double;
    FOBSERVACAO: Nullable<String>;
    FDT_EMISSAO: TDateTime;
    FDT_ENTREGA: Nullable<TDateTime>;
    FDT_INC: TDateTime;
    FDT_ALT: Nullable<TDateTime>;
    FDT_HAB: Nullable<TDateTime>;
    FMARCA: Boolean;
    FBLOQUEADO: Boolean;
    FPEDIDO_VENDA_ITEM: TObjectList<TPEDIDO_VENDA_ITEM>;

    function GetQtdeTotal: Double;
    function GetTotalBruto: Double;
    function GetTotalDesconto: Double;
    function GetTotalAcrescimo: Double;
    function GetTotalArredondamento: Double;
    function GetTotalFrete: Double;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

    [Column('ID_PEDIDO_VENDA', ftInteger)]
    [Dictionary('ID_PEDIDO_VENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pedido_venda: Nullable<Integer> read FID_PEDIDO_VENDA write FID_PEDIDO_VENDA;

    [Restrictions([NotNull])]
    [Column('CODIGO', ftInteger)]
    [Dictionary('CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property codigo: Integer read FCODIGO write FCODIGO;

    [Restrictions([NotNull])]
    [Column('ID_EMPRESA', ftInteger)]
    [Dictionary('ID_EMPRESA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_empresa: Integer read FID_EMPRESA write FID_EMPRESA;

    [Restrictions([NotNull])]
    [Column('ID_COLABORADOR', ftInteger)]
    [Dictionary('ID_COLABORADOR', 'Mensagem de validação', '', '', '', taCenter)]
    property id_colaborador: Integer read FID_COLABORADOR write FID_COLABORADOR;

    [Restrictions([NotNull])]
    [Column('ID_CLIENTE', ftInteger)]
    [Dictionary('ID_CLIENTE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_cliente: Integer read FID_CLIENTE write FID_CLIENTE;

    [Restrictions([NotNull])]
    [Column('ID_NATUREZA_OPERACAO', ftInteger)]
    [Dictionary('ID_NATUREZA_OPERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_natureza_operacao: Integer read FID_NATUREZA_OPERACAO write FID_NATUREZA_OPERACAO;

    [Column('ID_TRANSPORTADORA', ftInteger)]
    [Dictionary('ID_TRANSPORTADORA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_transportadora: Nullable<Integer> read FID_TRANSPORTADORA write FID_TRANSPORTADORA;

    [Restrictions([NotNull])]
    [Column('ID_LOCAL_COBRANCA', ftInteger)]
    [Dictionary('ID_LOCAL_COBRANCA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_local_cobranca: Integer read FID_LOCAL_COBRANCA write FID_LOCAL_COBRANCA;

    [Restrictions([NotNull])]
    [Column('ID_PRODUTO_TABELA', ftInteger)]
    [Dictionary('ID_PRODUTO_TABELA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_produto_tabela: Integer read FID_PRODUTO_TABELA write FID_PRODUTO_TABELA;

    [Column('ID_FORNECEDOR', ftInteger)]
    [Dictionary('ID_FORNECEDOR', 'Mensagem de validação', '', '', '', taCenter)]
    property id_fornecedor: Nullable<Integer> read FID_FORNECEDOR write FID_FORNECEDOR;

    [Column('ID_PEDIDO_COMPRA', ftInteger)]
    [Dictionary('ID_PEDIDO_COMPRA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pedido_compra: Nullable<Integer> read FID_PEDIDO_COMPRA write FID_PEDIDO_COMPRA;

    [Column('ID_PEDIDO_VENDA_REF', ftInteger)]
    [Dictionary('ID_PEDIDO_VENDA_REF', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pedido_venda_ref: Nullable<Integer> read FID_PEDIDO_VENDA_REF write FID_PEDIDO_VENDA_REF;

    [Restrictions([NotNull])]
    [Column('STATUS', ftInteger)]
    [Dictionary('STATUS', 'Mensagem de validação', '', '', '', taCenter)]
    property status: Integer read FSTATUS write FSTATUS;

    [Restrictions([NotNull])]
    [Column('TOTAL_QUANTIDADE', ftBCD, 93, 6)]
    [Dictionary('TOTAL_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_quantidade: Double read GetQtdeTotal;

    [Restrictions([NotNull])]
    [Column('TOTAL_BRUTO', ftBCD)]
    [Dictionary('TOTAL_BRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_bruto: Double read GetTotalBruto;

    [Restrictions([NotNull])]
    [Column('TOTAL_DESCONTO', ftBCD)]
    [Dictionary('TOTAL_DESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_desconto: Double read GetTotalDesconto;

    [Restrictions([NotNull])]
    [Column('TOTAL_ACRESCIMO', ftBCD)]
    [Dictionary('TOTAL_ACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_acrescimo: Double read GetTotalAcrescimo;

    [Restrictions([NotNull])]
    [Column('TOTAL_ARREDONDAMENTO', ftBCD)]
    [Dictionary('TOTAL_ARREDONDAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_arredondamento: Double read GetTotalArredondamento;

    [Restrictions([NotNull])]
    [Column('TOTAL_FRETE', ftBCD)]
    [Dictionary('TOTAL_FRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property total_frete: Double read GetTotalFrete;

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

    [Column('OBSERVACAO', ftString, 8000)]
    [Dictionary('OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property observacao: Nullable<String> read FOBSERVACAO write FOBSERVACAO;

    [Restrictions([NotNull])]
    [Column('DT_EMISSAO', ftDateTime)]
    [Dictionary('DT_EMISSAO', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property dt_emissao: TDateTime read FDT_EMISSAO write FDT_EMISSAO;

    [Column('DT_ENTREGA', ftDateTime)]
    [Dictionary('DT_ENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property dt_entrega: Nullable<TDateTime> read FDT_ENTREGA write FDT_ENTREGA;

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

    [Association(TMultiplicity.OneToMany, 'ID_PEDIDO_VENDA',
    'PEDIDO_VENDA', 'ID_PEDIDO_VENDA')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property PEDIDO_VENDA_ITEM: TObjectList<TPEDIDO_VENDA_ITEM> read FPEDIDO_VENDA_ITEM write FPEDIDO_VENDA_ITEM;

  end;

implementation

constructor TPEDIDO_VENDA.Create;
begin
  FPEDIDO_VENDA_ITEM := TObjectList<TPEDIDO_VENDA_ITEM>.Create;
end;

destructor TPEDIDO_VENDA.Destroy;
begin
  FreeAndNil(FPEDIDO_VENDA_ITEM);
  inherited;
end;

function TPEDIDO_VENDA.GetQtdeTotal: Double;
begin
  Result := 0;
  for var i := 0 to FPEDIDO_VENDA_ITEM.Count - 1 do
    Result := Result + FPEDIDO_VENDA_ITEM.Items[i].quantidade;
end;

function TPEDIDO_VENDA.GetTotalAcrescimo: Double;
begin
  Result := 0;
  for var i := 0 to FPEDIDO_VENDA_ITEM.Count - 1 do
    Result := Result + FPEDIDO_VENDA_ITEM.Items[i].total_acrescimo;
end;

function TPEDIDO_VENDA.GetTotalArredondamento: Double;
begin
  Result := 0;
  for var i := 0 to FPEDIDO_VENDA_ITEM.Count - 1 do
    Result := Result + FPEDIDO_VENDA_ITEM.Items[i].total_arredondamento;
end;

function TPEDIDO_VENDA.GetTotalBruto: Double;
begin
  Result := 0;
  for var i := 0 to FPEDIDO_VENDA_ITEM.Count - 1 do
    Result := Result + FPEDIDO_VENDA_ITEM.Items[i].total_bruto;
end;

function TPEDIDO_VENDA.GetTotalDesconto: Double;
begin
  Result := 0;
  for var i := 0 to FPEDIDO_VENDA_ITEM.Count - 1 do
    Result := Result + FPEDIDO_VENDA_ITEM.Items[i].total_desconto;
end;

function TPEDIDO_VENDA.GetTotalFrete: Double;
begin
  Result := 0;
  for var i := 0 to FPEDIDO_VENDA_ITEM.Count - 1 do
    Result := Result + FPEDIDO_VENDA_ITEM.Items[i].total_frete;
end;

initialization
  TRegisterClass.RegisterEntity(TPEDIDO_VENDA)

end.
