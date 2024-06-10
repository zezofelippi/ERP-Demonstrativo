unit uComponenteDBGrid;

interface

uses uFDquery, System.SysUtils;

type TComponenteDBGrid = class
  private
    codigoCampo, codigoChavePrimaria: string;
    function pesquisarCodigoCampoOuCodigoChavePrimaria(
      pCodigoTabela, pCodigoTela, pNomeCampo: string): string;
  public
    objQuery: TUFDQuery;
    constructor create;
    procedure pesquisarColunas(pCodigoMenu: string);
    function cadastrarCampoNoDBGrid(pCodigoCampo, pCodigoTabela,
      pCodigoMenu, pTipoCampo: string; pTamanho: integer;
      pChaveEstrangeira: boolean):string;
    function pegarCaptionDoCampo(pCodigoCampo: string): string;
    function pegarCaptionDaChavePrimaria(pCodigoCampo: string): string;
    function excluirColuna(pIndexColuna, pCodigoMenu: string): string;
    function alterarTamanhoDasColunasDBGrid(pCodigoMenu,
      pCodigoTabela, pNomeCampo: string; tamanhoColuna: integer): string;
    function alterarPosicaoDasColunasDBGrid(pCodigoMenu,
      pCodigoTabela, pNomeCampo: string; posicaoColuna: integer): string;
end;

implementation

{ TComponenteDBGrid }

function TComponenteDBGrid.alterarPosicaoDasColunasDBGrid(pCodigoMenu,
  pCodigoTabela, pNomeCampo: string; posicaoColuna: integer): string;
begin
  pesquisarCodigoCampoOuCodigoChavePrimaria(pCodigoTabela, pCodigoMenu, pNomeCampo);

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TELA_CAMPO_GRID          ');
    objQuery.FDQuery.SQL.Add(' SET DDTCG_POSICAO=:DDTCG_POSICAO  ');
    objQuery.FDQuery.SQL.Add(' WHERE DDM_CODIGO=:DDM_CODIGO AND  ');
    if codigoCampo <> '' then
      objQuery.FDQuery.SQL.Add(' DDBDC_CODIGO=:DDBDC_CODIGO      ')
    else
      objQuery.FDQuery.SQL.Add(' DDBDCP_CODIGO=:DDBDCP_CODIGO    ');

    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
    if codigoCampo <> '' then
      objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString:= codigoCampo
    else
      objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString:= codigoChavePrimaria;

    objQuery.FDQuery.ParamByName('DDTCG_POSICAO').AsInteger:= posicaoColuna;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;
end;

function TComponenteDBGrid.alterarTamanhoDasColunasDBGrid(
  pCodigoMenu, pCodigoTabela, pNomeCampo: string; tamanhoColuna: integer): string;
begin
  pesquisarCodigoCampoOuCodigoChavePrimaria(pCodigoTabela, pCodigoMenu, pNomeCampo);

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TELA_CAMPO_GRID          ');
    objQuery.FDQuery.SQL.Add(' SET DDTCG_TAMANHO=:DDTCG_TAMANHO  ');
    objQuery.FDQuery.SQL.Add(' WHERE DDM_CODIGO=:DDM_CODIGO AND  ');
    if codigoCampo <> '' then
      objQuery.FDQuery.SQL.Add(' DDBDC_CODIGO=:DDBDC_CODIGO      ')
    else
      objQuery.FDQuery.SQL.Add(' DDBDCP_CODIGO=:DDBDCP_CODIGO    ');

    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
    if codigoCampo <> '' then
      objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString:= codigoCampo
    else
      objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString:= codigoChavePrimaria;

    objQuery.FDQuery.ParamByName('DDTCG_TAMANHO').AsInteger:= tamanhoColuna;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;

end;

function TComponenteDBGrid.cadastrarCampoNoDBGrid(pCodigoCampo, pCodigoTabela,
  pCodigoMenu, pTipoCampo: string;
  pTamanho: integer; pChaveEstrangeira: boolean): string;
var
  ultimaPosicao: integer;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT MAX(DDTCG_POSICAO) AS ULTIMA_POSICAO '+
    ' FROM DD_TELA_CAMPO_GRID WHERE DDM_CODIGO=:DDM_CODIGO ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
  objQuery.FDQuery.Open();

  ultimaPosicao := objQuery.FDQuery.FieldByName('ULTIMA_POSICAO').AsInteger;

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO_GRID ');
    if pTipoCampo = 'C' then
      objQuery.FDQuery.SQL.Add('(DDBDC_CODIGO,  ')
    else if pTipoCampo = 'CP' then
      objQuery.FDQuery.SQL.Add('(DDBDCP_CODIGO,  ');
    if pChaveEstrangeira = true then
      objQuery.FDQuery.SQL.Add(' DDBDT_CODIGO,  ');
    objQuery.FDQuery.SQL.Add('DDM_CODIGO, DDTCG_TAMANHO, DDTCG_POSICAO) ');
    objQuery.FDQuery.SQL.Add('VALUES ');
    if pTipoCampo = 'C' then
      objQuery.FDQuery.SQL.Add('(:DDBDC_CODIGO, ')
    else if pTipoCampo = 'CP' then
      objQuery.FDQuery.SQL.Add('(:DDBDCP_CODIGO, ');
    if pChaveEstrangeira = true then
      objQuery.FDQuery.SQL.Add(' :DDBDT_CODIGO,  ');
    objQuery.FDQuery.SQL.Add(':DDM_CODIGO, :DDTCG_TAMANHO, :DDTCG_POSICAO)');
    if pTipoCampo = 'C' then
      objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo
    else if pTipoCampo = 'CP' then
      objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;

    if pChaveEstrangeira = true then
      objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabela;

    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDTCG_TAMANHO').AsInteger := pTamanho;
    objQuery.FDQuery.ParamByName('DDTCG_POSICAO').AsInteger := ultimaPosicao +1;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;
end;

constructor TComponenteDBGrid.create;
begin
  objQuery:= TUFDQuery.GetInstancia;
end;

function TComponenteDBGrid.excluirColuna(pIndexColuna,
  pCodigoMenu: string): string;
var
  i: integer;
  codigoColuna: string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTCG_CODIGO FROM DD_TELA_CAMPO_GRID '+
    'WHERE DDM_CODIGO=:DDM_CODIGO');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
  objQuery.FDQuery.Open();
  objQuery.FDQuery.First;
  i:= 0;
  while i<= strtoint(pIndexColuna) do
  begin
    codigoColuna:= objQuery.FDQuery.FieldByName('DDTCG_CODIGO').AsString;
    objQuery.FDQuery.Next;
    i:=i+1;
  end;

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_TELA_CAMPO_GRID '+
      'WHERE DDTCG_CODIGO=:DDTCG_CODIGO');
    objQuery.FDQuery.ParamByName('DDTCG_CODIGO').AsString := codigoColuna;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;

end;

function TComponenteDBGrid.pegarCaptionDaChavePrimaria(
  pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CAMPO_APELIDO '+
    'FROM DD_BD_CHAVE_PRIMARIA                    '+
    'WHERE DDBDCP_CODIGO=:DDBDCP_CODIGO    ');
  objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString :=pCodigoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_APELIDO').AsString;
end;

function TComponenteDBGrid.pegarCaptionDoCampo(pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC_CAMPO_APELIDO '+
    'FROM DD_BD_CAMPO                    '+
    'WHERE DDBDC_CODIGO=:DDBDC_CODIGO    ');
  objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString :=pCodigoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDC_CAMPO_APELIDO').AsString;

end;

function TComponenteDBGrid.pesquisarCodigoCampoOuCodigoChavePrimaria(
  pCodigoTabela, pCodigoTela, pNomeCampo: string): string;
var
  vetor:array[0..20] of string;
  i, i_aux: integer;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC_CODIGO FROM DD_BD_CAMPO  '+
    'WHERE DDBDC_CAMPO_FISICO=:DDBDC_CAMPO_FISICO AND DDBDT_CODIGO=:DDBDT_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDC_CAMPO_FISICO').AsString:= pNomeCampo;
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString:= pCodigoTabela;
  objQuery.FDQuery.Open();

  codigoCampo:= objQuery.FDQuery.FieldByName('DDBDC_CODIGO').AsString;
  codigoChavePrimaria:= '';

  if objQuery.FDQuery.IsEmpty = true then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CODIGO FROM DD_BD_CHAVE_PRIMARIA  '+
      'WHERE DDBDCP_CAMPO_FISICO=:DDBDCP_CAMPO_FISICO AND DDBDT_CODIGO=:DDBDT_CODIGO ');
    objQuery.FDQuery.ParamByName('DDBDCP_CAMPO_FISICO').AsString:= pNomeCampo;
    objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString:= pCodigoTabela;
    objQuery.FDQuery.Open();

    codigoChavePrimaria:= objQuery.FDQuery.FieldByName('DDBDCP_CODIGO').AsString;
    codigoCampo:= '';
  end;

  if objQuery.FDQuery.IsEmpty = true then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDBDT_CODIGO '+
      'FROM DD_TELA_CAMPO_GRID                                  '+
      'WHERE DDM_CODIGO=:DDM_CODIGO AND DDBDT_CODIGO IS NOT NULL ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoTela;
    objQuery.FDQuery.open();
    objQuery.FDQuery.First;

    i:=0;
    while not objQuery.FDQuery.Eof do
    begin
      vetor[i]:= objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString;
      objQuery.FDQuery.Next;
      i:=i+1;
    end;

    i_aux:=0;
    while i_aux <= i do
    begin
      objQuery.FDQuery.Close;
      objQuery.FDQuery.SQL.Clear;
      objQuery.FDQuery.SQL.Add('SELECT DDBDC_CODIGO, DDBDC_CAMPO_FISICO '+
        'FROM DD_BD_CAMPO                                               '+
        'WHERE DDBDC_CAMPO_FISICO=:DDBDC_CAMPO_FISICO '+
        'AND DDBDT_CODIGO =:DDBDT_CODIGO');
      objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString:= vetor[i_aux];
      objQuery.FDQuery.ParamByName('DDBDC_CAMPO_FISICO').AsString:= pNomeCampo;
      objQuery.FDQuery.Open();

      if not objQuery.FDQuery.IsEmpty then
      begin
         codigoCampo:= objQuery.FDQuery.FieldByName('DDBDC_CODIGO').AsString;
         codigoChavePrimaria:= '';
         break;
      end;
      i_aux:=i_aux +1;
    end;


  end;

end;

procedure TComponenteDBGrid.pesquisarColunas(pCodigoMenu: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTCG_CODIGO, DDM_CODIGO,   '+
     'DDTCG_TAMANHO, DDTCG_POSICAO,                                          '+
     'DDBDC.DDBDC_CAMPO_APELIDO AS CAMPO_APELIDO, '+
     'DDBDC.DDBDC_CAMPO_FISICO AS CAMPO_FISICO, DDBDC.DDBDT_CODIGO,          '+
     'DDBDFC.DDBDFC_FORMATO_FISICO, DDBDFC_TIPO, DDBDFC_DESCRICAO_CAMPO,     '+
     'DDBDFC_TAMANHO, DDBDT.DDBDT_TABELA_FISICA AS TABELA_FISICA             '+
     'FROM DD_TELA_CAMPO_GRID DDTCG                                          '+
     'INNER JOIN DD_BD_CAMPO DDBDC ON                                        '+
     'DDTCG.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO                                '+
     'INNER JOIN DD_BD_FORMATO_CAMPO DDBDFC ON                               '+
     'DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO                             '+
     'INNER JOIN DD_BD_TABELAS DDBDT ON                                      '+
     'DDBDC.DDBDT_CODIGO = DDBDT.DDBDT_CODIGO                                '+
     'WHERE DDM_CODIGO=:DDM_CODIGO      '+
     'union                             '+
     'SELECT DDTCG_CODIGO, DDM_CODIGO,                         '+
     'DDTCG_TAMANHO, DDTCG_POSICAO, DDBDCP.DDBDCP_CAMPO_APELIDO AS CAMPO_APELIDO, '+
     'DDBDCP.DDBDCP_CAMPO_FISICO AS CAMPO_FISICO, DDBDCP.DDBDT_CODIGO, '+
     ' '''', '''', '''', 0, DDBDT.DDBDT_TABELA_FISICA AS TABELA_FISICA '+
     'FROM DD_TELA_CAMPO_GRID DDTCG                                        '+
     'INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON                             '+
     'DDTCG.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO                             '+
     'INNER JOIN DD_BD_TABELAS DDBDT ON                                '+
     'DDBDCP.DDBDT_CODIGO = DDBDT.DDBDT_CODIGO                         '+
     'WHERE DDM_CODIGO=:DDM_CODIGO ORDER BY 4');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  objQuery.FDQuery.Open();
end;

end.
