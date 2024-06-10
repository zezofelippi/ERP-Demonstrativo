unit untCadastroCompleto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Vcl.Buttons, JvExButtons, JvButtons, Vcl.ImgList,
  JvExControls, JvTransparentButton, JvNavigationPane, Vcl.Menus,
  untBaseCadastro, Vcl.ExtCtrls, uAuxiliar, Vcl.ComCtrls, uMenu,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL,
  {FireDAC.Phys.MySQLDef,} FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.Provider, Datasnap.DBClient,
  Vcl.Mask, Vcl.DBCtrls, JvExMask, JvToolEdit, JvMaskEdit, JvDBControls,
  JvBaseEdits, uComponenteDataControlsStandard, uPesquisa, uComponentePageControl,
  uTabelaCampos, AdvEdit, DBAdvEd;

type
  TfrmCadastroCompleto = class(TfrmBaseCadastro)
    gpbBotoes: TGroupBox;
    btnLocalizar: TJvNavPanelButton;
    btnNovo: TJvNavPanelButton;
    btnExcluir: TJvNavPanelButton;
    btnAlterar: TJvNavPanelButton;
    btnCancelar: TJvNavPanelButton;
    btnGravar: TJvNavPanelButton;
    imgLista: TImageList;
    procedure popItemCadastrarGroupBox1Click(Sender: TObject);
    procedure tmMostrarComponentesTimer(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    //procedure
  private
    { Private declarations }
    objAuxiliar : TAuxiliar;
  public
    { Public declarations }
  end;

var
  frmBaseCadastro: TfrmBaseCadastro;

implementation

uses untCadastrarGroupBox, untMenu, untCadastrarPageControl;
{$R *.dfm}

procedure TfrmCadastroCompleto.FormActivate(Sender: TObject);
begin
  inherited;

  {Aqui é quando é selecionado UM registro no DBGrid da untBasePesquisa através
   do enter na grid}
   if selecionarUmRegistroNoDBGBridDumaTelaDePesquisa = true then
   begin
     btnAlterar.Enabled:= true;
     btnExcluir.Enabled:= true;
   end;

end;

procedure TfrmCadastroCompleto.FormKeyDown(Sender: TObject; var Key: Word;
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
    btnExcluir.Click
  else if (key = VK_F7) then
    btnLocalizar.Click;

  inherited;

end;

procedure TfrmCadastroCompleto.FormShow(Sender: TObject);
begin
  inherited;
  objAuxiliar:= TAuxiliar.GetInstancia;

  if objAuxiliar.logadoComoADMSistema = true then
    btnNovo.Enabled := false
  else
    btnNovo.Enabled := true;

  btnGravar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := false;
  btnExcluir.Enabled := false;
  btnLocalizar.Enabled := true;
end;

procedure TfrmCadastroCompleto.btnNovoClick(Sender: TObject);
begin
  inherited;

  inserirRegistro;

  btnNovo.Enabled := false;
  btnGravar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnExcluir.Enabled := false;
  btnLocalizar.Enabled := true;
end;

procedure TfrmCadastroCompleto.btnAlterarClick(Sender: TObject);
begin
  inherited;

  alterarRegistro;

  btnNovo.Enabled := false;
  btnGravar.Enabled := true;
  btnCancelar.Enabled := true;
  btnAlterar.Enabled := false;
  btnExcluir.Enabled := false;
  btnLocalizar.Enabled := true;
end;

procedure TfrmCadastroCompleto.btnCancelarClick(Sender: TObject);
begin
  inherited;

  cancelarRegistro;

  btnNovo.Enabled := true;
  btnGravar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := false;
  btnExcluir.Enabled := false;
  btnLocalizar.Enabled := true;
end;

procedure TfrmCadastroCompleto.btnExcluirClick(Sender: TObject);
begin
  inherited;
  deletarRegistro;

  btnNovo.Enabled := true;
  btnGravar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := false;
  btnExcluir.Enabled := false;
  btnLocalizar.Enabled := true;
end;

procedure TfrmCadastroCompleto.btnGravarClick(Sender: TObject);
begin
  inherited;
  if gravarRegistro = false then
    exit;

  btnNovo.Enabled := true;
  btnGravar.Enabled := false;
  btnCancelar.Enabled := false;
  btnAlterar.Enabled := false;
  btnExcluir.Enabled := false;
  btnLocalizar.Enabled := true;

end;

procedure TfrmCadastroCompleto.btnLocalizarClick(Sender: TObject);
var
  frmFormNomePesq: Tform;
  frcFormClassePesq : TFormclass;
  objMenu: TUMenu;
begin
  objMenu:= TUMenu.create;

  frmFormNomePesq := Tform(FindGlobalComponent(
    'frmPesq' +  objMenu.pegarNameDoForm(inttostr(self.Tag))));

  if frmFormNomePesq = nil then
  begin
    frcFormClassePesq := TFormClass(FindClass('TfrmPesquisaConvencional'));
    frmFormNomePesq := frcFormClassePesq.create(nil);

    frmFormNomePesq.Name := 'frmPesq' + objMenu.pegarNameDoForm(inttostr(self.Tag));
    frmFormNomePesq.Tag := self.Tag;
    frmFormNomePesq.Show;
  end
  else
  begin
    frmFormNomePesq.WindowState := wsNormal;
    frmFormNomePesq.BringToFront;
  end;
  FreeAndNil(objMenu);

end;

procedure TfrmCadastroCompleto.popItemCadastrarGroupBox1Click(Sender: TObject);
begin
  inherited;
  frmCadastrarGroupBox := TfrmCadastrarGroupBox.Create(self);
  frmCadastrarGroupBox.Show;
end;

procedure TfrmCadastroCompleto.tmMostrarComponentesTimer(Sender: TObject);
begin
  inherited;
  if pageControl = nil then
  begin
    if objAuxiliar.logadoComoADMSistema = true then
      self.PopupMenu := popOpcoesTelaCadastro;
  end
  else
  begin
    if objAuxiliar.logadoComoADMSistema = true then
      pageControl.PopupMenu := popOpcoesTelaCadastro;
  end;

  cdsCadastro.EmptyDataSet;

end;

initialization
  RegisterClass(TfrmCadastroCompleto);

end.
