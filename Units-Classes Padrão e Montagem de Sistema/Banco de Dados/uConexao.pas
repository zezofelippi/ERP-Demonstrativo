unit uConexao;

interface

uses Forms, Winapi.Windows, System.SysUtils, FireDAC.Comp.Client,
  IniFiles;

type TConexao = class
  private
    constructor Create;
    Class var Instanciado: TConexao;
    class procedure LiberarInstancia;
    Function Crypt(Action, Src: String): String;
  public
    FDConexao: TFDConnection;
    Transacao: TFDTransaction;
    Class function GetInstancia: TConexao;
end;

implementation

{ TConexao }

constructor TConexao.Create;
var
  Arquivo : TIniFile;
  BaseDados, Usuario, Senha, Servidor : string;
begin
  try
    Arquivo := TIniFile.Create(ExtractFilePath(ParamStr(0))+'CONFIG.INI');

    Servidor := Arquivo.ReadString('BASE', 'SERVER', '');
    BaseDados := Arquivo.ReadString('BASE', 'DATABASE', '');
    Usuario     := Arquivo.ReadString('BASE', 'USER', '');
   // Senha     := Arquivo.ReadString('BASE', 'PASS', '');
   // Senha := Crypt('D',Senha);
    Senha := '1234';

    FDConexao := TFDConnection.Create(nil);
    Transacao := TFDTransaction.Create(FDConexao);
    FDConexao.Connected   := False;
    FDConexao.LoginPrompt := false;
   // FDConexao.Params.DriverID := 'MySQL'; 02/10/2023
   FDConexao.Params.Add('DriverID=MySQL');

    {base local}
    {FDConexao.Params.Database := 'rrestoque';
    FDConexao.Params.UserName := 'root';
    FDConexao.Params.Password := 'root'; 25/01/2018}

    FDConexao.Params.Add('server=' + Servidor);
    FDConexao.Params.Add('Port=3306');
    FDConexao.Params.Add('Database=' + BaseDados);
    FDConexao.Params.Add('User_Name=' + Usuario);
   // FDConexao.Params.Add('Password=' + Senha);
   // FDConexao.Params.Database := BaseDados;  02/10/2023
   // FDConexao.Params.UserName := Usuario;    02/10/2023
   // FDConexao.Params.Password := Senha;      02/10/2023

    {base na nuvem}
    {FDConexao.Params.Database := 'conec621_rrestoque';
    FDConexao.Params.UserName := 'conec621';
    FDConexao.Params.Password := 'gili070813';
    FDConexao.Params.Add('server=www.conectati.com');
    FDConexao.Params.Add('Port=3306');
    FDConexao.TxOptions.AutoCommit := True;
    FDConexao.ResourceOptions.AutoReconnect := True; }

    FDConexao.Transaction := Transacao;
    FDConexao.Connected    := True;

   // Transacao.Active := true;
  except
    Application.MessageBox('Banco de dados não encontrado','Atenção', MB_ICONEXCLAMATION + MB_OK);

  end;

  Arquivo.Free;
end;

function TConexao.Crypt(Action, Src: String): String;
Label Fim;
var KeyLen : Integer;
  KeyPos : Integer;
  OffSet : Integer;
  Dest, Key : String;
  SrcPos : Integer;
  SrcAsc : Integer;
  TmpSrcAsc : Integer;
  Range : Integer;
begin
  if (Src = '') Then
  begin
    Result:= '';
    Goto Fim;
  end;
  Key :=
  'HUQL23KL23DF90WI5E1JAS460NMCXXL6JAOAUWWMCL0AOMJ4A4VZYW9KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 256;
  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x',[OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;
      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x',[SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToInt('$'+ copy(Src,1,2));
    SrcPos := 3;
  repeat
    SrcAsc := StrToInt('$'+ copy(Src,SrcPos,2));
    if (KeyPos < KeyLen) Then KeyPos := KeyPos + 1 else KeyPos := 1;
    TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
    if TmpSrcAsc <= OffSet then TmpSrcAsc := 255 + TmpSrcAsc - OffSet
    else TmpSrcAsc := TmpSrcAsc - OffSet;
    Dest := Dest + Chr(TmpSrcAsc);
    OffSet := SrcAsc;
    SrcPos := SrcPos + 2;
  until (SrcPos >= Length(Src));
  end;
  Result:= Dest;
  Fim:

end;

class function TConexao.GetInstancia: TConexao;
begin
  if not Assigned(self.Instanciado) then
    self.Instanciado := TConexao.create;
  result := self.Instanciado;
end;

class procedure TConexao.LiberarInstancia;
begin
  if Assigned(self.Instanciado) then
  begin
    self.Instanciado.Free;
  end;
end;

initialization
Finalization
  TConexao.LiberarInstancia;

end.
