unit controller.empresa.interfaces.impl;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  model.EMPRESA,

  controller.empresa.interfaces,

  model.service.interfaces.impl,
  model.service.interfaces;

type
  TIEMPRESA = class(TInterfacedObject, IEMPRESA)
    private
      FEntity: TEMPRESA;
      FService: IService<TEMPRESA>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IEMPRESA;

      function Build: IService<TEMPRESA>;
  end;

implementation

{ TIEMPRESA }

function TIEMPRESA.Build: IService<TEMPRESA>;
begin
  Result := FService;
end;

constructor TIEMPRESA.Create;
begin
  FEntity := TEMPRESA.Create;
  FService := TServiceORMBr<TEMPRESA>.New(FEntity);
end;

destructor TIEMPRESA.Destroy;
begin
  FreeAndNil(FEntity);
  inherited;
end;

class function TIEMPRESA.New: IEMPRESA;
begin
  Result := Self.Create;
end;

end.
