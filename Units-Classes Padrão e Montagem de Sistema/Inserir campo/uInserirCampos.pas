unit uInserirCampos;

interface

uses UFDQuery;

type TInserirCampos = class
  public
    objQuery : TUFDQuery;
    constructor create;
    procedure verificarSeExistePesquisaEntreDatas(pCodigoMenu: string);
    procedure alterarPosicaoGroupBoxData(pCodigoGroupBox: string;
      pLeft, pTop: integer);
    procedure mostrarComboBox(pCodigoMenu, pTipoTela:string);
    function verificaSeCampoChavePrimariaFoiInserido(
      pCodigoMenu, pCodigoCampo, pTipoCampo: string): boolean; {Aqui é usado na modelagem do tvCampos}
    function verificaSeCampoEChavePrimaria(
      pCampoApelido: string): boolean; {Aqui é usado na colocação dos icones de cada campo e tabela}
    function verificaSeChavePrimariaNaoEstaInseridoNaTela(pCodigoMenu, pTipoTela: string): boolean;
    function capturarChavePrimaria(pCodigoTabela: string): string;
    function cadastrarPesquisaEntreDatas(pNomePesquisaEntreDatas,
      pCodigoCampo, pCodigoMenu: string):string;
    function excluirPesquisaEntreDatas(pCodigoPesquisa:string):string;
    function excluirComboBox(pCodigoComboBox:string):string;
    function cadastrarGroupBox(pNomeComboBox,
      pCodigoCampoComum, pCodigoTabela, pCodigoMenu: string): string;
    function pegarCodigoDoCampoComDuaschavesEstrangeiras(pCampoApelido, pCodigoTabelaEstrangeira: string): string;
end;

implementation

{ TInserirCampos }

procedure TInserirCampos.alterarPosicaoGroupBoxData(pCodigoGroupBox: string;
  pLeft, pTop: integer);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('UPDATE DD_PESQUISA_ENTRE_DATAS SET '+
    ' DDPED_TOP=:DDPED_TOP, DDPED_LEFT=:DDPED_LEFT '+
    ' WHERE DDPED_CODIGO=:DDPED_CODIGO ');
  objQuery.FDQuery.ParamByName('DDPED_TOP').AsInteger := pTop;
  objQuery.FDQuery.ParamByName('DDPED_LEFT').AsInteger := pLeft;
  objQuery.FDQuery.ParamByName('DDPED_CODIGO').AsString := pCodigoGroupBox;
  objQuery.FDQuery.ExecSQL;
end;

function TInserirCampos.cadastrarGroupBox(pNomeComboBox, pCodigoCampoComum,
  pCodigoTabela, pCodigoMenu: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_COMBOBOX'+
      '(DDCB_NOME_COMBOBOX, DDBDC_CODIGO, DDBDT_CODIGO, DDM_CODIGO)'+
      ' VALUES '+
      '(:DDCB_NOME_COMBOBOX, :DDBDC_CODIGO, :DDBDT_CODIGO, :DDM_CODIGO)');
    objQuery.FDQuery.ParamByName('DDCB_NOME_COMBOBOX').AsString:=
      pNomeComboBox;
    objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString:=
      pCodigoCampoComum;
    objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString:=
      pCodigoTabela;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:=
      pCodigoMenu;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;
end;

function TInserirCampos.cadastrarPesquisaEntreDatas(pNomePesquisaEntreDatas,
  pCodigoCampo, pCodigoMenu: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_PESQUISA_ENTRE_DATAS'+
      '(DDPED_NOME_PESQUISA, DDBDC_CODIGO, DDM_CODIGO, DDPED_TOP, DDPED_LEFT)'+
      ' VALUES '+
      '(:DDPED_NOME_PESQUISA, :DDBDC_CODIGO, :DDM_CODIGO, :DDPED_TOP, :DDPED_LEFT)');
    objQuery.FDQuery.ParamByName('DDPED_NOME_PESQUISA').AsString:=
      pNomePesquisaEntreDatas;
    objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString:=
      pCodigoCampo;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:=
      pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDPED_TOP').AsInteger:= 10;
    objQuery.FDQuery.ParamByName('DDPED_LEFT').AsInteger:= 30;
    objQuery.FDQuery.ExecSQL;
  except
    result:='Erro';
  end;
end;

function TInserirCampos.capturarChavePrimaria(pCodigoTabela: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CAMPO_APELIDO '+
    'FROM DD_BD_CHAVE_PRIMARIA '+
    'WHERE DDBDT_CODIGO=:DDBDT_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabela;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_APELIDO').AsString;

end;

constructor TInserirCampos.create;
begin
  objQuery := TUFDQuery.GetInstancia;
end;

function TInserirCampos.excluirComboBox(pCodigoComboBox: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_COMBOBOX '+
      ' WHERE DDCB_CODIGO=:DDCB_CODIGO ');
    objQuery.FDQuery.ParamByName('DDCB_CODIGO').AsString:= pCodigoComboBox;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;
end;

function TInserirCampos.excluirPesquisaEntreDatas(
  pCodigoPesquisa: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_PESQUISA_ENTRE_DATAS '+
      ' WHERE DDPED_CODIGO=:DDPED_CODIGO ');
    objQuery.FDQuery.ParamByName('DDPED_CODIGO').AsString:= pCodigoPesquisa;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;
end;

procedure TInserirCampos.mostrarComboBox(pCodigoMenu, pTipoTela: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDCB_CODIGO, DDCB_NOME_COMBOBOX,                ');
  objQuery.FDQuery.SQL.Add('DDBDT_TABELA_APELIDO, DDBDC_CAMPO_APELIDO              ');
  objQuery.FDQuery.SQL.Add('FROM DD_COMBOBOX DDCB INNER JOIN DD_BD_TABELAS DDBDT ON ');
  objQuery.FDQuery.SQL.Add('DDCB.DDBDT_CODIGO= DDBDT.DDBDT_CODIGO                  ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CAMPO DDBDC ON                        ');
  objQuery.FDQuery.SQL.Add('DDCB.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO                 ');

  if pTipoTela = 'C' then
  begin
    objQuery.FDQuery.SQL.Add('AND DDCB_CODIGO NOT IN (SELECT DDCB_CODIGO FROM DD_TELA_CAMPO ');
    objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO AND DDCB_CODIGO IS NOT NULL) ');
  end
  else if pTipoTela = 'P' then
  begin
    objQuery.FDQuery.SQL.Add('AND DDCB_CODIGO NOT IN (SELECT DDCB_CODIGO FROM DD_TELA_CAMPO_PESQUISA ');
    objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO AND DDCB_CODIGO IS NOT NULL) ');
  end;

  objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:=pCodigoMenu;

end;

function TInserirCampos.pegarCodigoDoCampoComDuaschavesEstrangeiras(
  pCampoApelido, pCodigoTabelaEstrangeira: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC_CODIGO   '+
    'FROM DD_BD_CHAVE_ESTRANGEIRA DDBDCE          '+
    'INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON    '+
    'DDBDCE.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO  '+
    'INNER JOIN DD_BD_TABELAS DDBDT ON            '+
    'DDBDCP.DDBDT_CODIGO = DDBDT.DDBDT_CODIGO     '+
    'INNER JOIN DD_BD_CAMPO DDBDC ON              '+
    'DDBDT.DDBDT_CODIGO = DDBDC.DDBDT_CODIGO      '+
    'WHERE DDBDC.DDBDC_CAMPO_APELIDO=:DDBDC_CAMPO_APELIDO  '+
    'AND DDBDCE.DDBDT_CODIGO=:DDBDT_CODIGO');
  objQuery.FDQuery.ParamByName('DDBDC_CAMPO_APELIDO').AsString := pCampoApelido;
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabelaEstrangeira;

  result:= objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString;
end;

procedure TInserirCampos.verificarSeExistePesquisaEntreDatas(pCodigoMenu: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDPED_CODIGO, DDPED_NOME_PESQUISA, DDBDC_CAMPO_APELIDO,  '+
    'DDBDC_CAMPO_FISICO, DDPED_TOP, DDPED_LEFT FROM DD_PESQUISA_ENTRE_DATAS DDPED INNER JOIN                           '+
    'DD_BD_CAMPO DDBDC ON                                                    '+
    'DDPED.DDBDC_CODIGO= DDBDC.DDBDC_CODIGO                                  '+
    'WHERE DDM_CODIGO=:DDM_CODIGO ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
  objQuery.FDQuery.Open();

end;

function TInserirCampos.verificaSeCampoChavePrimariaFoiInserido(pCodigoMenu,
  pCodigoCampo, pTipoCampo: string): boolean;
begin

  if pTipoCampo = 'C' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDTC_CODIGO FROM DD_TELA_CAMPO DDTC  '+
      'INNER JOIN DD_GROUPBOX DDGB ON                                     '+
      'DDTC.DDGB_CODIGO = DDGB.DDGB_CODIGO                                '+
      'WHERE DDBDCP_CODIGO=:DDBDCP_CODIGO AND DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.Open();
  end
  else if pTipoCampo = 'P' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO FROM DD_TELA_CAMPO_PESQUISA '+
      'WHERE DDBDCP_CODIGO=:DDBDCP_CODIGO AND DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.Open();
  end
  else if pTipoCampo = 'G' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDTCG_CODIGO FROM DD_TELA_CAMPO_GRID '+
      'WHERE DDBDCP_CODIGO=:DDBDCP_CODIGO AND DDM_CODIGO=:DDM_CODIGO ');
    objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.Open();
  end;

  if objQuery.FDQuery.IsEmpty then
    result := false
  else
    result := true;
end;

function TInserirCampos.verificaSeCampoEChavePrimaria(
  pCampoApelido: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CODIGO FROM DD_BD_CHAVE_PRIMARIA '+
    'WHERE DDBDCP_CAMPO_APELIDO=:DDBDCP_CAMPO_APELIDO ');
  objQuery.FDQuery.ParamByName('DDBDCP_CAMPO_APELIDO').AsString := pCampoApelido;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty then
    result := false
  else
    result := true;

end;

function TInserirCampos.verificaSeChavePrimariaNaoEstaInseridoNaTela(
  pCodigoMenu, pTipoTela: string): boolean;
begin
  if pTipoTela = 'C' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDBDCP.DDBDCP_CAMPO_APELIDO FROM DD_MENU DDM '+
      'INNER JOIN DD_GROUPBOX DDGB ON                '+
      'DDM.DDM_CODIGO = DDGB.DDM_CODIGO              '+
      'INNER JOIN DD_TELA_CAMPO DDTC ON              '+
      'DDTC.DDGB_CODIGO = DDGB.DDGB_CODIGO           '+
      'INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON     '+
      'DDTC.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO     '+
      'WHERE DDM.DDM_CODIGO=:DDM_CODIGO');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.Open();
  end
  else if pTipoTela = 'P' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDBDCP.DDBDCP_CAMPO_APELIDO FROM DD_MENU DDM '+
      'INNER JOIN DD_TELA_CAMPO_PESQUISA DDTCP ON    '+
      'DDTCP.DDM_CODIGO = DDM.DDM_CODIGO             '+
      'INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON     '+
      'DDTCP.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO     '+
      'WHERE DDM.DDM_CODIGO=:DDM_CODIGO');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.Open();
  end;

  if objQuery.FDQuery.IsEmpty then
    result := true
  else
    result := false;

end;

end.
