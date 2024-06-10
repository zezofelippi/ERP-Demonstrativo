unit untLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  uAuxiliar;

type
  TfrmLogin = class(TForm)
    gpb1: TGroupBox;
    btnGerarCodigo: TBitBtn;
    edtCodigo: TEdit;
    btnEntrarADMSistema: TBitBtn;
    leChaveAcesso: TLabeledEdit;
    gpb2: TGroupBox;
    btnEntrar: TBitBtn;
    btnSair: TBitBtn;
    procedure btnGerarCodigoClick(Sender: TObject);
    procedure btnEntrarADMSistemaClick(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objAuxiliar: TAuxiliar;
    intE, intN, intNPar, iOrdemLetra, iConferirSenha, iContadorDeChanges: integer;
    uniaodeNE, chaveAcessoDescrip: string;
    vetorN: array [0..7] of string;
    vetorNPar: array [0..7] of string;
    vetorE : array [0..7] of string;
    procedure CriptografarNE;
    procedure CriptografarOrdemLetras;
    procedure DecifrarNumero;
    procedure CalcularNumero;
    procedure DecifrarNumCrip(iMult: int64; iM, iD, iOrdem : integer);
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses untMenu;

{$R *.dfm}

procedure TfrmLogin.btnEntrarADMSistemaClick(Sender: TObject);
begin
  if edtCodigo.Text = EmptyStr then
  begin
    Application.MessageBox(Pchar('É necessário gerar um código.'), 'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    Exit;
  end
  else if leChaveAcesso.Text = EmptyStr then
  begin
    Application.MessageBox(Pchar('É necessário digitar a chave de acesso.'), 'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    leChaveAcesso.SetFocus;
    Exit;
  end;

  DecifrarNumero;
  CalcularNumero;

  iContadorDeChanges:=iContadorDeChanges+1;
  if iContadorDeChanges = 3 then
    edtCodigo.Clear;
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  objAuxiliar.logadoComoADMSistema:= false;
  close;
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  Close;
  frmMenu.Close;
end;

procedure TfrmLogin.btnGerarCodigoClick(Sender: TObject);
var
 i : integer;
begin
  iContadorDeChanges:=0;

  vetorN[0]:= '33';
  vetorN[1]:= '39';
  vetorN[2]:= '21';
  vetorN[3]:= '14';
  vetorN[4]:= '22';
  vetorN[5]:= '35';
  vetorN[6]:= '15';

  vetorNPar[0]:= '20';
  vetorNPar[1]:= '24';
  vetorNPar[2]:= '12';
  vetorNPar[3]:= '06';
  vetorNPar[4]:= '10';
  vetorNPar[5]:= '24';
  vetorNPar[6]:= '8';

  vetorE[0]:= '7';
  vetorE[1]:= '5';
  vetorE[2]:= '5';
  vetorE[3]:= '5';
  vetorE[4]:= '7';
  vetorE[5]:= '5';
  vetorE[6]:= '3';

  try
    Randomize;
    i := Random(8);
    intE:= StrToInt(vetorE[i]);
    intN:= StrToInt(vetorN[i]);
    intNPar := StrToInt(vetorNPar[i]);
    uniaodeNE := '';
    uniaodeNE := vetorN[i] + vetorE[i];
  except
    edtCodigo.Clear;
    exit;
  end;

  CriptografarNE;
  CriptografarOrdemLetras;

end;

procedure TfrmLogin.CalcularNumero;
var
  iD, iTotDE, iM,
    iMult, i, iOrdem : int64;
  cMult: string;
begin
  {Procura o D}
  iD := 0;
  repeat
    iD := iD +1;
    iTotDE := intE * iD;
  until (iTotDE mod intNPar = 1);
  {FIM}

  i:=1;
  iOrdem := 0;
  iConferirSenha := 0;
  while i<= Length(chaveAcessoDescrip) do
  begin
    while (Copy(chaveAcessoDescrip, i,1) <> '.') and (i<30) do
    begin
      cMult := cMult +
        Copy(chaveAcessoDescrip, i,1);
      i:=i+1;
    end;
    iMult := StrToInt(cMult);
    iM := StrToInt(cMult);
    iOrdem := iOrdem + 1;
    DecifrarNumCrip(iMult, iM, iD, iOrdem);
    cMult := '';
    i:=i+1;
  end;

  if iConferirSenha = 5 then
  begin
    objAuxiliar.logadoComoADMSistema:= true;
    close;
  end
  else
    Application.MessageBox(Pchar('Chave de acesso inválida.'), 'Erro!',
      MB_OK+MB_ICONERROR + MB_TOPMOST);

end;

procedure TfrmLogin.CriptografarNE;
var
  c0, c1, c2, c3, c4, c5,
    c6, c7, c8, c9 :string;
  i : integer;
begin
  Randomize;
  c0 := 'rDLmeE';
  c1 := 'CghVjF';
  c2 := 'kldnUG';
  c3 := 'pqaswz';
  c4 := 'uvxytI';
  c5 := 'HABfbO';
  c7 := 'JKcMNP';
  c9 := 'ToiXWQ';

  edtCodigo.Text := '';
  i := 1;

  while i<= Length(uniaodeNE) do
  begin
    if Copy(uniaodeNE,i,1) = '0' then
      edtCodigo.Text := edtCodigo.Text + c0[random(Length(c0))]
    else if Copy(uniaodeNE,i,1) = '1' then
      edtCodigo.Text := edtCodigo.Text + c1[random(Length(c1))]
    else if Copy(uniaodeNE,i,1) = '2' then
      edtCodigo.Text := edtCodigo.Text + c2[random(Length(c2))]
    else if Copy(uniaodeNE,i,1) = '3' then
      edtCodigo.Text := edtCodigo.Text + c3[random(Length(c3))]
    else if Copy(uniaodeNE,i,1) = '4' then
      edtCodigo.Text := edtCodigo.Text + c4[random(Length(c4))]
    else if Copy(uniaodeNE,i,1) = '5' then
      edtCodigo.Text := edtCodigo.Text + c5[random(Length(c5))]
    else if Copy(uniaodeNE,i,1) = '6' then
      edtCodigo.Text := edtCodigo.Text + c6[random(Length(c6))]
    else if Copy(uniaodeNE,i,1) = '7' then
      edtCodigo.Text := edtCodigo.Text + c7[random(Length(c7))]
    else if Copy(uniaodeNE,i,1) = '8' then
      edtCodigo.Text := edtCodigo.Text + c8[random(Length(c8))]
    else if Copy(uniaodeNE,i,1) = '9' then
      edtCodigo.Text := edtCodigo.Text + c9[random(Length(c9))];
    i := i +1;
  end;
  if Length(edtCodigo.Text) <> 3 then
    CriptografarNE;


end;

procedure TfrmLogin.CriptografarOrdemLetras;
var
  p1, p2, p3, p4, p5, p6 : string; {usei a letra p de (posição)}
begin
  {Escolhe a ordem das letras e caracteres}
  iOrdemLetra := Random(5);
  while (iOrdemLetra = 0) do
    iOrdemLetra := Random(5);
  {FIM}

  {Escolhe a letra}
  p1 := 'abcd';
  p2 := 'efgh';
  p3 := 'ijkl';
  p4 := 'mnop';
  p5 := 'qrst';
  p6 := 'uvxw';

  if iOrdemLetra = 1 then
    edtCodigo.Text := edtCodigo.Text +
      p1[random(Length(p1))]
  else if iOrdemLetra = 2 then
    edtCodigo.Text := edtCodigo.Text +
      p2[random(Length(p2))]
  else if iOrdemLetra = 3 then
    edtCodigo.Text := edtCodigo.Text +
      p3[random(Length(p3))]
  else if iOrdemLetra = 4 then
    edtCodigo.Text := edtCodigo.Text +
      p4[random(Length(p4))]
  else if iOrdemLetra = 5 then
    edtCodigo.Text := edtCodigo.Text +
      p5[random(Length(p5))]
  else if iOrdemLetra = 6 then
    edtCodigo.Text := edtCodigo.Text +
      p6[random(Length(p6))];
  {FIM}

  if Length(edtCodigo.Text) < 4 then
    CriptografarOrdemLetras;

end;

procedure TfrmLogin.DecifrarNumCrip(iMult: int64; iM, iD, iOrdem: integer);
var
  iPot : integer;
begin
  iPot := 2;
  while iPot <= iD do
  begin
    iMult:= iMult  * im;
    iPot := iPot + 1;
  end;
  iM := iMult mod intN;

  if (iM = 3) and (iOrdem = 1) then
    iConferirSenha := iConferirSenha +1
  else if (iM =2) and (iOrdem = 2) then
    iConferirSenha := iConferirSenha +1
  else if (iM = 5) and (iOrdem = 3) then
    iConferirSenha := iConferirSenha +1
  else if (iM = 4) and (iOrdem = 4) then
    iConferirSenha := iConferirSenha +1
  else if (iM = 6) and (iOrdem = 5) then
    iConferirSenha := iConferirSenha +1;

end;

procedure TfrmLogin.DecifrarNumero;
var
  c0, c1, c2, c3, c4, c5,
    c6, c7, c8, c9, cLetra, cPonto :string;
  i : integer;
begin
  Randomize;
  c0 := 'HF/dN';
  c1 := 'fKhCj';
  c2 := 'UlSno';
  c3 := 'pOrVt';
  c4 := 'u+xyw';
  c5 := 'zABiD';
  c6 := 'EbGa&';
  c7 := 'JgL-e';
  c8 := '*PQRM';
  c9 := 'TksXW';
  cPonto := 'vMcqI';

  i := 1;
  while i<= Length(leChaveAcesso.Text) do
  begin
    if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c0, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '0'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c1, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '1'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c2, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '2'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c3, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '3'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c4, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '4'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c5, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '5'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c6, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '6'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c7, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '7'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c8, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '8'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(c9, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '9'
    else if  Pos(Copy(leChaveAcesso.Text, i,1), copy(cPonto, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '.';

    i:=i+1;
  end;
  chaveAcessoDescrip := cLetra;

end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  objAuxiliar:= TAuxiliar.GetInstancia;
end;

end.
