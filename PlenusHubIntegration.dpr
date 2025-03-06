program PlenusHubIntegration;

uses
  Vcl.SvcMgr,
  view.principal in 'source\view\view.principal.pas' {PlenusHubService: TService},
  model.resource.interfaces in 'source\model\resource\model.resource.interfaces.pas',
  model.resource.impl.configuration in 'source\model\resource\impl\model.resource.impl.configuration.pas',
  model.resource.impl.connection.firedac in 'source\model\resource\impl\model.resource.impl.connection.firedac.pas',
  model.resource.impl.factory in 'source\model\resource\impl\model.resource.impl.factory.pas',
  model.service.interfaces in 'source\model\service\model.service.interfaces.pas',
  model.service.interfaces.impl in 'source\model\service\impl\model.service.interfaces.impl.pas',
  controller.parametros.interfaces in 'source\controller\controller.parametros.interfaces.pas',
  controller.parametros.interfaces.impl in 'source\controller\impl\controller.parametros.interfaces.impl.pas',
  model.service.scripts.interfaces in 'source\model\service\model.service.scripts.interfaces.pas',
  model.service.scripts.interfaces.impl in 'source\model\service\impl\model.service.scripts.interfaces.impl.pas',
  controller.estoque.interfaces in 'source\controller\controller.estoque.interfaces.pas',
  controller.estoque.interfaces.impl in 'source\controller\impl\controller.estoque.interfaces.impl.pas',
  BackgroundThreadUnit in 'source\view\BackgroundThreadUnit.pas',
  model.CLIENTE in 'source\model\entity\model.CLIENTE.pas',
  model.CONTATO in 'source\model\entity\model.CONTATO.pas',
  model.CONTATO_EMAIL in 'source\model\entity\model.CONTATO_EMAIL.pas',
  model.CONTATO_TELEFONE in 'source\model\entity\model.CONTATO_TELEFONE.pas',
  model.PDV_NOTAS_FISCAIS_CAB in 'source\model\entity\model.PDV_NOTAS_FISCAIS_CAB.pas',
  model.PDV_NOTAS_FISCAIS_ITEM in 'source\model\entity\model.PDV_NOTAS_FISCAIS_ITEM.pas',
  model.PESSOA in 'source\model\entity\model.PESSOA.pas',
  model.PESSOA_FISICA in 'source\model\entity\model.PESSOA_FISICA.pas',
  model.PESSOA_JURIDICA in 'source\model\entity\model.PESSOA_JURIDICA.pas',
  controller.pessoa.interfaces in 'source\controller\controller.pessoa.interfaces.pas',
  controller.pessoa.interfaces.impl in 'source\controller\impl\controller.pessoa.interfaces.impl.pas',
  model.ENDERECO in 'source\model\entity\model.ENDERECO.pas',
  model.EMPRESA in 'source\model\entity\model.EMPRESA.pas',
  model.PARAMETROS in 'source\model\entity\model.PARAMETROS.pas',
  model.PEDIDO_VENDA in 'source\model\entity\model.PEDIDO_VENDA.pas',
  model.PEDIDO_VENDA_ITEM in 'source\model\entity\model.PEDIDO_VENDA_ITEM.pas',
  model.SERIE_NFE in 'source\model\entity\model.SERIE_NFE.pas',
  routines in 'source\rotinas\routines.pas',
  controller.empresa.interfaces in 'source\controller\controller.empresa.interfaces.pas',
  controller.empresa.interfaces.impl in 'source\controller\impl\controller.empresa.interfaces.impl.pas',
  controller.pdv_notas_fiscais.interfaces in 'source\controller\controller.pdv_notas_fiscais.interfaces.pas',
  controller.pdv_notas_fiscais.interfaces.impl in 'source\controller\impl\controller.pdv_notas_fiscais.interfaces.impl.pas',
  controller.serie_nfe.interfaces in 'source\controller\controller.serie_nfe.interfaces.pas',
  controller.serie_nfe.interfaces.impl in 'source\controller\impl\controller.serie_nfe.interfaces.impl.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TPlenusHubService, PlenusHubService);
  Application.Run;
end.
