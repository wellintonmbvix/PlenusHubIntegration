unit model.contato;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,

  model.CONTATO_TELEFONE,
  model.CONTATO_EMAIL,

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
  [Table('CONTATO', '')]
  [PrimaryKey('CONTATO_GUID', TAutoIncType.NotInc,
                             TGeneratorType.Guid32Inc,
                             TSortingOrder.Ascending,
                             True, 'Chave primária')]
  [OrderBy('CONTATO_GUID')]
  TCONTATO = class
  private
    { Private declarations }
    FID_CONTATO: nullable<Integer>;
    FID_PESSOA: Integer;
    FNOME: String;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;
    FCONTATO_TELEFONE: TObjectList<TCONTATO_TELEFONE>;
    FCONTATO_EMAIL: TObjectList<TCONTATO_EMAIL>;
    FCONTATO_GUID: nullable<TGUID>;
    FID_PESSOA_GUID: TGUID;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

    [Column('ID_CONTATO', ftInteger)]
    [Dictionary('ID_CONTATO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_contato: nullable<Integer> read FID_CONTATO write FID_CONTATO;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA', ftInteger)]
    [ForeignKey('FK__CONTATO__PESSOA', 'ID_PESSOA', 'PESSOA', 'ID_PESSOA',
      Cascade, Cascade)]
    [Dictionary('ID_PESSOA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa: Integer read FID_PESSOA write FID_PESSOA;

    [Restrictions([NotNull])]
    [Column('NOME', ftString, 100)]
    [Dictionary('NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nome: String read FNOME write FNOME;

    [Restrictions([NotNull])]
    [Column('DT_INC', ftDateTime)]
    [Dictionary('DT_INC', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property dt_inc: TDateTime read FDT_INC write FDT_INC;

    [Restrictions([NotNull])]
    [Column('DT_ALT', ftDateTime)]
    [Dictionary('DT_ALT', 'Mensagem de validação', 'Now', '', '!##/##/####;1;_', taCenter)]
    property dt_alt: TDateTime read FDT_ALT write FDT_ALT;

    [Column('DT_HAB', ftDateTime)]
    [Dictionary('DT_HAB', 'Mensagem de validação', '', '', '', taCenter)]
    property dt_hab: Nullable<TDateTime> read FDT_HAB write FDT_HAB;

    [Column('CONTATO_GUID', ftGuid)]
    [Dictionary('CONTATO_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property contato_guid: nullable<TGUID> read FCONTATO_GUID write FCONTATO_GUID;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA_GUID', ftGuid)]
    [ForeignKey('FK__CONTATO__ID_PESS__165CC070', 'ID_PESSOA_GUID', 'PESSOA', 'PESSOA_GUID',
      Cascade, Cascade)]
    [Dictionary('ID_PESSOA_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property id_pessoa_guid: TGUID read FID_PESSOA_GUID write FID_PESSOA_GUID;

    [Association(TMultiplicity.OneToMany, 'ID_CONTATO', 'CONTATO_TELEFONE', 'ID_CONTATO')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property CONTATO_TELEFONE: TObjectList<TCONTATO_TELEFONE> read FCONTATO_TELEFONE write FCONTATO_TELEFONE;

    [Association(TMultiplicity.OneToMany, 'ID_CONTATO', 'CONTATO_EMAIL', 'ID_CONTATO')]
    [CascadeActions([TCascadeAction.CascadeAutoInc,
                     TCascadeAction.CascadeInsert,
                     TCascadeAction.CascadeUpdate,
                     TCascadeAction.CascadeDelete])]
    property CONTATO_EMAIL: TObjectList<TCONTATO_EMAIL> read FCONTATO_EMAIL write FCONTATO_EMAIL;
  end;

implementation

constructor TCONTATO.Create;
begin
  FCONTATO_TELEFONE := TObjectList<TCONTATO_TELEFONE>.Create;
  FCONTATO_EMAIL := TObjectList<TCONTATO_EMAIL>.Create;
end;

destructor TCONTATO.Destroy;
begin
  FreeAndNil(FCONTATO_TELEFONE);
  FreeAndNil(FCONTATO_EMAIL);
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TCONTATO)

end.
