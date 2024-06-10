unit untBaseCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, untBase,
  uMenu, uAuxiliar, uComponentePageControl, Vcl.ComCtrls, Vcl.ExtCtrls,
  uComponenteGroupBox, Data.DB, Datasnap.DBClient, Datasnap.Provider, Vcl.Mask,
  Vcl.DBCtrls, uComponenteDataControlsStandard, JvExMask, JvToolEdit, JvMaskEdit, JvDBControls,
  JvBaseEdits, AdvEdit, DBAdvEd, uPesquisa, uTabelaCampos, Vcl.ImgList,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, {FireDAC.Phys.MySQLDef,} FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmBaseCadastro = class(TfrmBase)
    tmMostrarComponentes: TTimer;
    popOpcoesTelaCadastro: TPopupMenu;
    popItemInseriratalho: TMenuItem;
    InserirPageControl1: TMenuItem;
    InserirGroupBox1: TMenuItem;
    ExcluirGroupBox1: TMenuItem;
    popItemAlterarcaptionGroupBox1: TMenuItem;
    popItemInserircampos1: TMenuItem;
    popItemOrdenarcampos1: TMenuItem;
    procedure tmMostrarComponentesTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure popItemInseriratalhoClick(Sender: TObject);
    procedure InserirPageControl1Click(Sender: TObject);
    procedure InserirGroupBox1Click(Sender: TObject);
    procedure popOpcoesTelaCadastroPopup(Sender: TObject);
    procedure ExcluirGroupBox1Click(Sender: TObject);
    procedure popItemAlterarcaptionGroupBox1Click(Sender: TObject);
    procedure popItemInserircampos1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure popItemOrdenarcampos1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objAuxiliar : TAuxiliar;
    giQtdeLinha : integer;
  protected
    pageControl: TPageControl;
    tabSheet: TTabSheet;
    procedure criarBotaoDeAtalho(Sender: TObject);
    procedure cadastrarBotaoDeAtalho;
    procedure criarPageControl;
    procedure destruirPageControl;
    procedure criarGroupBox;
    procedure destruirGroupBox;
    procedure pressionarGroupBox(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure movimentarGroupBox(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure finalizarGroupBox(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure duploCliqueGroupBox(Sender: TObject);
    procedure mostrarDBEdit(pCodigoDBEdit, pLabel, pNameCampo, pCodigoGroupBox,
      pFormatoCampo, pTipoCampo, pDescricaoCampo: string;
      pTop, pLeft, pHeight, pWidth: integer);override;
    procedure inserirDBEditsNosSeusRespectivosGroupBox;
    procedure pressionarDBEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure movimentarDBEdit(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure finalizarDBEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure enterDBEdit(Sender: TObject);
    procedure ordenarCampo(pCodigoGroupBox: string);
    procedure ordenarCamposMesmaLinha;
    procedure ordenarTabNosCampos(pCodigoGroupBox: string);
    procedure SetaParaCima(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pressionarDBMaskEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure movimentarDBMaskEdit(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure finalizarDBMaskEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pressionarDBDateEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure movimentarDBDateEdit(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure finalizarDBDateEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pressionarDBCalcEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure movimentarDBCalcEdit(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure finalizarDBCalcEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure procurarGroupBoxParaAtivalo;
    procedure procurarGroupBoxParaDesativalo;
    procedure ativarPrimeiraAbaDoPageControl;
    procedure inserirFocoDoDBEdit;
    procedure inserirComboBoxNoSeuRespectivoGroupBox;
    procedure inserirRegistro;
    procedure cancelarRegistro;
    procedure alterarRegistro;
    procedure deletarRegistro;
    function selecionarUmRegistroNoDBGBridDumaTelaDePesquisa: boolean;
    function  gravarRegistro: boolean;
    function verificarCamposObrigatorios: boolean;

  public
    { Public declarations }
  end;

var
  frmBaseCadastro: TfrmBaseCadastro;
  giQtdeCol: integer; {Está variável está aqui porque ela está na clausula
                      FOR que aceita variável global ou local}
  gcVetorLinha         : array[1..2, 1..100] of string;

implementation

uses untMenu, untCadastrarPageControl, untCadastrarGroupBox,
  untInserirCampo;

{$R *.dfm}

procedure TfrmBaseCadastro.alterarRegistro;
begin
  cdsCadastro.Edit;

  procurarGroupBoxParaAtivalo;
  ativarPrimeiraAbaDoPageControl;
  inserirFocoDoDBEdit;
end;

procedure TfrmBaseCadastro.ativarPrimeiraAbaDoPageControl;
begin
  if PageControl <> nil then
    PageControl.ActivePageIndex:=0;
end;

procedure TfrmBaseCadastro.cadastrarBotaoDeAtalho;
var
  objMenu : TUMenu;
begin
  objMenu := TUMenu.create;
  if objMenu.cadastrarBotaoAtalho(inttostr(self.Tag)) = 'Erro' then
  begin
    Application.MessageBox(Pchar('Erro no cadastro '+
      ' do botão de atalho '), 'Erro!',
      MB_OK+MB_ICONERROR + MB_TOPMOST);
  end;
  FreeAndNil(objMenu);
end;

procedure TfrmBaseCadastro.cancelarRegistro;
begin
  cdsCadastro.Cancel;
  cdsCadastro.EmptyDataSet;
  procurarGroupBoxParaDesativalo;
end;

procedure TfrmBaseCadastro.criarBotaoDeAtalho(Sender: TObject);
var
  botaoAtalho : TButton;
  objMenu : TUMenu;
  tryIcon : TIcon;
begin
  objMenu := TUMenu.create;
  tryIcon := TIcon.Create;
  botaoAtalho := TButton.Create(frmMenu);

  objMenu.mostrarDadosBotaoDeAtalho(inttostr(self.tag));

  {Coloca ícone do botão de atalho}
  tryIcon.LoadFromFile(
    objMenu.objQuery.FDQuery.FieldByName('DDM_CAMINHO_ICONE').AsString);
  frmMenu.imgListaIconesBotaoAtalho.AddIcon(tryIcon);
  botaoAtalho.images := frmMenu.imgListaIconesBotaoAtalho;
  {FIM}

  botaoAtalho.ImageIndex :=
    objMenu.objQuery.FDQuery.FieldByName('DDBA_POSICAO').AsInteger;
  botaoAtalho.Name := 'btn' + inttostr(self.tag);
  botaoAtalho.tag := self.Tag;
  botaoAtalho.Width := 90;
  botaoAtalho.Caption := '';
  botaoAtalho.Parent := frmMenu.tooBotaoAtalho;
  botaoAtalho.ImageAlignment := iaCenter;
  botaoAtalho.Hint := self.Caption;
  botaoAtalho.ShowHint := TRUE;

  if objAuxiliar.logadoComoADMSistema = true then
    botaoAtalho.PopupMenu := frmMenu.popBotaoAtalho;

  botaoAtalho.ImageAlignment := iaCenter;

  botaoAtalho.OnClick := frmMenu.clicarBotaoAtalho;
  botaoAtalho.OnMouseEnter := frmMenu.pegarNomeDoBotaoDeAtalho;

  FreeAndNil(objMenu);
  FreeAndNil(tryIcon);

end;

procedure TfrmBaseCadastro.criarGroupBox;
var
  objGroupBox: TComponenteGroupBox;
begin

  objGroupBox:= TComponenteGroupBox.create;
  objGroupBox.mostrarGroupBox(inttostr(self.Tag));
  objGroupBox.objQuery.FDQuery.First;
  while not objGroupBox.objQuery.FDQuery.Eof do
  begin
    groupBox := TGroupBox.Create(self);
    if objGroupBox.objQuery.FDQuery.FieldByName('DDTS_CODIGO').AsString = '' then
    begin
      groupBox.Parent :=self;
    end
    else
    begin
      pageControl.ActivePageIndex :=
        objGroupBox.objQuery.FDQuery.FieldByName('DDTS_POSICAO').AsInteger;
      groupBox.Parent := PageControl.ActivePage;
    end;
    groupBox.Top := objGroupBox.objQuery.FDQuery.FieldByName('DDGB_TOP').AsInteger;
    groupBox.Left := objGroupBox.objQuery.FDQuery.FieldByName('DDGB_LEFT').AsInteger;
    groupBox.Height := objGroupBox.objQuery.FDQuery.FieldByName('DDGB_HEIGHT').AsInteger;
    groupBox.Width := objGroupBox.objQuery.FDQuery.FieldByName('DDGB_WIDTH').AsInteger;
    groupBox.Tag := objGroupBox.objQuery.FDQuery.FieldByName('DDGB_CODIGO').AsInteger;
    groupBox.Name := objGroupBox.objQuery.FDQuery.FieldByName('DDGB_NAME').AsString;
    groupBox.Caption := objGroupBox.objQuery.FDQuery.FieldByName('DDGB_CAPTION').AsString;

    if objAuxiliar.logadoComoADMSistema = true then
    begin
      groupBox.PopupMenu := popOpcoesTelaCadastro;
      groupBox.Enabled := true;
    end
    else
      groupBox.Enabled := false;

    groupBox.Font.Size := 09;
    groupBox.Color := $00F2F2F2;
    groupBox.ParentBackground :=false;

    groupBox.OnMouseDown := pressionarGroupBox;
    groupBox.OnMouseMove := movimentarGroupBox;
    groupBox.OnMouseUp   := finalizarGroupBox;
    groupBox.OnDblClick  := duploCliqueGroupBox;

    objGroupBox.objQuery.FDQuery.Next;
  end;
  FreeAndNil(objGroupBox);

end;

procedure TfrmBaseCadastro.criarPageControl;
var
  objComponentePageControl: TComponentePageControl;
begin
  objComponentePageControl:= TComponentePageControl.create;

  objComponentePageControl.verificarSePageControlJaExisteNaTela(
    inttostr(self.Tag));

  if not objComponentePageControl.objQuery.FDQuery.IsEmpty then
  begin
    {Criar PageControl}
    pageControl := TPageControl.Create(self);
    pageControl.Parent := self;
    pageControl.Name :=
      objComponentePageControl.objQuery.FDQuery.FieldByName('DDPC_NOME').AsString;
    pageControl.Font.Size := 11;
    pageControl.Align := alClient;
    pageControl.Tag :=
      objComponentePageControl.objQuery.FDQuery.FieldByName('DDPC_CODIGO').AsInteger;
    {FIM}

    {CriarTabSheet}
    objComponentePageControl.mostrarTabSheet(inttostr(pageControl.Tag));
    objComponentePageControl.objQuery.FDQuery.First;
    while not objComponentePageControl.objQuery.FDQuery.Eof do
    begin
      tabSheet := TTabSheet.Create(pageControl);
      tabSheet.Parent := pageControl;
      tabSheet.PageControl := pageControl;
      tabSheet.Name := RetirarCaracteresEspeciais(
        objComponentePageControl.objQuery.FDQuery.FieldByName('DDTS_CAPTION').AsString);
      tabSheet.Caption:=
        objComponentePageControl.objQuery.FDQuery.FieldByName('DDTS_CAPTION').AsString;
      tabSheet.Tag :=
        objComponentePageControl.objQuery.FDQuery.FieldByName('DDTS_CODIGO').AsInteger;
      objComponentePageControl.objQuery.FDQuery.Next;
    end;
    {FIM}

    FreeAndNil(objComponentePageControl);
  end
  else
    pageControl:= nil;

end;

procedure TfrmBaseCadastro.deletarRegistro;
begin
  cdsCadastro.Delete;
  cdsCadastro.ApplyUpdates(0);
end;

procedure TfrmBaseCadastro.destruirGroupBox;
var
  i : integer;
begin
  for i := self.ComponentCount -1 downto 0 do
  begin
    if (self.Components[i] is TGroupBox) then
      if ((self.Components[i] as TGroupBox).Name <> 'gpbBotoes') and
         ((self.Components[i] as TGroupBox).Name <> 'gpbDados') then
      begin
        groupBox:= TGroupBox(FindComponent((self.Components[i]).Name));
        FreeAndNil(groupBox);
      end;
  end;

end;

procedure TfrmBaseCadastro.destruirPageControl;
begin
  FreeAndNil(pageControl);
end;

procedure TfrmBaseCadastro.duploCliqueGroupBox(Sender: TObject);
begin
  objAuxiliar:= TAuxiliar.GetInstancia;

  if objAuxiliar.tipoDeComponenteSelecionado = 'edits' then
    criarDBEdit(Sender as TObject)
  else if objAuxiliar.tipoDeComponenteSelecionado = 'comboBox' then
    criarComboBox(Sender as TObject);
end;

procedure TfrmBaseCadastro.enterDBEdit(Sender: TObject);
begin

end;

procedure TfrmBaseCadastro.ExcluirGroupBox1Click(Sender: TObject);
var
  i: integer;
  objGroupBox: TComponenteGroupBox;
  cdsGroupBox : TClientDataSet;
  dspGroupBox : TDataSetProvider;
begin
  inherited;
  i := popOpcoesTelaCadastro.PopupComponent.ComponentIndex;
  groupBox := TGroupBox(FindComponent(Components[i].Name));

  if Components[i] is TGroupBox then
  begin
    objGroupBox:= TComponenteGroupBox.create;
    IF objGroupBox.excluirGroupBox(inttostr(groupBox.Tag)) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro na exclusão do GroupBox.'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
      exit;
    end;

    {Reordenar GroupBox}
    objGroupBox.mostrarGroupBox(inttostr(self.Tag));

    dspGroupBox := TDataSetProvider.Create(self);
    dspGroupBox.Name := 'dspGroupBox';
    dspGroupBox.DataSet := objGroupBox.objQuery.FDQuery;

    cdsGroupBox := TClientDataSet.Create(self);
    cdsGroupBox.Name := 'cdsGroupBox';
    cdsGroupBox.ProviderName := dspGroupBox.Name;

    cdsGroupBox.Close;
    cdsGroupBox.FetchParams;
    cdsGroupBox.Open;
    cdsGroupBox.First;
    i:= 1;
    while not cdsGroupBox.Eof do
    begin
      objGroupBox.reordenarNamesDosGroupBox(
        cdsGroupBox.FieldByName('DDGB_CODIGO').AsString, i);
      i:=i+1;
      cdsGroupBox.Next;
    end;
    FreeAndNil(objGroupBox);
    FreeAndNil(cdsGroupBox);
    FreeAndNil(dspGroupBox);

    {FIM}

    tmMostrarComponentes.Enabled := true;
  end;

end;

procedure TfrmBaseCadastro.finalizarDBCalcEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objDataControlsStandard: TComponenteDataControlsStandard;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      calcDBEdit.Left:= calcDBEdit.Left-(gPt.x-x);
      calcDBEdit.Top:= calcDBEdit.Top - (gPt.y-y);
    end;

    objDataControlsStandard:= TComponenteDataControlsStandard.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objDataControlsStandard.alterarTamanhoPosicao(inttostr(calcDBEdit.Tag),
      calcDBEdit.Left, calcDBEdit.Top, calcDBEdit.Width, calcDBEdit.Height);
    FreeAndNil(objDataControlsStandard);
  end;
end;

procedure TfrmBaseCadastro.finalizarDBDateEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objDataControlsStandard: TComponenteDataControlsStandard;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      dateDBEdit.Left:= dateDBEdit.Left-(gPt.x-x);
      dateDBEdit.Top:= dateDBEdit.Top - (gPt.y-y);
    end;

    objDataControlsStandard:= TComponenteDataControlsStandard.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objDataControlsStandard.alterarTamanhoPosicao(inttostr(dateDBEdit.Tag),
      dateDBEdit.Left, dateDBEdit.Top, dateDBEdit.Width, dateDBEdit.Height);
    FreeAndNil(objDataControlsStandard);
  end;
end;

procedure TfrmBaseCadastro.finalizarDBEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objDataControlsStandard: TComponenteDataControlsStandard;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      dbEdit.Left:= dbEdit.Left-(gPt.x-x);
      dbEdit.Top:= dbEdit.Top - (gPt.y-y);
    end;

    objDataControlsStandard:= TComponenteDataControlsStandard.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objDataControlsStandard.alterarTamanhoPosicao(inttostr(dbEdit.Tag),
      dbEdit.Left, dbEdit.Top, dbEdit.Width, dbEdit.Height);
    FreeAndNil(objDataControlsStandard);
  end;

end;

procedure TfrmBaseCadastro.finalizarDBMaskEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objDataControlsStandard: TComponenteDataControlsStandard;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      maskDBEditComp.Left:= maskDBEditComp.Left-(gPt.x-x);
      maskDBEditComp.Top:= maskDBEditComp.Top - (gPt.y-y);
    end;

    objDataControlsStandard:= TComponenteDataControlsStandard.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objDataControlsStandard.alterarTamanhoPosicao(inttostr(maskDBEditComp.Tag),
      maskDBEditComp.Left, maskDBEditComp.Top, maskDBEditComp.Width, maskDBEditComp.Height);
    FreeAndNil(objDataControlsStandard);
  end;
end;

procedure TfrmBaseCadastro.finalizarGroupBox(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objGroupBox: TComponenteGroupBox;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      groupBox.Left:= groupBox.Left-(gPt.x-x);
      groupBox.Top:= groupBox.Top - (gPt.y-y);
    end;

    objGroupBox:= TComponenteGroupBox.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objGroupBox.alterarTamanhoPosicao(inttostr(groupBox.Tag),
      groupBox.Left, groupBox.Top, groupBox.Width, groupBox.Height);
    FreeAndNil(objGroupBox);
  end;
end;

procedure TfrmBaseCadastro.FormActivate(Sender: TObject);
var
  objMenu : TUMenu;
begin
  inherited;
  objMenu := TUMenu.create;
  FreeAndNil(objMenu);

  objAuxiliar := TAuxiliar.GetInstancia;

  {Este if serve p/ verificar se nao está inserindo coluna no DBGrid,
  se estiver o objAuxiliar.tipoTela tem que continuar valendo 'G'}
  if objAuxiliar.inserindoColunaNaDBGrid = false then
    objAuxiliar.tipoTela := 'C';

  if objAuxiliar.recriarComponentes = true then
  begin
    tmMostrarComponentes.Enabled:= true;
    objAuxiliar.recriarComponentes := false;
  end;
end;

procedure TfrmBaseCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmBaseCadastro := nil;
  if frmInserirCampo <> nil then
    frmInserirCampo := nil;
end;

procedure TfrmBaseCadastro.FormShow(Sender: TObject);
begin
  inherited;
  objAuxiliar:= TAuxiliar.GetInstancia;
end;

function TfrmBaseCadastro.gravarRegistro: boolean;
var
  objDataControlsStandard: TComponenteDataControlsStandard;
begin
  objDataControlsStandard:= TComponenteDataControlsStandard.create;

  if verificarCamposObrigatorios = true then
  begin
    result:= false;
    exit;
  end
  else
    result:= true;

  objDataControlsStandard.pesquisarTabela(codigoTabela, 'N');
  cdsCadastro.ApplyUpdates(0);
  FreeAndNil(objDataControlsStandard);

  cdsCadastro.EmptyDataSet;

  procurarGroupBoxParaDesativalo;
end;

procedure TfrmBaseCadastro.inserirComboBoxNoSeuRespectivoGroupBox;
begin

end;

procedure TfrmBaseCadastro.inserirDBEditsNosSeusRespectivosGroupBox;
var
  i: integer;
  objDataControlsStandard : TComponenteDataControlsStandard;
  cdsDBedit : TClientDataSet;
  dspDBEdit : TDataSetProvider;
begin
  objDataControlsStandard := TComponenteDataControlsStandard.create;

  dspDBEdit := TDataSetProvider(FindComponent('dspDBEdit'));
  if dspDBEdit = nil then
  begin
    dspDBEdit := TDataSetProvider.Create(self);
    dspDBEdit.Name:= 'dspDBEdit';
    dspDBEdit.DataSet := objDataControlsStandard.objQuery.FDQuery;
  end;

  cdsDBEdit := TClientDataSet(FindComponent('cdsDBedit'));
  if cdsDBedit = nil then
  begin
    cdsDBedit := TClientDataSet.Create(self);
    cdsDBedit.Name := 'cdsDBedit';
    cdsDBedit.ProviderName := dspDBEdit.Name;
  end;

  objAuxiliar.iContCampoObrigatorio:=0;
  for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TGroupBox Then
    begin
      {Constrói CDS, dsp e dts para cadastro }
      objDataControlsStandard.pesquisarTabela(codigoTabela, 'N');
      dspCadastro := TDataSetProvider(FindComponent('dsp' + self.Name));
      if dspCadastro = nil then
      begin
        dspCadastro := TDataSetProvider.Create(self);
        dspCadastro.Name:= 'dsp' + self.Name;
        dspCadastro.DataSet := objDataControlsStandard.objQuery.FDQuery;
      end;

      cdsCadastro := TClientDataSet(FindComponent('cds' + self.Name));
      if cdsCadastro = nil then
      begin
        cdsCadastro := TClientDataSet.Create(self);
        cdsCadastro.Name := 'cds' + self.Name;
        cdsCadastro.ProviderName := dspCadastro.Name;
      end;

      dtsCadastro := TDataSource(FindComponent('dts' + self.Name));
      if dtsCadastro = nil then
      begin
        dtsCadastro := TDataSource.Create(self);
        dtsCadastro.Name := 'dts' + self.Name;
        dtsCadastro.DataSet := cdsCadastro;
      end;

      cdsCadastro.Close;
      cdsCadastro.FetchParams;
      cdsCadastro.Open;
      {FIM}

      {Inserção dos DBEdits nos seus respectivos groupbox}
      objDataControlsStandard.pesquisarDBEdits(inttostr(Components[i].Tag), '');
      cdsDBedit.Close;
      cdsDBedit.FetchParams;
      cdsDBedit.Open;
      cdsDBedit.First;

      while not cdsDBedit.Eof do
      begin
        mostrarDBEdit(
          cdsDBedit.FieldByName('DDTC_CODIGO').AsString,
          cdsDBedit.FieldByName('CAMPO_APELIDO').AsString,
          cdsDBedit.FieldByName('CAMPO_FISICO').AsString,
          cdsDBedit.FieldByName('DDGB_CODIGO').AsString,
          cdsDBedit.FieldByName('DDBDFC_FORMATO_FISICO').AsString,
          cdsDBedit.FieldByName('DDBDFC_TIPO').AsString,
          cdsDBedit.FieldByName('DDBDFC_DESCRICAO_CAMPO').AsString,
          cdsDBedit.FieldByName('DDTC_TOP').AsInteger,
          cdsDBedit.FieldByName('DDTC_LEFT').AsInteger,
          cdsDBedit.FieldByName('DDTC_HEIGHT').AsInteger,
          cdsDBedit.FieldByName('DDTC_WIDTH').AsInteger);
        cdsDBedit.Next;
      end;
      {FIM}

      {Inserção dos ComboBox nos seus respectivos GroupBox}
      objDataControlsStandard.pesquisarComboBoxTela(inttostr(Components[i].Tag), '');
      cdsDBedit.Close;
      cdsDBedit.FetchParams;
      cdsDBedit.Open;
      cdsDBedit.First;

      while not cdsDBedit.Eof do
      begin
        mostrarComboBox(
          cdsDBedit.FieldByName('DDTC_CODIGO').AsString,
          cdsDBedit.FieldByName('DDGB_CODIGO').AsString,
          cdsDBedit.FieldByName('DDBDC_CAMPO_FISICO').AsString,
          cdsDBedit.FieldByName('DDBDCP_CAMPO_FISICO').AsString,
          cdsDBedit.FieldByName('DDBDT_CODIGO').AsString,
          codigoTabela,
          cdsDBedit.FieldByName('DDCB_NOME_COMBOBOX').AsString,
          cdsDBedit.FieldByName('DDTC_TOP').AsInteger,
          cdsDBedit.FieldByName('DDTC_LEFT').AsInteger,
          cdsDBedit.FieldByName('DDTC_WIDTH').AsInteger);
        cdsDBedit.Next;
      end;
      {FIM}
      ordenarTabNosCampos(inttostr(Components[i].Tag));
    end;

  end;
  FreeAndNil(objDataControlsStandard);

end;

procedure TfrmBaseCadastro.inserirFocoDoDBEdit;
var
  i : integer;
  tipoComboBox: string;
begin
  if pageControl = nil then
  begin
    for i := 0 to ComponentCount -1 do
    begin
      if (Components[i] is TDBEdit) Then
      begin
        dbEdit := TDBEdit(FindComponent(Components[i].Name));
        if dbEdit.ReadOnly = false then
        begin
          dbEdit.SetFocus;
          exit;
        end;
      end
      else if (Components[i] is TJvDBCalcEdit) Then
      begin
        calcDBEdit := TJvDBCalcEdit(FindComponent(Components[i].Name));
        if calcDBEdit.ReadOnly = false then
        begin
          calcDBEdit.SetFocus;
          exit;
        end;
      end
      else if (Components[i] is TDBLookupComboBox) Then
      begin
        compComboBox := TDBLookupComboBox(FindComponent(Components[i].Name));
        tipoComboBox:= Copy(compComboBox.Name,Length(compComboBox.Name), Length(compComboBox.Name) - 2);

        if tipoComboBox = 'C' then
        begin
          if compComboBox.ReadOnly = false then
          begin
            compComboBox.SetFocus;
            exit;
          end;
        end;

      end
      else if (Components[i] is TDBAdvMaskEdit) Then
      begin
        maskDBEditComp := TDBAdvMaskEdit(FindComponent(Components[i].Name));
        if maskDBEditComp.ReadOnly = false then
        begin
          maskDBEditComp.SetFocus;
          exit;
        end;
      end;
    end;
    exit;
  end;

  for i := 0 to ComponentCount -1 do
  begin
    if (Components[i] is TDBEdit) Then
    begin
      dbEdit := TDBEdit(FindComponent(Components[i].Name));
      if dbEdit.ReadOnly = false then
      begin
        groupBox:= TGroupBox(dbEdit.Parent);
        tabSheet:= TTabSheet(groupBox.Parent);
        if tabSheet.TabIndex = 0 then
        begin
          dbEdit.SetFocus;
          exit;
        end;
      end;
    end
    else if (Components[i] is TJvDBCalcEdit) Then
    begin
      calcDBEdit := TJvDBCalcEdit(FindComponent(Components[i].Name));
      if calcDBEdit.ReadOnly = false then
      begin
        groupBox:= TGroupBox(calcDBEdit.Parent);
        tabSheet:= TTabSheet(groupBox.Parent);
        if tabSheet.TabIndex = 0 then
        begin
          calcDBEdit.SetFocus;
          exit;
        end;
      end;
    end
    else if (Components[i] is TDBLookupComboBox) Then
    begin
      compComboBox := TDBLookupComboBox(FindComponent(Components[i].Name));
      if compComboBox.ReadOnly = false then
      begin
        groupBox:= TGroupBox(compComboBox.Parent);
        tabSheet:= TTabSheet(groupBox.Parent);
        if tabSheet.TabIndex = 0 then
        begin
          compComboBox.SetFocus;
          exit;
        end;
      end;
    end
    else if (Components[i] is TDBAdvMaskEdit) Then
    begin
      maskDBEditComp := TDBAdvMaskEdit(FindComponent(Components[i].Name));
      if maskDBEditComp.ReadOnly = false then
      begin
        groupBox:= TGroupBox(maskDBEditComp.Parent);
        tabSheet:= TTabSheet(groupBox.Parent);
        if tabSheet.TabIndex = 0 then
        begin
          maskDBEditComp.SetFocus;
          exit;
        end;
      end;
    end;
  end;
end;

procedure TfrmBaseCadastro.InserirGroupBox1Click(Sender: TObject);
begin
  inherited;

  frmCadastrarGroupBox := TfrmCadastrarGroupBox.Create(self);
  frmCadastrarGroupBox.codigoMenu := inttostr(self.Tag);

  if pageControl = nil then
    frmCadastrarGroupBox.codigoTabSheet := ''
  else
    frmCadastrarGroupBox.codigoTabSheet := inttostr(PageControl.ActivePage.Tag);

  frmCadastrarGroupBox.btnGravar.Tag :=0;
  frmCadastrarGroupBox.Show;
end;

procedure TfrmBaseCadastro.InserirPageControl1Click(Sender: TObject);
begin
  inherited;
  {objAuxiliar é usado porque quando cria o form primeiro executa o que
  está no onShow, onCreate e onActivate e depois é atribuido valor nas
  variáveis}

  objAuxiliar := TAuxiliar.GetInstancia;
  objAuxiliar.codigoMenu := inttostr(self.Tag);
  objauxiliar.nomeTela := RetirarCaracteresEspeciais(self.Caption);

  frmCadastrarPageControl := TfrmCadastrarPageControl.Create(self);
  frmCadastrarPageControl.Show;
end;

procedure TfrmBaseCadastro.inserirRegistro;
begin
  cdsCadastro.Open;
  cdsCadastro.Insert;

  procurarGroupBoxParaAtivalo;
  ativarPrimeiraAbaDoPageControl;
  inserirFocoDoDBEdit;
end;

procedure TfrmBaseCadastro.mostrarDBEdit(pCodigoDBEdit, pLabel, pNameCampo,
  pCodigoGroupBox, pFormatoCampo, pTipoCampo, pDescricaoCampo: string; pTop,
  pLeft, pHeight, pWidth: integer);
var
  objDataControlsStandard: TComponenteDataControlsStandard;
begin
  objDataControlsStandard:= TComponenteDataControlsStandard.create;
  groupBox := TGroupBox(FindComponent(
    objDataControlsStandard.pegarNomeDoGroupBox(pCodigoDBEdit)));

  {Inserir no vetor campos de preenchimento obrigatório}
  if objDataControlsStandard.verificarSeCampoPreenchimentoObrigatorio
     (pCodigoDBEdit) = true then
  begin
    objAuxiliar.vetorCamposPreenchimentoObrigatorio
      [objAuxiliar.iContCampoObrigatorio]:='edt' + pCodigoDBEdit;

    objAuxiliar.iContCampoObrigatorio:=objAuxiliar.iContCampoObrigatorio+1;
  end;
  {FIM}

  if ((pFormatoCampo = '') and (pTipoCampo = 'VARCHAR'))
    or (pTipoCampo = '') then
  begin
    dbEdit := TDBEdit.Create(self);

    dbEdit.Parent := groupBox;
    dbEdit.Left := pLeft;
    dbEdit.Top := pTop;
    dbEdit.Width := pWidth;
    dbEdit.Tag := strtoint(pCodigoDBEdit);
    dbEdit.Hint:= 'dbEdt' + pNameCampo;
    dbEdit.ShowHint:= true;

    if objAuxiliar.logadoComoADMSistema = true then
      dbEdit.PopupMenu := popExcluirDBEdit;

    dbEdit.Name := 'dbEdt' + pNameCampo;
    dbEdit.TabOrder := dbEdit.TabOrder + 1;
    dbEdit.Height := 26;
    dbEdit.DataSource := dtsCadastro;
    dbEdit.DataField := pNameCampo;

    if pTipoCampo = '' then
    begin
      dbEdit.ReadOnly := true;
      dbEdit.Color := $00E0E0E0;
    end;

    dbEdit.OnMouseDown := pressionarDBEdit;
    dbEdit.OnMouseMove := movimentarDBEdit;
    dbEdit.OnMouseUp   := finalizarDBEdit;
    dbEdit.OnEnter     := enterCampo;
    dbEdit.OnExit      := exitCampo;
    dbEdit.OnKeyPress  := EnterFoco;
    dbEdit.onKeyUp     := SetaParaCima;
  end
  else if (pFormatoCampo <> '') then
  begin
    maskDBEditComp := TDBAdvMaskEdit.Create(self);

    maskDBEditComp.Parent := groupBox;
    maskDBEditComp.Left := pLeft;
    maskDBEditComp.Top := pTop;
    maskDBEditComp.Width := pWidth;
    maskDBEditComp.Tag := strtoint(pCodigoDBEdit);
    maskDBEditComp.AutoTab:= false;

    if objAuxiliar.logadoComoADMSistema = true then
      maskDBEditComp.PopupMenu := popExcluirDBEdit;

    maskDBEditComp.Name := 'dbEdt' + pNameCampo;
    maskDBEditComp.TabOrder := maskDBEditComp.TabOrder + 1;
    maskDBEditComp.EditMask := pFormatoCampo;
    maskDBEditComp.Height := 26;
    maskDBEditComp.DataSource := dtsCadastro;
    maskDBEditComp.DataField := pNameCampo;

    maskDBEditComp.OnMouseDown := pressionarDBMaskEdit;
    maskDBEditComp.OnMouseMove := movimentarDBMaskEdit;
    maskDBEditComp.OnMouseUp   := finalizarDBMaskEdit;
    maskDBEditComp.OnEnter     := enterCampo;
    maskDBEditComp.OnExit      := exitCampo;
    maskDBEditComp.OnKeyPress  := EnterFoco;
    maskDBEditComp.onKeyUp     := SetaParaCima;
  end
  else if (pTipoCampo = 'TIMESTAMP') then
  begin
    dateDBEdit := TJvDBDateEdit.Create(self);

    dateDBEdit.Parent := groupBox;
    dateDBEdit.Left := pLeft;
    dateDBEdit.Top := pTop;
    dateDBEdit.Width := pWidth;
    dateDBEdit.Tag := strtoint(pCodigoDBEdit);

    if objAuxiliar.logadoComoADMSistema = true then
      dateDBEdit.PopupMenu := popExcluirDBEdit;

    dateDBEdit.Name := 'dbEdt' + pNameCampo;
    dateDBEdit.TabOrder := dateDBEdit.TabOrder + 1;
    dateDBEdit.Height := 26;
    dateDBEdit.DataSource := dtsCadastro;
    dateDBEdit.DataField := pNameCampo;

    dateDBEdit.OnMouseDown := pressionarDBDateEdit;
    dateDBEdit.OnMouseMove := movimentarDBDateEdit;
    dateDBEdit.OnMouseUp   := finalizarDBDateEdit;
    dateDBEdit.OnEnter     := enterCampo;
    dateDBEdit.OnExit      := exitCampo;
    dateDBEdit.OnKeyPress  := EnterFoco;
    dateDBEdit.onKeyUp     := SetaParaCima;
  end
  else if (pTipoCampo = 'DOUBLE') then
  begin
    calcDBEdit := TJvDBCalcEdit.Create(self);

    calcDBEdit.Parent := groupBox;
    calcDBEdit.Left := pLeft;
    calcDBEdit.Top := pTop;
    calcDBEdit.Width := pWidth;
    calcDBEdit.Tag := strtoint(pCodigoDBEdit);

    if objAuxiliar.logadoComoADMSistema = true then
      calcDBEdit.PopupMenu := popExcluirDBEdit;

    calcDBEdit.Name := 'dbEdt' + pNameCampo;
    calcDBEdit.TabOrder := calcDBEdit.TabOrder + 1;
    calcDBEdit.Height := 26;
    calcDBEdit.ShowButton := false;
    calcDBEdit.DataSource := dtsCadastro;
    calcDBEdit.DataField := pNameCampo;

    calcDBEdit.DecimalPlacesAlwaysShown:=true;

    calcDBEdit.OnMouseDown := pressionarDBCalcEdit;
    calcDBEdit.OnMouseMove := movimentarDBCalcEdit;
    calcDBEdit.OnMouseUp   := finalizarDBCalcEdit;
    calcDBEdit.OnEnter     := enterCampo;
    calcDBEdit.OnExit      := exitCampo;
    calcDBEdit.OnKeyPress  := EnterFoco;
    calcDBEdit.onKeyUp     := SetaParaCima;

    if pDescricaoCampo = 'QTDE' then
    begin
      calcDBEdit.DisplayFormat := '###,##0.000';
      calcDBEdit.DecimalPlaces := 3;
    end
    else if pDescricaoCampo = 'VALOR MONETÁRIO(10,2)' then
    begin
      calcDBEdit.DisplayFormat := 'R$###,##0.00';
      calcDBEdit.DecimalPlaces := 2;
    end
    else if pDescricaoCampo = 'VALOR MONETÁRIO(10,4)' then
    begin
      calcDBEdit.DisplayFormat := 'R$###,##0.0000';
      calcDBEdit.DecimalPlaces := 4;
    end;

  end;

  {Cria label}
  labelComp := TLabel.Create(self);
  labelComp.Left := pLeft;
  labelComp.Top  := pTop - 17;
  labelComp.name   := 'dblbl' + 'dbEdt' + pNameCampo;
  labelComp.Caption := pLabel;
  labelComp.parent := groupBox;

  FreeAndNIL(objDataControlsStandard);
end;

procedure TfrmBaseCadastro.movimentarDBCalcEdit(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    calcDBEdit.Left:= calcDBEdit.Left-(gPt.x-x);
    calcDBEdit.Top:= calcDBEdit.Top - (gPt.y-y);
    labelComp.Left:= labelComp.Left-(gPt.x-x);
    labelComp.Top:= labelComp.Top - (gPt.y-y);

  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
     calcDBEdit.Width := x +1;
  end;
end;

procedure TfrmBaseCadastro.movimentarDBDateEdit(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    dateDBEdit.Left:= dateDBEdit.Left-(gPt.x-x);
    dateDBEdit.Top:= dateDBEdit.Top - (gPt.y-y);
    labelComp.Left:= labelComp.Left-(gPt.x-x);
    labelComp.Top:= labelComp.Top - (gPt.y-y);

  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
     dateDBEdit.Width := x +1;
  end;
end;

procedure TfrmBaseCadastro.movimentarDBEdit(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    dbEdit.Left:= dbEdit.Left-(gPt.x-x);
    dbEdit.Top:= dbEdit.Top - (gPt.y-y);
    labelComp.Left:= labelComp.Left-(gPt.x-x);
    labelComp.Top:= labelComp.Top - (gPt.y-y);

  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
     dbEdit.Width := x +1;
  end;
end;

procedure TfrmBaseCadastro.movimentarDBMaskEdit(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    maskDBEditComp.Left:= maskDBEditComp.Left-(gPt.x-x);
    maskDBEditComp.Top:= maskDBEditComp.Top - (gPt.y-y);
    labelComp.Left:= labelComp.Left-(gPt.x-x);
    labelComp.Top:= labelComp.Top - (gPt.y-y);

  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
     maskDBEditComp.Width := x +1;
  end;
end;

procedure TfrmBaseCadastro.movimentarGroupBox(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin

  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    groupBox.Left:= groupBox.Left-(gPt.x-x);
    groupBox.Top:= groupBox.Top - (gPt.y-y);
  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
     groupBox.Width := x +1;
     groupBox.Height := y +1;
  end;
end;

procedure TfrmBaseCadastro.ordenarCampo(pCodigoGroupBox: string);
var
  i, iTop, iSomatop, iSomawidth: integer;
  cComp: string;
  cptComponente : TComponent;
  objDataControlsStandard: TComponenteDataControlsStandard;
begin
  objDataControlsStandard := TComponenteDataControlsStandard.create;
  objDataControlsStandard.pesquisarDBEdits(pCodigoGroupBox, 'Ordenar');
  objDataControlsStandard.objQuery.FDQuery.First;

  {Limpeza de vetor}
  FillChar(gcVetorLinha, SizeOf(gcVetorLinha), #0);
  {FIM}

  giQtdeLinha:=1;
  iTop:= 0;
  i:=0;

  while not objDataControlsStandard.objQuery.FDQuery.Eof do
  begin
    gcVetorLinha[1,i+1] :=
      objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString;
    gcVetorLinha[2,i+1] := '999'; {passa-se o valor 999 para nao ficar
                                vazio quando passar no while de organização
                                dos campos (1º campo, 2ºcampo e etc)
                                e poder sair do while}
    if objDataControlsStandard.objQuery.FDQuery.RecNo = 1 then
    begin
      gcVetorLinha[2,i+1] := '1';
      iTop:= objDataControlsStandard.objQuery.FDQuery.FieldByName('DDTC_TOP').AsInteger;
    end
    else
    begin

      if (objDataControlsStandard.objQuery.FDQuery.FieldByName('DDTC_TOP').AsInteger - iTop) > 30 then
      begin

        {Organiza a ordem dos campos da mesma linha (1ºcampo, 2ºcampo,
          3ºcampo e etc)}
         OrdenarCamposMesmaLinha;
        {FIM}

        giQtdeLinha:= giQtdeLinha+1;
        iTop:= objDataControlsStandard.objQuery.FDQuery.FieldByName('DDTC_TOP').AsInteger;
      end;
       gcVetorLinha[2,i+1] := IntToStr(giQtdeLinha);
    end;
    i:=i+1;
    objDataControlsStandard.objQuery.FDQuery.Next;
  end;

  {Repetição do codigo de ordenação dos vetores}
  OrdenarCamposMesmaLinha;
  {FIM}

  {Calcula media Top e left de cada linha}
  objDataControlsStandard:= TComponenteDataControlsStandard.create;
  iSomatop:= 45;
  giQtdeCol:=1;
  for i:=1 to giQtdeLinha do
  begin
    //iSomaLeft:= 25;
    iSomawidth:= 0;
    while gcVetorLinha[2,giQtdeCol] = IntToStr(i) do
    begin
      cptComponente := FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]);

      if cptComponente = nil then
      begin
        cptComponente := FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol] + '_C');

      end;

      cComp:= cptComponente.ClassName;

      {Calcula media vertical (Top) da linha}
      if cComp = 'TDBEdit' then
      begin
        DBEdit := TDBEdit(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]));
        DBEdit.Top := iSomaTop;
      end
      else if cComp = 'TDBAdvMaskEdit' then
      begin
        maskDBEditComp := TDBAdvMaskEdit(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]));
        maskDBEditComp.Top := iSomaTop;
      end
      else if cComp = 'TJvDBCalcEdit' then
      begin
        calcDBEdit := TJvDBCalcEdit(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]));
        calcDBEdit.Top := iSomaTop;
      end
      else if cComp = 'TJvDBDateEdit' then
      begin
        dateDBEdit := TJvDBDateEdit(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]));
        dateDBEdit.Top := iSomaTop;
      end
      else if cComp = 'TDBLookupComboBox' then
      begin
        compComboBox := TDBLookupComboBox(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]+ '_C'));
        compComboBox.Top := iSomaTop;
      end;

      labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol]));

      if labelComp = nil then
        labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol] + '_C'));

      labelComp.Top := iSomaTop -17;
      {FIM}

      {Calcula o espaço horizontal(left) entre os campos da mesma linha}
      if iSomawidth = 0 then
      begin
        if cComp = 'TDBEdit' then
        begin
          iSomawidth:= DBEdit.Width +25;
          DBEdit.Left:= 25;
        end
        else if cComp = 'TDBAdvMaskEdit' then
        begin
          iSomawidth:= maskDBEditComp.Width +25;
          maskDBEditComp.Left:= 25;
        end
        else if cComp = 'TJvDBDateEdit' then
        begin
          iSomawidth:= dateDBEdit.Width +25;
          dateDBEdit.Left:= 25;
        end
        else if cComp = 'TJvDBCalcEdit' then
        begin
          iSomawidth:= calcDBEdit.Width +25;
          calcDBEdit.Left:= 25;
        end
        else if cComp = 'TDBLookupComboBox' then
        begin
          iSomawidth:= compComboBox.Width +25;
          compComboBox.Left:= 25;
        end;
        labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol]));

        if labelComp = nil then
        begin
          labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol] + '_C'));

        end;

        labelComp.Left:= 25;
      end
      else
      begin
        if cComp = 'TDBEdit' then
        begin
          DBEdit.Left:= iSomawidth + 10;
          labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol]));
          labelComp.Left:= iSomawidth +10;
          iSomawidth:= iSomawidth + DBEdit.Width +10;
        end
        else if cComp = 'TDBAdvMaskEdit' then
        begin
          maskDBEditComp.Left:= iSomawidth + 10;
          labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol]));
          labelComp.Left:= iSomawidth +10;
          iSomawidth:= iSomawidth + maskDBEditComp.Width +10;
        end
        else if cComp = 'TJvDBDateEdit' then
        begin
          dateDBEdit.Left:= iSomawidth + 10;
          labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol]));
          labelComp.Left:= iSomawidth +10;
          iSomawidth:= iSomawidth + dateDBEdit.Width +10;
        end
        else if cComp = 'TJvDBCalcEdit' then
        begin
          calcDBEdit.Left:= iSomawidth + 10;
          labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol]));
          labelComp.Left:= iSomawidth +10;
          iSomawidth:= iSomawidth + calcDBEdit.Width +10;
        end
        else if cComp = 'TDBLookupComboBox' then
        begin
          compComboBox.Left:= iSomawidth + 10;
          labelComp := TLabel(FindComponent('dblbl' + 'dbedt' + gcVetorLinha[1,giQtdeCol] + '_C'));
          labelComp.Left:= iSomawidth +10;
          iSomawidth:= iSomawidth + compComboBox.Width +10;
        end;

      end;
      {FIM}

      {grava a posicao horizontal e vertical na tabela}
      if cComp = 'TDBEdit' then
      begin
        objDataControlsStandard.alterarTamanhoPosicao(inttostr(dbEdit.Tag),
          dbEdit.Left, dbEdit.Top, dbEdit.Width, dbEdit.Height);
      end
      else if cComp = 'TDBAdvMaskEdit' then
      begin
        objDataControlsStandard.alterarTamanhoPosicao(inttostr(maskDBEditComp.Tag),
          maskDBEditComp.Left, maskDBEditComp.Top, maskDBEditComp.Width, maskDBEditComp.Height);
      end
      else if cComp = 'TJvDBDateEdit' then
      begin
        objDataControlsStandard.alterarTamanhoPosicao(inttostr(dateDBEdit.Tag),
          dateDBEdit.Left, dateDBEdit.Top, dateDBEdit.Width, dateDBEdit.Height);
      end
      else if cComp = 'TJvDBCalcEdit' then
      begin
        objDataControlsStandard.alterarTamanhoPosicao(inttostr(calcDBEdit.Tag),
          calcDBEdit.Left, calcDBEdit.Top, calcDBEdit.Width, calcDBEdit.Height);
      end
      else if cComp = 'TDBLookupComboBox' then
      begin
        objDataControlsStandard.alterarTamanhoPosicao(inttostr(compComboBox.Tag),
          compComboBox.Left, compComboBox.Top, compComboBox.Width, compComboBox.Height);
      end;
      {FIM}
      giQtdeCol:= giQtdeCol +1;
    end;
    iSomatop:= iSomaTop + 45;
  end;

  ordenarTabNosCampos(pCodigoGroupBox);

  FreeAndNil(objDataControlsStandard);

end;

procedure TfrmBaseCadastro.OrdenarCamposMesmaLinha;
var
  iAuxOrd, iAuxLeft: integer;
  cptComponente : TComponent;
  cVetorAuxOrdenacao: array[1..2, 1..20] of string;
  cComp, cNomeCampoAux: string;
begin
  {Organiza a ordem dos campos da mesma linha (1ºcampo, 2ºcampo,
            3ºcampo e etc)}

  {Recebe left e nomedocampo no vetor auxiliar}
  giQtdeCol:= 1;
  iAuxOrd:=1;
  while StrToInt(gcVetorLinha[2,giQtdeCol]) <= giQtdeLinha do
  begin
    if StrToInt(gcVetorLinha[2,giQtdeCol]) = giQtdeLinha then
    begin
      cptComponente := FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]);

      if cptComponente = nil then
      begin
        cptComponente := FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol] + '_C');
      end;

      cComp:= cptComponente.ClassName;

      if cComp = 'TDBEdit' then
      begin
        dbEdit := TDBEdit(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]));
        cVetorAuxOrdenacao[1,iAuxOrd]:= gcVetorLinha[1,giQtdeCol];
        cVetorAuxOrdenacao[2,iAuxOrd]:= IntToStr(dbEdit.Left);
      end
      else if cComp = 'TDBAdvMaskEdit' then
      begin
        maskDBEditComp := TDBAdvMaskEdit(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]));
        cVetorAuxOrdenacao[1,iAuxOrd]:= gcVetorLinha[1,giQtdeCol];
        cVetorAuxOrdenacao[2,iAuxOrd]:= IntToStr(maskDBEditComp.Left);
      end
      else if cComp = 'TJvDBDateEdit' then
      begin
        dateDBEdit := TJvDBDateEdit(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]));
        cVetorAuxOrdenacao[1,iAuxOrd]:= gcVetorLinha[1,giQtdeCol];
        cVetorAuxOrdenacao[2,iAuxOrd]:= IntToStr(dateDBEdit.Left);
      end
      else if cComp = 'TJvDBCalcEdit' then
      begin
        calcDBEdit := TJvDBCalcEdit(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]));
        cVetorAuxOrdenacao[1,iAuxOrd]:= gcVetorLinha[1,giQtdeCol];
        cVetorAuxOrdenacao[2,iAuxOrd]:= IntToStr(calcDBEdit.Left);
      end
      else if cComp = 'TDBLookupComboBox' then
      begin
        compComboBox := TDBLookupComboBox(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]+ '_C'));
        cVetorAuxOrdenacao[1,iAuxOrd]:= gcVetorLinha[1,giQtdeCol];
        cVetorAuxOrdenacao[2,iAuxOrd]:= IntToStr(compComboBox.Left);
      end;

      iAuxOrd:=iAuxOrd+1;
    end;
    giQtdeCol:=giQtdeCol +1;
    if gcVetorLinha[2,giQtdeCol] = '' then
      Break;
  end;
  {FIM}

  {Ordena os lefts no vetor auxiliar}
  for iAuxOrd := 1 to 20 do
    for giQtdeCol := iAuxOrd + 1 to 21 do
    begin
      if (cVetorAuxOrdenacao[2,giQtdeCol] <> '') and
         (giQtdeCol <= 20) then
        if StrToInt(cVetorAuxOrdenacao[2,iAuxOrd]) >
          StrToInt(cVetorAuxOrdenacao[2,giQtdeCol]) then
        begin
          iAuxLeft:= StrToInt(cVetorAuxOrdenacao[2, iAuxOrd]);
          cVetorAuxOrdenacao[2,iAuxOrd]:= cVetorAuxOrdenacao[2,giQtdeCol];
          cVetorAuxOrdenacao[2,giQtdeCol]:= IntToStr(iAuxLeft);

          cNomeCampoAux:= cVetorAuxOrdenacao[1, iAuxOrd];
          cVetorAuxOrdenacao[1,iAuxOrd]:= cVetorAuxOrdenacao[1,giQtdeCol];
          cVetorAuxOrdenacao[1,giQtdeCol]:= cNomeCampoAux;
        end;
    end;
   {FIM}

  {Coloca os campos em ordem de left no vetor principal}
  giQtdeCol:= 1;
  iAuxOrd:=1;
  while StrToInt(gcVetorLinha[2,giQtdeCol]) <= giQtdeLinha do
  begin
    if StrToInt(gcVetorLinha[2,giQtdeCol]) = giQtdeLinha then
    begin
      gcVetorLinha[1,giQtdeCol]:= cVetorAuxOrdenacao[1,iAuxOrd];
      iAuxOrd:= iAuxOrd+1;
    end;
    giQtdeCol:=giQtdeCol+1;
    if gcVetorLinha[2,giQtdeCol] = '' then
      Break;
  end;
  {FIM}

  {Limpa variável}
  giQtdeCol:=1;
  while giQtdeCol <=20 do
  begin
    cVetorAuxOrdenacao[1,giQtdeCol]:='';
    cVetorAuxOrdenacao[2,giQtdeCol]:='';
    giQtdeCol:=giQtdeCol +1;
  end;
  {FIM}
end;

procedure TfrmBaseCadastro.ordenarTabNosCampos(pCodigoGroupBox: string);
var
  objDataControlsStandard : TComponenteDataControlsStandard;
  cptComponente: TComponent;
  cComp: string;
  i: integer;
begin
  objDataControlsStandard := TComponenteDataControlsStandard.create;
  objDataControlsStandard.pesquisarDBEdits(pCodigoGroupBox, 'Ordenar');

  objDataControlsStandard.objQuery.FDQuery.First;

  i:=1;
  while not objDataControlsStandard.objQuery.FDQuery.Eof do
  begin
    cptComponente :=
      FindComponent('dbEdt' +
      objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString);

    if (cptComponente = nil) then
      cptComponente:= FindComponent('dbEdt' +
        objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString + '_C');

    if (cptComponente = nil) then
      cptComponente:= FindComponent('dbEdt' +
        objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString + '_P');

    cComp := cptComponente.ClassName;

    if 'TDBEdit' = cComp then
    begin
      DBEdit := TDBEdit(FindComponent('dbEdt' +
        objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString));

      DBEdit.TabOrder := i;
    end
    else if 'TDBAdvMaskEdit' = cComp then
    begin
      maskDBEditComp := TDBAdvMaskEdit(FindComponent('dbEdt' +
        objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString));

      maskDBEditComp.TabOrder := i;
    end
    else if 'TJvDBDateEdit' = cComp then
    begin
      dateDBEdit := TJvDBDateEdit(FindComponent('dbEdt' +
        objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString));

      dateDBEdit.TabOrder := i;
    end
    else if 'TJvDBCalcEdit' = cComp then
    begin
      calcDBEdit := TJvDBCalcEdit(FindComponent('dbEdt' +
        objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString));

      calcDBEdit.TabOrder := i;
    end
    else if 'TDBLookupComboBox' = cComp then
    begin
      compComboBox := TDBLookUpComboBox(FindComponent('dbEdt' +
          objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString  + '_C'));

      if compComboBox = nil then
        compComboBox := TDBLookUpComboBox(FindComponent('dbEdt' +
          objDataControlsStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString  + '_P'));

      compComboBox.TabOrder := i;
    end;
    i:=i+1;

    objDataControlsStandard.objQuery.FDQuery.Next;
  end;
  FreeAndNil(objDataControlsStandard);

end;

procedure TfrmBaseCadastro.popOpcoesTelaCadastroPopup(Sender: TObject);
var
  objMenu : TUMenu;
begin
  inherited;
  objMenu := TUMenu.create;
  if objMenu.verificarSeBotaoDeAtalhoJaExiste(inttostr(self.Tag)) = true then
    popItemInseriratalho.Enabled := false
  ELSE
    popItemInseriratalho.Enabled := true;

  FreeAndNil(objMenu);

end;

procedure TfrmBaseCadastro.popItemAlterarcaptionGroupBox1Click(
  Sender: TObject);
var
  i : integer;
begin
  inherited;
  i := popOpcoesTelaCadastro.PopupComponent.ComponentIndex;
  groupBox := TGroupBox(FindComponent(Components[i].Name));

  if Components[i] is TGroupBox then
  begin
    frmCadastrarGroupBox := TfrmCadastrarGroupBox.Create(self);
    frmCadastrarGroupBox.codigoGroupBox := inttostr(groupBox.Tag);
    frmCadastrarGroupBox.edtNomeTela.Text := groupBox.Caption;
    frmCadastrarGroupBox.btnGravar.Tag := 1;
    frmCadastrarGroupBox.Show;
  end;
end;

procedure TfrmBaseCadastro.popItemInseriratalhoClick(Sender: TObject);
begin
  inherited;
  cadastrarBotaoDeAtalho;
  criarBotaoDeAtalho(Sender as TObject);
end;

procedure TfrmBaseCadastro.popItemInserircampos1Click(Sender: TObject);
begin
  inherited;
  objAuxiliar := TAuxiliar.GetInstancia;
  objAuxiliar.codigoMenu := inttostr(self.Tag);
  objAuxiliar.codigoTabela := codigoTabela;
  objAuxiliar.tipoTela := 'C'; {C de tela de Cadastro}

  if frmInserirCampo = nil then
  begin
    frmInserirCampo := TfrmInserirCampo.Create(self);
    frmInserirCampo.Show;
  end
  else
  begin
    frmInserirCampo.tmMostrarDados.Enabled := true;
    frmInserirCampo.WindowState := wsNormal;
    frmInserirCampo.BringToFront;
  end;
end;

procedure TfrmBaseCadastro.popItemOrdenarcampos1Click(Sender: TObject);
var
  i: integer;
begin
  i := popOpcoesTelaCadastro.PopupComponent.ComponentIndex;
  groupBox := TGroupBox(FindComponent(Components[i].Name));
  if groupBox.Enabled = true then
    ordenarCampo(inttostr(groupBox.Tag));
end;

procedure TfrmBaseCadastro.pressionarDBCalcEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  calcDBEdit := Sender as TJvDBCalcEdit;
  labelComp := TLabel(FindComponent('dblbl' + calcDBEdit.Name));
  if ssCtrl in Shift then
  begin
    SetCapture(calcDBEdit.Handle);
    gbCapturando := true;
    gPt.X := x;
    gPt.Y := Y;
    gbAlterandoPosicao := true;
    gbAlterandoTamanho := false;
    exit;
  end;

  if ssShift in Shift then
  begin
    gbAlterandoTamanho := true;
    gbAlterandoPosicao := false;
    exit;
  end;
end;

procedure TfrmBaseCadastro.pressionarDBDateEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dateDBEdit := Sender as TJvDBDateEdit;
  labelComp := TLabel(FindComponent('dblbl' + dateDBEdit.Name));
  if ssCtrl in Shift then
  begin
    SetCapture(dateDBEdit.Handle);
    gbCapturando := true;
    gPt.X := x;
    gPt.Y := Y;
    gbAlterandoPosicao := true;
    gbAlterandoTamanho := false;
    exit;
  end;

  if ssShift in Shift then
  begin
    gbAlterandoTamanho := true;
    gbAlterandoPosicao := false;
    exit;
  end;
end;

procedure TfrmBaseCadastro.pressionarDBEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  dbEdit := Sender as TDBEdit;
  labelComp := TLabel(FindComponent('dblbl' + dbEdit.Name));
  if ssCtrl in Shift then
  begin
    SetCapture(dbEdit.Handle);
    gbCapturando := true;
    gPt.X := x;
    gPt.Y := Y;
    gbAlterandoPosicao := true;
    gbAlterandoTamanho := false;
    exit;
  end;

  if ssShift in Shift then
  begin
    gbAlterandoTamanho := true;
    gbAlterandoPosicao := false;
    exit;
  end;
end;

procedure TfrmBaseCadastro.pressionarDBMaskEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  maskDBEditComp := Sender as TDBAdvMaskEdit;
  labelComp := TLabel(FindComponent('dblbl' + maskDBEditComp.Name));
  if ssCtrl in Shift then
  begin
    SetCapture(maskDBEditComp.Handle);
    gbCapturando := true;
    gPt.X := x;
    gPt.Y := Y;
    gbAlterandoPosicao := true;
    gbAlterandoTamanho := false;
    exit;
  end;

  if ssShift in Shift then
  begin
    gbAlterandoTamanho := true;
    gbAlterandoPosicao := false;
    exit;
  end;
end;

procedure TfrmBaseCadastro.pressionarGroupBox(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  groupBox := Sender as TGroupBox;
  if ssCtrl in Shift then
  begin
    SetCapture(groupBox.Handle);
    gbCapturando := true;
    gPt.X := x;
    gPt.Y := Y;
    gbAlterandoPosicao := true;
    gbAlterandoTamanho := false;
    exit;
  end;

  if ssShift in Shift then
  begin
    gbAlterandoTamanho := true;
    gbAlterandoPosicao := false;
    exit;
  end;
end;

procedure TfrmBaseCadastro.procurarGroupBoxParaAtivalo;
var
  i : integer;
begin
  for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TGroupBox Then
    begin
      groupBox := TGroupBox(FindComponent(Components[i].Name));
      groupBox.Enabled := true;
    end;
  end;
end;

procedure TfrmBaseCadastro.procurarGroupBoxParaDesativalo;
var
  i : integer;
begin
  for i := 0 to ComponentCount -1 do
  begin
    if (Components[i] is TGroupBox) and (Components[i].Name <> 'gpbBotoes') and
      (Components[i] is TGroupBox) and (Components[i].Name <> 'gpbDados') Then
    begin
      groupBox := TGroupBox(FindComponent(Components[i].Name));
      groupBox.Enabled := false;
    end;
  end;

end;

function TfrmBaseCadastro.selecionarUmRegistroNoDBGBridDumaTelaDePesquisa: boolean;
var
  objPesquisa: TPesquisa;
  objTabelaCampo: TTabelaCampos;
begin
  objAuxiliar:= TAuxiliar.GetInstancia;
  if objAuxiliar.pesquisandoRegistro = true then
  begin
    objPesquisa:= TPesquisa.create;
    objTabelaCampo:= TTabelaCampos.create;

    objPesquisa.selecionarUmRegistroDoDBGrid(
      objAuxiliar.idRegistroChavePrimaria, codigoTabela);

    dspCadastro.DataSet := objPesquisa.objQuery.FDQuery;

    cdsCadastro.Close;
    cdsCadastro.FetchParams;
    cdsCadastro.Open;

    FreeAndNil(objTabelaCampo);
    FreeAndNil(objPesquisa);

    objAuxiliar.pesquisandoRegistro:= false;
    result:= true;
  end
  else
  begin
    result:= false;
  end;
end;

procedure TfrmBaseCadastro.SetaParaCima(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key =VK_UP then
    Perform(Wm_NextDlgCtl,1,0);
end;

procedure TfrmBaseCadastro.tmMostrarComponentesTimer(Sender: TObject);
var
  objMenu : TUMenu;
begin
  {É usado time porque o self pego no onShow ou onActivate
    é do frmCadastroCompleto e não do form virtual. Após a criação
    do form vrtual na memória que será pego o self virtual}

  objMenu := TUMenu.Create;
  codigoTabela := objMenu.pegarCodigoTabela(inttostr(self.tag));
  FreeAndNil(objMenu);
  destruirPageControl;
  destruirGroupBox;
  criarPageControl;
  criarGroupBox;
  inserirDBEditsNosSeusRespectivosGroupBox;
  ativarPrimeiraAbaDoPageControl;

  objAuxiliar := TAuxiliar.GetInstancia;
  objAuxiliar.tipoTela := 'C';

  tmMostrarComponentes.Enabled := false;
end;

function TfrmBaseCadastro.verificarCamposObrigatorios: boolean;
var
  objDataControlsStandard: TComponenteDataControlsStandard;
  i, iPosicaoTabSheet: integer;
  cComp, cCompEdit: string;
  cptComponente: TComponent;
  objPageControl: TComponentePageControl;
begin
  objDataControlsStandard:= TComponenteDataControlsStandard.create;

  i:=0;
  while i< objAuxiliar.iContCampoObrigatorio do
  begin
    cptComponente := FindComponent(
      objAuxiliar.vetorCamposPreenchimentoObrigatorio[i]);

    cComp:= cptComponente.ClassName; {nao pode ser usado o
                                      cptComponente porque nao possui setfocus}

    if cComp = 'TDBEdit' then
    begin
      dbEdit:= TDBEdit(FindComponent(
        objAuxiliar.vetorCamposPreenchimentoObrigatorio[i]));

      if dbEdit.Text = '' then
      begin
        if pageControl <> nil then
        begin
          objPageControl := TComponentePageControl.create;
          iPosicaoTabSheet:= objPageControl.pegarPosicaoDoTabSheetOndeSeEncontraOCampo(dbEdit.Tag);
          FreeAndNil(objPageControl);
          cCompEdit:= dbEdit.Name; {Aqui é preciso pegar o name do dbEdit porque o comando ActivePageIndex coloca o primeiro componente como setFocus}
          PageControl.ActivePageIndex:=iPosicaoTabSheet;
          dbEdit:= TDBEdit(FindComponent(cCompEdit));
        end;

        Application.MessageBox(Pchar('Campo ' +
          objDataControlsStandard.pegarCaptionDoCampo(dbEdit.Tag) + ' deve ser preenchido.'),
          'Informação!', MB_OK+MB_ICONINFORMATION + MB_TOPMOST);
        dbEdit.SetFocus;
        result:= true;
        exit;
      end
      else
        result:=false;
    end
    else if cComp = 'TDBAdvMaskEdit' then
    begin
      maskDBEditComp:= TDBAdvMaskEdit(FindComponent(
        objAuxiliar.vetorCamposPreenchimentoObrigatorio[i]));

      if verificarSeMaskEditEstaVazio(maskDBEditComp.editMask,
        maskDBEditComp.Text) then
      begin
        if pageControl <> nil then
        begin
          objPageControl := TComponentePageControl.create;
          iPosicaoTabSheet:= objPageControl.pegarPosicaoDoTabSheetOndeSeEncontraOCampo(maskDBEditComp.Tag);
          FreeAndNil(objPageControl);
          cCompEdit:= maskDBEditComp.Name; {Aqui é preciso pegar o name do dbEdit porque o comando ActivePageIndex coloca o primeiro componente como setFocus}
          PageControl.ActivePageIndex:=iPosicaoTabSheet;
          maskDBEditComp:= TDBAdvMaskEdit(FindComponent(cCompEdit));
        end;
        Application.MessageBox(Pchar('Campo ' +
          objDataControlsStandard.pegarCaptionDoCampo(maskDBEditComp.Tag) + ' deve ser preenchido.'),
          'Informação!', MB_OK+MB_ICONINFORMATION + MB_TOPMOST);
        maskDBEditComp.SetFocus;
        exit;
      end;
    end
    else if cComp = 'TJvDBDateEdit' then
    begin
      dateDBEdit:= TJvDBDateEdit(FindComponent(
        objAuxiliar.vetorCamposPreenchimentoObrigatorio[i]));

      if dateDBEdit.Date = 0 then
      begin
        if pageControl <> nil then
        begin
          objPageControl := TComponentePageControl.create;
          iPosicaoTabSheet:= objPageControl.pegarPosicaoDoTabSheetOndeSeEncontraOCampo(dateDBEdit.Tag);
          FreeAndNil(objPageControl);
          cCompEdit:= dateDBEdit.Name; {Aqui é preciso pegar o name do dbEdit porque o comando ActivePageIndex coloca o primeiro componente como setFocus}
          PageControl.ActivePageIndex:=iPosicaoTabSheet;
          dateDBEdit:= TJvDBDateEdit(FindComponent(cCompEdit));
        end;
        Application.MessageBox(Pchar('Campo ' +
          objDataControlsStandard.pegarCaptionDoCampo(dateDBEdit.Tag) + ' deve ser preenchido.'),
          'Informação!', MB_OK+MB_ICONINFORMATION + MB_TOPMOST);
        dateDBEdit.SetFocus;
        exit;
      end;
    end
    else if cComp = 'TJvDBCalcEdit' then
    begin
      calcDBEdit:= TJvDBCalcEdit(FindComponent(
        objAuxiliar.vetorCamposPreenchimentoObrigatorio[i]));

      if calcDBEdit.Value = 0 then
      begin
        if pageControl <> nil then
        begin
          objPageControl := TComponentePageControl.create;
          iPosicaoTabSheet:= objPageControl.pegarPosicaoDoTabSheetOndeSeEncontraOCampo(calcDBEdit.Tag);
          FreeAndNil(objPageControl);
          cCompEdit:= calcDBEdit.Name; {Aqui é preciso pegar o name do dbEdit porque o comando ActivePageIndex coloca o primeiro componente como setFocus}
          PageControl.ActivePageIndex:=iPosicaoTabSheet;
          calcDBEdit:= TJvDBCalcEdit(FindComponent(cCompEdit));
        end;
        Application.MessageBox(Pchar('Campo ' +
          objDataControlsStandard.pegarCaptionDoCampo(calcDBEdit.Tag) + ' deve ser preenchido.'),
          'Informação!', MB_OK+MB_ICONINFORMATION + MB_TOPMOST);
        calcDBEdit.SetFocus;
        exit;
      end;
    end;

    i:=i+1;
  end;
  FreeAndNil(objDataControlsStandard);
end;

initialization
  RegisterClass(TfrmBaseCadastro);

end.

