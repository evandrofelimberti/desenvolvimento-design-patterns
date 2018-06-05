unit TemplateMethod.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, UTemplateMethod,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TTemplateMethodView = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TemplateMethodView: TTemplateMethodView;

implementation

{$R *.fmx}

procedure TTemplateMethodView.Button1Click(Sender: TObject);
var
  _AIcpp, _AIkcv: IImposto;
  _AOrcamento: TOrcamento;
begin
  _AOrcamento := TOrcamento.Create(StrToFloatDef(Edit1.Text, 100));
  try

    _AOrcamento.AdicionarItem(TItem.Create('Cafe', 200));
    _AOrcamento.AdicionarItem(TItem.Create('Arroz', 300));
    _AOrcamento.AdicionarItem(TItem.Create('Carne', 300));
    _AOrcamento.AdicionarItem(TItem.Create('Feijão', 300));

    _AIcpp := TIcpp.Create;
    _AIkcv := TIkcv.Create;

    ShowMessage('Imposto ICCP: ' + FloatToStr(_AIcpp.Calcula(_AOrcamento)));

    ShowMessage('Imposto IKCP: ' + FloatToStr(_AIkcv.Calcula(_AOrcamento)));

  finally
    _AOrcamento.Free;
  end;

end;

end.
