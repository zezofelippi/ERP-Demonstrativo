unit untBasePesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untBase, Vcl.Grids, Vcl.DBGrids,
  Vcl.Menus, Vcl.StdCtrls, uAuxiliar, uMenu, Vcl.ExtCtrls, uComponenteStandard,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, Vcl.Mask,
  uComponenteDataControlsStandard, uComponenteDBGrid, uTabelaCampos, uPesquisa,
  System.MaskUtils, JvExControls, JvButton, JvNavigationPane, Vcl.ImgList,
  uInserirCampos, Vcl.ComCtrls, JvExMask, JvToolEdit, Vcl.DBCtrls, StrUtils,
  untBaseCadastro;

type
  TfrmBasePesquisa = class(TfrmBaseCadastro)
    tmMostrarComponentesPesquisa: TTimer;
    dtsPesquisa: TDataSource;
    cdsPesquisa: TClientDataSet;
    dspPesquisa: TDataSetProvider;
    cdsPesquisaDBGrid: TClientDataSet;
    imgLista: TImageList;
    btnPesquisar: TJvNavPanelButton;
    procedure tmMostrarComponentesPesquisaTimer(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnPesquisarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnPesquisarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnPesquisarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
    objAuxiliar : TAuxiliar;
    col, gLinha: integer;
    gbCapturando, gbAlterandoPosicao,
      gbAlterandoTamanho : boolean;
    gPt : Tpoint;

    matrizTabela:array[0..50] of array[0..50] of string;
    matrizTabelaEstrangeira:array[0..30] of array [0..30] of string;
  protected
    labelComp: TLabel;
    iContMonetario4, iContMonetario2, iContQtde: integer;

    vetorValorMonetário4:array[0..10] of string;
    vetorValorMonetário2:array[0..10] of string;
    vetorQtde:array[0..10] of string;
    procedure setaParaCima(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure funcaoRecursiva(codTabela, codTabelaEstrangeira: string);
    procedure pesquisarRegistros;

  public
    { Public declarations }
  end;

var
  frmBasePesquisa: TfrmBasePesquisa;
implementation

uses untInserirCampo;

{$R *.dfm}

procedure TfrmBasePesquisa.btnPesquisarClick(Sender: TObject);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    pesquisarRegistros;
end;

procedure TfrmBasePesquisa.btnPesquisarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if ssCtrl in Shift then
  begin
    gbCapturando := true;
    gPt.X := x;
    gPt.Y := Y;
    gbAlterandoPosicao := true;
    gbAlterandoTamanho := false;
    exit;
  end;
end;

procedure TfrmBasePesquisa.btnPesquisarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if gbCapturando then
  begin
    btnPesquisar.Left:= btnPesquisar.Left-(gPt.x-x);
    btnPesquisar.Top:= btnPesquisar.Top - (gPt.y-y);
  end;
end;

procedure TfrmBasePesquisa.btnPesquisarMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objPesquisa: TPesquisa;
begin
  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      btnPesquisar.Left:= btnPesquisar.Left-(gPt.x-x);
      btnPesquisar.Top:= btnPesquisar.Top - (gPt.y-y);
    end;

    objPesquisa:= TPesquisa.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objPesquisa.alterarPosicaoBotaoPesquisar(inttostr(self.Tag),
      btnPesquisar.Left, btnPesquisar.Top);
    FreeAndNil(objPesquisa);
  end;

end;


procedure TfrmBasePesquisa.funcaoRecursiva(codTabela, codTabelaEstrangeira: string);
var
  objPesquisaRegistros: TPesquisa;
  linha, j: integer;
begin
  objPesquisaRegistros:= TPesquisa.create;

  matrizTabela[0,col]:= codTabelaEstrangeira;
  objPesquisaRegistros.
    procurarChaveEstrangeiraAtravesDeOutraChaveEstrangeira(codTabelaEstrangeira);
  linha:=1;
  objPesquisaRegistros.objQuery.FDQuery.First;
  while not objPesquisaRegistros.objQuery.FDQuery.Eof  do
  begin
    matrizTabela[linha,col]:=
      objPesquisaRegistros.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString;

    if objPesquisaRegistros.objQuery.FDQuery.
      FieldByName('DDBDT_CODIGO').AsString = codTabela then
    begin
      j:=0;
      while j<=col do
      begin
        matrizTabelaEstrangeira[gLinha,j]:= matrizTabela[0,j];
        j:=j+1;
      end;
      FreeAndNil(objPesquisaRegistros);
      exit;
    end;

    linha:=linha + 1;
    objPesquisaRegistros.objQuery.FDQuery.Next;
  end;

  if linha=1 then
  begin
    matrizTabela[0,col]:= '';
    col:=col-1;
    linha:=2;

    while matrizTabela[linha,col]= '' do
    begin
      matrizTabela[1,col]:='';
      matrizTabela[0,col]:='';
      col:=col-1;
    end;

    linha:=1;
    while matrizTabela[linha +1, col] <> '' do
    begin
      matrizTabela[linha,col]:= matrizTabela[linha+1, col];
      linha:=linha+1;
    end;
    matrizTabela[linha,col]:= '';
  end;

  FreeAndNil(objPesquisaRegistros);
  col:=col+1;
  funcaoRecursiva(codTabela, matrizTabela[1, col-1]);

end;

procedure TfrmBasePesquisa.pesquisarRegistros;
var
  objDBGrid: TComponenteDBGrid;
  objPesquisa : TComponenteStandard;
  objDataControls: TComponenteDataControlsStandard;
  objTabelaCampos: TTabelaCampos;
  objPesquisaRegistros: TPesquisa;
  objInserirCampos: TInserirCampos;
  cdsAuxiliar: TClientDataSet;
  dspAuxiliar: TDataSetProvider;
  componente: TComponent;
  compDataInicial: TJvDateEdit;
  compDataFinal: TJvDateEdit;
  registroComValorExato, nenhumRegistroPesquisado,
    comboBoxPreenchido, campoChavePrimaria, pesquisaComLike: boolean;
  nomeTabela, campos, selectFrom, wherePesquisa, ordenar, sintaxSQL,
  wherePesquisaComValorExato: string;
  between_data, data_inicial, data_final,
    joinsSQL, tipoDeJoin, joinAux, joinAuxOficial, nomeChavePrimaria : string;
  i, i_aux, i_join, j, j_recursiva: integer;
  vetorTabela: array[0..30] of string;
  vetorGuardaTabelaJaInseridaNoJoin: array[0..100] of string;
  matrizWhere:array[0..2] of array[0..30] of string;
begin
  objPesquisa := TComponenteStandard.create;

  objPesquisa.pesquisarEdits(inttostr(self.Tag), '');

  if objPesquisa.objQuery.FDQuery.IsEmpty then
  begin
    FreeAndNil(objPesquisa);
    exit;
  end;

  objDBGrid:= TComponenteDBGrid.create;
  objTabelaCampos:= TTabelaCampos.create;
  objPesquisaRegistros:= TPesquisa.create;
  objInserirCampos:= TInserirCampos.create;
  objDataControls:= TComponenteDataControlsStandard.create;

  if not cdsPesquisaDBGrid.IsEmpty = true then
  begin
    cdsPesquisaDBGrid.Open;
    cdsPesquisaDBGrid.EmptyDataSet;
    cdsPesquisaDBGrid.Close;
    cdsPesquisaDBGrid.Open;

    {Serve p/ limpar os indeces inseridos quando clica title do DBGrid}
    TClientDataSet(dtsPesquisa.DataSet).IndexDefs.clear ;
    TClientDataSet(dtsPesquisa.DataSet).IndexName := '' ;
    {FIM}
  end;

  objDBGrid.pesquisarColunas(IntToStr(self.Tag));
  objDBGrid.objQuery.FDQuery.First;

  campos:='';
  ordenar:='';
  i:=0;
  while not objDBGrid.objQuery.FDQuery.Eof do
  begin
    i_aux := AnsiIndexText(
      objPesquisaRegistros.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString,
      vetorTabela);

    if i_aux < 0 then
    begin
      vetorTabela[i]:=
        objDBGrid.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString;
      i:=i+1;
    end;

    campos := campos +
      objDBGrid.objQuery.FDQuery.FieldByName('TABELA_FISICA').AsString + '.' +
      objDBGrid.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString + ', ';

    if (objDBGrid.objQuery.FDQuery.FieldByName('DDBDFC_TIPO').AsString = 'VARCHAR') and
       (objDBGrid.objQuery.FDQuery.FieldByName('DDBDFC_TAMANHO').AsInteger > 14 ) then
      ordenar := ordenar +
        objDBGrid.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString + ', ';

    objDBGrid.objQuery.FDQuery.Next;
  end;

  {tira a última vírgula da variável campo}
  campos := Copy(campos,1, Length(campos) -2);
  ordenar := Copy(ordenar,1, Length(ordenar) -2);
  {FIM}

  {Criando os inners e left joins de chave estrangeira ligada
  diretamente com a tabela principal}
  i := AnsiIndexText(codigoTabela, vetorTabela);
                   //criar um while até tirar todo o codigoTabela do vetorTabela
  if i>=0 then
    vetorTabela[i]:= '';

  nomeTabela := objTabelaCampos.capturarNomeFisicoDaTabela(codigoTabela);
  objPesquisaRegistros.criarLigacoesComJoins(codigoTabela);
  objPesquisaRegistros.objQuery.FDQuery.First;
  joinsSQL := nomeTabela + ' ' + nomeTabela;
  while not objPesquisaRegistros.objQuery.FDQuery.Eof do
  begin
    i := AnsiIndexText(
      objPesquisaRegistros.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString,
      vetorTabela);

    if i>=0 then
      vetorTabela[i]:= '';

    if objPesquisaRegistros.objQuery.FDQuery.
       FieldByName('DDBDCE_REQUERIDO').AsString = 'N' then
    begin
      joinsSQL := joinsSQL + ' LEFT JOIN ' +
        objPesquisaRegistros.objQuery.FDQuery.
          FieldByName('DDBDT_TABELA_FISICA').AsString + ' ' +
        objPesquisaRegistros.objQuery.FDQuery.
          FieldByName('DDBDT_TABELA_FISICA').AsString;
    end
    else
    begin
      joinsSQL := joinsSQL + ' INNER JOIN ' +
        objPesquisaRegistros.objQuery.FDQuery.
          FieldByName('DDBDT_TABELA_FISICA').AsString + ' ' +
        objPesquisaRegistros.objQuery.FDQuery.
          FieldByName('DDBDT_TABELA_FISICA').AsString;
    end;

    joinsSQL := joinsSQL + ' ON ' +
      objPesquisaRegistros.objQuery.FDQuery.
        FieldByName('DDBDT_TABELA_FISICA').AsString + '.' +
      objPesquisaRegistros.objQuery.FDQuery.
        FieldByName('DDBDCP_CAMPO_FISICO').AsString;

    joinsSQL := joinsSQL + ' = ' + nomeTabela + '.' +
      objPesquisaRegistros.objQuery.FDQuery.
        FieldByName('DDBDCP_CAMPO_FISICO').AsString;

    objPesquisaRegistros.objQuery.FDQuery.Next;
  end;
  {FIM}

  {Criando joins de chave estrangeira de outra chave estrangeira, exemplo:
   Funcionario é chave estrangeira de Vendedor, Vendedor é chave estrangeira
   de Cliente, Cliente é tabela principal}
  i:=0;
  gLinha:=0;
  while i<=30 do
  begin
    if vetorTabela[i] <> '' then
    begin
      col:=0;
      funcaoRecursiva(codigoTabela, vetorTabela[i]);
      gLinha:=gLinha + 1;
    end;
    i:=i+1;
  end;

  i:=0;
  i_join := 0;
  while i < gLinha do
  begin
    col:=0;
    while matrizTabelaEstrangeira[i,col] <> '' do
    begin
      col:=col+1;
    end;
    col:=col-1;

    objPesquisaRegistros.criarLigacoesComJoins(codigoTabela);
    objPesquisaRegistros.objQuery.FDQuery.First;

    while not objPesquisaRegistros.objQuery.FDQuery.Eof do
    begin
      if objPesquisaRegistros.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString =
        matrizTabelaEstrangeira[i,col] then
      begin
        if objPesquisaRegistros.objQuery.FDQuery.
          FieldByName('DDBDCE_REQUERIDO').AsString = 'N' then
          tipoDeJoin:=' LEFT '
        else
          tipoDeJoin:=' INNER ';
      end;

      objPesquisaRegistros.objQuery.FDQuery.Next;
    end;

    col:=col -1;

    while col > -1 do
    begin
      joinAux:='';
      i_aux := AnsiIndexText(
      matrizTabelaEstrangeira[i, col],
      vetorGuardaTabelaJaInseridaNoJoin);

      if i_aux < 0 then
      begin
        vetorGuardaTabelaJaInseridaNoJoin[i_join]:=
          matrizTabelaEstrangeira[i, col];
        i_join:=i_join +1;

        nomeTabela := objTabelaCampos.capturarNomeFisicoDaTabela(matrizTabelaEstrangeira[i,col]);
        joinAux := ' '+ tipoDeJoin + ' JOIN ' + nomeTabela + ' ' + nomeTabela + ' ON ';
        joinAux := joinAux + ' '+ nomeTabela + '.' +
        objTabelaCampos.capturarCampoChavePrimaria(matrizTabelaEstrangeira[i,col]) +
        ' = ' +
        objTabelaCampos.capturarNomeFisicoDaTabela(matrizTabelaEstrangeira[i,col + 1]) +
        '.' + objTabelaCampos.capturarCampoChavePrimaria(matrizTabelaEstrangeira[i,col]);
        joinAuxOficial:= joinAuxOficial + joinAux + ' ';
      end;
      col:=col-1;
    end;
    i:=i+1;
  end;

  nomeTabela := objTabelaCampos.capturarNomeFisicoDaTabela(codigoTabela);
 {FIM}

  if joinsSQL <> '' then
    selectFrom:='SELECT ' + campos + ' FROM ' + joinsSQL + ' ' + joinAuxOficial
  else
    selectFrom:='SELECT ' + campos + ' FROM ' + nomeTabela + ' ' + nomeTabela;

  objPesquisa.pesquisarEdits(inttostr(self.Tag), 'Ordenar');

  dspAuxiliar := TDataSetProvider(FindComponent('dspAuxiliar'));
  if dspAuxiliar = nil then
  begin
    dspAuxiliar := TDataSetProvider.Create(self);
    dspAuxiliar.Name:= 'dspAuxiliar';
    dspAuxiliar.DataSet := objPesquisa.objQuery.FDQuery;
  end;

  cdsAuxiliar := TClientDataSet(FindComponent('cdsAuxiliar'));
  if cdsAuxiliar = nil then
  begin
    cdsAuxiliar := TClientDataSet.Create(self);
    cdsAuxiliar.Name := 'cdsAuxiliar';
    cdsAuxiliar.ProviderName := dspAuxiliar.Name;
  end;

  cdsAuxiliar.Close;
  cdsAuxiliar.FetchParams;
  cdsAuxiliar.Open;
  cdsAuxiliar.First;

  {PRIMEIRO SELECIONA CAMPOS COM VALOR EXATO(ID, CPF, ETC) E OS NÃO EXATOS(NOME, ENDEREÇO)}
  nenhumRegistroPesquisado:=true;
  col:=0;
  while not cdsAuxiliar.Eof do
  begin

    if cdsAuxiliar.FieldByName('CODIGO_COMBOBOX').AsInteger = 0 then
      componente := FindComponent('edt'+
        cdsAuxiliar.FieldByName('CAMPO_FISICO').AsString)
    else
    begin
      componente := FindComponent('dbEdt'+
        cdsAuxiliar.FieldByName('CAMPO_FISICO').AsString + '_P');
    end;

    if componente is TEdit then
    begin

      compEdit:= TEdit(FindComponent('edt'+
        cdsAuxiliar.FieldByName('CAMPO_FISICO').AsString));

      if (compEdit.Text <> '') and
        (cdsAuxiliar.FieldByName('DDBDFC_TIPO').AsString = 'VARCHAR') and
        (cdsAuxiliar.FieldByName('DDBDFC_TAMANHO').AsInteger > 14) then
      begin
        matrizWhere[0,col]:= cdsAuxiliar.FieldByName('DDTCP_CODIGO').AsString;
        matrizWhere[1,col]:='L'; {L LIKE}
        matrizWhere[2,col]:='E'; {E Edit}
        col:=col +1;
        registroComValorExato:= false;
        nenhumRegistroPesquisado:= false;
      end
      else if (compEdit.Text <> '') and
        ((cdsAuxiliar.FieldByName('DDBDFC_TIPO').AsString = 'INTEGER') or
        (cdsAuxiliar.FieldByName('DDBDFC_TAMANHO').AsInteger <= 14)) then
      begin
        matrizWhere[0,col]:= cdsAuxiliar.FieldByName('DDTCP_CODIGO').AsString;
        matrizWhere[1,col]:='I'; {I IGUAL}
        matrizWhere[2,col]:='E'; {E Edit}
        col:=col +1;
        registroComValorExato:= true;
        comboBoxPreenchido:= false;
        nenhumRegistroPesquisado:= false;

        {Verifica se campo é chave primaria}
        if cdsAuxiliar.FieldByName('FORMATO_FISICO').AsString = '' then
          campoChavePrimaria:= true
        else
          campoChavePrimaria:= false;
      end;
    end
    else if componente is TMaskEdit then
    begin
      compMaskEdit:= TMaskEdit(FindComponent('edt'+
        cdsAuxiliar.FieldByName('CAMPO_FISICO').AsString));

      if not verificarSeMaskEditEstaVazio(compMaskEdit.editMask , compMaskEdit.Text) then
      begin
        matrizWhere[0,col]:= cdsAuxiliar.FieldByName('DDTCP_CODIGO').AsString;
        matrizWhere[1,col]:='I'; {I IGUAL}
        matrizWhere[2,col]:='M'; {M MaskEdit}
        col:=col +1;
        registroComValorExato:= true;
        comboBoxPreenchido:= false;
        nenhumRegistroPesquisado:= false;
      end;
    end
    else if componente is TDBLookupComboBox then
    begin
      compComboBox:= TDBLookupComboBox(FindComponent('dbEdt'+
        cdsAuxiliar.FieldByName('CAMPO_FISICO').AsString + '_C'));

      if compComboBox = nil then
        compComboBox:= TDBLookupComboBox(FindComponent('dbEdt'+
          cdsAuxiliar.FieldByName('CAMPO_FISICO').AsString + '_P'));

      if compComboBox.Text <> '' then
      begin
        matrizWhere[0,col]:= cdsAuxiliar.FieldByName('DDTCP_CODIGO').AsString;
        matrizWhere[1,col]:='I'; {I IGUAL}
        matrizWhere[2,col]:='C'; {C ComboBox}
        col:=col +1;
        registroComValorExato:= true;
        nenhumRegistroPesquisado:= false;
        comboBoxPreenchido:= true;
      end;
    end;
    cdsAuxiliar.Next;
  end;
  {FIM}

  {Verifica se haverá pesquisa entre datas}
  objInserirCampos.verificarSeExistePesquisaEntreDatas(inttostr(self.Tag));
  between_data:='';
  objInserirCampos.objQuery.FDQuery.First;
  while not objInserirCampos.objQuery.FDQuery.Eof do
  begin
    compDataInicial:= TJvDateEdit(FindComponent('edt' +
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_CODIGO').AsString + 'inicial'));

    if compDataInicial.Text <> '  /  /    ' then
    begin
      compDataFinal:= TJvDateEdit(FindComponent('edt' +
        objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_CODIGO').AsString + 'final'));

      if compDataFinal.Text <> '  /  /    ' then
      begin
        data_inicial := Copy(compDataInicial.Text,7,4) + '-' + Copy(compDataInicial.Text,4,2) + '-' + Copy(compDataInicial.Text,1,2);
        data_final := Copy(compDataFinal.Text,7,4) + Copy(compDataFinal.Text,4,2) + Copy(compDataFinal.Text,1,2);

        between_data:= ' AND ' +
          objInserirCampos.objQuery.FDQuery.FieldByName('DDBDC_CAMPO_FISICO').AsString +
            ' BETWEEN '+ #39 + data_inicial + #39 + ' AND '+ #39 + data_final + #39;
        break;
      end;
    end;
    objInserirCampos.objQuery.FDQuery.Next;
  end;
  {FIM}

  {Este while logo abaixo pega todos os campos com valor exato =}
  wherePesquisaComValorExato:='';
  col:=col-1;
  j:=0;
  while j<=col do
  begin
    pesquisaComLike:= false;

    if matrizWhere[1,j] = 'I' then
    begin
      if matrizWhere[2,j] = 'E' then
      begin
       // com o codigo da matrizWhere, pegar o nameFisico do componete
       // p/ utiliza-lo logo abaixo
        compEdit:= TEdit(FindComponent('edt' +
          objPesquisaRegistros.
          pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j])));

        if compEdit = nil then
        begin
          compEdit:= TEdit(FindComponent('edt' +
            objPesquisaRegistros.
            pegarNameFisicoChavePrimaria(matrizWhere[0,j])));

          wherePesquisaComValorExato := wherePesquisaComValorExato + ' AND (' +
            objPesquisaRegistros.
            pegarNameFisicoChavePrimaria(matrizWhere[0,j]) +
            ' = ' + QuotedStr(compEdit.Text) + ')';
        end
        else
        begin
          wherePesquisaComValorExato := wherePesquisaComValorExato + ' AND (' +
            objPesquisaRegistros.
            pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j]) +
            ' = ' + QuotedStr(compEdit.Text) + ')';
        end;
      end
      else if matrizWhere[2,j] = 'M' then
      begin
        compMaskEdit:= TMaskEdit(findComponent('edt' +
          objPesquisaRegistros.
          pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j])));

        wherePesquisaComValorExato := wherePesquisaComValorExato + ' AND (' +
          objPesquisaRegistros.
          pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j]) +
          ' = ' + QuotedStr(compMaskEdit.Text) + ')';
      end
      else if matrizWhere[2,j] = 'C' then
      begin
        compComboBox:= TDBLookupComboBox(findComponent('dbEdt' +
          objDataControls.
          pegarCampoFisicoChavePrimariaPelaTabelaTelaCampoPesquisa(matrizWhere[0,j]) + '_P'));

        {Configurar pesquisa usando comboBox}

        {Fazer uma verificacao se o campo do cdsAuxiliar é chave estrangeira
        da tabela principal, se nao for, terá que pesquisar do campo chave até
        a chave estrangeira da tabela principal}

        if objDataControls.verificaSeChaveEstrangeiraPertenceATabelaPrincipal(
         objPesquisaRegistros.
         pegarChavePrimariaAtravesDoCodigoDoComponenteNaTela(matrizWhere[0,j]), codigoTabela) = true then
        begin
          nomeTabela:=
            objDataControls.pegarNomeDaTabelaDoComboBox(inttostr(compComboBox.Tag));

          wherePesquisaComValorExato := wherePesquisaComValorExato + ' AND (' +
            nomeTabela + '.' +
            objPesquisaRegistros.
            pegarChavePrimariaAtravesDoCodigoDoComponenteNaTela(matrizWhere[0,j]) +
            ' = ' + QuotedStr(compComboBox.KeyValue) + ')';
        end
        else
        begin

          for i := 0 to 30 do
            for j_recursiva := 0 to 30 do
              matrizTabelaEstrangeira[i,j_recursiva]:='';

           for i := 0 to 50 do
            for j_recursiva := 0 to 50 do
              matrizTabela[i,j_recursiva]:='';

           col:=0;
           nomeChavePrimaria:= objPesquisaRegistros.
             pegarChavePrimariaAtravesDoCodigoDoComponenteNaTela(matrizWhere[0,j]);

           funcaoRecursiva(codigoTabela,
             objTabelaCampos.pegarCodigoDaTabelaComNomeDaChavePrimaria(
             nomeChavePrimaria));

           nomeTabela := objTabelaCampos.capturarNomeFisicoDaTabela(codigoTabela);
           i:=0;
           while matrizTabela[0,i] <> '' do
           begin
             i:=i+1;
           end;

           wherePesquisaComValorExato := wherePesquisaComValorExato + ' AND (' +
            nomeTabela + '.' +
            objTabelaCampos.capturarCampoChavePrimaria(matrizTabela[0,i-1]) +
            ' = ' + QuotedStr(compComboBox.KeyValue) + ')';
        end;
        nomeTabela := objTabelaCampos.capturarNomeFisicoDaTabela(codigoTabela);
      end;
    end;
    j:=j +1;
  end;

  {Este while logo abaixo pega todos os campos com valor like}
  j:=0;
  wherePesquisa:='';
  while j<=col do
  begin

    if matrizWhere[1,j] = 'L' then {Se for L, automaticamente é Edit}
    begin
      pesquisaComLike:= true;
      compEdit:= TEdit(FindComponent('edt' +
        objPesquisaRegistros.
        pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j])));


      wherePesquisa := wherePesquisaComValorExato + ' AND (' +
        objPesquisaRegistros.
        pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j]) +
        ' like ' + QuotedStr(compEdit.Text+ '%')+ ')';

      sintaxSQL:= selectFrom + ' WHERE 1=1 ' + wherePesquisa +
      between_data + ' ORDER BY ' + ordenar;

      objPesquisaRegistros.pesquisarRegistros(sintaxSQL);

      dspPesquisa.DataSet := objPesquisaRegistros.objQuery.FDQuery;
      cdsPesquisa.ProviderName := dspPesquisa.Name;

      cdsPesquisa.Close;
      cdsPesquisa.FetchParams;
      cdsPesquisa.Open;

      cdsPesquisaDBGrid.AppendData (cdsPesquisa.Data, true);
      cdsPesquisaDBGrid.Close;
      cdsPesquisaDBGrid.Open;

      wherePesquisa := wherePesquisaComValorExato +' AND (' +
        objPesquisaRegistros.
        pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j]) +
        ' like ' + QuotedStr('%' + compEdit.Text + '%')+ ' AND NOT ' +
        objPesquisaRegistros.
        pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j]) +
        ' like ' + QuotedStr(compEdit.Text+ '%')+ ')';

      sintaxSQL:= selectFrom + ' WHERE 1=1 ' + wherePesquisa +
        between_data + ' ORDER BY ' + ordenar;

      objPesquisaRegistros.pesquisarRegistros(sintaxSQL);

      dspPesquisa.DataSet := objPesquisaRegistros.objQuery.FDQuery;
      cdsPesquisa.ProviderName := dspPesquisa.Name;

      cdsPesquisa.Close;
      cdsPesquisa.FetchParams;
      cdsPesquisa.Open;

      cdsPesquisaDBGrid.AppendData (cdsPesquisa.Data, True);
      cdsPesquisaDBGrid.Close;
      cdsPesquisaDBGrid.Open;

      wherePesquisa := wherePesquisaComValorExato + ' AND (' +
        objPesquisaRegistros.
        pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j]) +
        ' like ' + QuotedStr('%' + compEdit.Text) + ' AND NOT ' +
        objPesquisaRegistros.
        pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j]) +
        ' like ' + QuotedStr(compEdit.Text+ '%')+ ' AND NOT ' +
        objPesquisaRegistros.
        pegarCampoNaoComboBoxParaPesquisarRegistrosNaClausulaWhere(matrizWhere[0,j]) +
        ' like ' + QuotedStr('%' + compEdit.Text+ '%')+ ')';

      sintaxSQL:= selectFrom + ' WHERE 1=1 ' + wherePesquisa +
        between_data + ' ORDER BY ' + ordenar;

      objPesquisaRegistros.pesquisarRegistros(sintaxSQL);

      dspPesquisa.DataSet := objPesquisaRegistros.objQuery.FDQuery;
      cdsPesquisa.ProviderName := dspPesquisa.Name;

      cdsPesquisa.Close;
      cdsPesquisa.FetchParams;
      cdsPesquisa.Open;

      cdsPesquisaDBGrid.AppendData (cdsPesquisa.Data, True);
      cdsPesquisaDBGrid.Close;
      cdsPesquisaDBGrid.Open;

    end;
    j:=j+1;
  end;

  if pesquisaComLike = false then
  begin
      sintaxSQL:= selectFrom + ' WHERE 1=1 ' + wherePesquisaComValorExato +
        between_data + ' ORDER BY ' + ordenar;

      objPesquisaRegistros.pesquisarRegistros(sintaxSQL);

      dspPesquisa.DataSet := objPesquisaRegistros.objQuery.FDQuery;
      cdsPesquisa.ProviderName := dspPesquisa.Name;

      cdsPesquisa.Close;
      cdsPesquisa.FetchParams;
      cdsPesquisa.Open;

      cdsPesquisaDBGrid.AppendData (cdsPesquisa.Data, True);
      cdsPesquisaDBGrid.Close;
      cdsPesquisaDBGrid.Open;
  end;

  i:=0;
  while i < iContMonetario4 do {iContMonetario4 porque o campo tem 4 casas decimais}
  begin
    (cdsPesquisaDBGrid.FieldByName(vetorValorMonetário4[i]) as TNumericField).
      DisplayFormat := 'R$#,##0.0000';
    i:=i+1;
  end;

  i:=0;
  while i < iContMonetario2 do  {iContMonetario2 porque o campo tem 2 casas decimais}
  begin
    (cdsPesquisaDBGrid.FieldByName(vetorValorMonetário2[i]) as TNumericField).
      DisplayFormat := 'R$#,##0.00';
    i:=i+1;
  end;

  i:=0;
  while i < iContQtde do {iContQtde porque o campo é do tipo qtde}
  begin
    (cdsPesquisaDBGrid.FieldByName(vetorQtde[i]) as TNumericField).
      DisplayFormat := '#,##0.000';
    i:=i+1;
  end;

  FreeAndNIL(objDBGrid);
  FreeAndNIL(objTabelaCampos);
  FreeAndNIL(objPesquisaRegistros);
  FreeAndNil(objInserirCampos);
  FreeAndNil(objDataControls);
  {FIM}

end;

procedure TfrmBasePesquisa.setaParaCima(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key =VK_UP then
    Perform(Wm_NextDlgCtl,1,0);
end;

procedure TfrmBasePesquisa.tmMostrarComponentesPesquisaTimer(Sender: TObject);
var
  objMenu : TUMenu;
  objPesquisa: TPesquisa;
begin

  {Coloca a posição do botão Pesquisar}
  objPesquisa:= TPesquisa.create;
  objPesquisa.pegarPosicaoBotaoPesquisar(inttostr(self.Tag));
  btnPesquisar.Left := objPesquisa.iLeft;
  btnPesquisar.Top  := objPesquisa.iTop;
  FreeAndNil(objPesquisa);
  {FIM}

  objMenu := TUMenu.Create;
  codigoTabela := objMenu.pegarCodigoTabela(inttostr(self.tag));
  FreeAndNil(objMenu);
  objAuxiliar := TAuxiliar.GetInstancia;
  objAuxiliar.tipoTela := 'P';

end;

initialization
  RegisterClass(TfrmBasePesquisa);

end.
