unit controller.pedido_venda.interfaces;

interface

uses
  model.service.interfaces,
  model.service.scripts.interfaces;

type
  IPEDIDO_VENDA = interface
    ['{94494CF6-4084-4804-8150-56C45B2DC002}']

    function Manufactory: IServiceScripts;
  end;

implementation

end.
