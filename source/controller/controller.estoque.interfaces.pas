unit controller.estoque.interfaces;

interface

uses
  DBClient,

  model.service.interfaces,
  model.service.scripts.interfaces;

type
  IEstoque = interface
    ['{74B991EF-B491-461A-B138-88E8179F2532}']

    function Manufacture: IServiceScripts;
  end;

implementation

end.
