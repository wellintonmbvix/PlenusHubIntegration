unit model.pessoa_juridica;

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
  [Table('PESSOA_JURIDICA', '')]
  [PrimaryKey('ID_PESSOA_JURIDICA', TAutoIncType.AutoInc,
                                    TGeneratorType.NoneInc,
                                    TSortingOrder.NoSort,
                                    True, 'Chave primária')]
  [OrderBy('ID_PESSOA_JURIDICA')]
  TPESSOA_JURIDICA = class
  private
    { Private declarations } 
    FID_PESSOA_JURIDICA: nullable<Integer>;
    FID_PESSOA: Integer;
    FCNPJ: Nullable<String>;
    FRAZAO_SOCIAL: String;
    FFANTASIA: String;
    FINSCRICAO_MUNICIPAL: String;
    FINSCRICAO_ESTADUAL: String;
    FDATA_CONSTITUICAO: Nullable<TDateTime>;
    FID_REGIME_TRIBUTARIO: Nullable<Integer>;
    FVLR_IMOVEL: Nullable<Double>;
    FCAPITAL_REG: Nullable<Double>;
    FCAPITAL_GIRO: Nullable<Double>;
    FINSCRICAO_JUNTA_COMERCIAL: Nullable<String>;
    FDATA_INSC_JUNTA_COMERCIAL: Nullable<TDateTime>;
    FVLR_ESTOQUE: Nullable<Double>;
    FRAZAO_SOCIAL_ANT: Nullable<String>;
    FDT_INC: TDateTime;
    FDT_ALT: TDateTime;
    FDT_HAB: Nullable<TDateTime>;

  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;
    [Column('ID_PESSOA_JURIDICA', ftInteger)]
    [Dictionary('ID_PESSOA_JURIDICA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa_juridica: nullable<Integer> read FID_PESSOA_JURIDICA write FID_PESSOA_JURIDICA;

    [Restrictions([NotNull])]
    [Column('ID_PESSOA', ftInteger)]
    [ForeignKey('FK__PESSOA_JURIDICA__PESSOA', 'ID_PESSOA', 'PESSOA', 'ID_PESSOA',
      Cascade, Cascade)]
    [Dictionary('ID_PESSOA', 'Mensagem de validação', '', '', '', taCenter)]
    property id_pessoa: Integer read FID_PESSOA write FID_PESSOA;

    [Column('CNPJ', ftString, 18)]
    [Dictionary('CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property cnpj: Nullable<String> read FCNPJ write FCNPJ;

    [Restrictions([NotNull])]
    [Column('RAZAO_SOCIAL', ftString, 100)]
    [Dictionary('RAZAO_SOCIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property razao_social: String read FRAZAO_SOCIAL write FRAZAO_SOCIAL;

    [Restrictions([NotNull])]
    [Column('FANTASIA', ftString, 100)]
    [Dictionary('FANTASIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property fantasia: String read FFANTASIA write FFANTASIA;

    [Restrictions([NotNull])]
    [Column('INSCRICAO_MUNICIPAL', ftString, 30)]
    [Dictionary('INSCRICAO_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property inscricao_municipal: String read FINSCRICAO_MUNICIPAL write FINSCRICAO_MUNICIPAL;

    [Restrictions([NotNull])]
    [Column('INSCRICAO_ESTADUAL', ftString, 30)]
    [Dictionary('INSCRICAO_ESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property inscricao_estadual: String read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;

    [Column('DATA_CONSTITUICAO', ftDateTime)]
    [Dictionary('DATA_CONSTITUICAO', 'Mensagem de validação', '', '', '', taCenter)]
    property data_constituicao: Nullable<TDateTime> read FDATA_CONSTITUICAO write FDATA_CONSTITUICAO;

    [Column('ID_REGIME_TRIBUTARIO', ftInteger)]
    [Dictionary('ID_REGIME_TRIBUTARIO', 'Mensagem de validação', '', '', '', taCenter)]
    property id_regime_tributario: Nullable<Integer> read FID_REGIME_TRIBUTARIO write FID_REGIME_TRIBUTARIO;


    [Column('VLR_IMOVEL', ftBCD)]
    [Dictionary('VLR_IMOVEL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property vlr_imovel: Nullable<Double> read FVLR_IMOVEL write FVLR_IMOVEL;

    [Column('CAPITAL_REG', ftBCD, 93, 6)]
    [Dictionary('CAPITAL_REG', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property capital_reg: Nullable<Double> read FCAPITAL_REG write FCAPITAL_REG;

    [Column('CAPITAL_GIRO', ftBCD, 93, 6)]
    [Dictionary('CAPITAL_GIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property capital_giro: Nullable<Double> read FCAPITAL_GIRO write FCAPITAL_GIRO;

    [Column('INSCRICAO_JUNTA_COMERCIAL', ftString, 50)]
    [Dictionary('INSCRICAO_JUNTA_COMERCIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property inscricao_junta_comercial: Nullable<String> read FINSCRICAO_JUNTA_COMERCIAL write FINSCRICAO_JUNTA_COMERCIAL;

    [Column('DATA_INSC_JUNTA_COMERCIAL', ftDateTime)]
    [Dictionary('DATA_INSC_JUNTA_COMERCIAL', 'Mensagem de validação', '', '', '', taCenter)]
    property data_insc_junta_comercial: Nullable<TDateTime> read FDATA_INSC_JUNTA_COMERCIAL write FDATA_INSC_JUNTA_COMERCIAL;

    [Column('VLR_ESTOQUE', ftBCD, 93, 6)]
    [Dictionary('VLR_ESTOQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property vlr_estoque: Nullable<Double> read FVLR_ESTOQUE write FVLR_ESTOQUE;

    [Column('RAZAO_SOCIAL_ANT', ftString, 100)]
    [Dictionary('RAZAO_SOCIAL_ANT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property razao_social_ant: Nullable<String> read FRAZAO_SOCIAL_ANT write FRAZAO_SOCIAL_ANT;

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

constructor TPESSOA_JURIDICA.Create;
begin

end;

destructor TPESSOA_JURIDICA.Destroy;
begin
  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TPESSOA_JURIDICA)

end.
