unit EFStrategyView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, UEFStrategy,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Layouts, FMX.ListBox;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Rtti, typinfo;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  ItemList: TListItem;
  _AOrcamento: TOrcamento;
  _ValorIss, _ValorIcms: Double;

begin
  _AOrcamento := TOrcamento.Create(StrToFloatDef(trim(Edit1.Text), 0));
  try
    _ValorIcms := TCalculadorImpostos.GetCalculo(_AOrcamento, ICMS.Create);
    _ValorIss := TCalculadorImpostos.GetCalculo(_AOrcamento, ISS.Create);

    ListBox1.Items.AddPair('Orçamento ' + IntToStr(ListBox1.Items.Count + 1) + ', R$ ' + Edit1.Text,
      '  ' + ICMS.ToString + ' R$ :' + _ValorIcms.ToString +
      '  ' + ISS.ToString + ' R$ :' + _ValorIss.ToString);

  finally
    _AOrcamento.Free;
  end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if Edit1.CanFocus then
    Edit1.SetFocus;
end;

end.
