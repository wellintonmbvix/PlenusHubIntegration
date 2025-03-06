unit model.contato_telefone;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

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
  [Table('CONTATO_TELEFONE', '')]
  [PrimaryKey('ID_CONTATO_TELEFONE', TAutoIncType.NotInc,
                                     TGeneratorType.TableInc,
                                     TSortingOrder.NoSort,
                                     True, 'Chave primária')]
  [OrderBy('ID_CONTATO_TELEFONE')]
  TCONTATO_TELEFONE = class
  private
    { Private declarations } 
    FID_CONTATO_TELEFONE: nullable<Integer>;
    FID_TIPO_TELEFONE: Integer;
    FID_CONTATO: Integer;
    FTELEFONE: String;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Column('ID_CONTATO_TELEFONE', ftInteger)]
    [Dictionary('ID_CONTATO_TELEFONE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_contato_telefone: nullable<Integer> read FID_CONTATO_TELEFONE write FID_CONTATO_TELEFONE;

    [Restrictions([NotNull])]
    [Column('ID_TIPO_TELEFONE', ftInteger)]
    [Dictionary('ID_TIPO_TELEFONE', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_telefone: Integer read FID_TIPO_TELEFONE write FID_TIPO_TELEFONE;

    [Restrictions([NotNull])]
    [Column('ID_CONTATO', ftInteger)]
    [ForeignKey('FK__CONTATO_TELEFONE__CONTATO', 'ID_CONTATO', 'CONTATO', 'ID_CONTATO',
      Cascade, Cascade)]
    [Dictionary('ID_CONTATO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_contato: Integer read FID_CONTATO write FID_CONTATO;

    [Restrictions([NotNull])]
    [Column('TELEFONE', ftString, 20)]
    [Dictionary('TELEFONE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property telefone: String read FTELEFONE write FTELEFONE;

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

  end;

implementation

constructor TCONTATO_TELEFONE.Create;
begin
  //
end;

destructor TCONTATO_TELEFONE.Destroy;
begin
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TCONTATO_TELEFONE)

end.
