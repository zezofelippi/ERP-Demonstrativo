unit untCadastroForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ExtDlgs, Vcl.Grids, Vcl.DBGrids, Data.DB, Datasnap.Provider, Datasnap.DBClient, Vcl.CategoryButtons,
  Vcl.Menus, uModulosClasses, uTabelaCampos, uMenu, jpeg, JvExExtCtrls, JvImage,
  JvExControls, JvButton, JvNavigationPane, Vcl.ImgList, JvLabel,
  JvTransparentButton, untBase, uPesquisa;

type
  TfrmCadastroForms = class(TfrmBase)
    rpbDadosGerais: TGroupBox;
    cboTabela: TDBLookupComboBox;
    dlgIcone: TOpenPictureDialog;
    imgIcone: TImage;
    pop1: TPopupMenu;
    Excluir1: TMenuItem;
    Alterar1: TMenuItem;
    lbl3: TLabel;
    cboClasse: TDBLookupComboBox;
    imgIconeGrid: TImage;
    grdTela: TDBGrid;
    imgListIcone: TImageList;
    lblModulo: TLabel;
    edtNomeTela: TEdit;
    lbl2: TLabel;
    lbl4: TLabel;
    edtNomeForm: TEdit;
    lbl1: TLabel;
    edtCaminhoIcone: TEdit;
    lbl5: TLabel;
    btnLimparIcone: TJvNavPanelButton;
    btnIcone: TJvNavPanelButton;
    btnGravar: TJvNavPanelButton;
    procedure FormShow(Sender: TObject);
    procedure cboTabelaEnter(Sender: TObject);
    procedure cboTabelaExit(Sender: TObject);
    procedure cboTabelaKeyPress(Sender: TObject; var Key: Char);
    procedure MostrarClasses(Sender: TObject);
    procedure MostrarTelasNaGrid(pCampoOrdenacao: string);
    procedure grdTelaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure LimpaCampos(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure OrdenarForms(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
   // procedure SelecionarClasseNaGrid(Sender: TObject);
    procedure montarEstruturaComboBoxDBGrid(Sender: TObject);
    procedure mostrarTabelas(Sender: TObject);
    procedure edtNomeFormEnter(Sender: TObject);
    procedure edtNomeFormExit(Sender: TObject);
    procedure edtNomeFormKeyPress(Sender: TObject; var Key: Char);
    procedure cboClasseEnter(Sender: TObject);
    procedure cboClasseExit(Sender: TObject);
    procedure cboClasseKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure mostrarDadosDoRespectivoModuloSelecionado(sender: TObject);
    procedure edtNomeTelaEnter(Sender: TObject);
    procedure edtNomeTelaExit(Sender: TObject);
    procedure edtNomeTelaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnLimparIconeClick(Sender: TObject);
    procedure btnIconeClick(Sender: TObject);
    procedure grdTelaTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    dspClasse, dspTabela, dspMostrarTelas : TDataSetProvider;
    cdsClasse, cdsTabela, cdsMostrarTelas : TClientDataSet;
    dtsClasse, dtsTabela, dtsMostrarTelas : TDataSource;
    gcCodigoTela, nameForm: string;
  public
    { Public declarations }
    gcIndexModulo: string;
  end;

var
  frmCadastroForms: TfrmCadastroForms;
  gCds : TClientDataSet; {Este cds é usado p/ mostrar as telas no grdTela,
    ele é global porque é usado no evento DrawColumnCell p/ mostrar os
    ícones das telas no grdTela}
  gcMoCodigo : string;

implementation

{$R *.dfm}

uses untMenu;

procedure TfrmCadastroForms.Alterar1Click(Sender: TObject);
begin
  gcCodigoTela := cdsMostrarTelas.FieldByName('DDM_CODIGO').AsString;
  edtNomeTela.Text := cdsMostrarTelas.FieldByName('DDM_CAPTION').AsString;
  edtNomeForm.Text := cdsMostrarTelas.FieldByName('DDM_NAME').AsString;
  nameForm:= cdsMostrarTelas.FieldByName('DDM_NAME').AsString;
  cboTabela.KeyValue := cdsMostrarTelas.FieldByName('DDBDT_CODIGO').AsString;
  cboClasse.KeyValue := cdsMostrarTelas.FieldByName('DDCPF_CODIGO').AsString;
  edtCaminhoIcone.Text := cdsMostrarTelas.FieldByName('DDM_CAMINHO_ICONE').AsString;
  if cdsMostrarTelas.FieldByName('DDM_CAMINHO_ICONE').AsString <> '' then
    imgIcone.Picture.LoadFromFile(
      cdsMostrarTelas.FieldByName('DDM_CAMINHO_ICONE').AsString);

  cboTabela.ReadOnly := True;
  cboClasse.ReadOnly := true;
  cboClasse.Color := $00E0E0E0;
  cboTabela.Color := $00E0E0E0;

  btnGravar.Tag := 1;

end;

procedure TfrmCadastroForms.cboClasseEnter(Sender: TObject);
begin
  cboClasse.Color := $00FFEAEA;
end;

procedure TfrmCadastroForms.cboClasseExit(Sender: TObject);
begin
  cboClasse.Color := clwindow;
end;

procedure TfrmCadastroForms.cboClasseKeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
    btnGravar.Click;
end;

procedure TfrmCadastroForms.cboTabelaEnter(Sender: TObject);
begin
  cboTabela.Color := $00FFEAEA;
end;

procedure TfrmCadastroForms.cboTabelaExit(Sender: TObject);
begin
  cboTabela.Color := clWindow;
end;

procedure TfrmCadastroForms.cboTabelaKeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
    cboClasse.SetFocus;
end;

procedure TfrmCadastroForms.Excluir1Click(Sender: TObject);
var
  objMenu : TUMenu;
begin

  case MessageBox (Application.Handle, Pchar ('Tem certeza que deseja '+
    'excluir a tela ' + cdsMostrarTelas.FieldByName('DDM_CAPTION').AsString +'?'),'Alerta',
    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) of
  IDNO:
  begin
    Exit;
  end;
  end;

  objMenu := TUMenu.Create;
  if objMenu.excluirTela(cdsMostrarTelas.FieldByName('DDM_CODIGO').AsString) = 'Erro' then
  begin
    Application.MessageBox(Pchar('Exclua primeiro botão de atalho, '+
      ' PageControl, GroupBox e todos os componentes referentes a esta tela.'),
      'Aviso!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    Exit;
  end;

  FreeAndNil(objMenu);

  OrdenarForms(Sender AS TObject);

  MostrarTelasNaGrid('');

  frmMenu.ctbMenu.Categories.Clear;
  frmMenu.imgListaIconesMenu.Clear;
  frmMenu.ConstruirMenu(Sender as TObject);
  frmMenu.fecharModulos(Sender as TObject);
  frmMenu.abrirModuloEspecifico(strToInt(gcIndexModulo));

end;

procedure TfrmCadastroForms.FormActivate(Sender: TObject);
begin
  mostrarDadosDoRespectivoModuloSelecionado(Sender as TObject);
end;

procedure TfrmCadastroForms.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadastroForms := nil;
end;

procedure TfrmCadastroForms.FormShow(Sender: TObject);
begin
  inherited;
  edtNomeTela.SetFocus;
end;

procedure TfrmCadastroForms.grdTelaDrawColumnCell(Sender: TObject;
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
    grdTela.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdTela.Canvas.Font.Color:= clBlack;

  grdTela.Canvas.FillRect(Rect);
  grdTela.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if cdsMostrarTelas.FieldByName('DDM_CAMINHO_ICONE').AsString <> '' then
  begin
    if Column.Index = 4 then
    begin
      vl_icone := TIcon.Create;
      grdTela.Canvas.FillRect(Rect);
      imgIconeGrid.Picture.LoadFromFile
        (cdsMostrarTelas.FieldByName('DDM_CAMINHO_ICONE').AsString);

      vl_icone := imgIconeGrid.Picture.Icon;
      grdTela.Canvas.Draw((Rect.Right - Rect.Left - vl_icone.Width) div 2 + Rect.Left,
      (Rect.Bottom - Rect.Top - vl_icone.Height) div 2 + Rect.Top, vl_icone);
    end;
  end;

end;

procedure TfrmCadastroForms.grdTelaTitleClick(Column: TColumn);
begin
  mostrarTelasNaGrid(column.fieldname);
end;

procedure TfrmCadastroForms.btnIconeClick(Sender: TObject);
begin
 if dlgIcone.Execute then
    if FileExists(dlgIcone.FileName) then
    begin
      imgIcone.Picture.LoadFromFile(dlgIcone.FileName);
      edtCaminhoIcone.Text := dlgIcone.FileName;
    end;
end;

procedure TfrmCadastroForms.btnLimparIconeClick(Sender: TObject);
begin
  edtCaminhoIcone.Clear;
  imgIcone.Picture := nil;
end;

procedure TfrmCadastroForms.btnGravarClick(Sender: TObject);
var
  objMenu: TUMenu;
begin
  if edtNomeTela.Text = EmptyStr then
  begin
    Application.MessageBox(Pchar('Campo obrigatório. Nome da Tela'+
        ' precisa ser inserido '), 'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    edtNomeTela.SetFocus;
    Exit;
  end
  else if edtNomeForm.Text = EmptyStr then
  begin
    Application.MessageBox(Pchar('Campo obrigatório. Nome do Form'+
        ' precisa ser inserido '), 'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    edtNomeForm.SetFocus;
    Exit;
  end
  else if cboTabela.Text = EmptyStr then
  begin
    Application.MessageBox(Pchar('Campo obrigatório. Tabela'+
        ' precisa ser inserida '), 'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    cboTabela.SetFocus;
    Exit;
  end
  else if cboClasse.Text = EmptyStr then
  begin
    Application.MessageBox(Pchar('Campo obrigatório. Classe'+
        ' precisa ser inserida '), 'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    cboClasse.SetFocus;
    Exit;
  end;

  objMenu:= TUMenu.create;

  if btnGravar.Tag = 0 then
  begin
    if objMenu.verificarSeNomeDoFormJaExiste(edtNomeForm.Text) = true then
    begin
      Application.MessageBox(Pchar('O nome do form digitado já existe.'),
        'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
      edtNomeForm.SetFocus;
      FreeAndNil(objMenu);
      Exit;
    end;

    if objMenu.cadastrarForm(edtNomeTela.Text, edtNomeForm.Text, gcMoCodigo, cboTabela.KeyValue,
      cboClasse.KeyValue, edtCaminhoIcone.Text) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro no cadastro dos dados'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
      FreeAndNil(objMenu);
      Exit;
    end;
  end
  else
  begin
    if nameForm <> edtNomeForm.Text then
    begin
      if objMenu.verificarSeNomeDoFormJaExiste(edtNomeForm.Text) = true then
      begin
        Application.MessageBox(Pchar('O nome do form digitado já existe.'),
          'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
        edtNomeForm.SetFocus;
        FreeAndNil(objMenu);
        Exit;
      end;  
    end;

    cboTabela.ReadOnly := false;
    if objMenu.alterarCadastroForm(edtNomeTela.Text, edtNomeForm.Text,
        edtCaminhoIcone.Text, gcCodigoTela) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro na alteração do cadastro dos dados'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
      FreeAndNil(objMenu);
      Exit;
    end;
  end;

  FreeAndNil(objMenu);

  OrdenarForms(Sender AS TObject);

  MostrarTelasNaGrid('');

  LimpaCampos(Sender as TObject);

  cboTabela.ReadOnly := false;
  cboClasse.ReadOnly := false;
  cboClasse.Color := clwhite;
  cboTabela.Color := clwhite;

  btnGravar.Tag := 0;

  frmMenu.ctbMenu.Categories.Clear;
  frmMenu.imgListaIconesMenu.Clear;
  frmMenu.ConstruirMenu(Sender as TObject);
  frmMenu.fecharModulos(Sender as TObject);
  frmMenu.abrirModuloEspecifico(strToInt(gcIndexModulo));

end;

procedure TfrmCadastroForms.edtNomeFormEnter(Sender: TObject);
begin
  edtNomeForm.Color := $00FFEAEA;
end;

procedure TfrmCadastroForms.edtNomeFormExit(Sender: TObject);
begin
  edtNomeForm.Color := clwindow;
end;

procedure TfrmCadastroForms.edtNomeFormKeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
    cboTabela.SetFocus
end;

procedure TfrmCadastroForms.edtNomeTelaEnter(Sender: TObject);
begin
  edtNomeTela.Color := $00FFEAEA;
end;

procedure TfrmCadastroForms.edtNomeTelaExit(Sender: TObject);
begin
  edtNomeTela.Color := clwindow;
end;


procedure TfrmCadastroForms.edtNomeTelaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key =#13 then
    edtNomeForm.SetFocus;
end;

procedure TfrmCadastroForms.LimpaCampos(Sender: TObject);
begin
  gcCodigoTela := '';
  edtNomeTela.Clear;
  edtNomeForm.Clear;
  cboclasse.KeyValue := -1;
  cboTabela.KeyValue := -1;
  edtCaminhoIcone.Clear;
  imgIcone.Picture := nil;
end;

procedure TfrmCadastroForms.montarEstruturaComboBoxDBGrid(Sender: TObject);
begin
  cboClasse.KeyField := 'DDCPF_CODIGO';
  cboClasse.ListField := 'DDCPF_DESCRICAO';

  cboTabela.KeyField := 'DDBDT_CODIGO';
  cboTabela.ListField := 'DDBDT_TABELA_APELIDO';

  grdTela.Columns[0].FieldName := 'DDM_CAPTION';
  grdTela.Columns[0].Title.Caption := 'Caption do form';
  grdTela.Columns[0].Width := 160;

  grdTela.Columns[1].FieldName := 'DDM_NAME';
  grdTela.Columns[1].Title.Caption := 'Name do form';
  grdTela.Columns[1].Width := 160;

  grdTela.Columns[2].FieldName := 'DDCPF_DESCRICAO';
  grdTela.Columns[2].Title.Caption := 'Classe';
  grdTela.Columns[2].Width := 160;

  grdTela.Columns[3].FieldName := 'DDBDT_TABELA_APELIDO';
  grdTela.Columns[3].Title.Caption := 'Tabela';
  grdTela.Columns[3].Width := 160;

  grdTela.Columns[4].Title.Caption := 'Ícone';

  grdTela.Columns[5].FieldName := 'DDM_CODIGO';
  grdTela.Columns[5].Visible := False;

end;

procedure TfrmCadastroForms.MostrarClasses(Sender: TObject);
var
  objModulosClasses : TModulosClasses;
begin
  objModulosClasses := TModulosClasses.create;
  objModulosClasses.mostrarClassesDeAcordoComCadaModulo(gcIndexModulo);

  dspClasse := TDataSetProvider(FindComponent('dspClasse'));
  if dspClasse = nil then
  begin
    dspClasse := TDataSetProvider.Create(self);
    dspClasse.Name:= 'dspClasse';
    dspClasse.DataSet := objModulosClasses.objQuery.FDQuery;
  end;

  cdsClasse := TClientDataSet(FindComponent('cdsClasse'));
  if cdsClasse = nil then
  begin
    cdsClasse := TClientDataSet.Create(self);
    cdsClasse.Name := 'cdsClasse';
    cdsClasse.ProviderName := dspClasse.Name;
  end;

  dtsClasse := TDataSource(FindComponent('dtsClasse'));
  if dtsClasse = nil then
  begin
    dtsClasse := TDataSource.Create(self);
    dtsClasse.Name := 'dtsClasse';
    dtsClasse.DataSet := cdsClasse;
  end;

  cdsClasse.Close;
  cdsClasse.FetchParams;
  cdsClasse.Open;

  cboClasse.ListSource := dtsClasse;

  FreeAndNil(objModulosClasses);

end;

procedure TfrmCadastroForms.mostrarDadosDoRespectivoModuloSelecionado(
  sender: TObject);
var
  objModulosClasses: TModulosClasses;
begin
  gcIndexModulo:= IntToStr(frmMenu.ctbMenu.CurrentCategory.Index);
  btnGravar.Tag := 0;
  montarEstruturaComboBoxDBGrid(Sender as TObject);
  mostrarClasses(Sender as TObject);
  mostrarTabelas(Sender as TObject);
  objModulosClasses:= TModulosClasses.create;
  objModulosClasses.mostrarClassesDeAcordoComCadaModulo(gcIndexModulo);
  gcMoCodigo := objModulosClasses.objQuery.FDQuery.FieldByName('DDMM_CODIGO').AsString;
  lblModulo.Caption :=
    objModulosClasses.objQuery.FDQuery.FieldByName('DDMM_DESCRICAO').AsString;
  mostrarTelasNaGrid('');
end;

procedure TfrmCadastroForms.mostrarTabelas(Sender: TObject);
var
  objTabelaCampos: TTabelaCampos;
begin
  objTabelaCampos:= TTabelaCampos.create;
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

  cboTabela.ListSource:= dtsTabela;

  FreeAndNil(objTabelaCampos);

end;

procedure TfrmCadastroForms.MostrarTelasNaGrid(pCampoOrdenacao: string);
var
  objMenu : TUMenu;
begin
  objMenu := TUMenu.create;
  objMenu.mostrarTelas(gcMoCodigo,pCampoOrdenacao);

  dspMostrarTelas := TDataSetProvider(FindComponent('dspMostrarTelas'));
  if dspMostrarTelas = nil then
  begin
    dspMostrarTelas := TDataSetProvider.Create(self);
    dspMostrarTelas.Name:= 'dspMostrarTelas';
    dspMostrarTelas.DataSet := objMenu.objQuery.FDQuery;
  end;

  cdsMostrarTelas := TClientDataSet(FindComponent('cdsMostrarTelas'));
  if cdsMostrarTelas = nil then
  begin
    cdsMostrarTelas := TClientDataSet.Create(self);
    cdsMostrarTelas.Name := 'cdsMostrarTelas';
    cdsMostrarTelas.ProviderName := dspMostrarTelas.Name;
  end;

  dtsMostrarTelas := TDataSource(FindComponent('dtsMostrarTelas'));
  if dtsMostrarTelas = nil then
  begin
    dtsMostrarTelas := TDataSource.Create(self);
    dtsMostrarTelas.Name := 'dtsMostrarTelas';
    dtsMostrarTelas.DataSet := cdsMostrarTelas;
  end;

  cdsMostrarTelas.Close;
  cdsMostrarTelas.FetchParams;
  cdsMostrarTelas.Open;

  grdTela.DataSource := dtsMostrarTelas;

end;

procedure TfrmCadastroForms.OrdenarForms(Sender: TObject);
var
  objMenu: TUMenu;
  cdsMenu: TClientDataSet;
  dtsMenu: TDataSetProvider;
  i: integer;
begin
  objMenu:= TUMenu.create;
  objMenu.mostrarCodigoDoMenu(gcMoCodigo);

  dtsMenu := TDataSetProvider(FindComponent('dtsMenu'));
  if dtsMenu = nil then
  begin
    dtsMenu := TDataSetProvider.Create(self);
    dtsMenu.Name := 'dtsMenu';
    dtsMenu.DataSet := objMenu.objQuery.FDQuery;
  end;

  cdsMenu := TClientDataSet(FindComponent('cdsMenu'));
  if cdsMenu = nil then
  begin
    cdsMenu := TClientDataSet.Create(self);
    cdsMenu.Name := 'cdsMenu';
    cdsMenu.ProviderName := dtsMenu.Name;
  end;

  cdsMenu.close;
  cdsMenu.FetchParams;
  cdsMenu.Open;
  cdsMenu.First;

  i:=0;

  while not cdsMenu.Eof do
  begin
    if objMenu.alterarCodigoModuloCodigoMenu(gcMoCodigo,
       cdsMenu.FieldByName('DDM_CODIGO').AsString, gcIndexModulo, inttostr(i)) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro ao alterar sequencia dos forms.'),
      'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
      Exit;
    end;
    i:= i+1;
    cdsMenu.Next;
  end;

  FreeAndNil(objMenu);

end;

{procedure TfrmCadastroForms.SelecionarClasseNaGrid(Sender: TObject);
var
  dsp : TDataSetProvider;
  cds : TClientDataSet;
  dts : TDataSource;
begin

   dsp := TDataSetProvider.Create(self);
   cds := TClientDataSet.Create(self);
   dts := TDataSource.Create(self);

   Cds := TClientDataSet(FindComponent('cdsClasse'));
   dsp := TDataSetProvider(FindComponent('dspClasse'));
   dts := TDataSource(FindComponent('dtsClasse'));

   Cds.ProviderName := dsp.Name;
   Dts.DataSet := Cds;

   Cds.Close;
   Cds.FetchParams;
   Cds.Open;
end;  }

end.
