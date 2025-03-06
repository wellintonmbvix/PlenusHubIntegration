unit model.contato_email;

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
  [Table('CONTATO_EMAIL', '')]
  [PrimaryKey('ID_CONTATO_EMAIL', TAutoIncType.NotInc,
                                  TGeneratorType.NoneInc,
                                  TSortingOrder.NoSort,
                                  True, 'Chave primária')]
  [OrderBy('ID_CONTATO_EMAIL')]
  TCONTATO_EMAIL = class
  private
    { Private declarations } 
    FID_CONTATO_EMAIL: nullable<Integer>;
    FID_CONTATO: Integer;
    FID_TIPO_EMAIL: Integer;
    FEMAIL: String;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;
    FEMAIL_MARKETING: Boolean;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    [Column('ID_CONTATO_EMAIL', ftInteger)]
    [Dictionary('ID_CONTATO_EMAIL', 'Mensagem de validação', '', '', '', taCenter)]
    property id_contato_email: nullable<Integer> read FID_CONTATO_EMAIL write FID_CONTATO_EMAIL;

    [Restrictions([NotNull])]
    [Column('ID_CONTATO', ftInteger)]
    [ForeignKey('FK__CONTATO_EMAIL__CONTATO', 'ID_CONTATO', 'CONTATO', 'ID_CONTATO',
      Cascade, Cascade)]
    [Dictionary('ID_CONTATO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_contato: Integer read FID_CONTATO write FID_CONTATO;

    [Restrictions([NotNull])]
    [Column('ID_TIPO_EMAIL', ftInteger)]
    [Dictionary('ID_TIPO_EMAIL', 'Mensagem de validação', '', '', '', taCenter)]
    property id_tipo_email: Integer read FID_TIPO_EMAIL write FID_TIPO_EMAIL;

    [Restrictions([NotNull])]
    [Column('EMAIL', ftString, 255)]
    [Dictionary('EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property email: String read FEMAIL write FEMAIL;

    [Restrictions([NotNull])]
    [Column('EMAIL_MARKETING', ftBoolean)]
    [Dictionary('EMAIL_MARKETING', 'Mensagem de validação', '', '', '', taCenter)]
    property email_marketing: Boolean read FEMAIL_MARKETING write FEMAIL_MARKETING;

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

constructor TCONTATO_EMAIL.Create;
begin
  //
end;

destructor TCONTATO_EMAIL.Destroy;
begin
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TCONTATO_EMAIL)

end.
