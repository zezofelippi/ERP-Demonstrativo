unit uAuxiliar;

interface

type TAuxiliar= class
  private
    constructor create;
    Class var Instanciado: TAuxiliar;
    class procedure LiberarInstancia;
  public
    codigoMenu, codigoTabela, nomeTabela, nomeTela: string;
    campoSelecionado, tipoCampo, tipoTela, idRegistroChavePrimaria: string;
    tipoDeComponenteSelecionado, nomeGroupBox: string;
    recriarComponentes, logadoComoADMSistema, pesquisandoRegistro,
      criarGroupBoxPesquisarCadastrar, remetentePesquisarCadastrar,
      inserindoColunaNaDBGrid : boolean;
    iContCampoObrigatorio, iLevelTreeView: integer;
    vetorCamposPreenchimentoObrigatorio: array[0..30] of string;
    Class function GetInstancia: TAuxiliar;
end;

implementation

{ TAuxiliar }

constructor TAuxiliar.create;
begin
  recriarComponentes := false;
  pesquisandoRegistro:= false;
  criarGroupBoxPesquisarCadastrar:= false;
  remetentePesquisarCadastrar:= false;
  inserindoColunaNaDBGrid:= false;
end;

class function TAuxiliar.GetInstancia: TAuxiliar;
begin
  if not Assigned(self.Instanciado) then
    self.Instanciado := TAuxiliar.create;
  result := self.Instanciado;
end;

class procedure TAuxiliar.LiberarInstancia;
begin
   if Assigned(self.Instanciado) then
  begin
    self.Instanciado.Free;
  end;
end;

initialization
Finalization
  TAuxiliar.LiberarInstancia;

end.
