unit UTemplateMethod;

interface

type
  TOrcamento = class
  private
    FValor: Double;
  public
    constructor Create(_PValor: Double);
    function GetValor(): Double;
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
    function DeveUsarMaximaTaxacao(_Orcamento: TOrcamento): Boolean; virtual; abstract;
    function MaximaTaxacao(_Orcamento: TOrcamento): Double; virtual; abstract;
    function MinimaTaxacao(_Orcamento: TOrcamento): Double; virtual; abstract;
  end;

  TIcpp = class(TTamplateImpostoCondicional)
  private
    function ItemMaiorQueCemReais(_Orcamento: TOrcamento): Boolean;
  protected
    function DeveUsarMaximaTaxacao(_Orcamento: TOrcamento): Boolean; override;
    function MaximaTaxacao(_Orcamento: TOrcamento): Double; override;
    function MinimaTaxacao(_Orcamento: TOrcamento): Double; override;
  end;

  TIkcv = class(TTamplateImpostoCondicional)
  private
    function ItemMaiorQueCemReais(_Orcamento: TOrcamento): Boolean;
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

function TIcpp.ItemMaiorQueCemReais(_Orcamento: TOrcamento): Boolean;
begin
  { TODO -oEU -cGeneral : Item no Orçamento e varer os items maior que cem reais }
  result := true;

end;

function TIkcv.DeveUsarMaximaTaxacao(_Orcamento: TOrcamento): Boolean;
begin
  result := ((_Orcamento.GetValor > 500) and (ItemMaiorQueCemReais(_Orcamento)));

end;

function TIkcv.ItemMaiorQueCemReais(_Orcamento: TOrcamento): Boolean;
begin
  result := true;
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

constructor TOrcamento.Create(_PValor: Double);
begin
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

end.
