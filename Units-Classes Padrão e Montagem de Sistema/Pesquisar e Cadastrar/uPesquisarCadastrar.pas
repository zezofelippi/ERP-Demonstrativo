unit uPesquisarCadastrar;

interface

uses uFDquery;

type TPesquisarCadastrar = class
  public
    objQuery: TUFDQuery;
    constructor create;
    procedure pegarPosicaoGpbBotoesPesquisarCadastrar(pCodigoTela: string);
    function alterarPosicaoGroupBoxBotoes(pCodigoMenu: string; pLeft,
      pTop: integer): string;
    function verificarSeGpbBotoesDaTelaDePesquisarCadastrarJaFoiCadastrado
      (pCodigoTela: string): boolean;
    function cadastrarGpbBotoesTelaDePesquisarCadastrar(pCodigoTela: string): string;

end;

implementation

{ TPesquisarCadastrar }

function TPesquisarCadastrar.alterarPosicaoGroupBoxBotoes(pCodigoMenu: string;
  pLeft, pTop: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_POSICAO_GROUPBOX_BOTOES SET '+
      'DDPGB_LEFT=:DDPGB_LEFT, DDPGB_TOP=:DDPGB_TOP  '+
      'WHERE DDM_CODIGO=:DDM_CODIGO    ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDPGB_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDPGB_TOP').AsInteger := pTop;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:= 'Sucesso';
end;

function TPesquisarCadastrar.cadastrarGpbBotoesTelaDePesquisarCadastrar(
  pCodigoTela: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_POSICAO_GROUPBOX_BOTOES  '+
      '(DDM_CODIGO, DDPGB_LEFT, DDPGB_TOP) '+
      'values                       '+
      '(:DDM_CODIGO, :DDPGB_LEFT, :DDPGB_TOP) ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ParamByName('DDPGB_LEFT').AsInteger := 150;
    objQuery.FDQuery.ParamByName('DDPGB_TOP').AsInteger := 30;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

constructor TPesquisarCadastrar.create;
begin
  objQuery:= TUFDQuery.GetInstancia;
end;

procedure TPesquisarCadastrar.pegarPosicaoGpbBotoesPesquisarCadastrar(pCodigoTela: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT   '+
    ' DDPGB_LEFT, DDPGB_TOP              '+
    ' FROM DD_POSICAO_GROUPBOX_BOTOES    '+
    ' WHERE DDM_CODIGO=:DDM_CODIGO  ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoTela;
  objQuery.FDQuery.Open();
end;

function TPesquisarCadastrar.verificarSeGpbBotoesDaTelaDePesquisarCadastrarJaFoiCadastrado(
  pCodigoTela: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDPGB_CODIGO '+
    'FROM DD_POSICAO_GROUPBOX_BOTOES WHERE DDM_CODIGO=:DDM_CODIGO ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoTela;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty then
    result:= false
  else
    result:= true;
end;

end.
