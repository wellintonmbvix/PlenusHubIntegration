unit controller.estoque.interfaces.impl;

interface

uses
  controller.estoque.interfaces,

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
  TIEstoque = class(TInterfacedObject, IEstoque)
    private
      FServiceScripts: IServiceScripts;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IEstoque;

      function Manufacture: IServiceScripts;
  end;

implementation

{ TIProduto }

constructor TIEstoque.Create;
begin
  FServiceScripts := TServiceScripts.New;
end;

destructor TIEstoque.Destroy;
begin
  inherited;
end;

function TIEstoque.Manufacture: IServiceScripts;
begin
  Result := FServiceScripts;
end;

class function TIEstoque.New: IEstoque;
begin
  Result := Self.Create;
end;

end.
