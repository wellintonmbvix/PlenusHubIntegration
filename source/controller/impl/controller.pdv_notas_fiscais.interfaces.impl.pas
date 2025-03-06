unit controller.pdv_notas_fiscais.interfaces.impl;

interface

uses
  controller.pdv_notas_fiscais.interfaces,

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
  TIPDV_NOTAS_FISCAIS = class(TInterfacedObject, IPDV_NOTAS_FISCAIS)
    private
      FServiceScripts: IServiceScripts;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IPDV_NOTAS_FISCAIS;

      function Manufactory: IServiceScripts;
  end;

implementation

{ TIPDV_NOTAS_FISCAIS }

constructor TIPDV_NOTAS_FISCAIS.Create;
begin
  FServiceScripts := TServiceScripts.New;
end;

destructor TIPDV_NOTAS_FISCAIS.Destroy;
begin
  inherited;
end;

function TIPDV_NOTAS_FISCAIS.Manufactory: IServiceScripts;
begin
  Result := FServiceScripts;
end;

class function TIPDV_NOTAS_FISCAIS.New: IPDV_NOTAS_FISCAIS;
begin
  Result := Self.Create;
end;

end.
