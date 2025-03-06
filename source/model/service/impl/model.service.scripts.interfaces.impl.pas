unit model.service.scripts.interfaces.impl;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Rtti,
  System.TypInfo,

  Vcl.Dialogs,

  dbebr.factory.interfaces,
  dbebr.factory.firedac,
  cqlbr.select.mssql,
  cqlbr.serialize.mssql,
  ormbr.criteria.resultset,
  ormbr.types.nullable,

  firedac.Comp.Client,
  firedac.Comp.DataSet,
  firedac.UI.Intf,
  firedac.VCLUI.Wait,
  firedac.Comp.UI,
  firedac.Stan.Param,

  model.PESSOA,
  model.PARAMETROS,
  model.CONTATO,
  model.CONTATO_TELEFONE,
  model.CONTATO_EMAIL,
  model.PDV_NOTAS_FISCAIS_CAB,
  model.PDV_NOTAS_FISCAIS_ITEM,
  model.PEDIDO_VENDA,
  model.PEDIDO_VENDA_ITEM,
  model.service.scripts.interfaces,
  model.resource.interfaces;

type
  TServiceScripts = class(TInterfacedObject, IServiceScripts)
  private
    FConnection: IConnection;
    FConnectionORM: IDBConnection;
    FServiceScripts: IServiceScripts;

  public
    constructor Create;
    destructor Destroy; override;
    class function New: IServiceScripts;

    function viewStockProducts(PARAMETROS: TPARAMETROS; dtData: TDate;
      var aList: TFDMemTable): IServiceScripts;
    function savePerson(PESSOA: TPESSOA; PARAMETROS: TPARAMETROS;
      nLoja: Integer; var msg: String): IServiceScripts;
    function ifCustomerExist(aCpfCnpj: String; var cliente: TFDMemTable): Boolean;
    function saveOrder(PDV_NOTAS_FISCAIS: TPDV_NOTAS_FISCAIS_CAB;
      var msg: String): Boolean; overload;
    function saveOrder(PEDIDO_VENDA: TPEDIDO_VENDA; var msg: String)
      : Boolean; overload;
    function getLastOrderCode(id_empresa: Integer): Integer;
    function getLastCustomerCode: Integer;
    function viewSku(aFilter: String; var aTable: TFDMemTable): Boolean;
  end;

implementation

{ TServiceScripts }

uses
  cqlbr.interfaces,
  criteria.query.language,
  model.resource.impl.factory;

constructor TServiceScripts.Create;
begin
  FConnection := TResource.New.Connection;
  FConnectionORM := TFactoryFiredac.Create
    (TFDConnection(FConnection.Connect), dnMSSQL);
end;

destructor TServiceScripts.Destroy;
begin
  inherited;
end;

function TServiceScripts.ifCustomerExist(aCpfCnpj: String; var cliente: TFDMemTable): Boolean;
var
  lQry: TFDQuery;
begin
  Result := False;
  lQry := TFDQuery.Create(nil);
  lQry.Connection := TFDConnection(FConnection.Connect);
  Try
    With lQry Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM VW_CADCLIENTE');
      SQL.Add('WHERE CPFCNPJ = :CPFCNPJ');
      ParamByName('CPFCNPJ').AsString := aCpfCnpj;
      Open;
      if RecordCount > 0 then
        begin
          if cliente.Active then
            cliente.EmptyDataSet;

          cliente.CloneCursor(lQry);
          Result := True;
        end;
    End;
  Finally
    FreeAndNil(lQry);
  End;
end;

class function TServiceScripts.New: IServiceScripts;
begin
  Result := Self.Create;
end;

function TServiceScripts.getLastCustomerCode: Integer;
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(nil);
  lQry.Connection := TFDConnection(FConnection.Connect);
  Result := 0;
  Try
    With lQry Do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ISNULL(MAX(CODIGO), 0) + 1 AS MAXCOD FROM CLIENTE');
      SQL.Add('WHERE CODIGO < 9999999');
      Open;
      Result := FieldByName('MAXCOD').AsInteger;
    end;
  Finally
    FreeAndNil(lQry);
  End;
end;

function TServiceScripts.getLastOrderCode(id_empresa: Integer): Integer;
var
  lQry: TFDQuery;
begin
  lQry := TFDQuery.Create(nil);
  lQry.Connection := TFDConnection(FConnection.Connect);
  Result := 0;
  Try
    With lQry Do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT RIGHT(ISNULL(MAX(CODIGO),0),4) + 1 AS CODIGO');
      SQL.Add('FROM PDV_NOTAS_FISCAIS_CAB WHERE ID_EMPRESA = :id_empresa');
      SQL.Add('AND CAST(DT_EMISSAO AS date) = '+QuotedStr(FormatDateTime('YYYY/mm/dd', Date())) );
      ParamByName('id_empresa').AsInteger := id_empresa;
      Open;
      Result := FieldByName('CODIGO').AsInteger;
    end;
  Finally
    FreeAndNil(lQry);
  End;
end;

function TServiceScripts.saveOrder(PDV_NOTAS_FISCAIS: TPDV_NOTAS_FISCAIS_CAB;
  var msg: String): Boolean;
var
  FDTransaction: TFDTransaction;
  lQry,
  lQryEstoque,
  lQryKardex: TFDQuery;
begin
  FDTransaction := TFDTransaction.Create(nil);
  lQry := TFDQuery.Create(nil);
  lQryEstoque := TFDQuery.Create(nil);
  lQryKardex := TFDQuery.Create(nil);
  FDTransaction.Connection := TFDConnection(FConnection.Connect);
  lQry.Connection := FDTransaction.Connection;
  lQryEstoque.Connection := FDTransaction.Connection;
  lQryKardex.Connection := FDTransaction.Connection;
  FDTransaction.StartTransaction;

  Try
    Try

      With lQry Do
      begin

        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO PDV_NOTAS_FISCAIS_CAB(');
        SQL.Add('CODIGO');
        SQL.Add(',ID_TIPO_AMBIENTE_NFE');
        SQL.Add(',ID_TIPO_EMISSAO_NFE');
        SQL.Add(',TIPO_CADASTRO');
        SQL.Add(',ID_CLI_FOR');
        SQL.Add(',ID_COLABORADOR');
        SQL.Add(',ID_EMPRESA');
        SQL.Add(',DT_EMISSAO');
        SQL.Add(',ID_FORMA_PAGAMENTO');
        SQL.Add(',OPERACAO');
        SQL.Add(',ID_PRODUTO_TABELA');
        SQL.Add(',IEST');
        SQL.Add(',MODELO');
        SQL.Add(',SERIE');
        SQL.Add(',SUBSERIE');
        SQL.Add(',NUM_NOTA');
        SQL.Add(',DT_NOTA');
        SQL.Add(',NOME_DESTINATARIO');
        SQL.Add(',CPF_CNPJ_DESTINATARIO');
        SQL.Add(',TELEFONE_DESTINATARIO');
        SQL.Add(',ENDERECO_DESTINATARIO');
        SQL.Add(',SITUACAO');
        SQL.Add(',ID_TRANSPORTADORA');
        SQL.Add(',CIF_FOB');
        SQL.Add(',TRAN_FRETE_POR_CONTA');
        SQL.Add(',TRAN_QTDE_VOLUMES');
        SQL.Add(',TRAN_ESPECIE');
        SQL.Add(',TRAN_NUMERACAO');
        SQL.Add(',TRAN_PESO_BRUTO');
        SQL.Add(',TRAN_PESO_LIQUIDO');
        SQL.Add(',TOTAL_QUANTIDADE');
        SQL.Add(',TOTAL_BRUTO');
        SQL.Add(',TOTAL_CRED_CSOSN');
        SQL.Add(',TOTAL_BASE_ICMS');
        SQL.Add(',TOTAL_ICMS');
        SQL.Add(',TOTAL_REDU_BASE');
        SQL.Add(',TOTAL_BASE_SUBTRIB');
        SQL.Add(',TOTAL_SUB_TRIB');
        SQL.Add(',TOTAL_BASE_PIS');
        SQL.Add(',TOTAL_PIS');
        SQL.Add(',TOTAL_BASE_COFINS');
        SQL.Add(',TOTAL_COFINS');
        SQL.Add(',TOTAL_BASE_IPI');
        SQL.Add(',TOTAL_IPI');
        SQL.Add(',TOTAL_BASE_ISSQN');
        SQL.Add(',TOTAL_ISSQN');
        SQL.Add(',TOTAL_BASE_II');
        SQL.Add(',TOTAL_II_ADUANEIRA');
        SQL.Add(',TOTAL_II_IOF');
        SQL.Add(',TOTAL_II');
        SQL.Add(',TOTAL_ACRESCIMO');
        SQL.Add(',TOTAL_DESCONTO');
        SQL.Add(',TOTAL_CREDITO');
        SQL.Add(',PERC_COMISSAO');
        SQL.Add(',TOTAL_COMISSAO');
        SQL.Add(',TOTAL_FRETE');
        SQL.Add(',TOTAL_SEGURO');
        SQL.Add(',TOTAL_DESPESA');
        SQL.Add(',TOTAL_LIQUIDO');
        SQL.Add(',TOTAL_ISENTO');
        SQL.Add(',TOTAL_NAO_TRIBUT');
        SQL.Add(',TOTAL_CANCELADO');
        SQL.Add(',CK_IPINAODEDUZDESCONTO');
        SQL.Add(',NFE_FINALIDADE');
        SQL.Add(',NFE_INDFINAL');
        SQL.Add(',NFE_INDPRES');
        SQL.Add(',IND_EMITENTE');
        SQL.Add(',IND_PGTO');
        SQL.Add(',IND_FRETE');
        SQL.Add(',IND_NAT_FRETE');
        SQL.Add(',CK_CSOSN');
        SQL.Add(',ICMSNAOSOMADESPESAS');
        SQL.Add(',IPINAOSOMADESPESAS');
        SQL.Add(',IPIDEDUZDESCONTO');
        SQL.Add(',ID_USUARIO_ALT');
        SQL.Add(',COMISSAO');
        SQL.Add(',ID_ORIGEM');
        SQL.Add(',REVENDA');
        SQL.Add(',CANCELADA');
        SQL.Add(',CONTIGENCIA');
        SQL.Add(',STATUS');
        SQL.Add(',OBS');
        SQL.Add(',VALOR_FCP');
        SQL.Add(',VALOR_ICMS_UF_DEST');
        SQL.Add(',VALOR_ICMS_UF_REMET');
        SQL.Add(',TROCO');
        SQL.Add(',DT_INC');
        SQL.Add(',DT_ALT');
        SQL.Add(',MARCA');
        SQL.Add(',BLOQUEADO)');
        SQL.Add('OUTPUT INSERTED.ID_PDV_NOTAS_FISCAIS_CAB AS ID');
        SQL.Add('VALUES(');
        SQL.Add(':CODIGO');
        SQL.Add(',:ID_TIPO_AMBIENTE_NFE');
        SQL.Add(',:ID_TIPO_EMISSAO_NFE');
        SQL.Add(',:TIPO_CADASTRO');
        SQL.Add(',:ID_CLI_FOR');
        SQL.Add(',:ID_COLABORADOR');
        SQL.Add(',:ID_EMPRESA');
        SQL.Add(',:DT_EMISSAO');
        SQL.Add(',:ID_FORMA_PAGAMENTO');
        SQL.Add(',:OPERACAO');
        SQL.Add(',:ID_PRODUTO_TABELA');
        SQL.Add(',:IEST');
        SQL.Add(',:MODELO');
        SQL.Add(',:SERIE');
        SQL.Add(',:SUBSERIE');
        SQL.Add(',:NUM_NOTA');
        SQL.Add(',:DT_NOTA');
        SQL.Add(',:NOME_DESTINATARIO');
        SQL.Add(',:CPF_CNPJ_DESTINATARIO');
        SQL.Add(',:TELEFONE_DESTINATARIO');
        SQL.Add(',:ENDERECO_DESTINATARIO');
        SQL.Add(',:SITUACAO');
        SQL.Add(',:ID_TRANSPORTADORA');
        SQL.Add(',:CIF_FOB');
        SQL.Add(',:TRAN_FRETE_POR_CONTA');
        SQL.Add(',:TRAN_QTDE_VOLUMES');
        SQL.Add(',:TRAN_ESPECIE');
        SQL.Add(',:TRAN_NUMERACAO');
        SQL.Add(',:TRAN_PESO_BRUTO');
        SQL.Add(',:TRAN_PESO_LIQUIDO');
        SQL.Add(',:TOTAL_QUANTIDADE');
        SQL.Add(',:TOTAL_BRUTO');
        SQL.Add(',:TOTAL_CRED_CSOSN');
        SQL.Add(',:TOTAL_BASE_ICMS');
        SQL.Add(',:TOTAL_ICMS');
        SQL.Add(',:TOTAL_REDU_BASE');
        SQL.Add(',:TOTAL_BASE_SUBTRIB');
        SQL.Add(',:TOTAL_SUB_TRIB');
        SQL.Add(',:TOTAL_BASE_PIS');
        SQL.Add(',:TOTAL_PIS');
        SQL.Add(',:TOTAL_BASE_COFINS');
        SQL.Add(',:TOTAL_COFINS');
        SQL.Add(',:TOTAL_BASE_IPI');
        SQL.Add(',:TOTAL_IPI');
        SQL.Add(',:TOTAL_BASE_ISSQN');
        SQL.Add(',:TOTAL_ISSQN');
        SQL.Add(',:TOTAL_BASE_II');
        SQL.Add(',:TOTAL_II_ADUANEIRA');
        SQL.Add(',:TOTAL_II_IOF');
        SQL.Add(',:TOTAL_II');
        SQL.Add(',:TOTAL_ACRESCIMO');
        SQL.Add(',:TOTAL_DESCONTO');
        SQL.Add(',:TOTAL_CREDITO');
        SQL.Add(',:PERC_COMISSAO');
        SQL.Add(',:TOTAL_COMISSAO');
        SQL.Add(',:TOTAL_FRETE');
        SQL.Add(',:TOTAL_SEGURO');
        SQL.Add(',:TOTAL_DESPESA');
        SQL.Add(',:TOTAL_LIQUIDO');
        SQL.Add(',:TOTAL_ISENTO');
        SQL.Add(',:TOTAL_NAO_TRIBUT');
        SQL.Add(',:TOTAL_CANCELADO');
        SQL.Add(',:CK_IPINAODEDUZDESCONTO');
        SQL.Add(',:NFE_FINALIDADE');
        SQL.Add(',:NFE_INDFINAL');
        SQL.Add(',:NFE_INDPRES');
        SQL.Add(',:IND_EMITENTE');
        SQL.Add(',:IND_PGTO');
        SQL.Add(',:IND_FRETE');
        SQL.Add(',:IND_NAT_FRETE');
        SQL.Add(',:CK_CSOSN');
        SQL.Add(',:ICMSNAOSOMADESPESAS');
        SQL.Add(',:IPINAOSOMADESPESAS');
        SQL.Add(',:IPIDEDUZDESCONTO');
        SQL.Add(',:ID_USUARIO_ALT');
        SQL.Add(',:COMISSAO');
        SQL.Add(',:ID_ORIGEM');
        SQL.Add(',:REVENDA');
        SQL.Add(',:CANCELADA');
        SQL.Add(',:CONTIGENCIA');
        SQL.Add(',:STATUS');
        SQL.Add(',:OBS');
        SQL.Add(',:VALOR_FCP');
        SQL.Add(',:VALOR_ICMS_UF_DEST');
        SQL.Add(',:VALOR_ICMS_UF_REMET');
        SQL.Add(',:TROCO');
        SQL.Add(',:DT_INC');
        SQL.Add(',:DT_ALT');
        SQL.Add(',:MARCA');
        SQL.Add(',:BLOQUEADO);');
        ParamByName('codigo').Value := PDV_NOTAS_FISCAIS.codigo;
        ParamByName('id_tipo_ambiente_nfe').Value :=
          PDV_NOTAS_FISCAIS.id_tipo_ambiente_nfe;
        ParamByName('id_tipo_emissao_nfe').Value :=
          PDV_NOTAS_FISCAIS.id_tipo_emissao_nfe;
        ParamByName('tipo_cadastro').Value := PDV_NOTAS_FISCAIS.tipo_cadastro;
        ParamByName('id_cli_for').Value := PDV_NOTAS_FISCAIS.id_cli_for;
        ParamByName('id_colaborador').Value := PDV_NOTAS_FISCAIS.id_colaborador;
        ParamByName('id_empresa').Value := PDV_NOTAS_FISCAIS.id_empresa;
        ParamByName('dt_emissao').Value := PDV_NOTAS_FISCAIS.dt_emissao;
        ParamByName('id_forma_pagamento').Value :=
          PDV_NOTAS_FISCAIS.id_forma_pagamento;
        ParamByName('operacao').Value := PDV_NOTAS_FISCAIS.operacao;
        ParamByName('id_produto_tabela').Value :=
          PDV_NOTAS_FISCAIS.id_produto_tabela;
        ParamByName('iest').Value := PDV_NOTAS_FISCAIS.iest;
        if not PDV_NOTAS_FISCAIS.iest.HasValue then
          ParamByName('iest').Clear(0);
        ParamByName('modelo').Value := PDV_NOTAS_FISCAIS.modelo;
        ParamByName('serie').Value := PDV_NOTAS_FISCAIS.serie;
        ParamByName('subserie').Value := PDV_NOTAS_FISCAIS.subserie;
        ParamByName('num_nota').Value := PDV_NOTAS_FISCAIS.num_nota;
        if not PDV_NOTAS_FISCAIS.num_nota.HasValue then
          ParamByName('num_nota').Clear(0);

        ParamByName('dt_nota').Value := PDV_NOTAS_FISCAIS.dt_nota;
        ParamByName('nome_destinatario').Value :=
          PDV_NOTAS_FISCAIS.nome_destinatario;
        if not PDV_NOTAS_FISCAIS.nome_destinatario.HasValue then
          ParamByName('nome_destinatario').Clear(0);

        ParamByName('cpf_cnpj_destinatario').Value :=
          PDV_NOTAS_FISCAIS.cpf_cnpj_destinatario;
        if not PDV_NOTAS_FISCAIS.cpf_cnpj_destinatario.HasValue then
          ParamByName('cpf_cnpj_destinatario').Clear(0);

        ParamByName('telefone_destinatario').Value :=
          PDV_NOTAS_FISCAIS.telefone_destinatario;
        if not PDV_NOTAS_FISCAIS.telefone_destinatario.HasValue then
          ParamByName('telefone_destinatario').Clear(0);

        ParamByName('endereco_destinatario').Value :=
          PDV_NOTAS_FISCAIS.endereco_destinatario;
        if not PDV_NOTAS_FISCAIS.endereco_destinatario.HasValue then
          ParamByName('endereco_destinatario').Clear(0);

        ParamByName('situacao').Value := PDV_NOTAS_FISCAIS.situacao;
        ParamByName('id_transportadora').Value :=
          PDV_NOTAS_FISCAIS.id_transportadora;
        if not PDV_NOTAS_FISCAIS.id_transportadora.HasValue then
          ParamByName('id_transportadora').Clear(0);

        ParamByName('cif_fob').Value := PDV_NOTAS_FISCAIS.cif_fob;
        ParamByName('tran_frete_por_conta').Value :=
          PDV_NOTAS_FISCAIS.tran_frete_por_conta;
        ParamByName('tran_qtde_volumes').Value :=
          PDV_NOTAS_FISCAIS.tran_qtde_volumes;
        ParamByName('tran_especie').Value := PDV_NOTAS_FISCAIS.tran_especie;
        ParamByName('tran_numeracao').Value := PDV_NOTAS_FISCAIS.tran_numeracao;
        ParamByName('tran_peso_bruto').Value :=
          PDV_NOTAS_FISCAIS.tran_peso_bruto;
        ParamByName('tran_peso_liquido').Value :=
          PDV_NOTAS_FISCAIS.tran_peso_liquido;
        ParamByName('total_quantidade').Value :=
          PDV_NOTAS_FISCAIS.total_quantidade;
        ParamByName('total_bruto').Value := PDV_NOTAS_FISCAIS.total_bruto;
        ParamByName('total_cred_csosn').Value :=
          PDV_NOTAS_FISCAIS.total_cred_csosn;
        ParamByName('total_base_icms').Value :=
          PDV_NOTAS_FISCAIS.total_base_icms;
        ParamByName('total_icms').Value := PDV_NOTAS_FISCAIS.total_icms;
        ParamByName('total_redu_base').Value :=
          PDV_NOTAS_FISCAIS.total_redu_base;
        ParamByName('total_base_subtrib').Value :=
          PDV_NOTAS_FISCAIS.total_base_subtrib;
        ParamByName('total_sub_trib').Value := PDV_NOTAS_FISCAIS.total_sub_trib;
        ParamByName('total_base_pis').Value := PDV_NOTAS_FISCAIS.total_base_pis;
        ParamByName('total_pis').Value := PDV_NOTAS_FISCAIS.total_pis;
        ParamByName('total_base_cofins').Value :=
          PDV_NOTAS_FISCAIS.total_base_cofins;
        ParamByName('total_cofins').Value := PDV_NOTAS_FISCAIS.total_cofins;
        ParamByName('total_base_ipi').Value := PDV_NOTAS_FISCAIS.total_base_ipi;
        ParamByName('total_ipi').Value := PDV_NOTAS_FISCAIS.total_ipi;
        ParamByName('total_base_issqn').Value :=
          PDV_NOTAS_FISCAIS.total_base_issqn;
        ParamByName('total_issqn').Value := PDV_NOTAS_FISCAIS.total_issqn;
        ParamByName('total_base_ii').Value := PDV_NOTAS_FISCAIS.total_base_ii;
        ParamByName('total_ii_aduaneira').Value :=
          PDV_NOTAS_FISCAIS.total_ii_aduaneira;
        ParamByName('total_ii_iof').Value := PDV_NOTAS_FISCAIS.total_ii_iof;
        ParamByName('total_ii').Value := PDV_NOTAS_FISCAIS.total_ii;
        ParamByName('total_acrescimo').Value :=
          PDV_NOTAS_FISCAIS.total_acrescimo;
        ParamByName('total_desconto').Value := PDV_NOTAS_FISCAIS.total_desconto;
        ParamByName('total_credito').Value := PDV_NOTAS_FISCAIS.total_credito;
        ParamByName('perc_comissao').Value := PDV_NOTAS_FISCAIS.perc_comissao;
        ParamByName('total_comissao').Value := PDV_NOTAS_FISCAIS.total_comissao;
        ParamByName('total_frete').Value := PDV_NOTAS_FISCAIS.total_frete;
        ParamByName('total_seguro').Value := PDV_NOTAS_FISCAIS.total_seguro;
        ParamByName('total_despesa').Value := PDV_NOTAS_FISCAIS.total_despesa;
        ParamByName('total_liquido').Value := PDV_NOTAS_FISCAIS.total_liquido;
        ParamByName('total_isento').Value := PDV_NOTAS_FISCAIS.total_isento;
        ParamByName('total_nao_tribut').Value :=
          PDV_NOTAS_FISCAIS.total_nao_tribut;
        ParamByName('total_cancelado').Value :=
          PDV_NOTAS_FISCAIS.total_cancelado;
        ParamByName('ck_ipinaodeduzdesconto').Value :=
          PDV_NOTAS_FISCAIS.ck_ipinaodeduzdesconto;
        ParamByName('nfe_finalidade').Value := PDV_NOTAS_FISCAIS.nfe_finalidade;
        ParamByName('nfe_indfinal').Value := PDV_NOTAS_FISCAIS.nfe_indfinal;
        ParamByName('nfe_indpres').Value := PDV_NOTAS_FISCAIS.nfe_indpres;
        ParamByName('ind_emitente').Value := PDV_NOTAS_FISCAIS.ind_emitente;
        ParamByName('ind_pgto').Value := PDV_NOTAS_FISCAIS.ind_pgto;
        ParamByName('ind_frete').Value := PDV_NOTAS_FISCAIS.ind_frete;
        ParamByName('ind_nat_frete').Value := PDV_NOTAS_FISCAIS.ind_nat_frete;
        ParamByName('ck_csosn').Value := PDV_NOTAS_FISCAIS.ck_csosn;
        ParamByName('icmsnaosomadespesas').Value :=
          PDV_NOTAS_FISCAIS.icmsnaosomadespesas;
        ParamByName('ipinaosomadespesas').Value :=
          PDV_NOTAS_FISCAIS.ipinaosomadespesas;
        ParamByName('ipideduzdesconto').Value :=
          PDV_NOTAS_FISCAIS.ipideduzdesconto;
        ParamByName('id_usuario_alt').Value := PDV_NOTAS_FISCAIS.id_usuario_alt;
        ParamByName('comissao').Value := PDV_NOTAS_FISCAIS.comissao;
        ParamByName('id_origem').Value := PDV_NOTAS_FISCAIS.id_origem;
        ParamByName('revenda').Value := PDV_NOTAS_FISCAIS.revenda;
        ParamByName('cancelada').Value := PDV_NOTAS_FISCAIS.cancelada;
        ParamByName('contigencia').Value := PDV_NOTAS_FISCAIS.contigencia;
        ParamByName('status').Value := PDV_NOTAS_FISCAIS.status;
        ParamByName('obs').Value := PDV_NOTAS_FISCAIS.obs;
        ParamByName('valor_fcp').Value := PDV_NOTAS_FISCAIS.valor_fcp;
        ParamByName('valor_icms_uf_dest').Value :=
          PDV_NOTAS_FISCAIS.valor_icms_uf_dest;
        ParamByName('valor_icms_uf_remet').Value :=
          PDV_NOTAS_FISCAIS.valor_icms_uf_remet;
        ParamByName('troco').Value := PDV_NOTAS_FISCAIS.troco;
        ParamByName('dt_inc').Value := PDV_NOTAS_FISCAIS.dt_inc;
        ParamByName('dt_alt').Value := PDV_NOTAS_FISCAIS.dt_alt;
        ParamByName('marca').Value := PDV_NOTAS_FISCAIS.marca;
        ParamByName('bloqueado').Value := PDV_NOTAS_FISCAIS.bloqueado;
        Open;

        var
        id_pdv_notas_fiscais := FieldByName('ID').AsInteger;

        for var Item in PDV_NOTAS_FISCAIS.PDV_NOTAS_FISCAIS_ITEM do
          begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO PDV_NOTAS_FISCAIS_ITEM(');
            SQL.Add('ID_PDV_NOTAS_FISCAIS_CAB');
            SQL.Add(',ID_NATUREZA_OPERACAO');
            SQL.Add(',ID_COLABORADOR');
            SQL.Add(',ITEM');
            SQL.Add(',ID_SKU');
            SQL.Add(',GTIN_PRODUTO');
            SQL.Add(',ID_PRODUTO');
            SQL.Add(',DESCRICAO');
            SQL.Add(',ID_UNIDADE_PRODUTO');
            SQL.Add(',QUANTIDADE');
            SQL.Add(',VALOR_UNITARIO');
            SQL.Add(',PRECO_TABELA');
            SQL.Add(',DESCONTO');
            SQL.Add(',ACRESCIMO');
            SQL.Add(',PERC_CRED_CSOSN');
            SQL.Add(',TOTAL_CRED_CSOSN');
            SQL.Add(',BASE_ICMS');
            SQL.Add(',ALIQ_ICMS');
            SQL.Add(',TOTAL_ICMS');
            SQL.Add(',PERC_REDU_BASE');
            SQL.Add(',VALOR_REDU_BASE');
            SQL.Add(',BASE_ISENTO');
            SQL.Add(',COD_NTRIBUT');
            SQL.Add(',BASE_NAO_TRIBUT');
            SQL.Add(',BASE_SUB_TRIB');
            SQL.Add(',MVA_SUB_TRIB');
            SQL.Add(',ALIQ_SUBTRIB');
            SQL.Add(',TOTAL_SUB_TRIB');
            SQL.Add(',CST_PIS');
            SQL.Add(',ALIQ_PIS');
            SQL.Add(',BASE_PIS');
            SQL.Add(',TOTAL_PIS');
            SQL.Add(',CST_COFINS');
            SQL.Add(',BASE_COFINS');
            SQL.Add(',ALIQ_COFINS');
            SQL.Add(',TOTAL_COFINS');
            SQL.Add(',BASE_IPI');
            SQL.Add(',ALIQ_IPI');
            SQL.Add(',TOTAL_IPI');
            SQL.Add(',BASE_ISSQN');
            SQL.Add(',ALIQ_ISSQN');
            SQL.Add(',TOTAL_ISSQN');
            SQL.Add(',BASE_II');
            SQL.Add(',ALIQ_II');
            SQL.Add(',TOTAL_II_ADUANEIRA');
            SQL.Add(',TOTAL_II_IOF');
            SQL.Add(',TOTAL_II');
            SQL.Add(',TOTAL_BRUTO');
            SQL.Add(',TOTAL_ACRESCIMO');
            SQL.Add(',TOTAL_DESCONTO');
            SQL.Add(',TOTAL_CREDITO');
            SQL.Add(',TOTAL_COMISSAO');
            SQL.Add(',TOTAL_FRETE');
            SQL.Add(',TOTAL_SEGURO');
            SQL.Add(',TOTAL_DESPESA');
            SQL.Add(',PRECO_LIQUIDO');
            SQL.Add(',TOTAL_LIQUIDO');
            SQL.Add(',PRECO_CUSTO');
            SQL.Add(',PRECO_UNITARIO');
            SQL.Add(',PRECO_UNITARIO_MEDIO');
            SQL.Add(',CUSTO_CONTABIL');
            SQL.Add(',CUSTO_LIQUIDO');
            SQL.Add(',CUSTO_REAL');
            SQL.Add(',CUSTO_MEDIO');
            SQL.Add(',IND_MOV');
            SQL.Add(',RESERVADO');
            SQL.Add(',PRESENTE');
            SQL.Add(',PROMOCAO');
            SQL.Add(',CANCELADO');
            SQL.Add(',FCP');
            SQL.Add(',ALIQ_INTERNA');
            SQL.Add(',ALIQ_INTERESTADUAL');
            SQL.Add(',BASE_DIF_ALIQ');
            SQL.Add(',DT_INC');
            SQL.Add(',DT_ALT');
            SQL.Add(',MARCA');
            SQL.Add(',BLOQUEADO)');
            SQL.Add('OUTPUT INSERTED.ID_PDV_NOTAS_FISCAIS_ITEM AS ID');
            SQL.Add('VALUES(');
            SQL.Add(':ID_PDV_NOTAS_FISCAIS_CAB');
            SQL.Add(',:ID_NATUREZA_OPERACAO');
            SQL.Add(',:ID_COLABORADOR');
            SQL.Add(',:ITEM');
            SQL.Add(',:ID_SKU');
            SQL.Add(',:GTIN_PRODUTO');
            SQL.Add(',:ID_PRODUTO');
            SQL.Add(',:DESCRICAO');
            SQL.Add(',:ID_UNIDADE_PRODUTO');
            SQL.Add(',:QUANTIDADE');
            SQL.Add(',:VALOR_UNITARIO');
            SQL.Add(',:PRECO_TABELA');
            SQL.Add(',:DESCONTO');
            SQL.Add(',:ACRESCIMO');
            SQL.Add(',:PERC_CRED_CSOSN');
            SQL.Add(',:TOTAL_CRED_CSOSN');
            SQL.Add(',:BASE_ICMS');
            SQL.Add(',:ALIQ_ICMS');
            SQL.Add(',:TOTAL_ICMS');
            SQL.Add(',:PERC_REDU_BASE');
            SQL.Add(',:VALOR_REDU_BASE');
            SQL.Add(',:BASE_ISENTO');
            SQL.Add(',:COD_NTRIBUT');
            SQL.Add(',:BASE_NAO_TRIBUT');
            SQL.Add(',:BASE_SUB_TRIB');
            SQL.Add(',:MVA_SUB_TRIB');
            SQL.Add(',:ALIQ_SUBTRIB');
            SQL.Add(',:TOTAL_SUB_TRIB');
            SQL.Add(',:CST_PIS');
            SQL.Add(',:ALIQ_PIS');
            SQL.Add(',:BASE_PIS');
            SQL.Add(',:TOTAL_PIS');
            SQL.Add(',:CST_COFINS');
            SQL.Add(',:BASE_COFINS');
            SQL.Add(',:ALIQ_COFINS');
            SQL.Add(',:TOTAL_COFINS');
            SQL.Add(',:BASE_IPI');
            SQL.Add(',:ALIQ_IPI');
            SQL.Add(',:TOTAL_IPI');
            SQL.Add(',:BASE_ISSQN');
            SQL.Add(',:ALIQ_ISSQN');
            SQL.Add(',:TOTAL_ISSQN');
            SQL.Add(',:BASE_II');
            SQL.Add(',:ALIQ_II');
            SQL.Add(',:TOTAL_II_ADUANEIRA');
            SQL.Add(',:TOTAL_II_IOF');
            SQL.Add(',:TOTAL_II');
            SQL.Add(',:TOTAL_BRUTO');
            SQL.Add(',:TOTAL_ACRESCIMO');
            SQL.Add(',:TOTAL_DESCONTO');
            SQL.Add(',:TOTAL_CREDITO');
            SQL.Add(',:TOTAL_COMISSAO');
            SQL.Add(',:TOTAL_FRETE');
            SQL.Add(',:TOTAL_SEGURO');
            SQL.Add(',:TOTAL_DESPESA');
            SQL.Add(',:PRECO_LIQUIDO');
            SQL.Add(',:TOTAL_LIQUIDO');
            SQL.Add(',(SELECT TOP 1 PRECO_CUSTO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            SQL.Add(',(SELECT TOP 1 PRECO_UNITARIO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            SQL.Add(',(SELECT TOP 1 PRECO_UNITARIO_MEDIO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            SQL.Add(',(SELECT TOP 1 CUSTO_CONTABIL FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            SQL.Add(',(SELECT TOP 1 CUSTO_LIQUIDO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            SQL.Add(',(SELECT TOP 1 CUSTO_REAL FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            SQL.Add(',(SELECT TOP 1 CUSTO_MEDIO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            SQL.Add(',:IND_MOV');
            SQL.Add(',:RESERVADO');
            SQL.Add(',:PRESENTE');
            SQL.Add(',:PROMOCAO');
            SQL.Add(',:CANCELADO');
            SQL.Add(',:FCP');
            SQL.Add(',:ALIQ_INTERNA');
            SQL.Add(',:ALIQ_INTERESTADUAL');
            SQL.Add(',:BASE_DIF_ALIQ');
            SQL.Add(',:DT_INC');
            SQL.Add(',:DT_ALT');
            SQL.Add(',:MARCA');
            SQL.Add(',:BLOQUEADO)');
            ParamByName('id_empresa').Value := PDV_NOTAS_FISCAIS.id_empresa;
            ParamByName('id_pdv_notas_fiscais_cab').Value :=
              id_pdv_notas_fiscais;
            ParamByName('id_natureza_operacao').Value := Item.id_natureza_operacao;
            ParamByName('id_colaborador').Value := Item.id_colaborador;
            ParamByName('item').Value := Item.item;
            ParamByName('id_sku').Value := Item.id_sku;
            ParamByName('gtin_produto').Value := Item.gtin_produto;
            if not Item.gtin_produto.HasValue then
              ParamByName('gtin_produto').Clear(0);

            ParamByName('id_produto').Value := Item.id_produto;
            ParamByName('descricao').Value := Item.descricao;
            if not Item.descricao.HasValue then
              ParamByName('descricao').Clear(0);

            ParamByName('id_unidade_produto').Value := Item.id_unidade_produto;
            ParamByName('quantidade').Value := Item.quantidade;
            ParamByName('valor_unitario').Value := Item.valor_unitario;
            ParamByName('preco_tabela').Value := Item.preco_tabela;
            ParamByName('desconto').Value := Item.desconto;
            ParamByName('acrescimo').Value := Item.acrescimo;
            ParamByName('perc_cred_csosn').Value := Item.perc_cred_csosn;
            ParamByName('total_cred_csosn').Value := Item.total_cred_csosn;
            ParamByName('base_icms').Value := Item.base_icms;
            ParamByName('aliq_icms').Value := Item.aliq_icms;
            ParamByName('total_icms').Value := Item.total_icms;
            ParamByName('perc_redu_base').Value := Item.perc_redu_base;
            ParamByName('valor_redu_base').Value := Item.valor_redu_base;
            ParamByName('base_isento').Value := Item.base_isento;
            ParamByName('cod_ntribut').Value := Item.cod_ntribut;
            ParamByName('base_nao_tribut').Value := Item.base_nao_tribut;
            ParamByName('base_sub_trib').Value := Item.base_sub_trib;
            ParamByName('mva_sub_trib').Value := Item.mva_sub_trib;
            ParamByName('aliq_subtrib').Value := Item.aliq_subtrib;
            ParamByName('total_sub_trib').Value := Item.total_sub_trib;
            ParamByName('cst_pis').Value := Item.cst_pis;
            if not Item.cst_pis.HasValue then
              ParamByName('cst_pis').Clear(0);

            ParamByName('aliq_pis').Value := Item.aliq_pis;
            ParamByName('base_pis').Value := Item.base_pis;
            ParamByName('total_pis').Value := Item.total_pis;
            ParamByName('cst_cofins').Value := Item.cst_cofins;
            if not Item.cst_cofins.HasValue then
              ParamByName('cst_cofins').Clear(0);

            ParamByName('base_cofins').Value := Item.base_cofins;
            ParamByName('aliq_cofins').Value := Item.aliq_cofins;
            ParamByName('total_cofins').Value := Item.total_cofins;
            ParamByName('base_ipi').Value := Item.base_ipi;
            ParamByName('aliq_ipi').Value := Item.aliq_ipi;
            ParamByName('total_ipi').Value := Item.total_ipi;
            ParamByName('base_issqn').Value := Item.base_issqn;
            ParamByName('aliq_issqn').Value := Item.aliq_issqn;
            ParamByName('total_issqn').Value := Item.total_issqn;
            ParamByName('base_ii').Value := Item.base_ii;
            ParamByName('aliq_ii').Value := Item.aliq_ii;
            ParamByName('total_ii_aduaneira').Value := Item.total_ii_aduaneira;
            ParamByName('total_ii_iof').Value := Item.total_ii_iof;
            ParamByName('total_ii').Value := Item.total_ii;
            ParamByName('total_bruto').Value := Item.total_bruto;
            ParamByName('total_acrescimo').Value := Item.total_acrescimo;
            ParamByName('total_desconto').Value := Item.total_desconto;
            ParamByName('total_credito').Value := Item.total_credito;
            ParamByName('total_comissao').Value := Item.total_comissao;
            ParamByName('total_frete').Value := Item.total_frete;
            ParamByName('total_seguro').Value := Item.total_seguro;
            ParamByName('total_despesa').Value := Item.total_despesa;
            ParamByName('preco_liquido').Value := Item.preco_liquido;
            ParamByName('total_liquido').Value := Item.total_liquido;
//            ParamByName('preco_custo').Value := Item.preco_custo;
//            ParamByName('preco_unitario').Value := Item.preco_unitario;
//            ParamByName('preco_unitario_medio').Value := Item.preco_unitario_medio;
//            ParamByName('custo_contabil').Value := Item.custo_contabil;
//            ParamByName('custo_liquido').Value := Item.custo_liquido;
//            ParamByName('custo_real').Value := Item.custo_real;
//            ParamByName('custo_medio').Value := Item.custo_medio;
            ParamByName('ind_mov').Value := Item.ind_mov;
            ParamByName('reservado').Value := Item.reservado;
            ParamByName('presente').Value := Item.presente;
            ParamByName('promocao').Value := Item.promocao;
            ParamByName('cancelado').Value := Item.cancelado;
            ParamByName('fcp').Value := Item.fcp;
            ParamByName('aliq_interna').Value := Item.aliq_interna;
            ParamByName('aliq_interestadual').Value := Item.aliq_interestadual;
            ParamByName('base_dif_aliq').Value := Item.base_dif_aliq;
            ParamByName('dt_inc').Value := Item.dt_inc;
            ParamByName('dt_alt').Value := Item.dt_alt;
            ParamByName('marca').Value := Item.marca;
            ParamByName('bloqueado').Value := Item.bloqueado;
            Open;

            var
            id_pdv_notas_item := FieldByName('ID').AsInteger;

            lQryEstoque.Close;
            lQryEstoque.SQL.Clear;
            lQryEstoque.SQL.Add('UPDATE ESTOQUE SET ');
            lQryEstoque.SQL.Add('ID_EMPRESA = :EMPRESA,');
            lQryEstoque.SQL.Add('QTD_DISPONIVEL = QTD_DISPONIVEL - :QTD_SAI,');
            lQryEstoque.SQL.Add('QTD_TOTAL = QTD_DISPONIVEL - QTD_RESERVADO - :QTD_SAI');
            lQryEstoque.SQL.Add('WHERE ID_SKU = :SKU AND ID_PRODUTO = :PRODUTO');
            lQryEstoque.ParamByName('EMPRESA').AsInteger := PDV_NOTAS_FISCAIS.id_empresa;
            lQryEstoque.ParamByName('QTD_SAI').AsCurrency := Item.quantidade;
            lQryEstoque.ParamByName('SKU').AsInteger := Item.id_sku;
            lQryEstoque.ParamByName('PRODUTO').AsInteger := Item.id_produto;
            lQryEstoque.ExecSQL;

            lQryKardex.Close;
            lQryKardex.SQL.Clear;
            lQryKardex.SQL.Add('INSERT INTO KARDEX(');
            lQryKardex.SQL.Add('ID_EMPRESA');
            lQryKardex.SQL.Add(',DATA_MOVIMENTO');
            lQryKardex.SQL.Add(',DATA_NOTA');
            lQryKardex.SQL.Add(',NOTA');
            lQryKardex.SQL.Add(',ID_TIPO_MOVIMENTO');
            lQryKardex.SQL.Add(',OPERACAO');
            lQryKardex.SQL.Add(',ITEM');
            lQryKardex.SQL.Add(',ID_SKU');
            lQryKardex.SQL.Add(',ID_PRODUTO');
            lQryKardex.SQL.Add(',QUANTIDADE');
            lQryKardex.SQL.Add(',ID_PRODUTO_TABELA');
            lQryKardex.SQL.Add(',ID_CODTABELA');
            lQryKardex.SQL.Add(',ST_TABELA');
            lQryKardex.SQL.Add(',PRECO_VENDIDO');
            lQryKardex.SQL.Add(',PRECO_UNITARIO');
            lQryKardex.SQL.Add(',PRECO_UNITARIO_MEDIO');
            lQryKardex.SQL.Add(',PRECO_CUSTO');
            lQryKardex.SQL.Add(',PRECO_TABELA');
            lQryKardex.SQL.Add(',CUSTO_CONTABIL');
            lQryKardex.SQL.Add(',CUSTO_LIQUIDO');
            lQryKardex.SQL.Add(',CUSTO_REAL');
            lQryKardex.SQL.Add(',CUSTO_MEDIO');
            lQryKardex.SQL.Add(',SALDO_ESTOQUE');
            lQryKardex.SQL.Add(',ESTOQUE_TOTAL');
            lQryKardex.SQL.Add(',ESTOQUE_RESERVADO');
            lQryKardex.SQL.Add(',TIPO_CADASTRO');
            lQryKardex.SQL.Add(',CODIGO_CADASTRO');
            lQryKardex.SQL.Add(',ID_USUARIO');
            lQryKardex.SQL.Add(',ID_COLABORADOR');
            lQryKardex.SQL.Add(',STATUS');
            lQryKardex.SQL.Add(',DT_INC');
            lQryKardex.SQL.Add(',DT_ALT)');
            lQryKardex.SQL.Add('VALUES(');
            lQryKardex.SQL.Add(':ID_EMPRESA');
            lQryKardex.SQL.Add(',:DATA_MOVIMENTO');
            lQryKardex.SQL.Add(',:DATA_NOTA');
            lQryKardex.SQL.Add(',:NOTA');
            lQryKardex.SQL.Add(',:ID_TIPO_MOVIMENTO');
            lQryKardex.SQL.Add(',:OPERACAO');
            lQryKardex.SQL.Add(',:ITEM');
            lQryKardex.SQL.Add(',:ID_SKU');
            lQryKardex.SQL.Add(',:ID_PRODUTO');
            lQryKardex.SQL.Add(',:QUANTIDADE');
            lQryKardex.SQL.Add(',:ID_PRODUTO_TABELA');
            lQryKardex.SQL.Add(',:ID_CODTABELA');
            lQryKardex.SQL.Add(',:ST_TABELA');
            lQryKardex.SQL.Add(',:PRECO_VENDIDO');
            lQryKardex.SQL.Add(',(SELECT TOP 1 PRECO_UNITARIO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',(SELECT TOP 1 PRECO_UNITARIO_MEDIO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',(SELECT TOP 1 PRECO_CUSTO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',:PRECO_TABELA');
            lQryKardex.SQL.Add(',(SELECT TOP 1 CUSTO_CONTABIL FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',(SELECT TOP 1 CUSTO_LIQUIDO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',(SELECT TOP 1 CUSTO_REAL FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',(SELECT TOP 1 CUSTO_MEDIO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',(SELECT TOP 1 QTD_DISPONIVEL FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',(SELECT TOP 1 QTD_TOTAL FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',(SELECT TOP 1 QTD_RESERVADO FROM ESTOQUE WHERE '+
              'ID_EMPRESA = :ID_EMPRESA AND ID_PRODUTO = :ID_PRODUTO '+
                'AND ID_SKU = :ID_SKU ORDER BY DT_INC DESC)');
            lQryKardex.SQL.Add(',:TIPO_CADASTRO');
            lQryKardex.SQL.Add(',:CODIGO_CADASTRO');
            lQryKardex.SQL.Add(',:ID_USUARIO');
            lQryKardex.SQL.Add(',:ID_COLABORADOR');
            lQryKardex.SQL.Add(',:STATUS');
            lQryKardex.SQL.Add(',:DT_INC');
            lQryKardex.SQL.Add(',:DT_ALT)');
            lQryKardex.ParamByName('ID_EMPRESA').AsInteger := PDV_NOTAS_FISCAIS.id_empresa;
            lQryKardex.ParamByName('DATA_MOVIMENTO').AsDateTime := now();
            lQryKardex.ParamByName('DATA_NOTA').AsDateTime := PDV_NOTAS_FISCAIS.dt_emissao;
            lQryKardex.ParamByName('NOTA').AsInteger := id_pdv_notas_fiscais;
            lQryKardex.ParamByName('ID_TIPO_MOVIMENTO').AsInteger := 2; // Tipo Venda
            lQryKardex.ParamByName('OPERACAO').AsString := 'S';
            lQryKardex.ParamByName('ITEM').AsInteger := Item.item;
            lQryKardex.ParamByName('ID_SKU').AsInteger := Item.id_sku;
            lQryKardex.ParamByName('ID_PRODUTO').AsInteger := Item.id_produto;
            lQryKardex.ParamByName('QUANTIDADE').AsCurrency := Item.quantidade;
            lQryKardex.ParamByName('ID_PRODUTO_TABELA').AsInteger := PDV_NOTAS_FISCAIS.id_produto_tabela;
            lQryKardex.ParamByName('ID_CODTABELA').AsInteger := id_pdv_notas_item;
            lQryKardex.ParamByName('ST_TABELA').AsString := 'PDV_NOTAS_FISCAIS_ITEM';
            lQryKardex.ParamByName('PRECO_VENDIDO').AsCurrency := Item.preco_unitario;
            lQryKardex.ParamByName('PRECO_TABELA').AsCurrency := Item.preco_tabela;
            lQryKardex.ParamByName('TIPO_CADASTRO').AsString := 'C';
            lQryKardex.ParamByName('CODIGO_CADASTRO').AsInteger := PDV_NOTAS_FISCAIS.id_cli_for;
            lQryKardex.ParamByName('ID_USUARIO').Value := PDV_NOTAS_FISCAIS.id_colaborador;
            lQryKardex.ParamByName('ID_COLABORADOR').Value := PDV_NOTAS_FISCAIS.id_colaborador;
            lQryKardex.ParamByName('STATUS').AsString := '0';
            lQryKardex.ParamByName('DT_INC').AsDateTime := PDV_NOTAS_FISCAIS.dt_inc;
            lQryKardex.ParamByName('DT_ALT').AsDateTime := PDV_NOTAS_FISCAIS.dt_alt;
            lQryKardex.ExecSQL;
          end;
      end;
      FDTransaction.Commit;
    Except
      on e: Exception do
      begin
        FDTransaction.Rollback;
        msg := e.Message;
      end;
    End;
  Finally
    FreeAndNil(lQryKardex);
    FreeAndNil(lQryEstoque);
    FreeAndNil(lQry);
    FreeAndNil(FDTransaction);
  End;
end;

function TServiceScripts.saveOrder(PEDIDO_VENDA: TPEDIDO_VENDA;
  var msg: String): Boolean;
var
  FDTransaction: TFDTransaction;
  lQry,
  lQryEstoque: TFDQuery;
begin
  FDTransaction := TFDTransaction.Create(nil);
  lQry := TFDQuery.Create(nil);
  lQryEstoque := TFDQuery.Create(nil);
  FDTransaction.Connection := TFDConnection(FConnection.Connect);
  lQry.Connection := FDTransaction.Connection;
  lQryEstoque.Connection := FDTransaction.Connection;
  FDTransaction.StartTransaction;

  Try
    try
      With lQry Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO PEDIDO_VENDA(');
        SQL.Add('CODIGO');
        SQL.Add(',ID_EMPRESA');
        SQL.Add(',ID_COLABORADOR');
        SQL.Add(',ID_CLIENTE');
        SQL.Add(',ID_NATUREZA_OPERACAO');
        SQL.Add(',ID_TRANSPORTADORA');
        SQL.Add(',ID_LOCAL_COBRANCA');
        SQL.Add(',ID_PRODUTO_TABELA');
        SQL.Add(',ID_FORNECEDOR');
        SQL.Add(',ID_PEDIDO_COMPRA');
        SQL.Add(',ID_PEDIDO_VENDA_REF');
        SQL.Add(',STATUS');
        SQL.Add(',OBSERVACAO');
        SQL.Add(',DT_EMISSAO');
        SQL.Add(',DT_ENTREGA');
        SQL.Add(',DT_INC');
        SQL.Add(',DT_ALT)');
        SQL.Add('OUTPUT INSERTED.ID_PEDIDO_VENDA AS ID');
        SQL.Add('VALUES(');
        SQL.Add(':CODIGO');
        SQL.Add(',:ID_EMPRESA');
        SQL.Add(',:ID_COLABORADOR');
        SQL.Add(',:ID_CLIENTE');
        SQL.Add(',:ID_NATUREZA_OPERACAO');
        SQL.Add(',:ID_TRANSPORTADORA');
        SQL.Add(',:ID_LOCAL_COBRANCA');
        SQL.Add(',:ID_PRODUTO_TABELA');
        SQL.Add(',:ID_FORNECEDOR');
        SQL.Add(',:ID_PEDIDO_COMPRA');
        SQL.Add(',:ID_PEDIDO_VENDA_REF');
        SQL.Add(',:STATUS');
        SQL.Add(',:OBSERVACAO');
        SQL.Add(',:DT_EMISSAO');
        SQL.Add(',:DT_ENTREGA');
        SQL.Add(',:DT_INC');
        SQL.Add(',:DT_ALT);');
        ParamByName('CODIGO').AsInteger := PEDIDO_VENDA.codigo;
        ParamByName('ID_EMPRESA').AsInteger := PEDIDO_VENDA.id_empresa;
        ParamByName('ID_COLABORADOR').AsInteger := PEDIDO_VENDA.id_colaborador;
        ParamByName('ID_CLIENTE').AsInteger := PEDIDO_VENDA.id_cliente;
        ParamByName('ID_NATUREZA_OPERACAO').AsInteger :=
          PEDIDO_VENDA.id_natureza_operacao;
        ParamByName('ID_TRANSPORTADORA').AsInteger :=
          PEDIDO_VENDA.id_transportadora;
        ParamByName('ID_LOCAL_COBRANCA').AsInteger :=
          PEDIDO_VENDA.id_local_cobranca;
        ParamByName('ID_PRODUTO_TABELA').AsInteger :=
          PEDIDO_VENDA.id_produto_tabela;
        ParamByName('ID_FORNECEDOR').AsInteger := PEDIDO_VENDA.id_fornecedor;
        ParamByName('ID_PEDIDO_COMPRA').AsInteger :=
          PEDIDO_VENDA.id_pedido_compra;
        ParamByName('ID_PEDIDO_VENDA_REF').AsInteger :=
          PEDIDO_VENDA.id_pedido_venda_ref;
        ParamByName('STATUS').AsInteger := 1; // ** Passando "status" como faturado
        ParamByName('OBSERVACAO').AsString := PEDIDO_VENDA.observacao;
        ParamByName('DT_EMISSAO').AsDateTime := PEDIDO_VENDA.dt_emissao;
        ParamByName('DT_ENTREGA').AsDateTime := PEDIDO_VENDA.dt_entrega;
        ParamByName('DT_INC').AsDateTime := PEDIDO_VENDA.dt_inc;
        ParamByName('DT_ALT').AsDateTime := PEDIDO_VENDA.dt_alt;
        Open;

        var
        pedido_venda_id := FieldByName('ID').AsInteger;

        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO PEDIDO_VENDA_ITEM(');
        SQL.Add('ID_PEDIDO_VENDA');
        SQL.Add(',ID_SKU');
        SQL.Add(',ID_PRODUTO');
        SQL.Add(',ID_NATUREZA_OPERACAO');
        SQL.Add(',ID_PRODUTO_TABELA');
        SQL.Add(',ITEM');
        SQL.Add(',QUANTIDADE');
        SQL.Add(',QUANTIDADE_FATURAR');
        SQL.Add(',PRECO_TABELA');
        SQL.Add(',PRECO_VENDA');
        SQL.Add(',DESCONTO');
        SQL.Add(',ACRESCIMO');
        SQL.Add(',ARREDONDAMENTO');
        SQL.Add(',FRETE');
        SQL.Add(',SEGURO');
        SQL.Add(',DESPESAS');
        SQL.Add(',TOTAL_BRUTO');
        SQL.Add(',TOTAL_DESCONTO');
        SQL.Add(',TOTAL_ACRESCIMO');
        SQL.Add(',TOTAL_ARREDONDAMENTO');
        SQL.Add(',TOTAL_FRETE');
        SQL.Add(',TOTAL_SEGURO');
        SQL.Add(',TOTAL_DESPESA');
        SQL.Add(',TOTAL_LIQUIDO');
        SQL.Add(',DT_INC');
        SQL.Add(',DT_ALT');
        SQL.Add(',ATUALIZADO)');
        SQL.Add('VALUES(');
        SQL.Add(':ID_PEDIDO_VENDA');
        SQL.Add(',:ID_SKU');
        SQL.Add(',:ID_PRODUTO');
        SQL.Add(',:ID_NATUREZA_OPERACAO');
        SQL.Add(',:ID_PRODUTO_TABELA');
        SQL.Add(',:ITEM');
        SQL.Add(',:QUANTIDADE');
        SQL.Add(',:QUANTIDADE_FATURAR');
        SQL.Add(',:PRECO_TABELA');
        SQL.Add(',:PRECO_VENDA');
        SQL.Add(',:DESCONTO');
        SQL.Add(',:ACRESCIMO');
        SQL.Add(',:ARREDONDAMENTO');
        SQL.Add(',:FRETE');
        SQL.Add(',:SEGURO');
        SQL.Add(',:DESPESAS');
        SQL.Add(',:TOTAL_BRUTO');
        SQL.Add(',:TOTAL_DESCONTO');
        SQL.Add(',:TOTAL_ACRESCIMO');
        SQL.Add(',:TOTAL_ARREDONDAMENTO');
        SQL.Add(',:TOTAL_FRETE');
        SQL.Add(',:TOTAL_SEGURO');
        SQL.Add(',:TOTAL_DESPESA');
        SQL.Add(',:TOTAL_LIQUIDO');
        SQL.Add(',:DT_INC');
        SQL.Add(',:DT_ALT');
        SQL.Add(',:ATUALIZADO);');

        Params.ArraySize := 0;

        lQryEstoque.Close;
        lQryEstoque.SQL.Clear;
        lQryEstoque.SQL.Add('UPDATE ESTOQUE SET ');
        lQryEstoque.SQL.Add('ID_EMPRESA = :EMPRESA,');
        lQryEstoque.SQL.Add('QTD_DISPONIVEL = QTD_DISPONIVEL - :QTD_SAI,');
        lQryEstoque.SQL.Add('QTD_TOTAL = QTD_DISPONIVEL + QTD_RESERVADO');
        lQryEstoque.SQL.Add('WHERE ID_SKU = :SKU AND ID_PRODUTO = :PRODUTO');

        lQryEstoque.Params.ArraySize := 0;

        With PEDIDO_VENDA Do
        Begin
          for var i := 0 to PEDIDO_VENDA_ITEM.Count - 1 do
          begin
            Params.ArraySize := Params.ArraySize + 1;
            ParamByName('ID_PEDIDO_VENDA').Value := pedido_venda_id;
            ParamByName('ID_SKU').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).id_sku;
            ParamByName('ID_PRODUTO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).id_produto;
            ParamByName('ID_NATUREZA_OPERACAO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM)
              .id_natureza_operacao;
            ParamByName('ID_PRODUTO_TABELA').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM)
              .id_produto_tabela;
            ParamByName('ITEM').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).item;
            ParamByName('QUANTIDADE').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).quantidade;
            ParamByName('QUANTIDADE_FATURAR').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM)
              .quantidade_faturar;
            ParamByName('PRECO_TABELA').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).preco_tabela;
            ParamByName('PRECO_VENDA').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).preco_venda;
            ParamByName('DESCONTO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).desconto;
            ParamByName('ACRESCIMO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).acrescimo;
            ParamByName('ARREDONDAMENTO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).arredondamento;
            ParamByName('FRETE').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).frete;
            ParamByName('SEGURO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).seguro;
            ParamByName('DESPESAS').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).despesas;
            ParamByName('TOTAL_BRUTO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).total_bruto;
            ParamByName('TOTAL_DESCONTO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).total_desconto;
            ParamByName('TOTAL_ACRESCIMO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM)
              .total_acrescimo;
            ParamByName('TOTAL_ARREDONDAMENTO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM)
              .total_arredondamento;
            ParamByName('TOTAL_FRETE').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).total_frete;
            ParamByName('TOTAL_SEGURO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).total_seguro;
            ParamByName('TOTAL_DESPESA').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).total_despesa;
            ParamByName('TOTAL_LIQUIDO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).total_liquido;
            ParamByName('DT_INC').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).dt_inc;
            ParamByName('DT_ALT').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).dt_alt;
            ParamByName('ATUALIZADO').Value :=
              (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).atualizado;

              lQryEstoque.Params.ArraySize := lQryEstoque.Params.ArraySize + 1;

              lQryEstoque.ParamByName('EMPRESA').AsInteger := PEDIDO_VENDA.id_empresa;
              lQryEstoque.ParamByName('QTD_SAI').AsCurrency :=
                (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).quantidade;
              lQryEstoque.ParamByName('SKU').AsInteger :=
                (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).id_sku;
              lQryEstoque.ParamByName('PRODUTO').AsInteger :=
                (PEDIDO_VENDA_ITEM.Items[i] as TPEDIDO_VENDA_ITEM).id_produto;
          end;
        End;
        lQryEstoque.Execute(lQryEstoque.Params.ArraySize); // Baixando estoque
        Execute(Params.ArraySize); // Inserindo os itens
      End;
      FDTransaction.Commit;
    Except
      On e: Exception do
      begin
        FDTransaction.Rollback;
        msg := e.Message;
      end;
    End;
  finally
    lQryEstoque.Close;
    lQry.Close;
    FreeAndNil(lQryEstoque);
    FreeAndNil(lQry);
    FreeAndNil(FDTransaction);
  end;
end;

function TServiceScripts.savePerson(PESSOA: TPESSOA; PARAMETROS: TPARAMETROS;
  nLoja: Integer; var msg: String): IServiceScripts;
var
  FDTransaction: TFDTransaction;
  lQry: TFDQuery;
begin
  FDTransaction := TFDTransaction.Create(nil);
  lQry := TFDQuery.Create(nil);
  FDTransaction.Connection := TFDConnection(FConnection.Connect);
  lQry.Connection := FDTransaction.Connection;
  FDTransaction.StartTransaction;

  Try
    Try
      With lQry Do
      Begin
        // ** INSERINDO DADOS NA TABELA PESSOA
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO PESSOA(');
        SQL.Add('NOME,');
        SQL.Add('ABREVIADO,');
        SQL.Add('TIPO,');
        SQL.Add('SITE,');
        SQL.Add('SUFRAMA,');
        SQL.Add('DT_INC,');
        SQL.Add('DT_ALT)');
        SQL.Add('OUTPUT INSERTED.ID_PESSOA');
        SQL.Add('VALUES(');
        SQL.Add(':NOME,');
        SQL.Add(':ABREVIADO,');
        SQL.Add(':TIPO,');
        SQL.Add(':SITE,');
        SQL.Add(':SUFRAMA,');
        SQL.Add(':DT_INC,');
        SQL.Add(':DT_ALT);');
        ParamByName('NOME').AsString := AnsiUpperCase(PESSOA.nome);
        ParamByName('ABREVIADO').AsString := AnsiUpperCase(PESSOA.abreviado);
        ParamByName('TIPO').AsString := PESSOA.tipo;
        ParamByName('SITE').AsString := AnsiLowerCase(PESSOA.site);
        if PESSOA.site.HasValue then
          ParamByName('SITE').Clear(0);
        ParamByName('SUFRAMA').AsString := PESSOA.suframa;
        if PESSOA.suframa.HasValue then
          ParamByName('SUFRAMA').Clear(0);
        ParamByName('DT_INC').AsDateTime := PESSOA.dt_inc;
        ParamByName('DT_ALT').AsDateTime := PESSOA.dt_alt;
        Open;

        // ** PEGANDO O IDENTITY PESSOA DA TRANSAÇÃO
        var
        pessoa_id := FieldByName('ID_PESSOA').AsInteger;

        // ** INSERINDO DADOS NA TABELA PESSOA_FISICA OU PESSOA_JURIDICA
        if PESSOA.tipo = 'F' then
        begin
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO PESSOA_FISICA(');
          SQL.Add('ID_PESSOA,');
          SQL.Add('ID_ESTADO_CIVIL,');
          SQL.Add('NOME,');
          SQL.Add('CPF,');
          SQL.Add('RG,');
          SQL.Add('ORGAO_RG,');
          SQL.Add('DATA_EMISSAO_RG,');
          SQL.Add('DATA_NASCIMENTO,');
          SQL.Add('SEXO,');
          SQL.Add('NAT_CIDADE,');
          SQL.Add('NAT_UF,');
          SQL.Add('NACIONALIDADE,');
          SQL.Add('INSCRICAO_MUNICIPAL,');
          SQL.Add('INSCRICAO_ESTADUAL,');
          SQL.Add('NUM_DEPENDENTES,');
          SQL.Add('TEMPO_RESIDENCIA,');
          SQL.Add('DT_INC,');
          SQL.Add('DT_ALT');
          SQL.Add(')VALUES(');
          SQL.Add(':ID_PESSOA,');
          SQL.Add(':ID_ESTADO_CIVIL,');
          SQL.Add(':NOME,');
          SQL.Add(':CPF,');
          SQL.Add(':RG,');
          SQL.Add(':ORGAO_RG,');
          SQL.Add(':DATA_EMISSAO_RG,');
          SQL.Add(':DATA_NASCIMENTO,');
          SQL.Add(':SEXO,');
          SQL.Add(':NAT_CIDADE,');
          SQL.Add(':NAT_UF,');
          SQL.Add(':NACIONALIDADE,');
          SQL.Add(':INSCRICAO_MUNICIPAL,');
          SQL.Add(':INSCRICAO_ESTADUAL,');
          SQL.Add(':NUM_DEPENDENTES,');
          SQL.Add(':TEMPO_RESIDENCIA,');
          SQL.Add(':DT_INC,');
          SQL.Add(':DT_ALT);');
          ParamByName('ID_PESSOA').AsInteger := pessoa_id;
          ParamByName('ID_ESTADO_CIVIL').AsInteger :=
            PESSOA.PESSOA_FISICA.id_estado_civil;
          if PESSOA.PESSOA_FISICA.id_estado_civil = 0 then
            ParamByName('ID_ESTADO_CIVIL').Clear(0);

          ParamByName('NOME').AsString := AnsiUpperCase(PESSOA.nome);
          ParamByName('CPF').AsString := PESSOA.PESSOA_FISICA.cpf;
          ParamByName('RG').AsString := PESSOA.PESSOA_FISICA.rg;
          if not PESSOA.PESSOA_FISICA.rg.HasValue then
            ParamByName('RG').Clear(0);

          ParamByName('ORGAO_RG').AsString := AnsiUpperCase(PESSOA.PESSOA_FISICA.orgao_rg);
          if not PESSOA.PESSOA_FISICA.orgao_rg.HasValue then
            ParamByName('ORGAO_RG').Clear(0);

          ParamByName('DATA_EMISSAO_RG').AsDateTime :=
            PESSOA.PESSOA_FISICA.data_emissao_rg;
          if not PESSOA.PESSOA_FISICA.data_emissao_rg.HasValue then
            ParamByName('DATA_EMISSAO_RG').Clear(0);

          ParamByName('DATA_NASCIMENTO').AsDateTime :=
            PESSOA.PESSOA_FISICA.data_nascimento;
          ParamByName('SEXO').AsString := PESSOA.PESSOA_FISICA.sexo;
          if not PESSOA.PESSOA_FISICA.sexo.HasValue then
            ParamByName('SEXO').Clear(0);

          ParamByName('NAT_CIDADE').AsString := AnsiUpperCase(PESSOA.PESSOA_FISICA.nat_cidade);
          if not PESSOA.PESSOA_FISICA.nat_cidade.HasValue then
            ParamByName('NAT_CIDADE').Clear(0);

          ParamByName('NAT_UF').AsString := AnsiUpperCase(PESSOA.PESSOA_FISICA.nat_uf);
          if not PESSOA.PESSOA_FISICA.nat_uf.HasValue then
            ParamByName('NAT_UF').Clear(0);

          ParamByName('NACIONALIDADE').AsString :=
            AnsiUpperCase(PESSOA.PESSOA_FISICA.nacionalidade);
          if not PESSOA.PESSOA_FISICA.nacionalidade.HasValue then
            ParamByName('NACIONALIDADE').Clear(0);

          ParamByName('INSCRICAO_MUNICIPAL').AsString :=
            AnsiUpperCase(PESSOA.PESSOA_FISICA.inscricao_municipal);
          ParamByName('INSCRICAO_ESTADUAL').AsString :=
            AnsiUpperCase(PESSOA.PESSOA_FISICA.inscricao_estadual);
          ParamByName('NUM_DEPENDENTES').AsInteger :=
            PESSOA.PESSOA_FISICA.num_dependentes;
          ParamByName('TEMPO_RESIDENCIA').AsInteger :=
            PESSOA.PESSOA_FISICA.tempo_residencia;
          ParamByName('DT_INC').AsDateTime := PESSOA.dt_inc;
          ParamByName('DT_ALT').AsDateTime := PESSOA.dt_alt;
          ExecSQL;
        end
        else
        begin
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO PESSOA_JURIDICA(');
          SQL.Add('ID_PESSOA,');
          SQL.Add('CNPJ,');
          SQL.Add('RAZAO_SOCIAL,');
          SQL.Add('FANTASIA,');
          SQL.Add('INSCRICAO_MUNICIPAL,');
          SQL.Add('INSCRICAO_ESTADUAL,');
          SQL.Add('DT_INC,');
          SQL.Add('DT_ALT');
          SQL.Add(')VALUES(');
          SQL.Add(':ID_PESSOA,');
          SQL.Add(':CNPJ,');
          SQL.Add(':RAZAO_SOCIAL,');
          SQL.Add(':FANTASIA,');
          SQL.Add(':INSCRICAO_MUNICIPAL,');
          SQL.Add(':INSCRICAO_ESTADUAL,');
          SQL.Add(':DT_INC,');
          SQL.Add(':DT_ALT);');
          ParamByName('ID_PESSOA').AsInteger := pessoa_id;
          ParamByName('CNPJ').AsString := PESSOA.PESSOA_JURIDICA.cnpj;
          ParamByName('RAZAO_SOCIAL').AsString :=
            AnsiUpperCase(PESSOA.PESSOA_JURIDICA.razao_social);
          ParamByName('FANTASIA').AsString := AnsiUpperCase(PESSOA.PESSOA_JURIDICA.fantasia);
          ParamByName('INSCRICAO_MUNICIPAL').AsString :=
            AnsiUpperCase(PESSOA.PESSOA_JURIDICA.inscricao_municipal);
          ParamByName('INSCRICAO_ESTADUAL').AsString :=
            AnsiUpperCase(PESSOA.PESSOA_JURIDICA.inscricao_estadual);
          ParamByName('DT_INC').AsDateTime := PESSOA.dt_inc;
          ParamByName('DT_ALT').AsDateTime := PESSOA.dt_alt;
          ExecSQL;
        end;

//        // ** PEGANDO O MAIOR CODIGO
//        Close;
//        SQL.Clear;
//        SQL.Add('SELECT ISNULL(MAX(CODIGO), 0) + 1 AS CODIGO');
//        SQL.Add(' FROM CLIENTE WHERE ID_EMPRESA = :empresa_id');
//        ParamByName('empresa_id').AsInteger :=
//          PARAMETROS.ID_EMPRESA_LOJA_VIRTUAL;
//        Open;
//        var
//        codigo := FieldByName('CODIGO').AsInteger;

        // ** INSERINDO DADOS NA TABELA CLIENTE
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO CLIENTE(');
        SQL.Add('CODIGO,');
        SQL.Add('ID_PESSOA,');
        SQL.Add('ID_EMPRESA,');
        SQL.Add('DESDE,');
        SQL.Add('ID_EMPRESA_PREF,');
        SQL.Add('LIMITE_PERSONALIZADO,');
        SQL.Add('LIMITE_CREDITO,');
        SQL.Add('DESCONSIDERAR_CHEQ_LIMITE_CREDITO,');
        SQL.Add('COMISSAO_VENDEDOR,');
        SQL.Add('FATURAR,');
        SQL.Add('DATA_ULTIMA_COMPRA,');
        SQL.Add('VALOR_ULTIMA_COMPRA,');
        SQL.Add('DATA_CADASTRO,');
        SQL.Add('USUARIO_CADASTRO,');
        SQL.Add('DATA_ALTERACAO,');
        SQL.Add('USUARIO_ALTERACAO,');
        SQL.Add('M_BLUSA,');
        SQL.Add('M_CALCA,');
        SQL.Add('M_CALCADO,');
        SQL.Add('SUSPENSO,');
        SQL.Add('ID_TIPO_VENDA,');
        SQL.Add('MARKUP_MIN,');
        SQL.Add('DT_INC,');
        SQL.Add('DT_ALT,');
        SQL.Add('MARCA,');
        SQL.Add('BLOQUEADO');
        SQL.Add(')VALUES(');
        SQL.Add(':CODIGO,');
        SQL.Add(':ID_PESSOA,');
        SQL.Add(':ID_EMPRESA,');
        SQL.Add(':DESDE,');
        SQL.Add(':ID_EMPRESA_PREF,');
        SQL.Add(':LIMITE_PERSONALIZADO,');
        SQL.Add(':LIMITE_CREDITO,');
        SQL.Add(':DESCONSIDERAR_CHEQ_LIMITE_CREDITO,');
        SQL.Add(':COMISSAO_VENDEDOR,');
        SQL.Add(':FATURAR,');
        SQL.Add(':DATA_ULTIMA_COMPRA,');
        SQL.Add(':VALOR_ULTIMA_COMPRA,');
        SQL.Add(':DATA_CADASTRO,');
        SQL.Add(':USUARIO_CADASTRO,');
        SQL.Add(':DATA_ALTERACAO,');
        SQL.Add(':USUARIO_ALTERACAO,');
        SQL.Add(':M_BLUSA,');
        SQL.Add(':M_CALCA,');
        SQL.Add(':M_CALCADO,');
        SQL.Add(':SUSPENSO,');
        SQL.Add(':ID_TIPO_VENDA,');
        SQL.Add(':MARKUP_MIN,');
        SQL.Add(':DT_INC,');
        SQL.Add(':DT_ALT,');
        SQL.Add(':MARCA,');
        SQL.Add(':BLOQUEADO)');
        ParamByName('CODIGO').AsInteger := PESSOA.CLIENTE.codigo;
        ParamByName('ID_PESSOA').AsInteger := pessoa_id;
        ParamByName('ID_EMPRESA').AsInteger :=
          PARAMETROS.ID_EMPRESA_LOJA_VIRTUAL;
        if not PARAMETROS.ID_EMPRESA_LOJA_VIRTUAL.HasValue then
          ParamByName('ID_EMPRESA').Clear(0);

        ParamByName('DESDE').AsDateTime := PESSOA.dt_inc;
        ParamByName('ID_EMPRESA_PREF').AsInteger :=
          PARAMETROS.ID_EMPRESA_LOJA_VIRTUAL;
        if PARAMETROS.ID_EMPRESA_LOJA_VIRTUAL.Value = 0 then
          ParamByName('ID_EMPRESA_PREF').Clear(0);

        ParamByName('LIMITE_PERSONALIZADO').AsBoolean := True;
        ParamByName('LIMITE_CREDITO').AsCurrency := 0;
        ParamByName('DESCONSIDERAR_CHEQ_LIMITE_CREDITO').AsBoolean := False;
        ParamByName('COMISSAO_VENDEDOR').AsCurrency := 0;
        ParamByName('FATURAR').AsBoolean := False;
        ParamByName('DATA_ULTIMA_COMPRA').AsDateTime := PESSOA.dt_inc;
        ParamByName('VALOR_ULTIMA_COMPRA').AsCurrency := 0;
        ParamByName('DATA_CADASTRO').AsDateTime := PESSOA.dt_inc;
        ParamByName('USUARIO_CADASTRO').AsInteger := 1;
        ParamByName('DATA_ALTERACAO').AsDateTime := PESSOA.dt_inc;
        ParamByName('USUARIO_ALTERACAO').AsInteger := 1;
        ParamByName('M_BLUSA').AsString := EmptyStr;
        ParamByName('M_CALCA').AsString := EmptyStr;
        ParamByName('M_CALCADO').AsString := EmptyStr;
        ParamByName('SUSPENSO').AsBoolean := False;
        ParamByName('ID_TIPO_VENDA').AsInteger := 1;
        ParamByName('MARKUP_MIN').AsCurrency := 0;
        ParamByName('DT_INC').AsDateTime := PESSOA.dt_inc;
        ParamByName('DT_ALT').AsDateTime := PESSOA.dt_alt;
        ParamByName('MARCA').AsBoolean := False;
        ParamByName('BLOQUEADO').AsBoolean := False;
        ExecSQL;

        // ** INSERINDO DADOS NA TABELA ENDERECO
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO ENDERECO(');
        SQL.Add('ID_PESSOA,');
        SQL.Add('ROTULO,');
        SQL.Add('CEP,');
        SQL.Add('LOGRADOURO,');
        SQL.Add('NUMERO,');
        SQL.Add('COMPLEMENTO,');
        SQL.Add('BAIRRO,');
        SQL.Add('CIDADE,');
        SQL.Add('MUNICIPIO_IBGE,');
        SQL.Add('UF,');
        SQL.Add('PAIS_IBGE,');
        SQL.Add('PRINCIPAL,');
        SQL.Add('ENTREGA,');
        SQL.Add('COBRANCA,');
        SQL.Add('DT_INC,');
        SQL.Add('DT_ALT');
        SQL.Add(')VALUES(');
        SQL.Add(':ID_PESSOA,');
        SQL.Add(':ROTULO,');
        SQL.Add(':CEP,');
        SQL.Add(':LOGRADOURO,');
        SQL.Add(':NUMERO,');
        SQL.Add(':COMPLEMENTO,');
        SQL.Add(':BAIRRO,');
        SQL.Add(':CIDADE,');
        SQL.Add(':MUNICIPIO_IBGE,');
        SQL.Add(':UF,');
        SQL.Add(':PAIS_IBGE,');
        SQL.Add(':PRINCIPAL,');
        SQL.Add(':ENTREGA,');
        SQL.Add(':COBRANCA,');
        SQL.Add(':DT_INC,');
        SQL.Add(':DT_ALT);');
        ParamByName('ID_PESSOA').AsInteger := pessoa_id;
        ParamByName('ROTULO').AsString := PESSOA.ENDERECO.rotulo;
        ParamByName('CEP').AsString := PESSOA.ENDERECO.cep;
        ParamByName('LOGRADOURO').AsString := AnsiUpperCase(PESSOA.ENDERECO.logradouro);
        ParamByName('NUMERO').AsString := AnsiUpperCase(PESSOA.ENDERECO.numero);
        if not PESSOA.ENDERECO.numero.HasValue then
          ParamByName('NUMERO').Clear(0);

        ParamByName('COMPLEMENTO').AsString := AnsiUpperCase(PESSOA.ENDERECO.complemento);
        if not PESSOA.ENDERECO.complemento.HasValue then
          ParamByName('COMPLEMENTO').Clear(0);

        ParamByName('BAIRRO').AsString := AnsiUpperCase(PESSOA.ENDERECO.bairro);
        ParamByName('CIDADE').AsString := AnsiUpperCase(PESSOA.ENDERECO.cidade);
        ParamByName('MUNICIPIO_IBGE').AsInteger :=
          PESSOA.ENDERECO.municipio_ibge;
        if PESSOA.ENDERECO.municipio_ibge.Value = 0then
          ParamByName('MUNICIPIO_IBGE').Clear(0);

        ParamByName('UF').AsString := AnsiUpperCase(PESSOA.ENDERECO.uf);
        ParamByName('PAIS_IBGE').AsInteger := PESSOA.ENDERECO.pais_ibge;
        if PESSOA.ENDERECO.pais_ibge.Value = 0 then
          ParamByName('PAIS_IBGE').Clear(0);

        ParamByName('PRINCIPAL').AsBoolean := PESSOA.ENDERECO.principal;
        ParamByName('ENTREGA').AsBoolean := PESSOA.ENDERECO.entrega;
        ParamByName('COBRANCA').AsBoolean := PESSOA.ENDERECO.cobranca;
        ParamByName('DT_INC').AsDateTime := PESSOA.dt_inc;
        ParamByName('DT_ALT').AsDateTime := PESSOA.dt_alt;
        ExecSQL;

        // ** INSERINDO DADOS NA TABELA CONTATO
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO CONTATO(');
        SQL.Add('NOME,');
        SQL.Add('ID_PESSOA,');
        SQL.Add('DT_INC,');
        SQL.Add('DT_ALT)');
        SQL.Add('OUTPUT INSERTED.ID_CONTATO');
        SQL.Add('VALUES(');
        SQL.Add(':NOME,');
        SQL.Add(':ID_PESSOA,');
        SQL.Add(':DT_INC,');
        SQL.Add(':DT_ALT)');
        ParamByName('NOME').AsString := AnsiUpperCase(PESSOA.nome);
        ParamByName('ID_PESSOA').AsInteger := pessoa_id;
        ParamByName('DT_INC').AsDateTime := PESSOA.dt_inc;
        ParamByName('DT_ALT').AsDateTime := PESSOA.dt_alt;
        Open;

        // ** PEGANDO O IDENTITY PESSOA DA TRANSAÇÃO
        var
        contato_id := FieldByName('ID_CONTATO').AsInteger;

        if (PESSOA.CONTATO[0].CONTATO_TELEFONE <> nil) And
          (PESSOA.CONTATO[0].CONTATO_TELEFONE.Count > 0) then
        begin
          // ** INSERINDO DADOS NA TABELA CONTATO TELEFONE
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO CONTATO_TELEFONE(');
          SQL.Add('ID_TIPO_TELEFONE,');
          SQL.Add('ID_CONTATO,');
          SQL.Add('TELEFONE,');
          SQL.Add('DT_INC,');
          SQL.Add('DT_ALT');
          SQL.Add(')VALUES(');
          SQL.Add(':ID_TIPO_TELEFONE,');
          SQL.Add(':ID_CONTATO,');
          SQL.Add(':TELEFONE,');
          SQL.Add(':DT_INC,');
          SQL.Add(':DT_ALT)');

          Params.ArraySize := 0;

          for var i := 0 to PESSOA.CONTATO[0].CONTATO_TELEFONE.Count - 1 do
          begin
            Params.ArraySize := Params.ArraySize + 1;

            ParamByName('ID_TIPO_TELEFONE').AsIntegers[i] :=
              (PESSOA.CONTATO[0].CONTATO_TELEFONE.Items[i] as TCONTATO_TELEFONE)
              .id_tipo_telefone;
            ParamByName('ID_CONTATO').AsIntegers[i] := contato_id;
            ParamByName('TELEFONE').AsStrings[i] :=
              (PESSOA.CONTATO[0].CONTATO_TELEFONE.Items[i]
              as TCONTATO_TELEFONE).telefone;
            ParamByName('DT_INC').AsDateTimes[i] := PESSOA.dt_inc;
            ParamByName('DT_ALT').AsDateTimes[i] := PESSOA.dt_alt;
          end;
          Execute(Params.ArraySize);
        end;

        if (PESSOA.CONTATO[0].CONTATO_EMAIL <> nil) And
          (PESSOA.CONTATO[0].CONTATO_EMAIL.Count > 0) then
        begin
          // ** INSERINDO DADOS NA TABELA CONTATO EMAIL
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO CONTATO_EMAIL(');
          SQL.Add('ID_CONTATO,');
          SQL.Add('ID_TIPO_EMAIL,');
          SQL.Add('EMAIL,');
          SQL.Add('EMAIL_MARKETING,');
          SQL.Add('DT_INC,');
          SQL.Add('DT_ALT');
          SQL.Add(')VALUES(');
          SQL.Add(':ID_CONTATO,');
          SQL.Add(':ID_TIPO_EMAIL,');
          SQL.Add(':EMAIL,');
          SQL.Add(':EMAIL_MARKETING,');
          SQL.Add(':DT_INC,');
          SQL.Add(':DT_ALT)');

          Params.ArraySize := 0;

          for var i := 0 to PESSOA.CONTATO[0].CONTATO_EMAIL.Count - 1 do
          begin
            Params.ArraySize := Params.ArraySize + 1;

            ParamByName('ID_CONTATO').AsIntegers[i] := contato_id;
            ParamByName('ID_TIPO_EMAIL').AsIntegers[i] :=
              (PESSOA.CONTATO[0].CONTATO_EMAIL.Items[i] as TCONTATO_EMAIL)
              .id_tipo_email;
            ParamByName('EMAIL').AsStrings[i] :=
              AnsiLowerCase((PESSOA.CONTATO[0].CONTATO_EMAIL.Items[i]
              as TCONTATO_EMAIL).email);
            ParamByName('EMAIL_MARKETING').AsBooleans[i] :=
              (PESSOA.CONTATO[0].CONTATO_EMAIL.Items[i] as TCONTATO_EMAIL)
              .email_marketing;
            ParamByName('DT_INC').AsDateTimes[i] := PESSOA.dt_inc;
            ParamByName('DT_ALT').AsDateTimes[i] := PESSOA.dt_alt;
          end;
          Execute(Params.ArraySize);
        end;

      End;
      FDTransaction.Commit;
    Except
      On e: Exception do
      begin
        FDTransaction.Rollback;
        msg := e.Message;
      end;
    End;
  Finally
    lQry.Close;
    FreeAndNil(lQry);
    FreeAndNil(FDTransaction);
  End;
end;

function TServiceScripts.viewSku(aFilter: String;
  var aTable: TFDMemTable): Boolean;
var
  LSQL: String;
  LResultSet: IDBResultSet;
begin
  Result := False;
  LSQL  := TCQL.New(dbnMSSQL)
      .Select
        .Column('s.ID_SKU')
        .Column('s.ID_PRODUTO')
        .Column('s.ID_PRODUTO_TAMANHO')
        .Column('s.ID_PRODUTO_COR')
        .Column('p.NOME')
        .Column('p.REFID')
        .Column('p.ID_UNIDADE_PRODUTO')
        .Column('CONVERT(varchar(14),cb.CODIGO_BARRAS)').&As('CODIGO_BARRAS')
      .From('SKU').&As('s')
    .WHERE(aFilter)
      .LeftJoin('SKU_CODIGO_BARRAS').&As('cb')
      .On('s.ID_SKU = cb.ID_SKU')
      .LeftJoin('PRODUTO').&As('p')
      .On('s.ID_PRODUTO = p.ID_PRODUTO')
    .GroupBy('s.ID_SKU, s.ID_PRODUTO, ID_PRODUTO_TAMANHO, ID_PRODUTO_COR, '+
      'p.NOME, p.REFID, p.ID_UNIDADE_PRODUTO, CODIGO_BARRAS')
  .AsString;

  LResultSet := TCriteria.New.SetConnection(FConnectionORM).SQL(LSQL)
    .AsResultSet;

  if aTable.Active then
    aTable.EmptyDataSet;

  if LResultSet.RecordCount > 0 then
    aTable.CloneCursor(TFDDataSet(LResultSet.DataSet));
end;

function TServiceScripts.viewStockProducts(PARAMETROS: TPARAMETROS;
  dtData: TDate; var aList: TFDMemTable): IServiceScripts;
var
  LSQL: String;
  LResultSet: IDBResultSet;
begin
  Result := Self;
  var
  id_empresa := PARAMETROS.ID_EMPRESA_LOJA_VIRTUAL;
  var
  dtFormatada := FormatDateTime('YYYY-mm-dd', dtData);
  LSQL := TCQL.New(dbnMSSQL).select.Column('ESTOQUE.ID_EMPRESA').&As('EMPRESA')
    .Column('SKU.ID_SKU').&As('SKU').Column('P.REFID')
    .Column('P.CODIGO_FABRICANTE').&As('CODIGO_FABRICANTE').Column('P.NOME')
    .Column('G.NOME').&As('GRUPO').Column('M.NOME').&As('MARCA')
    .Column('SG.NOME').&As('SUBGRUPO').Column('T.ID_PRODUTO_TAMANHO')
    .&As('ID_TAMANHO').Column('T.SIGLA').&As('TAMANHO')
    .Column('C.ID_PRODUTO_COR').&As('ID_COR').Column('C.NOME').&As('COR')
    .Column('CB.CODIGO_BARRAS').&As('CODIGO_BARRAS')
    .Column('ESTOQUE.PRECO_CUSTO').&As('PRECO_CUSTO')
    .Column('ISNULL(PRODUTO_TABELA.PRECO,0)').&As('PRECO_VENDA')
    .Column('ISNULL(ROUND((IIF(ESTOQUE.QTD_DISPONIVEL > 0, ' +
    'ESTOQUE.QTD_DISPONIVEL, 0) * ISNULL(PARAMETROS.REPASSE_ESTOQUE_LOJA_VIRTUAL / 100,0)),0),0)')
    .&As('ESTOQUE').From('SKU').LeftJoin('PRODUTO').&As('P')
    .On('SKU.ID_PRODUTO = P.ID_PRODUTO').LeftJoin('PRODUTO_COR').&As('C')
    .On('SKU.ID_PRODUTO_COR = C.ID_PRODUTO_COR').LeftJoin('PRODUTO_TAMANHO')
    .&As('T').On('SKU.ID_PRODUTO_TAMANHO = T.ID_PRODUTO_TAMANHO')
    .LeftJoin('ESTOQUE').On('SKU.ID_SKU = ESTOQUE.ID_SKU')
    .LeftJoin('PRODUTO_TABELA_PRECO')
    .On('SKU.ID_PRODUTO = PRODUTO_TABELA_PRECO.ID_PRODUTO')
    .LeftJoin('PARAMETROS')
    .On('ESTOQUE.ID_EMPRESA = PARAMETROS.ID_EMPRESA_LOJA_VIRTUAL')
    .LeftJoin('PRODUTO_GRUPO').&As('G')
    .On('P.ID_PRODUTO_GRUPO = G.ID_PRODUTO_GRUPO').LeftJoin('PRODUTO_SUB_GRUPO')
    .&As('SG').On('P.ID_PRODUTO_SUB_GRUPO = SG.ID_PRODUTO_SUB_GRUPO')
    .LeftJoin('SKU_CODIGO_BARRAS').&As('CB').On('SKU.ID_SKU = CB.ID_SKU')
    .LeftJoin('(SELECT * FROM PRODUTO_TABELA_PRECO PTB WHERE ' +
    'PTB.ID_PRODUTO_TABELA IN (SELECT PARAMETROS.ID_PRODUTO_TABELA_LOJA_VIRTUAL '
    + 'FROM PARAMETROS WHERE PARAMETROS.ID_EMPRESA_LOJA_VIRTUAL = ' +
    id_empresa.ToString + '))').&As('PRODUTO_TABELA')
    .On('PRODUTO_TABELA.ID_PRODUTO = P.ID_PRODUTO').LeftJoin('PRODUTO_MARCA')
    .&As('M').On('P.ID_PRODUTO_MARCA = M.ID_PRODUTO_MARCA')
    .Where('P.LOJA_VIRTUAL = 1 AND ESTOQUE.ID_EMPRESA = ' + id_empresa.ToString
    + ' AND ' + '(CONVERT(datetime2, ESTOQUE.DT_ALT, 120) >= ' +
    QuotedStr(dtFormatada) + ' OR ' +
    'CONVERT(datetime2, PRODUTO_TABELA.DT_ALT, 120) >= ' +
    QuotedStr(dtFormatada) + ')')
    .GroupBy('ESTOQUE.ID_EMPRESA, SKU.ID_SKU, SKU.ID_PRODUTO, ' +
    'P.REFID, CODIGO_FABRICANTE, P.NOME, G.NOME, SG.NOME, M.NOME, ' +
    'T.ID_PRODUTO_TAMANHO, T.SIGLA, C.ID_PRODUTO_COR, C.NOME, ' +
    'CODIGO_BARRAS, ESTOQUE.PRECO_CUSTO, PRODUTO_TABELA.PRECO, ' +
    'QTD_DISPONIVEL, PARAMETROS.REPASSE_ESTOQUE_LOJA_VIRTUAL').AsString;

  LResultSet := TCriteria.New.SetConnection(FConnectionORM).SQL(LSQL)
    .AsResultSet;

  if aList.Active then
    aList.EmptyDataSet;

  if LResultSet.RecordCount > 0 then
    aList.CloneCursor(TFDDataSet(LResultSet.DataSet));
end;

end.
