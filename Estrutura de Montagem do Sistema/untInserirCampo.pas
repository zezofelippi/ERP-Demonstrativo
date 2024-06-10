unit untInserirCampo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untBase, Vcl.ComCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, uTabelaCampos, Vcl.ExtCtrls,
  uAuxiliar, Vcl.ImgList, uInserirCampos, Vcl.StdCtrls, Vcl.Buttons,
  uComponenteDataControlsStandard, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

type
  TfrmInserirCampo = class(TfrmBase)
    tvCampos: TTreeView;
    tmMostrarDados: TTimer;
    imgIconesLista: TImageList;
    cpgCategorias: TCategoryPanelGroup;
    cpPesquisaEntreDatas: TCategoryPanel;
    edtNomePesquisaDatas: TEdit;
    lbl9: TLabel;
    edtCampoData: TEdit;
    lbl11: TLabel;
    btnDatas: TBitBtn;
    grdPesquisaEntreDatas: TDBGrid;
    popExcluirPesquisaEntreDatas: TPopupMenu;
    popItemExcluirpesquisaentredata1: TMenuItem;
    cpComboBox: TCategoryPanel;
    grdComboBox: TDBGrid;
    btnComboBox: TBitBtn;
    edtTabelaComboBox: TEdit;
    lbl1: TLabel;
    edtCampoComumCombobox: TEdit;
    lbl2: TLabel;
    edtNomeComboBox: TEdit;
    lbl3: TLabel;
    popExcluirComboBox: TPopupMenu;
    popItemExcluircombobox1: TMenuItem;
    procedure tmMostrarDadosTimer(Sender: TObject);
    procedure tvCamposCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tvCamposGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure tvCamposGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure tvCamposDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDatasClick(Sender: TObject);
    procedure edtCampoDataDblClick(Sender: TObject);
    procedure grdPesquisaEntreDatasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure edtNomePesquisaDatasEnter(Sender: TObject);
    procedure edtNomePesquisaDatasExit(Sender: TObject);
    procedure popItemExcluirpesquisaentredata1Click(Sender: TObject);
    procedure grdComboBoxDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnComboBoxClick(Sender: TObject);
    procedure edtTabelaComboBoxDblClick(Sender: TObject);
    procedure edtCampoComumComboboxDblClick(Sender: TObject);
    procedure popItemExcluircombobox1Click(Sender: TObject);
    procedure grdComboBoxDblClick(Sender: TObject);
  private
    { Private declarations }

    {Variáveis e vetores da árvore}
    gtnNo : TTreeNode;
    vetorTabelaRecursiva: array[0..100] of string;
    vetorTabelaSemChaveEstrangeira: array[0..30] of string;
    matrizTabela:array[0..50] of array[0..50] of string;
    i_1, i_2, col : integer;
    qtdePassadasNaFuncaoRecursivaMatriz: integer;
    {FIM}

    giModelagem, giPosicaoNo, gI: integer;
    codigoTabela, codigoMenu, tipoTela: string;
    codigoTabelaEstrangeira: string;
    gcVetorCodTabela  : array[1..50] of string;
    objAuxiliar: TAuxiliar;
    dspPesquisaDatas, dspComboBox: TDataSetProvider;
    cdsPesquisaDatas, cdsComboBox: TClientDataSet;
    dtsPesquisaDatas, dtsComboBox: TDataSource;
    procedure montarModelagemArvore;
    procedure RecursividadeTabelasRelacionadas(pCodTabela: string);
    procedure mostrarPesquisaEntreDatas;
    procedure mostrarCombobox;
    procedure montarEstruturaDBGrid;

    {Aba modelagem banco de dados}
    procedure funcaoRecursiva;
    procedure funcaoRecursivaMatriz;
    {FIM}

  public
    { Public declarations }

  end;

var
  frmInserirCampo: TfrmInserirCampo;

implementation

{$R *.dfm}

{ TfrmInserirCampo }

procedure TfrmInserirCampo.btnComboBoxClick(Sender: TObject);
var
  objInserirCampo: TInserirCampos;
  objDataControlStandard: TComponenteDataControlsStandard;
  objTabelaCampos: TTabelaCampos;
  codigoCampo, codigoTabelaEstrangeira: string;
begin
  if edtTabelaComboBox.text = '' then
  begin
    Application.MessageBox(Pchar('Selecione uma tabela.'),
       'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    exit;
  end;

  if edtCampoComumCombobox.text = '' then
  begin
    Application.MessageBox(Pchar('Selecione um campo.'),
       'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    exit;
  end;

  if edtNomeComboBox.text = '' then
  begin
    Application.MessageBox(Pchar('De um nome ao combobox.'),
       'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    edtNomeComboBox.SetFocus;
    exit;
  end;

  objInserirCampo:= TInserirCampos.create;
  objDataControlStandard:= TComponenteDataControlsStandard.create;
  objTabelaCampos:= TTabelaCampos.create;

  codigoTabelaEstrangeira:=
    objTabelaCampos.pegarCodigoDaTabela(edtTabelaComboBox.Text);

  codigoCampo:= objDataControlStandard.
      pegarCodigoDoCampo(edtCampoComumCombobox.Text, codigoTabelaEstrangeira);

  if objInserirCampo.cadastrarGroupBox(
    edtNomeComboBox.Text, codigoCampo, codigoTabelaEstrangeira, codigomenu) = 'Erro' then
  begin
    codigoCampo:= objInserirCampo.pegarCodigoDoCampoComDuaschavesEstrangeiras(
      edtCampoComumCombobox.Text, codigoTabelaEstrangeira);
  end;

  mostrarCombobox;

  tmMostrarDados.Enabled := true;

  FreeAndNil(objInserirCampo);
  FreeAndNil(objDataControlStandard);
  FreeAndNil(objTabelaCampos);

  edtTabelaCombobox.Clear;
  edtNomecombobox.Clear;
  edtCampoComumCombobox.Clear;

end;

procedure TfrmInserirCampo.btnDatasClick(Sender: TObject);
var
  objInserirCampo: TInserirCampos;
  objDataControlStandard: TComponenteDataControlsStandard;
  codigoCampo: string;
begin
  if edtNomePesquisaDatas.text = '' then
  begin
    Application.MessageBox(Pchar('Coloque um nome na pesquisa entre datas.'),
       'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    edtNomePesquisaDatas.SetFocus;
    exit;
  end;

  if edtCampoData.text = '' then
  begin
    Application.MessageBox(Pchar('Coloque o campo data.'),
       'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    exit;
  end;

  objInserirCampo:= TInserirCampos.create;
  objDataControlStandard:= TComponenteDataControlsStandard.create;
  objAuxiliar:= TAuxiliar.GetInstancia;

  codigoCampo:= objDataControlStandard.
      pegarCodigoDoCampo(objAuxiliar.campoSelecionado, codigoTabela);

  if objInserirCampo.cadastrarPesquisaEntreDatas(
    edtNomePesquisaDatas.Text, codigoCampo, codigoMenu) = 'Erro' then
  begin
    Application.MessageBox(Pchar('Erro no cadastro do campo data.'),
       'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;

  mostrarPesquisaEntreDatas;

  tmMostrarDados.Enabled := true;

  FreeAndNil(objInserirCampo);
  FreeAndNil(objDataControlStandard);

end;

procedure TfrmInserirCampo.edtCampoComumComboboxDblClick(Sender: TObject);
begin
   edtCampoComumCombobox.Text:= tvCampos.Items[tvCampos.Selected.AbsoluteIndex].Text;
end;

procedure TfrmInserirCampo.edtCampoDataDblClick(Sender: TObject);
var
  codigoCampo: string;
  objDataControlStandard: TComponenteDataControlsStandard;
begin
  objDataControlStandard:= TComponenteDataControlsStandard.create;

  codigoCampo:= objDataControlStandard.
      pegarCodigoDoCampo(objAuxiliar.campoSelecionado, objAuxiliar.codigoTabela);

  if objDataControlStandard.pegarTipoDoCampo(codigoCampo) <> 'TIMESTAMP' then
  begin
     Application.MessageBox(Pchar('Não é um campo data.'),
       'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
     edtCampoData.Clear;
  end;

  edtCampoData.Text :=
    tvCampos.Items[tvCampos.Selected.AbsoluteIndex].Text;

  FreeAndNil(objDataControlStandard);

end;

procedure TfrmInserirCampo.edtNomePesquisaDatasEnter(Sender: TObject);
begin
  edtNomePesquisaDatas.Color:= $00FFEAEA;;

end;

procedure TfrmInserirCampo.edtNomePesquisaDatasExit(Sender: TObject);
begin
  edtNomePesquisaDatas.Color:= clwindow;

end;

procedure TfrmInserirCampo.edtTabelaComboBoxDblClick(Sender: TObject);
var
  objTabelaCampos: TTabelaCampos;
begin
  objTabelaCampos:= TTabelaCampos.create;

  codigoTabelaEstrangeira:=
    objTabelaCampos.pegarCodigoDaTabela(
      tvCampos.Items[tvCampos.Selected.AbsoluteIndex].Text);

  edtTabelaComboBox.Text :=
    tvCampos.Items[tvCampos.Selected.AbsoluteIndex].Text;

  FreeAndNil(objTabelaCampos);
end;

procedure TfrmInserirCampo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmInserirCampo := nil;
end;

procedure TfrmInserirCampo.FormCreate(Sender: TObject);
begin
  Width := 750;
  height := 650;
end;

procedure TfrmInserirCampo.funcaoRecursiva;
var
  tabelaEChavePrimaria, i, i_linha, i_col : integer;
  tabelaEncontrada, passouNoLoop: boolean;
  objTabelaCampo: TTabelaCampos;
  objInserirCampo: TInserirCampos;
  cdsTabelaContemChaveEstrangeira, cdsAuxiliar: TClientDataSet;
  dspTabelaContemChaveEstrangeira, dspAuxiliar: TDataSetProvider;
begin
  objTabelaCampo := TTabelaCampos.create;
  objInserirCampo:= TInserirCampos.create;

  objTabelaCampo.mostrarCamposNaArvore(vetorTabelaRecursiva[i_1], codigoMenu, tipoTela);

  if objTabelaCampo.objQuery.FDQuery.IsEmpty then
  begin
    objTabelaCampo.mostrarCamposNaArvore(vetorTabelaRecursiva[i_1], '', '');
  end;

  dspAuxiliar := TDataSetProvider(FindComponent('dspAuxiliar'));
  if dspAuxiliar = nil then
  begin
    dspAuxiliar := TDataSetProvider.Create(self);
    dspAuxiliar.Name:= 'dspAuxiliar';
    dspAuxiliar.DataSet := objTabelaCampo.objQuery.FDQuery;
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

  {Cria Tabela e campo chave primaria no tree}
  if not cdsAuxiliar.IsEmpty then
  begin
    for tabelaEChavePrimaria := 0 to 1 do
    begin
      if tabelaEChavePrimaria = 0 then
      begin
        gtnNo := tvCampos.Items.AddChild(gtnNo,
          cdsAuxiliar.FieldByName('DDBDT_TABELA_APELIDO').AsString);
      end
      else
      begin
        if objInserirCampo.verificaSeCampoChavePrimariaFoiInserido(codigoMenu,
          cdsAuxiliar.FieldByName('DDBDCP_CODIGO').AsString, tipoTela) = false then
          gtnNo := tvCampos.Items.AddChild(gtnNo,
            cdsAuxiliar.FieldByName('DDBDCP_CAMPO_APELIDO').AsString);
      end;
      cdsAuxiliar.Next;
    end;
  end
  else
  begin
    gtnNo := tvCampos.Items.Add(nil,
      objTabelaCampo.captutarNomeDaTabela(codigoTabela));

    if objInserirCampo.
      verificaSeChavePrimariaNaoEstaInseridoNaTela(codigoMenu, tipoTela) = true then
    begin
      gtnNo := tvCampos.Items.AddChild(gtnNo,
        objInserirCampo.capturarChavePrimaria(codigoTabela));
    end;
  end;
  {FIM}

  objTabelaCampo.mostrarCamposNaArvore(vetorTabelaRecursiva[i_1], codigoMenu, tipoTela);

  dspAuxiliar := TDataSetProvider(FindComponent('dspAuxiliar'));
  if dspAuxiliar = nil then
  begin
    dspAuxiliar := TDataSetProvider.Create(self);
    dspAuxiliar.Name:= 'dspAuxiliar';
    dspAuxiliar.DataSet := objTabelaCampo.objQuery.FDQuery;
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

  {Cria os campos da tabela}
  if objInserirCampo.verificaSeCampoChavePrimariaFoiInserido(codigoMenu,
    cdsAuxiliar.FieldByName('DDBDCP_CODIGO').AsString, tipoTela) = true then
    passouNoLoop := false
  else
    passouNoLoop := true;

  cdsAuxiliar.First;
  while not cdsAuxiliar.Eof do
  begin
    if passouNoLoop = false then
    begin
      gtnNo := tvCampos.items.AddChild(gtnNo,
        cdsAuxiliar.FieldByName('DDBDC_CAMPO_APELIDO').AsString);
    end
    else
      tvCampos.items.addobject(gtnNo,
        cdsAuxiliar.FieldByName('DDBDC_CAMPO_APELIDO').AsString, nil);

    cdsAuxiliar.Next;
    passouNoLoop := true;
  end;
  {FIM}

  objTabelaCampo.mostrarChaveEstrangeiraNaArvore(vetorTabelaRecursiva[i_1]);

  dspTabelaContemChaveEstrangeira := TDataSetProvider(FindComponent('dspTabelaContemChaveEstrangeira'));
  if dspTabelaContemChaveEstrangeira = nil then
  begin
    dspTabelaContemChaveEstrangeira := TDataSetProvider.Create(self);
    dspTabelaContemChaveEstrangeira.Name:= 'dspTabelaContemChaveEstrangeira';
    dspTabelaContemChaveEstrangeira.DataSet := objTabelaCampo.objQuery.FDQuery;
  end;

  cdsTabelaContemChaveEstrangeira := TClientDataSet(FindComponent('cdsTabelaContemChaveEstrangeira'));
  if cdsTabelaContemChaveEstrangeira = nil then
  begin
    cdsTabelaContemChaveEstrangeira := TClientDataSet.Create(self);
    cdsTabelaContemChaveEstrangeira.Name := 'cdsTabelaContemChaveEstrangeira';
    cdsTabelaContemChaveEstrangeira.ProviderName := dspTabelaContemChaveEstrangeira.Name;
  end;

  cdsTabelaContemChaveEstrangeira.Close;
  cdsTabelaContemChaveEstrangeira.FetchParams;
  cdsTabelaContemChaveEstrangeira.Open;
  cdsTabelaContemChaveEstrangeira.First;

  if not cdsTabelaContemChaveEstrangeira.IsEmpty then
  begin
    {Coloca as chaves estrangeiras na matriz de acordo com
    suas respectivas tabelas }
    for i_col := 0 to col do
    begin
      if matrizTabela[0,i_col] = vetorTabelaRecursiva[i_1] then
      begin
        i_linha:=1;
        while i_linha < 999 do
        begin
          if matrizTabela[i_linha, i_col] = '' then
          begin
            matrizTabela[i_linha,i_col]:=
              cdsTabelaContemChaveEstrangeira.
              FieldByName('DDBDT_CODIGO').AsString;
            break;
          end
          else
            i_linha := i_linha +1;
        end;
        break;
      end
      else if matrizTabela[0,i_col] = '' then
        break;
    end;

    if (i_col > col) or (matrizTabela[0,i_col] = '') then
      i_col:=9999;

    if i_col = 9999 then
    begin
      matrizTabela[0,col]:= vetorTabelaRecursiva[i_1];
      matrizTabela[1,col]:= cdsTabelaContemChaveEstrangeira.
        FieldByName('DDBDT_CODIGO').AsString;
      col:=col +1;
    end;
    {FIM}

    i_2:=0;
    FillChar(vetorTabelaSemChaveEstrangeira, SizeOf(vetorTabelaSemChaveEstrangeira), #0);
    i_1:=i_1 + 1;

    gtnNo := tvCampos.Items.addobject(gtnNo,
      cdsTabelaContemChaveEstrangeira.
      FieldByName('DDBDCP_CAMPO_APELIDO').AsString, nil);

    vetorTabelaRecursiva[i_1]:= cdsTabelaContemChaveEstrangeira.FieldByName('DDBDT_CODIGO').AsString;
    funcaoRecursiva;
  end
  else
  begin
    vetorTabelaSemChaveEstrangeira[i_2]:= vetorTabelaRecursiva[i_1];
    i_2:=i_2 +1;
    vetorTabelaRecursiva[i_1]:= '';
    i_1:=i_1 -1;

    if vetorTabelaRecursiva[0] = '' then {verifica se vetor está vazio}
      exit; {acaba toda a recursividade aqui}

    objTabelaCampo.mostrarChaveEstrangeiraNaArvore(vetorTabelaRecursiva[i_1]);

    dspTabelaContemChaveEstrangeira := TDataSetProvider(FindComponent('dspTabelaContemChaveEstrangeira'));
    if dspTabelaContemChaveEstrangeira = nil then
    begin
      dspTabelaContemChaveEstrangeira := TDataSetProvider.Create(self);
      dspTabelaContemChaveEstrangeira.Name:= 'dspTabelaContemChaveEstrangeira';
      dspTabelaContemChaveEstrangeira.DataSet := objTabelaCampo.objQuery.FDQuery;
    end;

    cdsTabelaContemChaveEstrangeira := TClientDataSet(FindComponent('cdsTabelaContemChaveEstrangeira'));
    if cdsTabelaContemChaveEstrangeira = nil then
    begin
      cdsTabelaContemChaveEstrangeira := TClientDataSet.Create(self);
      cdsTabelaContemChaveEstrangeira.Name := 'cdsTabelaContemChaveEstrangeira';
      cdsTabelaContemChaveEstrangeira.ProviderName := dspTabelaContemChaveEstrangeira.Name;
    end;

    cdsTabelaContemChaveEstrangeira.Close;
    cdsTabelaContemChaveEstrangeira.FetchParams;
    cdsTabelaContemChaveEstrangeira.Open;
    cdsTabelaContemChaveEstrangeira.First;

    while not cdsTabelaContemChaveEstrangeira.Eof do
    begin
      {Coloca as chaves estrangeiras na matriz de acordo com
      suas respectivas tabelas }
      tabelaEncontrada:= false;
      for i_col := 0 to col do
      begin
        if matrizTabela[0,i_col] = vetorTabelaRecursiva[i_1] then
        begin
          i_linha:=1;
          while i_linha < 999 do
          begin
            if (matrizTabela[i_linha, i_col] = '') then
            begin
              matrizTabela[i_linha,i_col]:=
                cdsTabelaContemChaveEstrangeira.
                FieldByName('DDBDT_CODIGO').AsString;
              break;
            end
            else if matrizTabela[i_linha, i_col] =
               cdsTabelaContemChaveEstrangeira.FieldByName('DDBDT_CODIGO').AsString then
            begin
              tabelaEncontrada:= true;
              break;
            end
            else
              i_linha := i_linha +1;
          end;
          break;
        end;
      end;
      {FIM}

      i := AnsiIndexText(
      cdsTabelaContemChaveEstrangeira.FieldByName('DDBDT_CODIGO').AsString,
      vetorTabelaSemChaveEstrangeira);

      if (i >=0) or (tabelaEncontrada = true) then
      begin
        cdsTabelaContemChaveEstrangeira.Next;
      end
      else
      begin
        matrizTabela[0,col]:= cdsTabelaContemChaveEstrangeira.FieldByName('DDBDT_CODIGO').AsString;
        col:=col+1;
        i_1:=i_1+1;

        gtnNo := gtnNo.Parent;
        gtnNo := gtnNo.Parent;

        gtnNo := tvCampos.Items.addobject(gtnNo,
          cdsTabelaContemChaveEstrangeira.
          FieldByName('DDBDCP_CAMPO_APELIDO').AsString, nil);

        vetorTabelaRecursiva[i_1]:=
          cdsTabelaContemChaveEstrangeira.FieldByName('DDBDT_CODIGO').AsString;
        funcaoRecursiva;
        break;
      end;
    end;

  end;
  qtdePassadasNaFuncaoRecursivaMatriz:=0;
  funcaoRecursivaMatriz;

end;

procedure TfrmInserirCampo.funcaoRecursivaMatriz;
var
  objTabelaCampo: TTabelaCampos;
  cdsTabelaContemChaveEstrangeira: TClientDataSet;
  dspTabelaContemChaveEstrangeira: TDataSetProvider;
  i_linha, i_col, i: integer;
  tabelaEncontrada: boolean;
begin

  vetorTabelaRecursiva[i_1]:= '';
  i_1:=i_1-1;
  if vetorTabelaRecursiva[0] = '' then {verifica se vetor está vazio}
    exit {acaba toda a recursividade aqui}
  else
  begin
    FillChar(vetorTabelaSemChaveEstrangeira,
      SizeOf(vetorTabelaSemChaveEstrangeira), #0);

    objTabelaCampo:= TTabelaCampos.create;

    objTabelaCampo.mostrarChaveEstrangeiraNaArvore(vetorTabelaRecursiva[i_1]);

    dspTabelaContemChaveEstrangeira := TDataSetProvider(FindComponent('dspTabelaContemChaveEstrangeira'));
    if dspTabelaContemChaveEstrangeira = nil then
    begin
      dspTabelaContemChaveEstrangeira := TDataSetProvider.Create(self);
      dspTabelaContemChaveEstrangeira.Name:= 'dspTabelaContemChaveEstrangeira';
      dspTabelaContemChaveEstrangeira.DataSet := objTabelaCampo.objQuery.FDQuery;
    end;

    cdsTabelaContemChaveEstrangeira := TClientDataSet(FindComponent('cdsTabelaContemChaveEstrangeira'));
    if cdsTabelaContemChaveEstrangeira = nil then
    begin
      cdsTabelaContemChaveEstrangeira := TClientDataSet.Create(self);
      cdsTabelaContemChaveEstrangeira.Name := 'cdsTabelaContemChaveEstrangeira';
      cdsTabelaContemChaveEstrangeira.ProviderName := dspTabelaContemChaveEstrangeira.Name;
    end;

    cdsTabelaContemChaveEstrangeira.Close;
    cdsTabelaContemChaveEstrangeira.FetchParams;
    cdsTabelaContemChaveEstrangeira.Open;
    cdsTabelaContemChaveEstrangeira.First;

    while not cdsTabelaContemChaveEstrangeira.Eof do
    begin
      tabelaEncontrada:= false;
      for i_col := 0 to col do
        for i_linha:= 0 to 10 do
        begin
          if cdsTabelaContemChaveEstrangeira.
            FieldByName('DDBDT_CODIGO').AsString = matrizTabela[i_linha, i_col] then
          begin
            tabelaEncontrada:= true;
            break;
          end;
        end;

      if tabelaEncontrada = true then
      begin
        cdsTabelaContemChaveEstrangeira.Next;
      end
      else
      begin
        for i := 0 to qtdePassadasNaFuncaoRecursivaMatriz do
        begin
          if i = 0 then
          begin
            gtnNo := gtnNo.Parent;
            gtnNo := gtnNo.Parent;
            gtnNo := gtnNo.Parent;
            gtnNo := gtnNo.Parent;
            gtnNo := gtnNo.Parent;
          end
          else
          begin
            gtnNo := gtnNo.Parent;
            gtnNo := gtnNo.Parent;
          end;
        end;
        gtnNo := tvCampos.Items.AddChild(gtnNo,
          cdsTabelaContemChaveEstrangeira.FieldByName('DDBDCP_CAMPO_APELIDO').AsString);

        i_1:=i_1 + 1;
        vetorTabelaRecursiva[i_1]:=
          cdsTabelaContemChaveEstrangeira.FieldByName('DDBDT_CODIGO').AsString;
        funcaoRecursiva;
        break;
      end;
    end;
    qtdePassadasNaFuncaoRecursivaMatriz:= qtdePassadasNaFuncaoRecursivaMatriz +1;
    funcaoRecursivaMatriz;
  end;

end;

procedure TfrmInserirCampo.grdComboBoxDblClick(Sender: TObject);
begin
  objAuxiliar:= TAuxiliar.GetInstancia;
  objAuxiliar.campoSelecionado:= cdsComboBox.FieldByName('DDCB_CODIGO').AsString;
  objAuxiliar.tipoDeComponenteSelecionado:='comboBox';
  screen.cursor := crDrag;
end;

procedure TfrmInserirCampo.grdComboBoxDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdComboBox.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdComboBox.Canvas.Font.Color:= clBlack;

  grdComboBox.Canvas.FillRect(Rect);
  grdComboBox.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmInserirCampo.grdPesquisaEntreDatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdPesquisaEntreDatas.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdPesquisaEntreDatas.Canvas.Font.Color:= clBlack;

  grdPesquisaEntreDatas.Canvas.FillRect(Rect);
  grdPesquisaEntreDatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmInserirCampo.montarEstruturaDBGrid;
begin

  grdPesquisaEntreDatas.Columns[0].FieldName := 'DDPED_NOME_PESQUISA';
  grdPesquisaEntreDatas.Columns[0].Title.Caption := 'Nome da pesquisa';
  grdPesquisaEntreDatas.Columns[0].Width := 220;

  grdPesquisaEntreDatas.Columns[1].FieldName := 'DDBDC_CAMPO_APELIDO';
  grdPesquisaEntreDatas.Columns[1].Title.Caption := 'Campo data';
  grdPesquisaEntreDatas.Columns[1].Width := 150;

  grdComboBox.Columns[0].FieldName := 'DDCB_NOME_COMBOBOX';
  grdComboBox.Columns[0].Title.Caption := 'Nome do combobox';
  grdComboBox.Columns[0].Width := 150;

  grdComboBox.Columns[1].FieldName := 'DDBDT_TABELA_APELIDO';
  grdComboBox.Columns[1].Title.Caption := 'Nome do tabela';
  grdComboBox.Columns[1].Width := 120;

  grdComboBox.Columns[2].FieldName := 'DDBDC_CAMPO_APELIDO';
  grdComboBox.Columns[2].Title.Caption := 'Nome do campo';
  grdComboBox.Columns[2].Width := 130;


end;

procedure TfrmInserirCampo.montarModelagemArvore;
var
  iModelagem : integer;
  objTabelaCampo: TTabelaCampos;
  objInserirCampo : TInserirCampos;
  cdsMostrarCampos : TClientDataSet;
  dspMostrarCampos : TDataSetProvider;
  passouNoLoop : boolean;
begin
  tvCampos.Items.Clear;
  giModelagem :=0;

  objInserirCampo := TInserirCampos.create;

  objTabelaCampo := TTabelaCampos.create;
  objTabelaCampo.mostrarCamposNaArvore(codigoTabela, codigoMenu, tipoTela);

  dspMostrarCampos := TDataSetProvider(FindComponent('dspMostrarCampos'));
  if dspMostrarCampos = nil then
  begin
    dspMostrarCampos := TDataSetProvider.Create(self);
    dspMostrarCampos.Name:= 'dspMostrarCampos';
    dspMostrarCampos.DataSet := objTabelaCampo.objQuery.FDQuery;
  end;

  cdsMostrarCampos := TClientDataSet(FindComponent('cdsMostrarCampos'));
  if cdsMostrarCampos = nil then
  begin
    cdsMostrarCampos := TClientDataSet.Create(self);
    cdsMostrarCampos.Name := 'cdsMostrarCampos';
    cdsMostrarCampos.ProviderName := dspMostrarCampos.Name;
  end;

  cdsMostrarCampos.Close;
  cdsMostrarCampos.FetchParams;
  cdsMostrarCampos.Open;
  cdsMostrarCampos.First;

  {Cria Tabela e campo chave primaria no tree}
  if not cdsMostrarCampos.IsEmpty then
  begin
    for iModelagem := 0 to 1 do
    begin
      if iModelagem = 0 then
      begin
        gtnNo := tvCampos.Items.Add(nil,
          cdsMostrarCampos.FieldByName('DDBDT_TABELA_APELIDO').AsString);
      end
      else
      begin
        if objInserirCampo.verificaSeCampoChavePrimariaFoiInserido(codigoMenu,
          cdsMostrarCampos.FieldByName('DDBDCP_CODIGO').AsString, tipoTela) = false then
          gtnNo := tvCampos.Items.AddChild(gtnNo,
            cdsMostrarCampos.FieldByName('DDBDCP_CAMPO_APELIDO').AsString);
      end;
      cdsMostrarCampos.Next;
    end;
    giModelagem := giModelagem + iModelagem;
  end
  else
  begin
    gtnNo := tvCampos.Items.Add(nil,
      objTabelaCampo.captutarNomeDaTabela(codigoTabela));

    if objInserirCampo.
      verificaSeChavePrimariaNaoEstaInseridoNaTela(codigoMenu, tipoTela) = true then
    begin
      gtnNo := tvCampos.Items.AddChild(gtnNo,
        objInserirCampo.capturarChavePrimaria(codigoTabela));
    end;
  end;
  {FIM}

  {Cria os campos da tabela}
  if objInserirCampo.verificaSeCampoChavePrimariaFoiInserido(codigoMenu,
    cdsMostrarCampos.FieldByName('DDBDCP_CODIGO').AsString, tipoTela) = true then
    passouNoLoop := false
  else
    passouNoLoop := true;

  cdsMostrarCampos.First;
  while not cdsMostrarCampos.Eof do
  begin
    if passouNoLoop = false then
    begin
      gtnNo := tvCampos.items.AddChild(gtnNo,
        cdsMostrarCampos.FieldByName('DDBDC_CAMPO_APELIDO').AsString);
    end
    else
      tvCampos.items.addobject(gtnNo,
        cdsMostrarCampos.FieldByName('DDBDC_CAMPO_APELIDO').AsString, nil);

    cdsMostrarCampos.Next;
    passouNoLoop := true;
  end;
  {FIM}

  objTabelaCampo.mostrarChaveEstrangeiraNaArvore(codigoTabela);

  dspMostrarCampos := TDataSetProvider(FindComponent('dspMostrarCampos'));
  if dspMostrarCampos = nil then
  begin
    dspMostrarCampos := TDataSetProvider.Create(self);
    dspMostrarCampos.Name:= 'dspMostrarCampos';
    dspMostrarCampos.DataSet := objTabelaCampo.objQuery.FDQuery;
  end;

  cdsMostrarCampos := TClientDataSet(FindComponent('cdsMostrarCampos'));
  if cdsMostrarCampos = nil then
  begin
    cdsMostrarCampos := TClientDataSet.Create(self);
    cdsMostrarCampos.Name := 'cdsMostrarCampos';
    cdsMostrarCampos.ProviderName := dspMostrarCampos.Name;
  end;

  cdsMostrarCampos.Close;
  cdsMostrarCampos.FetchParams;
  cdsMostrarCampos.Open;
  cdsMostrarCampos.First;

  giPosicaoNo := 0;
  giModelagem := tvCampos.Items.Count;

  while not cdsMostrarCampos.Eof do
  begin
    i_1:=0; {pertence ao índice do vetor vetorTabelaRecursiva}
    i_2:=0; {pertence ao índice do vetor vetorTabelaSemChaveEstrangeira}

    {lIMPAR VETORES}
    FillChar(vetorTabelaSemChaveEstrangeira, SizeOf(vetorTabelaSemChaveEstrangeira), #0);
    FillChar(matrizTabela, SizeOf(matrizTabela), #0);
    {FIM}

    gtnNo := tvCampos.Items.addobject(gtnNo,
      cdsMostrarCampos.FieldByName('DDBDCP_CAMPO_APELIDO').AsString, nil);

    vetorTabelaRecursiva[i_1]:= cdsMostrarCampos.FieldByName('DDBDT_CODIGO').AsString;
    col:=0;

    funcaoRecursiva;
    gtnNo:= tvCampos.Items[0];
    gtnNo := gtnNo.GetNext;
    cdsMostrarCampos.Next;
   
  end;
  {FIm Cria as chaves estrangeiras da tabela}
  FreeAndNil(objTabelaCampo);
  FreeAndNil(objInserirCampo);

end;

procedure TfrmInserirCampo.mostrarCombobox;
var
  objInserirCampos: TInserirCampos;
begin
  objInserirCampos:= TInserirCampos.create;
  objInserirCampos.mostrarComboBox(codigoMenu, objAuxiliar.tipoTela);

  dspComboBox:= TDataSetProvider(FindComponent('dspComboBox'));
  if dspComboBox = nil then
  begin
    dspComboBox := TDataSetProvider.Create(self);
    dspComboBox.Name:= 'dspComboBox';
    dspComboBox.DataSet := objInserirCampos.objQuery.FDQuery;
  end;

  cdsComboBox := TClientDataSet(FindComponent('cdsComboBox'));
  if cdsComboBox = nil then
  begin
    cdsComboBox := TClientDataSet.Create(self);
    cdsComboBox.Name := 'cdsComboBox';
    cdsComboBox.ProviderName := dspComboBox.Name;
  end;

  dtsComboBox := TDataSource(FindComponent('dtsComboBox'));
  if dtsComboBox = nil then
  begin
    dtsComboBox := TDataSource.Create(self);
    dtsComboBox.Name := 'dtsComboBox';
    dtsComboBox.DataSet := cdsComboBox;
  end;

  cdsComboBox.Close;
  cdsComboBox.FetchParams;
  cdsComboBox.Open;

  grdComboBox.DataSource:= dtsComboBox;

  FreeAndNil(objInserirCampos);
end;

procedure TfrmInserirCampo.mostrarPesquisaEntreDatas;
var
  objInserirCampos: TInserirCampos;
begin
  objInserirCampos:= TInserirCampos.create;
  objInserirCampos.verificarSeExistePesquisaEntreDatas(codigoMenu);

  dspPesquisaDatas := TDataSetProvider(FindComponent('dspPesquisaDatas'));
  if dspPesquisaDatas = nil then
  begin
    dspPesquisaDatas := TDataSetProvider.Create(self);
    dspPesquisaDatas.Name:= 'dspPesquisaDatas';
    dspPesquisaDatas.DataSet := objInserirCampos.objQuery.FDQuery;
  end;

  cdsPesquisaDatas := TClientDataSet(FindComponent('cdsPesquisaDatas'));
  if cdsPesquisaDatas = nil then
  begin
    cdsPesquisaDatas := TClientDataSet.Create(self);
    cdsPesquisaDatas.Name := 'cdsPesquisaDatas';
    cdsPesquisaDatas.ProviderName := dspPesquisaDatas.Name;
  end;

  dtsPesquisaDatas := TDataSource(FindComponent('dtsPesquisaDatas'));
  if dtsPesquisaDatas = nil then
  begin
    dtsPesquisaDatas := TDataSource.Create(self);
    dtsPesquisaDatas.Name := 'dtsPesquisaDatas';
    dtsPesquisaDatas.DataSet := cdsPesquisaDatas;
  end;

  cdsPesquisaDatas.Close;
  cdsPesquisaDatas.FetchParams;
  cdsPesquisaDatas.Open;

  grdPesquisaEntreDatas.DataSource:= dtsPesquisaDatas;

  FreeAndNil(objInserirCampos);

end;

procedure TfrmInserirCampo.popItemExcluircombobox1Click(Sender: TObject);
var
  objInserirCampos: TInserirCampos;
begin

  case MessageBox (Application.Handle, Pchar ('Tem certeza que deseja excluir Combobox?'),'Erro',
    MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2) of
  IDNO:
  begin
    Exit;
  end;
  end;

  objInserirCampos:= TInserirCampos.create;

  if objInserirCampos.excluirComboBox(
    cdsComboBox.FieldByName('DDCB_CODIGO').AsString) = 'Erro' then
  begin
    Application.MessageBox(Pchar('O componente está sendo usado em alguma tela, '+
       ' exclua-o primeiro da tela.'),
       'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
  end;

  mostrarCombobox;

  tmMostrarDados.Enabled := true;

  FreeAndNil(objInserirCampos);

end;

procedure TfrmInserirCampo.popItemExcluirpesquisaentredata1Click(
  Sender: TObject);
var
  objInserirCampos: TInserirCampos;
begin

  case MessageBox (Application.Handle, Pchar ('Tem certeza que deseja excluir?'),'Erro',
    MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2) of
  IDNO:
  begin
    Exit;
  end;
  end;

  objInserirCampos:= TInserirCampos.create;

  if objInserirCampos.excluirPesquisaEntreDatas(
    cdsPesquisaDatas.FieldByName('DDPED_CODIGO').AsString) = 'Erro' then
  begin
    Application.MessageBox(Pchar('Erro na exclusão da data.'),
       'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;

  mostrarPesquisaEntreDatas;

  tmMostrarDados.Enabled := true;

  FreeAndNil(objInserirCampos);

end;

procedure TfrmInserirCampo.RecursividadeTabelasRelacionadas(pCodTabela: string);
var
  cNomeNode : string;
  i_recursivo: integer;
  objTabelaCampo : TTabelaCampos;
  objInserirCampo: TInserirCampos;
begin
  objTabelaCampo := TTabelaCampos.create;
  objTabelaCampo.mostrarCamposNaArvore(pCodTabela, codigoMenu, tipoTela);
  objTabelaCampo.objQuery.FDQuery.First;

  if objTabelaCampo.objQuery.FDQuery.
     FieldByName('DDBDCP_CAMPO_APELIDO').AsString <> '' then
    gtnNo := tvCampos.Items.AddChild(gtnNo,
      objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_APELIDO').AsString)
  else
  begin
    objInserirCampo:= TInserirCampos.create;
    gtnNo := tvCampos.Items.AddChild(gtnNo,
      objInserirCampo.capturarChavePrimaria(pCodTabela));
    FreeAndNil(objInserirCampo);
    objTabelaCampo.mostrarCamposNaArvore(pCodTabela, codigoMenu, tipoTela);
    objTabelaCampo.objQuery.FDQuery.First;
  end;

  while not objTabelaCampo.objQuery.FDQuery.Eof do
  begin
    tvCampos.items.addobject(gtnNo,
      objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDC_CAMPO_APELIDO').AsString,
      nil);
    
    objTabelaCampo.objQuery.FDQuery.Next;
  end;

  objTabelaCampo.mostrarChaveEstrangeiraNaArvore(pCodTabela);
  objTabelaCampo.objQuery.FDQuery.First;

  gtnNo.GetLastChild;
  cNomeNode := gtnNo.Text;

  while not objTabelaCampo.objQuery.FDQuery.Eof do
  begin
    {localizando se há registro no vetor}
    i_recursivo := AnsiIndexText(pCodTabela +
      objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString,
      gcVetorCodTabela);
    {FIM}

    if (i_recursivo < 0) and
       (objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString <>
         codigoTabela) then
    begin
      gtnNo := tvCampos.Items.Addobject(gtnNo,
        objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_APELIDO').AsString,
        nil);

      gtnNo := tvCampos.Items.AddChild(gtnNo,
        objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDT_TABELA_APELIDO').AsString);

    end;

    {Função recursiva}
    if (i_recursivo < 0) and
       (objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString <>
         codigoTabela) then
    begin
      gcVetorCodTabela[gI] := pCodTabela +
        objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString;
      gI := gI +1;
      RecursividadeTabelasRelacionadas(
        objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString);
    end;
    {FIM}

    i_recursivo := giPosicaoNo;
    gtnNo := tvCampos.Items[i_recursivo];
    while (cNomeNode <> gtnNo.Text) do
    begin
      i_recursivo := i_recursivo +1;
      gtnNo := tvCampos.Items[i_recursivo];
    end;
    gtnNo := tvCampos.Items[i_recursivo +2];{exemplo do porque é somado
     + 2, exemplo: quando é encontrado o Cod.cliente precisa descer mais
     2 nós (1º nó CLIENTE, 2º nó Cod.cliente};
  end;

  FreeAndNil(objTabelaCampo);

end;

procedure TfrmInserirCampo.tmMostrarDadosTimer(Sender: TObject);
begin
  objAuxiliar :=TAuxiliar.GetInstancia;
  codigoTabela := objAuxiliar.codigoTabela;
  codigoMenu := objAuxiliar.codigoMenu;
  tipoTela := objAuxiliar.tipoTela;
  montarModelagemArvore;
  montarEstruturaDBGrid;

  if objAuxiliar.tipoTela = 'P' then
    mostrarPesquisaEntreDatas
  else
    cpPesquisaEntreDatas.Visible:= false;

  if objAuxiliar.tipoTela = 'G' then
    cpComboBox.Visible:= false
  else
    cpComboBox.Visible:= true;

  mostrarCombobox;
  tmMostrarDados.Enabled := false;

  {Aqui é quando já foi montado a modelagem da árvore}
  objAuxiliar.inserindoColunaNaDBGrid:= false;

  tvCampos.FullExpand;
end;

procedure TfrmInserirCampo.tvCamposCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  {Mudando cor de item selecionado no tvCampos}
  with tvCampos.Canvas do
  begin
    if cdsSelected in State then
    begin
      Font.Color := CLblack;
      Font.Style :=[FSBOLD];
      Brush.Color := tvCampos.Color;
    end;
  end;
  {FIM}

end;

procedure TfrmInserirCampo.tvCamposDblClick(Sender: TObject);
var
  Nodo : TTreeNode;
begin
  objAuxiliar.campoSelecionado :=
    tvCampos.Items[tvCampos.Selected.AbsoluteIndex].Text;

  if tvCampos.Items[tvCampos.Selected.AbsoluteIndex].Level >= 3 then
  begin
    Nodo:= tvCampos.Items[tvCampos.Selected.AbsoluteIndex].Parent;
    objAuxiliar.nomeTabela:= Nodo.Text;
  end;
 
  if tvCampos.Items[tvCampos.Selected.AbsoluteIndex].ImageIndex = 3 then
    objAuxiliar.tipoCampo := 'C'
  else if tvCampos.Items[tvCampos.Selected.AbsoluteIndex].ImageIndex = 1 then
    objAuxiliar.tipoCampo := 'CP';

  objAuxiliar.tipoDeComponenteSelecionado:='edits';

  if objAuxiliar.tipoTela = 'G' then
   objAuxiliar.inserindoColunaNaDBGrid:= true;

  screen.cursor := crDrag;
end;

procedure TfrmInserirCampo.tvCamposGetImageIndex(Sender: TObject;
  Node: TTreeNode);
var
  objInserirCampos : TInserirCampos;
begin
  objInserirCampos := TInserirCampos.create;

  if node.Level = 0 then
    Node.ImageIndex := 0
  else if not Node.HasChildren then
  begin
    if Node.Index = 0 then
    begin
      if objInserirCampos.verificaSeCampoEChavePrimaria(
        node.text) = true then
        Node.ImageIndex := 1
      else
        if Node.GetPrev.ImageIndex = 2 then
          Node.ImageIndex := 0
        else
          Node.ImageIndex := 3;
    end
    else
      Node.ImageIndex := 3;
  end
  else if not (node.Level = 0) and (Node.HasChildren) then
  begin
    if Node.GetNext.HasChildren then
      Node.ImageIndex := 2
    else
    begin
      if (Node.GetPrev.ImageIndex = 0) or
         (Node.GetPrev.ImageIndex = 1) or
         (Node.GetPrev.ImageIndex = 3) then
        Node.ImageIndex := 2
      else
        Node.ImageIndex := 0;
    end;
  end;

  FreeAndNil(objInserirCampos);
end;

procedure TfrmInserirCampo.tvCamposGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  {Aqui é p/ manter o mesmo ícone do item selecionado no treeview}
  Node.SelectedIndex := Node.ImageIndex;
  {FIM}
end;

end.
