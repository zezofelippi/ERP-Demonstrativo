unit uModulosClasses;

interface

uses uFDQuery;

type TModulosClasses = class

  public
    objQuery : TUFDQuery;
    constructor create;
    function cadastrarModulo(pDescricao: string): string;
    function cadastrarClasse(pDescricao: string): string;
    function cadastrarModuloClasse(pCodigoModulo, pCodigoClasse: string): string;
    function alterarCadastroModulo(pCodigoModulo, pDescricaoModulo: string): string;
    function alterarSequenciaDosModulos(pCodigoModulo: string; pSequencia: integer): string;
    function verificaSeModuloPodeSerExcluido(pCodigoModulo: string): string;
    function verificaSeClassePodeSerExcluida(pCodigoClasse: string): string;
    function verificaSeModuloEClasseJaEstaoCadastrados(
             pCodigoModulo, pCodigoClasse: string): string;
    function excluirModulo(pCodigoModulo: string):string;
    function excluirClasse(pCodigoClasse: string):string;
    function excluirModuloClasse(pModuloClasse: string): string;
    procedure mostrarClasses;
    procedure mostrarModulos;
    procedure mostrarModulosClasses(pCodigoModulo: string);
    procedure mostrarClassesDeAcordoComCadaModulo(pSequenciaModulo: string);
end;

implementation

{ TModulosClasses }

function TModulosClasses.alterarCadastroModulo(pCodigoModulo,
  pDescricaoModulo: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_MODULO_MENU SET '+
      ' DDMM_DESCRICAO=:DDMM_DESCRICAO '+
      ' WHERE DDMM_CODIGO=:DDMM_CODIGO');
    objQuery.FDQuery.ParamByName('DDMM_DESCRICAO').AsString := pDescricaoModulo;
    objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    Exit;
  end;
  result := 'Sucesso';
end;

function TModulosClasses.alterarSequenciaDosModulos(
  pCodigoModulo: string; pSequencia: integer): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('UPDATE DD_MODULO_MENU SET '+
      ' DDMM_SEQUENCIA_MODULO=:DDMM_SEQUENCIA_MODULO    '+
      ' WHERE DDMM_CODIGO=:DDMM_CODIGO');
    objQuery.FDQuery.ParamByName('DDMM_SEQUENCIA_MODULO').AsInteger := pSequencia;
    objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result:='Sucesso';
end;

function TModulosClasses.cadastrarClasse(pDescricao: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_CLASSES_PARA_FORMS '+
      ' (DDCPF_DESCRICAO) '+
      'values'+
      '(:DDCPF_DESCRICAO)');
    objQuery.FDQuery.ParamByName('DDCPF_DESCRICAO').AsString := pDescricao;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    Exit;
  end;
  result := 'Sucesso';
end;

function TModulosClasses.cadastrarModulo(pDescricao: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_MODULO_MENU (DDMM_DESCRICAO) '+
      'values'+
      '(:DDMM_DESCRICAO)');
    objQuery.FDQuery.ParamByName('DDMM_DESCRICAO').AsString := pDescricao;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  end;
  result := 'Sucesso';
end;

function TModulosClasses.cadastrarModuloClasse(pCodigoModulo,
  pCodigoClasse: string): string;
begin
  try
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add('INSERT INTO DD_MODULO_MENU_CLASSES_FORMS '+
      '(DDMM_CODIGO, DDCPF_CODIGO)  '+
      'values'+
      '(:DDMM_CODIGO, :DDCPF_CODIGO)');
    objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
    objQuery.FDQuery.ParamByName('DDCPF_CODIGO').AsString := pCodigoClasse;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    Exit;
  end;
  result:= 'Sucesso';
end;

constructor TModulosClasses.create;
begin
  objQuery := TUFDQuery.GetInstancia;
end;

function TModulosClasses.excluirClasse(pCodigoClasse: string): string;
begin
  TRY
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add(' '+
      'DELETE FROM DD_CLASSES_PARA_FORMS  '+
      'WHERE DDCPF_CODIGO=:DDCPF_CODIGO');
    objQuery.FDQuery.ParamByName('DDCPF_CODIGO').AsString := pCodigoClasse;
    objQuery.FDQuery.ExecSQL;
  except
    result:= 'Erro';
    exit;
  END;
  result := 'Sucesso';
end;

function TModulosClasses.excluirModulo(pCodigoModulo: string): string;
begin
  TRY
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add(' '+
      'DELETE FROM DD_MODULO_MENU  '+
      'WHERE DDMM_CODIGO=:DDMM_CODIGO');
    objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
    objQuery.FDQuery.ExecSQL;
  except
    result := 'Erro';
    exit;
  END;
  result:= 'Sucesso';
end;

function TModulosClasses.excluirModuloClasse(pModuloClasse: string): string;
begin
  TRY
    objQuery.FDQuery.Close;
    objQuery.FDQuery.SQL.Clear;
    objQuery.FDQuery.SQL.Add(' '+
      'DELETE FROM DD_MODULO_MENU_CLASSES_FORMS  '+
      'WHERE DDMMCF_CODIGO=:DDMMCF_CODIGO');
    objQuery.FDQuery.ParamByName('DDMMCF_CODIGO').AsString := pModuloClasse;
    objQuery.FDQuery.ExecSQL;
  except
    result:='Erro';
    exit;
  END;
  result:='Sucesso';
end;

procedure TModulosClasses.mostrarClasses;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDCPF_CODIGO, DDCPF_DESCRICAO '+
    'FROM DD_CLASSES_PARA_FORMS ORDER BY DDCPF_DESCRICAO ');
  objQuery.FDQuery.Open;
end;

procedure TModulosClasses.mostrarClassesDeAcordoComCadaModulo(
  pSequenciaModulo: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDCPF.DDCPF_CODIGO, '+
    ' DDCPF.DDCPF_DESCRICAO, DDMM.DDMM_CODIGO, DDMM_DESCRICAO '+
    'FROM DD_MODULO_MENU DDMM INNER JOIN               '+
    'DD_MODULO_MENU_CLASSES_FORMS DDMMCF ON            '+
    'DDMM.DDMM_CODIGO = DDMMCF.DDMM_CODIGO             '+
    'INNER JOIN DD_CLASSES_PARA_FORMS DDCPF ON         '+
    'DDMMCF.DDCPF_CODIGO = DDCPF.DDCPF_CODIGO          '+
    'WHERE DDMM.DDMM_SEQUENCIA_MODULO =:DDMM_SEQUENCIA_MODULO');
  objQuery.FDQuery.ParamByName('DDMM_SEQUENCIA_MODULO').AsString:=
    pSequenciaModulo;
  objQuery.FDQuery.Open();
end;

procedure TModulosClasses.mostrarModulos;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT '+
    ' DDMM_CODIGO, DDMM_DESCRICAO '+
    ' FROM DD_MODULO_MENU '+
    ' ORDER BY DDMM_DESCRICAO ');
  objQuery.FDQuery.Open;
end;

procedure TModulosClasses.mostrarModulosClasses(pCodigoModulo: string);
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDMMCF_CODIGO, DDCPF.DDCPF_CODIGO,  ');
  objQuery.FDQuery.SQL.Add('DDCPF_DESCRICAO, DDMM.DDMM_CODIGO, DDMM_DESCRICAO ');
  objQuery.FDQuery.SQL.Add('FROM DD_MODULO_MENU_CLASSES_FORMS DDMMCF   ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_CLASSES_PARA_FORMS DDCPF ON  ');
  objQuery.FDQuery.SQL.Add('DDCPF.DDCPF_CODIGO = DDMMCF.DDCPF_CODIGO   ');
  objQuery.FDQuery.SQL.Add('INNER JOIN DD_MODULO_MENU DDMM ON          ');
  objQuery.FDQuery.SQL.Add('DDMM.DDMM_CODIGO = DDMMCF.DDMM_CODIGO      ');
  if pCodigoModulo <> '' then
    objQuery.FDQuery.SQL.Add('WHERE DDMMCF.DDMM_CODIGO=:DDMM_CODIGO    ');
  objQuery.FDQuery.SQL.Add('ORDER BY DDMM_DESCRICAO, DDCPF_DESCRICAO   ');
  if pCodigoModulo <> '' then
    objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
  objQuery.FDQuery.Open;

end;

function TModulosClasses.verificaSeClassePodeSerExcluida(
  pCodigoClasse: string): string;
begin
  {Verifica se classe está contida em algum módulo}
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDMMCF_CODIGO FROM DD_MODULO_MENU_CLASSES_FORMS '+
    ' WHERE DDCPF_CODIGO=:DDCPF_CODIGO ');
  objQuery.FDQuery.ParamByName('DDCPF_CODIGO').AsString := pCodigoClasse;
  objQuery.FDQuery.Open();
  objQuery.FDQuery.FetchAll;

  if not objQuery.FDQuery.IsEmpty then
  begin
    result := 'Aviso';
    exit;
  end;
  result := 'Sucesso';
  {FIM}
end;

function TModulosClasses.verificaSeModuloEClasseJaEstaoCadastrados(
  pCodigoModulo, pCodigoClasse: string): string;
begin
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDMMCF_CODIGO '+
    'FROM DD_MODULO_MENU_CLASSES_FORMS           '+
    'WHERE DDMM_CODIGO=:DDMM_CODIGO AND DDCPF_CODIGO=:DDCPF_CODIGO ');
  objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
  objQuery.FDQuery.ParamByName('DDCPF_CODIGO').AsString := pCodigoClasse;
  objQuery.FDQuery.Open();
  objQuery.FDQuery.FetchAll;

  if objQuery.FDQuery.IsEmpty = false then
  begin
    result:= 'Aviso';
    Exit;
  end;
  result:= 'Sucesso';
end;

function TModulosClasses.verificaSeModuloPodeSerExcluido(
  pCodigoModulo: string): string;
begin

  {verifica se há classe inserido no módulo}
  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT DDMMCF_CODIGO FROM DD_MODULO_MENU_CLASSES_FORMS '+
    ' WHERE DDMM_CODIGO=:DDMM_CODIGO ');
  objQuery.FDQuery.ParamByName('DDMM_CODIGO').AsString := pCodigoModulo;
  objQuery.FDQuery.Open();
  objQuery.FDQuery.FetchAll;

  if not objQuery.FDQuery.IsEmpty then
  begin
    result := 'Aviso';
    exit;
  end;
  result := 'Sucesso';
  {FIM}

end;

end.
