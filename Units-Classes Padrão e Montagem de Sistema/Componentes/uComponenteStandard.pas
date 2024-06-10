unit uComponenteStandard;

interface

uses uFDquery;

type TComponenteStandard = class

  public
    objQuery: TUFDQuery;
    constructor create;
    procedure pesquisarEdits(pCodigoMenu, pOrdenarCampos: string);
    function alterarTamanhoPosicao(pCodigoDBEdit: string; pLeft, pTop,
      pWidth, pHeight: integer): string;
    function excluirCampo(pCodigoCampo: string): string;

end;

implementation

{ TComponenteStandard }

function TComponenteStandard.alterarTamanhoPosicao(pCodigoDBEdit: string; pLeft,
  pTop, pWidth, pHeight: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TELA_CAMPO_PESQUISA SET '+
      'DDTCP_LEFT=:DDTCP_LEFT, DDTCP_TOP=:DDTCP_TOP, DDTCP_WIDTH=:DDTCP_WIDTH,  '+
      'DDTCP_HEIGHT=:DDTCP_HEIGHT WHERE DDTCP_CODIGO=:DDTCP_CODIGO    ');
    objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString := pCodigoDBEdit;
    objQuery.FDQuery.ParamByName('DDTCP_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDTCP_TOP').AsInteger := pTop;
    objQuery.FDQuery.ParamByName('DDTCP_WIDTH').AsInteger := pWidth;
    objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger := pHeight;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:= 'Sucesso';
end;

constructor TComponenteStandard.create;
begin
  objQuery:= TUFDQuery.GetInstancia;
end;

function TComponenteStandard.excluirCampo(pCodigoCampo: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_TELA_CAMPO_PESQUISA  '+
      ' WHERE DDTCP_CODIGO=:DDTCP_CODIGO');
    objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString := pCodigoCampo;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:='Sucesso';
end;

procedure TComponenteStandard.pesquisarEdits(pCodigoMenu, pOrdenarCampos: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO, DDM_CODIGO,                 ');
  objQuery.FDQuery.SQL.Add('DDTCP_TOP, DDTCP_LEFT,                           ');
  objQuery.FDQuery.SQL.Add('DDTCP_HEIGHT, DDTCP_WIDTH,  ');
  objQuery.FDQuery.SQL.Add('DDBDC.DDBDC_CAMPO_APELIDO AS CAMPO_APELIDO, ');
  objQuery.FDQuery.SQL.Add('DDBDC.DDBDC_CAMPO_FISICO AS CAMPO_FISICO,    ');
  objQuery.FDQuery.SQL.Add('DDBDFC.DDBDFC_FORMATO_FISICO AS FORMATO_FISICO, DDBDFC_TIPO, DDBDFC_DESCRICAO_CAMPO,     ');
  objQuery.FDQuery.SQL.Add('DDBDFC_TAMANHO, 0 AS CODIGO_COMBOBOX         ');
  objQuery.FDQuery.SQL.Add('FROM DD_TELA_CAMPO_PESQUISA DDTCP                                      ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CAMPO DDBDC ON                                        ');
  objQuery.FDQuery.SQL.Add('DDTCP.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO                                ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_FORMATO_CAMPO DDBDFC ON                               ');
  objQuery.FDQuery.SQL.Add('DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO                             ');
  objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO      ');
  objQuery.FDQuery.SQL.Add('UNION                             ');
  objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO, DDM_CODIGO, DDTCP_TOP, DDTCP_LEFT,                ');
  objQuery.FDQuery.SQL.Add('DDTCP_HEIGHT, DDTCP_WIDTH,            ');
  objQuery.FDQuery.SQL.Add('DDBDCP.DDBDCP_CAMPO_APELIDO AS CAMPO_APELIDO, ');
  objQuery.FDQuery.SQL.Add('DDBDCP.DDBDCP_CAMPO_FISICO AS CAMPO_FISICO,   ');
  objQuery.FDQuery.SQL.Add(' '''' AS FORMATO_FISICO, '''', '''', 0, 0 AS CODIGO_COMBOBOX ');
  objQuery.FDQuery.SQL.Add('FROM DD_TELA_CAMPO_PESQUISA DDTCP                                        ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON                             ');
  objQuery.FDQuery.SQL.Add('DDTCP.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO                             ');
  objQuery.FDQuery.SQL.Add('WHERE DDM_CODIGO=:DDM_CODIGO     ');

  if pOrdenarCampos = 'Ordenar' then
  begin
    objQuery.FDQuery.SQL.Add('UNION                             ');
    objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO, '''', DDTCP_TOP, DDTCP_LEFT, ');
    objQuery.FDQuery.SQL.Add('DDTCP_HEIGHT, DDTCP_WIDTH, '''',   ');
    objQuery.FDQuery.SQL.Add('DDBDCP_CAMPO_FISICO AS CAMPO_FISICO, ');
    objQuery.FDQuery.SQL.Add(' '''', '''', '''', 0, DDCB.DDCB_CODIGO AS CODIGO_COMBOBOX ');
    objQuery.FDQuery.SQL.Add('FROM DD_TELA_CAMPO_PESQUISA DDTCP                       ');
    objQuery.FDQuery.SQL.Add('INNER JOIN DD_COMBOBOX DDCB ON                        ');
    objQuery.FDQuery.SQL.Add('DDTCP.DDCB_CODIGO = DDCB.DDCB_CODIGO                   ');
    objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON ');
    objQuery.FDQuery.SQL.Add('DDCB.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO ');
    objQuery.FDQuery.SQL.Add('WHERE DDTCP.DDM_CODIGO=:DDM_CODIGO     ');
  end;

  objQuery.FDQuery.SQL.Add('ORDER BY 3, 4');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  objQuery.FDQuery.Open();
end;

end.
