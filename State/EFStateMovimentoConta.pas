unit EFStateMovimentoConta;

interface

type

  ITransacao = interface;

  TContaTransacao = class
  private
    FSaldo: Double;
    FEstado: ITransacao;
    procedure SetSaldo(const Value: Double);
  public
    constructor create;
    property Saldo: Double read FSaldo write SetSaldo;

    procedure Saque(const Value: Double);
    procedure Deposito(const Value: Double);
  end;

  ITransacao = interface
    ['{4F59AB2A-0A11-4FA3-A898-41153DACCD86}']
    procedure Saca(_AConta: TContaTransacao; _Valor: Double);
    procedure Deposita(_AConta: TContaTransacao; _Valor: Double);
  end;

  TPositivo = class(TInterfacedObject, ITransacao)

    procedure Saca(_AConta: TContaTransacao; _Valor: Double);
    procedure Deposita(_AConta: TContaTransacao; _Valor: Double);
  end;

  TNegativo = class(TInterfacedObject, ITransacao)
    procedure Saca(_AConta: TContaTransacao; _Valor: Double);
    procedure Deposita(_AConta: TContaTransacao; _Valor: Double);
  end;

implementation

uses
  System.SysUtils;

{ TConta }

constructor TContaTransacao.create;
begin
  FEstado := TPositivo.create;
end;

procedure TContaTransacao.Deposito(const Value: Double);
begin
  FEstado.Deposita(Self, Value);
end;

procedure TContaTransacao.Saque(const Value: Double);
begin
  FEstado.Saca(Self, Value);
end;

procedure TContaTransacao.SetSaldo(const Value: Double);
begin
  FSaldo := Value;
end;

{ TPositivo }

procedure TPositivo.Deposita(_AConta: TContaTransacao; _Valor: Double);
begin
  _AConta.Saldo := _AConta.Saldo + (_Valor * 0.98);

end;

procedure TPositivo.Saca(_AConta: TContaTransacao; _Valor: Double);
begin
  _AConta.Saldo := _AConta.Saldo - (_Valor);
  if _AConta.Saldo < 0 then
    _AConta.FEstado := TNegativo.create;
end;

{ TNegativo }

procedure TNegativo.Deposita(_AConta: TContaTransacao; _Valor: Double);
begin
  _AConta.Saldo := _AConta.Saldo - (_Valor * 0.95);
  if _AConta.Saldo > 0 then
    _AConta.FEstado := TPositivo.create;
end;

procedure TNegativo.Saca(_AConta: TContaTransacao; _Valor: Double);
begin
  raise Exception.create('Sem Saldo !!!');
end;

end.
