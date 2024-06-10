unit untPesquisaConvencional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untBasePesquisa, Vcl.ImgList,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, Vcl.ExtCtrls, Vcl.Menus,
  Vcl.Grids, Vcl.DBGrids, JvExControls, JvButton, JvNavigationPane, Vcl.StdCtrls,
  uAuxiliar, uPesquisa, Vcl.Mask, uComponenteStandard,
  uComponenteDataControlsStandard, uComponenteDBGrid, uTabelaCampos,
  uInserirCampos, JvToolEdit, Vcl.DBCtrls;

type
  TfrmPesquisaConvencional = class(TfrmBasePesquisa)
    gpbDados: TGroupBox;
    grdGrid: TDBGrid;
    popExcluirCampo: TPopupMenu;
    popItemExcluir1: TMenuItem;
    popOpcoesTelaPesquisa: TPopupMenu;
    popItemInserircampo1: TMenuItem;
    popItemOrdenarcampo1: TMenuItem;
    popOpcoesDBGrid: TPopupMenu;
    popItemInserircampo2: TMenuItem;
    popItemExcluircolunaselecionada1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure tmMostrarComponentesPesquisaTimer(Sender: TObject);
    procedure grdGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure grdGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gpbDadosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gpbDadosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure gpbDadosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdGridDblClick(Sender: TObject);
    procedure grdGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdGridKeyPress(Sender: TObject; var Key: Char);
    procedure grdGridTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure popItemExcluir1Click(Sender: TObject);
    procedure popItemOrdenarcampo1Click(Sender: TObject);
    procedure popItemExcluircolunaselecionada1Click(Sender: TObject);
    procedure popItemInserircampo1Click(Sender: TObject);
    procedure popItemInserircampo2Click(Sender: TObject);
    procedure gpbDadosDblClick(Sender: TObject);
  private
    { Private declarations }
    objAuxiliar : TAuxiliar;
    colunaSelecionada: integer;
    gbCapturando, gbAlterandoPosicao,
      gbAlterandoTamanho : boolean;
    gPt : Tpoint;
    groupBoxData: TGroupBox;
    compData: TJvDateEdit;
    giQtdeLinha : integer;
  protected
    giQtdeColunasGrid: integer;
    procedure mostrarComboBox(pCodigoComboBoxNaTela,
      codigoGroupBox, pNameCampo, pNameChavePrimaria, pCodigoTabela, pCodigoTabelaPrincipal, pCaptionCampo: string;
      pTop, pLeft, pWidth: integer); override;
    procedure mostrarEdit(pCodigoDBEdit, pLabel, pNameCampo, pCodigoMenu,
      pFormatoCampo, pTipoCampo, pDescricaoCampo: string;
      pTop, pLeft, pHeight, pWidth: integer);override;
    procedure finalizarEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure finalizarGroupBoxData(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure finalizarMaskEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pressionarEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pressionarGroupBoxData(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pressionarMaskEdit(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure movimentarEdit(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure movimentarGroupBoxData(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure movimentarMaskEdit(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure inserirEditNoSeuRespectivoGroupBox;
    procedure inserirColunaNoGrid(pFieldName, pTitleName, pDescricaoCampo: string;
      pTamanho: integer); override;
    procedure mostrarColunasNoDBGrid;
    procedure ordenarCampos;
    procedure OrdenarCamposMesmaLinha;
    procedure verificarSeHouveAlteracaoNoTamanhoDaColuna;
    procedure verificarSehouveAlteracaoNaPosicaoDaColuna;
    procedure inserirPesquisaEntreDatas;
    procedure inserirFocoNoEdit;
  public
    { Public declarations }
  end;

var
  frmPesquisaConvencional: TfrmPesquisaConvencional;
  gcVetorLinha         : array[1..2, 1..100] of string;
  gcVetorColunasDBGrid : array[1..2, 1..30] of string;
  giQtdeCol: integer; {Está variável está aqui porque ela está na clausula
                      FOR que aceita variável global ou local}

implementation

uses untInserirCampo;

{$R *.dfm}


procedure TfrmPesquisaConvencional.finalizarEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objEdit: TComponenteStandard;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      compEdit.Left:= compEdit.Left-(gPt.x-x);
      compEdit.Top:= compEdit.Top - (gPt.y-y);
    end;

    objEdit:= TComponenteStandard.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objEdit.alterarTamanhoPosicao(inttostr(compEdit.Tag),
      compEdit.Left, compEdit.Top, compEdit.Width, compEdit.Height);
    FreeAndNil(objEdit);
  end;

end;

procedure TfrmPesquisaConvencional.finalizarGroupBoxData(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objInserirCampos: TInserirCampos;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      groupBoxData.Left:= groupBoxData.Left-(gPt.x-x);
      groupBoxData.Top:= groupBoxData.Top - (gPt.y-y);
    end;

    objInserirCampos:= TInserirCampos.create;
    gbAlterandoPosicao := false;
    objInserirCampos.alterarPosicaoGroupBoxData(inttostr(groupBoxData.Tag),
      groupBoxData.Left, groupBoxData.Top);
    FreeAndNil(objInserirCampos);
  end;

end;

procedure TfrmPesquisaConvencional.finalizarMaskEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objEdit: TComponenteStandard;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      compMaskEdit.Left:= compMaskEdit.Left-(gPt.x-x);
      compMaskEdit.Top:= compMaskEdit.Top - (gPt.y-y);
    end;

    objEdit:= TComponenteStandard.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objEdit.alterarTamanhoPosicao(inttostr(compMaskEdit.Tag),
      compMaskEdit.Left, compMaskEdit.Top, compMaskEdit.Width, compMaskEdit.Height);
    FreeAndNil(objEdit);
  end;

end;

procedure TfrmPesquisaConvencional.FormActivate(Sender: TObject);
begin
  inherited;
  tmMostrarComponentes.Enabled := false;
  objAuxiliar := TAuxiliar.GetInstancia;
  if objAuxiliar.logadoComoADMSistema = true then
  begin
    gpbDados.PopupMenu:= popOpcoesTelaPesquisa;
    grdGrid.PopupMenu:= popOpcoesDBGrid;
  end;
  btnPesquisar.Parent:= gpbDados;

end;

procedure TfrmPesquisaConvencional.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  verificarSeHouveAlteracaoNoTamanhoDaColuna;
  verificarSehouveAlteracaoNaPosicaoDaColuna;
  inherited;
end;

procedure TfrmPesquisaConvencional.gpbDadosDblClick(Sender: TObject);
begin
  objAuxiliar:= TAuxiliar.GetInstancia;
  objAuxiliar.tipoTela:= 'P';
  objAuxiliar.nomeGroupBox := 'gpbDados';
  if objAuxiliar.tipoDeComponenteSelecionado = 'edits' then
    criarDBEdit(Sender as TObject)
  else if objAuxiliar.tipoDeComponenteSelecionado = 'comboBox' then
    criarComboBox(Sender as TObject);
end;

procedure TfrmPesquisaConvencional.gpbDadosMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  gpbDados := Sender as TGroupBox;

  if ssCtrl in Shift then
  begin
    SetCapture(gpbDados.Handle);
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

procedure TfrmPesquisaConvencional.gpbDadosMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    gpbDados.Left:= gpbDados.Left-(gPt.x-x);
    gpbDados.Top:= gpbDados.Top - (gPt.y-y);
  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
    gpbDados.Width := x +1;
    gpbDados.Height := y +1;
  end;

end;

procedure TfrmPesquisaConvencional.gpbDadosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  objPesquisa: TPesquisa;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      gpbDados.Left:= gpbDados.Left-(gPt.x-x);
      gpbDados.Top:= gpbDados.Top - (gPt.y-y);
    end;

    objPesquisa:= TPesquisa.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objPesquisa.alterarTamanhoGpbDadosPesquisa(inttostr(self.Tag),
      gpbDados.Height, gpbDados.Width, gpbDados.Top, gpbDados.Left);
    FreeAndNil(objPesquisa);
  end;

end;

procedure TfrmPesquisaConvencional.grdGridDblClick(Sender: TObject);
begin
   criarDBEdit(Sender as TObject);
end;

procedure TfrmPesquisaConvencional.grdGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdGrid.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdGrid.Canvas.Font.Color:= clBlack;

  grdGrid.Canvas.FillRect(Rect);
  grdGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmPesquisaConvencional.grdGridKeyPress(Sender: TObject;
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

    close;
  end;

end;

procedure TfrmPesquisaConvencional.grdGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   grdGrid := Sender as TDBGrid;

  if ssCtrl in Shift then
  begin
    SetCapture(grdGrid.Handle);
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

procedure TfrmPesquisaConvencional.grdGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    grdGrid.Left:= grdGrid.Left-(gPt.x-x);
    grdGrid.Top:= grdGrid.Top - (gPt.y-y);
  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
     grdGrid.Width := x +1;
     grdGrid.Height := y +1;
  end;

end;

procedure TfrmPesquisaConvencional.grdGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   objPesquisa: TPesquisa;
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if (gbCapturando = true) or (gbAlterandoTamanho = true) then
  begin
    ReleaseCapture;
    gbCapturando := false;

    if gbAlterandoPosicao = true then
    begin
      grdGrid.Left:= grdGrid.Left-(gPt.x-x);
      grdGrid.Top:= grdGrid.Top - (gPt.y-y);
    end;

    objPesquisa:= TPesquisa.create;
    gbAlterandoPosicao := false;
    gbAlterandoTamanho := false;
    objPesquisa.alterarTamanhogrdGridPesquisa(inttostr(self.Tag),
      grdGrid.Height, grdGrid.Width, grdGrid.Top, grdGrid.Left);
    FreeAndNil(objPesquisa);
  end;


end;

procedure TfrmPesquisaConvencional.grdGridTitleClick(Column: TColumn);
var
  i, colunas: integer;
begin
  {Ordena registro de acordo com coluna clicada}
  cdsPesquisaDBGrid.IndexFieldNames := column.FieldName;
  {FIM}

  colunaSelecionada := Column.Index;

  {tira o negrito da coluna marcada anteriormente}
  colunas := grdGrid.Columns.Count;
  i:=0;
  While i < colunas Do
  Begin
    grdGrid.Columns.Items[i].Title.Font.Style := [];
    i := i + 1;
  End;
  {FIM}
  Column.Title.Font.Style := [fsBold];

end;

procedure TfrmPesquisaConvencional.inserirColunaNoGrid(pFieldName, pTitleName,
  pDescricaoCampo: string; pTamanho: integer);
var
  i: integer;
begin
  i:= grdGrid.Columns.Count;
  if i = 1 then
    if grdGrid.Columns[0].Title.Caption = '' then
    begin
      grdGrid.Columns.Delete(i-1);
      i:=i-1;
    end;
  grdGrid.Columns.Add;
  grdGrid.Columns[i].FieldName := pFieldName;
  grdGrid.Columns[i].Title.Caption := pTitleName;
  grdGrid.Columns[i].Width := pTamanho + 100;

  {Este bloco é para pegar todos os campos com formato monetario ou qtde
  e colocar displayFormat em cada campo da grid}
  if pDescricaoCampo = 'VALOR MONETÁRIO(10,4)' then
  begin
    vetorValorMonetário4[iContMonetario4]:= pFieldName;
    iContMonetario4:=iContMonetario4+1;
  end
  else if pDescricaoCampo = 'VALOR MONETÁRIO(10,2)' then
  begin
    vetorValorMonetário2[iContMonetario2]:= pFieldName;
    iContMonetario2:=iContMonetario2+1;
  end
  else if pDescricaoCampo = 'QTDE' then
  begin
    vetorQtde[iContQtde]:= pFieldName;
    iContQtde:=iContQtde+1;
  end;
  {FIM}

end;

procedure TfrmPesquisaConvencional.inserirEditNoSeuRespectivoGroupBox;
var
  objStandard : TComponenteStandard;
  objDataControlsStandard : TComponenteDataControlsStandard;
  cdsEdit : TClientDataSet;
  dspEdit : TDataSetProvider;
begin
  objStandard := TComponenteStandard.create;

  dspEdit := TDataSetProvider(FindComponent('dspEdit'));
  if dspEdit = nil then
  begin
    dspEdit := TDataSetProvider.Create(self);
    dspEdit.Name:= 'dspEdit';
    dspEdit.DataSet := objStandard.objQuery.FDQuery;
  end;

  cdsEdit := TClientDataSet(FindComponent('cdsEdit'));
  if cdsEdit = nil then
  begin
    cdsEdit := TClientDataSet.Create(self);
    cdsEdit.Name := 'cdsEdit';
    cdsEdit.ProviderName := dspEdit.Name;
  end;

  {Inserir edits na tela}
  objStandard.pesquisarEdits(inttostr(self.Tag), '');
  cdsEdit.Close;
  cdsEdit.FetchParams;
  cdsEdit.Open;
  cdsEdit.First;

  while not cdsEdit.Eof do
  begin
    mostrarEdit(
      cdsEdit.FieldByName('DDTCP_CODIGO').AsString,
      cdsEdit.FieldByName('CAMPO_APELIDO').AsString,
      cdsEdit.FieldByName('CAMPO_FISICO').AsString,
      cdsEdit.FieldByName('DDM_CODIGO').AsString,
      cdsEdit.FieldByName('FORMATO_FISICO').AsString,
      cdsEdit.FieldByName('DDBDFC_TIPO').AsString,
      cdsEdit.FieldByName('DDBDFC_DESCRICAO_CAMPO').AsString,
      cdsEdit.FieldByName('DDTCP_TOP').AsInteger,
      cdsEdit.FieldByName('DDTCP_LEFT').AsInteger,
      cdsEdit.FieldByName('DDTCP_HEIGHT').AsInteger,
      cdsEdit.FieldByName('DDTCP_WIDTH').AsInteger);
    cdsEdit.Next;
  end;
  {FIM}

  {Inserir comboBox na tela}
  objDataControlsStandard := TComponenteDataControlsStandard.create;
  objDataControlsStandard.pesquisarComboBoxTelaPesquisa(inttostr(self.Tag), '');

  dspEdit.DataSet := objDataControlsStandard.objQuery.FDQuery;

  cdsEdit.Close;
  cdsEdit.FetchParams;
  cdsEdit.Open;
  cdsEdit.First;

  while not cdsEdit.Eof do
  begin
     mostrarComboBox(cdsEdit.FieldByName('DDTCP_CODIGO').AsString,
      '',
      cdsEdit.FieldByName('DDBDC_CAMPO_FISICO').AsString,
      cdsEdit.FieldByName('DDBDCP_CAMPO_FISICO').AsString,
      cdsEdit.FieldByName('DDBDT_CODIGO').AsString,
      codigoTabela,
      cdsEdit.FieldByName('DDCB_NOME_COMBOBOX').AsString,
      cdsEdit.FieldByName('DDTCP_TOP').AsInteger,
      cdsEdit.FieldByName('DDTCP_LEFT').AsInteger,
      cdsEdit.FieldByName('DDTCP_WIDTH').AsInteger);
    cdsEdit.Next;
  end;
  {FIM}

  FreeAndNil(objStandard);
  FreeAndNil(objDataControlsStandard);

end;

procedure TfrmPesquisaConvencional.inserirFocoNoEdit;
var
  i: integer;
begin
  for i := 0 to ComponentCount -1 do
  begin
    if (Components[i] is TEdit) Then
    begin
      compEdit := TEdit(FindComponent(Components[i].Name));
      groupBox:= TGroupBox(compEdit.Parent);
      if groupBox.Name = 'gpbDados' then
      begin
        compEdit.SetFocus;
        exit;
      end;
    end
    else if (Components[i] is TDBLookupComboBox) Then
    begin
      compComboBox := TDBLookupComboBox(FindComponent(Components[i].Name));
      groupBox:= TGroupBox(compComboBox.Parent);
      if groupBox.Name = 'gpbDados' then
      begin
        compComboBox.SetFocus;
        exit;
      end;
    end;
  end;
end;

procedure TfrmPesquisaConvencional.inserirPesquisaEntreDatas;
var
  objInserirCampos: TInserirCampos;
begin
  objInserirCampos:= TInserirCampos.create;

  objInserirCampos.verificarSeExistePesquisaEntreDatas(inttostr(Self.Tag));
  objInserirCampos.objQuery.FDQuery.First;

  while not objInserirCampos.objQuery.FDQuery.Eof do
  begin
    groupBoxData:= TGroupBox.Create(self);
    groupBoxData.Parent:= gpbDados;
    groupBoxData.Name:= 'gpb'+
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_CODIGO').AsString;
    groupBoxData.Caption:=
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_NOME_PESQUISA').AsString;
    groupBoxData.Width:= 250;
    groupBoxData.Height:= 70;
    groupBoxData.Tag :=
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_CODIGO').AsInteger;
    groupBoxData.Top :=
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_TOP').AsInteger;
    groupBoxData.Left :=
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_lEFT').AsInteger;

    groupBoxData.OnMouseDown := pressionarGroupBoxData;
    groupBoxData.OnMouseMove := movimentarGroupBoxData;
    groupBoxData.OnMouseUp   := finalizarGroupBoxData;

    compData:= TJvDateEdit.Create(self);
    compData.Name:= 'edt' +
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_CODIGO').AsString + 'inicial';
    compData.Parent:= groupBoxData;
    compData.Width:= 110;
    compData.Top:= 35;
    compData.Left:= 5;

    labelComp := TLabel.Create(self);
    labelComp.Name:= 'lbl' +
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_CODIGO').AsString + 'inicial';
    labelComp.Caption:= 'Data inicial';
    labelComp.Top:= 20;
    labelComp.Left:= 5;
    labelComp.Parent:= groupBoxData;
    labelComp.Font.Size:= 9;

    compData:= TJvDateEdit.Create(self);
    compData.Name:= 'edt' +
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_CODIGO').AsString + 'final';
    compData.Parent:= groupBoxData;
    compData.Width:= 110;
    compData.Top:= 35;
    compData.Left:= 125;

    labelComp := TLabel.Create(self);
    labelComp.Name:= 'lbl' +
      objInserirCampos.objQuery.FDQuery.FieldByName('DDPED_CODIGO').AsString + 'final';
    labelComp.Caption:= 'Data final';
    labelComp.Top:= 20;
    labelComp.Left:= 125;
    labelComp.Parent:= groupBoxData;
    labelComp.Font.Size:= 9;

    objInserirCampos.objQuery.FDQuery.Next;
  end;

  FreeAndNil(objInserirCampos);

end;

procedure TfrmPesquisaConvencional.mostrarColunasNoDBGrid;
var
  objDBGrid : TComponenteDBGrid;
  cdsDBGrid : TClientDataSet;
  dspDBGrid : TDataSetProvider;
  tamanhoColuna: integer;
begin
  objDBGrid := TComponenteDBGrid.create;

  dspDBGrid := TDataSetProvider(FindComponent('dspDBGrid'));
  if dspDBGrid = nil then
  begin
    dspDBGrid := TDataSetProvider.Create(self);
    dspDBGrid.Name:= 'dspDBGrid';
    dspDBGrid.DataSet := objDBGrid.objQuery.FDQuery;
  end;

  cdsDBGrid := TClientDataSet(FindComponent('cdsDBGrid'));
  if cdsDBGrid = nil then
  begin
    cdsDBGrid := TClientDataSet.Create(self);
    cdsDBGrid.Name := 'cdsDBGrid';
    cdsDBGrid.ProviderName := dspDBGrid.Name;
  end;

  objDBGrid.pesquisarColunas(inttostr(self.Tag));
  cdsDBGrid.Close;
  cdsDBGrid.FetchParams;
  cdsDBGrid.Open;
  cdsDBGrid.First;

  giQtdeColunasGrid:=1;
  iContMonetario4:=0;
  iContMonetario2:=0;
  iContQtde:=0;
  while not cdsDBGrid.Eof do
  begin
    inserirColunaNoGrid(
      cdsDBGrid.FieldByName('CAMPO_FISICO').AsString,
      cdsDBGrid.FieldByName('CAMPO_APELIDO').AsString,
      cdsDBGrid.FieldByName('DDBDFC_DESCRICAO_CAMPO').AsString,
      cdsDBGrid.FieldByName('DDTCG_TAMANHO').AsInteger);

    tamanhoColuna:= cdsDBGrid.FieldByName('DDTCG_TAMANHO').AsInteger +100;
    gcVetorColunasDBGrid[1,giQtdeColunasGrid] :=
      cdsDBGrid.FieldByName('CAMPO_FISICO').AsString;
    gcVetorColunasDBGrid[2,giQtdeColunasGrid] := inttostr(tamanhoColuna);
    cdsDBGrid.Next;
    giQtdeColunasGrid:= giQtdeColunasGrid +1;
  end;

  FreeAndNil(objDBGrid);

end;

procedure TfrmPesquisaConvencional.mostrarComboBox(pCodigoComboBoxNaTela,
  codigoGroupBox, pNameCampo, pNameChavePrimaria, pCodigoTabela,
  pCodigoTabelaPrincipal, pCaptionCampo: string; pTop, pLeft, pWidth: integer);
begin
  inherited;
  objAuxiliar:= TAuxiliar.GetInstancia;
  if objAuxiliar.logadoComoADMSistema = true then
  begin
    groupBox:= TGroupBox(compComboBox.Parent);

    if groupBox.Name = 'gpbDados' then
      compComboBox.PopupMenu := popExcluirCampo
    else
      compComboBox.PopupMenu := popExcluirDBEdit;
  end;
end;

procedure TfrmPesquisaConvencional.mostrarEdit(pCodigoDBEdit, pLabel,
  pNameCampo, pCodigoMenu, pFormatoCampo, pTipoCampo, pDescricaoCampo: string;
  pTop, pLeft, pHeight, pWidth: integer);
begin
  if ((pFormatoCampo = '') and (pTipoCampo = 'VARCHAR'))
    or (pTipoCampo = '') then
  begin
    compEdit := TEdit.Create(self);

    compEdit.Parent := gpbDados;
    compEdit.Left := pLeft;
    compEdit.Top := pTop;
    compEdit.Width := pWidth;
    compEdit.Tag := strtoint(pCodigoDBEdit);

    if objAuxiliar.logadoComoADMSistema = true then
      compEdit.PopupMenu := popExcluirCampo;

    compEdit.Name := 'edt' + pNameCampo;
    compEdit.TabOrder := compEdit.TabOrder + 1;
    compEdit.Height := 26;
    compEdit.Text := '';
    compEdit.MaxLength := pWidth;

    compEdit.OnMouseDown := pressionarEdit;
    compEdit.OnMouseMove := movimentarEdit;
    compEdit.OnMouseUp   := finalizarEdit;
    compEdit.OnEnter     := enterCampo;
    compEdit.OnExit      := exitCampo;
    compEdit.OnKeyPress  := EnterFoco;
    compEdit.onKeyUp     := SetaParaCima;
  end
  else if (pFormatoCampo <> '') then
  begin
    compMaskEdit := TMaskEdit.Create(self);

    compMaskEdit.Parent := gpbDados;
    compMaskEdit.Left := pLeft;
    compMaskEdit.Top := pTop;
    compMaskEdit.Width := pWidth;
    compMaskEdit.Tag := strtoint(pCodigoDBEdit);

    if objAuxiliar.logadoComoADMSistema = true then
      compMaskEdit.PopupMenu := popExcluirCampo;

    compMaskEdit.Name := 'edt' + pNameCampo;
    compMaskEdit.TabOrder := compMaskEdit.TabOrder + 1;
    compMaskEdit.EditMask := pFormatoCampo;
    compMaskEdit.Height := 26;
    compMaskEdit.Text := '';

    compMaskEdit.OnMouseDown := pressionarMaskEdit;
    compMaskEdit.OnMouseMove := movimentarMaskEdit;
    compMaskEdit.OnMouseUp   := finalizarMaskEdit;
    compMaskEdit.OnEnter     := enterCampo;
    compMaskEdit.OnExit      := exitCampo;
    compMaskEdit.OnKeyPress  := EnterFoco;
    compMaskEdit.onKeyUp     := SetaParaCima;
  end;

  {Cria label}
  labelComp := TLabel.Create(self);
  labelComp.Left := pLeft;
  labelComp.Top  := pTop - 17;
  labelComp.name   := 'lbl' + 'edt' + pNameCampo;
  labelComp.Caption := pLabel;
  labelComp.parent := gpbDados;

end;

procedure TfrmPesquisaConvencional.movimentarEdit(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    compEdit.Left:= compEdit.Left-(gPt.x-x);
    compEdit.Top:= compEdit.Top - (gPt.y-y);
    labelComp.Left:= labelComp.Left-(gPt.x-x);
    labelComp.Top:= labelComp.Top - (gPt.y-y);
  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
    compEdit.Width := x +1;
  end;
end;

procedure TfrmPesquisaConvencional.movimentarGroupBoxData(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    groupBoxData.Left:= groupBoxData.Left-(gPt.x-x);
    groupBoxData.Top:= groupBoxData.Top - (gPt.y-y);
  end;
end;

procedure TfrmPesquisaConvencional.movimentarMaskEdit(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if objAuxiliar.logadoComoADMSistema = false then
    exit;

  if gbCapturando then
  begin
    compMaskEdit.Left:= compMaskEdit.Left-(gPt.x-x);
    compMaskEdit.Top:= compMaskEdit.Top - (gPt.y-y);
    labelComp.Left:= labelComp.Left-(gPt.x-x);
    labelComp.Top:= labelComp.Top - (gPt.y-y);
  end;
  if gbAlterandoTamanho then
  begin
    if x <=15 then
      exit;
    compMaskEdit.Width := x +1;
  end;
end;

procedure TfrmPesquisaConvencional.ordenarCampos;
var
  i, iTop, iSomatop, iSomaLeft, iSomawidth: integer;
  cComp: string;
  cptComponente : TComponent;
  objStandard : TComponenteStandard;
begin
  objStandard := TComponenteStandard.create;

  objStandard.pesquisarEdits(inttostr(self.Tag), 'Ordenar');
  objStandard.objQuery.FDQuery.First;

  {Limpeza de vetor}
  FillChar(gcVetorLinha, SizeOf(gcVetorLinha), #0);
  {FIM}

  giQtdeLinha:=1;
  iTop:= 0;
  i:=0;

  while not objStandard.objQuery.FDQuery.Eof do
  begin
    gcVetorLinha[1,i+1] :=
      objStandard.objQuery.FDQuery.FieldByName('CAMPO_FISICO').AsString;
    gcVetorLinha[2,i+1] := '999'; {passa-se o valor 999 para nao ficar
                                vazio quando passar no while de organização
                                dos campos (1º campo, 2ºcampo e etc)
                                e poder sair do while}
    if objStandard.objQuery.FDQuery.RecNo = 1 then
    begin
      gcVetorLinha[2,i+1] := '1';
      iTop:= objStandard.objQuery.FDQuery.FieldByName('DDTCP_TOP').AsInteger;
    end
    else
    begin

      if (objStandard.objQuery.FDQuery.FieldByName('DDTCP_TOP').AsInteger - iTop) > 30 then
      begin

        {Organiza a ordem dos campos da mesma linha (1ºcampo, 2ºcampo,
          3ºcampo e etc)}
         OrdenarCamposMesmaLinha;
        {FIM}

        giQtdeLinha:= giQtdeLinha+1;
        iTop:= objStandard.objQuery.FDQuery.FieldByName('DDTCP_TOP').AsInteger;
      end;
       gcVetorLinha[2,i+1] := IntToStr(giQtdeLinha);
    end;
    i:=i+1;
    objStandard.objQuery.FDQuery.Next;
  end;

  {Repetição do codigo de ordenação dos vetores}
  OrdenarCamposMesmaLinha;
  {FIM}

  {Calcula media Top e left de cada linha}
  iSomatop:= 45;
  giQtdeCol:=1;
  for i:=1 to giQtdeLinha do
  begin
    iSomaLeft:= 25;
    iSomawidth:= 0;
    while gcVetorLinha[2,giQtdeCol] = IntToStr(i) do
    begin
      {Verifica se componente é Edit ou ComboBox, se for combobox é dbEdt}
      cptComponente := FindComponent('edt' + gcVetorLinha[1,giQtdeCol]);
      if cptComponente = nil then
      begin
        cptComponente := FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol] + '_P');
      end;
      {FIM}

      cComp:= cptComponente.ClassName;

      {Calcula media vertical (Top) da linha}
      if cComp = 'TEdit' then
      begin
        compEdit := TEdit(FindComponent('edt' + gcVetorLinha[1,giQtdeCol]));
        compEdit.Top := iSomaTop;
      end
      else if cComp = 'TMaskEdit' then
      begin
        compMaskEdit := TMaskEdit(FindComponent('edt' + gcVetorLinha[1,giQtdeCol]));
        compMaskEdit.Top := iSomaTop;
      end
      else if cComp = 'TDBLookupComboBox' then
      begin
        compComboBox := TDBLookupComboBox(FindComponent('dbEdt' + gcVetorLinha[1,giQtdeCol] + '_P' ));
        compComboBox.Top := iSomaTop;
      end;

      labelComp := TLabel(FindComponent('lbl' + 'edt' + gcVetorLinha[1,giQtdeCol]));

      if labelComp = nil then
      begin
        labelComp := TLabel(FindComponent('dblbl' + 'dbEdt' + gcVetorLinha[1,giQtdeCol] + '_P' ));
      end;

      labelComp.Top := iSomaTop -17;
      {FIM}

      {Calcula o espaço horizontal(left) entre os campos da mesma linha}
      if iSomawidth = 0 then
      begin
        if cComp = 'TEdit' then
        begin
          iSomawidth:= compEdit.Width +25;
          compEdit.Left:= 25;
        end
        else if cComp = 'TMaskEdit' then
        begin
          iSomawidth:= compMaskEdit.Width +25;
          compMaskEdit.Left:= 25;
        end
        else if cComp = 'TDBLookupComboBox' then
        begin
          iSomawidth:= compComboBox.Width +25;
          compComboBox.Left:= 25;
        end;
        labelComp := TLabel(FindComponent('lbl' + 'edt' + gcVetorLinha[1,giQtdeCol]));

        if labelComp = nil then
          labelComp := TLabel(FindComponent('dblbl' + 'dbEdt' + gcVetorLinha[1,giQtdeCol] + '_P'));

        labelComp.Left:= 25;
      end
      else
      begin
        if cComp = 'TEdit' then
        begin
          compEdit.Left:= iSomawidth + 10;
          labelComp := TLabel(FindComponent('lbl' + 'edt' + gcVetorLinha[1,giQtdeCol]));
          labelComp.Left:= iSomawidth +10;
          iSomawidth:= iSomawidth + compEdit.Width +10;
        end
        else if cComp = 'TMaskEdit' then
        begin
          compMaskEdit.Left:= iSomawidth + 10;
          labelComp := TLabel(FindComponent('lbl' + 'edt' + gcVetorLinha[1,giQtdeCol]));
          labelComp.Left:= iSomawidth +10;
          iSomawidth:= iSomawidth + compMaskEdit.Width +10;
        end
        else if cComp = 'TDBLookupComboBox' then
        begin
          compComboBox.Left:= iSomawidth + 10;
          labelComp := TLabel(FindComponent('dblbl' + 'dbEdt' + gcVetorLinha[1,giQtdeCol] + '_P'));
          labelComp.Left:= iSomawidth +10;
          iSomawidth:= iSomawidth + compComboBox.Width +10;
        end;
      end;
      {FIM}

      {grava a posicao horizontal e vertical na tabela}
      if cComp = 'TEdit' then
      begin
        objStandard.alterarTamanhoPosicao(inttostr(compEdit.Tag),
          compEdit.Left, compEdit.Top, compEdit.Width, compEdit.Height);
      end
      else if cComp = 'TMaskEdit' then
      begin
        objStandard.alterarTamanhoPosicao(inttostr(compMaskEdit.Tag),
          compMaskEdit.Left, compMaskEdit.Top, compMaskEdit.Width, compMaskEdit.Height);
      end
      else if cComp = 'TDBLookupComboBox' then
      begin
        objStandard.alterarTamanhoPosicao(inttostr(compComboBox.Tag),
          compComboBox.Left, compComboBox.Top, compComboBox.Width, compComboBox.Height);
      end;
      {FIM}
      giQtdeCol:= giQtdeCol +1;
    end;
    iSomatop:= iSomaTop + 45;
  end;

  FreeAndNil(objStandard);

end;

procedure TfrmPesquisaConvencional.OrdenarCamposMesmaLinha;
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
      {Verifica se componente é Edit ou ComboBox, se for combobox é dbEdt}
      cptComponente := FindComponent('edt' + gcVetorLinha[1,giQtdeCol]);
      if cptComponente = nil then
      begin
        cptComponente := FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]);

        if cptComponente = nil then
          cptComponente := FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol] + '_P');

      end;
      {FIM}
      cComp:= cptComponente.ClassName;

      if cComp = 'TEdit' then
      begin
        compEdit := TEdit(FindComponent('edt' + gcVetorLinha[1,giQtdeCol]));
        cVetorAuxOrdenacao[1,iAuxOrd]:= gcVetorLinha[1,giQtdeCol];
        cVetorAuxOrdenacao[2,iAuxOrd]:= IntToStr(compEdit.Left);
      end
      else if cComp = 'TMaskEdit' then
      begin
        compMaskEdit := TMaskEdit(FindComponent('edt' + gcVetorLinha[1,giQtdeCol]));
        cVetorAuxOrdenacao[1,iAuxOrd]:= gcVetorLinha[1,giQtdeCol];
        cVetorAuxOrdenacao[2,iAuxOrd]:= IntToStr(compMaskEdit.Left);
      end
      else if cComp = 'TDBLookupComboBox' then
      begin
        compComboBox := TDBLookupComboBox(FindComponent('dbedt' + gcVetorLinha[1,giQtdeCol]+ '_P'));
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

procedure TfrmPesquisaConvencional.popItemExcluir1Click(Sender: TObject);
var
  objDataStandard: TComponenteStandard;
  i: integer;
begin
  objDataStandard:= TComponenteStandard.create;

  i := popExcluirCampo.PopupComponent.ComponentIndex;
  if Components[i] is TEdit then
  begin
    objDataStandard.excluirCampo(inttostr(compEdit.Tag));
    labelComp := TLabel(FindComponent('lbl' + compEdit.Name));
    FreeAndNil(compEdit);
  end
  else if Components[i] is TMaskEdit then
  begin
    objDataStandard.excluirCampo(inttostr(compMaskEdit.Tag));
    labelComp := TLabel(FindComponent('lbl' + compMaskEdit.Name));
    FreeAndNil(compMaskEdit);
  end
  else if Components[i] is TDBLookupComboBox then
  begin
    objDataStandard.excluirCampo(inttostr(compComboBox.Tag));
    labelComp := TLabel(FindComponent('dblbl' + compComboBox.Name));
    FreeAndNil(compComboBox);
  end;

  FreeAndNil(objDataStandard);
  FreeAndNil(labelComp);
end;

procedure TfrmPesquisaConvencional.popItemExcluircolunaselecionada1Click(
  Sender: TObject);
var
  objDBGrid: TComponenteDBGrid;
begin
  objDBGrid:= TComponenteDBGrid.create;
  if objDBGrid.excluirColuna(inttostr(colunaSelecionada),
    inttostr(self.Tag)) = 'Erro' then
  begin
    Application.MessageBox(Pchar('Erro na exclusão da coluna.'),'Erro',
        MB_OK+MB_ICONERROR + MB_TOPMOST);
  end
  else
  begin
    grdGrid.Columns[colunaSelecionada].Free;
    giQtdeColunasGrid:= giQtdeColunasGrid-1;
  end;

  FreeAndNil(objDBGrid);
end;

procedure TfrmPesquisaConvencional.popItemInserircampo1Click(Sender: TObject);
begin

  objAuxiliar := TAuxiliar.GetInstancia;
  objAuxiliar.codigoMenu := inttostr(self.Tag);
  objAuxiliar.codigoTabela := codigoTabela;
  objAuxiliar.tipoTela := 'P'; {P de tela de Pesquisa}

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

procedure TfrmPesquisaConvencional.popItemInserircampo2Click(Sender: TObject);
begin
  objAuxiliar := TAuxiliar.GetInstancia;
  objAuxiliar.codigoMenu := inttostr(self.Tag);
  objAuxiliar.codigoTabela := codigoTabela;
  objAuxiliar.tipoTela := 'G'; {G de dbGrid}

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

procedure TfrmPesquisaConvencional.popItemOrdenarcampo1Click(Sender: TObject);
begin
  ordenarCampos;
end;

procedure TfrmPesquisaConvencional.pressionarEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  compEdit := Sender as TEdit;
  labelComp := TLabel(FindComponent('lbl' + compEdit.Name));
  if ssCtrl in Shift then
  begin
    SetCapture(compEdit.Handle);
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

procedure TfrmPesquisaConvencional.pressionarGroupBoxData(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  groupBoxData := Sender as TGroupBox;
  if ssCtrl in Shift then
  begin
    SetCapture(groupBoxData.Handle);
    gbCapturando := true;
    gPt.X := x;
    gPt.Y := Y;
  end;
end;

procedure TfrmPesquisaConvencional.pressionarMaskEdit(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  compMaskEdit := Sender as TMaskEdit;
  labelComp := TLabel(FindComponent('lbl' + compMaskEdit.Name));
  if ssCtrl in Shift then
  begin
    SetCapture(compMaskEdit.Handle);
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

procedure TfrmPesquisaConvencional.tmMostrarComponentesPesquisaTimer(
  Sender: TObject);
var
  objPesquisar : TPesquisa;
  objDataControlsStandard: TComponenteDataControlsStandard;

begin
  inherited;
  objPesquisar := TPesquisa.create;

  {Verifica se botão tela de pesquisa está cadastrada, senão tiver será cadastrado}
  if objPesquisar.verificarSeBotaoDaTelaDePesquisaJaFoiCadastrado
     (inttostr(self.Tag)) = false then
  begin
    if objPesquisar.cadastrarPosicaoBotaoPesquisar(inttostr(self.Tag)) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro no cadastro do botão de pesquisa'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
      Exit;
    end;
  end;
  {FIM}

  {Verifica se gpbDados da tela de pesquisa está cadastrada,
  senão tiver será cadastrado}
  if objPesquisar.verificarSeGpbDadosDaTelaDePesquisaJaFoiCadastrado
     (inttostr(self.Tag)) = false then
  begin
    if objPesquisar.cadastrarGpbDadosTelaDePesquisa(inttostr(self.Tag)) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro no cadastro de tamanho do gpbGroupBox'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
      Exit;
    end;
  end;
  {FIM}

  {Verifica se grdGrid da tela de pesquisa está cadastrada,
  senão tiver será cadastrado}
  if objPesquisar.verificarSeGrdGridDaTelaDePesquisaJaFoiCadastrado
     (inttostr(self.Tag)) = false then
  begin
    if objPesquisar.cadastrarGrdGridTelaDePesquisa(inttostr(self.Tag)) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro no cadastro de tamanho do grdGrid'),
        'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
      Exit;
    end;
  end;
  {FIM}

  {Pegar tamanho do gpbDados}
  objPesquisar.pegarTamanhoGpbDadosPesquisa(inttostr(Self.Tag));
  gpbDados.Height := objPesquisar.objQuery.FDQuery.FieldByName('DDTCP_HEIGHT').AsInteger;
  gpbDados.Width :=  objPesquisar.objQuery.FDQuery.FieldByName('DDTCP_WIDTH').AsInteger;
  gpbDados.Top   :=  objPesquisar.objQuery.FDQuery.FieldByName('DDTCP_TOP').AsInteger;
  gpbDados.Left  :=  objPesquisar.objQuery.FDQuery.FieldByName('DDTCP_LEFT').AsInteger;
  {FIM}

  {Pegar tamanho do grdGrid}
  objPesquisar.pegarTamanhogrdGridPesquisa(inttostr(Self.Tag));
  grdGrid.Height := objPesquisar.objQuery.FDQuery.FieldByName('DDTCP_HEIGHT').AsInteger;
  grdGrid.Width :=  objPesquisar.objQuery.FDQuery.FieldByName('DDTCP_WIDTH').AsInteger;
  grdGrid.Top   :=  objPesquisar.objQuery.FDQuery.FieldByName('DDTCP_TOP').AsInteger;
  grdGrid.Left  :=  objPesquisar.objQuery.FDQuery.FieldByName('DDTCP_LEFT').AsInteger;
  {FIM}

  if objAuxiliar.logadoComoADMSistema = true then
    self.PopupMenu := popOpcoesTelaCadastro;

  inserirEditNoSeuRespectivoGroupBox;
  inserirPesquisaEntreDatas;
  mostrarColunasNoDBGrid;

  inserirFocoNoEdit;

  try
    cdsCadastro.EmptyDataSet;
  except
    objDataControlsStandard:= TComponenteDataControlsStandard.create;
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

    FreeAndNil(objDataControlsStandard);
  end;

  tmMostrarComponentesPesquisa.Enabled := false;

end;

procedure TfrmPesquisaConvencional.verificarSehouveAlteracaoNaPosicaoDaColuna;
var
  i: integer;
  objGrid: TComponenteDBGrid;
begin
  i:=1;

  objGrid:= TComponenteDBGrid.create;

  while i< giQtdeColunasGrid do
  begin
    if grdGrid.Columns[i -1].FieldName <> gcVetorColunasDBGrid[1,i] then
    begin
      break;
    end;
    i:=i+1;
  end;

  if i=giQtdeColunasGrid then
    exit;

  i:=1;
  while i< giQtdeColunasGrid do
  begin
    objGrid.alterarPosicaoDasColunasDBGrid(IntToStr(self.Tag),
      codigoTabela, grdGrid.Columns[i -1].FieldName, i);
    i:=i+1;
  end;

  FreeAndNil(objGrid);

end;

procedure TfrmPesquisaConvencional.verificarSeHouveAlteracaoNoTamanhoDaColuna;
var
  i: integer;
  objGrid: TComponenteDBGrid;
begin
  i:=1;

  objGrid:= TComponenteDBGrid.create;

  while i< giQtdeColunasGrid do
  begin
    if inttostr(grdGrid.Columns[i -1].Width) <> gcVetorColunasDBGrid[2,i] then
    begin
      objGrid.alterarTamanhoDasColunasDBGrid(IntToStr(self.Tag),
        codigoTabela, grdGrid.Columns[i -1].FieldName,
        grdGrid.Columns[i -1].Width -100 );
    end;
    i:=i+1;
  end;

  FreeAndNil(objGrid);

end;

initialization
  RegisterClass(TfrmPesquisaConvencional);

end.
