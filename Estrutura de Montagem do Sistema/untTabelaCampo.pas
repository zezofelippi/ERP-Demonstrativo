unit untTabelaCampo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.ComCtrls,
  Datasnap.Provider, Datasnap.DBClient, Data.DB, StrUtils, Vcl.Menus,
  Vcl.ImgList, uFDQuery, uTabelaCampos, JvExControls, JvButton,
  JvTransparentButton, JvNavigationPane, untBase;

type
  TfrmTabelaCampo = class(TfrmBase)
    pgcBancoDados: TPageControl;
    tshCriacaoCampos: TTabSheet;
    rpbDadosGerais: TGroupBox;
    rdgCampoObrigatorio: TRadioGroup;
    grdCampos: TDBGrid;
    tshCriacaoTabelas: TTabSheet;
    rpb1: TGroupBox;
    rpb2: TGroupBox;
    rdgChaveEstrangeiraObrigatoria: TRadioGroup;
    grdTabelasRelacionadas: TDBGrid;
    tshModelagemBD: TTabSheet;
    rpb3: TGroupBox;
    tvTabelas: TTreeView;
    rpb4: TGroupBox;
    cboTabelaModelagem: TDBLookupComboBox;
    popAbrirFechar: TPopupMenu;
    Abrirrvore1: TMenuItem;
    Fecharrvore1: TMenuItem;
    imgIconesLista: TImageList;
    imgIcone: TImage;
    popCampo: TPopupMenu;
    Alterarcampo1: TMenuItem;
    lbl1: TLabel;
    edtNomeTabela: TEdit;
    edtCampoChave: TEdit;
    lbl9: TLabel;
    btnGravarTabelas: TJvNavPanelButton;
    lbl10: TLabel;
    cboTabelas: TDBLookupComboBox;
    lbl11: TLabel;
    cboTabelasRelacionadas: TDBLookupComboBox;
    btnInserirTabRel: TJvNavPanelButton;
    lbl2: TLabel;
    cboTabelaCampo: TDBLookupComboBox;
    lbl3: TLabel;
    edtNomeCampo: TEdit;
    lbl4: TLabel;
    edtDescricaoCampo: TEdit;
    lbl5: TLabel;
    cboFormatoCampo: TDBLookupComboBox;
    btnGravarCampo: TJvNavPanelButton;
    lbl6: TLabel;
    popItemExcluircampo1: TMenuItem;
    imgIconesAltExcluir: TImageList;
    procedure FormShow(Sender: TObject);
    procedure leDescricaoCampoExit(Sender: TObject);
    procedure Abrirrvore1Click(Sender: TObject);
    procedure Fecharrvore1Click(Sender: TObject);
    procedure tvTabelasCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure grdTabelasRelacionadasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdCamposDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure tvTabelasGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure tvTabelasGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure grdCamposTitleClick(Column: TColumn);
    procedure Alterarcampo1Click(Sender: TObject);
    procedure cboTabelaModelagemEnter(Sender: TObject);
    procedure cboTabelaModelagemExit(Sender: TObject);
    procedure leCampoChaveChange(Sender: TObject);
    procedure edtNomeTabelaEnter(Sender: TObject);
    procedure edtCampoChaveEnter(Sender: TObject);
    procedure edtNomeTabelaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCampoChaveKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarTabelasClick(Sender: TObject);
    procedure edtNomeTabelaExit(Sender: TObject);
    procedure edtCampoChaveExit(Sender: TObject);
    procedure cboTabelasCloseUp(Sender: TObject);
    procedure cboTabelasEnter(Sender: TObject);
    procedure cboTabelasExit(Sender: TObject);
    procedure cboTabelasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboTabelasRelacionadasEnter(Sender: TObject);
    procedure btnInserirTabRelClick(Sender: TObject);
    procedure cboTabelasRelacionadasExit(Sender: TObject);
    procedure cboTabelaCampoCloseUp(Sender: TObject);
    procedure cboTabelaCampoEnter(Sender: TObject);
    procedure cboTabelaCampoExit(Sender: TObject);
    procedure cboTabelaCampoKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeCampoChange(Sender: TObject);
    procedure edtDescricaoCampoEnter(Sender: TObject);
    procedure edtNomeCampoKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescricaoCampoChange(Sender: TObject);
    procedure edtDescricaoCampoKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeCampoEnter(Sender: TObject);
    procedure cboFormatoCampoEnter(Sender: TObject);
    procedure cboFormatoCampoExit(Sender: TObject);
    procedure edtNomeCampoExit(Sender: TObject);
    procedure edtDescricaoCampoExit(Sender: TObject);
    procedure btnGravarCampoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboTabelaCampoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure criarAvoreDeTabelas(Sender: TObject);
    procedure cboTabelaModelagemCloseUp(Sender: TObject);
    procedure cboTabelaModelagemKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboTabelasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure popItemExcluircampo1Click(Sender: TObject);

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

    codCampo, nomeAntigoCampo: string;
    dtsTabela, dtsTabelaRelacionada,
      dtsTabelasQueSeraoRelacionadas,
      dtsFormatoCampo, dtsCampo : TDataSource;
    cdsTabela, cdsTabelaRelacionada,
      cdsTabelasQueSeraoRelacionadas,
      cdsFormatoCampo, cdsCampo : TClientDataSet;
    dspTabela, dspTabelaRelacionada,
      dspTabelasQueSeraoRelacionadas,
      dspFormatoCampo, dspCampo : TDataSetProvider;

    {Aba tabela/chave primaria/chave estrangeira}
    procedure MostrarTabelasRelacionadasNaGrid;
    procedure MostrarTabelasRelacionadasNoCombo;
    procedure LimpaTabelasRelacionadas;
    procedure montarEstruturaDBGridTabelasRelacionada;
    procedure LimpaTabelas;
    {FIM}

    {Aba criação dos campos}
    procedure mostrarDadosDosCampos(pCampoOrdenacao: string);
    procedure MostrarFormatoCampo;
    procedure montarEstruturaDBGridCampos;
    procedure LimpaCampos;
    {FIM}

    {Aba modelagem banco de dados}
    procedure funcaoRecursiva;
    procedure funcaoRecursivaMatriz;
    procedure MontarModelagemBancoDados;
    procedure MontarModelagemOutrasTabelas;
    {FIM}

    procedure MostrarTabelasComboBox(cCodComboBox: string);
    procedure montarEstruturaComboBox;

  public
    { Public declarations }
  end;

var
  frmTabelaCampo: TfrmTabelaCampo;

implementation

{$R *.dfm}

uses untMenu;

procedure TfrmTabelaCampo.Abrirrvore1Click(Sender: TObject);
begin
  tvTabelas.FullExpand;
end;

procedure TfrmTabelaCampo.Alterarcampo1Click(Sender: TObject);
begin

  if grdCampos.Fields[4].AsString = '' then
  begin
    Application.MessageBox(Pchar('Campo chave não pode ser alterado. '),
      'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    Exit;
  end;
  codCampo:= cdsCampo.FieldByName('CODIGO').AsString;
  nomeAntigoCampo:= cdsCampo.FieldByName('CAMPO_FISICO').AsString;
  edtNomeCampo.Text := grdCampos.Fields[1].AsString;
  edtDescricaoCampo.Text := grdCampos.Fields[3].AsString;
  cboFormatoCampo.KeyValue := cdsCampo.FieldByName('CODIGO_TIPO').AsString;
  cboTabelaCampo.Enabled := false;
  cboFormatoCampo.Enabled := false;
  rdgCampoObrigatorio.Enabled := false;

  edtNomeCampo.SetFocus;

  btnGravarCampo.Tag :=1;

end;

procedure TfrmTabelaCampo.btnInserirTabRelClick(Sender: TObject);
var
  objTabelaCampos : TTabelaCampos;
  requerido : string;
begin
  if (cboTabelas.Text = '') or (cboTabelasRelacionadas.Text = '') then
  begin
    Application.MessageBox(Pchar('Insira a tabela principal e a relacionada'),
          'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    cboTabelas.SetFocus;
    Exit;
  end;
  if rdgChaveEstrangeiraObrigatoria.ItemIndex = -1 then
  begin
    Application.MessageBox(Pchar('Chave estrangeira é obrigatória, sim ou não?'),
          'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    cboTabelas.SetFocus;
    Exit;
  end;

  objTabelaCampos := TTabelaCampos.create;

  if rdgChaveEstrangeiraObrigatoria.ItemIndex = 0 then
    requerido := 'S'
  else
    requerido := 'N';

  objTabelaCampos.cadastrarChaveEstrangeira(
    cboTabelas.KeyValue, cboTabelasRelacionadas.KeyValue, requerido);

  objTabelaCampos.criarChaveEstrangeira(
    RetirarCaracteresEspeciais(cboTabelas.Text),
    RetirarCaracteresEspeciais(cboTabelasRelacionadas.Text));

  LimpaTabelasRelacionadas;

  MostrarTabelasRelacionadasNaGrid;
  MostrarTabelasRelacionadasNoCombo;

end;

procedure TfrmTabelaCampo.btnGravarCampoClick(Sender: TObject);
var
  objTabelaCampo: TTabelaCampos;
  campoObrigatorio, tipoCampo, tamanho: string;
begin
  if cboTabelaCampo.Text = '' then
  begin
    Application.MessageBox(Pchar('Insira uma tabela antes de inserir os campos '),
          'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    cboTabelaCampo.SetFocus;
    Exit;
  end
  else if edtNomeCampo.Text = EmptyStr then
  begin
    Application.MessageBox(Pchar('Insira um nome para o campo.'),
          'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    edtNomeCampo.SetFocus;
    Exit;
  end
  else if edtDescricaoCampo.Text = EmptyStr then
  begin
    Application.MessageBox(Pchar('Insira uma descrição para o campo.'),
          'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    edtDescricaoCampo.SetFocus;
    Exit;
  end;

  if btnGravarCampo.Tag = 0 then
  begin
    if cboFormatoCampo.Text = '' then
    begin
      Application.MessageBox(Pchar('Insira um formato para o campo.'),
            'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
      cboFormatoCampo.SetFocus;
      Exit;
    end;

    if rdgCampoObrigatorio.ItemIndex = 0 then
      campoObrigatorio := 'S'
    else
      campoObrigatorio := 'N';
  end;

  objTabelaCampo:= TTabelaCampos.create;

  tipoCampo := objTabelaCampo.capturarTipoCampo(cboFormatoCampo.KeyValue);
  tamanho :=  objTabelaCampo.capturarTamanhoCampo(cboFormatoCampo.KeyValue);

  if btnGravarCampo.Tag = 0 then
  begin
    objTabelaCampo.cadastrarCampo(
      RetirarCaracteresEspeciais(cboTabelaCampo.Text),
      cboFormatoCampo.KeyValue,
      RetirarCaracteresEspeciais(edtNomeCampo.Text), edtNomeCampo.Text,
      edtDescricaoCampo.Text, campoObrigatorio);

    objTabelaCampo.criarCampo(RetirarCaracteresEspeciais(cboTabelaCampo.Text),
      RetirarCaracteresEspeciais(edtNomeCampo.Text),
      tipoCampo, tamanho, campoObrigatorio);
  end
  else
  begin
    objTabelaCampo.alterarCadastroDoCampo(
      RetirarCaracteresEspeciais(cboTabelaCampo.Text),
      codCampo,
      RetirarCaracteresEspeciais(edtNomeCampo.Text),
      edtNomeCampo.Text, edtDescricaoCampo.Text);

    objTabelaCampo.alterarCampoFisico(
      RetirarCaracteresEspeciais(cboTabelaCampo.Text),
      nomeAntigoCampo,
      RetirarCaracteresEspeciais(edtNomeCampo.Text),tipoCampo, tamanho);
  end;

  FreeAndNil(objTabelaCampo);

  mostrarDadosDosCampos('');
  LimpaCampos;
  edtNomeCampo.SetFocus;

end;

procedure TfrmTabelaCampo.btnGravarTabelasClick(Sender: TObject);
var
  objTabelaCampo : TTabelaCampos;
begin
  if edtNomeTabela.Text = '' then
  begin
    Application.MessageBox(Pchar('Insira um nome para a tabela'),
          'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    edtNomeTabela.SetFocus;
    Exit;
  end;

  objTabelaCampo := TTabelaCampos.create;
  objTabelaCampo.cadastrarTabela(RetirarCaracteresEspeciais(edtNomeTabela.Text),
    edtNomeTabela.Text);
  objTabelaCampo.cadastrarChavePrimaria(
    RetirarCaracteresEspeciais(edtNomeTabela.Text),
    RetirarCaracteresEspeciais(edtCampoChave.Text),
      edtCampoChave.Text);
  objTabelaCampo.criarTabelaComChavePrimaria(
    RetirarCaracteresEspeciais(edtNomeTabela.Text),
    RetirarCaracteresEspeciais(edtCampoChave.Text));

  FreeAndNil(objTabelaCampo);

  MostrarTabelasComboBox('1');
  LimpaTabelas;
  edtNomeTabela.SetFocus;

end;

procedure TfrmTabelaCampo.cboTabelasRelacionadasEnter(Sender: TObject);
begin
  cboTabelasRelacionadas.Color:= $00FFEAEA;
end;

procedure TfrmTabelaCampo.cboTabelasRelacionadasExit(Sender: TObject);
begin
  cboTabelasRelacionadas.Color := clwindow;
end;

procedure TfrmTabelaCampo.criarAvoreDeTabelas(Sender: TObject);
begin
  if cboTabelaModelagem.Text = '' then
    exit;

  tvTabelas.Items.Clear;
  MontarModelagemBancoDados;
  MontarModelagemOutrasTabelas;
end;

procedure TfrmTabelaCampo.cboFormatoCampoEnter(Sender: TObject);
begin
  cboFormatoCampo.Color :=$00FFEAEA;
end;

procedure TfrmTabelaCampo.cboFormatoCampoExit(Sender: TObject);
begin
  cboFormatoCampo.Color := clwindow;
end;

procedure TfrmTabelaCampo.cboTabelaCampoCloseUp(Sender: TObject);
begin
  if cboTabelaCampo.Text = '' then
    Exit;
  mostrarDadosDosCampos('');
end;

procedure TfrmTabelaCampo.cboTabelaCampoEnter(Sender: TObject);
begin
  cboTabelaCampo.Color:= $00FFEAEA;
  MostrarTabelasComboBox('2');
end;

procedure TfrmTabelaCampo.cboTabelaCampoExit(Sender: TObject);
begin
  cboTabelaCampo.Color := clWindow;
end;

procedure TfrmTabelaCampo.cboTabelaCampoKeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
    edtNomeCampo.SetFocus;
end;

procedure TfrmTabelaCampo.cboTabelaCampoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if cboTabelaCampo.Text = '' then
    Exit;
  mostrarDadosDosCampos('');
end;

procedure TfrmTabelaCampo.cboTabelasCloseUp(Sender: TObject);
begin
  if cboTabelas.Text = '' then
    Exit;

  MostrarTabelasRelacionadasNaGrid;
  MostrarTabelasRelacionadasNoCombo;
end;

procedure TfrmTabelaCampo.cboTabelasEnter(Sender: TObject);
begin
  cboTabelas.Color :=$00FFEAEA;
  MostrarTabelasComboBox('1');
end;

procedure TfrmTabelaCampo.cboTabelasExit(Sender: TObject);
begin
  cboTabelas.Color := clWindow;
end;

procedure TfrmTabelaCampo.cboTabelasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if KEY =VK_back then
    cboTabelas.KeyValue :=-1;
end;

procedure TfrmTabelaCampo.cboTabelasKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if cboTabelas.Text = '' then
    Exit;

  MostrarTabelasRelacionadasNaGrid;
  MostrarTabelasRelacionadasNoCombo;
end;

procedure TfrmTabelaCampo.cboTabelaModelagemCloseUp(Sender: TObject);
begin
  criarAvoreDeTabelas(Sender as TObject);
end;

procedure TfrmTabelaCampo.cboTabelaModelagemEnter(Sender: TObject);
begin
  cboTabelaModelagem.Color := $00FFEAEA;
  MostrarTabelasComboBox('3');
end;

procedure TfrmTabelaCampo.cboTabelaModelagemExit(Sender: TObject);
begin
  cboTabelaModelagem.Color := clWindow;
end;

procedure TfrmTabelaCampo.cboTabelaModelagemKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  criarAvoreDeTabelas(Sender as TObject);
end;

procedure TfrmTabelaCampo.edtCampoChaveEnter(Sender: TObject);
begin
  edtCampoChave.Color :=  $00FFEAEA;
end;

procedure TfrmTabelaCampo.edtCampoChaveExit(Sender: TObject);
begin
  edtCampoChave.color := clwindow;
end;

procedure TfrmTabelaCampo.edtCampoChaveKeyPress(Sender: TObject; var Key: Char);
begin
  If  key in['0'..'9'] then
    key:=#0;

  if key =#13 then
    btnGravarTabelas.Click;
end;

procedure TfrmTabelaCampo.edtNomeCampoChange(Sender: TObject);
begin
  if Length(edtNomeCampo.Text) = 1 then
  begin
    edtNomeCampo.Text := UpperCase(edtNomeCampo.Text);
    edtNomeCampo.SelStart := 1;
  end;
end;

procedure TfrmTabelaCampo.edtNomeCampoEnter(Sender: TObject);
begin
  edtNomeCampo.Color :=$00FFEAEA;
end;

procedure TfrmTabelaCampo.edtNomeCampoExit(Sender: TObject);
begin
  edtNomeCampo.Color := clwindow;
end;

procedure TfrmTabelaCampo.edtDescricaoCampoChange(Sender: TObject);
begin
  if Length(edtDescricaoCampo.Text) = 1 then
  begin
    edtDescricaoCampo.Text := UpperCase(edtDescricaoCampo.Text);
    edtDescricaoCampo.SelStart := 1;
  end;
end;

procedure TfrmTabelaCampo.edtDescricaoCampoEnter(Sender: TObject);
begin
  edtDescricaoCampo.Color := $00FFEAEA;
end;

procedure TfrmTabelaCampo.edtDescricaoCampoExit(Sender: TObject);
begin
  edtDescricaoCampo.Color := clwindow;
end;

procedure TfrmTabelaCampo.edtDescricaoCampoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
    cboFormatoCampo.SetFocus;
end;

procedure TfrmTabelaCampo.edtNomeCampoKeyPress(Sender: TObject; var Key: Char);
begin
  If  key in['0'..'9'] then
    key:=#0;

  if Key =#13 then
    edtDescricaoCampo.SetFocus;
end;

procedure TfrmTabelaCampo.edtNomeTabelaEnter(Sender: TObject);
begin
  edtNomeTabela.Color :=  $00FFEAEA;
end;

procedure TfrmTabelaCampo.edtNomeTabelaExit(Sender: TObject);
begin
  edtNomeTabela.Color := clwindow;
end;

procedure TfrmTabelaCampo.edtNomeTabelaKeyPress(Sender: TObject; var Key: Char);
begin
  If  key in['0'..'9'] then
    key:=#0;

  if key =#13 then
    edtCampoChave.SetFocus;
end;

procedure TfrmTabelaCampo.Fecharrvore1Click(Sender: TObject);
begin
  tvTabelas.FullCollapse;
end;

procedure TfrmTabelaCampo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmTabelaCampo := nil;
end;

procedure TfrmTabelaCampo.FormShow(Sender: TObject);
var
  i: integer;
begin
  inherited;
  i:=1;
  while i<4 do
  begin
    MostrarTabelasComboBox(IntToStr(i));
    i:=i+1;
  end;

  MostrarFormatoCampo;
  montarEstruturaDBGridCampos;
  montarEstruturaDBGridTabelasRelacionada;
  montarEstruturaComboBox;

  LimpaCampos;
  LimpaTabelasRelacionadas;
  LimpaTabelas;

  pgcBancoDados.ActivePageIndex :=0;

  btnGravarCampo.Tag :=0;

end;

procedure TfrmTabelaCampo.funcaoRecursiva;
var
  tabelaEChavePrimaria, i, i_linha, i_col : integer;
  tabelaEncontrada: boolean;
  objTabelaCampo: TTabelaCampos;
  cdsTabelaContemChaveEstrangeira: TClientDataSet;
  dspTabelaContemChaveEstrangeira: TDataSetProvider;
begin
  objTabelaCampo := TTabelaCampos.create;
  objTabelaCampo.mostrarCamposNaArvore(vetorTabelaRecursiva[i_1], '', '');
  objTabelaCampo.objQuery.FDQuery.First;

  {Cria Tabela e campo chave primaria no tree}
  for tabelaEChavePrimaria := 0 to 1 do
  begin
    if tabelaEChavePrimaria = 0 then
    begin
      gtnNo := tvTabelas.Items.AddChild(gtnNo,
        objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDT_TABELA_APELIDO').AsString);
    end
    else
    begin
      gtnNo := tvTabelas.Items.AddChild(gtnNo,
        objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_APELIDO').AsString);
    end;
    objTabelaCampo.objQuery.FDQuery.Next;
  end;
  {FIM}

  {Cria os campos da tabela}
  objTabelaCampo.objQuery.FDQuery.First;
  while not objTabelaCampo.objQuery.FDQuery.Eof do
  begin
    tvTabelas.items.addobject(gtnNo,
      objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDC_CAMPO_APELIDO').AsString,
      nil);
    objTabelaCampo.objQuery.FDQuery.Next;
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

    gtnNo := tvTabelas.Items.addobject(gtnNo,
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

        gtnNo := tvTabelas.Items.addobject(gtnNo,
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

procedure TfrmTabelaCampo.funcaoRecursivaMatriz;
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
        gtnNo := tvTabelas.Items.AddChild(gtnNo,
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

procedure TfrmTabelaCampo.grdCamposDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  vl_icone : TIcon;
begin
  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdCampos.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdCampos.Canvas.Font.Color:= clBlack;
  grdCampos.Canvas.FillRect(Rect);
  grdCampos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.Index = 0 then
  begin
    vl_icone := TIcon.Create;
    grdCampos.Canvas.FillRect(Rect);

    if grdCampos.Fields[4].AsString <> '' then
      imgIconesLista.GetIcon(3,imgIcone.Picture.Icon)
    else
    begin
      imgIconesLista.GetIcon(1,imgIcone.Picture.Icon);
    end;

    vl_icone := imgIcone.Picture.Icon;
    grdCampos.Canvas.Draw((Rect.Right - Rect.Left - vl_icone.Width) div 2 + Rect.Left,
      (Rect.Bottom - Rect.Top - vl_icone.Height) div 2 + Rect.Top, vl_icone);
  end;

end;

procedure TfrmTabelaCampo.grdCamposTitleClick(Column: TColumn);
var
  campoOrdenacao : string;
begin
  if cboTabelaCampo.Text = '' then
  begin
    Application.MessageBox(Pchar('Selecione uma tabela.'),
       'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    cboTabelaCampo.SetFocus;
    Exit;
  end;

  campoOrdenacao := column.fieldname;

  if campoOrdenacao = 'CAMPO_APELIDO' then
    campoOrdenacao := '2'
  else if campoOrdenacao = 'CAMPO_FISICO' then
    campoOrdenacao := '3'
  else if campoOrdenacao = 'DESCRICAO_CAMPO' then
    campoOrdenacao := '4'
  else if campoOrdenacao = 'DESCRICAO_CAMPO_FORMATO' then
    campoOrdenacao := '5'
  else if campoOrdenacao = 'TIPO' then
    campoOrdenacao := '6'
  else if campoOrdenacao = 'TAMANHO' then
    campoOrdenacao := '7'
  else if campoOrdenacao = 'CASA_DECIMAL' then
    campoOrdenacao := '8'
  else if campoOrdenacao = 'REQUERIDO' then
    campoOrdenacao := '9'
  else
    campoOrdenacao :='';

  mostrarDadosDosCampos(campoOrdenacao);
end;

procedure TfrmTabelaCampo.grdTabelasRelacionadasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  vl_icone : TIcon;
begin
  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdTabelasRelacionadas.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdTabelasRelacionadas.Canvas.Font.Color:= clBlack;
  grdTabelasRelacionadas.Canvas.FillRect(Rect);
  grdTabelasRelacionadas.DefaultDrawColumnCell(Rect, DataCol, Column, State);


  if Column.Index = 0 then
  begin
    vl_icone := TIcon.Create;
    grdTabelasRelacionadas.Canvas.FillRect(Rect);
    imgIconesLista.GetIcon(0,imgIcone.Picture.Icon);
    vl_icone := imgIcone.Picture.Icon;
    grdTabelasRelacionadas.Canvas.Draw((Rect.Right - Rect.Left - vl_icone.Width) div 2 + Rect.Left,
      (Rect.Bottom - Rect.Top - vl_icone.Height) div 2 + Rect.Top, vl_icone);
  end;
  if Column.Index = 2 then
  begin
    vl_icone := TIcon.Create;
    grdTabelasRelacionadas.Canvas.FillRect(Rect);
    imgIconesLista.GetIcon(2,imgIcone.Picture.Icon);
    vl_icone := imgIcone.Picture.Icon;
    grdTabelasRelacionadas.Canvas.Draw((Rect.Right - Rect.Left - vl_icone.Width) div 2 + Rect.Left,
      (Rect.Bottom - Rect.Top - vl_icone.Height) div 2 + Rect.Top, vl_icone);
  end;
end;

procedure TfrmTabelaCampo.leCampoChaveChange(Sender: TObject);
begin
  if Length(edtCampoChave.Text) = 1 then
  begin
    edtCampoChave.Text := UpperCase(edtCampoChave.Text);
    edtCampoChave.SelStart := 1;
  end;

end;

procedure TfrmTabelaCampo.leDescricaoCampoExit(Sender: TObject);
begin
  edtDescricaoCampo.Color := clWhite;
end;

procedure TfrmTabelaCampo.LimpaCampos;
begin
  edtNomeCampo.Clear;
  edtDescricaoCampo.Clear;
  cboFormatoCampo.KeyValue := -1;
  rdgCampoObrigatorio.ItemIndex:=-1;
end;

procedure TfrmTabelaCampo.LimpaTabelas;
begin
  edtNomeTabela.Clear;
  edtCampoChave.Clear;
end;

procedure TfrmTabelaCampo.LimpaTabelasRelacionadas;
begin
  rdgChaveEstrangeiraObrigatoria.ItemIndex :=-1;
  cboTabelasRelacionadas.KeyValue :=-1;
end;

procedure TfrmTabelaCampo.montarEstruturaComboBox;
begin
  cboTabelas.KeyField := 'DDBDT_CODIGO';
  cboTabelas.ListField := 'DDBDT_TABELA_APELIDO';
  cboTabelaCampo.KeyField := 'DDBDT_CODIGO';
  cboTabelaCampo.ListField := 'DDBDT_TABELA_APELIDO';
  cboTabelaModelagem.KeyField := 'DDBDT_CODIGO';
  cboTabelaModelagem.ListField := 'DDBDT_TABELA_APELIDO';
end;

procedure TfrmTabelaCampo.montarEstruturaDBGridCampos;
begin
  grdCampos.Columns[1].FieldName := 'CAMPO_APELIDO';
  grdCampos.Columns[1].Title.Caption := 'Nome do campo';
  grdCampos.Columns[1].Width := 200;

  grdCampos.Columns[2].FieldName := 'CAMPO_FISICO';
  grdCampos.Columns[2].Title.Caption := 'Nome técnico do campo';
  grdCampos.Columns[2].Width := 180;

  grdCampos.Columns[3].FieldName := 'DESCRICAO_CAMPO';
  grdCampos.Columns[3].Title.Caption := 'Descrição sobre o campo';
  grdCampos.Columns[3].Width := 285;

  grdCampos.Columns[4].FieldName := 'DESCRICAO_CAMPO_FORMATO';
  grdCampos.Columns[4].Title.Caption := 'Formato do campo';
  grdCampos.Columns[4].Width := 140;

  grdCampos.Columns[5].FieldName := 'TIPO';
  grdCampos.Columns[5].Title.Caption := 'Tipo do campo';
  grdCampos.Columns[5].Width := 110;

  grdCampos.Columns[6].FieldName := 'TAMANHO';
  grdCampos.Columns[6].Title.Caption := 'Tam.';
  grdCampos.Columns[6].Width := 40;

  grdCampos.Columns[7].FieldName := 'CASA_DECIMAL';
  grdCampos.Columns[7].Title.Caption := 'Dec.';
  grdCampos.Columns[7].Width := 35;

  grdCampos.Columns[8].FieldName := 'REQUERIDO';
  grdCampos.Columns[8].Title.Caption := '*';
  grdCampos.Columns[8].Width := 20;

end;

procedure TfrmTabelaCampo.montarEstruturaDBGridTabelasRelacionada;
begin
  grdTabelasRelacionadas.DataSource := dtsTabelaRelacionada;
  grdTabelasRelacionadas.Columns[1].FieldName := 'DDBDT_TABELA_APELIDO';
  grdTabelasRelacionadas.Columns[1].Width := 220;

  grdTabelasRelacionadas.Columns[3].FieldName := 'DDBDCP_CAMPO_APELIDO';
  grdTabelasRelacionadas.Columns[3].Width := 220;

  grdTabelasRelacionadas.Columns[4].FieldName := 'DDBDCE_REQUERIDO';
end;

procedure TfrmTabelaCampo.MostrarTabelasComboBox(cCodComboBox: string);
var
  objTabelaCampos : TTabelaCampos;
begin

  objTabelaCampos := TTabelaCampos.create;
  objTabelaCampos.mostrarTabelas;

  dspTabela := TDataSetProvider(FindComponent('dspTabela'));
  if dspTabela = nil then
  begin
    dspTabela := TDataSetProvider.Create(self);
    dspTabela.Name:= 'dspTabela';
    dspTabela.DataSet := objTabelaCampos.objQuery.FDQuery;
  end;

  cdsTabela := TClientDataSet(FindComponent('cdsTabela'));
  if cdsTabela = nil then
  begin
    cdsTabela := TClientDataSet.Create(self);
    cdsTabela.Name := 'cdsTabela';
    cdsTabela.ProviderName := dspTabela.Name;
  end;

  dtsTabela := TDataSource(FindComponent('dtsTabela'));
  if dtsTabela = nil then
  begin
    dtsTabela := TDataSource.Create(self);
    dtsTabela.Name := 'dtsTabela';
    dtsTabela.DataSet := cdsTabela;
  end;

  cdsTabela.Close;
  cdsTabela.FetchParams;
  cdsTabela.Open;

  FreeAndNil(objTabelaCampos);

  if cCodComboBox = '1' then
    cboTabelas.ListSource := dtsTabela
  else if cCodComboBox = '2' then
    cboTabelaCampo.ListSource := dtsTabela
  else if cCodComboBox = '3' then
    cboTabelaModelagem.ListSource := dtsTabela;

end;

procedure TfrmTabelaCampo.MostrarTabelasRelacionadasNaGrid;
var
  objTabelaCampos : TTabelaCampos;
begin
  objTabelaCampos := TTabelaCampos.create;
  objTabelaCampos.mostrarTabelasRelacionadas(cboTabelas.KeyValue);

  dspTabelaRelacionada := TDataSetProvider(FindComponent('dspTabelaRelacionada'));
  if dspTabelaRelacionada = nil then
  begin
    dspTabelaRelacionada := TDataSetProvider.Create(self);
    dspTabelaRelacionada.Name:= 'dspTabelaRelacionada';
    dspTabelaRelacionada.DataSet := objTabelaCampos.objQuery.FDQuery;
  end;

  cdsTabelaRelacionada := TClientDataSet(FindComponent('cdsTabelaRelacionada'));
  if cdsTabelaRelacionada = nil then
  begin
    cdsTabelaRelacionada := TClientDataSet.Create(self);
    cdsTabelaRelacionada.Name := 'cdsTabelaRelacionada';
    cdsTabelaRelacionada.ProviderName := dspTabelaRelacionada.Name;
  end;

  dtsTabelaRelacionada := TDataSource(FindComponent('dtsTabelaRelacionada'));
  if dtsTabelaRelacionada = nil then
  begin
    dtsTabelaRelacionada := TDataSource.Create(self);
    dtsTabelaRelacionada.Name := 'dtsTabelaRelacionada';
    dtsTabelaRelacionada.DataSet := cdsTabelaRelacionada;
  end;

  cdsTabelaRelacionada.Close;
  cdsTabelaRelacionada.FetchParams;
  cdsTabelaRelacionada.Open;

  grdTabelasRelacionadas.DataSource := dtsTabelaRelacionada;

  FreeAndNil(objTabelaCampos);

end;

procedure TfrmTabelaCampo.MostrarTabelasRelacionadasNoCombo;
var
 objTabelaCampos : TTabelaCampos;
begin

  objTabelaCampos := TTabelaCampos.create;

  objTabelaCampos.mostrarTabelasQueSeraoRelacionadas(
    cboTabelas.KeyValue);

  dspTabelasQueSeraoRelacionadas := TDataSetProvider(FindComponent('dspTabelasQueSeraoRelacionadas'));
  if dspTabelasQueSeraoRelacionadas = nil then
  begin
    dspTabelasQueSeraoRelacionadas := TDataSetProvider.Create(self);
    dspTabelasQueSeraoRelacionadas.Name:= 'dspTabelasQueSeraoRelacionadas';
    dspTabelasQueSeraoRelacionadas.DataSet := objTabelaCampos.objQuery.FDQuery;
  end;

  cdsTabelasQueSeraoRelacionadas := TClientDataSet(FindComponent('cdsTabelasQueSeraoRelacionadas'));
  if cdsTabelasQueSeraoRelacionadas = nil then
  begin
    cdsTabelasQueSeraoRelacionadas := TClientDataSet.Create(self);
    cdsTabelasQueSeraoRelacionadas.Name := 'cdsTabelasQueSeraoRelacionadas';
    cdsTabelasQueSeraoRelacionadas.ProviderName := dspTabelasQueSeraoRelacionadas.Name;
  end;

  dtsTabelasQueSeraoRelacionadas := TDataSource(FindComponent('dtsTabelasQueSeraoRelacionadas'));
  if dtsTabelasQueSeraoRelacionadas = nil then
  begin
    dtsTabelasQueSeraoRelacionadas := TDataSource.Create(self);
    dtsTabelasQueSeraoRelacionadas.Name := 'dtsTabelasQueSeraoRelacionadas';
    dtsTabelasQueSeraoRelacionadas.DataSet := cdsTabelasQueSeraoRelacionadas;
  end;

  cboTabelasRelacionadas.KeyField := 'DDBDT_CODIGO';
  cboTabelasRelacionadas.ListField := 'DDBDT_TABELA_APELIDO';
  cboTabelasRelacionadas.ListSource := dtsTabelasQueSeraoRelacionadas;

  cdsTabelasQueSeraoRelacionadas.Close;
  cdsTabelasQueSeraoRelacionadas.FetchParams;
  cdsTabelasQueSeraoRelacionadas.Open;

  FreeAndNil(objTabelaCampos);

end;

procedure TfrmTabelaCampo.popItemExcluircampo1Click(Sender: TObject);
var
  objTabelaCampos: TTabelaCampos;
begin

  case MessageBox (Application.Handle, Pchar ('Tem certeza que deseja '+
    'excluir o campo ' + cdsCampo.FieldByName('CAMPO_APELIDO').AsString +'?'),'Alerta',
    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) of
  IDNO:
  begin
    Exit;
  end;
  end;

  objTabelaCampos:= TTabelaCampos.create;

  if objTabelaCampos.verificarSeCampoContemRegistro(
    cdsCampo.FieldByName('CAMPO_FISICO').AsString, cboTabelaCampo.Text) = false then
  begin
    IF objTabelaCampos.excluirCampo(cboTabelaCampo.Text,
      cdsCampo.FieldByName('CAMPO_FISICO').AsString,
      cdsCampo.FieldByName('CODIGO').AsString ) = 'Erro'then
    begin
      Application.MessageBox(Pchar('Erro ao excluir o campo.'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
    end;
  end
  else
  begin
    Application.MessageBox(Pchar('Campo não pode ser excluído porque contém registros'),
      'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
  end;

  FreeAndNil(objTabelaCampos);
  mostrarDadosDosCampos('');

end;


procedure TfrmTabelaCampo.tvTabelasCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  {colocando cor no nó}
  if Node.Text = cboTabelaModelagem.Text then
  begin
    Node.TreeView.Canvas.Font.Color := $00A67000;
    Node.TreeView.Canvas.Font.Style := [fsBold];
  end
  else
    Node.TreeView.Canvas.Font.Color := clblack;
  {FIM}

  {Mudando cor de item selecionado no tvTabelas}
  with tvTabelas.Canvas do
  begin
    if cdsSelected in State then
    begin
      Font.Color := CLblack;
      Font.Style :=[FSBOLD];
      Brush.Color := tvTabelas.Color;
    end;
  end;
  {FIM}

end;

procedure TfrmTabelaCampo.tvTabelasGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if node.Level = 0 then
    Node.ImageIndex := 0
  else if not Node.HasChildren then
  begin
    if Node.Index = 0 then
      Node.ImageIndex := 1
    else
      Node.ImageIndex := 3;
  end
  else if not (node.Level = 0) and (Node.HasChildren) then
  begin
    if Node.GetNext.HasChildren then
      Node.ImageIndex := 2
    else
    begin
      Node.ImageIndex := 0;
    end;
  end;
end;

procedure TfrmTabelaCampo.tvTabelasGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  {Aqui é p/ manter o mesmo ícone do item selecionado no treeview}
  Node.SelectedIndex := Node.ImageIndex;
  {FIM}
end;

procedure TfrmTabelaCampo.MontarModelagemBancoDados;
var
  tabelaEChavePrimaria : integer;
  objTabelaCampo: TTabelaCampos;
  cdsTabelaCampo : TClientDataSet;
  dspTabelaCampo: TDataSetProvider;
begin
  objTabelaCampo := TTabelaCampos.create;
  objTabelaCampo.mostrarCamposNaArvore(cboTabelaModelagem.KeyValue, '', '');
  objTabelaCampo.objQuery.FDQuery.First;

  {Cria Tabela e campo chave primaria no tree}
  for tabelaEChavePrimaria := 0 to 1 do
  begin
    if tabelaEChavePrimaria = 0 then
    begin
      gtnNo := tvTabelas.Items.Add(nil,
        objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDT_TABELA_APELIDO').AsString);
    end
    else
    begin
      gtnNo := tvTabelas.Items.AddChild(gtnNo,
        objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_APELIDO').AsString);
    end;

    objTabelaCampo.objQuery.FDQuery.Next;
  end;
  {FIM}

  {Cria os campos da tabela}
  objTabelaCampo.objQuery.FDQuery.First;
  while not objTabelaCampo.objQuery.FDQuery.Eof do
  begin
    tvTabelas.items.addobject(gtnNo,
      objTabelaCampo.objQuery.FDQuery.FieldByName('DDBDC_CAMPO_APELIDO').AsString,
      nil);
    objTabelaCampo.objQuery.FDQuery.Next;
  end;
  {FIM}

  objTabelaCampo.mostrarChaveEstrangeiraNaArvore(cboTabelaModelagem.KeyValue);

  dspTabelaCampo := TDataSetProvider(FindComponent('dspTabelaCampo'));
  if dspTabelaCampo = nil then
  begin
    dspTabelaCampo := TDataSetProvider.Create(self);
    dspTabelaCampo.Name:= 'dspTabelaCampo';
    dspTabelaCampo.DataSet := objTabelaCampo.objQuery.FDQuery;
  end;

  cdsTabelaCampo := TClientDataSet(FindComponent('cdsTabelaCampo'));
  if cdsTabelaCampo = nil then
  begin
    cdsTabelaCampo := TClientDataSet.Create(self);
    cdsTabelaCampo.Name := 'cdsTabelaCampo';
    cdsTabelaCampo.ProviderName := dspTabelaCampo.Name;
  end;

  cdsTabelaCampo.Close;
  cdsTabelaCampo.FetchParams;
  cdsTabelaCampo.Open;
  cdsTabelaCampo.First;

  while not cdsTabelaCampo.Eof do
  begin
    i_1:=0; {pertence ao índice do vetor vetorTabelaRecursiva}
    i_2:=0; {pertence ao índice do vetor vetorTabelaSemChaveEstrangeira}

    {lIMPAR VETORES}
    FillChar(vetorTabelaSemChaveEstrangeira, SizeOf(vetorTabelaSemChaveEstrangeira), #0);
    FillChar(matrizTabela, SizeOf(matrizTabela), #0);
    {FIM}

    gtnNo := tvTabelas.Items.addobject(gtnNo,
      cdsTabelaCampo.FieldByName('DDBDCP_CAMPO_APELIDO').AsString, nil);

    vetorTabelaRecursiva[i_1]:= cdsTabelaCampo.FieldByName('DDBDT_CODIGO').AsString;
    col:=0;

    funcaoRecursiva;
    gtnNo:= tvTabelas.Items[0];
    gtnNo := gtnNo.GetNext;
    cdsTabelaCampo.Next;

  end;

  FreeAndNil(objTabelaCampo);

end;

procedure TfrmTabelaCampo.MontarModelagemOutrasTabelas;
VAR
  dspArvore : TDataSetProvider;
  cdsArvore : TClientDataSet;
  objTabelaCampo : TTabelaCampos;
  tabelaEChavePrimaria: integer;

begin
  objTabelaCampo := TTabelaCampos.create;
  objTabelaCampo.mostrarTabelaPrincipalComoChaveEstrangeiraDeOutraTabela(cboTabelaModelagem.KeyValue);

  dspArvore := TDataSetProvider(FindComponent('dspArvore'));
  if dspArvore = nil then
  begin
    dspArvore := TDataSetProvider.Create(self);
    dspArvore.Name:= 'dspArvore';
    dspArvore.DataSet := objTabelaCampo.objQuery.FDQuery;
  end;

  cdsArvore := TClientDataSet(FindComponent('cdsArvore'));
  if cdsArvore = nil then
  begin
    cdsArvore := TClientDataSet.Create(self);
    cdsArvore.Name := 'cdsArvore';
    cdsArvore.ProviderName := dspArvore.Name;
  end;

  cdsArvore.Close;
  cdsArvore.FetchParams;
  cdsArvore.Open;

  cdsArvore.First;
  while not cdsArvore.Eof do
  begin

    for tabelaEChavePrimaria := 0 to 1 do
    begin
      if tabelaEChavePrimaria = 0 then
      begin
        gtnNo := tvTabelas.Items.Add(nil,
          cdsArvore.FieldByName('TABELA_PRINCIPAL').AsString);
      end
      else
      begin
        gtnNo := tvTabelas.Items.AddChild(gtnNo,
          cdsArvore.FieldByName('CHAVE_PRIMARIA_PRINCIPAL').AsString);
      end;
    end;

    gtnNo := tvTabelas.Items.addobject(gtnNo,
      cdsArvore.FieldByName('CHAVE_ESTRANGEIRA').AsString, nil);

    gtnNo := tvTabelas.Items.AddChild(gtnNo,
      cdsArvore.FieldByName('TABELA_ESTRANGEIRA').AsString);

    gtnNo := tvTabelas.Items.AddChild(gtnNo,
      cdsArvore.FieldByName('CHAVE_ESTRANGEIRA').AsString);

    cdsArvore.Next;

  end;

  FreeAndNil(objTabelaCampo);

end;

procedure TfrmTabelaCampo.mostrarDadosDosCampos(pCampoOrdenacao: string);
var
  objTabelaCampo: TTabelaCampos;
begin
  objTabelaCampo:= TTabelaCampos.create;
  objTabelaCampo.mostrarCampos(cboTabelaCampo.KeyValue, pCampoOrdenacao);

  dspCampo := TDataSetProvider(FindComponent('dspCampo'));
  if dspCampo = nil then
  begin
    dspCampo := TDataSetProvider.Create(self);
    dspCampo.Name:= 'dspCampo';
    dspCampo.DataSet := objTabelaCampo.objQuery.FDQuery;
  end;

  cdsCampo := TClientDataSet(FindComponent('cdsCampo'));
  if cdsCampo = nil then
  begin
    cdsCampo := TClientDataSet.Create(self);
    cdsCampo.Name := 'cdsCampo';
    cdsCampo.ProviderName := dspCampo.Name;
  end;

  dtsCampo := TDataSource(FindComponent('dtsCampo'));
  if dtsCampo = nil then
  begin
    dtsCampo := TDataSource.Create(self);
    dtsCampo.Name := 'dtsCampo';
    dtsCampo.DataSet := cdsCampo;
  end;

  grdCampos.DataSource:= dtsCampo;

  cdsCampo.Close;
  cdsCampo.FetchParams;
  cdsCampo.Open;

  FreeAndNil(objTabelaCampo);
end;

procedure TfrmTabelaCampo.MostrarFormatoCampo;
var
  objTabelaCampo: TTabelaCampos;
begin
  objTabelaCampo:= TTabelaCampos.create;
  objTabelaCampo.mostrarFormatoDosCampos;

  dspFormatoCampo := TDataSetProvider(FindComponent('dspFormatoCampo'));
  if dspFormatoCampo = nil then
  begin
    dspFormatoCampo := TDataSetProvider.Create(self);
    dspFormatoCampo.Name:= 'dspFormatoCampo';
    dspFormatoCampo.DataSet := objTabelaCampo.objQuery.FDQuery;
  end;

  cdsFormatoCampo := TClientDataSet(FindComponent('cdsFormatoCampo'));
  if cdsFormatoCampo = nil then
  begin
    cdsFormatoCampo := TClientDataSet.Create(self);
    cdsFormatoCampo.Name := 'cdsFormatoCampo';
    cdsFormatoCampo.ProviderName := dspFormatoCampo.Name;
  end;

  dtsFormatoCampo := TDataSource(FindComponent('dtsFormatoCampo'));
  if dtsFormatoCampo = nil then
  begin
    dtsFormatoCampo := TDataSource.Create(self);
    dtsFormatoCampo.Name := 'dtsFormatoCampo';
    dtsFormatoCampo.DataSet := cdsFormatoCampo;
  end;

  cdsFormatoCampo.Close;
  cdsFormatoCampo.FetchParams;
  cdsFormatoCampo.Open;

  cboFormatoCampo.KeyField := 'DDBDFC_CODIGO';
  cboFormatoCampo.ListField := 'DDBDFC_DESCRICAO_CAMPO';
  cboFormatoCampo.ListSource := dtsFormatoCampo;

  FreeAndNil(objTabelaCampo);
end;

end.
