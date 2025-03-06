unit controller.pedido_venda.interfaces.impl;

interface

uses
  controller.pedido_venda.interfaces,

  ormbr.types.blob,
  ormbr.objects.helper,
  dbcbr.mapping.explorer,
  ormbr.json,
  ormbr.rtti.helper,

  model.service.interfaces.impl,
  model.service.interfaces,
  model.service.scripts.interfaces.impl,
  model.service.scripts.interfaces;

type
  TIPEDIDO_VENDA = class(TInterfacedObject, IPEDIDO_VENDA)
    private
    FServiceScripts: IServiceScripts;
    public
    constructor Create;
    destructor Destroy; override;
    class function New: IPEDIDO_VENDA;

    function Manufactory: IServiceScripts;
  end;

implementation

{ TIPEDIDO_VENDA }

constructor TIPEDIDO_VENDA.Create;
begin
  FServiceScripts := TServiceScripts.New;
end;

destructor TIPEDIDO_VENDA.Destroy;
begin
  inherited;
end;

function TIPEDIDO_VENDA.Manufactory: IServiceScripts;
begin
  Result := FServiceScripts;
end;

class function TIPEDIDO_VENDA.New: IPEDIDO_VENDA;
begin
  Result := Self.Create;
end;

end.
