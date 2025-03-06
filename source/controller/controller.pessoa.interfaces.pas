unit controller.pessoa.interfaces;

interface

uses
  System.Generics.Collections,

  model.PESSOA,
  model.PESSOA_FISICA,
  model.PESSOA_JURIDICA,
  model.CLIENTE,
  model.CONTATO,
  model.ENDERECO,

  //** ORMBr
  ormbr.types.blob,
  model.service.interfaces,
  model.service.scripts.interfaces;

type
  IPESSOA = interface
    ['{BCF6032F-F41C-4E30-8211-B980C3D9C601}']

    function id_pessoa(value: Integer): IPESSOA; overload;
    function id_pessoa: Integer; overload;

    function nome(value: String): IPESSOA; overload;
    function nome: String; overload;

    function abreviado(value: String): IPESSOA; overload;
    function abreviado: String; overload;

    function tipo(value: String): IPESSOA; overload;
    function tipo: String; overload;

    function site(value: String): IPESSOA; overload;
    function site: String; overload;

    function suframa(value: String): IPESSOA; overload;
    function suframa: String; overload;

    function dt_inc(value: TDateTime): IPESSOA; overload;
    function dt_inc: TDateTime; overload;

    function dt_alt(value: TDateTime): IPESSOA; overload;
    function dt_alt: TDateTime; overload;

    function dt_hab(value: TDateTime): IPESSOA; overload;
    function dt_hab: TDateTime; overload;

    function cliente(value: TCLIENTE): IPESSOA; overload;
    function cliente: TCLIENTE; overload;

    function pessoa_fisica(value: TPESSOA_FISICA): IPESSOA; overload;
    function pessoa_fisica: TPESSOA_FISICA; overload;

    function pessoa_juridica(value: TPESSOA_JURIDICA): IPESSOA; overload;
    function pessoa_juridica: TPESSOA_JURIDICA; overload;

    function contato(value: TObjectList<TCONTATO>): IPESSOA; overload;
    function contato: TObjectList<TCONTATO>; overload;

    function pessoa_guid(value: TGUID): IPESSOA; overload;
    function pessoa_guid: TGUID; overload;

    function endereco(value: TENDERECO): IPESSOA; overload;
    function endereco: TENDERECO; overload;

    function Build: IService<TPESSOA>;
    function Manufacture: IServiceScripts;
  end;

implementation

end.
