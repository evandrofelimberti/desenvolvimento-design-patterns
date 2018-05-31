unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, unit2,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.Button1Click(Sender: TObject);
var
  _AOrcamento: TOrcamento;
  _ADesconto: Double;
begin
  _AOrcamento := TOrcamento.Create(StrToFloatDef(Edit1.Text, 0));
  try
    _AOrcamento.AdicionarItem(TItem.Create('Cafe', 200));
    _AOrcamento.AdicionarItem(TItem.Create('Arroz', 300));
    _AOrcamento.AdicionarItem(TItem.Create('Carne', 300));
    _AOrcamento.AdicionarItem(TItem.Create('Feijão', 300));
    // _AOrcamento.AdicionarItem(TItem.Create('Arroz', 300));
    // _AOrcamento.AdicionarItem(TItem.Create('Arroz', 300));

    _ADesconto := TCalculadorDeDescontos.Calcular(_AOrcamento);
    ShowMessage(_ADesconto.ToString);

  finally
    _AOrcamento.Free;
  end;
  // TTesteDesconto.Create();
end;

end.
