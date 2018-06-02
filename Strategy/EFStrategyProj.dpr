program EFStrategyProj;

uses
  System.StartUpCopy,
  FMX.Forms,
  EFStrategyView in 'EFStrategyView.pas' {Form1},
  UEFStrategy in 'UEFStrategy.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
