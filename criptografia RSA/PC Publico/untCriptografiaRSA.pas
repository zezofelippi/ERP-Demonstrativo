unit untCriptografiaRSA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, StrUtils, Math;

type
  TfrmCriptografiaRSA = class(TForm)
    btnGerarCodigo: TBitBtn;
    edtGerarCodigo: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    leSenha: TLabeledEdit;
    btnOk: TBitBtn;
    lbl4: TLabel;
    procedure btnGerarCodigoClick(Sender: TObject);
    procedure CriptografarNE(Sender: TObject);
    procedure CalcularNumero(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DecifrarNumCrip(iMult: int64; iM, iD, iOrdem : integer);
    procedure DecifrarNE(Sender: TOBject);
    procedure CifrarNumero(Sender : TOBject);
    procedure DecifrarNumero(Sender: TOBject);
    procedure CriptografarOrdemLetras(Sender: TOBject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCriptografiaRSA: TfrmCriptografiaRSA;
  gcPrimo,
   // gcPrimoCrip,
   // gcPrimoP,
   // gcPrimoQ,
   // gcPrimoCripP,
   // gcPrimoCripQ,
    gcChavePub,
      gcResultadoSenha : string;
  giN,
  //  giNPr,
  //  giEPr,
    giNPar,
    giE,
    giChavePub,
    giConferirSenha : Integer;
    iOrdemLetra : Integer;
  {vetores}
  gcVetorN: array [0..7] of string;
  gcVetorNPAR: array [0..7] of string;
  gcVetorE : array [0..7] of string;

implementation

{$R *.dfm}

procedure TfrmCriptografiaRSA.btnGerarCodigoClick(Sender: TObject);
var
 i, iOrdemLetra, iVariavelLetra : integer;
begin
  gcVetorN[0]:= '33';
  gcVetorN[1]:= '39';
  gcVetorN[2]:= '21';
  gcVetorN[3]:= '14';
  gcVetorN[4]:= '22';
 // gcVetorN[5]:= '23';
  gcVetorN[5]:= '35';
  gcVetorN[6]:= '15';

  gcVetorNPAR[0]:= '20';
  gcVetorNPAR[1]:= '24';
  gcVetorNPAR[2]:= '12';
  gcVetorNPAR[3]:= '06';
  gcVetorNPAR[4]:= '10';
 // gcVetorNPAR[5]:= '12';
  gcVetorNPAR[5]:= '24';
  gcVetorNPAR[6]:= '8';

  gcVetorE[0]:= '7';
  gcVetorE[1]:= '5';
  gcVetorE[2]:= '5';
  gcVetorE[3]:= '5';
  gcVetorE[4]:= '7';
  //gcVetorE[5]:= '5';
  gcVetorE[5]:= '5';
  gcVetorE[6]:= '3';

  try
    Randomize;
    i := Random(8);
    giE:= StrToInt(gcVetorE[i]);
    giN:= StrToInt(gcVetorN[i]);
    giNPar := StrToInt(gcVetorNPAR[i]);
    gcPrimo := '';
    gcPrimo := gcVetorN[i] + gcVetorE[i];
    CriptografarNE(Sender as TObject);
    CriptografarOrdemLetras(Sender as TOBject);
  except
    edtGerarCodigo.Text := '';
  end;

end;

procedure TfrmCriptografiaRSA.btnOkClick(Sender: TObject);
{var
  i, iPot, iMult, iChavePub : integer;
  im : Int64;
  cM : string;  }
begin
  DecifrarNumero(Sender as TOBject);
  CalcularNumero(Sender AS TObject);

  {Cria Mensagem criptografada p/ comparar c/ senha digitada}
  //DecifrarNE(Sender as TObject);

  {cifrando a palavra}
  {i:= 1;
  gcChavePub := '';
  while i <=  Length('trave')  do
  begin
    cM := Copy('trave',i,1);
    if cM = 't' then
      iM := 3
    else if cM = 'r' then
      iM := 2
    else if cM = 'a' then
      iM := 5
    else if cM = 'v' then
      iM := 4
    else if cM = 'e' then
      iM := 6;   }

    {potenciação do numero}
   { iPot := 2;
    iMult := iM;
    while iPot <= giE do
    begin
      iM := iM * iMult;
      iPot := iPot + 1;
    end;  }
    {FIM}
   { iChavePub := iM mod giN;
    gcChavePub := gcChavePub + IntToStr(iChavePub) + '.';
    i:=i+1;
  end;     }
  //leCifrada.Text := gcChavePub;
 { CifrarNumero(Sender as TOBject);
  gcResultadoSenha := Copy(gcResultadoSenha, 1,
    length(gcResultadoSenha)-1);  }
  {FIM}

 { if leSenha.Text = gcResultadoSenha then
    ShowMessage('Senha correta')
  else
    ShowMessage('errooooooooooooou');   }


  //DecifrarNumero(Sender as TOBject);
  //CalcularNumero(Sender AS TObject);
end;

procedure TfrmCriptografiaRSA.CifrarNumero(Sender: TOBject);
var
  c0, c1, c2, c3, c4, c5,
    c6, c7, c8, c9, cPonto :string;
  i : integer;
begin
  Randomize;
  c0 := 'abcde';
  c1 := 'f/hij';
  c2 := 'klmno';
  c3 := 'pqr-t';
  c4 := 'uvxyw';
  c5 := 'zABCD';
  c6 := 'EFGHI';
  c7 := 'JK+MN';
  c8 := 'OPQRS';
  c9 := 'TUVX?';
  cPonto := 'LsgW!';

  gcResultadoSenha := '';
  i := 1;
  while i<= Length(gcChavePub) do
  begin
     if Copy(gcChavePub,i,1) = '0' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c0, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '1' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c1, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '2' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c2, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '3' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c3, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '4' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c4, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '5' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c5, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '6' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c6, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '7' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c7, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '8' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c8, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '9' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(c9, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '.' then
      gcResultadoSenha := gcResultadoSenha +
        Copy(cPonto, iOrdemLetra,1);
    i := i +1;
  end;

  if Length(gcResultadoSenha) <> Length(gcChavePub) then
  begin
    gcResultadoSenha := '';
    CifrarNumero(Sender as TObject);
  end;
  Exit;

end;

procedure TfrmCriptografiaRSA.CriptografarNE(Sender: TObject);
var
  c0, c1, c2, c3, c4, c5,
    c6, c7, c8, c9 :string;
  i : integer;
begin
  Randomize;
  c0 := 'abcde';
  c1 := 'fghij';
  c2 := 'klmno';
  c3 := 'pqrst';
  c4 := 'uvxyw';
  c5 := 'zABCD';
  c6 := 'EFGHI';
  c7 := 'JKLMN';
  c8 := 'OPQRS';
  c9 := 'TUVXW';

  edtGerarCodigo.Text := '';
  i := 1;
  while i<= Length(gcPrimo) do
  begin
    if Copy(gcPrimo,i,1) = '0' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c0[random(Length(c0))]
    else if Copy(gcPrimo,i,1) = '1' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c1[random(Length(c1))]
    else if Copy(gcPrimo,i,1) = '2' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c2[random(Length(c2))]
    else if Copy(gcPrimo,i,1) = '3' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c3[random(Length(c3))]
    else if Copy(gcPrimo,i,1) = '4' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c4[random(Length(c4))]
    else if Copy(gcPrimo,i,1) = '5' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c5[random(Length(c5))]
    else if Copy(gcPrimo,i,1) = '6' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c6[random(Length(c6))]
    else if Copy(gcPrimo,i,1) = '7' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c7[random(Length(c7))]
    else if Copy(gcPrimo,i,1) = '8' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c8[random(Length(c8))]
    else if Copy(gcPrimo,i,1) = '9' then
      edtGerarCodigo.Text := edtGerarCodigo.Text + c9[random(Length(c9))];
    i := i +1;
  end;
  i:=1;
  if Length(edtGerarCodigo.Text) <> 3 then
    CriptografarNE(Sender as TObject);


end;

procedure TfrmCriptografiaRSA.CriptografarOrdemLetras(Sender: TOBject);
var
  iVariavelLetra, iOrdemLetra : integer;
  p1, p2, p3, p4, p5 : string; {usei a letra p de (posição)}
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

  iVariavelLetra := Random(4);
  while (iVariavelLetra = 0) do
    iVariavelLetra := Random(5);
  {FIM}

  if iOrdemLetra = 1 then
    edtGerarCodigo.Text := edtGerarCodigo.Text +
      p1[random(Length(p1))]
  else if iOrdemLetra = 2 then
    edtGerarCodigo.Text := edtGerarCodigo.Text +
      p2[random(Length(p2))]
  else if iOrdemLetra = 3 then
    edtGerarCodigo.Text := edtGerarCodigo.Text +
      p3[random(Length(p3))]
  else if iOrdemLetra = 4 then
    edtGerarCodigo.Text := edtGerarCodigo.Text +
      p4[random(Length(p4))]
  else if iOrdemLetra = 5 then
    edtGerarCodigo.Text := edtGerarCodigo.Text +
      p5[random(Length(p5))];

  if Length(edtGerarCodigo.Text) < 4 then
    CriptografarOrdemLetras(Sender as TOBject);

  {FIM}

end;

procedure TfrmCriptografiaRSA.DecifrarNE(Sender: TOBject);
var
  c0, c1, c2, c3, c4, c5,
    c6, c7, c8, c9, cLetra, p1, p2, p3, p4, p5 :string;
  i : integer;
begin
 { Randomize;
  c0 := 'abcde';
  c1 := 'fghij';
  c2 := 'klmno';
  c3 := 'pqrst';
  c4 := 'uvxyw';
  c5 := 'zABCD';
  c6 := 'EFGHI';
  c7 := 'JKLMN';
  c8 := 'OPQRS';
  c9 := 'TUVXW';

  i := 1;
  while i< Length(leCodigoNE.Text) do
  begin
    if  Pos(Copy(leCodigoNE.Text, i,1), c0) <> 0 then
      cLetra := cLetra + '0'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c1) <> 0 then
      cLetra := cLetra + '1'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c2) <> 0 then
      cLetra := cLetra + '2'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c3) <> 0 then
      cLetra := cLetra + '3'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c4) <> 0 then
      cLetra := cLetra + '4'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c5) <> 0 then
      cLetra := cLetra + '5'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c6) <> 0 then
      cLetra := cLetra + '6'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c7) <> 0 then
      cLetra := cLetra + '7'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c8) <> 0 then
      cLetra := cLetra + '8'
    else if  Pos(Copy(leCodigoNE.Text, i,1), c9) <> 0 then
      cLetra := cLetra + '9';

    if i = 2 then
      giNPr := StrToInt(cLetra)
    else if i = 3 then
      giEPr := StrToInt(cLetra);
    i:=i+1;
    if (i = 3) then
      cLetra := '';
  end; }

  {captura posicao da letra}
  p1 := 'abcd';
  p2 := 'efgh';
  p3 := 'ijkl';
  p4 := 'mnop';
  p5 := 'qrst';

  if  Pos(Copy(edtGerarCodigo.Text, 4,1), p1) <> 0 then
    iOrdemLetra := 1
  else if  Pos(Copy(edtGerarCodigo.Text, 4,1), p2) <> 0 then
    iOrdemLetra := 2
  else if  Pos(Copy(edtGerarCodigo.Text, 4,1), p3) <> 0 then
    iOrdemLetra := 3
  else if  Pos(Copy(edtGerarCodigo.Text, 4,1), p4) <> 0 then
    iOrdemLetra := 4
  else if  Pos(Copy(edtGerarCodigo.Text, 4,1), p5) <> 0 then
    iOrdemLetra := 5;
  {FIM}


end;

procedure TfrmCriptografiaRSA.DecifrarNumCrip(iMult: Int64;
    iM, iD, iOrdem: integer);
var
  iPot : integer;
begin
  iPot := 2;
  while iPot <= iD do
  begin
    iMult:= iMult  * im;
    iPot := iPot + 1;
  end;
  iM := iMult mod giN;

  if (iM = 3) and (iOrdem = 1) then
    giConferirSenha := giConferirSenha +1
  else if (iM =2) and (iOrdem = 2) then
    giConferirSenha := giConferirSenha +1
  else if (iM = 5) and (iOrdem = 3) then
    giConferirSenha := giConferirSenha +1
  else if (iM = 4) and (iOrdem = 4) then
    giConferirSenha := giConferirSenha +1
  else if (iM = 6) and (iOrdem = 5) then
    giConferirSenha := giConferirSenha +1;
end;

procedure TfrmCriptografiaRSA.DecifrarNumero(Sender: TOBject);
var
  c0, c1, c2, c3, c4, c5,
    c6, c7, c8, c9, cLetra, cPonto :string;
  i : integer;
begin
  Randomize;
  c0 := 'abcde';
  c1 := 'f/hij';
  c2 := 'klmno';
  c3 := 'pqr-t';
  c4 := 'uvxyw';
  c5 := 'zABCD';
  c6 := 'EFGHI';
  c7 := 'JK+MN';
  c8 := 'OPQRS';
  c9 := 'TUVX?';
  cPonto := 'LsgW!';

  i := 1;
  while i<= Length(leSenha.Text) do
  begin
    if  Pos(Copy(leSenha.Text, i,1), copy(c0, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '0'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c1, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '1'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c2, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '2'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c3, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '3'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c4, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '4'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c5, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '5'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c6, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '6'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c7, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '7'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c8, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '8'
    else if  Pos(Copy(leSenha.Text, i,1), copy(c9, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '9'
    else if  Pos(Copy(leSenha.Text, i,1), copy(cPonto, iOrdemLetra,1)) <> 0 then
      cLetra := cLetra + '.';

    i:=i+1;
  end;
  leSenha.Text := cLetra;

end;

procedure TfrmCriptografiaRSA.CalcularNumero(Sender: TObject);
var
  iD, iTotDE, iM,
    iPot, iMult, i, iOrdem : int64;
  cMult: string;
begin
  {Procura o D}
  iD := 0;
  repeat
    iD := iD +1;
    iTotDE := giE * iD;
  until (iTotDE mod giNPar = 1);
  {FIM}

  i:=1;
  iOrdem := 0;
  giConferirSenha := 0;
  while i<= Length(leSenha.Text) do
  begin
    while (Copy(leSenha.Text, i,1) <> '.') and (i<30) do
    begin
      cMult := cMult +
        Copy(leSenha.Text, i,1);
      i:=i+1;
    end;
    iMult := StrToInt(cMult);
    iM := StrToInt(cMult);
    iOrdem := iOrdem + 1;
    DecifrarNumCrip(iMult, iM, iD, iOrdem);
    cMult := '';
    i:=i+1;

  end;

  if giConferirSenha = 5 then
    ShowMessage('Senha correta')
  else
    ShowMessage('errooooooooooooou');

end;

end.
