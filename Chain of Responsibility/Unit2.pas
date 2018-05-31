unit Unit2;

interface

uses
  System.Generics.Collections;

type
  TItem = class
  private
    FNome: string;
    FValor: Double;

  public
    property Nome: string read FNome write FNome;
    property Valor: Double read FValor write FValor;
    constructor Create(_PNome: string; _PValor: Double);
  end;

  TOrcamento = class
  private
    FValor: Double;
    // FItens: TObjectList<TItem>;
    FItens: TDictionary<string, TItem>; // dicionario do item
  public
    constructor Create(_PValor: Double);
    function GetValor(): Double;
    property Valor: Double read FValor write FValor;
    // property Itens: TObjectList<TItem> read FItens write FItens;
    property Itens: TDictionary<string, TItem> read FItens write FItens;

    procedure AdicionarItem(_PItem: TItem);

  end;

  IDesconto = interface
    ['{1D0D29F0-7B10-4742-ABA1-8E383390ADA3}']

    // função igual para todos os metodos de validar desconto
    function Desconta(_AOrcamento: TOrcamento): Double;
    // procedimento para salvar o objeto do proximo desconto, na funcção desconta,
    // caso não atenda a validação, chama o objeto setado nessa função
    procedure SetProximo(_AProximo: IDesconto);
  end;

  TDescontoPorMaisdeCincoItens = class(TInterfacedObject, IDesconto)
  private
    FProximo: IDesconto;
  public
    function Desconta(_AOrcamento: TOrcamento): Double;
    procedure SetProximo(_AProximo: IDesconto);
  end;

  TDescontoPorMaisqueQuinhentosReais = class(TInterfacedObject, IDesconto)
  private
    FProximo: IDesconto;
  public
    function Desconta(_AOrcamento: TOrcamento): Double;
    procedure SetProximo(_AProximo: IDesconto);
  end;

  TDescontoPorVendaCasada = class(TInterfacedObject, IDesconto)
  private
    FProximo: IDesconto;
    function ExisteCesta(_AOrcamento: TOrcamento): boolean;
  public
    function Desconta(_AOrcamento: TOrcamento): Double;
    procedure SetProximo(_AProximo: IDesconto);
  end;

  TCalculadorDeDescontos = class
  public
    class function Calcular(_POrcamento: TOrcamento): Double;
  end;

  TSemDesconto = class(TInterfacedObject, IDesconto)
  public
    function Desconta(_AOrcamento: TOrcamento): Double;
    procedure SetProximo(_AProximo: IDesconto);
  end;

implementation

uses
  FMX.Dialogs, System.SysUtils;

{ TItem }

constructor TItem.Create(_PNome: string; _PValor: Double);
begin
  FNome := _PNome;
  FValor := _PValor;
end;

{ TOrcamento }

procedure TOrcamento.AdicionarItem(_PItem: TItem);
begin
  FItens.Add(_PItem.Nome, _PItem);
end;

constructor TOrcamento.Create(_PValor: Double);
begin
  FValor := _PValor;
  // FItens := TObjectList<TItem>.Create;
  FItens := TDictionary<string, TItem>.Create;
end;

function TOrcamento.GetValor: Double;
begin
  Result := Valor;
end;

{ TDescontoPorMaisdeCincoItens }

function TDescontoPorMaisdeCincoItens.Desconta(_AOrcamento: TOrcamento): Double;
begin
  if _AOrcamento.Itens.Count > 5 then
    Result := _AOrcamento.Valor * 0.01
  else
    Result := FProximo.Desconta(_AOrcamento);
end;

procedure TDescontoPorMaisdeCincoItens.SetProximo(_AProximo: IDesconto);
begin
  FProximo := _AProximo;
end;

{ TDescontoPorMaisqueQuinhentosReais }

function TDescontoPorMaisqueQuinhentosReais.Desconta(_AOrcamento: TOrcamento): Double;
begin
  // verifica se o desconto está dentro da validação, caso contrario passa para o
  // proxima classe de validação de desconto

  if _AOrcamento.GetValor > 500 then
    Result := _AOrcamento.Valor * 0.01
  else
    Result := FProximo.Desconta(_AOrcamento)
end;

procedure TDescontoPorMaisqueQuinhentosReais.SetProximo(_AProximo: IDesconto);
begin
  FProximo := _AProximo;
end;

{ TDescontoPorVendaCasada }

function TDescontoPorVendaCasada.Desconta(_AOrcamento: TOrcamento): Double;
begin
  if ExisteCesta(_AOrcamento) then
  begin
    Result := _AOrcamento.Valor * 0.05
  end
  else
    Result := FProximo.Desconta(_AOrcamento)

end;

function TDescontoPorVendaCasada.ExisteCesta(_AOrcamento: TOrcamento): boolean;
var
  _AItem: TItem;
  _AArroz, _AFeijao: boolean;
  _AKey: string;
begin
  _AArroz := False;
  _AFeijao := False;

  _AArroz := _AOrcamento.FItens.ContainsKey('Arroz');
  _AFeijao := _AOrcamento.FItens.ContainsKey('Feijão');

  // for _AItem in _AOrcamento.FItens do
 { for _AItem in _AOrcamento.FItens.Values do
  begin
    if not _AArroz then
      _AArroz := (_AItem.FNome.Equals('Arroz'));

    if not _AFeijao then
      _AFeijao := (_AItem.FNome.Equals('Feijão'));
  end;
       }

  Result := (_AArroz = _AFeijao);
end;

procedure TDescontoPorVendaCasada.SetProximo(_AProximo: IDesconto);
begin
  FProximo := _AProximo;
end;

{ TCalculadorDeDescontos }

class function TCalculadorDeDescontos.Calcular(_POrcamento: TOrcamento): Double;
var
  D1, D2, D3, D5: IDesconto;
begin
  D1 := TDescontoPorMaisdeCincoItens.Create;
  D2 := TDescontoPorMaisqueQuinhentosReais.Create;
  D3 := TDescontoPorVendaCasada.Create;
  D5 := TSemDesconto.Create;

  D1.SetProximo(D2);
  D2.SetProximo(D3);
  D3.SetProximo(D5);

  Result := D1.Desconta(_POrcamento);

end;

{ TSemDesconto }

function TSemDesconto.Desconta(_AOrcamento: TOrcamento): Double;
begin
  Result := 0;
end;

procedure TSemDesconto.SetProximo(_AProximo: IDesconto);
begin
  //
end;

end.
