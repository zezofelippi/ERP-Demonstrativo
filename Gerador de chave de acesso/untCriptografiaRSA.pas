unit untCriptografiaRSA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, StrUtils, Math;

type
  TfrmCriptografiaRSA = class(TForm)
    leCodigoNE: TLabeledEdit;
    btnGerarSenha: TBitBtn;
    leResultadoNECifrado: TLabeledEdit;
    lbl3: TLabel;
    lbl5: TLabel;
    procedure btnGerarSenhaClick(Sender: TObject);
    procedure DecifrarNE(Sender: TOBject);
    procedure CifrarNumero(Sender : TOBject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCriptografiaRSA: TfrmCriptografiaRSA;
    gcChavePub : string;
    giNPr,
    giEPr,
    iOrdemLetra : Integer;

implementation

{$R *.dfm}

procedure TfrmCriptografiaRSA.btnGerarSenhaClick(Sender: TObject);
var
  i, iPot, iMult, iChavePub : Integer;
  im : Int64;
  cM : string;
begin
  DecifrarNE(Sender as TObject);

  {cifrando a palavra}
  i:= 1;
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
      iM := 6;

    {potenciação do numero}
    iPot := 2;
    iMult := iM;
    while iPot <= giEPr do
    begin
      iM := iM * iMult;
      iPot := iPot + 1;
    end;
    {FIM}
    iChavePub := iM mod giNPr;
    gcChavePub := gcChavePub + IntToStr(iChavePub) + '.';
    i:=i+1;
  end;
  CifrarNumero(Sender as TOBject);
  leResultadoNECifrado.Text := Copy(leResultadoNECifrado.Text, 1,
    length(leResultadoNECifrado.Text)-1);

end;

procedure TfrmCriptografiaRSA.CifrarNumero(Sender: TOBject);
var
  c0, c1, c2, c3, c4, c5,
    c6, c7, c8, c9, cPonto :string;
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

  leResultadoNECifrado.Text := '';
  i := 1;
  while i<= Length(gcChavePub) do
  begin
     if Copy(gcChavePub,i,1) = '0' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c0, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '1' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c1, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '2' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c2, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '3' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c3, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '4' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c4, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '5' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c5, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '6' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c6, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '7' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c7, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '8' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c8, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '9' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(c9, iOrdemLetra,1)
    else if Copy(gcChavePub,i,1) = '.' then
      leResultadoNECifrado.Text := leResultadoNECifrado.Text +
        Copy(cPonto, iOrdemLetra,1);
    i := i +1;
  end;

  if Length(leResultadoNECifrado.Text) <> Length(gcChavePub) then
  begin
    leResultadoNECifrado.Text := '';
    CifrarNumero(Sender as TObject);
  end;
  Exit;

end;

procedure TfrmCriptografiaRSA.DecifrarNE(Sender: TOBject);
var
  c0, c1, c2, c3, c4, c5,
    c6, c7, c8, c9, cLetra, p1, p2, p3, p4, p5, p6 :string;
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
  end;

  {captura posicao da letra}
  p1 := 'abcd';
  p2 := 'efgh';
  p3 := 'ijkl';
  p4 := 'mnop';
  p5 := 'qrst';
  p6 := 'uvxw';

  if  Pos(Copy(leCodigoNE.Text, i,1), p1) <> 0 then
    iOrdemLetra := 1
  else if  Pos(Copy(leCodigoNE.Text, i,1), p2) <> 0 then
    iOrdemLetra := 2
  else if  Pos(Copy(leCodigoNE.Text, i,1), p3) <> 0 then
    iOrdemLetra := 3
  else if  Pos(Copy(leCodigoNE.Text, i,1), p4) <> 0 then
    iOrdemLetra := 4
  else if  Pos(Copy(leCodigoNE.Text, i,1), p5) <> 0 then
    iOrdemLetra := 5
  else if  Pos(Copy(leCodigoNE.Text, i,1), p6) <> 0 then
    iOrdemLetra := 6;
  {FIM}


end;


end.
