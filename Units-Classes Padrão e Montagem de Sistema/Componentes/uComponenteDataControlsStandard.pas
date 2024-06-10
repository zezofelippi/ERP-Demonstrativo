unit uComponenteDataControlsStandard;

interface

uses uFDquery;

type TComponenteDataControlsStandard = class
  public
    objQuery: TUFDQuery;
    constructor create;
    procedure pesquisarDBEdits(pCodigoGroupBox, pOrdenarCampos: string);
    procedure pesquisarTabela(pCodigoTabela, pMostrarTodosOsRegistros: string);
    procedure pesquisarComboBoxTela(pCodigoGroupBox, pCodigoComboBoxNaTela: string);
    procedure pesquisarComboBoxTelaPesquisa(pCodigoMenu, pCodigoComboBoxNaTela: string);
    procedure mostrarCodigoChavePrimariaETabela(pCodigoTabela: string);
    procedure sqlComboBox(pSql: string);
    function cadastrarDBEdit(pCodigoCampo, pCodigoGroupBox,
      pTipoCampo, pTipoTela, pCodigoMenu: string;
      pTop, pLeft, pHeight, pWidth: integer):string;
    function cadastrarComboBoxNaTela(pCodigoComboBox, pCodigoGroupBox:string;
      pTop, pLeft, pHeight, pWidth: integer):string;
    function cadastrarComboBoxNaTelaPesquisa(pCodigoComboBox, pCodigoMenu:string;
      pTop, pLeft, pHeight, pWidth: integer):string;
    function pegarCodigoDoCampo(pNomeCampo, pCodigoTabela: string): string;
    function pegarCodigoDaChavePrimaria(pNomeCampo: string): string;
    function pegarCodigoDaChavePrimariaPeloCampoFisico(pNomeCampo: string): string;
    function pegarNomeDoGroupBox(pCodigoCampo: string): string;
    function alterarTamanhoPosicao(pCodigoDBEdit: string; pLeft, pTop,
      pWidth, pHeight: integer): string;
    function alterarTamanhoPosicaoTelaPesquisa(pCodigoComboBoxTela: string; pLeft, pTop,
      pWidth, pHeight: integer): string;
    function pegarCodigoDoDBEdit(pCodigoCampo, pCodigoGroupBox, pTipoTela, pCodigoMenu: string): string;
    function pegarCodigoDoDBEditChavePrimaria(pCodigoCampo,
      pCodigoGroupBox, pTipoTela, pCodigoMenu: string): string;
    function excluirDBEdit(pCodigoDBEdit: string): string;
    function pegarFormatoDoCampo(pCodigoCampo: string): string;
    function pegarTipoDoCampo(pCodigoCampo: string): string;
    function pegarDescricaoTipoCampo(pCodigoCampo: string): string;
    function pegarNameCampo(pCodigoCampo: string): string;
    function pegarNameChavePrimaria(pCodigoCampo: string): string;
    function pegarTamanhoCampo(pCodigoCampo: string): integer;
    function verificarSeCampoPreenchimentoObrigatorio(pCodigoCampo: string): boolean;
    function pegarCaptionDoCampo(pCodigoComponente:integer): string;
    function pegarCodigoDoComboboxNaTela(pCodigoComboBox, pCodigoGroupBox:string): string;
    function pegarCodigoDoComboboxNaTelaPesquisa(pCodigoComboBox, pCodigoMenu:string): string;
    function pegarNomeDaTabelaDoComboBox(pCodigoComboBox: string): string;
    function verificaSeChaveEstrangeiraPertenceATabelaPrincipal(pCampoChaveEstrangeira, pCodigoTabelaPrincipal: string): boolean;
    function pegarCampoFisicoChavePrimariaPelaTabelaTelaCampoPesquisa(pCodigoTela: string): string;
end;

implementation

{ TComponenteDBEdit }

function TComponenteDataControlsStandard.alterarTamanhoPosicao(pCodigoDBEdit: string; pLeft,
  pTop, pWidth, pHeight: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TELA_CAMPO SET '+
      'DDTC_LEFT=:DDTC_LEFT, DDTC_TOP=:DDTC_TOP, DDTC_WIDTH=:DDTC_WIDTH,  '+
      'DDTC_HEIGHT=:DDTC_HEIGHT WHERE DDTC_CODIGO=:DDTC_CODIGO    ');
    objQuery.FDQuery.ParamByName('DDTC_CODIGO').AsString := pCodigoDBEdit;
    objQuery.FDQuery.ParamByName('DDTC_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDTC_TOP').AsInteger := pTop;
    objQuery.FDQuery.ParamByName('DDTC_WIDTH').AsInteger := pWidth;
    objQuery.FDQuery.ParamByName('DDTC_HEIGHT').AsInteger := pHeight;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:= 'Sucesso';
end;

function TComponenteDataControlsStandard.alterarTamanhoPosicaoTelaPesquisa(
  pCodigoComboBoxTela: string; pLeft, pTop, pWidth, pHeight: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TELA_CAMPO_PESQUISA SET '+
      'DDTCP_LEFT=:DDTCP_LEFT, DDTCP_TOP=:DDTCP_TOP, DDTCP_WIDTH=:DDTCP_WIDTH,  '+
      'DDTCP_HEIGHT=:DDTCP_HEIGHT WHERE DDTCP_CODIGO=:DDTCP_CODIGO    ');
    objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString := pCodigoComboBoxTela;
    objQuery.FDQuery.ParamByName('DDTCP_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDTCP_TOP').AsInteger := pTop;
    objQuery.FDQuery.ParamByName('DDTCP_WIDTH').AsInteger := pWidth;
    objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger := pHeight;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
  end;
end;

function TComponenteDataControlsStandard.cadastrarComboBoxNaTela(
  pCodigoComboBox, pCodigoGroupBox: string;
  pTop, pLeft, pHeight, pWidth: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO '+
      ' (DDCB_CODIGO, DDGB_CODIGO, DDTC_TOP, DDTC_LEFT, DDTC_HEIGHT, DDTC_WIDTH) '+
      ' VALUES '+
      ' (:DDCB_CODIGO, :DDGB_CODIGO, :DDTC_TOP, :DDTC_LEFT, :DDTC_HEIGHT, :DDTC_WIDTH) ');
    objQuery.FDQuery.ParamByName('DDCB_CODIGO').AsString:= pCodigoComboBox;
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString:= pCodigoGroupBox;
    objQuery.FDQuery.ParamByName('DDTC_TOP').AsInteger:= pTop;
    objQuery.FDQuery.ParamByName('DDTC_LEFT').AsInteger:= pLeft;
    objQuery.FDQuery.ParamByName('DDTC_HEIGHT').AsInteger:= pHeight;
    objQuery.FDQuery.ParamByName('DDTC_WIDTH').AsInteger:= pWidth;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';

  end;
end;

function TComponenteDataControlsStandard.cadastrarComboBoxNaTelaPesquisa(
  pCodigoComboBox, pCodigoMenu: string; pTop, pLeft, pHeight,
  pWidth: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO_PESQUISA '+
      ' (DDCB_CODIGO, DDM_CODIGO, DDTCP_TOP, DDTCP_LEFT, DDTCP_HEIGHT, DDTCP_WIDTH) '+
      ' VALUES '+
      ' (:DDCB_CODIGO, :DDM_CODIGO, :DDTCP_TOP, :DDTCP_LEFT, :DDTCP_HEIGHT, :DDTCP_WIDTH) ');
    objQuery.FDQuery.ParamByName('DDCB_CODIGO').AsString:= pCodigoComboBox;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
    objQuery.FDQuery.ParamByName('DDTCP_TOP').AsInteger:= pTop;
    objQuery.FDQuery.ParamByName('DDTCP_LEFT').AsInteger:= pLeft;
    objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger:= pHeight;
    objQuery.FDQuery.ParamByName('DDTCP_WIDTH').AsInteger:= pWidth;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';

  end;
end;

function TComponenteDataControlsStandard.cadastrarDBEdit(pCodigoCampo,
  pCodigoGroupBox, pTipoCampo, pTipoTela, pCodigoMenu: string;
  pTop, pLeft, pHeight, pWidth: integer): string;
begin
  try
    if pTipoTela = 'C' then
    begin
      objQuery.FDQuery.Close;
      objQuery.FDQuery.SQL.Clear;
      objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO ');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.SQL.Add('(DDBDC_CODIGO,  ')
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.SQL.Add('(DDBDCP_CODIGO,  ');
      objQuery.FDQuery.SQL.Add('DDGB_CODIGO, DDTC_TOP, DDTC_LEFT, DDTC_HEIGHT, DDTC_WIDTH) ');
      objQuery.FDQuery.SQL.Add('VALUES ');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.SQL.Add('(:DDBDC_CODIGO, ')
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.SQL.Add('(:DDBDCP_CODIGO, ');
      objQuery.FDQuery.SQL.Add(':DDGB_CODIGO, :DDTC_TOP, :DDTC_LEFT, ');
      objQuery.FDQuery.SQL.Add(':DDTC_HEIGHT, :DDTC_WIDTH)');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;

      objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
      objQuery.FDQuery.ParamByName('DDTC_TOP').AsInteger := pTop;
      objQuery.FDQuery.ParamByName('DDTC_LEFT').AsInteger := pLeft;
      objQuery.FDQuery.ParamByName('DDTC_HEIGHT').AsInteger := pHeight;
      objQuery.FDQuery.ParamByName('DDTC_WIDTH').AsInteger := pWidth;
      objQuery.FDQuery.ExecSQL;
    end
    else if pTipoTela = 'P' then
    begin
      objQuery.FDQuery.Close;
      objQuery.FDQuery.SQL.Clear;
      objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO_PESQUISA ');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.SQL.Add('(DDBDC_CODIGO,  ')
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.SQL.Add('(DDBDCP_CODIGO,  ');
      objQuery.FDQuery.SQL.Add('DDM_CODIGO, DDTCP_TOP, DDTCP_LEFT, DDTCP_HEIGHT, DDTCP_WIDTH) ');
      objQuery.FDQuery.SQL.Add('VALUES ');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.SQL.Add('(:DDBDC_CODIGO, ')
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.SQL.Add('(:DDBDCP_CODIGO, ');
      objQuery.FDQuery.SQL.Add(':DDM_CODIGO, :DDTCP_TOP, :DDTCP_LEFT, ');
      objQuery.FDQuery.SQL.Add(':DDTCP_HEIGHT, :DDTCP_WIDTH)');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;

      objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
      objQuery.FDQuery.ParamByName('DDTCP_TOP').AsInteger := pTop;
      objQuery.FDQuery.ParamByName('DDTCP_LEFT').AsInteger := pLeft;
      objQuery.FDQuery.ParamByName('DDTCP_HEIGHT').AsInteger := pHeight;
      objQuery.FDQuery.ParamByName('DDTCP_WIDTH').AsInteger := pWidth;
      objQuery.FDQuery.ExecSQL;
    end
    else if pTipoTela = 'G' then
    begin
      objQuery.FDQuery.Close;
      objQuery.FDQuery.SQL.Clear;
      objQuery.FDQuery.SQL.Add('INSERT INTO DD_TELA_CAMPO_GRID ');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.SQL.Add('(DDBDC_CODIGO,  ')
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.SQL.Add('(DDBDCP_CODIGO,  ');
      objQuery.FDQuery.SQL.Add('DDM_CODIGO, DDTCG_TAMANHO, DDTCG_POSICAO) ');
      objQuery.FDQuery.SQL.Add('VALUES ');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.SQL.Add('(:DDBDC_CODIGO, ')
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.SQL.Add('(:DDBDCP_CODIGO, ');
      objQuery.FDQuery.SQL.Add(':DDM_CODIGO, :DDTCG_TAMANHO, :DDTCG_POSICAO');
      if pTipoCampo = 'C' then
        objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo
      else if pTipoCampo = 'CP' then
        objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;

      objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
      objQuery.FDQuery.ParamByName('DDTCG_TAMANHO').AsInteger := 100;
      objQuery.FDQuery.ParamByName('DDTCG_POSICAO').AsInteger := 1;
      objQuery.FDQuery.ExecSQL;
    end;
  except
    result:='Erro';
    exit;
  end;
  result:='Sucesso';
end;

constructor TComponenteDataControlsStandard.create;
begin
  objQuery:= TUFDQuery.GetInstancia;
end;

function TComponenteDataControlsStandard.excluirDBEdit(pCodigoDBEdit: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_TELA_CAMPO  '+
      ' WHERE DDTC_CODIGO=:DDTC_CODIGO');
    objQuery.FDQuery.ParamByName('DDTC_CODIGO').AsString := pCodigoDBEdit;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:='Sucesso';
end;

procedure TComponenteDataControlsStandard.mostrarCodigoChavePrimariaETabela(
  pCodigoTabela: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCE.DDBDCP_CODIGO, DDBDCP.DDBDT_CODIGO '+
    'FROM DD_BD_CHAVE_PRIMARIA DDBDCP                                    '+
    'INNER JOIN DD_BD_CHAVE_ESTRANGEIRA DDBDCE ON                        '+
    'DDBDCP.DDBDCP_CODIGO = DDBDCE.DDBDCP_CODIGO                         '+
    'WHERE DDBDCE.DDBDT_CODIGO=:DDBDT_CODIGO');
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString:= pCodigoTabela;
  objQuery.FDQuery.Open();

end;

function TComponenteDataControlsStandard.pegarCampoFisicoChavePrimariaPelaTabelaTelaCampoPesquisa(
  pCodigoTela: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CAMPO_FISICO FROM    '+
    'DD_TELA_CAMPO_PESQUISA DDTCP INNER JOIN                   '+
    'DD_COMBOBOX DDCB ON DDTCP.DDCB_CODIGO = DDCB.DDCB_CODIGO  '+
    'INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON                 '+
    'DDCB.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO                   '+
    'WHERE DDTCP.DDTCP_CODIGO=:DDTCP_CODIGO ');
  objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString:= pCodigoTela;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_FISICO').AsString;
end;

function TComponenteDataControlsStandard.pegarCaptionDoCampo(
  pCodigoComponente: integer): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC_CAMPO_APELIDO FROM DD_TELA_CAMPO DDTC  '+
    ' INNER JOIN DD_BD_CAMPO DDBDC ON DDTC.DDBDC_CODIGO= DDBDC.DDBDC_CODIGO '+
    ' WHERE DDTC_CODIGO=:DDTC_CODIGO');
  objQuery.FDQuery.ParamByName('DDTC_CODIGO').AsInteger:= pCodigoComponente;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDBDC_CAMPO_APELIDO').AsString;

end;

function TComponenteDataControlsStandard.pegarCodigoDaChavePrimaria(
  pNomeCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CODIGO FROM DD_BD_CHAVE_PRIMARIA '+
    'WHERE DDBDCP_CAMPO_APELIDO=:DDBDCP_CAMPO_APELIDO              ');
  objQuery.FDQuery.ParamByName('DDBDCP_CAMPO_APELIDO').AsString :=pNomeCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDCP_CODIGO').AsString;
end;

function TComponenteDataControlsStandard.pegarCodigoDaChavePrimariaPeloCampoFisico(
  pNomeCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CODIGO FROM DD_BD_CHAVE_PRIMARIA '+
    'WHERE DDBDCP_CAMPO_FISICO=:DDBDCP_CAMPO_FISICO              ');
  objQuery.FDQuery.ParamByName('DDBDCP_CAMPO_FISICO').AsString :=pNomeCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDCP_CODIGO').AsString;
end;

function TComponenteDataControlsStandard.pegarCodigoDoCampo(pNomeCampo, pCodigoTabela: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC_CODIGO FROM DD_BD_CAMPO '+
    'WHERE DDBDC_CAMPO_APELIDO=:DDBDC_CAMPO_APELIDO AND DDBDT_CODIGO=:DDBDT_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDC_CAMPO_APELIDO').AsString :=pNomeCampo;
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString := pCodigoTabela;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDC_CODIGO').AsString;
end;

function TComponenteDataControlsStandard.pegarCodigoDoComboboxNaTela(
  pCodigoComboBox, pCodigoGroupBox: string): string;
begin

  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTC_CODIGO     '+
    ' FROM DD_TELA_CAMPO                           '+
    ' WHERE DDGB_CODIGO=:DDGB_CODIGO AND DDCB_CODIGO=:DDCB_CODIGO ');
  objQuery.FDQuery.ParamByName('DDCB_CODIGO').AsString := pCodigoComboBox;
  objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDTC_CODIGO').AsString;
end;

function TComponenteDataControlsStandard.pegarCodigoDoComboboxNaTelaPesquisa(
  pCodigoComboBox, pCodigoMenu: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO     '+
    ' FROM DD_TELA_CAMPO_PESQUISA                           '+
    ' WHERE DDM_CODIGO=:DDM_CODIGO AND DDCB_CODIGO=:DDCB_CODIGO ');
  objQuery.FDQuery.ParamByName('DDCB_CODIGO').AsString := pCodigoComboBox;
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDTCP_CODIGO').AsString;
end;

function TComponenteDataControlsStandard.pegarCodigoDoDBEdit(pCodigoCampo,
  pCodigoGroupBox, pTipoTela, pCodigoMenu: string): string;
begin
  if pTipoTela = 'C' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDTC_CODIGO     '+
      ' FROM DD_TELA_CAMPO                           '+
      ' WHERE DDGB_CODIGO=:DDGB_CODIGO AND DDBDC_CODIGO=:DDBDC_CODIGO ');
    objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo;
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
    objQuery.FDQuery.Open();

    result := objQuery.FDQuery.FieldByName('DDTC_CODIGO').AsString;
  end
  else if pTipoTela = 'P' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO     '+
      ' FROM DD_TELA_CAMPO_PESQUISA                   '+
      ' WHERE DDM_CODIGO=:DDM_CODIGO AND DDBDC_CODIGO=:DDBDC_CODIGO ');
    objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.Open();

    result := objQuery.FDQuery.FieldByName('DDTCP_CODIGO').AsString;
  end;

end;

function TComponenteDataControlsStandard.pegarCodigoDoDBEditChavePrimaria(pCodigoCampo,
  pCodigoGroupBox, pTipoTela, pCodigoMenu: string): string;
begin
  if pTipoTela = 'C' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDTC_CODIGO     '+
      ' FROM DD_TELA_CAMPO                           '+
      ' WHERE DDGB_CODIGO=:DDGB_CODIGO AND DDBDCP_CODIGO=:DDBDCP_CODIGO ');
    objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
    objQuery.FDQuery.Open();

    result := objQuery.FDQuery.FieldByName('DDTC_CODIGO').AsString;
  end
  else if pTipoTela = 'P' then
  begin
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO     '+
      ' FROM DD_TELA_CAMPO_PESQUISA                   '+
      ' WHERE DDM_CODIGO=:DDM_CODIGO AND DDBDCP_CODIGO=:DDBDCP_CODIGO ');
    objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString := pCodigoCampo;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.Open();

    result := objQuery.FDQuery.FieldByName('DDTCP_CODIGO').AsString;
  end;
end;

function TComponenteDataControlsStandard.pegarNameCampo(
  pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC_CAMPO_FISICO FROM DD_BD_CAMPO '+
    'WHERE DDBDC_CODIGO=:DDBDC_CODIGO              ');
  objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString :=pCodigoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDC_CAMPO_FISICO').AsString;
end;

function TComponenteDataControlsStandard.pegarNameChavePrimaria(pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDCP_CAMPO_FISICO FROM DD_BD_CHAVE_PRIMARIA '+
    'WHERE DDBDCP_CODIGO=:DDBDCP_CODIGO              ');
  objQuery.FDQuery.ParamByName('DDBDCP_CODIGO').AsString :=pCodigoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_FISICO').AsString;
end;


function TComponenteDataControlsStandard.pegarDescricaoTipoCampo(pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDFC.DDBDFC_DESCRICAO_CAMPO '+
    'FROM DD_BD_CAMPO DDBDC                                     '+
    'INNER JOIN DD_BD_FORMATO_CAMPO DDBDFC ON                   '+
    'DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO                 '+
    'WHERE DDBDC.DDBDC_CODIGO=:DDBDC_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDFC_DESCRICAO_CAMPO').AsString;
end;

function TComponenteDataControlsStandard.pegarFormatoDoCampo(pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDFC.DDBDFC_FORMATO_FISICO '+
    'FROM DD_BD_CAMPO DDBDC                                     '+
    'INNER JOIN DD_BD_FORMATO_CAMPO DDBDFC ON                   '+
    'DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO                 '+
    'WHERE DDBDC.DDBDC_CODIGO=:DDBDC_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDFC_FORMATO_FISICO').AsString;

end;

function TComponenteDataControlsStandard.pegarNomeDaTabelaDoComboBox(
  pCodigoComboBox: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDT_TABELA_FISICA FROM  '+
    'DD_TELA_CAMPO_PESQUISA DDTCP                            '+
    'LEFT JOIN DD_COMBOBOX DDCB ON                           '+
    'DDTCP.DDCB_CODIGO = DDCB.DDCB_CODIGO                    '+
    'INNER JOIN DD_BD_TABELAS DDBDT ON                       '+
    '   DDCB.DDBDT_CODIGO = DDBDT.DDBDT_CODIGO               '+
    ' WHERE DDTCP.DDTCP_CODIGO =:DDTCP_CODIGO ');
  objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString := pCodigoComboBox;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDBDT_TABELA_FISICA').AsString;

end;

function TComponenteDataControlsStandard.pegarNomeDoGroupBox(pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDGB_NAME FROM DD_TELA_CAMPO DDTC '+
  'INNER JOIN DD_GROUPBOX DDGB ON                                    '+
  '  DDGB.DDGB_CODIGO = DDTC.DDGB_CODIGO                             '+
  '  WHERE DDTC.DDTC_CODIGO=:DDTC_CODIGO ');
  objQuery.FDQuery.ParamByName('DDTC_CODIGO').AsString:= pCodigoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDGB_NAME').AsString;

end;

function TComponenteDataControlsStandard.pegarTamanhoCampo(
  pCodigoCampo: string): integer;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDFC.DDBDFC_TAMANHO        '+
    'FROM DD_BD_CAMPO DDBDC                                     '+
    'INNER JOIN DD_BD_FORMATO_CAMPO DDBDFC ON                   '+
    'DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO                 '+
    'WHERE DDBDC.DDBDC_CODIGO=:DDBDC_CODIGO AND DDBDFC_TAMANHO IS NOT NULL');
  objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo;
  objQuery.FDQuery.Open();

  if not objQuery.FDQuery.IsEmpty then
    result := objQuery.FDQuery.FieldByName('DDBDFC_TAMANHO').AsInteger
  else
    result:=150;

end;

function TComponenteDataControlsStandard.pegarTipoDoCampo(pCodigoCampo: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDFC.DDBDFC_TIPO           '+
    'FROM DD_BD_CAMPO DDBDC                                     '+
    'INNER JOIN DD_BD_FORMATO_CAMPO DDBDFC ON                   '+
    'DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO                 '+
    'WHERE DDBDC.DDBDC_CODIGO=:DDBDC_CODIGO ');
  objQuery.FDQuery.ParamByName('DDBDC_CODIGO').AsString := pCodigoCampo;
  objQuery.FDQuery.Open();

  result := objQuery.FDQuery.FieldByName('DDBDFC_TIPO').AsString;

end;

procedure TComponenteDataControlsStandard.pesquisarComboBoxTela(
  pCodigoGroupBox, pCodigoComboBoxNaTela: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTC_CODIGO, DDGB_CODIGO, ');
  objQuery.FDQuery.SQL.Add('DDTC_TOP, DDTC_LEFT,             ');
  objQuery.FDQuery.SQL.Add('DDTC_HEIGHT, DDTC_WIDTH, DDCB_NOME_COMBOBOX,  ');
  objQuery.FDQuery.SQL.Add('DDBDC_CAMPO_FISICO, DDBDC_CAMPO_APELIDO,      ');
  objQuery.FDQuery.SQL.Add('DDBDCP_CAMPO_FISICO, DDBDCP.DDBDT_CODIGO      ');
  objQuery.FDQuery.SQL.Add('FROM DD_TELA_CAMPO DDTC INNER JOIN            ');
  objQuery.FDQuery.SQL.Add('DD_COMBOBOX DDCB ON                           ');
  objQuery.FDQuery.SQL.Add('DDTC.DDCB_CODIGO = DDCB.DDCB_CODIGO           ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CAMPO DDBDC ON               ');
  objQuery.FDQuery.SQL.Add('DDCB.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO        ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON     ');
  objQuery.FDQuery.SQL.Add('DDBDC.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO      ');
  if pCodigoGroupBox <> '' then
  begin
    objQuery.FDQuery.SQL.Add('WHERE DDTC.DDGB_CODIGO=:DDGB_CODIGO           ');
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
  end
  else if pCodigoComboBoxNaTela <> '' then
  begin
    objQuery.FDQuery.SQL.Add('WHERE DDTC.DDTC_CODIGO=:DDTC_CODIGO           ');
    objQuery.FDQuery.ParamByName('DDTC_CODIGO').AsString := pCodigoComboBoxNaTela;
  end;

  objQuery.FDQuery.Open();

end;

procedure TComponenteDataControlsStandard.pesquisarComboBoxTelaPesquisa(
  pCodigoMenu, pCodigoComboBoxNaTela: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTCP_CODIGO, DDTCP.DDM_CODIGO,   ');
  objQuery.FDQuery.SQL.Add('DDTCP_TOP, DDTCP_LEFT,             ');
  objQuery.FDQuery.SQL.Add('DDTCP_HEIGHT, DDTCP_WIDTH, DDCB_NOME_COMBOBOX,  ');
  objQuery.FDQuery.SQL.Add('DDBDC_CAMPO_FISICO, DDBDC_CAMPO_APELIDO,      ');
  objQuery.FDQuery.SQL.Add('DDBDCP_CAMPO_FISICO, DDBDCP.DDBDT_CODIGO      ');
  objQuery.FDQuery.SQL.Add('FROM DD_TELA_CAMPO_PESQUISA DDTCP INNER JOIN   ');
  objQuery.FDQuery.SQL.Add('DD_COMBOBOX DDCB ON                           ');
  objQuery.FDQuery.SQL.Add('DDTCP.DDCB_CODIGO = DDCB.DDCB_CODIGO           ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CAMPO DDBDC ON               ');
  objQuery.FDQuery.SQL.Add('DDCB.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO        ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON     ');
  objQuery.FDQuery.SQL.Add('DDBDC.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO      ');
  if pCodigoMenu <> '' then
  begin
    objQuery.FDQuery.SQL.Add('WHERE DDTCP.DDM_CODIGO=:DDM_CODIGO           ');
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  end
  else if pCodigoComboBoxNaTela <> '' then
  begin
    objQuery.FDQuery.SQL.Add('WHERE DDTCP.DDTCP_CODIGO=:DDTCP_CODIGO           ');
    objQuery.FDQuery.ParamByName('DDTCP_CODIGO').AsString := pCodigoComboBoxNaTela;
  end;

  objQuery.FDQuery.Open();
end;

procedure TComponenteDataControlsStandard.pesquisarDBEdits(
  pCodigoGroupBox, pOrdenarCampos: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTC_CODIGO, DDGB_CODIGO,               ');
  objQuery.FDQuery.SQL.Add('DDTC_TOP, DDTC_LEFT,                                                 ');
  objQuery.FDQuery.SQL.Add('DDTC_HEIGHT, DDTC_WIDTH, DDBDC.DDBDC_CAMPO_APELIDO AS CAMPO_APELIDO, ');
  objQuery.FDQuery.SQL.Add('DDBDC.DDBDC_CAMPO_FISICO AS CAMPO_FISICO,                            ');
  objQuery.FDQuery.SQL.Add('DDBDFC.DDBDFC_FORMATO_FISICO, DDBDFC_TIPO, DDBDFC_DESCRICAO_CAMPO    ');
  objQuery.FDQuery.SQL.Add('FROM DD_TELA_CAMPO DDTC                                             ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CAMPO DDBDC ON                                     ');
  objQuery.FDQuery.SQL.Add('DDTC.DDBDC_CODIGO = DDBDC.DDBDC_CODIGO                              ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_FORMATO_CAMPO DDBDFC ON                            ');
  objQuery.FDQuery.SQL.Add('DDBDC.DDBDFC_CODIGO = DDBDFC.DDBDFC_CODIGO                          ');
  objQuery.FDQuery.SQL.Add('WHERE DDGB_CODIGO=:DDGB_CODIGO    ');
  objQuery.FDQuery.SQL.Add('UNION                             ');
  objQuery.FDQuery.SQL.Add('SELECT DDTC_CODIGO, DDGB_CODIGO, DDTC_TOP, DDTC_LEFT,               ');
  objQuery.FDQuery.SQL.Add('DDTC_HEIGHT, DDTC_WIDTH, DDBDCP.DDBDCP_CAMPO_APELIDO AS CAMPO_APELIDO, ');
  objQuery.FDQuery.SQL.Add('DDBDCP.DDBDCP_CAMPO_FISICO AS CAMPO_FISICO,                         ');
  objQuery.FDQuery.SQL.Add(' '''', '''', '''' ');
  objQuery.FDQuery.SQL.Add('FROM DD_TELA_CAMPO DDTC                                               ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON                             ');
  objQuery.FDQuery.SQL.Add('DDTC.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO                             ');
  objQuery.FDQuery.SQL.Add('WHERE DDGB_CODIGO=:DDGB_CODIGO    ');

  if pOrdenarCampos = 'Ordenar' then
  begin
    objQuery.FDQuery.SQL.Add('UNION                             ');
    objQuery.FDQuery.SQL.Add('SELECT DDTC_CODIGO, DDGB_CODIGO, DDTC_TOP, DDTC_LEFT, ');
    objQuery.FDQuery.SQL.Add('DDTC_HEIGHT, DDTC_WIDTH, '''', ');
    objQuery.FDQuery.SQL.Add('DDBDCP.DDBDCP_CAMPO_FISICO AS CAMPO_FISICO, '''', '''', '''' ');
    objQuery.FDQuery.SQL.Add('FROM DD_TELA_CAMPO DDTC                               ');
    objQuery.FDQuery.SQL.Add('INNER JOIN DD_COMBOBOX DDCB ON                        ');
    objQuery.FDQuery.SQL.Add('DDTC.DDCB_CODIGO = DDCB.DDCB_CODIGO             ');
    objQuery.FDQuery.SQL.Add('INNER JOIN DD_BD_CHAVE_PRIMARIA DDBDCP ON       ');
    objQuery.FDQuery.SQL.Add('DDCB.DDBDT_CODIGO = DDBDCP.DDBDT_CODIGO ');
    objQuery.FDQuery.SQL.Add('WHERE DDGB_CODIGO=:DDGB_CODIGO    ');
  end;

  objQuery.FDQuery.SQL.Add('ORDER BY 3, 4');
  objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
  objQuery.FDQuery.Open();

end;

procedure TComponenteDataControlsStandard.pesquisarTabela(
  pCodigoTabela, pMostrarTodosOsRegistros: string);
var
  nomeTabela: string;
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
  if pMostrarTodosOsRegistros = 'N' then
    objQuery.FDQuery.SQL.Add('SELECT * FROM ' + nomeTabela + ' LIMIT 1 ')
  else if pMostrarTodosOsRegistros = 'S' then
    objQuery.FDQuery.SQL.Add('SELECT * FROM ' + nomeTabela );
  objQuery.FDQuery.Open();

end;

procedure TComponenteDataControlsStandard.sqlComboBox(pSql: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT * FROM ' + pSql);
  objQuery.FDQuery.Open();
end;

function TComponenteDataControlsStandard.verificarSeCampoPreenchimentoObrigatorio(
  pCodigoCampo: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDBDC_REQUERIDO FROM DD_TELA_CAMPO DDTC  '+
    ' INNER JOIN DD_BD_CAMPO DDBDC ON DDTC.DDBDC_CODIGO= DDBDC.DDBDC_CODIGO '+
    ' WHERE DDTC_CODIGO=:DDTC_CODIGO');
  objQuery.FDQuery.ParamByName('DDTC_CODIGO').AsString:= pCodigoCampo;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.FieldByName('DDBDC_REQUERIDO').AsString = 'S' then
    result:= true
  else
    result:= false;

end;

function TComponenteDataControlsStandard.verificaSeChaveEstrangeiraPertenceATabelaPrincipal(
  pCampoChaveEstrangeira, pCodigoTabelaPrincipal: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT ddbdce.DDBDT_CODIGO '+
    'FROM DD_BD_CHAVE_ESTRANGEIRA DDBDCE INNER join    '+
    'DD_BD_CHAVE_PRIMARIA DDBDCP ON                    '+
    'DDBDCE.DDBDCP_CODIGO = DDBDCP.DDBDCP_CODIGO       '+
    'WHERE DDBDCP.DDBDCP_CAMPO_FISICO=:DDBDCP_CAMPO_FISICO   '+
    'AND DDBDCE.DDBDT_CODIGO=:DDBDT_CODIGO');
  objQuery.FDQuery.ParamByName('DDBDCP_CAMPO_FISICO').AsString:= pCampoChaveEstrangeira;
  objQuery.FDQuery.ParamByName('DDBDT_CODIGO').AsString:= pCodigoTabelaPrincipal;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty then
    result:= false
  else
    result:= true;

end;

end.
