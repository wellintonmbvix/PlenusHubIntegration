unit model.service.scripts.interfaces;

interface

uses
  model.PESSOA,
  model.PARAMETROS,
  model.PDV_NOTAS_FISCAIS_CAB,
  model.PEDIDO_VENDA,
  DBClient,
  FireDAC.Comp.Client;

type
  IServiceScripts = interface
    ['{08F455CD-F8A7-447B-8899-B04D7AE84639}']

    function viewStockProducts(PARAMETROS: TPARAMETROS; dtData: TDate;
      var aList: TFDMemTable): IServiceScripts;
    function savePerson(PESSOA: TPESSOA; PARAMETROS: TPARAMETROS;
      nLoja: Integer; var msg: String): IServiceScripts;
    function ifCustomerExist(aCpfCnpj: String; var cliente: TFDMemTable): Boolean;
    function saveOrder(PDV_NOTAS_FISCAIS: TPDV_NOTAS_FISCAIS_CAB;
      var msg: String): Boolean; overload;
    function saveOrder(PEDIDO_VENDA: TPEDIDO_VENDA; var msg: String): Boolean; overload;
    function getLastOrderCode(id_empresa: Integer): Integer;
    function getLastCustomerCode: Integer;
    function viewSku(aFilter: String; var aTable: TFDMemTable): Boolean;
  end;

implementation

end.
