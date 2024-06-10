unit untBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uAuxiliar, uComponenteDataControlsStandard,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, uComponenteDBGrid, Vcl.Mask, System.MaskUtils,
  Vcl.DBCtrls, Data.DB, Datasnap.Provider, Datasnap.DBClient, uComponenteGroupBox,
  AdvEdit, DBAdvEd, JvExMask, JvToolEdit, JvDBControls, uTabelaCampos,
  uPesquisa, StrUtils;

type
  TfrmBase = class(TForm)
    popExcluirDBEdit: TPopupMenu;
    popItemExcluirDBEdit1: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure popItemExcluirDBEdit1Click(Sender: TObject);
  private
    { Private declarations }
    objAuxiliar : TAuxiliar;
    gLInha, col: integer;
  protected
    codigoTabela: string;
    gPt : Tpoint;
    compComboBox: TDBLookupComboBox;
    groupBox: TGroupBox;
    labelComp : TLabel;
    dbEdit : TDBEdit;
    maskDBEditComp : TDBAdvMaskEdit;
    dateDBEdit : TJvDBDateEdit;
    calcDBEdit : TJvDBCalcEdit;
    compEdit: TEdit;
    compMaskEdit : TMaskEdit;
    gbCapturando, gbAlterandoPosicao,
      gbAlterandoTamanho : boolean;
    cdsCadastro, cdsComboBox : TClientDataSet;
    dspCadastro, dspComboBox : TDataSetProvider;
    dtsCadastro, dtsComboBox : TDataSource;
    matrizTabelaEstrangeira:array[0..30] of array [0..30] of string;
    matrizTabela:array[0..50] of array[0..50] of string;

    procedure criarDBEdit(Sender: TObject);
    procedure criarComboBox(Sender: TObject);
    procedure mostrarEdit(pCodigoDBEdit, pLabel, pNameCampo, pCodigoGroupBoxMenu,
      pFormatoCampo, pTipoCampo, pDescricaoCampo: string;
      pTop, pLeft, pHeight, pWidth: integer); virtual;
    procedure mostrarDBEdit(pCodigoDBEdit, pLabel, pNameCampo, pCodigoGroupBoxMenu,
      pFormatoCampo, pTipoCampo, pDescricaoCampo: string;
      pTop, pLeft, pHeight, pWidth: integer); virtual;
    procedure mostrarComboBox(pCodigoComboBoxNaTela,
      codigoGroupBox, pNameCampo, pNameChavePrimaria, pCodigoTabela, pCodigoTabelaPrincipal,
      pCaptionCampo: string; pTop, pLeft, pWidth: integer); virtual;
    procedure inserirColunaNoGrid(pFieldName, pTitleName, pDescricaoCampo: string;
      pTamanho: integer); virtual;
    procedure pressionarComboBox(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure movimentarComboBox(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure finalizarComboBox(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure limparComboBox(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure funcaoRecursiva(codTabela, codTabelaEstrangeira: string);
    function RetirarCaracteresEspeciais(cTexto : string): string;
    function verificarSeMaskEditEstaVazio(const EditMask: TEditMask;
      const Text:String):Boolean;
   // function funcaoRecursivaAcharChaveEstrangeira(pCodigoTabela, pCodigoChaveEstrangeira, pCodigoChaveEstrangeiraASerEncontrado: string): string;
    procedure enterCampo(Sender: TObject);
    procedure exitCampo(Sender: TObject); virtual;
    procedure enterFoco(Sender: TObject; var Key: Char);

  public
    { Public declarations }

  end;

var
  frmBase: TfrmBase;

implementation

uses untInserirCampo, untBaseCadastro;

{$R *.dfm}

function TfrmBase.verificarSeMaskEditEstaVazio(
  const EditMask: TEditMask; const Text:String):Boolean;
var
  MaskOffset: Integer;
  CType: TMaskCharType;
  FMaskBlank:Char;
  Mask:String;
  default:boolean;
begin
  default:=true;
  FMaskBlank:= MaskGetMaskBlank(EditMask);
  for MaskOffset := 1 to Length(Editmask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    case CType of
      mcLiteral, mcIntlLiteral: Mask:=Mask+EditMask[MaskOffset];
      mcMaskOpt,mcMask:Mask:=Mask+FMaskBlank;
      mcFieldSeparator:
    begin
      if EditMask[MaskOffset+1] = '0' then
        Mask:='';
      Break;
      default:=false;
    end;
    end;
  end;
  if default then
    Mask:= FormatMaskText(EditMask,'');
  result:=Text = Mask;
end;

procedure TfrmBase.criarComboBox(Sender: TObject);
var
  codigoGroupBox, codigoComboBoxNaTela: string;
  objDataControlStandard: TComponenteDataControlsStandard;
begin
  if screen.cursor <> crDrag then
    exit;

  objDataControlStandard:= TComponenteDataControlsStandard.create;
  objAuxiliar := TAuxiliar.GetInstancia;

  if sender is TGroupBox then
  begin
    codigoGroupBox:= inttostr((Sender as TGroupBox).Tag);
    gPt := (sender as TGroupBox).ClientOrigin;

    if objAuxiliar.tipoTela = 'C' then
    begin
      objDataControlStandard.cadastrarComboBoxNaTela(
        objAuxiliar.campoSelecionado,
        codigoGroupBox, mouse.CursorPos.y-gPt.y, mouse.CursorPos.x-gPt.x, 21, 135);

      codigoComboBoxNaTela := objDataControlStandard.pegarCodigoDoComboboxNaTela(
        objAuxiliar.campoSelecionado, codigoGroupBox);

      objDataControlStandard.pesquisarComboBoxTela('',codigoComboBoxNaTela);
    end
    else if objAuxiliar.tipoTela = 'P' then
    begin
      objDataControlStandard.cadastrarComboBoxNaTelaPesquisa(
        objAuxiliar.campoSelecionado,
        inttostr(self.Tag), mouse.CursorPos.y-gPt.y, mouse.CursorPos.x-gPt.x, 21, 135);

      codigoComboBoxNaTela := objDataControlStandard.pegarCodigoDoComboboxNaTelaPesquisa(
        objAuxiliar.campoSelecionado, inttostr(self.Tag));

      objDataControlStandard.pesquisarComboBoxTelaPesquisa('',codigoComboBoxNaTela);
    end;

    {Foram passados alguns parâmetros vazios que consistem na ligação do
    combobox com os campos e tabelas, na criação do combobox isso nao é necessário}

    mostrarComboBox(codigoComboBoxNaTela, codigoGroupBox,
      objDataControlStandard.objQuery.FDQuery.FieldByName('DDBDC_CAMPO_FISICO').AsString,
      objDataControlStandard.objQuery.FDQuery.FieldByName('DDBDCP_CAMPO_FISICO').AsString,
      objDataControlStandard.objQuery.FDQuery.FieldByName('DDBDT_CODIGO').AsString,
      codigoTabela,
      objDataControlStandard.objQuery.FDQuery.FieldByName('DDCB_NOME_COMBOBOX').AsString,
      mouse.CursorPos.y-gPt.y,
      mouse.CursorPos.x-gPt.x, 200);

    FreeAndNil(objDataControlStandard);

    screen.cursor := crDefault;

    frmInserirCampo.tmMostrarDados.Enabled := true;
    frmInserirCampo.WindowState := wsNormal;
    frmInserirCampo.BringToFront;

  end;

end;

procedure TfrmBase.criarDBEdit(Sender: TObject);
var
  objDataControlStandard: TComponenteDataControlsStandard;
  objCampoGrid: TComponenteDBGrid;
  objTabelaCampos: TTabelaCampos;
  codigoCampo, codigoDBEdit, campoCaption,
    codigoGroupBox, formatoCampo, tipoCampo,
    descricaoTipoCampo, nameCampo, codigoTabelaEstrangeira,
    codigoDaTabelaDeCampoSelecionado: string;
    tamanhoCampo: integer;
  chaveEstrangeira: boolean;
begin
  if screen.cursor <> crDrag then
    exit;

  objDataControlStandard:= TComponenteDataControlsStandard.create;
  objAuxiliar := TAuxiliar.GetInstancia;

  {Verifica se campo pertence a tabela principal}
  objTabelaCampos:= TTabelaCampos.create;

  codigoDaTabelaDeCampoSelecionado:=
    objTabelaCampos.pegarCodigoDaTabela(
    objAuxiliar.nomeTabela);

  FreeAndNil(objTabelaCampos);
  if (codigoTabela <> codigoDaTabelaDeCampoSelecionado)
    and (objAuxiliar.nomeTabela <> '') then
  begin
    Application.MessageBox(Pchar('Campo não pertence à tabela principal'),
       'Erro!', MB_OK+MB_ICONWARNING + MB_TOPMOST);
    objAuxiliar.nomeTabela := '';
    Exit;
  end;
  {FIM}

  {Primeiro: recebe o codigo DDBDC_CODIGO ou DDBDCP_CODIGO e cadastra ele no DD_TELA_CAMPO}
  if objAuxiliar.tipoCampo = 'C' then
  begin
    {Campo da tabela principal}
    if objAuxiliar.nomeTabela = '' then
    begin
      chaveEstrangeira:= false;
      codigoCampo:= objDataControlStandard.
        pegarCodigoDoCampo(objAuxiliar.campoSelecionado, objAuxiliar.codigoTabela);
    end
    {FIM}
    else
    begin
    {Campos da tabela estrangeira}
      objTabelaCampos:= TTabelaCampos.create;
      codigoTabelaEstrangeira:=
        objTabelaCampos.pegarCodigoDaTabela(
        objAuxiliar.nomeTabela);
      FreeAndNil(objTabelaCampos);
      objAuxiliar.nomeTabela :='';
      chaveEstrangeira:= true;

      codigoCampo:= objDataControlStandard.
        pegarCodigoDoCampo(objAuxiliar.campoSelecionado, codigoTabelaEstrangeira);
    {FIM}
    end;
    formatoCampo:= objDataControlStandard.pegarFormatoDoCampo(codigoCampo);
    tipoCampo:= objDataControlStandard.pegarTipoDoCampo(codigoCampo);
    descricaoTipoCampo:= objDataControlStandard.pegarDescricaoTipoCampo(codigoCampo);
    nameCampo := objDataControlStandard.pegarNameCampo(codigoCampo);
    tamanhoCampo := objDataControlStandard.pegarTamanhoCampo(codigoCampo);
  end
  else if objAuxiliar.tipoCampo = 'CP' then
  begin
    codigoCampo:= objDataControlStandard.pegarCodigoDaChavePrimaria
      (objAuxiliar.campoSelecionado);
    nameCampo := objDataControlStandard.pegarNameChavePrimaria(codigoCampo);
    tamanhoCampo := 70;
  end;

  if sender is TGroupBox then
  begin
    codigoGroupBox:= inttostr((Sender as TGroupBox).Tag);
    gPt := (sender as TGroupBox).ClientOrigin;
    objDataControlStandard.cadastrarDBEdit(codigoCampo, codigoGroupBox,
     objAuxiliar.tipoCampo, objAuxiliar.tipoTela, inttostr(self.Tag),
     mouse.CursorPos.y-gPt.y, mouse.CursorPos.x-gPt.x, 21, 135);
    {Segundo: pega o codigo do DBEdit já cadastrado na tabela DD_TELA_CAMPO}
    if objAuxiliar.tipoCampo = 'C' then
      codigoDBEdit := objDataControlStandard.pegarCodigoDoDBEdit(codigoCampo,
        codigoGroupBox, objAuxiliar.tipoTela, inttostr(self.Tag))
    else if objAuxiliar.tipoCampo = 'CP' then
      codigoDBEdit := objDataControlStandard.pegarCodigoDoDBEditChavePrimaria(
        codigoCampo, codigoGroupBox, objAuxiliar.tipoTela, inttostr(self.Tag));

    if objAuxiliar.nomeGroupBox = 'gpbDados' then
    begin
      mostrarEdit(codigoDBEdit, objAuxiliar.campoSelecionado, nameCampo,
        codigoGroupBox, formatoCampo, tipoCampo, descricaoTipoCampo, mouse.CursorPos.y-gPt.y,
        mouse.CursorPos.x-gPt.x, 21, tamanhoCampo +200);
      objAuxiliar.nomeGroupBox := '';
    end
    else
    begin
      mostrarDBEdit(codigoDBEdit, objAuxiliar.campoSelecionado, nameCampo,
        codigoGroupBox, formatoCampo, tipoCampo, descricaoTipoCampo, mouse.CursorPos.y-gPt.y,
        mouse.CursorPos.x-gPt.x, 21, tamanhoCampo +200);
    end;

  end
  else if sender is TDBGrid then
  begin
    objCampoGrid:= TComponenteDBGrid.create;
    objCampoGrid.cadastrarCampoNoDBGrid(codigoCampo, codigoTabelaEstrangeira,
      objAuxiliar.codigoMenu, objAuxiliar.tipoCampo, 100, chaveEstrangeira);

    if objAuxiliar.tipoCampo = 'C' then
      campoCaption := objCampoGrid.pegarCaptionDoCampo(codigoCampo)
    else if objAuxiliar.tipoCampo = 'CP' then
      campoCaption := objCampoGrid.pegarCaptionDaChavePrimaria(codigoCampo);
     
    inserirColunaNoGrid(nameCampo, campoCaption, descricaoTipoCampo, tamanhoCampo);
    FreeAndNil(objCampoGrid);
  end;

  FreeAndNil(objDataControlStandard);

  screen.cursor := crDefault;

  frmInserirCampo.tmMostrarDados.Enabled := true;
  frmInserirCampo.WindowState := wsNormal;
  frmInserirCampo.BringToFront;

end;

procedure TfrmBase.enterCampo(Sender: TObject);
begin
  if TComponent(sender).ClassName = 'TDBEdit' then
  begin
    dbEdit := TDBEdit(FindComponent((sender as TDBEdit).Name));
    dbEdit.Color := $00FFEAEA;
  end
  else if TComponent(sender).ClassName = 'TDBAdvMaskEdit' then
  begin
    maskDBEditComp := TDBAdvMaskEdit(FindComponent((sender as TDBAdvMaskEdit).Name));
    maskDBEditComp.Color := $00FFEAEA;
  end
  else if TComponent(sender).ClassName = 'TJvDBDateEdit' then
  begin
    dateDBEdit := TJvDBDateEdit(FindComponent((sender as TJvDBDateEdit).Name));
    dateDBEdit.Color := $00FFEAEA;
  end
  else if TComponent(sender).ClassName = 'TJvDBCalcEdit' then
  begin
    calcDBEdit := TJvDBCalcEdit(FindComponent((sender as TJvDBCalcEdit).Name));
    calcDBEdit.Color := $00FFEAEA;
  end
  else if TComponent(sender).ClassName = 'TDBLookUpComboBox' then
  begin
    compComboBox := TDBLookUpComboBox(FindComponent((sender as TDBLookUpComboBox).Name));
    compComboBox.Color := $00FFEAEA;
  end
  else if TComponent(sender).ClassName = 'TEdit' then
  begin
    compEdit := TEdit(FindComponent((sender as TEdit).Name));
    compEdit.Color := $00FFEAEA;
  end
  else if TComponent(sender).ClassName = 'TMaskEdit' then
  begin
    compMaskEdit := TMaskEdit(FindComponent((sender as TMaskEdit).Name));
    compMaskEdit.Color := $00FFEAEA;
  end;

end;

procedure TfrmBase.enterFoco(Sender: TObject; var Key: Char);
begin
  If (key = #13) then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmBase.exitCampo(Sender: TObject);
begin
  if TComponent(sender).ClassName = 'TDBEdit' then
  begin
    dbEdit := TDBEdit(FindComponent((sender as TDBEdit).Name));
    if dbEdit.ReadOnly = false then
      dbEdit.Color := clwindow
    else
      dbEdit.Color := $00E0E0E0;
  end
  else if TComponent(sender).ClassName = 'TDBAdvMaskEdit' then
  begin
    maskDBEditComp := TDBAdvMaskEdit(FindComponent((sender as TDBAdvMaskEdit).Name));
    maskDBEditComp.Color := clwindow;
  end
  else if TComponent(sender).ClassName = 'TJvDBDateEdit' then
  begin
    dateDBEdit := TJvDBDateEdit(FindComponent((sender as TJvDBDateEdit).Name));
    dateDBEdit.Color := clwindow;
  end
  else if TComponent(sender).ClassName = 'TJvDBCalcEdit' then
  begin
    calcDBEdit := TJvDBCalcEdit(FindComponent((sender as TJvDBCalcEdit).Name));
    calcDBEdit.Color := clwindow;
  end
  else if TComponent(sender).ClassName = 'TEdit' then
    compEdit.Color := clwindow
  else if TComponent(sender).ClassName = 'TMaskEdit' then
    compMaskEdit.Color := clwindow;
end;

procedure TfrmBase.finalizarComboBox(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
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
      compComboBox.Left:= compComboBox.Left-(gPt.x-x);
      compComboBox.Top:= compComboBox.Top - (gPt.y-y);
    end;

    objDataControlsStandard:= TComponenteDataControlsStandard.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;

    groupBox := TGroupBox(compComboBox.Parent);

    if groupbox.Name <> 'gpbDados' then
      objDataControlsStandard.alterarTamanhoPosicao(inttostr(compComboBox.Tag),
        compComboBox.Left, compComboBox.Top, compComboBox.Width, compComboBox.Height)
    else if groupbox.Name = 'gpbDados' then
      objDataControlsStandard.alterarTamanhoPosicaoTelaPesquisa(inttostr(compComboBox.Tag),
        compComboBox.Left, compComboBox.Top, compComboBox.Width, compComboBox.Height);

    FreeAndNil(objDataControlsStandard);

  end;

end;

procedure TfrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmBase.FormCreate(Sender: TObject);
begin


  if (screen.Width = 1280) and (screen.Height = 800) then
  begin
    Height := 650;
    Width := 1090;
    top := 10;
    left := 10;
  end
  else if (screen.Width = 1280) and (screen.Height = 768) then
  begin
    Height := 632;
    Width := 1090;
    top := 10;
    left := 10;
  end
  else if (screen.Width = 1280) and (screen.Height = 720) then
  begin
    Height := 570;
    Width := 1090;
    top := 10;
    left := 10;
  end
  else if (screen.Width = 1280) and (screen.Height = 600) then
  begin
    Height := 450;
    Width := 1090;
    top := 10;
    left := 10;
  end
  else if (screen.Width = 1024) and (screen.Height = 768) then
  begin
    Height := 632;
    Width := 850;
    top := 10;
    left := 10;
  end
  else if (screen.Width = 1536) and (screen.Height = 864) then
  begin
    Height := 650;
    Width := 1090;
    top := 10;
    left := 10;
  end;

end;

procedure TfrmBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_ESCAPE) then
  begin
    close;
  end;
end;

procedure TfrmBase.FormShow(Sender: TObject);
begin
  {Serve p/ deixar a tela numa posição organizada no menu}
  Left := (Self.Width - Width) div 2;
  Top := (Self.Height - Height) div 2;
  {FIM}
end;

procedure TfrmBase.funcaoRecursiva(codTabela, codTabelaEstrangeira: string);
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

{function TfrmBase.funcaoRecursivaAcharChaveEstrangeira(pCodigoTabela,
  pCodigoChaveEstrangeira, pCodigoChaveEstrangeiraASerEncontrado: string): string;
begin

end; }

procedure TfrmBase.inserirColunaNoGrid(pFieldName, pTitleName, pDescricaoCampo: string;
  pTamanho: integer);
begin

end;

procedure TfrmBase.limparComboBox(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF KEY =VK_back then
  begin
    compComboBox.KeyValue := -1;

    try
      cdsCadastro.Fields.FindField(compComboBox.KeyField).Clear;
    except
      {Este try serve p/ verificar se cdsCadastro está em estado de
      edição ou inserção, serve apenas para cadastro. Na tela de pesquisa
      da erro pois não está nem em inserção e nem em edição }
    end;
  end;

end;

procedure TfrmBase.mostrarComboBox(pCodigoComboBoxNaTela,
  codigoGroupBox, pNameCampo, pNameChavePrimaria, pCodigoTabela, pCodigoTabelaPrincipal,
  pCaptionCampo: string; pTop, pLeft, pWidth: integer);
var
  codigoChaveEstrangeiraASerEncontrado, nomeFisicoTabela: string;

  objGroupBox: TComponenteGroupBox;
  objDataControlsStandard: TComponenteDataControlsStandard;
  objPesquisaRegistros: TPesquisa;
  objTabelaCampos: TTabelaCampos;

  i, i_join, i_aux: integer;
  tipoDeJoin, joinAux, nomeTabela, sqlComChaveEstrangeira: string;
  //vetorGuardaTabelaJaInseridaNoJoin: array[0..100] of string;
  vetorGuardaTabelaJaInseridaNoJoin: array of string;
begin
  compComboBox := TDBLookupComboBox.Create(self);

  objGroupBox:= TComponenteGroupBox.create;
  objDataControlsStandard:= TComponenteDataControlsStandard.create;

  {Constrói CDS, dsp e dts novamente no comboBox para poder funcionar nas telas
  de pesquisa, onde não são usados DBEdits}  {ESTÁ DEMORANDO MUITO, FAZER O
  DTSCADASTRO QUANDO INICIA A TELA DE PESQUISA QUANDO VERIFICADO SE EXISTE COMBOBOX
  NA TELA DE PESQUISA, CRIAR DTSCADASTRO UMA UNICA VEZ, DO JEITO QUE ESTÁ
  CRIA UM DTSCADASTRO POR COMBOBOX, AI FICA LENTO MESMO  }

  objDataControlsStandard.pesquisarTabela(pCodigoTabelaPrincipal, 'N');
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

  if (codigoGroupBox <> '0') and (codigoGroupBox <> '') then
    groupBox:= TGroupBox(FindComponent(
      objGroupBox.pegarNameGroupBox(codigoGroupBox)))
  else
    groupBox:= TGroupBox(FindComponent('gpbDados'));

  compComboBox.Parent := groupBox;
  compComboBox.Left := pLeft;
  compComboBox.Top := pTop;
  compComboBox.Width := pWidth;
  compComboBox.Tag := strtoint(pCodigoComboBoxNaTela);
  compComboBox.Hint:= 'edt' + pNameChavePrimaria;
  compComboBox.ShowHint:= true;

  objAuxiliar:= TAuxiliar.GetInstancia;
  if objAuxiliar.logadoComoADMSistema = true then
  begin
      compComboBox.PopupMenu := popExcluirDBEdit;
  end;

  if groupBox.Name = 'gpbDados' then
    compComboBox.Name := 'dbEdt' + pNameChavePrimaria + '_P'
  else
    compComboBox.Name := 'dbEdt' + pNameChavePrimaria + '_C';

  //compComboBox.Name := 'dbEdt' + pNameChavePrimaria;
  compComboBox.TabOrder := compComboBox.TabOrder + 1;
  compComboBox.Height := 26;
  compComboBox.DataSource := dtsCadastro;

  {Aqui é caso a chave primaria nao estiver na tabela principal, exemplo:
  vendedor é chave estrangeira de cliente, funcionario é chave estrangeira de vendedor
  e não de cliente, se vier id_funcionario vai dar pau}
  sqlComChaveEstrangeira:='';
  i:=0;
  while matrizTabelaEstrangeira[0,i] <> '' do
  begin
    matrizTabelaEstrangeira[0,i]:='';
    i:=i+1;
  end;

  try
    compComboBox.DataField := pNameChavePrimaria;
    compComboBox.KeyField  := pNameChavePrimaria;
  except

    objTabelaCampos:= TTabelaCampos.create;
    codigoChaveEstrangeiraASerEncontrado:=
      objTabelaCampos.pegarCodigoDaTabelaComNomeDaChavePrimaria(pNameChavePrimaria);

     col:=0;
     funcaoRecursiva(pCodigoTabelaPrincipal, codigoChaveEstrangeiraASerEncontrado);
     i:=0;
     i_join := 0;
     col:=0;
     while matrizTabelaEstrangeira[i,col] <> '' do
     begin
       col:=col+1;
     end;
     col:=col-1;

     objPesquisaRegistros:= TPesquisa.create;
     objPesquisaRegistros.criarLigacoesComJoins(pCodigoTabelaPrincipal);
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

     FreeAndNil(objPesquisaRegistros);

     nomeTabela := objTabelaCampos.capturarNomeFisicoDaTabela(matrizTabelaEstrangeira[i,col]);
     nomeTabela := nomeTabela + ' ' + nomeTabela;

     col:=col -1;
      while col > -1 do
      begin
        joinAux:='';
        i_aux := AnsiIndexText(
        matrizTabelaEstrangeira[i, col],
        vetorGuardaTabelaJaInseridaNoJoin);

        if i_aux < 0 then
        begin
          setLength(vetorGuardaTabelaJaInseridaNoJoin, i_join +1);

          vetorGuardaTabelaJaInseridaNoJoin[i_join]:=
            matrizTabelaEstrangeira[i, col];
          i_join:=i_join +1;

          nomeTabela := nomeTabela + ' ' + tipoDeJoin + ' JOIN ';

          nomeTabela := nomeTabela + ' ' +
            objTabelaCampos.capturarNomeFisicoDaTabela(matrizTabelaEstrangeira[i,col])
            + ' ' +
            objTabelaCampos.capturarNomeFisicoDaTabela(matrizTabelaEstrangeira[i,col])
            + ' ON ' +
            objTabelaCampos.capturarNomeFisicoDaTabela(matrizTabelaEstrangeira[i,col])
            + '.' +
            objTabelaCampos.capturarCampoChavePrimaria(matrizTabelaEstrangeira[i,col])
            + ' = ' +
            objTabelaCampos.capturarNomeFisicoDaTabela(matrizTabelaEstrangeira[i,col + 1])
            + '.' +
            objTabelaCampos.capturarCampoChavePrimaria(matrizTabelaEstrangeira[i,col]);

          sqlComChaveEstrangeira:= nomeTabela;
        end;
        col:=col-1;
      end;

    col:=0;
    while matrizTabelaEstrangeira[0,col] <> '' do
    begin
      col:=col+1;
    end;

    compComboBox.DataField :=
      objTabelaCampos.capturarCampoChavePrimaria(matrizTabelaEstrangeira[0,col-1]);
    compComboBox.KeyField :=
      objTabelaCampos.capturarCampoChavePrimaria(matrizTabelaEstrangeira[0,col-1]);

    FreeAndNil(objTabelaCampos);
  end;

  compComboBox.DataSource := dtsCadastro;
  compComboBox.ListField := pNameCampo;

  {Criar cds exclusivo para o ListSource}
  if pCodigoTabela <> '' then
  begin
    objTabelaCampos:= TTabelaCampos.create;
    nomeFisicoTabela:= objTabelaCampos.capturarNomeFisicoDaTabela(pCodigoTabela);
    FreeAndNil(objTabelaCampos);

    if sqlComChaveEstrangeira = '' then
      objDataControlsStandard.pesquisarTabela(pCodigoTabela, 'S')
    else
      objDataControlsStandard.sqlComboBox(sqlComChaveEstrangeira);

    dspComboBox := TDataSetProvider(FindComponent('dsp' + self.Name + nomeFisicoTabela));
    if dspComboBox = nil then
    begin
      dspComboBox := TDataSetProvider.Create(self);
      dspComboBox.Name:= 'dsp' + self.Name + nomeFisicoTabela;
      dspComboBox.DataSet := objDataControlsStandard.objQuery.FDQuery;
    end;

    cdsComboBox := TClientDataSet(FindComponent('cds' + self.Name + nomeFisicoTabela));
    if cdsComboBox = nil then
    begin
      cdsComboBox := TClientDataSet.Create(self);
      cdsComboBox.Name := 'cds' + self.Name + nomeFisicoTabela;
      cdsComboBox.ProviderName := dspComboBox.Name;
    end;

    dtsComboBox := TDataSource(FindComponent('dts' + self.Name + nomeFisicoTabela));
    if dtsComboBox = nil then
    begin
      dtsComboBox := TDataSource.Create(self);
      dtsComboBox.Name := 'dts' + self.Name + nomeFisicoTabela;
      dtsComboBox.DataSet := cdsComboBox;
    end;

    cdsComboBox.Close;
    cdsComboBox.FetchParams;
    cdsComboBox.Open;

    compComboBox.ListSource := dtsComboBox;
  end;
  {FIM}

  FreeAndNil(objDataControlsStandard);
  compComboBox.OnMouseDown := pressionarComboBox;
  compComboBox.OnMouseMove := movimentarComboBox;
  compComboBox.OnMouseUp   := finalizarComboBox;
  compComboBox.OnKeyDown   := limparComboBox;
  compComboBox.OnEnter     := enterCampo;
  compComboBox.OnExit      := exitCampo;
  compComboBox.OnKeyPress  := EnterFoco;

  labelComp := TLabel.Create(self);
  labelComp.Left := pLeft;
  labelComp.Top  := pTop - 17;

  if groupBox.Name = 'gpbDados' then
    labelComp.name := 'dblbl' + 'dbEdt' + pNameChavePrimaria + '_P'
  else
    labelComp.name := 'dblbl' + 'dbEdt' + pNameChavePrimaria + '_C';

  labelComp.Caption := pCaptionCampo;
  labelComp.parent := groupBox;
end;

procedure TfrmBase.mostrarDBEdit(pCodigoDBEdit, pLabel, pNameCampo,
  pCodigoGroupBoxMenu, pFormatoCampo, pTipoCampo, pDescricaoCampo: string; pTop,
  pLeft, pHeight, pWidth: integer);
begin

end;

procedure TfrmBase.mostrarEdit(pCodigoDBEdit, pLabel, pNameCampo,
  pCodigoGroupBoxMenu, pFormatoCampo, pTipoCampo, pDescricaoCampo: string; pTop,
  pLeft, pHeight, pWidth: integer);
begin

end;

procedure TfrmBase.movimentarComboBox(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    compComboBox.Left:= compComboBox.Left-(gPt.x-x);
    compComboBox.Top:= compComboBox.Top - (gPt.y-y);
    labelComp.Left:= labelComp.Left-(gPt.x-x);
    labelComp.Top:= labelComp.Top - (gPt.y-y);

  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
     compComboBox.Width := x +1;
  end;
end;

procedure TfrmBase.popItemExcluirDBEdit1Click(Sender: TObject);
var
  objDataControlsStandard: TComponenteDataControlsStandard;
  i: integer;
begin
  objDataControlsStandard:= TComponenteDataControlsStandard.create;

  i := popExcluirDBEdit.PopupComponent.ComponentIndex;

  if Components[i] is TDBEdit then
  begin
    objDataControlsStandard.excluirDBEdit(inttostr(dbEdit.Tag));
    labelComp := TLabel(FindComponent('dblbl' + dbEdit.Name));
    FreeAndNil(dbEdit);
  end
  else if Components[i] is TDBAdvMaskEdit then
  begin
    objDataControlsStandard.excluirDBEdit(inttostr(maskDBEditComp.Tag));
    labelComp := TLabel(FindComponent('dblbl' + maskDBEditComp.Name));
    FreeAndNil(maskDBEditComp);
  end
  else if Components[i] is TJvDBDateEdit then
  begin
    objDataControlsStandard.excluirDBEdit(inttostr(dateDBEdit.Tag));
    labelComp := TLabel(FindComponent('dblbl' + dateDBEdit.Name));
    FreeAndNil(dateDBEdit);
  end
  else if Components[i] is TJvDBCalcEdit then
  begin
    objDataControlsStandard.excluirDBEdit(inttostr(calcDBEdit.Tag));
    labelComp := TLabel(FindComponent('dblbl' + calcDBEdit.Name));
    FreeAndNil(calcDBEdit);
  end
  else if Components[i] is TDBLookUpComboBox then
  begin
    objDataControlsStandard.excluirDBEdit(inttostr(compComboBox.Tag));
    labelComp := TLabel(FindComponent('dblbl' + compComboBox.Name));
    FreeAndNil(compComboBox);
  end;

  FreeAndNil(objDataControlsStandard);
  FreeAndNil(labelComp);

end;

procedure TfrmBase.pressionarComboBox(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  compComboBox := Sender as TDBLookupComboBox;
  labelComp := TLabel(FindComponent('dblbl' + compComboBox.Name));
  if ssCtrl in Shift then
  begin
    SetCapture(compComboBox.Handle);
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

function TfrmBase.RetirarCaracteresEspeciais(cTexto: string): string;
const
  {Lista de caracteres especiais}
  cCarEsp: array[1..38] of String = ('á', 'à', 'ã', 'â', 'ä','Á', 'À', 'Ã', 'Â', 'Ä',
                                     'é', 'è','É', 'È','í', 'ì','Í', 'Ì',
                                     'ó', 'ò', 'ö','õ', 'ô','Ó', 'Ò', 'Ö', 'Õ', 'Ô',
                                     'ú', 'ù', 'ü','Ú','Ù', 'Ü','ç','Ç','ñ','Ñ');
  {Lista de caracteres para troca}
  cCarTro: array[1..38] of String = ('a', 'a', 'a', 'a', 'a','A', 'A', 'A', 'A', 'A',
                                     'e', 'e','E', 'E','i', 'i','I', 'I',
                                     'o', 'o', 'o','o', 'o','O', 'O', 'O', 'O', 'O',
                                     'u', 'u', 'u','u','u', 'u','c','C','n', 'N');
  {Lista de Caracteres Extras}
  cCarExt: array[1..51] of string = ('<','>','!','@','#','$','%','¨','&','*',
                                     '(',')','_','+','=','{','}','[',']','?',
                                     ';',':',',','|','*','"','~','^','´','`',
                                     '¨','æ','Æ','ø','£','Ø','ƒ','ª','º','¿',
                                     '®','½','¼','ß','µ','þ','ý','Ý','.','/','\');
var
  i : Integer;
begin
   for i:=1 to 38 do
     cTexto := StringReplace(cTexto, cCarEsp[i], cCarTro[i], [rfreplaceall]);
   for i:=1 to 51 do
     cTexto := StringReplace(cTexto, cCarExt[i], '', [rfreplaceall]);
   {Retira os espaços em branco}
   cTexto := StringReplace(cTexto, ' ', EmptyStr, [rfReplaceAll]);
   Result := cTexto;

end;

end.
