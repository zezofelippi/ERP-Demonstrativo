unit untCadastrarPageControl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untBase, JvExControls, JvButton,
  JvNavigationPane, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, uComponentePageControl,
  Data.DB, Datasnap.DBClient, Datasnap.Provider, uAuxiliar, Vcl.Menus,
  Vcl.ImgList;

type
  TfrmCadastrarPageControl = class(TfrmBase)
    lbl2: TLabel;
    edtNomeTabSheet: TEdit;
    btnGravar: TJvNavPanelButton;
    grdTabSheet: TDBGrid;
    popOpcoes: TPopupMenu;
    popItemAlterar1: TMenuItem;
    popItemExcluir1: TMenuItem;
    imgListIcone: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdTabSheetDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure popItemExcluir1Click(Sender: TObject);
    procedure popItemAlterar1Click(Sender: TObject);
    procedure grdTabSheetDblClick(Sender: TObject);
  private
    { Private declarations }
    cdsTabSheet: TClientDataSet;
    dspTabSheet: TDataSetProvider;
    dtsTabSheet: TDataSource;
    gCodigoTabSheet, gNomeTabSheet : string;
    gRecNo: integer;
    objAuxiliar: TAuxiliar;
    procedure mostrarTabSheet;
    procedure montarEstruturaDBGrid;
    procedure alterarPosicaoDoTabSheet;
  public
    { Public declarations }
    codigoMenu, nomeTela: string;
  end;

var
  frmCadastrarPageControl: TfrmCadastrarPageControl;

implementation

{$R *.dfm}

procedure TfrmCadastrarPageControl.alterarPosicaoDoTabSheet;
var
  codigoFixo, nomeFixo, nomeTabSheet, codigoTabSheetLocal : string;
  codigoZero: boolean;
  i: integer;
  objPageControl: TComponentePageControl;
begin
  if Screen.Cursor = crDefault then
  begin
    Screen.Cursor := crDrag;
    gNomeTabSheet := grdTabSheet.Fields[0].asString;
    gCodigoTabSheet := grdTabSheet.Fields[1].asString;
    gRecNo  := grdTabSheet.DataSource.DataSet.RecNo;

    grdTabSheet.DataSource.DataSet.Edit;
    grdTabSheet.Fields[1].AsInteger := -1;
    grdTabSheet.DataSource.DataSet.Post;

  end
  else
  begin
    Screen.Cursor := crDefault;
    nomeFixo   := gNomeTabSheet;
    codigoFixo := gCodigoTabSheet;

    {Altera na memória (cds)}
    if gRecNo > grdTabSheet.DataSource.DataSet.RecNo then
    begin

      while not grdTabSheet.DataSource.DataSet.Eof do
      begin
        {Muda nome da aba de posição}
        if nomeFixo <> nomeTabSheet then
        begin
          nomeTabSheet := grdTabSheet.Fields[0].asString;

          grdTabSheet.DataSource.DataSet.Edit;
          grdTabSheet.Fields[0].asString := gNomeTabSheet;
          grdTabSheet.DataSource.DataSet.Post;

          gNomeTabSheet := nomeTabSheet;
        end;
        {FIM}

        {Muda Codigo da aba de posição}
        if codigoFixo <> codigoTabSheetLocal then
        begin
          if grdTabSheet.Fields[1].asString <> '-1' then
          begin
            codigoTabSheetLocal := grdTabSheet.Fields[1].asString;
            codigoZero := false;
          end
          else
            codigoZero:= true;
          try
            try
              grdTabSheet.DataSource.DataSet.Edit;
              grdTabSheet.Fields[1].asString := gCodigoTabSheet;
              grdTabSheet.DataSource.DataSet.Post;
            except
              grdTabSheet.DataSource.DataSet.Edit;
              grdTabSheet.Fields[1].asString := codigoTabSheetLocal;
              grdTabSheet.DataSource.DataSet.Post;
            end;
          except
            Application.MessageBox(Pchar('Não foi possível alterar a posição '+
              'da aba de BAIXO para CIMA '),
              'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
            Exit;
          end;

          if codigoZero = true then
          begin
            grdTabSheet.DataSource.DataSet.next;
            gcodigoTabSheet := grdTabSheet.Fields[1].asString;
            grdTabSheet.DataSource.DataSet.prior;
          end
          else
            gCodigoTabSheet := codigoTabSheetLocal;

        end;
        {FIM}

        grdTabSheet.DataSource.DataSet.Next;

      end;

    end
    else
    begin

      while not grdTabSheet.DataSource.DataSet.Bof do
      begin
        {Muda nome da aba posição}
        if nomeFixo <> nomeTabSheet then
        begin
          nomeTabSheet := grdTabSheet.Fields[0].asString;

          grdTabSheet.DataSource.DataSet.Edit;
          grdTabSheet.Fields[0].asString := gNomeTabSheet;
          grdTabSheet.DataSource.DataSet.Post;

          gNomeTabSheet := nomeTabSheet;
        end;
        {FIM}

        {Muda Codigo da aba de posição}
        if codigoFixo <> codigoTabSheetLocal then
        begin
          if grdTabSheet.Fields[1].asString <> '-1' then
          begin
            codigoTabSheetLocal := grdTabSheet.Fields[1].asString;
            codigoZero := false;
          end
          else
            codigoZero:= true;

          try
            try
              grdTabSheet.DataSource.DataSet.Edit;
              grdTabSheet.Fields[1].asString := gCodigoTabSheet;
              grdTabSheet.DataSource.DataSet.Post;
            except
              grdTabSheet.DataSource.DataSet.Edit;
              grdTabSheet.Fields[1].asString := codigoTabSheetLocal;
              grdTabSheet.DataSource.DataSet.Post;
            end;
          except
            Application.MessageBox(Pchar('Não foi possível alterar a posição '+
              'da aba de CIMA para BAIXO '),
              'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
            Exit;
          end;

          if codigoZero = true then
          begin
            grdTabSheet.DataSource.DataSet.Prior;
            gCodigoTabSheet := grdTabSheet.Fields[1].asString;
            grdTabSheet.DataSource.DataSet.Next;
          end
          else
            gCodigoTabSheet := codigoTabSheetLocal;
        end;
        {FIM}

        grdTabSheet.DataSource.DataSet.Prior;

      end;
    end;
    {FIM}

    {Altera no banco de dados}
    cdsTabSheet.First;
    objPageControl:= TComponentePageControl.create;
    i:=0;
    while not cdsTabSheet.Eof do
    begin
      if objPageControl.reordenarPosicaoTabSheet(
        cdsTabSheet.FieldByName('DDTS_CODIGO').AsString, i) = 'Erro' then
      begin
        Application.MessageBox(Pchar('Não foi possível alterar a posição '+
         'do TabSheet.'),
         'Erro!', MB_OK+MB_ICONERROR + MB_TOPMOST);
        abort;
      end;
      cdsTabSheet.Next;
      i:=i+1;
    end;
    FreeAndNil(objPageControl);
    {FIM}

  end;
end;

procedure TfrmCadastrarPageControl.btnGravarClick(Sender: TObject);
var
  objPageControl : TComponentePageControl;
  codigoPageControl : string;
begin
  inherited;
  objPageControl := TComponentePageControl.create;

  if btnGravar.Tag = 0 then
  begin
    {Verifica se PageControl já existe, se não existir ele será cadastrado primeiro}
    if objPageControl.verificarSePageControlJaExisteNaTela(codigoMenu) = '' then
    begin
      if objPageControl.cadastrarPageControl(codigoMenu, 'pgc' + nomeTela) = 'Erro' then
      begin
        btnGravar.Tag := 0;
        FreeAndNil(objPageControl);
        Application.MessageBox(Pchar('Erro no cadastro '+
          ' do PageControl. '), 'Erro!',
        MB_OK+MB_ICONERROR + MB_TOPMOST);
        exit;
      end;
    end;
    {FIM}
    codigoPageControl :=
      objPageControl.verificarSePageControlJaExisteNaTela(codigoMenu);

    if objPageControl.cadastrarTabSheet(codigoPageControl, edtNomeTabSheet.Text) = 'Erro' then
    begin
       Application.MessageBox(Pchar('Erro no cadastro '+
          ' do TabSheet. '), 'Erro!',
        MB_OK+MB_ICONERROR + MB_TOPMOST);
    end;
  end
  else if btnGravar.Tag = 1 then
  begin
    if objPageControl.alterarCadastroTabSheet(
      gCodigoTabSheet, edtNomeTabSheet.Text) = 'Erro' then
    begin
       Application.MessageBox(Pchar('Erro na alteração do cadastro'+
          ' do TabSheet. '), 'Erro!',
        MB_OK+MB_ICONERROR + MB_TOPMOST);
    end;
  end;

  FreeAndNil(objPageControl);
  mostrarTabSheet;
  edtNomeTabSheet.Clear;
  btnGravar.Tag := 0;
end;

procedure TfrmCadastrarPageControl.FormCreate(Sender: TObject);
begin
  width  := 450;
  Height := 350;
end;

procedure TfrmCadastrarPageControl.FormShow(Sender: TObject);
begin
  inherited;
  montarEstruturaDBGrid;
  mostrarTabSheet;
  btnGravar.Tag := 0;
end;

procedure TfrmCadastrarPageControl.grdTabSheetDblClick(Sender: TObject);
begin
  inherited;
  alterarPosicaoDoTabSheet;
end;

procedure TfrmCadastrarPageControl.grdTabSheetDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color:= clWhite
  else
    (Sender as TDBGrid).Canvas.Brush.Color:= $00EFEFEF;

  if gdSelected in State then
  begin
    grdTabSheet.Canvas.Font.Style := [fsItalic, fsBold];
  end;

  grdTabSheet.Canvas.Font.Color:= clBlack;

  grdTabSheet.Canvas.FillRect(Rect);
  grdTabSheet.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCadastrarPageControl.montarEstruturaDBGrid;
begin
  grdTabSheet.Columns[0].FieldName := 'DDTS_CAPTION';
  grdTabSheet.Columns[0].Title.Caption := 'Nome do TabSheet';
  grdTabSheet.Columns[0].Width := 200;

  grdTabSheet.Columns[1].FieldName := 'DDTS_CODIGO';

end;

procedure TfrmCadastrarPageControl.mostrarTabSheet;
var
  objPageControl: TComponentePageControl;
  codigoPageControl: string;
begin
  objPageControl:= TComponentePageControl.create;
  objAuxiliar:= TAuxiliar.GetInstancia;

  codigoMenu := objAuxiliar.codigoMenu;
  nomeTela := objAuxiliar.nomeTela;

  codigoPageControl :=
    objPageControl.verificarSePageControlJaExisteNaTela(codigoMenu);

  if codigoPageControl <> '' then
  begin
    objPageControl.mostrarTabSheet(codigoPageControl);

    dspTabSheet := TDataSetProvider(FindComponent('dspTabSheet'));
    if dspTabSheet = nil then
    begin
      dspTabSheet := TDataSetProvider.Create(self);
      dspTabSheet.Name:= 'dspTabSheet';
      dspTabSheet.DataSet := objPageControl.objQuery.FDQuery;
    end;

    cdsTabSheet := TClientDataSet(FindComponent('cdsTabSheet'));
    if cdsTabSheet = nil then
    begin
      cdsTabSheet := TClientDataSet.Create(self);
      cdsTabSheet.Name := 'cdsTabSheet';
      cdsTabSheet.ProviderName := dspTabSheet.Name;
    end;

    dtsTabSheet := TDataSource(FindComponent('dtsTabSheet'));
    if dtsTabSheet = nil then
    begin
      dtsTabSheet := TDataSource.Create(self);
      dtsTabSheet.Name := 'dtsTabSheet';
      dtsTabSheet.DataSet := cdsTabSheet;
    end;

    grdTabSheet.DataSource := dtsTabSheet;

    cdsTabSheet.Close;
    cdsTabSheet.FetchParams;
    cdsTabSheet.Open;

  end;

  FreeAndNil(objPageControl);

end;

procedure TfrmCadastrarPageControl.popItemAlterar1Click(Sender: TObject);
begin
  inherited;

  if Screen.Cursor = crDrag then
  begin
    grdTabSheet.DataSource.DataSet.Edit;
    grdTabSheet.Fields[1].AsString := gCodigoTabSheet;
    grdTabSheet.DataSource.DataSet.Post;
    Screen.Cursor := crDefault;
  end;

  gCodigoTabSheet := cdsTabSheet.FieldByName('DDTS_CODIGO').AsString;
  edtNomeTabSheet.Text :=  cdsTabSheet.FieldByName('DDTS_CAPTION').AsString;
  btnGravar.Tag := 1;
end;

procedure TfrmCadastrarPageControl.popItemExcluir1Click(Sender: TObject);
VAR
  objComponentePageControl: TComponentePageControl;
  codigoPageControl: string;
  i, i_aux: integer;
  vetorTabSheet: array of string;
begin
  inherited;
  objComponentePageControl:= TComponentePageControl.create;

  {Verifica se tem GroupBox No TabSheet}
  if objComponentePageControl.verificarSeTabSheetPossuiGroupBox(
    cdsTabSheet.FieldByName('DDTS_CODIGO').AsString) = true then
  begin
    FreeAndNil(objComponentePageControl);
    Application.MessageBox(Pchar('TabSheet possui Groupbox, exclua-os '+
      'primeiro.'), 'Informação!',
    MB_OK+MB_ICONWARNING + MB_TOPMOST);
    exit;
  end;
  {FIM}

  {Exclui Tabsheet}
  if objComponentePageControl.excluirTabSheet(
    cdsTabSheet.FieldByName('DDTS_CODIGO').AsString) = 'Erro' then
  begin
    FreeAndNil(objComponentePageControl);
      Application.MessageBox(Pchar('Erro na exclusão '+
        ' do TabSheet. '), 'Erro!',
      MB_OK+MB_ICONERROR + MB_TOPMOST);
    exit;
  end;
  {FIM}

  codigoPageControl :=
    objComponentePageControl.verificarSePageControlJaExisteNaTela(codigoMenu);

  {Se pagecontrol não possuir mais tabsheet, aquele deverá ser excluído}
  if objComponentePageControl.verificaSePageControlPossuiTabSheet
    (codigoPageControl) = false then
  begin
    if objComponentePageControl.excluirPageControl(codigoPageControl) = 'Erro' then
    begin
      FreeAndNil(objComponentePageControl);
      Application.MessageBox(Pchar('Erro na exclusão do PageControl. '), 'Erro!',
      MB_OK+MB_ICONERROR + MB_TOPMOST);
      exit;
    end;
    cdsTabSheet.Close;
  end;
  {FIM}

  {ordena os TabSheets}
  objComponentePageControl.mostrarTabSheet(codigoPageControl);
  objComponentePageControl.objQuery.FDQuery.First;
  i:=0;
  while not objComponentePageControl.objQuery.FDQuery.Eof do
  begin
    SetLength(vetorTabSheet, i +1);
    vetorTabSheet[i]:=
      objComponentePageControl.objQuery.FDQuery.FieldByName('DDTS_CODIGO').AsString;
    i:=i+1;
    objComponentePageControl.objQuery.FDQuery.Next;
  end;

  i_aux:=0;
  while i_aux < i do
  begin
    if objComponentePageControl.reordenarPosicaoTabSheet(
      vetorTabSheet[i_aux], i_aux) = 'Erro' then
    begin
      FreeAndNil(objComponentePageControl);
       Application.MessageBox(Pchar('Erro na ordenação '+
       ' do TabSheet. '), 'Erro!',
       MB_OK+MB_ICONERROR + MB_TOPMOST);
      exit;
    end;
    i_aux := i_aux +1;
  end;
  {FIM}

  FreeAndNil(objComponentePageControl);
  mostrarTabSheet;

end;

end.
