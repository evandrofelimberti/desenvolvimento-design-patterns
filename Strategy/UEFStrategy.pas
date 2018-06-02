unit UEFStrategy;

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

  TIcms = class(TInterfacedObject, IImposto)
  public
    function Calcula(_Orcamento: TOrcamento): Double;
  end;

  TIss = class(TInterfacedObject, IImposto)
  public
    function Calcula(_Orcamento: TOrcamento): Double;
  end;

  TCalculadorImpostos = class
  private
  public
    class function GetCalculo(_AOrcamento: TOrcamento; _AImposto: IImposto): Double;
  end;

  EnumImposto = (NENHUM, ICMS, ISS);

  TImpostoHelper = record helper for EnumImposto
    function Create(): IImposto;
    function ToString: string;
  end;

implementation

uses
  FMX.Dialogs, System.SysUtils, typinfo;

{ TOrcamento }

constructor TOrcamento.Create(_PValor: Double);
begin
  FValor := _PValor;
end;

function TOrcamento.GetValor: Double;
begin
  Result := FValor;
end;

{ TIcms }

function TIcms.Calcula(_Orcamento: TOrcamento): Double;
begin
  Result := _Orcamento.GetValor * 0.17;
end;

{ TIss }

function TIss.Calcula(_Orcamento: TOrcamento): Double;
begin
  Result := _Orcamento.GetValor * 0.04;
end;

{ TCalculadorImpostos }

class function TCalculadorImpostos.GetCalculo(_AOrcamento: TOrcamento; _AImposto: IImposto): Double;
begin
  Result := 0;
  Result := _AImposto.Calcula(_AOrcamento);
end;

{ TImpostoHelper }

function TImpostoHelper.Create(): IImposto;
begin
  case self of
    NENHUM:
      Result := nil;
    ICMS:
      Result := TIcms.Create;
    ISS:
      Result := TIss.Create;
  end;
end;

function TImpostoHelper.ToString: string;
begin
  case self of
    NENHUM:
      Result := 'Nenhum';
    ICMS:
      Result := 'Valor de Icms';
    ISS:
      Result := 'Valor de Iss';
  end;
end;

end.
