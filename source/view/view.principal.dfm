object PlenusHubService: TPlenusHubService
  DisplayName = 'Servi'#231'o de Integra'#231#227'o Plenus/Hub'
  AfterInstall = ServiceAfterInstall
  OnContinue = ServiceContinue
  OnExecute = ServiceExecute
  OnPause = ServicePause
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 276
  Width = 393
  object Timer1: TTimer
    Enabled = False
    Left = 184
    Top = 120
  end
end
