unit uComponentePageControl;

interface

uses uFDQuery;

type TComponentePageControl = class
  public
    objQuery : TUFDQuery;
    constructor create;
    procedure mostrarTabSheet(pCodigoPageControl:string);
    function cadastrarTabSheet(pCodigoPageControl, pNomeTabSheet: string): string;
    function cadastrarPageControl(pCodigoMenu, pNomePageControl: string): string;
    function verificarSePageControlJaExisteNaTela(pCodigoMenu:string): string;
    function excluirTabSheet(pCodigoTabSheet: string):string;
    function reordenarPosicaoTabSheet(
      pCodigoTabSheet: string; pPosicao: integer):string;
    function alterarCadastroTabSheet(pCodigoTabSheet, pNomeTabSheet: string): string;
    function pegarPosicaoDoTabSheetOndeSeEncontraOCampo(pCodigoCampo:integer): integer;
    function verificarSeTabSheetPossuiGroupBox(pCodigoTabSheet: string): boolean;
    function verificaSePageControlPossuiTabSheet(pCodigoPageControl: string): boolean;
    function excluirPageControl(pCodigoPageControl:string): string;
end;

implementation

{ TComponentePageControl }

function TComponentePageControl.alterarCadastroTabSheet(pCodigoTabSheet,
  pNomeTabSheet: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TAB_SHEET SET DDTS_CAPTION=:DDTS_CAPTION '+
      ' WHERE DDTS_CODIGO=:DDTS_CODIGO ');
    objQuery.FDQuery.ParamByName('DDTS_CODIGO').AsString := pCodigoTabSheet;
    objQuery.FDQuery.ParamByName('DDTS_CAPTION').AsString := pNomeTabSheet;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

function TComponentePageControl.cadastrarPageControl(pCodigoMenu,
  pNomePageControl: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_PAGE_CONTROL '+
      '(DDPC_NOME, DDM_CODIGO) '+
      'VALUES                  '+
      '(:DDPC_NOME, :DDM_CODIGO) ');
    objQuery.FDQuery.ParamByName('DDPC_NOME').AsString  := pNomePageControl;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

function TComponentePageControl.cadastrarTabSheet(pCodigoPageControl,
  pNomeTabSheet: string): string;
var
  posicao, codigoTabSheet : integer;
begin

  {Pegar a posicao do TabSheet}
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT MAX(DDTS_POSICAO) AS POSICAO  '+
    ' FROM DD_TAB_SHEET '+
    ' WHERE DDPC_CODIGO=:DDPC_CODIGO ');
  objQuery.FDQuery.ParamByName('DDPC_CODIGO').AsString := pCodigoPageControl;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.FieldByName('POSICAO').AsString = '' then
    posicao := 0
  else
    posicao :=objQuery.FDQuery.FieldByName('POSICAO').AsInteger + 1;
  {FIM}

  {Pegar o código do TabSheet, não é autoincremento}
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT MAX(DDTS_CODIGO) AS CODIGO FROM DD_TAB_SHEET');
  objQuery.FDQuery.Open();
  codigoTabSheet := objQuery.FDQuery.FieldByName('CODIGO').AsInteger + 1;
  {FIM}

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_TAB_SHEET'+
      '(DDTS_CODIGO, DDTS_CAPTION, DDPC_CODIGO, DDTS_POSICAO) '+
      'VALUES                  '+
      '(:DDTS_CODIGO, :DDTS_CAPTION, :DDPC_CODIGO, :DDTS_POSICAO) ');
    objQuery.FDQuery.ParamByName('DDTS_CAPTION').AsString  := pNomeTabSheet;
    objQuery.FDQuery.ParamByName('DDPC_CODIGO').AsString := pCodigoPageControl;
    objQuery.FDQuery.ParamByName('DDTS_POSICAO').AsInteger := posicao;
    objQuery.FDQuery.ParamByName('DDTS_CODIGO').AsInteger := codigoTabSheet;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';
end;

constructor TComponentePageControl.create;
begin
  objQuery := TUFDQuery.GetInstancia;
end;

function TComponentePageControl.excluirPageControl(
  pCodigoPageControl: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_PAGE_CONTROL WHERE DDPC_CODIGO=:DDPC_CODIGO');
    objQuery.FDQuery.ParamByName('DDPC_CODIGO').AsString  := pCodigoPageControl;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
end;

function TComponentePageControl.excluirTabSheet(
  pCodigoTabSheet: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_TAB_SHEET WHERE DDTS_CODIGO=:DDTS_CODIGO');
    objQuery.FDQuery.ParamByName('DDTS_CODIGO').AsString  := pCodigoTabSheet;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
end;

procedure TComponentePageControl.mostrarTabSheet(pCodigoPageControl:string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTS_CODIGO, DDTS_CAPTION, DDTS_POSICAO '+
    ' FROM DD_TAB_SHEET WHERE DDPC_CODIGO=:DDPC_CODIGO ORDER BY DDTS_POSICAO ');
  objQuery.FDQuery.ParamByName('DDPC_CODIGO').AsString := pCodigoPageControl;
  objQuery.FDQuery.Open();
end;

function TComponentePageControl.pegarPosicaoDoTabSheetOndeSeEncontraOCampo(
  pCodigoCampo: integer): integer;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTS_POSICAO FROM   '+
    'DD_TELA_CAMPO DDTC INNER JOIN DD_GROUPBOX DDGB ON '+
    'DDTC.DDGB_CODIGO = DDGB.DDGB_CODIGO               '+
    'INNER JOIN DD_TAB_SHEET DDTS ON                   '+
    'DDGB.DDTS_CODIGO = DDTS.DDTS_CODIGO               '+
    'WHERE DDTC.DDTC_CODIGO=:DDTC_CODIGO');
  objQuery.FDQuery.ParamByName('DDTC_CODIGO').AsInteger := pCodigoCampo;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDTS_POSICAO').AsInteger;

end;

function TComponentePageControl.reordenarPosicaoTabSheet(
  pCodigoTabSheet: string; pPosicao: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_TAB_SHEET SET  '+
      'DDTS_POSICAO=:DDTS_POSICAO WHERE DDTS_CODIGO=:DDTS_CODIGO');
    objQuery.FDQuery.ParamByName('DDTS_CODIGO').AsString    := pCodigoTabSheet;
    objQuery.FDQuery.ParamByName('DDTS_POSICAO').AsInteger  := pPosicao;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

function TComponentePageControl.verificarSePageControlJaExisteNaTela(
  pCodigoMenu: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDPC_CODIGO, DDPC_NOME FROM DD_PAGE_CONTROL '+
    ' WHERE DDM_CODIGO=:DDM_CODIGO');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString := pCodigoMenu;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty = true then
    result := ''
  else
    result := objQuery.FDQuery.FieldByName('DDPC_CODIGO').AsString;

end;

function TComponentePageControl.verificarSeTabSheetPossuiGroupBox(
  pCodigoTabSheet: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTS_CODIGO FROM DD_GROUPBOX '+
    ' WHERE DDTS_CODIGO=:DDTS_CODIGO');
  objQuery.FDQuery.ParamByName('DDTS_CODIGO').AsString := pCodigoTabSheet;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty = true then
    result := false
  else
    result := true;

end;

function TComponentePageControl.verificaSePageControlPossuiTabSheet(
  pCodigoPageControl: string): boolean;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDTS_CODIGO FROM DD_TAB_SHEET '+
    ' WHERE DDPC_CODIGO=:DDPC_CODIGO');
  objQuery.FDQuery.ParamByName('DDPC_CODIGO').AsString := pCodigoPageControl;
  objQuery.FDQuery.Open();

  if objQuery.FDQuery.IsEmpty = true then
    result := false
  else
    result := true;

end;

end.
