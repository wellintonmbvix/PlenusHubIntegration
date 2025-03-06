unit model.endereco;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,

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
  [Table('ENDERECO', '')]
  [PrimaryKey('ENDERECO_GUID', TAutoIncType.NotInc,
                                  TGeneratorType.Guid32Inc,
                                  TSortingOrder.NoSort,
                                  True, 'Chave primária')]
  [OrderBy('ENDERECO_GUID')]
  TENDERECO = class
  private
    { Private declarations } 
    FID_ENDERECO: Nullable<Integer>;
    FID_PESSOA: Integer;
    FROTULO: String;
    FCEP: String;
    FLOGRADOURO: String;
    FNUMERO: Nullable<String>;
    FCOMPLEMENTO: Nullable<String>;
    FBAIRRO: String;
    FCIDADE: String;
    FMUNICIPIO_IBGE: Nullable<Integer>;
    FUF: String;
    FPAIS_IBGE: Nullable<Integer>;
    FFONE: String;
    FCELULAR: Nullable<String>;
    FPONTO_REFERENCIA: Nullable<String>;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;
    FPRINCIPAL: Boolean;
    FENTREGA: Boolean;
    FCOBRANCA: Boolean;
    FCORRESPONDENCIA: Boolean;
    FMARCA: Boolean;
    FBLOQUEADO: Boolean;
    FENDERECO_GUID: nullable<TGUID>;
    FID_PESSOA_GUID: TGUID;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

    [Column('ID_ENDERECO', ftInteger)]
    [Dictionary('ID_ENDERECO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_endereco: Nullable<Integer> read FID_ENDERECO write FID_ENDERECO;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA', ftInteger)]
    [Dictionary('ID_PESSOA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa: Integer read FID_PESSOA write FID_PESSOA;

    [Restrictions([NotNull])]
    [Column('ROTULO', ftString, 100)]
    [Dictionary('ROTULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property rotulo: String read FROTULO write FROTULO;

    [Restrictions([NotNull])]
    [Column('CEP', ftString, 9)]
    [Dictionary('CEP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cep: String read FCEP write FCEP;

    [Restrictions([NotNull])]
    [Column('LOGRADOURO', ftString, 150)]
    [Dictionary('LOGRADOURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property logradouro: String read FLOGRADOURO write FLOGRADOURO;

    [Column('NUMERO', ftString, 15)]
    [Dictionary('NUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property numero: Nullable<String> read FNUMERO write FNUMERO;

    [Column('COMPLEMENTO', ftString, 100)]
    [Dictionary('COMPLEMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property complemento: Nullable<String> read FCOMPLEMENTO write FCOMPLEMENTO;

    [Restrictions([NotNull])]
    [Column('BAIRRO', ftString, 100)]
    [Dictionary('BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property bairro: String read FBAIRRO write FBAIRRO;

    [Restrictions([NotNull])]
    [Column('CIDADE', ftString, 100)]
    [Dictionary('CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cidade: String read FCIDADE write FCIDADE;

    [Column('MUNICIPIO_IBGE', ftInteger)]
    [Dictionary('MUNICIPIO_IBGE', 'Mensagem de validação', '', '', '', taCenter)]
    property municipio_ibge: Nullable<Integer> read FMUNICIPIO_IBGE write FMUNICIPIO_IBGE;

    [Restrictions([NotNull])]
    [Column('UF', ftString, 2)]
    [Dictionary('UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property uf: String read FUF write FUF;

    [Column('PAIS_IBGE', ftInteger)]
    [Dictionary('PAIS_IBGE', 'Mensagem de validação', '', '', '', taCenter)]
    property pais_ibge: Nullable<Integer> read FPAIS_IBGE write FPAIS_IBGE;

    [Restrictions([NotNull])]
    [Column('FONE', ftString, 20)]
    [Dictionary('FONE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property fone: String read FFONE write FFONE;

    [Column('CELULAR', ftString, 20)]
    [Dictionary('CELULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property celular: Nullable<String> read FCELULAR write FCELULAR;

    [Column('PONTO_REFERENCIA', ftString, 8000)]
    [Dictionary('PONTO_REFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ponto_referencia: Nullable<String> read FPONTO_REFERENCIA write FPONTO_REFERENCIA;

    [Column('PRINCIPAL', ftBoolean)]
    [Dictionary('PRINCIPAL', 'Mensagem de validação', '', '', '',
      taCenter)]
    property principal: Boolean read FPRINCIPAL write FPRINCIPAL;

    [Column('ENTREGA', ftBoolean)]
    [Dictionary('ENTREGA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property entrega: Boolean read FENTREGA write FENTREGA;

    [Column('COBRANCA', ftBoolean)]
    [Dictionary('COBRANCA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property cobranca: Boolean read FCOBRANCA write FCOBRANCA;

    [Column('CORRESPONDENCIA', ftBoolean)]
    [Dictionary('CORRESPONDENCIA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property correspondencia: Boolean read FCORRESPONDENCIA write FCORRESPONDENCIA;

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

    [Column('MARCA', ftBoolean)]
    [Dictionary('MARCA', 'Mensagem de validação', '', '', '',
      taCenter)]
    property marca: Boolean read FMARCA write FMARCA;

    [Column('BLOQUEADO', ftBoolean)]
    [Dictionary('BLOQUEADO', 'Mensagem de validação', '', '', '',
      taCenter)]
    property bloqueado: Boolean read FBLOQUEADO write FBLOQUEADO;

    [Column('ENDERECO_GUID', ftGuid)]
    [Dictionary('ENDERECO_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property endereco_guid: nullable<TGUID> read FENDERECO_GUID write FENDERECO_GUID;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA_GUID', ftGuid)]
    [ForeignKey('FK__ENDERECO__ID_PES__10D8F144', 'ID_PESSOA_GUID', 'PESSOA', 'PESSOA_GUID',
      Cascade, Cascade)]
    [Dictionary('ID_PESSOA_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property id_pessoa_guid: TGUID read FID_PESSOA_GUID write FID_PESSOA_GUID;

  end;

implementation

constructor TENDERECO.Create;
begin
  //
end;

destructor TENDERECO.Destroy;
begin
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TENDERECO)

end.
