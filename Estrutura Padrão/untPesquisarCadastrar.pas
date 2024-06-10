unit untPesquisarCadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPesquisaConvencional, Vcl.ImgList,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, JvExControls, JvButton, JvNavigationPane,
  uAuxiliar, uPesquisarCadastrar, uPesquisa, uTabelaCampos;

type
  TfrmPesquisarCadastrar = class(TfrmPesquisaConvencional)
    gpbBotoes: TGroupBox;
    btnNovo: TJvNavPanelButton;
    btnCancelar: TJvNavPanelButton;
    btnGravar: TJvNavPanelButton;
    btnExcluir: TJvNavPanelButton;
    btnAlterar: TJvNavPanelButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure popItemInserircampos1Click(Sender: TObject);
    procedure popItemInserircampo1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmMostrarComponentesPesquisaTimer(Sender: TObject);
    procedure tmMostrarComponentesTimer(Sender: TObject);
    procedure gpbBotoesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gpbBotoesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure gpbBotoesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure grdGridKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure InserirGroupBox1Click(Sender: TObject);
  private
    { Private declarations }
    objAuxiliar : TAuxiliar;
  public
    { Public declarations }
  end;

var
  frmPesquisarCadastrar: TfrmPesquisarCadastrar;

implementation

{$R *.dfm}

procedure TfrmPesquisarCadastrar.btnAlterarClick(Sender: TObject);
begin
  alterarRegistro;

  btnNovo.Enabled := false;
  btnGravar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnexcluir.Enabled := false;
end;

procedure TfrmPesquisarCadastrar.btnCancelarClick(Sender: TObject);
begin
  cancelarRegistro;

  btnNovo.Enabled := true;
  btnGravar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := false;
  btnexcluir.Enabled := false;

end;

procedure TfrmPesquisarCadastrar.btnExcluirClick(Sender: TObject);
begin
  deletarRegistro;

  btnNovo.Enabled := true;
  btnGravar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := false;
  btnexcluir.Enabled := false;

end;

procedure TfrmPesquisarCadastrar.btnGravarClick(Sender: TObject);
begin
  if gravarRegistro = false then
    exit;

  btnNovo.Enabled := true;
  btnGravar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := false;
  btnexcluir.Enabled := false;

end;

procedure TfrmPesquisarCadastrar.btnNovoClick(Sender: TObject);
begin
  inserirRegistro;

  btnNovo.Enabled := false;
  btnGravar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnexcluir.Enabled := false;

end;

procedure TfrmPesquisarCadastrar.FormActivate(Sender: TObject);
begin
  inherited;
  objAuxiliar := TAuxiliar.GetInstancia;
  if objAuxiliar.criarGroupBoxPesquisarCadastrar = true then
  begin
    tmMostrarComponentes.Enabled:= true;
    objAuxiliar.criarGroupBoxPesquisarCadastrar := false;
  end;

end;

procedure TfrmPesquisarCadastrar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_F2) then
    btnNovo.Click
  else if (key = VK_F3) then
    btnGravar.Click
  else if (key = VK_F4) then
    btnCancelar.Click
  else if (key = VK_F5) then
    btnAlterar.Click
  else if (key = VK_F6) then
    btnExcluir.Click;


  inherited;

end;

procedure TfrmPesquisarCadastrar.FormShow(Sender: TObject);
begin
  inherited;
  objAuxiliar := TAuxiliar.GetInstancia;

  if objAuxiliar.logadoComoADMSistema = true then
    btnNovo.Enabled := false
  else
    btnNovo.Enabled := true;

  btnGravar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := false;
  btnexcluir.Enabled := false;
end;

procedure TfrmPesquisarCadastrar.gpbBotoesMouseDown(Sender: TObject;
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

procedure TfrmPesquisarCadastrar.gpbBotoesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if gbCapturando then
  begin
    gpbBotoes.Left:= gpbBotoes.Left-(gPt.x-x);
    gpbBotoes.Top:= gpbBotoes.Top - (gPt.y-y);
  end;
end;

procedure TfrmPesquisarCadastrar.gpbBotoesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objPesquisarCadastrar: TPesquisarCadastrar;
begin
  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      gpbBotoes.Left:= gpbBotoes.Left-(gPt.x-x);
      gpbBotoes.Top:= gpbBotoes.Top - (gPt.y-y);
    end;

    objPesquisarCadastrar:= TPesquisarCadastrar.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objPesquisarCadastrar.alterarPosicaoGroupBoxBotoes(inttostr(self.Tag),
      gpbBotoes.Left, gpbBotoes.Top);
    FreeAndNil(objPesquisarCadastrar);
  end;

end;

procedure TfrmPesquisarCadastrar.grdGridKeyPress(Sender: TObject;
  var Key: Char);
var
  objPesquisa: TPesquisa;
  objTabelaCampo: TTabelaCampos;
  campoChavePrimaria: string;
begin
  if key =#13 then
  begin
    if cdsPesquisaDBGrid.IsEmpty = true then
      exit;

    objAuxiliar:= TAuxiliar.GetInstancia;
    objPesquisa:= TPesquisa.create;
    objTabelaCampo:= TTabelaCampos.create;

    campoChavePrimaria:=
      objTabelaCampo.capturarCampoChavePrimaria(codigoTabela);

    objAuxiliar.idRegistroChavePrimaria:=
      cdsPesquisaDBGrid.FieldByName(campoChavePrimaria).AsString;

    FreeAndNil(objTabelaCampo);
    FreeAndNil(objPesquisa);

    objAuxiliar.pesquisandoRegistro:= true;

    btnAlterar.Enabled := true;
    btnexcluir.Enabled := true;

    selecionarUmRegistroNoDBGBridDumaTelaDePesquisa;

  end;


end;

procedure TfrmPesquisarCadastrar.InserirGroupBox1Click(Sender: TObject);
begin
  inherited;
  objAuxiliar:= TAuxiliar.GetInstancia;
  objAuxiliar.remetentePesquisarCadastrar:= true;

end;

procedure TfrmPesquisarCadastrar.popItemInserircampo1Click(Sender: TObject);
var
 i: integer;
begin
  i := popOpcoesTelaPesquisa.PopupComponent.ComponentIndex;
  objAuxiliar.nomeGroupBox := TGroupBox(FindComponent(Components[i].Name)).Name;
  inherited;

end;

procedure TfrmPesquisarCadastrar.popItemInserircampos1Click(Sender: TObject);
var
  i: integer;
begin
  i := popOpcoesTelaCadastro.PopupComponent.ComponentIndex;
  objAuxiliar.nomeGroupBox := TGroupBox(FindComponent(Components[i].Name)).Name;
  inherited;

end;

procedure TfrmPesquisarCadastrar.tmMostrarComponentesPesquisaTimer(
  Sender: TObject);
var
  objPesquisarCadastrar: TPesquisarCadastrar;
begin
  inherited;

  objPesquisarCadastrar:= TPesquisarCadastrar.create;

  {Verifica se gpbBotoes da tela de pesquisarCadastrar está cadastrada,
  senão tiver será cadastrado}
  if objPesquisarCadastrar.verificarSeGpbBotoesDaTelaDePesquisarCadastrarJaFoiCadastrado
     (inttostr(self.Tag)) = false then
  begin
    if objPesquisarCadastrar.cadastrarGpbBotoesTelaDePesquisarCadastrar(inttostr(self.Tag)) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro no cadastro posicao do gpbBotoes'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
      Exit;
    end;
  end;
  {FIM}

  {Pegar posição do gpbBotoes}
  objPesquisarCadastrar.pegarPosicaoGpbBotoesPesquisarCadastrar(inttostr(Self.Tag));
  gpbBotoes.Top :=  objPesquisarCadastrar.objQuery.FDQuery.FieldByName('DDPGB_TOP').AsInteger;
  gpbBotoes.Left:=  objPesquisarCadastrar.objQuery.FDQuery.FieldByName('DDPGB_LEFT').AsInteger;
  {FIM}

  FreeAndNil(objPesquisarCadastrar);

  tmMostrarComponentes.Enabled := true;

end;

procedure TfrmPesquisarCadastrar.tmMostrarComponentesTimer(Sender: TObject);
begin
  inherited;
  try
    cdsCadastro.EmptyDataSet;
  except

  end;
end;

initialization
  RegisterClass(TfrmPesquisarCadastrar);

end.
