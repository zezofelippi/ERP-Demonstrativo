unit uPesquisa;

interface

uses uFDquery, System.SysUtils;

type TPesquisa = class
  public
  iLeft, iTop: integer;
  objQuery: TUFDQuery;
  constructor create;
  procedure pesquisarRegistros(pSQL: string);
  procedure pegarPosicaoBotaoPesquisar(pCodigoMenu: string);
  procedure selecionarUmRegistroDoDBGrid(pIdRegistro, pCodigoTabela: string);
  procedure criarLigacoesComJoins(pCodigoTabelaPrincipal: string);
  procedure procurarChaveEstrangeiraAtravesDeOutraChaveEstrangeira(pchaveEstrangeira:string);
  procedure pegarTamanhoGpbDadosPesquisa(pCodigoTela: string);
  procedure pegarTamanhoGrdGridPesquisa(pCodigoTela: string);
  function alterarPosicaoBotaoPesquisar(pCodigoMenu: string;
    pLeft, pTop: integer): string;
  function cadastrarPosicaoBotaoPesquisar(pCodigoMenu: string): string;
  function cadastrarGpbDadosTelaDePesquisa(pCodigoMenu: string): string;
  function cadastrargrdGridTelaDePesquisa(pCodigoMenu: string): string;
  function verificarSeBotaoDaTelaDePesquisaJaFoiCadastrado(pCodigoMenu: string):boolean;
  function verificarSeGpbDadosDaTelaDePesquisaJaFoiCadastrado(pCodigoMenu: string): boolean;
  function verificarSeGrdGridDaTelaDePesquisaJaFoiCadastrado(pCodigoMenu: string): boolean;
  function pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(pCodigoCampo: string):string;
  function pegarCampoComboBoxParaPesquisarRegistrosNaClausulaWhere(pCodigoCampo: string):string;
  function pegarChavePrimariaAtravesDoCodigoDoComponenteNaTela(pCodigoComponente:string): string;
  function gravarTamanhoGpbDadosPesquisa(pCodigoTela: string; pWidth, pHeight: integer):  string;
  function alterarTamanhoGpbDadosPesquisa(pCodigoTela: string;
    pHeight, pWidth, pTop, pLeft: integer): string;
  function alterarTamanhogrdGridPesquisa(pCodigoTela: string;
    pHeight, pWidth, pTop, pLeft: integer): string;
  function pegarNameFisicoChavePrimaria(pCodigoTela: string): string;

end;

implementation

{ TPesquisa }

FUNCTION TPesquisa.alterarPosicaoBotaoPesquisar(pCodigoMenu: string; pLeft,
  pTop: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_POSICAO_BOTAO_PESQUISA SET '+
      'DDPBP_LEFT=:DDPBP_LEFT, DDPBP_TOP=:DDPBP_TOP  '+
      'WHERE DDM_CODIGO=:DDM_CODIGO    ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDPBP_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDPBP_TOP').AsInteger := pTop;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:= 'Sucesso';
end;

function TPesquisa.alterarTamanhoGpbDadosPesquisa(pCodigoTela: string;
  pHeight, pWidth, pTop, pLeft: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TELA_CAMPO_PESQUISA SET '+
      'DDTCP_HEIGHT=:DDTCP_HEIGHT, DDTCP_WIDTH=:DDTCP_WIDTH, '+
      'DDTCP_TOP=:DDTCP_TOP, DDTCP_LEFT=:DDTCP_LEFT  '+
      'WHERE DDBDC_CODIGO IS NULL AND DDBDCP_CODIGO IS NULL     '+
      'AND DDTCP_TIPO_COMPONENTE=:DDTCP_TIPO_COMPONENTE  '+
      'AND DDCB_CODIGO IS NULL AND DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger := pHeight;
    objQuery.FDQuery.ParamByName('DDTCP_WIDTH').AsInteger := pWidth;
    objQuery.FDQuery.ParamByName('DDTCP_TOP').AsInteger := pTop;
    objQuery.FDQuery.ParamByName('DDTCP_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDTCP_TIPO_COMPONENTE').AsString := 'G';
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';
end;

function TPesquisa.alterarTamanhogrdGridPesquisa(pCodigoTela: string; pHeight,
  pWidth, pTop, pLeft: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TELA_CAMPO_PESQUISA SET '+
      'DDTCP_HEIGHT=:DDTCP_HEIGHT, DDTCP_WIDTH=:DDTCP_WIDTH, '+
      'DDTCP_TOP=:DDTCP_TOP, DDTCP_LEFT=:DDTCP_LEFT  '+
      'WHERE DDBDC_CODIGO IS NULL AND DDBDCP_CODIGO IS NULL     '+
      'AND DDTCP_TIPO_COMPONENTE=:DDTCP_TIPO_COMPONENTE  '+
      'AND DDCB_CODIGO IS NULL AND DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger := pHeight;
    objQuery.FDQuery.ParamByName('DDTCP_WIDTH').AsInteger := pWidth;
    objQuery.FDQuery.ParamByName('DDTCP_TOP').AsInteger := pTop;
    objQuery.FDQuery.ParamByName('DDTCP_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDTCP_TIPO_COMPONENTE').AsString := 'D';
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

function TPesquisa.cadastrarGpbDadosTelaDePesquisa(pCodigoMenu: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO_PESQUISA  '+
      '(DDM_CODIGO, DDTCP_HEIGHT, DDTCP_WIDTH, '+
      ' DDTCP_TOP, DDTCP_LEFT, DDTCP_TIPO_COMPONENTE)   '+
      'values                       '+
      '(:DDM_CODIGO, :DDTCP_HEIGHT, :DDTCP_WIDTH, '+
      ' :DDTCP_TOP, :DDTCP_LEFT, :DDTCP_TIPO_COMPONENTE)   ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger := 150;
    objQuery.FDQuery.ParamByName('DDTCP_WIDTH').AsInteger := 250;
    objQuery.FDQuery.ParamByName('DDTCP_TOP').AsInteger := 20;
    objQuery.FDQuery.ParamByName('DDTCP_LEFT').AsInteger := 10;
    objQuery.FDQuery.ParamByName('DDTCP_TIPO_COMPONENTE').AsString:= 'G';
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

function TPesquisa.cadastrargrdGridTelaDePesquisa(pCodigoMenu: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO_PESQUISA  '+
      '(DDM_CODIGO, DDTCP_HEIGHT, DDTCP_WIDTH, '+
      ' DDTCP_TOP, DDTCP_LEFT, DDTCP_TIPO_COMPONENTE)   '+
      'values                       '+
      '(:DDM_CODIGO, :DDTCP_HEIGHT, :DDTCP_WIDTH, '+
      ' :DDTCP_TOP, :DDTCP_LEFT, :DDTCP_TIPO_COMPONENTE)   ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger := 150;
    objQuery.FDQuery.ParamByName('DDTCP_WIDTH').AsInteger := 250;
    objQuery.FDQuery.ParamByName('DDTCP_TOP').AsInteger := 20;
    objQuery.FDQuery.ParamByName('DDTCP_LEFT').AsInteger := 10;
    objQuery.FDQuery.ParamByName('DDTCP_TIPO_COMPONENTE').AsString:= 'D';
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';
end;

function TPesquisa.cadastrarPosicaoBotaoPesquisar(pCodigoMenu: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_POSICAO_BOTAO_PESQUISA  '+
      '(DDM_CODIGO, DDPBP_LEFT, DDPBP_TOP)   '+
      'values                                '+
      '(:DDM_CODIGO, :DDPBP_LEFT, :DDPBP_TOP)   ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDPBP_LEFT').AsInteger := 411;
    objQuery.FDQuery.ParamByName('DDPBP_TOP').AsInteger := 88;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

constructor TPesquisa.create;
begin
  objQuery:= TUFDQuery.GetInstancia;
end;

procedure TPesquisa.criarLigacoesComJoins(pCodigoTabelaPrincipal: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT.DDBDT_TABELA_FISICA, DDBDT.DDBDT_CODIGO, '+
    'DDBDCP.DDBDCP_CAMPO_FISICO, DDBDCE_REQUERIDO    '+
    'FROM                                            '+
    'DD_BD_CHAVE_ESTRANGEIRA DDBDCE                  '+
    'INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON       '+
    'DDBDCE.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO     '+
    'INNER JOIN DD_BD_TABELAS DDBDT ON               '+
    'DDBDCP.DDBDT_CODIGO = DDBDT.DDBDT_CODIGO        '+
    'WHERE DDBDCE.DDBDT_CODIGO=:DDBDT_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString:= pCodigoTabelaPrincipal;
  objQuery.FDQuery.Open();

end;

function TPesquisa.gravarTamanhoGpbDadosPesquisa(pCodigoTela:string; pWidth,
  pHeight: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO_PESQUISA '+
      '(DDM_CODIGO, DDTCP_HEIGHT) '+
      'VALUES '+
      '(:DDM_CODIGO, :DDTCP_HEIGHT) ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoTela;
    objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger:= pHeight;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:= 'Sucesso';
end;

function TPesquisa.pegarCampoComboBoxParaPesquisarRegistrosNaClausulaWhere(
  pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC.DDBDC_CAMPO_FISICO   '+
    'FROM DD_TELA_CAMPO_PESQUISA DDTCP                                        '+
    'INNER JOIN DD_COMBOBOX DDCB ON DDTCP.DDCB_CODIGO = DDCB.DDCB_CODIGO      '+
    'INNER JOIN DD_BD_CAMPO DDBDC ON DDCB.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO  '+
    'WHERE DDTCP.DDTCP_CODIGO=:DDTCP_CODIGO ');
  objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString:= pCodigoCampo;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDBDC_CAMPO_FISICO').AsString;
end;

function TPesquisa.pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(
  pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC.DDBDC_CAMPO_FISICO                   '+
    'FROM DD_TELA_CAMPO_PESQUISA DDTCP                                        '+
    'INNER JOIN DD_BD_CAMPO DDBDC ON DDTCP.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO   '+
    'WHERE DDTCP.DDTCP_CODIGO=:DDTCP_CODIGO ');
  objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString:= pCodigoCampo;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDBDC_CAMPO_FISICO').AsString;

end;

function TPesquisa.pegarChavePrimariaAtravesDoCodigoDoComponenteNaTela(
  pCodigoComponente: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CAMPO_FISICO '+
    'FROM DD_TELA_CAMPO_PESQUISA DDTCP                 '+
    'INNER JOIN DD_COMBOBOX DDCB ON                    '+
    'DDTCP.DDCB_CODIGO = DDCB.DDCB_CODIGO              '+
    'INNER JOIN DD_BD_CAMPO DDBDC ON                   '+
    'DDCB.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO            '+
    'INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON         '+
    'DDBDC.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO          '+
    'WHERE DDTCP.DDTCP_CODIGO=:DDTCP_CODIGO');
  objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString:= pCodigoComponente;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_FISICO').AsString;

end;

function TPesquisa.pegarNameFisicoChavePrimaria(pCodigoTela: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP.DDBDCP_CAMPO_FISICO                   '+
    'FROM DD_TELA_CAMPO_PESQUISA DDTCP                                        '+
    'INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON DDTCP.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO   '+
    'WHERE DDTCP.DDTCP_CODIGO=:DDTCP_CODIGO ');
  objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString:= pCodigoTela;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_FISICO').AsString;
end;

procedure TPesquisa.pegarPosicaoBotaoPesquisar(pCodigoMenu: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDPBP_LEFT, DDPBP_TOP '+
    'FROM DD_POSICAO_BOTAO_PESQUISA WHERE DDM_CODIGO=:DDM_CODIGO ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
  objQuery.FDQuery.Open();
  iLeft:= objQuery.FDQuery.FieldByName('DDPBP_LEFT').AsInteger;
  iTop:= objQuery.FDQuery.FieldByName('DDPBP_TOP').AsInteger;
end;

procedure TPesquisa.pegarTamanhoGpbDadosPesquisa(pCodigoTela: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT   '+
    ' DDTCP_HEIGHT, DDTCP_WIDTH, DDTCP_TOP, DDTCP_LEFT  '+
    ' FROM DD_TELA_CAMPO_PESQUISA    '+
    ' WHERE DDBDC_CODIGO IS NULL AND DDBDCP_CODIGO IS NULL  '+
    ' AND DDCB_CODIGO IS NULL AND DDM_CODIGO=:DDM_CODIGO  '+
    ' AND DDTCP_TIPO_COMPONENTE=''G'' ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoTela;
  objQuery.FDQuery.Open();

end;

procedure TPesquisa.pegarTamanhoGrdGridPesquisa(pCodigoTela: string);
begin
   objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT   '+
    ' DDTCP_HEIGHT, DDTCP_WIDTH, DDTCP_TOP, DDTCP_LEFT  '+
    ' FROM DD_TELA_CAMPO_PESQUISA    '+
    ' WHERE DDBDC_CODIGO IS NULL AND DDBDCP_CODIGO IS NULL  '+
    ' AND DDCB_CODIGO IS NULL AND DDM_CODIGO=:DDM_CODIGO  '+
    ' AND DDTCP_TIPO_COMPONENTE=''D'' ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoTela;
  objQuery.FDQuery.Open();
end;

procedure TPesquisa.pesquisarRegistros(pSQL: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add(pSQL);
  objQuery.FDQuery.Open();
end;

procedure TPesquisa.procurarChaveEstrangeiraAtravesDeOutraChaveEstrangeira(
  pchaveEstrangeira: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCE.DDBDT_CODIGO FROM         '+
    'DD_BD_TABELAS DDBDT INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON  '+
    'DDBDT.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO                       '+
    'INNER JOIN DD_BD_CHAVE_ESTRANGEIRA DDBDCE ON                   '+
    'DDBDCP.DDBDCP_CODIGO = DDBDCE.DDBDCP_CODIGO                    '+
    'WHERE DDBDT.DDBDT_CODIGO=:DDBDT_CODIGO');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString:= pchaveEstrangeira;
  objQuery.FDQuery.Open();

end;

procedure TPesquisa.selecionarUmRegistroDoDBGrid(pIdRegistro,
  pCodigoTabela: string);
var
  nomeTabela, chavePrimaria: string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_TABELA_FISICA FROM DD_BD_TABELAS');
  objQuery.FDQuery.SQL.Add('WHERE DDBDT_CODIGO=:DDBDT_CODIGO');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabela;
  objQuery.FDQuery.Open();

  nomeTabela := objQuery.FDQuery.FieldByName('DDBDT_TABELA_FISICA').AsString;

  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CAMPO_FISICO FROM DD_BD_CHAVE_PRIMARIA');
  objQuery.FDQuery.SQL.Add('WHERE DDBDT_CODIGO=:DDBDT_CODIGO');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabela;
  objQuery.FDQuery.Open();

  chavePrimaria := objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_FISICO').AsString;

  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT * FROM ' + nomeTabela +
    ' WHERE ' + chavePrimaria + '=' + pIdRegistro);
  objQuery.FDQuery.Open();
end;

function TPesquisa.verificarSeBotaoDaTelaDePesquisaJaFoiCadastrado(
  pCodigoMenu: string): boolean;
begin

  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDPBP_CODIGO '+
    'FROM DD_POSICAO_BOTAO_PESQUISA WHERE DDM_CODIGO=:DDM_CODIGO ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty then
    result:= false
  else
    result:= true;

end;

function TPesquisa.verificarSeGpbDadosDaTelaDePesquisaJaFoiCadastrado(
  pCodigoMenu: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO FROM DD_TELA_CAMPO_PESQUISA '+
    'WHERE DDBDC_CODIGO IS NULL AND DDBDCP_CODIGO IS NULL                   '+
    'AND DDCB_CODIGO IS NULL AND DDTCP_TIPO_COMPONENTE=''G'' '+
    ' AND DDM_CODIGO=:DDM_CODIGO');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty then
    result:= false
  else
    result:= true;
end;

function TPesquisa.verificarSeGrdGridDaTelaDePesquisaJaFoiCadastrado(
  pCodigoMenu: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO FROM DD_TELA_CAMPO_PESQUISA '+
    'WHERE DDBDC_CODIGO IS NULL AND DDBDCP_CODIGO IS NULL                   '+
    'AND DDCB_CODIGO IS NULL AND DDTCP_TIPO_COMPONENTE=''D'' '+
    ' AND DDM_CODIGO=:DDM_CODIGO');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty then
    result:= false
  else
    result:= true;
end;

end.
