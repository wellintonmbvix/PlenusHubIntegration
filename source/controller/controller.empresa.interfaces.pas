unit controller.empresa.interfaces;

interface

uses
  model.EMPRESA,
  model.service.interfaces,
  model.service.scripts.interfaces;

type
  IEMPRESA = interface
    ['{8781B1CB-6CCE-4231-B12D-5F8E978F59D8}']

    function Build: IService<TEMPRESA>;
  end;

implementation

end.
