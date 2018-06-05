unit UTemplateMethod;

interface

uses System.Generics.Collections;

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
    FItem: TObjectList<TItem>;
  protected
    property Item: TObjectList<TItem> read FItem write FItem;
  public
    constructor Create(_PValor: Double);
    function GetValor(): Double;
    procedure AdicionarItem(_PItem: TItem);
  end;

  IImposto = interface
    ['{9DD22DD1-27C7-4317-949C-5C5F1C7EA263}']
    function Calcula(_Orcamento: TOrcamento): Double;
  end;

  { TCalculadorImpostos = class
    public
    class function GetCalculo(_AOrcamento: TOrcamento; _AImposto: IImposto): Double;
    end; }

  TTamplateImpostoCondicional = class(TInterfacedObject, IImposto)
  public
    function Calcula(_Orcamento: TOrcamento): Double;
  protected
    function ItemMaiorQueCemReais(_Orcamento: TOrcamento): Boolean;

    function DeveUsarMaximaTaxacao(_Orcamento: TOrcamento): Boolean; virtual; abstract;
    function MaximaTaxacao(_Orcamento: TOrcamento): Double; virtual; abstract;
    function MinimaTaxacao(_Orcamento: TOrcamento): Double; virtual; abstract;
  end;

  TIcpp = class(TTamplateImpostoCondicional)
  private
  protected
    function DeveUsarMaximaTaxacao(_Orcamento: TOrcamento): Boolean; override;
    function MaximaTaxacao(_Orcamento: TOrcamento): Double; override;
    function MinimaTaxacao(_Orcamento: TOrcamento): Double; override;
  end;

  TIkcv = class(TTamplateImpostoCondicional)
  private
  protected
    function DeveUsarMaximaTaxacao(_Orcamento: TOrcamento): Boolean; override;
    function MaximaTaxacao(_Orcamento: TOrcamento): Double; override;
    function MinimaTaxacao(_Orcamento: TOrcamento): Double; override;
  end;

implementation

{ TIkcv }

function TIcpp.DeveUsarMaximaTaxacao(_Orcamento: TOrcamento): Boolean;
begin
  result := ((_Orcamento.GetValor > 500) and (ItemMaiorQueCemReais(_Orcamento)));
end;

function TIkcv.DeveUsarMaximaTaxacao(_Orcamento: TOrcamento): Boolean;
begin
  result := ((_Orcamento.GetValor > 500) and (ItemMaiorQueCemReais(_Orcamento)));

end;

function TIkcv.MaximaTaxacao(_Orcamento: TOrcamento): Double;
begin
  result := _Orcamento.GetValor * 0.06;
end;

function TIkcv.MinimaTaxacao(_Orcamento: TOrcamento): Double;
begin
  result := _Orcamento.GetValor * 0.10;
end;

{ TOrcamento }

procedure TOrcamento.AdicionarItem(_PItem: TItem);
begin
  FItem.Add(_PItem);
end;

constructor TOrcamento.Create(_PValor: Double);
begin
  FItem := TObjectList<TItem>.Create;
  FValor := _PValor;
end;

function TOrcamento.GetValor: Double;
begin
  result := FValor;
end;

{ TTamplateImpostoCondicional }

function TIcpp.MaximaTaxacao(_Orcamento: TOrcamento): Double;
begin
  result := _Orcamento.GetValor * 0.07;
end;

function TIcpp.MinimaTaxacao(_Orcamento: TOrcamento): Double;
begin
  result := _Orcamento.GetValor * 0.05;
end;

{ TTamplateImpostoCondicional }

function TTamplateImpostoCondicional.Calcula(_Orcamento: TOrcamento): Double;
begin
  if DeveUsarMaximaTaxacao(_Orcamento) then
    result := MaximaTaxacao(_Orcamento)
  else
    result := MinimaTaxacao(_Orcamento);
end;

function TTamplateImpostoCondicional.ItemMaiorQueCemReais(_Orcamento: TOrcamento): Boolean;
var
  _AItem: TItem;
begin
  for _AItem in _Orcamento.FItem do
  begin
    if _AItem.Valor > 100 then
    begin
      result := true;
      break;
    end
    else
      result := false;

  end;
end;

{ TItem }

constructor TItem.Create(_PNome: string; _PValor: Double);
begin
  FNome := _PNome;
  FValor := _PValor;
end;

end.
