program EFStateProj;

uses
  Vcl.Forms,
  EFSate.View in 'EFSate.View.pas' {EFStateView},
  EFState in 'EFState.pas',
  EFStateMovimentoConta in 'EFStateMovimentoConta.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TEFStateView, EFStateView);
  Application.Run;
end.
