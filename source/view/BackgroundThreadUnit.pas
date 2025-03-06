unit BackgroundThreadUnit;

interface

uses
  System.Classes,
  System.IniFiles,
  System.Generics.Collections,
  System.StrUtils,
  System.NetEncoding,
  DataSnap.DBClient,
  Soap.EncdDecd,

  Winapi.Windows,

  Data.DB,

  routines,

  controller.parametros.interfaces,
  controller.empresa.interfaces,
  controller.estoque.interfaces,
  controller.pessoa.interfaces,
  controller.pdv_notas_fiscais.interfaces,
  controller.serie_nfe.interfaces,

  model.parametros,
  model.pessoa,
  model.PESSOA_FISICA,
  model.PESSOA_JURIDICA,
  model.CLIENTE,
  model.CONTATO,
  model.CONTATO_TELEFONE,
  model.CONTATO_EMAIL,
  model.ENDERECO,
  model.EMPRESA,
  model.PDV_NOTAS_FISCAIS_CAB,
  model.PDV_NOTAS_FISCAIS_ITEM,
  model.PEDIDO_VENDA,
  model.PEDIDO_VENDA_ITEM,
  model.SERIE_NFE,

  FireDAC.Comp.BatchMove,
  FireDAC.Comp.Client,
  FireDAC.Comp.BatchMove.Dataset,
  FireDAC.Comp.BatchMove.Text;

type
  TBackgroundThread = class(TThread)
  private
    FPaused: Boolean;
    // increase capabilities here
    // FTerminated: Boolean;
    // FOnTerminate: TNotifyEvent;
  protected
    procedure Execute; override;
  public
    procedure Pause;
    procedure Continue;
    procedure GenerateProductsFile;
    procedure EnterOrders;
    // procedure Terminate;
    // property OnTerminate: TNotifyEvent read FOnTerminate write FOnTerminate;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  view.principal,
  controller.parametros.interfaces.impl,
  controller.empresa.interfaces.impl,
  controller.estoque.interfaces.impl,
  controller.pessoa.interfaces.impl,
  controller.pdv_notas_fiscais.interfaces.impl,
  controller.serie_nfe.interfaces.impl;

{ TBackgroundThread }

procedure TBackgroundThread.Continue;
begin
  FPaused := False;
end;

procedure TBackgroundThread.EnterOrders;
var
  arqText: TextFile;
  reg0,
  reg1,
  reg2,
  reg3,
  reg4,
  reg5,
  tableSKU,
  tbcliente : TFDMemTable;
  objListParametro: TObjectList<TPARAMETROS>;
  parametro: TPARAMETROS;
  objListSerieNfe: TObjectList<TSERIE_NFE>;
  serie_nfe: TSERIE_NFE;
  objListEmpresa: TObjectList<TEMPRESA>;
  empresaModel: TEMPRESA;
  PDV_NOTAS_FISCAIS: TPDV_NOTAS_FISCAIS_CAB;
  qtdeTotal,
  cfop: Integer;
  listFiles,
  sLista: TStringList;
  config: TIniFile;
  empresa,
  linha,
  pdv_equipamento: String;
  sucesso,
  fileOpen: Boolean;
begin
  fileOpen := False;
  listFiles := TStringList.Create;
  TRoutines.ListarArquivos('C:\CSSISTEMAS\Plenus\ecommerce\download',false, listFiles);
  Try
    if listFiles.Count = 0 then
      Exit;
    for var i := 0 to listFiles.Count - 1 do
      begin
        sucesso := false;
        var
        nameFile: String := listFiles.Strings[i];
        while POS('\', nameFile) > 0 do
          nameFile := Copy(nameFile,POS('\', nameFile)+1, Length(nameFile));

        MoveFile(PWideChar(listFiles.Strings[i]),
          PWideChar('C:\CSSISTEMAS\Plenus\ecommerce\download\Temp\'+nameFile));

        AssignFile(arqText, 'C:\CSSISTEMAS\Plenus\ecommerce\download\Temp\'+nameFile);
        Reset(arqText);
        fileOpen := True;

        TRoutines.GenerateLogs(tpNormal,'Importando pedido do arquivo "'+nameFile+'"');

        config := TIniFile.Create('C:\CSSISTEMAS\Plenus\parametros.ini');
        empresa :=  DecodeString(config.ReadString('PARAMETROS_LOCAL', 'EMPRESA', '0'));
        pdv_equipamento := DecodeString (config.ReadString('PARAMETROS_LOCAL', 'PDV_EQUIPAMENTO', '0'));
        FreeAndNil(config);

        empresa := ((StrToInt(empresa) + 2) - 50).ToString();
        pdv_equipamento := ((StrToInt(pdv_equipamento) + 2) - 50).ToString();

        var
        IPARAMETRO := TIPARAMETROS.New;
        parametro := IPARAMETRO.Build.ListById('ID_EMPRESA',
          empresa.ToInteger, objListParametro).This;

        if (parametro.id_produto_tabela_loja_virtual.Value <= 0) Or
          (parametro.id_empresa_loja_virtual.Value <= 0) Or
          (parametro.id_colaborador_loja_virtual.Value <= 0) then
            Begin
              TRoutines.GenerateLogs(tpError,'Informações referente a Loja Virtual não informadas.');
              Exit;
            End;

        sLista := TStringList.Create;
        sLista.Delimiter := ';';
        sLista.StrictDelimiter := True;

{$REGION 'Criando tables temporárias'}
        reg0 := TFDMemTable.Create(nil);
        reg0.FieldDefs.Add('pedido', ftInteger, 0, false);
        reg0.FieldDefs.Add('dtemissao', ftDate, 0, false);
        reg0.FieldDefs.Add('pessoa', ftString, 1);
        reg0.FieldDefs.Add('documento', ftString, 20);
        reg0.FieldDefs.Add('nome', ftString, 60);
        reg0.FieldDefs.Add('tipoEntrega', ftString, 40);
        reg0.FieldDefs.Add('dtentrega', ftDate, 0, false);
        reg0.FieldDefs.Add('totalPedido', ftCurrency, 0, false);
        reg0.FieldDefs.Add('totalFrete', ftCurrency, 0, false);
        reg0.FieldDefs.Add('totalDesconto', ftCurrency, 0, false);
        reg0.FieldDefs.Add('status', ftString, 40);
        reg0.CreateDataSet;

        reg1 := TFDMemTable.Create(nil);
        reg1.FieldDefs.Add('pedido', ftInteger, 0, false);
        reg1.FieldDefs.Add('sku', ftString, 14);
        reg1.FieldDefs.Add('codbarras', ftString, 14);
        reg1.FieldDefs.Add('precoUnitario', ftCurrency);
        reg1.FieldDefs.Add('quantidade', ftFloat, 0, false);
        reg1.CreateDataSet;

        reg2 := TFDMemTable.Create(nil);
        reg2.FieldDefs.Add('pedido', ftInteger, 0, false);
        reg2.FieldDefs.Add('formaPagto', ftString, 30);
        reg2.FieldDefs.Add('nboleto_vdeposito', ftString, 30);
        reg2.FieldDefs.Add('urlboleto_titular', ftString, 60);
        reg2.FieldDefs.Add('ldigitavel_ncartao', ftString, 40);
        reg2.FieldDefs.Add('expiracao', ftString, 30);
        reg2.FieldDefs.Add('parcelas', ftInteger, 0, false);
        reg2.FieldDefs.Add('valorParcela', ftCurrency, 0, false);
        reg2.FieldDefs.Add('id_tipo', ftInteger, 0, false);
        reg2.CreateDataSet;

        reg3 := TFDMemTable.Create(nil);
        reg3.FieldDefs.Add('pedido', ftInteger, 0, false);
        reg3.FieldDefs.Add('cep', ftInteger, 0, false);
        reg3.FieldDefs.Add('endereco', ftString, 60);
        reg3.FieldDefs.Add('bairro', ftString, 40);
        reg3.FieldDefs.Add('numero', ftString, 5);
        reg3.FieldDefs.Add('complemento', ftString, 30);
        reg3.FieldDefs.Add('cidade', ftString, 30);
        reg3.FieldDefs.Add('estado', ftString, 2);
        reg3.FieldDefs.Add('ddd', ftInteger, 0, false);
        reg3.FieldDefs.Add('telefone', ftInteger, 0, false);
        reg3.CreateDataSet;

        reg4 := TFDMemTable.Create(nil);
        reg4.FieldDefs.Add('pedido', ftInteger, 0, false);
        reg4.FieldDefs.Add('cep', ftInteger, 0, false);
        reg4.FieldDefs.Add('endereco', ftString, 60);
        reg4.FieldDefs.Add('bairro', ftString, 40);
        reg4.FieldDefs.Add('numero', ftString, 5);
        reg4.FieldDefs.Add('complemento', ftString, 30);
        reg4.FieldDefs.Add('cidade', ftString, 30);
        reg4.FieldDefs.Add('estado', ftString, 2);
        reg4.FieldDefs.Add('ddd', ftInteger, 0, false);
        reg4.FieldDefs.Add('telefone', ftInteger, 0, false);
        reg4.CreateDataSet;

        reg5 := TFDMemTable.Create(nil);
        reg5.FieldDefs.Add('email', ftString, 120);
        reg5.FieldDefs.Add('pessoa', ftString, 1);
        reg5.FieldDefs.Add('nome', ftString, 60);
        reg5.FieldDefs.Add('documento', ftString, 20);
        reg5.FieldDefs.Add('ddd', ftInteger, 0, false);
        reg5.FieldDefs.Add('telefone', ftInteger, 0, false);
        reg5.FieldDefs.Add('dtnascimento', ftString, 10);
        reg5.FieldDefs.Add('ierg', ftString, 16);
        reg5.FieldDefs.Add('genero', ftString, 20);
        reg5.CreateDataSet;
{$ENDREGION}

          Try
{$REGION 'Importando registros'}

            while not Eoln(arqText) do
              begin
                ReadLn(arqText, linha);
                sLista.DelimitedText := linha;

                case AnsiIndexStr(sLista[0], ['0','1','2','3','4','5']) of
                  0:
                    begin
                      reg0.Append;
                      reg0.FieldByName('pedido').AsInteger := sLista[1].ToInteger;
                      reg0.FieldByName('dtemissao').AsDateTime := StrToDateTime(
                        Copy(sLista[3],7,2)+'/'+Copy(sLista[3],5,2)+'/'+Copy(sLista[3],1,4));
                      reg0.FieldByName('pessoa').AsString := sLista[5];
                      reg0.FieldByName('documento').AsString := TRoutines.MascaraCpfCnpj(sLista[6]);
                      reg0.FieldByName('nome').AsString := sLista[7];
                      reg0.FieldByName('tipoEntrega').AsString := sLista[8];
                      reg0.FieldByName('dtentrega').AsDateTime := StrToDateTime(
                        Copy(sLista[9],7,2)+'/'+Copy(sLista[9],5,2)+'/'+Copy(sLista[9],1,4));
                      reg0.FieldByName('totalPedido').AsString := sLista[11];
                      reg0.FieldByName('totalFrete').AsString := sLista[12];
                      reg0.FieldByName('totalDesconto').AsString := sLista[13];
                      reg0.FieldByName('status').AsString := sLista[14];
                      reg0.Post;
                    end;
                  1:
                    begin
                      reg1.Append;
                      reg1.FieldByName('pedido').AsInteger := sLista[1].ToInteger;
                      reg1.FieldByName('sku').AsString := sLista[3];
                      reg1.FieldByName('codbarras').AsString := sLista[4];
                      reg1.FieldByName('precoUnitario').AsString := sLista[5];
                      reg1.FieldByName('quantidade').AsString := sLista[6];
                      reg1.Post;
                      qtdeTotal := qtdeTotal + StrToInt(sLista[6]);
                    end;
                  2:
                    begin
                      case AnsiIndexStr(sLista[3],['BOLETO','CARTAO_CREDITO','CARTAO_DEBITO','DEBITO_ONLINE']) of
                        0:
                          begin
                            reg2.Append;
                            reg2.FieldByName('pedido').AsInteger := sLista[1].ToInteger;
                            reg2.FieldByName('formaPagto').AsString := sLista[3];
                            reg2.FieldByName('nboleto_vdeposito').AsString := sLista[4];
                            reg2.FieldByName('urlboleto_titular').AsString := sLista[5];
                            reg2.FieldByName('ldigitavel_ncartao').AsString := sLista[6];
                            reg2.FieldByName('expiracao').AsString := sLista[7];
                            reg2.FieldByName('parcelas').AsInteger := sLista[8].ToInteger;
                            reg2.FieldByName('valorParcela').AsString := sLista[9];
                            reg2.FieldByName('id_tipo').AsInteger := 4; // DUPLICATA
                            reg2.Post;
                          end;
                        1:
                          begin
                            reg2.Append;
                            reg2.FieldByName('pedido').AsInteger := sLista[1].ToInteger;
                            reg2.FieldByName('formaPagto').AsString := sLista[3];
                            reg2.FieldByName('nboleto_vdeposito').AsString := sLista[4];
                            reg2.FieldByName('urlboleto_titular').AsString := sLista[5];
                            reg2.FieldByName('ldigitavel_ncartao').AsString := sLista[6];
                            reg2.FieldByName('expiracao').AsString := sLista[7];
                            reg2.FieldByName('id_tipo').AsInteger := 2; // CARTAO_POS
                            reg2.Post;
                          end;
                        2:
                          begin
                            reg2.Append;
                            reg2.FieldByName('pedido').AsInteger := sLista[1].ToInteger;
                            reg2.FieldByName('formaPagto').AsString := sLista[3];
                            reg2.FieldByName('nboleto_vdeposito').AsString := sLista[4];
                            reg2.FieldByName('urlboleto_titular').AsString := sLista[5];
                            reg2.FieldByName('ldigitavel_ncartao').AsString := sLista[6];
                            reg2.FieldByName('expiracao').AsString := sLista[7];
                            reg2.FieldByName('parcelas').AsInteger := sLista[8].ToInteger;
                            reg2.FieldByName('valorParcela').AsString := sLista[9];
                            reg2.FieldByName('id_tipo').AsInteger := 2; // CARTAO_POS
                            reg2.Post;
                          end;
                        3:
                          begin
                            reg2.Append;
                            reg2.FieldByName('pedido').AsInteger := sLista[1].ToInteger;
                            reg2.FieldByName('formaPagto').AsString := sLista[3];
                            reg2.FieldByName('nboleto_vdeposito').AsString := sLista[4];
                            reg2.FieldByName('id_tipo').AsInteger := 14; // CARTEIRA_DIG
                            reg2.Post;
                          end;
                      end;

                    end;
                  3:
                    begin
                      reg3.Append;
                      reg3.FieldByName('pedido').AsInteger := sLista[1].ToInteger;
                      reg3.FieldByName('cep').AsInteger := sLista[3].ToInteger;
                      reg3.FieldByName('endereco').AsString := sLista[4];
                      reg3.FieldByName('bairro').AsString := sLista[5];
                      reg3.FieldByName('numero').AsString := sLista[6];
                      reg3.FieldByName('complemento').AsString := sLista[7];
                      reg3.FieldByName('cidade').AsString := sLista[8];
                      reg3.FieldByName('estado').AsString := sLista[9];
                      reg3.FieldByName('ddd').AsInteger := sLista[10].ToInteger;
                      reg3.FieldByName('telefone').AsInteger := sLista[11].ToInteger;
                      reg3.Post;
                    end;
                  4:
                    begin
                      reg4.Append;
                      reg4.FieldByName('pedido').AsInteger := sLista[1].ToInteger;
                      reg4.FieldByName('cep').AsInteger := sLista[3].ToInteger;
                      reg4.FieldByName('endereco').AsString := sLista[4];
                      reg4.FieldByName('bairro').AsString := sLista[5];
                      reg4.FieldByName('numero').AsString := sLista[6];
                      reg4.FieldByName('complemento').AsString := sLista[7];
                      reg4.FieldByName('cidade').AsString := sLista[8];
                      reg4.FieldByName('estado').AsString := sLista[9];
                      reg4.FieldByName('ddd').AsInteger := sLista[10].ToInteger;
                      reg4.FieldByName('telefone').AsInteger := sLista[11].ToInteger;
                      reg4.Post;
                    end;
                  5:
                    begin
                      reg5.Append;
                      reg5.FieldByName('email').AsString := sLista[1];
                      reg5.FieldByName('pessoa').AsString := sLista[2];
                      reg5.FieldByName('nome').AsString := sLista[3];
                      reg5.FieldByName('documento').AsString := TRoutines.MascaraCpfCnpj(sLista[4]);
                      reg5.FieldByName('ddd').AsInteger := sLista[5].ToInteger;
                      reg5.FieldByName('telefone').AsInteger := sLista[6].ToInteger;
                      reg5.FieldByName('dtnascimento').AsString := Copy(sLista[7],7,2)+
                        '/'+Copy(sLista[7],5,2)+'/'+Copy(sLista[7],1,4);
                      reg5.FieldByName('ierg').AsString := sLista[8];
                      reg5.FieldByName('genero').AsString := sLista[9];
                      reg5.Post;
                    end;
                end;
              end;
{$ENDREGION}

            var
            ISERIE_NFE := TISERIE_NFE.New;
            serie_nfe := ISERIE_NFE.Build.ListById('ID_SERIE_NFE',
              parametro.id_serie_nfe_loja_virtual, objListSerieNfe).This;

            var
            IEMPRESA := TIEMPRESA.New;
            empresaModel := IEMPRESA.Build.ListById('ID_EMPRESA',
              empresa.ToInteger, objListEmpresa).This;

            tbcliente := TFDMemTable.Create(nil);

{$REGION 'Criando ou Buscando Cliente'}

            if not IPARAMETRO.Manufactory.ifCustomerExist(reg0.FieldByName('documento').AsString, tbcliente) then
              begin
                var
                oContato_Telefone := TObjectList<TCONTATO_TELEFONE>.Create;
                oContato_Telefone.Add(TCONTATO_TELEFONE.Create);
                With oContato_Telefone.Last Do
                begin
                  id_tipo_telefone := 1;
                  telefone := reg3.FieldByName('ddd').AsString+reg3.FieldByName('telefone').AsString;
                  dt_inc := now();
                  dt_alt := now();
                end;

                var
                oContato_Email := TObjectList<TCONTATO_EMAIL>.Create;
                oContato_Email.Add(TCONTATO_EMAIL.Create);
                With oContato_Email.Last Do
                begin
                  id_tipo_email := 1;
                  email := reg5.FieldByName('email').AsString;
                  dt_inc := now();
                  dt_alt := now();
                end;

                var
                oContato := TObjectList<TCONTATO>.Create;
                oContato.Add(TCONTATO.Create);
                With oContato.Last Do
                begin
                  nome := reg0.FieldByName('nome').AsString;
                  CONTATO_TELEFONE := oContato_Telefone;
                  CONTATO_EMAIL := oContato_Email;
                  dt_inc := now();
                  dt_alt := now();
                end;

                var
                CLIENTE := TCLIENTE.Create;
                With CLIENTE Do
                Begin
                  codigo := IPARAMETRO
                    .Manufactory
                      .getLastCustomerCode;
                  id_empresa := parametro.id_empresa_loja_virtual;
                  desde := now();
                  id_empresa_pref := parametro.id_empresa_loja_virtual;
                  limite_personalizado := False;
                  limite_credito := 0;
                  desconsiderar_cheq_limite_credito := False;
                  comissao_vendedor := 0;
                  faturar := False;
                  data_ultima_compra := now();
                  valor_ultima_compra := 0;
                  data_cadastro := now();
                  usuario_cadastro := 1;
                  data_alteracao := now();
                  usuario_alteracao := 1;
                  m_blusa := '';
                  m_calca := '';
                  m_calcado := '';
                  suspenso := False;
                  id_tipo_venda := 1;
                  markup_min := 0;
                  dt_inc := now();
                  dt_alt := now();
                  marca := False;
                  bloqueado := False;
                End;

                var
                PESSOA_FISICA := TPESSOA_FISICA.Create;
                With PESSOA_FISICA Do
                Begin
                  id_estado_civil := 0;
                  nome := reg0.FieldByName('nome').AsString;
                  cpf := reg0.FieldByName('documento').AsString;
                  data_nascimento := StrToDate(IfThen(reg5.FieldByName('dtnascimento')
                    .AsString<>'//',reg5.FieldByName('dtnascimento').AsString,
                    DateToStr(Date())));
                  inscricao_municipal := EmptyStr;
                  inscricao_estadual := EmptyStr;
                  num_dependentes := 0;
                  tempo_residencia := 0;
                  dt_inc := now();
                  dt_alt := now();
                End;

                var
                ENDERECO := TENDERECO.Create;
                With ENDERECO DO
                Begin
                  rotulo := 'PRINCIPAL';
                  cep := reg3.FieldByName('cep').AsString;
                  logradouro := reg3.FieldByName('endereco').AsString;
                  numero := reg3.FieldByName('numero').AsString;
                  bairro := reg3.FieldByName('bairro').AsString;
                  cidade := reg3.FieldByName('cidade').AsString;
                  municipio_ibge := 0;
                  uf := 'ES';
                  pais_ibge := 0;
                  principal := True;
                  entrega := False;
                  cobranca := False;
                  dt_inc := now();
                  dt_alt := now();
                End;

                var
                PESSOA := TPESSOA.Create;
                pessoa.nome := reg0.FieldByName('nome').AsString;
                pessoa.abreviado := Copy(TRoutines.AbreviaNome(reg0.FieldByName('nome').AsString),1,15);
                pessoa.tipo := reg0.FieldByName('pessoa').AsString;
                pessoa.dt_inc := now();
                pessoa.dt_alt := now();
                pessoa.PESSOA_FISICA := PESSOA_FISICA;
                pessoa.CLIENTE := CLIENTE;
                pessoa.ENDERECO := ENDERECO;
                pessoa.CONTATO := oContato;

               var msg: String := '';
               IPARAMETRO.Manufactory.savePerson(PESSOA,PARAMETRO,empresa.ToInteger,msg);
               FreeAndNil(pessoa);
               if msg.Length = 0 then
                 IPARAMETRO.Manufactory.ifCustomerExist(reg0.FieldByName('documento').AsString, tbcliente)
               else
                raise Exception.Create(msg);
              end
            else
              IPARAMETRO.Manufactory.ifCustomerExist(reg0.FieldByName('documento').AsString, tbcliente);

{$ENDREGION}

            var
            cod := '3'+parametro.id_empresa_loja_virtual.ToString().PadLeft(3,'0')+
            IPARAMETRO
              .Manufactory
                .getLastOrderCode(parametro.id_empresa_loja_virtual).ToString()
                  .PadLeft(4,'0');

            if empresaModel.ENDERECO.uf = tbcliente.FieldByName('uf').AsString then
              cfop := 5102
            else
              cfop := 6102;

{$REGION 'Gerando a venda do pedido'}

            PDV_NOTAS_FISCAIS := TPDV_NOTAS_FISCAIS_CAB.Create;
            With PDV_NOTAS_FISCAIS Do
              begin
                codigo := cod.ToInteger;
                id_tipo_ambiente_nfe := serie_nfe.id_tipo_ambiente_nfe;
                id_tipo_emissao_nfe := serie_nfe.id_tipo_emissao_nfe;
                tipo_cadastro := 'C';
                id_cli_for := tbcliente.FieldByName('ID_CLIENTE').AsInteger;
                id_colaborador := parametro.id_colaborador_loja_virtual;
                id_empresa := parametro.id_empresa_loja_virtual;
                dt_emissao := now();
                id_forma_pagamento := reg2.FieldByName('id_tipo').AsInteger;
                operacao := 'S';
                id_produto_tabela := parametro.id_produto_tabela_loja_virtual;
                iest := '';
                modelo := serie_nfe.modelo;
                serie := serie_nfe.numero_serie;
                num_nota := serie_nfe.ultima_nfe.ToInteger + 1;
                dt_nota := reg0.FieldByName('dtemissao').Value;
                nome_destinatario := tbcliente.FieldByName('NOME').AsString;
                cpf_cnpj_destinatario := tbcliente.FieldByName('CPFCNPJ').AsString;
                telefone_destinatario := tbcliente.FieldByName('TELEFONE').AsString;
                endereco_destinatario := tbcliente.FieldByName('LOGRADOURO').AsString+', '+
                  tbcliente.FieldByName('NUMERO').AsString+', '+tbcliente.FieldByName('CEP').AsString;
                id_transportadora := parametro.id_transportadora_loja_virtual;
                cif_fob := false;
                tran_frete_por_conta := 1;
                tran_qtde_volumes := 0;
                tran_especie := 'VOLUME(S)';
                tran_numeracao := '0'; // verificar tipagem
                tran_peso_bruto := 0;
                tran_peso_liquido := 0;
                total_quantidade := qtdeTotal;
                total_desconto := reg0.FieldByName('totalDesconto').Value;
                total_frete := reg0.FieldByName('totalFrete').Value;
                total_bruto := reg0.FieldByName('totalPedido').Value+
                  reg0.FieldByName('totalDesconto').Value;
                total_liquido := total_bruto-
                  reg0.FieldByName('totalDesconto').Value+
                  reg0.FieldByName('totalFrete').Value;
                total_isento := 0;
                total_nao_tribut := total_liquido;
                total_cancelado := 0;
                ck_ipinaodeduzdesconto := False;
                nfe_finalidade := '1'; // verificar tipagem
                nfe_indfinal := True;
                nfe_indpres := 2; // NÃO PRESENCIAL PELA INTERNET
                ind_emitente := '0';
                ind_pgto := '0';
                ind_frete := '9'; // verificar tipagem
                ind_nat_frete := '9'; // verificar tipagem
                ck_csosn := True;
                id_usuario_alt := 1;
                id_origem := 13; // ORIGEM - VENDA
                cancelada := 'N';
                contigencia := False;
                status := 'P';
                obs := 'PEDIDO: '+reg0.FieldByName('pedido').AsString;
                dt_inc := now();
                dt_alt := now();

                reg1.First;
                tableSKU := TFDMemTable.Create(nil);
                if not reg1.Eof then
                  repeat
                    IPARAMETRO.Manufactory.viewSku('s.ID_SKU='+
                      reg1.FieldByName('sku').Value+' OR '+
                      'cb.CODIGO_BARRAS='''+reg1.FieldByName('codbarras').Value+'''',tableSKU);

                    if tableSKU.RecordCount = 0 then
                      begin
                        TRoutines.GenerateLogs(tpError,'Código "'+
                        reg1.FieldByName('codbarras').AsString+'" não encontrado.');
                        if fileOpen then
                          begin
                            CloseFile(arqText);
                            fileOpen := not fileOpen;
                          end;
                        MoveFile(PWideChar('C:\CSSISTEMAS\Plenus\ecommerce\download\Temp\'+nameFile),
                        PWideChar('C:\CSSISTEMAS\Plenus\ecommerce\download\Erro\'+nameFile));
                        Exit;
                      end;

                    PDV_NOTAS_FISCAIS_ITEM.Add(TPDV_NOTAS_FISCAIS_ITEM.Create);
                    With PDV_NOTAS_FISCAIS_ITEM.Last Do
                      Begin
                        id_natureza_operacao := cfop;
                        id_colaborador := parametro.id_colaborador_loja_virtual;
                        item := PDV_NOTAS_FISCAIS_ITEM.Count;
                        id_sku := tableSKU.FieldByName('ID_SKU').AsInteger;
                        gtin_produto := IfThen(
                          TRoutines.ValidaGTIN(tableSKU.FieldByName('CODIGO_BARRAS').AsString),
                          tableSKU.FieldByName('CODIGO_BARRAS').AsString,'SEM GTIN');
                        id_produto := tableSKU.FieldByName('ID_PRODUTO').AsInteger;
                        descricao := tableSKU.FieldByName('NOME').AsString;
                        id_unidade_produto := tableSKU.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
                        quantidade := reg1.FieldByName('quantidade').AsCurrency;
                        valor_unitario := reg1.FieldByName('precoUnitario').AsCurrency;
                        preco_unitario := reg1.FieldByName('precoUnitario').AsCurrency;
                        preco_tabela := reg1.FieldByName('precoUnitario').AsCurrency;
                        desconto := ((PDV_NOTAS_FISCAIS.total_desconto/reg1.RecordCount)/quantidade);
                        acrescimo := 0;
                        perc_cred_csosn := 0;
                        total_cred_csosn := 0;
                        base_icms := 0;
                        aliq_icms := 0;
                        total_icms := 0;
                        perc_redu_base := 0;
                        valor_redu_base := 0;
                        base_isento := 0;
                        cod_ntribut := ''; // verificar tipagem
                        base_nao_tribut := reg1.FieldByName('precoUnitario').AsCurrency;
                        base_sub_trib := 0;
                        mva_sub_trib := 0;
                        aliq_subtrib := 0;
                        total_sub_trib := 0;
                        cst_pis := '0';
                        aliq_pis := 0;
                        base_pis := 0;
                        total_pis := 0;
                        cst_cofins := '0';
                        base_cofins := 0;
                        aliq_cofins := 0;
                        total_cofins := 0;
                        base_ipi := 0;
                        aliq_ipi := 0;
                        base_issqn := 0;
                        aliq_issqn := 0;
                        total_issqn := 0;
                        base_ii := 0;
                        aliq_ii := 0;
                        total_ii_aduaneira := 0;
                        total_ii_iof := 0;
                        total_ii := 0;
                        total_bruto := valor_unitario*quantidade;
                        total_acrescimo := 0;
                        total_desconto := desconto*quantidade;
                        total_credito := 0;
                        total_comissao := 0;
                        total_frete := 0;
                        total_seguro := 0;
                        total_despesa := 0;
                        preco_liquido := valor_unitario-desconto;
                        total_liquido := (preco_liquido*quantidade)+total_frete;
                        ind_mov := '0'; // verificar tipagem
                        reservado := False;
                        presente := False;
                        promocao := False;
                        cancelado := 'N';
                        fcp := 0;
                        aliq_interna := 0;
                        aliq_interestadual := 0;
                        base_dif_aliq := 0;
                        dt_inc := PDV_NOTAS_FISCAIS.dt_inc;
                        dt_alt := PDV_NOTAS_FISCAIS.dt_alt;
                        marca := False;
                        bloqueado := False;
                      End;
                    reg1.Next
                  until reg1.Eof;
              end;

            var msg: String := EmptyStr;
            IPARAMETRO.Manufactory.saveOrder(PDV_NOTAS_FISCAIS,msg);

            FreeAndNil(PDV_NOTAS_FISCAIS);
            if msg.Length = 0 then
              begin
                sucesso := true;
                TRoutines.GenerateLogs(tpNormal,'Importação do pedido "'+
                reg0.FieldByName('pedido').AsString+'" do arquivo '+
                nameFile+' realizado com sucesso.');
              end
            else
              begin
                sucesso := false;
                TRoutines.GenerateLogs(tpError,'Procedimento encerrado por conta do erro: '+msg);
                raise Exception.Create('Error: '+msg);
              end;

{$ENDREGION}

        Finally
          if fileOpen then
            begin
              CloseFile(arqText);
              fileOpen := not fileOpen;
            end;
          if sucesso then
            begin
              nameFile := 'C:\CSSISTEMAS\Plenus\ecommerce\download\Temp\'+nameFile;
              while POS('\', nameFile) > 0 do
                nameFile := Copy(nameFile,POS('\', nameFile)+1, Length(nameFile));

              MoveFile(PWideChar('C:\CSSISTEMAS\Plenus\ecommerce\download\Temp\'+nameFile),
                PWideChar('C:\CSSISTEMAS\Plenus\ecommerce\download\Ok\'+nameFile));
            end
          else
            begin
              nameFile := 'C:\CSSISTEMAS\Plenus\ecommerce\download\Temp\'+nameFile;
              while POS('\', nameFile) > 0 do
                nameFile := Copy(nameFile,POS('\', nameFile)+1, Length(nameFile));

              MoveFile(PWideChar(listFiles.Strings[i]),
                PWideChar('C:\CSSISTEMAS\Plenus\ecommerce\download\Erro\'+nameFile));
            end;
        End;
      end;
  Finally
    if fileOpen then
      CloseFile(arqText);
    if Assigned(objListParametro) then
      begin
        objListParametro.Clear;
        FreeAndNil(objListParametro);
      end;
    if Assigned(objListSerieNfe) then
      begin
        objListSerieNfe.Clear;
        FreeAndNil(objListSerieNfe);
      end;
    if Assigned(objListEmpresa) then
      begin
        objListEmpresa.Clear;
        FreeAndNil(objListEmpresa);
      end;

    if Assigned(PDV_NOTAS_FISCAIS) then
      FreeAndNil(PDV_NOTAS_FISCAIS);
    if Assigned(tbcliente) then
      FreeAndNil(tbcliente);
    if Assigned(tableSKU) then
      FreeAndNil(tableSKU);
    if Assigned(reg5) then
      FreeAndNil(reg5);
    if Assigned(reg4) then
      FreeAndNil(reg4);
    if Assigned(reg3) then
      FreeAndNil(reg3);
    if Assigned(reg2) then
      FreeAndNil(reg2);
    if Assigned(reg1) then
      FreeAndNil(reg1);
    if Assigned(reg0) then
      FreeAndNil(reg0);
    if Assigned(sLista) then
      FreeAndNil(sLista);
    if Assigned(listFiles) then
      FreeAndNil(listFiles);
  End;
end;

procedure TBackgroundThread.Execute;
begin
  inherited;
  FPaused := False;

  while not Terminated do
  begin
    if not FPaused then
    begin
      EnterOrders();
      GenerateProductsFile();
    end;
    TThread.Sleep(TRoutines.GetInterval * 60 * 1000);
  end;
end;

procedure TBackgroundThread.GenerateProductsFile;
var
  fileProduto: TextFile;
  fileName,
  empresa,
  pdv_equipamento: String;
  config: TIniFile;
  parametros: TPARAMETROS;
  objListParametros: TObjectList<TPARAMETROS>;
  clienteDataSet: TFDMemTable;
begin
  fileName := FormatDateTime('YYYYmmddHHmmsszz',now())+'_Produtos.csv';
  config := TIniFile.Create('C:\CSSISTEMAS\Plenus\parametros.ini');
  empresa :=  DecodeString (config.ReadString('PARAMETROS_LOCAL', 'EMPRESA', '0'));
  pdv_equipamento := DecodeString (config.ReadString('PARAMETROS_LOCAL', 'PDV_EQUIPAMENTO', '0'));
  FreeAndNil(config);

  var
  IPARAMETROS := TIPARAMETROS.New;
  parametros := IPARAMETROS.Build.ListById('ID_PARAMETROS', 1, objListParametros).This;

  var
  IEstoque := TIEstoque.New;
  clienteDataSet := TFDMemTable.Create(nil);

  Try
    IEstoque.Manufacture.viewStockProducts(parametros,Date(),clienteDataSet);
    if clienteDataSet.RecordCount > 0 then
      begin
        TRoutines.GenerateLogs(tpNormal,'Gerando arquivo: C:\CSSISTEMAS\Plenus\ecommerce\upload\'+fileName);
        try
          AssignFile(fileProduto, 'C:\CSSISTEMAS\Plenus\ecommerce\upload\'+fileName);
          ReWrite(fileProduto);

          WriteLn(fileProduto,
            'Referencia;'+
            'Descricao;'+
            'Tamanho;'+
            'Cor;'+
            'NomeCor;'+
            'NomeCategoria;'+
            'NomeMarca;'+
            'SKU;'+
            'CodigoBarras;'+
            'CodificacaoFabricante;'+
            'PrecoCusto;'+
            'PrecoVenda;'+
            'Estoque;'+
            'Encomenda'
          );

            if not clienteDataSet.Eof then
              repeat
                 WriteLn(fileProduto,
                   clienteDataSet.FieldByName('REFID').AsString+';'+
                   clienteDataSet.FieldByName('NOME').AsString+';'+
                   clienteDataSet.FieldByName('TAMANHO').AsString+';'+
                   clienteDataSet.FieldByName('ID_COR').AsString+';'+
                   clienteDataSet.FieldByName('COR').AsString+';'+
                   clienteDataSet.FieldByName('SUBGRUPO').AsString+';'+ // Confirmar se este campo é para categoria
                   clienteDataSet.FieldByName('MARCA').AsString+';'+
                   clienteDataSet.FieldByName('SKU').AsString+';'+
                   clienteDataSet.FieldByName('CODIGO_BARRAS').AsString+';'+
                   clienteDataSet.FieldByName('PRECO_CUSTO').AsString+';'+
                   clienteDataSet.FieldByName('PRECO_VENDA').AsString+';'+
                   clienteDataSet.FieldByName('ESTOQUE').AsString+';'+
                   'N' // Encomenda
                 );
                clienteDataSet.Next;
              until clienteDataSet.Eof;

            CloseFile(fileProduto);
        except
          on e: exception do
            begin
              TRoutines.GenerateLogs(tpError,'Erro ao gerar *_Produto.csv por conta do erro a seguir: '+e.Message);
            end;
        end;
      end
    else
      TRoutines.GenerateLogs(tpWarning,'Nenhum produto ou movimentação para os critérios desejados.');
  Finally
    if Assigned(objListParametros) then
      begin
        objListParametros.Clear;
        FreeAndNil(objListParametros);
      end;
    if Assigned(clienteDataSet) then
      FreeAndNil(clienteDataSet);
  End;
end;

procedure TBackgroundThread.Pause;
begin
  FPaused := True;
end;

end.
