unit EFSate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EFState, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.StdCtrls, cxLabel, dxSkinscxPCPainter,
  dxBarBuiltInMenu, cxPC, EFStateMovimentoConta, cxTextEdit;

type

  TTransacaoConta = (tcNenhuma, tcSaque, tcDeposito);

  TEFStateView = class(TForm)
    Edit1: TEdit;
    cxLabel1: TcxLabel;
    Button1: TButton;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    cxLabel2: TcxLabel;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    cxTextEditSaldo: TcxTextEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cxTabSheet2Show(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    conta: TContaTransacao;
    procedure ProcessaTransacao(_ATransacao: TTransacaoConta);

  public
    { Public declarations }
  end;

var
  EFStateView: TEFStateView;

implementation

{$R *.dfm}

procedure TEFStateView.Button1Click(Sender: TObject);
var
  orcamento: TOrcamento;
begin
  orcamento := TOrcamento.Create(StrToFloatDef(Edit1.Text, 0));
  try
    orcamento.AplicaDescontoExtra;
    ShowMessage('Orçamento Em Aprovação Valor: ' + orcamento.Valor.ToString);

    orcamento.Aprova;
    orcamento.Aprova;
    orcamento.AplicaDescontoExtra;
    ShowMessage('Orçamento Aprovado Valor: ' + orcamento.Valor.ToString);

    orcamento.Finaliza;

  finally
    orcamento.Free;
  end;

end;

procedure TEFStateView.Button2Click(Sender: TObject);
begin
  ProcessaTransacao(tcSaque);
end;

procedure TEFStateView.Button3Click(Sender: TObject);
begin
  ProcessaTransacao(tcDeposito);
end;

procedure TEFStateView.cxTabSheet2Show(Sender: TObject);
begin
  if not Assigned(conta) then
    conta := TContaTransacao.Create;
end;

procedure TEFStateView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(conta)
end;

procedure TEFStateView.ProcessaTransacao(_ATransacao: TTransacaoConta);
var
  ValorTransacao: Double;
begin

  try
    ValorTransacao := StrToFloatDef(Edit2.Text, 0);

    case _ATransacao of
      tcSaque:
        conta.Saque(ValorTransacao);
      tcDeposito:
        conta.Deposito(ValorTransacao);
    end;

  finally
    cxTextEditSaldo.Text := conta.Saldo.ToString;
  end;

end;

end.
