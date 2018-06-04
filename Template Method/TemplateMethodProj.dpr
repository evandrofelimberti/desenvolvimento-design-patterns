program TemplateMethodProj;

uses
  System.StartUpCopy,
  FMX.Forms,
  TemplateMethod.View in 'TemplateMethod.View.pas' {TemplateMethodView},
  UTemplateMethod in 'UTemplateMethod.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTemplateMethodView, TemplateMethodView);
  Application.Run;
end.
