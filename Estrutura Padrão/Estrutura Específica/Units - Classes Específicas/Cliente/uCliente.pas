unit uCliente;

interface

uses UFDQuery;

type TCliente = class
    public
      objQuery : TUFDQuery;
      constructor create;
      procedure pesquisarCidades(pCodigoEstado: string);
end;

implementation

{ TCliente }

constructor TCliente.create;
begin
  objQuery := TUFDQuery.GetInstancia;
end;

procedure TCliente.pesquisarCidades(pCodigoEstado: string);
begin

  objQuery.FDQuery.Close;
  objQuery.FDQuery.SQL.Clear;
  objQuery.FDQuery.SQL.Add('SELECT IDCIDADE_CIDADE, IDESTADO_ESTADO, '+
    ' NOMECIDADE_CIDADE FROM CIDADE '+
    ' WHERE IDESTADO_ESTADO=:IDESTADO_ESTADO ');
  objQuery.FDQuery.ParamByName('IDESTADO_ESTADO').AsString:= pCodigoEstado;
  objQuery.FDQuery.Open();

end;

end.
