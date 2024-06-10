unit uMenu;

interface

uses uFDQuery;

type TUMenu = class  {Foi colocado TUMenu pois essa classe é reservada do delphi }

  public
    objQuery : TUFDQuery;
    constructor create;
    procedure mostrarModulos;
    procedure mostrarCodigoDoMenu(pCodigoModulo: string);
    procedure mostrarTelaPeloIndexDoModuloEDoMenu(pIndexModuloIndexMenu: string);
    procedure mostrarTelas(pCodigoModulo, pCampoOrdenacao: string);
    procedure mostrarTodasAsTelas;
    procedure mostrarDadosBotaoDeAtalho(pCodigoMenu: string);
    function alterarCodigoModuloCodigoMenu(pCodigoModulo, pCodigoMenu,
      pSequenciaModulo, pSequenciaMenu: string): string;
    function alterarCadastroForm(pDescricaoTela, pNomeForm, pIconeTela, pCodigoTela: string): string;
    function cadastrarForm(pDescricaoTela, pNomeForm, pCodigoModulo,
      pCodigoTabela, pCodigoClasse, pCaminhoIcone: string ):string;
    function excluirTela(pCodigoTela: string): string;
    function verificarSeClasseEstaCadastradaEmAlgumaTelaDoModulo(pCodigoClasse, pCodigoModulo: string): boolean;
    function cadastrarBotaoAtalho(pCodigoMenu: string): string;
    function excluirBotaoDeAtalhoEReordenalo(pCodigoBotao: string): string;
    function verificarSeBotaoDeAtalhoJaExiste(pCodigoMenu: string): boolean;
    function pegarCodigoTabela(pCodigoMenu: string): string;
    function pegarNameDoForm(pCodigoMenu: string):string;
    function pegarCodigoMenu:string;
    function verificarSeNomeDoFormJaExiste(pNomeForm:string): boolean;

end;

implementation

{ TMenu }

function TUMenu.alterarCadastroForm(pDescricaoTela, pNomeForm,
  pIconeTela, pCodigoTela: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_MENU SET      '+
      ' DDM_CAPTION=:DDM_CAPTION, DDM_NAME=:DDM_NAME, '+
      ' DDM_CAMINHO_ICONE=:DDM_CAMINHO_ICONE WHERE DDM_CODIGO=:DDM_CODIGO');
    objQuery.FDQuery.ParamByName('DDM_CAPTION').AsString := pDescricaoTela;
    objQuery.FDQuery.ParamByName('DDM_NAME').AsString := pNomeForm;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ParamByName('DDM_CAMINHO_ICONE').AsString := pIconeTela;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:='Sucesso';
end;

function TUMenu.alterarCodigoModuloCodigoMenu(pCodigoModulo, pCodigoMenu,
  pSequenciaModulo, pSequenciaMenu: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_MENU SET     ');
    objQuery.FDQuery.SQL.Add(' DDM_CODMODULO_CODMENU=:DDM_CODMODULO_CODMENU,');
    objQuery.FDQuery.SQL.Add(' DDM_SEQUENCIA_MENU=:DDM_SEQUENCIA_MENU       ');
    objQuery.FDQuery.SQL.Add(' WHERE DDMM_CODIGO=:DDMM_CODIGO               ');
    objQuery.FDQuery.SQL.Add(' AND DDM_CODIGO=:DDM_CODIGO                 ');
    objQuery.FDQuery.ParamByName('DDM_CODMODULO_CODMENU').AsString :=
      pSequenciaModulo + pSequenciaMenu;
    objQuery.FDQuery.ParamByName('DDM_SEQUENCIA_MENU').AsString :=
      pSequenciaMenu;
    objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
      objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:='Sucesso';
end;

function TUMenu.cadastrarBotaoAtalho(pCodigoMenu: string): string;
var
  posicao: integer;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT MAX(DDBA_POSICAO) AS POSICAO '+
    ' FROM DD_BOTAO_ATALHO ');
  objQuery.FDQuery.Open();
  objQuery.FDQuery.FetchAll;

  {Deixar posicao começando com 0(zero) pra acompanhar o index do imgList}
  if objQuery.FDQuery.FieldByName('POSICAO').AsString = '' then
    posicao := 0
  else
    posicao := objQuery.FDQuery.FieldByName('POSICAO').AsInteger +1;
  {FIM}

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_BOTAO_ATALHO    '+
      '(DDM_CODIGO, DDBA_POSICAO) '+
      'values                     '+
      '(:DDMM_CODIGO, :DDBA_POSICAO )');
    objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString   := pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDBA_POSICAO').AsInteger := posicao;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

function TUMenu.cadastrarForm(pDescricaoTela, pNomeForm, pCodigoModulo, pCodigoTabela,
  pCodigoClasse, pCaminhoIcone: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_MENU    '+
      '(DDM_CAPTION, DDM_NAME, DDMM_CODIGO,   '+
      ' DDBDT_CODIGO, DDCPF_CODIGO, DDM_CAMINHO_ICONE) '+
      'values                                          '+
      '(:DDM_CAPTION, :DDM_NAME, :DDMM_CODIGO,  '+
      ' :DDBDT_CODIGO, :DDCPF_CODIGO, :DDM_CAMINHO_ICONE)');
    objQuery.FDQuery.ParamByName('DDM_CAPTION').AsString := pDescricaoTela;
    objQuery.FDQuery.ParamByName('DDM_NAME').AsString := pNomeForm;
    objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
    objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabela;
    objQuery.FDQuery.ParamByName('DDCPF_CODIGO').AsString := pCodigoClasse;
    objQuery.FDQuery.ParamByName('DDM_CAMINHO_ICONE').AsString := pCaminhoIcone;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

constructor TUMenu.create;
begin
  objQuery := TUFDQuery.GetInstancia;
end;

function TUMenu.excluirBotaoDeAtalhoEReordenalo(pCodigoBotao: string): string;
var
  i, i_array: integer;
  botoes: array[1..30] of string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_BOTAO_ATALHO '+
      ' WHERE DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoBotao;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;

  {Ordena posição dos botões}
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDM_CODIGO   '+
    ' FROM DD_BOTAO_ATALHO                      '+
    ' ORDER BY DDBA_POSICAO ');
  objQuery.FDQuery.Open();
  objQuery.FDQuery.First;

  i_array := 1;
  while not objQuery.FDQuery.Eof do
  begin
    botoes[i_array] := objQuery.FDQuery.FieldByName('DDM_CODIGO').AsString;
    i_array := i_array +1;
    objQuery.FDQuery.Next;
  end;

  i:=0;
  while i < i_array -1 do
  begin
    try
      objQuery.FDQuery.Close;
      objQuery.FDQuery.SQL.Clear;
      objQuery.FDQuery.SQL.Add('UPDATE DD_BOTAO_ATALHO SET '+
        ' DDBA_POSICAO=:DDBA_POSICAO  '+
        ' WHERE DDM_CODIGO=:DDM_CODIGO ');
      objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString :=
        botoes[i+1];
      objQuery.FDQuery.ParamByName('DDBA_POSICAO').AsInteger := i;
        i:=i+1;
      objQuery.FDQuery.ExecSQL;
    except
      result := 'Erro';
      exit;
    end;
  end;
  {FIM}

end;

function TUMenu.excluirTela(pCodigoTela: string): string;
begin
  {Excluir botao de pesquisa na tela de pesquisa}
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_POSICAO_BOTAO_PESQUISA '+
      ' WHERE DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  {FIM}

  {Excluir botao de pesquisa na tela de pesquisarCadastrar}
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_POSICAO_GROUPBOX_BOTOES '+
      ' WHERE DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  {FIM}


  {Excluir colunas da grid da tela de pesquisa}
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_TELA_CAMPO_GRID '+
      ' WHERE DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  {FIM}


  {Excluir campos de pesquisa}
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_TELA_CAMPO_PESQUISA '+
      ' WHERE DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  {FIM}


  {Excluir tela}
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_MENU '+
      ' WHERE DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoTela;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
end;

procedure TUMenu.mostrarCodigoDoMenu(pCodigoModulo: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT '+
    'DDM_CODIGO    '+
    'FROM DD_MENU  '+
    'WHERE DDMM_CODIGO=:DDMM_CODIGO '+
    'ORDER BY DDM_CAPTION ');
  objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
  objQuery.FDQuery.Open;
  objQuery.FDQuery.FetchAll;
end;

procedure TUMenu.mostrarDadosBotaoDeAtalho(pCodigoMenu: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBA.DDM_CODIGO, DDM_CAMINHO_ICONE, ');
  objQuery.FDQuery.SQL.Add('DDM_CODMODULO_CODMENU, DDBA_POSICAO, DDM_CAPTION ');
  objQuery.FDQuery.SQL.Add('FROM DD_BOTAO_ATALHO DDBA                  ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_MENU DDM ON                  ');
  objQuery.FDQuery.SQL.Add('DDBA.DDM_CODIGO = DDM.DDM_CODIGO           ');
  if pCodigoMenu <> '' then
  begin
    objQuery.FDQuery.SQL.Add('WHERE DDBA.DDM_CODIGO=:DDM_CODIGO');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  end
  else
  begin
    objQuery.FDQuery.SQL.Add('ORDER BY DDBA_POSICAO');
  end;
  objQuery.FDQuery.Open();
end;

procedure TUMenu.mostrarTelaPeloIndexDoModuloEDoMenu(
  pIndexModuloIndexMenu: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDM_CAMINHO_ICONE,  '+
    'DDM_CODIGO, DDM_CAPTION, DDM_NAME, DDCPF.DDCPF_DESCRICAO '+
    'FROM DD_MENU DDM                            '+
    '  INNER JOIN DD_CLASSES_PARA_FORMS DDCPF ON '+
    '  DDM.DDCPF_CODIGO = DDCPF.DDCPF_CODIGO     '+
    'WHERE DDM_CODMODULO_CODMENU=:DDM_CODMODULO_CODMENU ');
  objQuery.FDQuery.ParamByName('DDM_CODMODULO_CODMENU').AsString :=
    pIndexModuloIndexMenu;
  objQuery.FDQuery.Open;
  objQuery.FDQuery.FetchAll;
end;

procedure TUMenu.mostrarModulos;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT MAX(DDM_SEQUENCIA_MENU) AS SEQUENCIA_MENU, '+
     'DDMM_DESCRICAO,                                                         '+
     'DDMM_SEQUENCIA_MODULO                                                   '+
    'FROM DD_MODULO_MENU DDMM                                                 '+
    ' LEFT JOIN DD_MENU DDM ON DDMM.DDMM_CODIGO = DDM.DDMM_CODIGO             '+
    'GROUP BY DDMM_DESCRICAO, DDMM_SEQUENCIA_MODULO                           '+
    'ORDER BY DDMM_DESCRICAO ');
  objQuery.FDQuery.Open();
end;

procedure TUMenu.mostrarTelas(pCodigoModulo, pCampoOrdenacao: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDM.DDM_CODIGO, DDM_CAPTION, DDM_NAME,         ');
  objQuery.FDQuery.SQL.Add('DDM_CAMINHO_ICONE, DDBDT.DDBDT_CODIGO, DDBDT_TABELA_APELIDO, ');
  objQuery.FDQuery.SQL.Add('DDCPF.DDCPF_CODIGO, DDCPF_DESCRICAO FROM DD_MENU DDM         ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_TABELAS DDBDT ON                            ');
  objQuery.FDQuery.SQL.Add('DDM.DDBDT_CODIGO = DDBDT.DDBDT_CODIGO                        ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_CLASSES_PARA_FORMS DDCPF ON                    ');
  objQuery.FDQuery.SQL.Add('DDM.DDCPF_CODIGO = DDCPF.DDCPF_CODIGO                        ');
  objQuery.FDQuery.SQL.Add('WHERE DDMM_CODIGO=:DDMM_CODIGO                               ');
  if (pCampoOrdenacao = '1') or (pCampoOrdenacao = '') then
    objQuery.FDQuery.SQL.Add('ORDER BY DDM_CAPTION')
  else
    objQuery.FDQuery.SQL.Add('ORDER BY ' + pCampoOrdenacao);

  objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
  objQuery.FDQuery.Open();

end;

procedure TUMenu.mostrarTodasAsTelas;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT    '+
     'DDM_CODIGO,                     '+
     'DDMM_DESCRICAO,                 '+
     'DDMM_SEQUENCIA_MODULO,          '+
     'DDM_CODMODULO_CODMENU,          '+
     'DDM_CAPTION,                    '+
     'DDM_NAME,                       '+
     'DDM_SEQUENCIA_MENU,             '+
     'DDM_CAMINHO_ICONE               '+
    'FROM DD_MODULO_MENU DDMM         '+
    ' LEFT JOIN DD_MENU DDM ON DDMM.DDMM_CODIGO = DDM.DDMM_CODIGO '+
    'ORDER BY DDMM_DESCRICAO, DDM_CAPTION ');
  objQuery.FDQuery.Open();

end;

function TUMenu.pegarCodigoMenu: string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT MAX(DDPBP_CODIGO) AS CODIGO_MENU  '+
    ' FROM DD_POSICAO_BOTAO_PESQUISA ');
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('CODIGO_MENU').AsString;
end;

function TUMenu.pegarCodigoTabela(pCodigoMenu: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_CODIGO FROM DD_MENU '+
    ' WHERE DDM_CODIGO=:DDM_CODIGO');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString;

end;

function TUMenu.pegarNameDoForm(pCodigoMenu: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDM_NAME FROM DD_MENU '+
    ' WHERE DDM_CODIGO=:DDM_CODIGO');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDM_NAME').AsString;
end;

function TUMenu.verificarSeBotaoDeAtalhoJaExiste(pCodigoMenu: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBA_CODIGO FROM DD_BOTAO_ATALHO '+
    ' WHERE DDM_CODIGO=:DDM_CODIGO');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty then
    result := false
  else
    result := true;

end;

function TUMenu.verificarSeClasseEstaCadastradaEmAlgumaTelaDoModulo(
  pCodigoClasse, pCodigoModulo: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT       '+
    'DDCPF_CODIGO, DDMM.DDMM_CODIGO      '+
    'FROM DD_MENU DDM INNER JOIN         '+
    'DD_MODULO_MENU DDMM ON              '+
    'DDM.DDMM_CODIGO = DDMM.DDMM_CODIGO  '+
    'WHERE DDCPF_CODIGO=:DDCPF_CODIGO    '+
    'AND DDMM.DDMM_CODIGO=:DDMM_CODIGO   ');
  objQuery.FDQuery.ParamByName('DDCPF_CODIGO').AsString := pCodigoClasse;
  objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
  objQuery.FDQuery.Open;
  objQuery.FDQuery.FetchAll;

  if not objQuery.FDQuery.IsEmpty then
    result := true
  else
    result := false;

end;

function TUMenu.verificarSeNomeDoFormJaExiste(pNomeForm: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDM_NAME FROM DD_MENU '+
    'WHERE DDM_NAME=:DDM_NAME');
  objQuery.FDQuery.ParamByName('DDM_NAME').AsString := pNomeForm;
  objQuery.FDQuery.Open;
  objQuery.FDQuery.FetchAll;

  if not objQuery.FDQuery.IsEmpty then
    result := true
  else
    result := false;
end;

end.
