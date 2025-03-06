unit model.service.contato_email.interfaces;

interface

uses
  System.Generics.Collections,
  model.CONTATO_EMAIL;

type
  IServiceCONTATO_EMAIL = interface
    ['{B340AC6B-6199-4759-9AAB-B8BD61365A00}']

    function Save(contato_email: TObjectList<TCONTATO_EMAIL>; var msg: String): Boolean;
  end;

implementation

end.
