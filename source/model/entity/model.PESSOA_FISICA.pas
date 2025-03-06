unit model.pessoa_fisica;

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
  [Table('PESSOA_FISICA', '')]
  [PrimaryKey('PESSOA_FISICA_GUID', TAutoIncType.NotInc,
                                  TGeneratorType.Guid32Inc,
                                  TSortingOrder.NoSort,
                                  True, 'Chave primária')]
  [OrderBy('PESSOA_FISICA_GUID')]
  TPESSOA_FISICA = class
  private
    { Private declarations } 
    FID_PESSOA_FISICA: nullable<Integer>;
    FID_PESSOA: Integer;
    FID_ESTADO_CIVIL: Nullable<Integer>;
    FNOME: String;
    FCPF: Nullable<String>;
    FRG: Nullable<String>;
    FORGAO_RG: Nullable<String>;
    FDATA_EMISSAO_RG: Nullable<TDateTime>;
    FDATA_NASCIMENTO: Nullable<TDateTime>;
    FSEXO: Nullable<String>;
    FNAT_CIDADE: Nullable<String>;
    FNAT_UF: Nullable<String>;
    FNACIONALIDADE: Nullable<String>;
    FRACA: Nullable<String>;
    FTIPO_SANGUE: Nullable<String>;
    FCNH_NUMERO: Nullable<String>;
    FCNH_CATEGORIA: Nullable<String>;
    FCNH_VENCIMENTO: Nullable<TDateTime>;
    FTITULO_ELEITORAL_NUMERO: Nullable<String>;
    FTITULO_ELEITORAL_ZONA: Nullable<String>;
    FTITULO_ELEITORAL_SECAO: Nullable<String>;
    FRESERVISTA_NUMERO: Nullable<String>;
    FRESERVISTA_CATEGORIA: Nullable<String>;
    FINSCRICAO_MUNICIPAL: String;
    FINSCRICAO_ESTADUAL: String;
    FFILIACAO_PAI: Nullable<String>;
    FFILIACAO_MAE: Nullable<String>;
    FNUM_DEPENDENTES: Integer;
    FTEMPO_RESIDENCIA: Integer;
    FFOTO: nullable<TBlob>;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;
    FPESSOA_FISICA_GUID: nullable<TGUID>;
    FID_PESSOA_GUID: TGUID;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

    [Column('ID_PESSOA_FISICA', ftInteger)]
    [Dictionary('ID_PESSOA_FISICA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa_fisica: nullable<Integer> read FID_PESSOA_FISICA write FID_PESSOA_FISICA;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA', ftInteger)]
    [Dictionary('ID_PESSOA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa: Integer read FID_PESSOA write FID_PESSOA;

    [Column('ID_ESTADO_CIVIL', ftInteger)]
    [Dictionary('ID_ESTADO_CIVIL', 'Mensagem de validação', '', '', '', taCenter)]
    property id_estado_civil: Nullable<Integer> read FID_ESTADO_CIVIL write FID_ESTADO_CIVIL;

    [Restrictions([NotNull])]
    [Column('NOME', ftString, 100)]
    [Dictionary('NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nome: String read FNOME write FNOME;

    [Column('CPF', ftString, 14)]
    [Dictionary('CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cpf: Nullable<String> read FCPF write FCPF;

    [Column('RG', ftString, 30)]
    [Dictionary('RG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property rg: Nullable<String> read FRG write FRG;

    [Column('ORGAO_RG', ftString, 15)]
    [Dictionary('ORGAO_RG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property orgao_rg: Nullable<String> read FORGAO_RG write FORGAO_RG;

    [Column('DATA_EMISSAO_RG', ftDateTime)]
    [Dictionary('DATA_EMISSAO_RG', 'Mensagem de validação', '', '', '', taCenter)]
    property data_emissao_rg: Nullable<TDateTime> read FDATA_EMISSAO_RG write FDATA_EMISSAO_RG;

    [Column('DATA_NASCIMENTO', ftDateTime)]
    [Dictionary('DATA_NASCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property data_nascimento: Nullable<TDateTime> read FDATA_NASCIMENTO write FDATA_NASCIMENTO;

    [Column('SEXO', ftString, 1)]
    [Dictionary('SEXO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property sexo: Nullable<String> read FSEXO write FSEXO;

    [Column('NAT_CIDADE', ftString, 100)]
    [Dictionary('NAT_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nat_cidade: Nullable<String> read FNAT_CIDADE write FNAT_CIDADE;

    [Column('NAT_UF', ftString, 2)]
    [Dictionary('NAT_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nat_uf: Nullable<String> read FNAT_UF write FNAT_UF;

    [Column('NACIONALIDADE', ftString, 100)]
    [Dictionary('NACIONALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property nacionalidade: Nullable<String> read FNACIONALIDADE write FNACIONALIDADE;

    [Column('RACA', ftString, 1)]
    [Dictionary('RACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property raca: Nullable<String> read FRACA write FRACA;

    [Column('TIPO_SANGUE', ftString, 3)]
    [Dictionary('TIPO_SANGUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property tipo_sangue: Nullable<String> read FTIPO_SANGUE write FTIPO_SANGUE;

    [Column('CNH_NUMERO', ftString, 30)]
    [Dictionary('CNH_NUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cnh_numero: Nullable<String> read FCNH_NUMERO write FCNH_NUMERO;

    [Column('CNH_CATEGORIA', ftString, 5)]
    [Dictionary('CNH_CATEGORIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cnh_categoria: Nullable<String> read FCNH_CATEGORIA write FCNH_CATEGORIA;

    [Column('CNH_VENCIMENTO', ftDateTime)]
    [Dictionary('CNH_VENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property cnh_vencimento: Nullable<TDateTime> read FCNH_VENCIMENTO write FCNH_VENCIMENTO;

    [Column('TITULO_ELEITORAL_NUMERO', ftString, 30)]
    [Dictionary('TITULO_ELEITORAL_NUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property titulo_eleitoral_numero: Nullable<String> read FTITULO_ELEITORAL_NUMERO write FTITULO_ELEITORAL_NUMERO;

    [Column('TITULO_ELEITORAL_ZONA', ftString, 5)]
    [Dictionary('TITULO_ELEITORAL_ZONA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property titulo_eleitoral_zona: Nullable<String> read FTITULO_ELEITORAL_ZONA write FTITULO_ELEITORAL_ZONA;

    [Column('TITULO_ELEITORAL_SECAO', ftString, 5)]
    [Dictionary('TITULO_ELEITORAL_SECAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property titulo_eleitoral_secao: Nullable<String> read FTITULO_ELEITORAL_SECAO write FTITULO_ELEITORAL_SECAO;

    [Column('RESERVISTA_NUMERO', ftString, 30)]
    [Dictionary('RESERVISTA_NUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property reservista_numero: Nullable<String> read FRESERVISTA_NUMERO write FRESERVISTA_NUMERO;

    [Column('RESERVISTA_CATEGORIA', ftString, 5)]
    [Dictionary('RESERVISTA_CATEGORIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property reservista_categoria: Nullable<String> read FRESERVISTA_CATEGORIA write FRESERVISTA_CATEGORIA;

    [Restrictions([NotNull])]
    [Column('INSCRICAO_MUNICIPAL', ftString, 30)]
    [Dictionary('INSCRICAO_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property inscricao_municipal: String read FINSCRICAO_MUNICIPAL write FINSCRICAO_MUNICIPAL;

    [Restrictions([NotNull])]
    [Column('INSCRICAO_ESTADUAL', ftString, 30)]
    [Dictionary('INSCRICAO_ESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property inscricao_estadual: String read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;

    [Column('FILIACAO_PAI', ftString, 100)]
    [Dictionary('FILIACAO_PAI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property filiacao_pai: Nullable<String> read FFILIACAO_PAI write FFILIACAO_PAI;

    [Column('FILIACAO_MAE', ftString, 100)]
    [Dictionary('FILIACAO_MAE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property filiacao_mae: Nullable<String> read FFILIACAO_MAE write FFILIACAO_MAE;

    [Restrictions([NotNull])]
    [Column('NUM_DEPENDENTES', ftInteger)]
    [Dictionary('NUM_DEPENDENTES', 'Mensagem de validação', '', '', '', taCenter)]
    property num_dependentes: Integer read FNUM_DEPENDENTES write FNUM_DEPENDENTES;

    [Restrictions([NotNull])]
    [Column('TEMPO_RESIDENCIA', ftInteger)]
    [Dictionary('TEMPO_RESIDENCIA', 'Mensagem de validação', '', '', '', taCenter)]
    property tempo_residencia: Integer read FTEMPO_RESIDENCIA write FTEMPO_RESIDENCIA;

    [Column('FOTO', ftBlob)]
    [Dictionary('FOTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property foto: nullable<TBlob> read FFOTO write FFOTO;

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

    [Column('PESSOA_FISICA_GUID', ftGuid)]
    [Dictionary('PESSOA_FISICA_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property pessoa_fisica_guid: nullable<TGUID> read FPESSOA_FISICA_GUID write FPESSOA_FISICA_GUID;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA_GUID', ftGuid)]
    [ForeignKey('FK__PESSOA_FI__ID_PE__4A316A31', 'ID_PESSOA_GUID', 'PESSOA', 'PESSOA_GUID',
      Cascade, Cascade)]
    [Dictionary('ID_PESSOA_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property id_pessoa_guid: TGUID read FID_PESSOA_GUID write FID_PESSOA_GUID;
  end;

implementation

constructor TPESSOA_FISICA.Create;
begin
  //
end;

destructor TPESSOA_FISICA.Destroy;
begin
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TPESSOA_FISICA)

end.
