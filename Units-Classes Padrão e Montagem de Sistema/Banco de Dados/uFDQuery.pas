unit uFDQuery;

interface

uses uConexao, FireDAC.Comp.Client, FireDAC.Comp.UI;

type TUFDQuery = class
  private
    BaseDados : TConexao;
    constructor create;
    Class var Instanciado: TUFDQuery;
    class procedure LiberarInstancia;
  public
    FDQuery : TFDQuery;
    Class function GetInstancia: TUFDQuery;
end;

implementation

{ TFDQuery }

constructor TUFDQuery.create;
begin
  BaseDados := TConexao.GetInstancia;
  FDQuery := TFDQuery.Create(BaseDados.FDConexao);
  FDQuery.Connection := BaseDados.FDConexao;
end;

class function TUFDQuery.GetInstancia: TUFDQuery;
begin
  if not Assigned(self.Instanciado) then
    self.Instanciado := TUFDQuery.create;
  result := self.Instanciado;
end;

class procedure TUFDQuery.LiberarInstancia;
begin
  if Assigned(self.Instanciado) then
  begin
    self.Instanciado.Free;
  end;
end;

initialization
Finalization
  TUFDQuery.LiberarInstancia;

end.
