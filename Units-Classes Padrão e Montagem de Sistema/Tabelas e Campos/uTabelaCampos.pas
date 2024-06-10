unit uTabelaCampos;

interface

uses uFDQuery, Vcl.Forms, System.StrUtils, Vcl.Dialogs, windows,
Datasnap.Provider, Datasnap.DBClient, Data.DB;

type TTabelaCampos = class
  private
    function pegarCodigoDaTabelaCriada(pTabelaFisica: string): string;
  public
    objQuery : TUFDQuery;
    constructor create;
    procedure cadastrarTabela(pTabelaFisica, pTabelaApelido: string);
    procedure cadastrarChavePrimaria(pTabelaFisica,
      pCampoFisico, pCampoApelido: string);
    procedure cadastrarChaveEstrangeira(pCodTabela, pCodTabelaEstrangeira, pRequerido: string);
    procedure cadastrarCampo(pTabelaFisica, pCodFormatoCampo, pCampoFisico,
      pCampoApelido, pDescricaoCampo, pObrigatorio: string);
    procedure criarTabelaComChavePrimaria(pTabelaFisica,pCampoFisico:string);
    procedure criarChaveEstrangeira(pTabelaFisica, pTabelaRelacionada: string);
    procedure criarCampo(pTabelaFisica, pCampoFisico, pTipoCampo,
      pTamanho, pObrigatorio: string);
    procedure mostrarTabelas;
    procedure mostrarTabelasRelacionadas(pCodTabela : string);
    procedure mostrarTabelasQueSeraoRelacionadas(pCodTabela : string);
    procedure mostrarFormatoDosCampos;
    procedure mostrarCampos(pCodTabela, pCampoOrdenacao: string);
    procedure mostrarCamposNaArvore(pCodTabela, pCodigoMenu, pTipoTela: string);
    procedure mostrarChaveEstrangeiraNaArvore(pCodTabela: string);
    procedure mostrarTabelaPrincipalComoChaveEstrangeiraDeOutraTabela(pCodTabela: string);
    function capturarIdChavePrimaria(pCodTabela: string): string;
    function capturarCampoChavePrimaria(pCodTabela: string): string;
    function capturarTipoCampo(pCodTipoCampo: string): string;
    function capturarTamanhoCampo(pCodTipoCampo: string): string;
    function captutarNomeDaTabela(pCodigoTabela: string): string;
    function alterarCadastroDoCampo(pTabelaFisica, pCodCampo, pCampoFisico,
      pCampoApelido, pDescricaoCampo: string): string;
    function alterarCampoFisico(pTabelaFisica, pCampoFisicoAntigo, pCampoFisicoNovo,
       pTipoCampo, pTamanho: string): string;
    function verificarSeCampoContemRegistro(pNomeCampo, pNomeTabela:string): boolean;
    function excluirCampo(pNomeTabela, pNomeCampo, pCodigoCampo:string): string;
    function pegarCodigoDaTabela(pTabelaApelido: string): string;
    function capturarNomeFisicoDaTabela(pCodigoTabela: string): string;
    function pegarCodigoDaTabelaComNomeDaChavePrimaria(pNomeFisicoChavePrimaria: string):string;
end;


implementation


{ TTabelaCampos }

function TTabelaCampos.alterarCadastroDoCampo(pTabelaFisica, pCodCampo, pCampoFisico,
  pCampoApelido, pDescricaoCampo: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_BD_CAMPO SET  '+
      ' DDBDC_CAMPO_FISICO=:DDBDC_CAMPO_FISICO,   '+
      ' DDBDC_CAMPO_APELIDO=:DDBDC_CAMPO_APELIDO, '+
      ' DDBDC_DESCRICAO_CAMPO=:DDBDC_DESCRICAO_CAMPO '+
      ' WHERE DDBDC_CODIGO=:DDBDC_CODIGO');
    objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodCampo;
    objQuery.FDQuery.ParamByName('DDBDC_CAMPO_FISICO').AsString := pCampoFisico + '_' + pTabelaFisica;
    objQuery.FDQuery.ParamByName('DDBDC_CAMPO_APELIDO').AsString := pCampoApelido;
    objQuery.FDQuery.ParamByName('DDBDC_DESCRICAO_CAMPO').AsString := pDescricaoCampo;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;
end;

function TTabelaCampos.alterarCampoFisico(pTabelaFisica, pCampoFisicoAntigo,
  pCampoFisicoNovo, pTipoCampo, pTamanho: string): string;
var
  codTabela: string;
begin
  try
    codTabela := pegarCodigoDaTabelaCriada(pTabelaFisica);
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('ALTER TABLE ' + pTabelaFisica);
    objQuery.FDQuery.SQL.Add(' CHANGE COLUMN ' + pCampoFisicoAntigo + ' ' +
    pCampoFisicoNovo + '_' + pTabelaFisica + ' ' + pTipoCampo + '(' + pTamanho + ')' );

    objQuery.FDQuery.ExecSQL;
  except
    result:='Erro';
  end;
end;

procedure TTabelaCampos.cadastrarCampo(pTabelaFisica, pCodFormatoCampo,
  pCampoFisico, pCampoApelido, pDescricaoCampo, pObrigatorio: string);
var
  codTabela: string;
begin
  codTabela:= pegarCodigoDaTabelaCriada(pTabelaFisica);
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_BD_CAMPO   '+
      '(DDBDT_CODIGO, DDBDFC_CODIGO, DDBDC_CAMPO_FISICO, '+
      'DDBDC_CAMPO_APELIDO, DDBDC_DESCRICAO_CAMPO, DDBDC_REQUERIDO) '+
      'VALUES                                                     '+
      '(:DDBDT_CODIGO, :DDBDFC_CODIGO, :DDBDC_CAMPO_FISICO,        '+
      ':DDBDC_CAMPO_APELIDO, :DDBDC_DESCRICAO_CAMPO, :DDBDC_REQUERIDO)');
    objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := codTabela;
    objQuery.FDQuery.ParamByName('DDBDFC_CODIGO').AsString := pCodFormatoCampo;
    objQuery.FDQuery.ParamByName('DDBDC_CAMPO_FISICO').AsString := pCampoFisico + '_' + pTabelaFisica;
    objQuery.FDQuery.ParamByName('DDBDC_CAMPO_APELIDO').AsString := pCampoApelido;
    objQuery.FDQuery.ParamByName('DDBDC_DESCRICAO_CAMPO').AsString := pDescricaoCampo;
    objQuery.FDQuery.ParamByName('DDBDC_REQUERIDO').AsString := pObrigatorio;
    objQuery.FDQuery.ExecSQL;
  except
    Application.MessageBox(Pchar('Erro no cadastro dos campos na '+
      'tabela DD_BD_CAMPO'),
      'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;
end;

procedure TTabelaCampos.cadastrarChaveEstrangeira(pCodTabela,
  pCodTabelaEstrangeira, pRequerido: string);
var
  chavePrimaria : string;
begin
  chavePrimaria:= capturarIdChavePrimaria(pCodTabelaEstrangeira);

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_BD_CHAVE_ESTRANGEIRA '+
      '(DDBDCP_CODIGO, DDBDT_CODIGO, DDBDCE_REQUERIDO)            '+
      'values                                                     '+
      '(:DDBDCP_CODIGO, :DDBDT_CODIGO, :DDBDCE_REQUERIDO)         ');
    objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := chavePrimaria;
    objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodTabela;
    objQuery.FDQuery.ParamByName('DDBDCE_REQUERIDO').AsString := pRequerido;

    objQuery.FDQuery.ExecSQL;
  except
    Application.MessageBox(Pchar('Erro na gravação dos dados na '+
      'tabela DD_BD_CHAVE_ESTRANGEIRA'),
      'Informação!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;

end;

procedure TTabelaCampos.cadastrarChavePrimaria(pTabelaFisica,
  pCampoFisico, pCampoApelido: string);
var
  codTabela: string;
begin
  codTabela := pegarCodigoDaTabelaCriada(pTabelaFisica);
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_BD_CHAVE_PRIMARIA   '+
      '(DDBDT_CODIGO, DDBDCP_CAMPO_FISICO, DDBDCP_CAMPO_APELIDO) '+
      'values                                                    '+
      '(:DDBDT_CODIGO, :DDBDCP_CAMPO_FISICO, :DDBDCP_CAMPO_APELIDO) ');
    objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := codTabela;
    objQuery.FDQuery.ParamByName('DDBDCP_CAMPO_FISICO').AsString := pCampoFisico
      + '_' + pTabelaFisica;
    objQuery.FDQuery.ParamByName('DDBDCP_CAMPO_APELIDO').AsString := pCampoApelido;
    objQuery.FDQuery.ExecSQL;
  except
    Application.MessageBox(Pchar('Erro na criação '+
      'da chave primária.'),
      'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;

end;

procedure TTabelaCampos.cadastrarTabela(pTabelaFisica, pTabelaApelido: string);
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_BD_TABELAS '+
      '(DDBDT_TABELA_FISICA, DDBDT_TABELA_APELIDO)              '+
      'values                                                   '+
      '(:DDBDT_TABELA_FISICA, :DDBDT_TABELA_APELIDO)            ');
    objQuery.FDQuery.ParamByName('DDBDT_TABELA_FISICA').AsString := pTabelaFisica;
    objQuery.FDQuery.ParamByName('DDBDT_TABELA_APELIDO').AsString := pTabelaApelido;
    objQuery.FDQuery.ExecSQL;
  except
    Application.MessageBox(Pchar('Erro na gravação dos dados, '+
      'verifique se já se existe uma tabela com este nome.'),
      'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
    Exit;
  end;

  pegarCodigoDaTabelaCriada(pTabelaFisica);

end;

function TTabelaCampos.capturarCampoChavePrimaria(pCodTabela: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CAMPO_FISICO '+
    ' FROM DD_BD_CHAVE_PRIMARIA        '+
    ' WHERE DDBDT_CODIGO=:DDBDT_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodTabela;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_FISICO').AsString;
end;

function TTabelaCampos.capturarIdChavePrimaria(pCodTabela: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CODIGO '+
    ' FROM DD_BD_CHAVE_PRIMARIA        '+
    ' WHERE DDBDT_CODIGO=:DDBDT_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodTabela;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDCP_CODIGO').AsString;

end;

function TTabelaCampos.capturarNomeFisicoDaTabela(
  pCodigoTabela: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_TABELA_FISICA '+
    ' FROM DD_BD_TABELAS                                '+
    ' WHERE DDBDT_CODIGO=:DDBDT_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabela;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDT_TABELA_FISICA').AsString;
end;

function TTabelaCampos.capturarTamanhoCampo(pCodTipoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDFC_TAMANHO '+
    ' FROM DD_BD_FORMATO_CAMPO                   '+
    ' WHERE DDBDFC_CODIGO=:DDBDFC_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDFC_CODIGO').AsString := pCodTipoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDFC_TAMANHO').AsString;
end;

function TTabelaCampos.capturarTipoCampo(pCodTipoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDFC_TIPO '+
    ' FROM DD_BD_FORMATO_CAMPO                   '+
    ' WHERE DDBDFC_CODIGO=:DDBDFC_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDFC_CODIGO').AsString := pCodTipoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDFC_TIPO').AsString;

end;

function TTabelaCampos.captutarNomeDaTabela(pCodigoTabela: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_TABELA_APELIDO '+
    ' FROM DD_BD_TABELAS                                '+
    ' WHERE DDBDT_CODIGO=:DDBDT_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabela;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDT_TABELA_APELIDO').AsString;
end;

constructor TTabelaCampos.create;
begin
  objQuery := TUFDQuery.GetInstancia;
end;

procedure TTabelaCampos.criarCampo(pTabelaFisica, pCampoFisico, pTipoCampo,
  pTamanho, pObrigatorio: string);
var
  codTabela: string;
begin
  try
    codTabela := pegarCodigoDaTabelaCriada(pTabelaFisica);
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('ALTER TABLE ' + pTabelaFisica);
    objQuery.FDQuery.SQL.Add(' ADD COLUMN ' + pCampoFisico + '_' + pTabelaFisica + ' ' + pTipoCampo);
    if (pTipoCampo <> 'DOUBLE') AND (pTipoCampo <> 'TIMESTAMP') then
      objQuery.FDQuery.SQL.Add(' (' + pTamanho + ')');
    if pObrigatorio = 'S' then
    begin
      if pTipoCampo <> 'TIMESTAMP' then
        objQuery.FDQuery.SQL.Add(' NOT NULL')
      else
        objQuery.FDQuery.SQL.Add(' NOT NULL');
    end
    else
      if pTipoCampo = 'TIMESTAMP' then
        objQuery.FDQuery.SQL.Add(' DEFAULT ''0000-00-00 00:00:00'' ');

    objQuery.FDQuery.ExecSQL;
  except
    Application.MessageBox(Pchar('Erro na criação do campo. '),
      'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;
end;

procedure TTabelaCampos.criarChaveEstrangeira(
  pTabelaFisica, pTabelaRelacionada: string);
var
  codTabelaRelacionada, campoChaveEstrangeira: string;
begin
  codTabelaRelacionada :=  pegarCodigoDaTabelaCriada(pTabelaRelacionada);
  campoChaveEstrangeira := capturarCampoChavePrimaria(codTabelaRelacionada);

  {Primeiro cria o campo}
   try
     objQuery.FDQuery.Close;
     objQuery.FDQuery.SQL.Clear;
     objQuery.FDQuery.SQL.Add('ALTER TABLE ' + pTabelaFisica);
     objQuery.FDQuery.SQL.Add(' ADD COLUMN ' + campoChaveEstrangeira + ' INT');
     objQuery.FDQuery.ExecSQL;
   except
     Application.MessageBox(Pchar('Erro na criação do campo para chave estrangeira '),
       'Informação!', MB_OK+MB_ICONERROR + MB_TOPMOST);
     exit;
   end;
  {FIM}

  {Depois transforma em chave estrangeira}
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('ALTER TABLE ' + pTabelaFisica +
      ' ADD FOREIGN KEY (' + campoChaveEstrangeira + ')'+
      ' REFERENCES '+ pTabelaRelacionada +
      ' (' + campoChaveEstrangeira +  ')');
    objQuery.FDQuery.ExecSQL;
  except
    Application.MessageBox(Pchar('Erro na transformação do campo em chave estrangeira '),
      'Informação!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;
  {FIM}

end;

procedure TTabelaCampos.criarTabelaComChavePrimaria(pTabelaFisica, pCampoFisico: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('create table ' +
      pTabelaFisica +' (');
  objQuery.FDQuery.Sql.Add(pCampoFisico + '_' + pTabelaFisica +
  ' integer not null AUTO_INCREMENT, PRIMARY KEY ( '+pCampoFisico + '_' + pTabelaFisica +')) ');
  objQuery.FDQuery.ExecSQL;
end;

function TTabelaCampos.excluirCampo(pNomeTabela, pNomeCampo,
  pCodigoCampo:string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_BD_CAMPO '+
      ' WHERE DDBDC_CODIGO=:DDBDC_CODIGO');
    objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString:= pCodigoCampo;
    objQuery.FDQuery.ExecSQL;
  except
    result:='Erro';
    exit;
  end;

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('ALTER TABLE '+ pNomeTabela +
      ' DROP COLUMN ' + pNomeCampo);
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;
end;

procedure TTabelaCampos.mostrarCampos(pCodTabela, pCampoOrdenacao: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CODIGO AS CODIGO, DDBDCP_CAMPO_APELIDO AS CAMPO_APELIDO, ');
  objQuery.FDQuery.SQL.Add('DDBDCP_CAMPO_FISICO AS CAMPO_FISICO,          ');
  objQuery.FDQuery.SQL.Add(' ''Chave Primária'' AS DESCRICAO_CAMPO,'''' AS DESCRICAO_CAMPO_FORMATO,       ');
  objQuery.FDQuery.SQL.Add(' ''INTEGER'' AS TIPO, '''' AS CODIGO_TIPO, '''' AS TAMANHO, '''' AS CASA_DECIMAL, '''' AS REQUERIDO ');
  objQuery.FDQuery.SQL.Add('FROM DD_BD_CHAVE_PRIMARIA DDBDCP INNER JOIN ');
  objQuery.FDQuery.SQL.Add('DD_BD_TABELAS DDBDT ON                      ');
  objQuery.FDQuery.SQL.Add('DDBDT.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO    ');
  objQuery.FDQuery.SQL.Add('WHERE DDBDT.DDBDT_CODIGO=:DDBDT_CODIGO      ');
  objQuery.FDQuery.SQL.Add('UNION                                       ');
  objQuery.FDQuery.SQL.Add('SELECT DDBDC_CODIGO AS CODIGO, DDBDC_CAMPO_APELIDO AS CAMPO_APELIDO, ');
  objQuery.FDQuery.SQL.Add('DDBDC_CAMPO_FISICO AS CAMPO_FISICO,          ');
  objQuery.FDQuery.SQL.Add('DDBDC_DESCRICAO_CAMPO AS DESCRICAO_CAMPO,    ');
  objQuery.FDQuery.SQL.Add('DDBDFC_DESCRICAO_CAMPO AS DESCRICAO_CAMPO_FORMATO, ');
  objQuery.FDQuery.SQL.Add('DDBDFC_TIPO AS TIPO, DDBDFC.DDBDFC_CODIGO AS CODIGO_TIPO, DDBDFC_TAMANHO AS TAMANHO,    ');
  objQuery.FDQuery.SQL.Add('DDBDFC_CASA_DECIMAL AS CASA_DECIMAL, DDBDC_REQUERIDO AS REQUERIDO ');
  objQuery.FDQuery.SQL.Add('FROM DD_BD_CAMPO DDBDC INNER JOIN                      ');
  objQuery.FDQuery.SQL.Add('DD_BD_FORMATO_CAMPO DDBDFC ON                          ');
  objQuery.FDQuery.SQL.Add('DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO             ');
  objQuery.FDQuery.SQL.Add('WHERE DDBDT_CODIGO=:DDBDT_CODIGO                       ');
  if pCampoOrdenacao = '' then
    objQuery.FDQuery.SQL.Add('ORDER BY 5, 1             ')
  else
    objQuery.FDQuery.SQL.Add('ORDER BY ' + pCampoOrdenacao );

  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodTabela;
  objQuery.FDQuery.Open();

end;

procedure TTabelaCampos.mostrarCamposNaArvore(pCodTabela,
  pCodigoMenu, pTipoTela: string);
begin

  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT                            ');
  objQuery.FDQuery.SQL.Add('DDBDT.DDBDT_TABELA_APELIDO, DDBDC.DDBDC_CODIGO, DDBDC.DDBDC_CAMPO_APELIDO, ');
  objQuery.FDQuery.SQL.Add('DDBDCP.DDBDCP_CODIGO, DDBDCP.DDBDCP_CAMPO_APELIDO      ');
  objQuery.FDQuery.SQL.Add('FROM DD_BD_TABELAS DDBDT INNER JOIN                    ');
  objQuery.FDQuery.SQL.Add('DD_BD_CHAVE_PRIMARIA DDBDCP ON                         ');
  objQuery.FDQuery.SQL.Add('DDBDT.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO               ');
  objQuery.FDQuery.SQL.Add('LEFT JOIN DD_BD_CAMPO DDBDC ON                         ');
  objQuery.FDQuery.SQL.Add('DDBDT.DDBDT_CODIGO = DDBDC.DDBDT_CODIGO                ');
  objQuery.FDQuery.SQL.Add('WHERE DDBDT.DDBDT_CODIGO =:DDBDT_CODIGO                ');
  if (pCodigoMenu <> '') and (pTipoTela = 'C') then
  begin
    objQuery.FDQuery.SQL.Add('AND DDBDC_CODIGO NOT IN (SELECT DDBDC_CODIGO FROM DD_TELA_CAMPO DDTC ');
    objQuery.FDQuery.SQL.Add('INNER JOIN DD_GROUPBOX DDGB ON   ');
    objQuery.FDQuery.SQL.Add('DDTC.DDGB_CODIGO = DDGB.DDGB_CODIGO ');
    objQuery.FDQuery.SQL.Add('WHERE DDGB.DDM_CODIGO=:DDM_CODIGO AND DDBDC_CODIGO IS NOT NULL) ');
    objQuery.FDQuery.SQL.Add('AND DDBDC_CODIGO NOT IN (SELECT DDBDC_CODIGO FROM DD_COMBOBOX ');
    objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO AND DDBDC_CODIGO IS NOT NULL) ');

  end
  else if (pCodigoMenu <> '') and (pTipoTela = 'P') then
  begin
    objQuery.FDQuery.SQL.Add('AND DDBDC_CODIGO NOT IN (SELECT DDBDC_CODIGO FROM DD_TELA_CAMPO_PESQUISA ');
    objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO AND DDBDC_CODIGO IS NOT NULL) ');
    objQuery.FDQuery.SQL.Add('AND DDBDC_CODIGO NOT IN (SELECT DDBDC_CODIGO FROM DD_PESQUISA_ENTRE_DATAS ');
    objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO AND DDBDC_CODIGO IS NOT NULL) ');
    objQuery.FDQuery.SQL.Add('AND DDBDC_CODIGO NOT IN (SELECT DDBDC_CODIGO FROM DD_COMBOBOX ');
    objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO AND DDBDC_CODIGO IS NOT NULL) ');

    {Aqui é p/ NÃO mostrar campos do tipo Double}
    objQuery.FDQuery.SQL.Add('AND DDBDC_CODIGO NOT IN (SELECT DDBDC_CODIGO FROM DD_BD_CAMPO DDBDC ');
    objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_FORMATO_CAMPO DDBDFC ON DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO ');
    objQuery.FDQuery.SQL.Add('WHERE DDBDFC_TIPO = ''DOUBLE'' ) ');
    {fim}
  end
  else if (pCodigoMenu <> '') and (pTipoTela = 'G') then
  begin
    objQuery.FDQuery.SQL.Add('AND DDBDC_CODIGO NOT IN (SELECT DDBDC_CODIGO FROM DD_TELA_CAMPO_GRID ');
    objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO AND DDBDC_CODIGO IS NOT NULL) ');
  end;

  objQuery.FDQuery.SQL.Add('ORDER BY DDBDC.DDBDC_CAMPO_APELIDO      ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodTabela;
  if pCodigoMenu <> '' then
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  objQuery.FDQuery.open;

end;

procedure TTabelaCampos.mostrarChaveEstrangeiraNaArvore(pCodTabela: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP.DDBDCP_CAMPO_APELIDO, '+
    'DDBDT.DDBDT_TABELA_APELIDO, DDBDT.DDBDT_CODIGO              '+
    'FROM DD_BD_CHAVE_ESTRANGEIRA DDBDCE                         '+
    '  INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON                 '+
    '  DDBDCE.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO               '+
    '  INNER JOIN DD_BD_TABELAS DDBDT ON                         '+
    '  DDBDCP.DDBDT_CODIGO = DDBDT.DDBDT_CODIGO                  '+
    '  WHERE DDBDCE.DDBDT_CODIGO=:DDBDT_CODIGO');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodTabela;
  objQuery.FDQuery.Open();
end;

procedure TTabelaCampos.mostrarFormatoDosCampos;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDFC_CODIGO, DDBDFC_DESCRICAO_CAMPO '+
    ' FROM DD_BD_FORMATO_CAMPO  '+
    ' ORDER BY DDBDFC_DESCRICAO_CAMPO');
  objQuery.FDQuery.Open();

end;

procedure TTabelaCampos.mostrarTabelaPrincipalComoChaveEstrangeiraDeOutraTabela(
  pCodTabela: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCE.DDBDCP_CODIGO, DDBDCE.DDBDT_CODIGO, '+
    'DDBDT.DDBDT_TABELA_APELIDO AS TABELA_ESTRANGEIRA,                        '+
    'DDBDCP.DDBDCP_CAMPO_APELIDO AS CHAVE_ESTRANGEIRA,                        '+
    'DDBDT2.DDBDT_TABELA_APELIDO AS TABELA_PRINCIPAL,                         '+
    'DDBDCP2.DDBDCP_CAMPO_APELIDO AS CHAVE_PRIMARIA_PRINCIPAL                 '+
    '  FROM DD_BD_TABELAS DDBDT                                               '+
    '  INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON                              '+
    '   DDBDT.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO                              '+
    '  LEFT JOIN  DD_BD_CHAVE_ESTRANGEIRA DDBDCE ON                           '+
    '    DDBDCP.DDBDCP_CODIGO = DDBDCE.DDBDCP_CODIGO                          '+
    '  INNER JOIN DD_BD_TABELAS DDBDT2 ON                                     '+
    '    DDBDCE.DDBDT_CODIGO = DDBDT2.DDBDT_CODIGO                            '+
    '  INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP2 ON                             '+
    '    DDBDT2.DDBDT_CODIGO = DDBDCP2.DDBDT_CODIGO                           '+
    '  WHERE DDBDT.DDBDT_CODIGO=:DDBDT_CODIGO                                 '+
    '  ORDER BY DDBDCE.DDBDT_CODIGO     ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodTabela;
  objQuery.FDQuery.Open();

end;

procedure TTabelaCampos.mostrarTabelas;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_CODIGO, DDBDT_TABELA_APELIDO '+
    ' FROM DD_BD_TABELAS ');
  objQuery.FDQuery.Open;

end;

procedure TTabelaCampos.mostrarTabelasQueSeraoRelacionadas(pCodTabela : string);
var
  cTabelasRelacionadas: string;
begin
  mostrarTabelasRelacionadas(pCodTabela);

  cTabelasRelacionadas:='';
  while not objQuery.FDQuery.Eof do
  begin
    cTabelasRelacionadas := cTabelasRelacionadas +
     ' AND  DDBDT.DDBDT_CODIGO NOT IN ('+ #39 +
      objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString +  #39 +
      ')';
    objQuery.FDQuery.Next;
  end;

  if cTabelasRelacionadas = '' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT                                         '+
      'DDBDT.DDBDT_CODIGO, DDBDT.DDBDT_TABELA_APELIDO                        '+
      'FROM DD_BD_TABELAS DDBDT INNER JOIN                                   '+
      '  DD_BD_CHAVE_PRIMARIA DDBDCP ON                                      '+
      '  DDBDT.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO                            '+
      '  LEFT JOIN                                                           '+
      '  DD_BD_CHAVE_ESTRANGEIRA DDBDCE ON                                   '+
      '  DDBDCP.DDBDCP_CODIGO = DDBDCE.DDBDCP_CODIGO                         '+
      'WHERE DDBDT.DDBDT_CODIGO NOT IN (:DDBDT_CODIGO)                       '+
      'GROUP BY DDBDT.DDBDT_CODIGO');
    objQuery.FDQuery.ParamByName('DDBDT_CODIGO').ASSTRING := pCodTabela;
    objQuery.FDQuery.Open;
    objQuery.FDQuery.FetchAll;
  end
  ELSE
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT                    '+
      'DDBDT.DDBDT_CODIGO, DDBDT.DDBDT_TABELA_APELIDO   '+
      '  FROM DD_BD_TABELAS DDBDT INNER JOIN                                '+
      '    DD_BD_CHAVE_PRIMARIA DDBDCP ON                                   '+
      '    DDBDT.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO                         '+
      '  WHERE DDBDT.DDBDT_CODIGO NOT IN (:DDBDT_CODIGO)' + cTabelasRelacionadas);
    objQuery.FDQuery.ParamByName('DDBDT_CODIGO').ASSTRING := pCodTabela;
    objQuery.FDQuery.Open;
    objQuery.FDQuery.FetchAll
  end;

end;

procedure TTabelaCampos.mostrarTabelasRelacionadas(pCodTabela : string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP.DDBDCP_CODIGO,         '+
      'DDBDT2.DDBDT_CODIGO, DDBDT.DDBDT_TABELA_APELIDO,          '+
      'DDBDCP2.DDBDCP_CAMPO_APELIDO, DDBDCE.DDBDCE_REQUERIDO     '+
      'FROM DD_BD_TABELAS DDBDT INNER JOIN                       '+
      '  DD_BD_CHAVE_PRIMARIA DDBDCP ON                          '+
      '  DDBDT.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO                '+
      '  INNER JOIN DD_BD_CHAVE_ESTRANGEIRA  DDBDCE ON           '+
      '  DDBDCP.DDBDT_CODIGO = DDBDCE.DDBDT_CODIGO INNER JOIN    '+
      '  DD_BD_CHAVE_PRIMARIA DDBDCP2 ON                         '+
      '  DDBDCE.DDBDCP_CODIGO = DDBDCP2.DDBDCP_CODIGO INNER JOIN '+
      '  DD_BD_TABELAS DDBDT2 ON                                 '+
      '  DDBDCP2.DDBDT_CODIGO = DDBDT2.DDBDT_CODIGO              '+
      'WHERE DDBDT.DDBDT_CODIGO=:DDBDT_CODIGO                    '+
      'ORDER BY DDBDT2.DDBDT_TABELA_APELIDO                      ');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodTabela;
  objQuery.FDQuery.Open();
  objQuery.FDQuery.First;

end;

function TTabelaCampos.pegarCodigoDaTabela(pTabelaApelido: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_CODIGO '+
    ' FROM DD_BD_TABELAS '+
    ' WHERE UPPER (DDBDT_TABELA_APELIDO) like UPPER ('+ #39 +
      pTabelaApelido +  #39 +')');
  objQuery.FDQuery.Open;

  result := objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString;
end;

function TTabelaCampos.pegarCodigoDaTabelaComNomeDaChavePrimaria(
  pNomeFisicoChavePrimaria: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_CODIGO FROM DD_BD_CHAVE_PRIMARIA '+
    'WHERE DDBDCP_CAMPO_FISICO=:DDBDCP_CAMPO_FISICO');
  objQuery.FDQuery.ParamByName('DDBDCP_CAMPO_FISICO').AsString:=
    pNomeFisicoChavePrimaria;
  objQuery.FDQuery.Open();
  result:= objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString;
end;

function TTabelaCampos.pegarCodigoDaTabelaCriada(pTabelaFisica: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_CODIGO '+
    ' FROM DD_BD_TABELAS '+
    ' WHERE UPPER (DDBDT_TABELA_FISICA) like UPPER ('+ #39 +
      pTabelaFisica +  #39 +')');
  objQuery.FDQuery.Open;

  result := objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString;

end;

function TTabelaCampos.verificarSeCampoContemRegistro(
  pNomeCampo, pNomeTabela: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT ' + pNomeCampo +
    ' FROM '+ pNomeTabela +
    ' WHERE ' + pNomeCampo + ' IS NOT NULL OR ' + pNomeCampo + ' <> '''' ');
  objQuery.FDQuery.Open;

  if objQuery.FDQuery.IsEmpty then
    result := false
  else
    result := true;

end;

end.
