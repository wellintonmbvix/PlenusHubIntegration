unit controller.pdv_notas_fiscais.interfaces;

interface

uses
  model.service.interfaces,
  model.service.scripts.interfaces;

type
  IPDV_NOTAS_FISCAIS = interface
    ['{8B610F52-8B89-4D06-91A2-6A678824BC9A}']

    function Manufactory: IServiceScripts;
  end;

implementation

end.
