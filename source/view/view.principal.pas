unit view.principal;

interface

uses
  Winapi.Windows
, Winapi.Messages

, System.IniFiles
, System.SysUtils
, System.StrUtils
, System.Classes
, System.JSON
, System.Win.Registry
, System.Generics.Collections
, System.NetEncoding
, Vcl.Graphics
, Vcl.Controls
, Vcl.SvcMgr
, Vcl.Dialogs
, BackgroundThreadUnit
, DataSet.Serialize
, routines,

  Data.DB,
  DataSnap.DBClient,
  Soap.EncdDecd,

  Vcl.ExtCtrls,

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

  controller.parametros.interfaces,
  controller.empresa.interfaces,
  controller.estoque.interfaces,
  controller.pessoa.interfaces,
  controller.pdv_notas_fiscais.interfaces,
  controller.serie_nfe.interfaces,

  FireDAC.Comp.BatchMove,
  FireDAC.Comp.Client,
  FireDAC.Comp.BatchMove.Dataset,
  FireDAC.Comp.BatchMove.Text;

type
  TPlenusHubService = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    { Private declarations }
    FBackgroundThread: TBackgroundThread;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  PlenusHubService: TPlenusHubService;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  controller.parametros.interfaces.impl,
  controller.empresa.interfaces.impl,
  controller.estoque.interfaces.impl,
  controller.pessoa.interfaces.impl,
  controller.pdv_notas_fiscais.interfaces.impl,
  controller.serie_nfe.interfaces.impl;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  PlenusHubService.Controller(CtrlCode);
end;

function TPlenusHubService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TPlenusHubService.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + name, false) then
    begin
      Reg.WriteString('Description', 'Serviço de Integração Plenus/Hub');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TPlenusHubService.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  FBackgroundThread.Continue;
  Continued := True;
  TRoutines.GenerateLogs(tpNormal,'Serviço reiniciado.');
end;

procedure TPlenusHubService.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
    ServiceThread.ProcessRequests(false);
    TThread.Sleep((TRoutines.GetInterval * 60 * 1000));
  end;
end;

procedure TPlenusHubService.ServicePause(Sender: TService; var Paused: Boolean);
begin
  FBackgroundThread.Pause;
  Paused := True;
  TRoutines.GenerateLogs(tpNormal,'Serviço pausado.');
end;

procedure TPlenusHubService.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  FBackgroundThread := TBackgroundThread.Create(True);
  FBackgroundThread.Start;
  Started := True;
  TRoutines.GenerateLogs(tpNormal,'Serviço iniciado.');
end;

procedure TPlenusHubService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  FBackgroundThread.Terminate;
  FBackgroundThread.WaitFor;
  FreeAndNil(FBackgroundThread);
  Stopped := True;
  TRoutines.GenerateLogs(tpNormal,'Serviço encerrado.');
end;

end.
