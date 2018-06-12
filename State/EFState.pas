unit EFState;

interface

type

  IEstadoOrcamento = interface;

  TOrcamento = class
  private
    FValor: Double;
    procedure SetValor(const Value: Double);
  protected
    FEstadoAtual: IEstadoOrcamento;
  public
    constructor Create(_PValor: Double);
    property Valor: Double read FValor write SetValor;
    procedure AplicaDescontoExtra();

    procedure Aprova;
    procedure Reprova;
    procedure Finaliza;

  end;

  IEstadoOrcamento = interface
    procedure AplicaDescontoExtra(_Orcamento: TOrcamento);
    procedure Aprova(_Orcamento: TOrcamento);
    procedure Reprova(_Orcamento: TOrcamento);
    procedure Finaliza(_Orcamento: TOrcamento);
  end;

  TAprovado = class(TInterfacedObject, IEstadoOrcamento)
  public
    procedure AplicaDescontoExtra(_Orcamento: TOrcamento);
    procedure Aprova(_Orcamento: TOrcamento);
    procedure Reprova(_Orcamento: TOrcamento);
    procedure Finaliza(_Orcamento: TOrcamento);
  end;

  TEmAprovacao = class(TInterfacedObject, IEstadoOrcamento)
  public
    procedure AplicaDescontoExtra(_Orcamento: TOrcamento);
    procedure Aprova(_Orcamento: TOrcamento);
    procedure Reprova(_Orcamento: TOrcamento);
    procedure Finaliza(_Orcamento: TOrcamento);
  end;

  TReprovado = class(TInterfacedObject, IEstadoOrcamento)
  public
    procedure AplicaDescontoExtra(_Orcamento: TOrcamento);
    procedure Aprova(_Orcamento: TOrcamento);
    procedure Reprova(_Orcamento: TOrcamento);
    procedure Finaliza(_Orcamento: TOrcamento);
  end;

  TFinalizado = class(TInterfacedObject, IEstadoOrcamento)
  public
    procedure AplicaDescontoExtra(_Orcamento: TOrcamento);
    procedure Aprova(_Orcamento: TOrcamento);
    procedure Reprova(_Orcamento: TOrcamento);
    procedure Finaliza(_Orcamento: TOrcamento);
  end;

implementation

uses
  System.SysUtils;

{ TAprovado }

procedure TAprovado.AplicaDescontoExtra(_Orcamento: TOrcamento);
begin
  _Orcamento.FValor := _Orcamento.FValor * 0.05;
end;

procedure TAprovado.Aprova(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamento já está em estado de aprovação');
end;

procedure TAprovado.Finaliza(_Orcamento: TOrcamento);
begin
  _Orcamento.FEstadoAtual := TFinalizado.Create;
end;

procedure TAprovado.Reprova(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamento já está em estado de aprovação e não pode ser Reprovado!');
end;

{ TEmAprovacao }

procedure TEmAprovacao.AplicaDescontoExtra(_Orcamento: TOrcamento);
begin
  _Orcamento.FValor := _Orcamento.FValor * 0.02;
end;

procedure TEmAprovacao.Aprova(_Orcamento: TOrcamento);
begin
  _Orcamento.FEstadoAtual := TAprovado.Create;
end;

procedure TEmAprovacao.Finaliza(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orcamento em aprovação não podem ir para finalizado diretamente');
end;

procedure TEmAprovacao.Reprova(_Orcamento: TOrcamento);
begin
  _Orcamento.FEstadoAtual := TReprovado.Create;
end;

{ TFinalizado }

procedure TFinalizado.AplicaDescontoExtra(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamentos finalizados não recebem desconto extra !');
end;

procedure TFinalizado.Aprova(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamento já finalizado');
end;

procedure TFinalizado.Finaliza(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamento já finalizado');
end;

procedure TFinalizado.Reprova(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamento já finalizado');
end;

{ TReprovado }

procedure TReprovado.AplicaDescontoExtra(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamentos reprovados não recebem desconto extra !');
end;

procedure TReprovado.Aprova(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamentos reprovados não pode ser aprovado !');
end;

procedure TReprovado.Finaliza(_Orcamento: TOrcamento);
begin
  _Orcamento.FEstadoAtual := TFinalizado.Create;
end;

procedure TReprovado.Reprova(_Orcamento: TOrcamento);
begin
  raise Exception.Create('Orçamentos reprovados não podem ser reprovados !');
end;

{ TOrcamento }

procedure TOrcamento.AplicaDescontoExtra;
begin
  FEstadoAtual.AplicaDescontoExtra(Self);
end;

procedure TOrcamento.Aprova;
begin
  FEstadoAtual.Aprova(Self);
end;

constructor TOrcamento.Create(_PValor: Double);
begin
  FValor := _PValor;
  FEstadoAtual := TEmAprovacao.Create;
end;

procedure TOrcamento.Finaliza;
begin
  FEstadoAtual.Finaliza(Self);
end;

procedure TOrcamento.Reprova;
begin
  FEstadoAtual.Reprova(Self);
end;

procedure TOrcamento.SetValor(const Value: Double);
begin
  FValor := Value;
end;

end.
