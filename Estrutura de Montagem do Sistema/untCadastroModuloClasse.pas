unit untCadastroModuloClasse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Data.DB, uFDQuery,
  Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.ExtDlgs, uModulosClasses,
  uMenu, JvExControls, JvButton, JvNavigationPane, untBase, Vcl.ImgList;

type
  TfrmCadastroModuloClasse = class(TfrmBase)
    rpbModulo: TGroupBox;
    grdModulo: TDBGrid;
    rpbClasse: TGroupBox;
    cboModulo: TDBLookupComboBox;
    grdModuloClasse: TDBGrid;
    popModulo: TPopupMenu;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    rpbCadastro: TGroupBox;
    popModuloClasse: TPopupMenu;
    Excluir2: TMenuItem;
    popClasse: TPopupMenu;
    Excluir3: TMenuItem;
    grdCadClasse: TDBGrid;
    edtNomeModulo: TEdit;
    lbl4: TLabel;
    btnGravarModulo: TJvNavPanelButton;
    lbl2: TLabel;
    edtNomeClasse: TEdit;
    btnGravarClasse: TJvNavPanelButton;
    lbl5: TLabel;
    edtModulo: TEdit;
    lbl3: TLabel;
    edtClasse: TEdit;
    lbl1: TLabel;
    btnGravarModuloClasse: TJvNavPanelButton;
    imgLista: TImageList;
    procedure FormShow(Sender: TObject);
    procedure grdModuloDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdModuloClasseDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure MostrarModulosClassesNaGrid(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure OrdenarModulos(Sender: TObject);
    procedure MostrarClassesNaGrid(Sender: TObject);
    procedure MostrarModulosComboBoxDBGrid(sender: TObject);
    procedure grdCadClasseDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Excluir2Click(Sender: TObject);
    procedure Excluir3Click(Sender: TObject);
    procedure grdModuloDblClick(Sender: TObject);
    procedure grdCadClasseDblClick(Sender: TObject);
    procedure cboModuloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboModuloCloseUp(Sender: TObject);
    procedure edtNomeModuloEnter(Sender: TObject);
    procedure edtNomeModuloExit(Sender: TObject);
    procedure edtNomeClasseEnter(Sender: TObject);
    procedure edtNomeClasseExit(Sender: TObject);
    procedure cboModuloEnter(Sender: TObject);
    procedure cboModuloExit(Sender: TObject);
    procedure LimparCampos(Sender: TObject);
    procedure montarEstruturaDBGridClasses(Sender: TObject);
    procedure montarEstruturaComboBoxModulo(Sender: TObject);
    procedure montarEstruturaDBGridModulos(Sender: TObject);
    procedure montarEstruturaDBGridModulosClasses(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarModuloClick(Sender: TObject);
    procedure btnGravarClasseClick(Sender: TObject);
    procedure btnGravarModuloClasseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboModuloKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    objQuery : TUFDQuery;
    codModulo,
      codClasse: string;
    dspModulo, dspClasse, dspModuloClasse : TDataSetProvider;
    cdsModulo, cdsClasse, cdsModuloClasse : TClientDataSet;
    dtsModulo, dtsClasse, dtsModuloClasse : TDataSource;
  public
    { Public declarations }
  end;

var
  frmCadastroModuloClasse: TfrmCadastroModuloClasse;

implementation

{$R *.dfm}

uses untMenu;

procedure TfrmCadastroModuloClasse.Alterar1Click(Sender: TObject);
begin
  edtNomeModulo.Text := grdModulo.Fields[0].AsString;
  codModulo := grdModulo.Fields[1].AsString;

end;

procedure TfrmCadastroModuloClasse.btnGravarClasseClick(Sender: TObject);
var
  objModulosClasses: TModulosClasses;
begin

  if edtNomeClasse.Text = '' then
  begin
    Application.MessageBox(Pchar('Coloque um nome para a classe.'), 'Informação!',
      MB_OK+MB_ICONINFORMATION + MB_TOPMOST);
    edtNomeClasse.SetFocus;
    Exit;
  end;

  if (edtNomeClasse.Text = EmptyStr) then
  begin
    Application.MessageBox(Pchar('Insira um nome para a classe.'),
      'Informação!', MB_OK+MB_ICONERROR + MB_TOPMOST);
    Exit;
  end;

  objModulosClasses := TModulosClasses.create;
  if edtNomeClasse.Text <> EmptyStr then
  begin
    if objModulosClasses.cadastrarClasse(edtNomeClasse.Text) = 'Erro' then
      Application.MessageBox(Pchar('Erro no cadastro da classe, '+
      'verifique se o nome da classe que está tentando cadastrar já existe'),
      'Informação!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;
  edtNomeClasse.Clear;
  MostrarClassesNaGrid(Sender as TObject);
  LimparCampos(Sender as TObject);
  FreeAndNil(objModulosClasses);

end;

procedure TfrmCadastroModuloClasse.btnGravarModuloClasseClick(Sender: TObject);
var
  objModulosClasses: TModulosClasses;
begin
  if (codModulo = '') or (codClasse = '') then
  begin
    Application.MessageBox(Pchar('Insira um módulo e uma classe.'), 'Informação!',
      MB_OK+MB_ICONINFORMATION + MB_TOPMOST);
    Exit;
  end;

  {Verifica se módulo e classe já estão cadastrados}
  objModulosClasses:= TModulosClasses.create;

  if objModulosClasses.verificaSeModuloEClasseJaEstaoCadastrados(
     codModulo, codClasse) = 'Aviso' then
  begin
    FreeAndNil(objModulosClasses);
    codModulo := '';
    codClasse := '';
    Application.MessageBox(Pchar('O módulo com essa classe já existe.'), 'Informação!',
      MB_OK+MB_ICONINFORMATION + MB_TOPMOST);
    Exit;
  end;
  {FIM}

  if objModulosClasses.cadastrarModuloClasse(codModulo, codClasse) = 'Erro' then
  begin
    FreeAndNil(objModulosClasses);
    codModulo := '';
    codClasse := '';
    Application.MessageBox(Pchar('Erro ao inserir na tabela DD_MODULO_MENU_CLASSES_FORMS.'), 'Erro!',
      MB_OK+MB_ICONERROR + MB_TOPMOST);
    Exit;
  end;

  MostrarModulosClassesNaGrid(Sender as TObject);
  cboModulo.KeyValue := -1;
  LimparCampos(Sender as TObject);
  codModulo := '';
  codClasse := '';
  FreeAndNil(objModulosClasses);

end;

procedure TfrmCadastroModuloClasse.btnGravarModuloClick(Sender: TObject);
var
  objModulosClasses: TModulosClasses;
begin

  if edtNomeModulo.Text = '' then
  begin
    Application.MessageBox(Pchar('Coloque um nome para o módulo.'), 'Informação!',
      MB_OK+MB_ICONINFORMATION + MB_TOPMOST);
    edtNomeModulo.SetFocus;
    Exit;
  end;

  objModulosClasses:= TModulosClasses.Create;

  if codModulo = '' then
  begin
    if objModulosClasses.cadastrarModulo(edtNomeModulo.Text) = 'Erro' then
      Application.MessageBox(Pchar('Erro no cadastro do módulo, '+
        'verifique se o nome do módulo que está tentando cadastrar já existe.'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
  end
  else
  begin
    if objModulosClasses.alterarCadastroModulo(codModulo, edtNomeModulo.Text) = 'Erro' then
      Application.MessageBox(Pchar('Erro na alteração do módulo, '+
        'verifique se o nome do módulo que está tentando cadastrar já existe'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);

  end;
  codModulo:='';
  cdsModulo.DisableControls;
  OrdenarModulos(Sender as TObject);
  cdsModulo.EnableControls;
  MostrarModulosComboBoxDBGrid(Sender as TObject);
  LimparCampos(Sender as TObject);

  FreeAndNil(objModulosClasses);

  frmMenu.ctbMenu.Categories.Clear;
  frmMenu.imgListaIconesMenu.Clear;
  frmMenu.ConstruirMenu(Sender as TObject);
  frmMenu.fecharModulos(Sender as TObject);

end;

procedure TfrmCadastroModuloClasse.cboModuloCloseUp(Sender: TObject);
begin
  MostrarModulosClassesNaGrid(Sender as TObject);
end;

procedure TfrmCadastroModuloClasse.cboModuloEnter(Sender: TObject);
begin
  cboModulo.Color := $00FFEAEA;
end;

procedure TfrmCadastroModuloClasse.cboModuloExit(Sender: TObject);
begin
  cboModulo.Color := clwindow;
end;

procedure TfrmCadastroModuloClasse.cboModuloKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_BACK)or (Key = VK_DELETE) then
  begin
    cboModulo.KeyValue :=-1;
    MostrarModulosClassesNaGrid(Sender as TObject);
  end;
end;

procedure TfrmCadastroModuloClasse.cboModuloKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  MostrarModulosClassesNaGrid(Sender as TObject);
end;

procedure TfrmCadastroModuloClasse.edtNomeClasseEnter(Sender: TObject);
begin
  edtNomeClasse.Color := $00FFEAEA;
end;

procedure TfrmCadastroModuloClasse.edtNomeClasseExit(Sender: TObject);
begin
  edtNomeClasse.Color := clwindow;
end;

procedure TfrmCadastroModuloClasse.edtNomeModuloEnter(Sender: TObject);
begin
  edtNomeModulo.Color := $00FFEAEA;
end;

procedure TfrmCadastroModuloClasse.edtNomeModuloExit(Sender: TObject);
begin
  edtNomeModulo.Color := clwindow;
end;

procedure TfrmCadastroModuloClasse.Excluir1Click(Sender: TObject);
var
  objModulosClasses : TModulosClasses;
begin
  objModulosClasses := TModulosClasses.create;

  {verifica se há classe inserido no módulo}
  if objModulosClasses.verificaSeModuloPodeSerExcluido(
    cdsModulo.FieldByName('DDMM_CODIGO').AsString) = 'Aviso' then
  begin
    FreeAndNil(objModulosClasses);
    Application.MessageBox(Pchar('Módulo ' + cdsModulo.FieldByName('DDMM_DESCRICAO').AsString +
      ' não pode ser excluído pois possui classes.'),
      'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    exit;
  end;
  {FIM}

  case MessageBox (Application.Handle, Pchar ('Tem certeza que deseja '+
    'excluir módulo ' + grdModulo.Fields[0].AsString +'?'),'Alerta',
    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) of
  IDNO:
  begin
    FreeAndNil(objModulosClasses);
    Exit;
  end;
  end;

  if objModulosClasses.excluirModulo(
    cdsModulo.FieldByName('DDMM_CODIGO').AsString) = 'Erro' then
  begin
    FreeAndNil(objModulosClasses);
    Application.MessageBox(Pchar('Erro na exclusão do modulo '+
      'tabela DICIONARIO_DADOS_CLASSE_MODULO'), 'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
    exit;
  end;

  cdsModulo.DisableControls;
  OrdenarModulos(Sender as TObject);
  cdsModulo.EnableControls;
  MostrarModulosComboBoxDBGrid(Sender as TObject);
  FreeAndNil(objModulosClasses);

  frmMenu.ctbMenu.Categories.Clear;
  frmMenu.imgListaIconesMenu.Clear;
  frmMenu.ConstruirMenu(Sender as TObject);
  frmMenu.fecharModulos(Sender as TObject);

end;

procedure TfrmCadastroModuloClasse.Excluir2Click(Sender: TObject);
var
  objModulosClasses: TModulosClasses;
  objMenu : TUMenu;
begin
  objMenu := TUMenu.create;

  if objMenu.verificarSeClasseEstaCadastradaEmAlgumaTelaDoModulo(
    cdsModuloClasse.FieldByName('DDCPF_CODIGO').AsString,
    cdsModuloClasse.FieldByName('DDMM_CODIGO').AsString) = true then
  begin
    FreeAndNil(objMenu);
    Application.MessageBox(Pchar('A classe deste módulo está vinculada numa tela, '+
     'exclua primeiro a tela.'),
     'Aviso!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    exit;
  end;
  FreeAndNil(objMenu);


  case MessageBox (Application.Handle, Pchar ('Tem certeza que deseja excluir união do '+
    'módulo ' + cdsModuloClasse.FieldByName('DDMM_DESCRICAO').AsString +
    ' com a classe ' + cdsModuloClasse.FieldByName('DDCPF_DESCRICAO').AsString + '?'),'Alerta',
    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) of
  IDNO:
  begin
    Exit;
  end;
  end;

  objModulosClasses:= TModulosClasses.create;

  if objModulosClasses.excluirModuloClasse(
    cdsModuloClasse.FieldByName('DDMMCF_CODIGO').AsString) = 'Erro' then
  begin
    FreeAndNil(objModulosClasses);
    Application.MessageBox(Pchar('Erro na exclusão da união do módulo com a classe.'),
     'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
    exit;
  END;
  FreeAndNil(objModulosClasses);
  MostrarModulosClassesNaGrid(Sender as TObject);

end;

procedure TfrmCadastroModuloClasse.Excluir3Click(Sender: TObject);
var
  objModulosClasses: TModulosClasses;
begin
  objModulosClasses:= TModulosClasses.create;

  {Verifica se classe está contida em algum módulo}
  if objModulosClasses.verificaSeClassePodeSerExcluida(
    cdsClasse.FieldByName('DDCPF_CODIGO').AsString) = 'Aviso' then
  begin
    FreeAndNil(objModulosClasses);
    Application.MessageBox(Pchar('classe ' + cdsClasse.FieldByName('DDCPF_DESCRICAO').AsString +
      ' não pode ser excluído pois está contida em algum módulo.'),
      'Informação!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    exit;
  end;
  {FIM}

  case MessageBox (Application.Handle, Pchar ('Tem certeza que deseja '+
    'excluir classe ' + grdCadClasse.Fields[0].AsString +'?'),'Alerta',
    MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) of
  IDNO:
  begin
    FreeAndNil(objModulosClasses);
    Exit;
  end;
  end;

  if objModulosClasses.excluirClasse(
    cdsClasse.FieldByName('DDCPF_CODIGO').AsString) = 'Erro' then
  begin
    FreeAndNil(objModulosClasses);
    Application.MessageBox(Pchar('Erro na exclusão da classe '),
     'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
    exit;
  END;

  FreeAndNil(objModulosClasses);
  MostrarClassesNaGrid(Sender as TObject);

end;

procedure TfrmCadastroModuloClasse.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadastroModuloClasse := nil;
end;

procedure TfrmCadastroModuloClasse.FormCreate(Sender: TObject);
begin
  Width := 880;
  height := 650;
end;

procedure TfrmCadastroModuloClasse.FormShow(Sender: TObject);
begin
  inherited;
  objQuery := TUFDQuery.GetInstancia;

  montarEstruturaDBGridClasses(sender as TObject);
  montarEstruturaComboBoxModulo(sender as TObject);
  montarEstruturaDBGridModulos(sender as TObject);
  montarEstruturaDBGridModulosClasses(Sender as TObject);

  mostrarModulosComboBoxDBGrid(sender as TObject);
  mostrarClassesNaGrid(Sender as TObject);
  mostrarModulosClassesNaGrid(Sender as TObject);

end;

procedure TfrmCadastroModuloClasse.grdCadClasseDblClick(Sender: TObject);
begin
  edtClasse.Text := grdCadClasse.Fields[1].AsString + ' - ' +
    grdCadClasse.Fields[0].AsString;
  codClasse := grdCadClasse.Fields[1].AsString;
end;

procedure TfrmCadastroModuloClasse.grdCadClasseDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdCadClasse.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdCadClasse.Canvas.Font.Color:= clBlack;

  grdCadClasse.Canvas.FillRect(Rect);
  grdCadClasse.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCadastroModuloClasse.grdModuloClasseDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdModuloClasse.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdModuloClasse.Canvas.Font.Color:= clBlack;

  grdModuloClasse.Canvas.FillRect(Rect);
  grdModuloClasse.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCadastroModuloClasse.grdModuloDblClick(Sender: TObject);
begin
  edtModulo.Text := grdModulo.Fields[1].AsString + ' - ' + grdModulo.Fields[0].AsString;
  codModulo :=  grdModulo.Fields[1].AsString;
end;

procedure TfrmCadastroModuloClasse.grdModuloDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdModulo.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdModulo.Canvas.Font.Color:= clBlack;

  grdModulo.Canvas.FillRect(Rect);
  grdModulo.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmCadastroModuloClasse.LimparCampos(Sender: TObject);
begin
  edtNomeModulo.Clear;
  edtNomeClasse.Clear;
  edtModulo.Clear;
  edtClasse.Clear;

end;

procedure TfrmCadastroModuloClasse.montarEstruturaComboBoxModulo(
  Sender: TObject);
begin
  cboModulo.KeyField := 'DDMM_CODIGO';
  cboModulo.ListField := 'DDMM_DESCRICAO';
end;

procedure TfrmCadastroModuloClasse.montarEstruturaDBGridClasses(
  Sender: TObject);
begin
  grdCadClasse.Columns[0].FieldName := 'DDCPF_DESCRICAO';
  grdCadClasse.Columns[0].Title.Caption := 'Classe';
  grdCadClasse.Columns[0].Width := 250;

  grdCadClasse.Columns[1].FieldName := 'DDCPF_CODIGO';
  grdCadClasse.Columns[1].Visible := FALSE;
end;

procedure TfrmCadastroModuloClasse.montarEstruturaDBGridModulos(
  Sender: TObject);
begin
  grdModulo.DataSource := dtsModulo;
  grdModulo.Columns[0].FieldName := 'DDMM_DESCRICAO';
  grdModulo.Columns[0].Title.Caption := 'Módulo';
  grdModulo.Columns[0].Width := 250;
  grdModulo.Columns[1].FieldName := 'DDMM_CODIGO';
  grdModulo.Columns[1].Visible := FALSE;
end;

procedure TfrmCadastroModuloClasse.montarEstruturaDBGridModulosClasses(
  Sender: TObject);
begin
  grdModuloClasse.Columns[0].FieldName := 'DDMM_DESCRICAO';
  grdModuloClasse.Columns[1].FieldName := 'DDCPF_DESCRICAO';
end;

procedure TfrmCadastroModuloClasse.MostrarClassesNaGrid(Sender: TObject);
var
  objModulosClasses: TModulosClasses;
begin
  objModulosClasses:= TModulosClasses.create;

  objModulosClasses.mostrarClasses;

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

  grdCadClasse.DataSource := dtsClasse;

  FreeAndNil(objModulosClasses);

end;

procedure TfrmCadastroModuloClasse.MostrarModulosClassesNaGrid(Sender: TObject);
var
  objModulosClasses : TModulosClasses;
begin
  objModulosClasses := TModulosClasses.create;

  if cboModulo.Text = '' then
    objModulosClasses.mostrarModulosClasses('')
  else
    objModulosClasses.mostrarModulosClasses(cboModulo.KeyValue);

  dspModuloClasse := TDataSetProvider(FindComponent('dspModuloClasse'));
  if dspModuloClasse = nil then
  begin
    dspModuloClasse := TDataSetProvider.Create(self);
    dspModuloClasse.Name:= 'dspModuloClasse';
    dspModuloClasse.DataSet := objModulosClasses.objQuery.FDQuery;
  end;

  cdsModuloClasse := TClientDataSet(FindComponent('cdsModuloClasse'));
  if cdsModuloClasse = nil then
  begin
    cdsModuloClasse := TClientDataSet.Create(self);
    cdsModuloClasse.Name := 'cdsModuloClasse';
    cdsModuloClasse.ProviderName := dspModuloClasse.Name;
  end;

  dtsModuloClasse := TDataSource(FindComponent('dtsModuloClasse'));
  if dtsModuloClasse = nil then
  begin
    dtsModuloClasse := TDataSource.Create(self);
    dtsModuloClasse.Name := 'dtsModuloClasse';
    dtsModuloClasse.DataSet := cdsModuloClasse;
  end;

  cdsModuloClasse.Close;
  cdsModuloClasse.FetchParams;
  cdsModuloClasse.Open;

  grdModuloClasse.DataSource := dtsModuloClasse;
  FreeAndNil(objModulosClasses);

end;

procedure TfrmCadastroModuloClasse.MostrarModulosComboBoxDBGrid(sender: TObject);
var
  objModulosClasses: TModulosClasses;
begin
  objModulosClasses:= TModulosClasses.create;
  objModulosClasses.mostrarModulos;

  dspModulo := TDataSetProvider(FindComponent('dspModulo'));
  if dspModulo = nil then
  begin
    dspModulo := TDataSetProvider.Create(self);
    dspModulo.Name:= 'dspModulo';
    dspModulo.DataSet := objModulosClasses.objQuery.FDQuery;
  end;

  cdsModulo := TClientDataSet(FindComponent('cdsModulo'));
  if cdsModulo = nil then
  begin
    cdsModulo := TClientDataSet.Create(self);
    cdsModulo.Name := 'cdsModulo';
    cdsModulo.ProviderName := dspModulo.Name;
  end;

  dtsModulo := TDataSource(FindComponent('dtsModulo'));
  if dtsModulo = nil then
  begin
    dtsModulo := TDataSource.Create(self);
    dtsModulo.Name := 'dtsModulo';
    dtsModulo.DataSet := cdsModulo;
  end;

  cdsModulo.Close;
  cdsModulo.FetchParams;
  cdsModulo.Open;

  cboModulo.ListSource := dtsModulo;
  grdModulo.DataSource := dtsModulo;

  FreeAndNil(objModulosClasses);

end;

procedure TfrmCadastroModuloClasse.OrdenarModulos(Sender: TObject);
var
  i, iCodModulo_CodMenu: integer;
  objModulosClasses: TModulosClasses;
  objMenu: TUMenu;
  cdsAuxiliar : TClientDataSet;
  dspAuxiliar : TDataSetProvider;
begin

  objMenu:= TUMenu.create;
  objModulosClasses:= TModulosClasses.create;
  objModulosClasses.mostrarModulos;

  dspModulo := TDataSetProvider(FindComponent('dspModulo'));
  if dspModulo = nil then
  begin
    dspModulo := TDataSetProvider.Create(self);
    dspModulo.Name:= 'dspModulo';
    dspModulo.DataSet := objModulosClasses.objQuery.FDQuery;
  end;

  cdsModulo := TClientDataSet(FindComponent('cdsModulo'));
  if cdsModulo = nil then
  begin
    cdsModulo := TClientDataSet.Create(self);
    cdsModulo.Name := 'cdsModulo';
    cdsModulo.ProviderName := dspModulo.Name;
  end;

  cdsModulo.Close;
  cdsModulo.FetchParams;
  cdsModulo.Open;
  cdsModulo.First;

  i:=0;

  while not cdsModulo.Eof do
  begin
    if objModulosClasses.alterarSequenciaDosModulos(
      cdsModulo.FieldByName('DDMM_CODIGO').AsString, i) = 'Erro' then
    begin
      FreeAndNil(objModulosClasses);
      FreeAndNil(objMenu);
      Application.MessageBox(Pchar('Erro na alteração da sequencia dos módulos'), 'Erro!',
      MB_OK+MB_ICONERROR + MB_TOPMOST);
      exit;
    end;

    {altera o MO_MEN_COD_MENU da tabela MENU}
    objMenu:= TUMenu.create;
    objMenu.mostrarCodigoDoMenu(cdsModulo.FieldByName('DDMM_CODIGO').AsString);
    dspAuxiliar := TDataSetProvider(FindComponent('dspAuxiliar'));
    if dspAuxiliar = nil then
    begin
      dspAuxiliar := TDataSetProvider.Create(self);
      dspAuxiliar.Name:= 'dspAuxiliar';
      dspAuxiliar.DataSet := objMenu.objQuery.FDQuery;
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

    iCodModulo_CodMenu:= 0;
    while not cdsAuxiliar.Eof do
    begin
      if objMenu.alterarCodigoModuloCodigoMenu(
        cdsModulo.FieldByName('DDMM_CODIGO').AsString,
        cdsAuxiliar.FieldByName('DDM_CODIGO').AsString,
        inttostr(i), inttostr(iCodModulo_CodMenu)) = 'Erro' then
      begin
        FreeAndNil(objModulosClasses);
        FreeAndNil(objMenu);
        Application.MessageBox(Pchar('Erro na alteração da sequencia do modulo e menu'),
          'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
        exit;
      end;

      iCodModulo_CodMenu:= iCodModulo_CodMenu+1;
      cdsAuxiliar.Next;
    end;
    {FIM}

    i:=i+1;
    cdsModulo.Next;
  end;
  FreeAndNil(objModulosClasses);
  FreeAndNil(objMenu);

end;

end.
