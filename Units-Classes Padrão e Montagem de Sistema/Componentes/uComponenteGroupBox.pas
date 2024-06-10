unit uComponenteGroupBox;

interface

uses uFDQuery, System.SysUtils;

type TComponenteGroupBox = class
  public
    objQuery : TUFDQuery;
    constructor create;
    procedure mostrarGroupBox(pCodigoMenu: string);
    function cadastrarGroupBox(pCodigoMenu,
      pCodigoTabSheet, pNomeGroupBox: string;
      pTop, pLeft, pHeight, pWidth: integer): string;
    function alterarTamanhoPosicao(pCodigoGroupBox: string; pLeft, pTop,
      pWidth, pHeight: integer): string;
    function excluirGroupBox(pCodigoGroupBox: string): string;
    function reordenarNamesDosGroupBox(pCodigoGroupBox: string; pIndex: integer): string;
    function alterarCaptionGroupBox(pCodigoGroupBox, pCaption: string): string;
    function pegarNameGroupBox(pCodigoGroupBox: string): string;
end;

implementation

{ TComponenteGroupBox }

function TComponenteGroupBox.alterarCaptionGroupBox(pCodigoGroupBox,
  pCaption: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_GROUPBOX SET '+
      'DDGB_CAPTION=:DDGB_CAPTION WHERE DDGB_CODIGO=:DDGB_CODIGO    ');
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
    objQuery.FDQuery.ParamByName('DDGB_CAPTION').AsString := pCaption;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:= 'Sucesso';

end;

function TComponenteGroupBox.alterarTamanhoPosicao(pCodigoGroupBox: string;
  pLeft, pTop, pWidth, pHeight: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_GROUPBOX SET '+
      'DDGB_LEFT=:DDGB_LEFT, DDGB_TOP=:DDGB_TOP, DDGB_WIDTH=:DDGB_WIDTH,  '+
      'DDGB_HEIGHT=:DDGB_HEIGHT WHERE DDGB_CODIGO=:DDGB_CODIGO    ');
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
    objQuery.FDQuery.ParamByName('DDGB_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDGB_TOP').AsInteger := pTop;
    objQuery.FDQuery.ParamByName('DDGB_WIDTH').AsInteger := pWidth;
    objQuery.FDQuery.ParamByName('DDGB_HEIGHT').AsInteger := pHeight;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:= 'Sucesso';
end;

function TComponenteGroupBox.cadastrarGroupBox(pCodigoMenu, pCodigoTabSheet,
  pNomeGroupBox: string; pTop, pLeft, pHeight, pWidth: integer): string;
var
  cName: string;
begin
  {Buscar um name para p GroupBox}
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDGB_CODIGO FROM DD_GROUPBOX '+
    ' WHERE DDM_CODIGO=:DDM_CODIGO');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString :=pCodigoMenu;
  objQuery.FDQuery.Open();
  objQuery.FDQuery.FetchAll;
  cName := 'gpb' + inttostr(objQuery.FDQuery.RecordCount +1);

  {FIM}

  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_GROUPBOX                          ');
    objQuery.FDQuery.SQL.Add('(DDGB_LEFT, DDGB_TOP, DDGB_HEIGHT,               ');
    objQuery.FDQuery.SQL.Add('DDGB_WIDTH, DDGB_CAPTION, DDGB_NAME, DDM_CODIGO  ');
    if pCodigoTabSheet <> '' then
      objQuery.FDQuery.SQL.Add(', DDTS_CODIGO)                                 ')
    else
      objQuery.FDQuery.SQL.Add(')');
    objQuery.FDQuery.SQL.Add('VALUES                                           ');
    objQuery.FDQuery.SQL.Add('(:DDGB_LEFT, :DDGB_TOP, :DDGB_HEIGHT,   ');
    objQuery.FDQuery.SQL.Add(':DDGB_WIDTH, :DDGB_CAPTION, :DDGB_NAME, :DDM_CODIGO ');
    if pCodigoTabSheet <> '' then
      objQuery.FDQuery.SQL.Add(', :DDTS_CODIGO)')
    else
      objQuery.FDQuery.SQL.Add(')');

    objQuery.FDQuery.ParamByName('DDGB_CAPTION').AsString  := pNomeGroupBox;
    objQuery.FDQuery.ParamByName('DDGB_NAME').AsString  :=  cName;
    objQuery.FDQuery.ParamByName('DDGB_LEFT').AsInteger := pLeft;
    objQuery.FDQuery.ParamByName('DDGB_TOP').AsInteger  := pTop;
    objQuery.FDQuery.ParamByName('DDGB_HEIGHT').AsInteger := pHeight;
    objQuery.FDQuery.ParamByName('DDGB_WIDTH').AsInteger  := pWidth;
    objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString   := pCodigoMenu;
    if pCodigoTabSheet <> '' then
      objQuery.FDQuery.ParamByName('DDTS_CODIGO').AsString  := pCodigoTabSheet;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';

end;

constructor TComponenteGroupBox.create;
begin
  objQuery := TUFDQuery.GetInstancia;
end;

function TComponenteGroupBox.excluirGroupBox(pCodigoGroupBox: string): string;
begin
  {excluir componentes vinculados ao GroupBox}
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_TELA_CAMPO WHERE DDGB_CODIGO=:DDGB_CODIGO');
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  {FIM}


  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('DELETE FROM DD_GROUPBOX WHERE DDGB_CODIGO=:DDGB_CODIGO');
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  end;
  result:= 'Sucesso';
end;

procedure TComponenteGroupBox.mostrarGroupBox(pCodigoMenu:string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDGB_CODIGO, DDGB_NAME, DDGB_LEFT, DDGB_TOP, '+
    'DDGB_WIDTH, DDGB_HEIGHT, DDGB.DDM_CODIGO, DDGB.DDTS_CODIGO, DDTS_POSICAO, '+
    'DDM.DDM_NAME, DDGB_CAPTION                                          '+
    'FROM DD_GROUPBOX DDGB                                               '+
    'LEFT JOIN DD_MENU DDM ON                                            '+
    'DDGB.DDM_CODIGO = DDM.DDM_CODIGO                                    '+
    'LEFT JOIN DD_TAB_SHEET DDTS ON                                      '+
    'DDGB.DDTS_CODIGO = DDTS.DDTS_CODIGO                                 '+
    'WHERE DDGB.DDM_CODIGO=:DDM_CODIGO ');
  objQuery.FDQuery.ParamByName('DDM_CODIGO').AsString:= pCodigoMenu;
  objQuery.FDQuery.Open();

end;

function TComponenteGroupBox.pegarNameGroupBox(pCodigoGroupBox: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDGB_NAME FROM DD_GROUPBOX '+
    ' WHERE DDGB_CODIGO=:DDGB_CODIGO ');
  objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
  objQuery.FDQuery.Open();

  result:= objQuery.FDQuery.FieldByName('DDGB_NAME').AsString;

end;

function TComponenteGroupBox.reordenarNamesDosGroupBox(
  pCodigoGroupBox: string; pIndex: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_GROUPBOX SET '+
      ' DDGB_NAME=:DDGB_NAME WHERE DDGB_CODIGO=:DDGB_CODIGO ');
    objQuery.FDQuery.ParamByName('DDGB_CODIGO').AsString := pCodigoGroupBox;
    objQuery.FDQuery.ParamByName('DDGB_NAME').AsString := 'gpb'+ inttostr(pIndex);
    objQuery.FDQuery.ExecSQL;
  Except
    result := 'Erro';
    exit;
  end;
  Result := 'Sucesso';
end;

end.
