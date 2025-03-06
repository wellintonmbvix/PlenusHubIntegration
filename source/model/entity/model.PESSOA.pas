unit model.pessoa;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,

  model.CLIENTE,
  model.PESSOA_FISICA,
  model.PESSOA_JURIDICA,
  model.CONTATO,
  model.ENDERECO,

  // ormbr
  ormbr.types.blob,
  ormbr.types.lazy,
  ormbr.objects.helper,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes;

type

  [Entity]
  [Table('PESSOA', '')]
  [PrimaryKey('PESSOA_GUID', TAutoIncType.NotInc,
                           TGeneratorType.Guid32Inc,
                           TSortingOrder.Ascending,
                           True, 'Chave primária')]
  [OrderBy('PESSOA_GUID')]
  TPESSOA = class
  private
    { Private declarations }
    FID_PESSOA: nullable<Integer>;
    FNOME: String;
    FABREVIADO: String;
    FTIPO: String;
    FSITE: nullable<String>;
    FSUFRAMA: nullable<String>;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: nullable<TDateTime>;
    FPESSOA_GUID: TGUID;

    FCLIENTE: TCLIENTE;
    FPESSOA_FISICA: TPESSOA_FISICA;
    FPESSOA_JURIDICA: TPESSOA_JURIDICA;
    FCONTATO: TObjectList<TCONTATO>;
    FENDERECO: TENDERECO;
  public
    constructor Create;
    destructor Destroy; override;

    { Public declarations }
    [Column('ID_PESSOA', ftInteger)]
    [Dictionary('ID_PESSOA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa: nullable<Integer> read FID_PESSOA write FID_PESSOA;

    [Restrictions([NotNull])]
    [Column('NOME', ftString, 100)]
    [Dictionary('NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nome: String read FNOME write FNOME;

    [Restrictions([NotNull])]
    [Column('ABREVIADO', ftString, 15)]
    [Dictionary('ABREVIADO', 'Mensagem de validação', '', '', '',
      taLeftJustify)]
    property abreviado: String read FABREVIADO write FABREVIADO;

    [Restrictions([NotNull])]
    [Column('TIPO', ftString, 1)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tipo: String read FTIPO write FTIPO;

    [Column('SITE', ftString, 255)]
    [Dictionary('SITE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property site: nullable<String> read FSITE write FSITE;

    [Column('SUFRAMA', ftString, 15)]
    [Dictionary('SUFRAMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property suframa: nullable<String> read FSUFRAMA write FSUFRAMA;

    [Restrictions([NotNull])]
    [Column('DT_INC', ftDateTime)]
    [Dictionary('DT_INC', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_',
      taCenter)]
    property dt_inc: TDateTime read FDT_INC write FDT_INC;

    [Restrictions([NotNull])]
    [Column('DT_ALT', ftDateTime)]
    [Dictionary('DT_ALT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_',
      taCenter)]
    property dt_alt: TDateTime read FDT_ALT write FDT_ALT;

    [Column('DT_HAB', ftDateTime)]
    [Dictionary('DT_HAB', 'Mensagem de validação', '', '', '', taCenter)]
    property dt_hab: nullable<TDateTime> read FDT_HAB write FDT_HAB;

    [Column('PESSOA_GUID', ftGuid)]
    [Dictionary('PESSOA_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property pessoa_guid: TGUID read FPESSOA_GUID write FPESSOA_GUID;

    [Association(TMultiplicity.OneToOne, 'ID_PESSOA', 'PESSOA_FISICA', 'ID_PESSOA')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property PESSOA_FISICA: TPESSOA_FISICA read FPESSOA_FISICA write FPESSOA_FISICA;

    [Association(TMultiplicity.OneToOne, 'ID_PESSOA', 'PESSOA_JURIDICA', 'ID_PESSOA')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property PESSOA_JURIDICA: TPESSOA_JURIDICA read FPESSOA_JURIDICA write FPESSOA_JURIDICA;

    [Association(TMultiplicity.OneToOne, 'ID_PESSOA', 'CLIENTE', 'ID_PESSOA')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property CLIENTE: TCLIENTE read FCLIENTE write FCLIENTE;

    [Association(TMultiplicity.OneToMany, 'ID_PESSOA', 'CONTATO', 'ID_PESSOA')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property CONTATO: TObjectList<TCONTATO> read FCONTATO write FCONTATO;

    [Association(TMultiplicity.OneToOne, 'ID_PESSOA', 'ENDERECO', 'ID_PESSOA')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property ENDERECO: TENDERECO read FENDERECO write FENDERECO;
  end;

implementation

{ TPESSOA }

constructor TPESSOA.Create;
begin
  FPESSOA_FISICA := TPESSOA_FISICA.Create;
  FPESSOA_JURIDICA := TPESSOA_JURIDICA.Create;
  FCLIENTE := TCLIENTE.Create;
  FCONTATO := TObjectList<TCONTATO>.Create;
  FENDERECO := TENDERECO.Create;
end;

destructor TPESSOA.Destroy;
begin
  FreeAndNil(FPESSOA_FISICA);
  FreeAndNil(FPESSOA_JURIDICA);
  FreeAndNil(FCLIENTE);
  FreeAndNil(FCONTATO);
  FreeAndNil(FENDERECO);
  inherited;
end;

initialization

TRegisterClass.RegisterEntity(TPESSOA)

end.
