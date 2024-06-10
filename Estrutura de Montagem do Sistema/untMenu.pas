unit untMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.CategoryButtons,
  Vcl.ToolWin,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, {FireDAC.Phys.MySQLDef,}
  Vcl.DBCtrls, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  uMenu, Vcl.ExtCtrls, Vcl.ImgList, Vcl.StdCtrls, Vcl.Menus, JvExControls,
  JvButton, JvTransparentButton, JvSpeedButton, uAuxiliar;

type
  TfrmMenu = class(TForm)
    tooBotaoAtalho: TToolBar;
    ctbMenu: TCategoryButtons;
    stat1: TStatusBar;
    fdgxwtcrsr1: TFDGUIxWaitCursor;
    imgListaIconesMenu: TImageList;
    popMenu: TPopupMenu;
    popItemAbrirmdulos: TMenuItem;
    popItemFecharmdulos: TMenuItem;
    imgListaIconesBotaoAtalho: TImageList;
    popBotaoAtalho: TPopupMenu;
    popItemExcluirBoto1: TMenuItem;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure ConstruirMenu(Sender: Tobject);
    procedure FormShow(Sender: TObject);
    procedure ctbMenuButtonClicked(Sender: TObject; const Button: TButtonItem);
    procedure inserirModuloBasico(Sender: TObject);
    procedure inserirCadastroDeFormsEmCadaModulo(Sender: TObject);
    procedure inserirTelasEmCadaModulo(Sender: TObject);
    procedure popItemAbrirmdulosClick(Sender: TObject);
    procedure popItemFecharmdulosClick(Sender: TObject);
    procedure fecharModulos(Sender: TObject);
    procedure abrirModulos(Sender: TObject);
    procedure abrirModuloEspecifico(pIndexModulo: integer);
    procedure popItemExcluirBoto1Click(Sender: TObject);
  private
    { Private declarations }
    objMenuPrivate : TUMenu;
    objAuxiliar: TAuxiliar;
    botaoAtalhoPrivate: string;
    procedure construirBotoesDeAtalho;
    procedure abrirForm;
  public
    { Public declarations }
    procedure clicarBotaoAtalho(Sender: TObject);
    procedure pegarNomeDoBotaoDeAtalho(Sender: TObject);
  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  untCadastroModuloClasse, untTabelaCampo, untCadastroForm, untLogin;

{$R *.dfm}

{ TfrmMenu }

procedure TfrmMenu.abrirForm;
var
  frmFormNome: Tform;
  frcFormClasse : TFormclass;
begin
  frmFormNome := Tform(FindGlobalComponent(
    objMenuPrivate.objQuery.FDQuery.FieldByName('DDM_NAME').AsString));

  if frmFormNome = nil then
  begin
    frcFormClasse := TFormClass(FindClass(
      objMenuPrivate.objQuery.FDQuery.FieldByName('DDCPF_DESCRICAO').AsString));
    frmFormNome := frcFormClasse.create(self);

    frmFormNome.Name :=
      objMenuPrivate.objQuery.FDQuery.FieldByName('DDM_NAME').AsString;
    frmFormNome.Caption :=
      objMenuPrivate.objQuery.FDQuery.FieldByName('DDM_CAPTION').AsString;
    frmFormNome.Tag :=
      objMenuPrivate.objQuery.FDQuery.FieldByName('DDM_CODIGO').AsInteger;

    if objMenuPrivate.objQuery.FDQuery.FieldByName('DDM_CAMINHO_ICONE').AsString <> '' then
    begin
      frmFormNome.Icon.LoadFromFile(
        objMenuPrivate.objQuery.FDQuery.FieldByName('DDM_CAMINHO_ICONE').AsString);
    end
    else
    begin
      frmFormNome.Icon := nil;
      frmFormNome.Hint := '';
    end;
    frmFormNome.Show;
  end
  else
  begin
    frmFormNome.WindowState := wsNormal;
    frmFormNome.BringToFront;
  end;
end;

procedure TfrmMenu.abrirModuloEspecifico(pIndexModulo: integer);
begin
ctbMenu.Categories.Items[pIndexModulo].Collapsed := false;
end;

procedure TfrmMenu.abrirModulos(Sender: TObject);
var
  i: integer;
begin
  i:=0;
  while i< ctbMenu.Categories.Count do
  begin
    ctbMenu.Categories.Items[i].Collapsed := false;
    i:= i + 1;
  end;
end;

procedure TfrmMenu.clicarBotaoAtalho(Sender: TObject);
begin
  objMenuPrivate := TUMenu.create;
  objMenuPrivate.mostrarDadosBotaoDeAtalho(inttostr((Sender as TButton).Tag));

  objMenuPrivate.mostrarTelaPeloIndexDoModuloEDoMenu(
     objMenuPrivate.objQuery.FDQuery.FieldByName('DDM_CODMODULO_CODMENU').AsString);

  abrirForm;

  FreeAndNil(objMenuPrivate);

end;

procedure TfrmMenu.construirBotoesDeAtalho;
var
  botaoAtalho : TButton;
  objMenu : TUMenu;
  tryIcon : TIcon;
begin
  objMenu := TUMenu.create;
  tryIcon := TIcon.Create;

  objMenu.mostrarDadosBotaoDeAtalho('');
  objMenu.objQuery.FDQuery.First;

  while not objMenu.objQuery.FDQuery.Eof do
  begin
    botaoAtalho := TButton.Create(frmMenu);
    {Coloca ícone do botão de atalho}
    tryIcon.LoadFromFile(
      objMenu.objQuery.FDQuery.FieldByName('DDM_CAMINHO_ICONE').AsString);
    frmMenu.imgListaIconesBotaoAtalho.AddIcon(tryIcon);
    botaoAtalho.images := frmMenu.imgListaIconesBotaoAtalho;
    {FIM}

    botaoAtalho.ImageIndex :=
      objMenu.objQuery.FDQuery.FieldByName('DDBA_POSICAO').AsInteger;
    botaoAtalho.Name := 'btn' +
      objMenu.objQuery.FDQuery.FieldByName('DDM_CODIGO').AsString;
    botaoAtalho.tag := objMenu.objQuery.FDQuery.FieldByName('DDM_CODIGO').AsInteger;
    botaoAtalho.Width := 90;
    botaoAtalho.Caption := '';
    botaoAtalho.Parent := frmMenu.tooBotaoAtalho;
    botaoAtalho.Hint :=
      objMenu.objQuery.FDQuery.FieldByName('DDM_CAPTION').AsString;
    botaoAtalho.ShowHint := TRUE;
    botaoAtalho.ImageAlignment := iaCenter;

    if objAuxiliar.logadoComoADMSistema = true then
      botaoAtalho.PopupMenu := popBotaoAtalho;

    botaoAtalho.OnClick := clicarBotaoAtalho;
    botaoAtalho.OnMouseEnter := pegarNomeDoBotaoDeAtalho;

    objMenu.objQuery.FDQuery.Next;
  end;

  FreeAndNil(objMenu);
  FreeAndNil(tryIcon);

end;

procedure TfrmMenu.ConstruirMenu(Sender: Tobject);
begin
  inserirTelasEmCadaModulo(Sender as TObject);
  if objAuxiliar.logadoComoADMSistema = true then
  begin
    inserirCadastroDeFormsEmCadaModulo(Sender as TObject);
    inserirModuloBasico(Sender as TObject);
  end;
end;

procedure TfrmMenu.ctbMenuButtonClicked(Sender: TObject;
  const Button: TButtonItem);
begin
  if ctbmenu.CurrentCategory.Caption = 'CONFIGURAÇÃO' then
  begin
    if ctbmenu.SelectedItem.Index = 0 then
    begin
      if frmCadastroModuloClasse = nil then
      begin
        frmCadastroModuloClasse := TfrmCadastroModuloClasse.Create(nil);
        frmCadastroModuloClasse.Icon.LoadFromFile('Icones\modulo.ico');
        frmCadastroModuloClasse.Show;
      end
      else
      begin
        frmCadastroModuloClasse.WindowState := wsNormal;
        frmCadastroModuloClasse.BringToFront;
      end;
    end
    else if ctbmenu.SelectedItem.Index = 1 then
    begin
      if frmTabelaCampo = nil then
      begin
        frmTabelaCampo := TfrmTabelaCampo.Create(nil);
        frmTabelaCampo.Icon.LoadFromFile('Icones\tabela.ico');
        frmTabelaCampo.Show;
      end
      else
      begin
        frmTabelaCampo.WindowState := wsNormal;
        frmTabelaCampo.BringToFront;
      end;
    end;
  end
  else
  begin
    objMenuPrivate:= TUMenu.Create;
    objMenuPrivate.mostrarTelaPeloIndexDoModuloEDoMenu(
      inttostr(ctbMenu.CurrentCategory.Index) +
      inttostr(ctbMenu.CurrentCategory.Items[ctbMenu.SelectedItem.Index].Index));

    if objMenuPrivate.objQuery.FDQuery.FieldByName('DDM_CODIGO').AsString = '' then
    begin
      if frmCadastroForms = nil then
      begin
        frmCadastroForms := TfrmCadastroForms.Create(nil);
        frmCadastroForms.Icon.LoadFromFile('Icones\configuracao.ico');
        frmCadastroForms.Show;
      end
      else
      begin
        frmCadastroForms.LimpaCampos(Sender as TObject);
        frmCadastroForms.mostrarDadosDoRespectivoModuloSelecionado(Sender as TObject);
        frmCadastroForms.WindowState := wsNormal;
        frmCadastroForms.BringToFront;
      end;
    end
    else
    begin
      abrirForm;
    end;
    FreeAndNil(objMenuPrivate);
  end;
end;

procedure TfrmMenu.fecharModulos(Sender: TObject);
var
  i: integer;
begin
  i:=0;
  while i< ctbMenu.Categories.Count do
  begin
    ctbMenu.Categories.Items[i].Collapsed := true;
    i:= i + 1;
  end;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  Application.CreateForm(TfrmLogin, frmLogin);
  frmLogin.showmodal;
  objAuxiliar:= TAuxiliar.GetInstancia;
  ConstruirMenu(Sender as TObject);
  fecharModulos(Sender as TObject);
  construirBotoesDeAtalho;
end;

procedure TfrmMenu.inserirCadastroDeFormsEmCadaModulo(Sender: TObject);
var
  objMenu: TUMenu;
  btcCategoria: TButtonCategory;
  btiButtonItem: TButtonItem;
  tryIcon : TIcon;
begin
  objMenu:= TUMenu.create;
  tryIcon := TIcon.Create();

  objMenu.mostrarModulos;
  objMenu.objQuery.FDQuery.First;
  tryIcon.LoadFromFile('Icones\configuracao.ico');
  imgListaIconesMenu.AddIcon(tryIcon);

  while not objMenu.objQuery.FDQuery.Eof do
  begin
    btcCategoria:=
      ctbMenu.Categories.Items[
      objMenu.objQuery.FDQuery.FieldByName('DDMM_SEQUENCIA_MODULO').AsInteger];
    btiButtonItem:= btcCategoria.Items.Add;
    btiButtonItem.Caption:= 'Criação de tela';

    if objMenu.objQuery.FDQuery.FieldByName('SEQUENCIA_MENU').AsInteger >= 0 then
    begin
      if objMenu.objQuery.FDQuery.FieldByName('SEQUENCIA_MENU').AsInteger > 0 then
      begin
        btiButtonItem.Index :=
          objMenu.objQuery.FDQuery.FieldByName('SEQUENCIA_MENU').AsInteger + 1;
      end
      else
      begin
        if ctbMenu.Categories.Items[
          objMenu.objQuery.FDQuery.FieldByName('DDMM_SEQUENCIA_MODULO').AsInteger].Items.Count = 1 then
        begin
          btiButtonItem.Index :=
            objMenu.objQuery.FDQuery.FieldByName('SEQUENCIA_MENU').AsInteger;
        end
        else
        begin
          btiButtonItem.Index :=
            objMenu.objQuery.FDQuery.FieldByName('SEQUENCIA_MENU').AsInteger +1;
        end;
      end;
    end
    else
    begin
      btiButtonItem.Index := 0;
    end;

    {imageList começa com o index 0(zero) por isso foi colocado -1}
    btiButtonItem.ImageIndex := imgListaIconesMenu.Count -1;

    objMenu.objQuery.FDQuery.Next;
  end;


end;

procedure TfrmMenu.inserirModuloBasico(Sender: TObject);
var
  btcCategoria: TButtonCategory;
  btiButtonItem: TButtonItem;
  objMenu : TUMenu;
  tryIcon : TIcon;
begin
  btcCategoria:= ctbMenu.Categories.Add;
  tryIcon := TIcon.Create;
  objMenu := TUMenu.create;
  objMenu.mostrarModulos;
  objMenu.objQuery.FDQuery.Last;

  ctbMenu.Categories[
    objMenu.objQuery.FDQuery.FieldByName('DDMM_SEQUENCIA_MODULO').AsInteger + 1].Caption:=
    'CONFIGURAÇÃO';
  btcCategoria.Color := $00FFD2D2;
  
  btiButtonItem:= btcCategoria.Items.Add;
  btiButtonItem.Caption:= 'Modulos';
  btiButtonItem.Index := 0;
  btiButtonItem.CategoryButtons.Font.Size := 10;
  tryIcon.LoadFromFile('Icones\modulo.ico');
  imgListaIconesMenu.AddIcon(tryIcon);
  btiButtonItem.ImageIndex := imgListaIconesMenu.Count -1;

  btiButtonItem:= btcCategoria.Items.Add;
  btiButtonItem.Caption:= 'Tabelas/Campos';
  btiButtonItem.Index := 1;
  btiButtonItem.CategoryButtons.Font.Size := 10;
  tryIcon.LoadFromFile('Icones\tabela.ico');
  imgListaIconesMenu.AddIcon(tryIcon);
  btiButtonItem.ImageIndex := imgListaIconesMenu.Count -1;
end;

procedure TfrmMenu.inserirTelasEmCadaModulo(Sender: TObject);
var
  objMenu: TUMenu;
  btcCategoria: TButtonCategory;
  btiButtonItem: TButtonItem;
  iModulo, iIndexImg: integer;
  tryIcon : TIcon;
begin

  tryIcon := TIcon.Create();
  objMenu:= TUMenu.create;
  objMenu.mostrarTodasAsTelas;
  objMenu.objQuery.FDQuery.First;

  iModulo := objMenu.objQuery.FDQuery.FieldByName('DDMM_SEQUENCIA_MODULO').AsInteger;
  btcCategoria:= ctbMenu.Categories.Add;

  btcCategoria.Color := $00FFD2D2;

  ctbMenu.Categories[iModulo].Caption:=
    objMenu.objQuery.FDQuery.FieldByName('DDMM_DESCRICAO').AsString;
  iIndexImg := 0;
  while not objMenu.objQuery.FDQuery.Eof do
  begin
    if iModulo = objMenu.objQuery.FDQuery.FieldByName('DDMM_SEQUENCIA_MODULO').AsInteger then
    begin
      if objMenu.objQuery.FDQuery.FieldByName('DDM_CAPTION').AsString <> '' then
      begin
        btiButtonItem:= btcCategoria.Items.Add;
        btiButtonItem.CategoryButtons.Font.Size := 10;
        btiButtonItem.Caption:= objMenu.objQuery.FDQuery.FieldByName('DDM_CAPTION').AsString;
        btiButtonItem.Index := objMenu.objQuery.FDQuery.FieldByName('DDM_SEQUENCIA_MENU').AsInteger;
      end;

      if objMenu.objQuery.FDQuery.FieldByName('DDM_CAMINHO_ICONE').AsString <> '' then
      begin
        tryIcon.LoadFromFile(
          objMenu.objQuery.FDQuery.FieldByName('DDM_CAMINHO_ICONE').AsString);

        imgListaIconesMenu.AddIcon(tryIcon);
        btiButtonItem.ImageIndex := iIndexImg;
        iIndexImg := iIndexImg +1;
      end;
    end
    else
    begin
      btcCategoria:= ctbMenu.Categories.Add;

      btcCategoria.Color := $00FFD2D2;

      ctbMenu.Categories[objMenu.objQuery.FDQuery.FieldByName('DDMM_SEQUENCIA_MODULO').AsInteger].Caption:=
        objMenu.objQuery.FDQuery.FieldByName('DDMM_DESCRICAO').AsString;

      if objMenu.objQuery.FDQuery.FieldByName('DDM_CAPTION').AsString <> '' then
      begin
        btiButtonItem:= btcCategoria.Items.Add;
        btiButtonItem.Caption:= objMenu.objQuery.FDQuery.FieldByName('DDM_CAPTION').AsString;
        btiButtonItem.Index := objMenu.objQuery.FDQuery.FieldByName('DDM_SEQUENCIA_MENU').AsInteger;
      end;

      if objMenu.objQuery.FDQuery.FieldByName('DDM_CAMINHO_ICONE').AsString <> '' then
      begin
        tryIcon.LoadFromFile(
          objMenu.objQuery.FDQuery.FieldByName('DDM_CAMINHO_ICONE').AsString);

        imgListaIconesMenu.AddIcon(tryIcon);
        btiButtonItem.ImageIndex := iIndexImg;
        iIndexImg := iIndexImg +1;
      end;
      iModulo := objMenu.objQuery.FDQuery.FieldByName('DDMM_SEQUENCIA_MODULO').AsInteger;
    end;
    objMenu.objQuery.FDQuery.Next;
  end;

  FreeAndNil(objMenu);

end;

procedure TfrmMenu.pegarNomeDoBotaoDeAtalho(Sender: TObject);
begin
  botaoAtalhoPrivate := (sender as TButton).Name;
end;

procedure TfrmMenu.popItemAbrirmdulosClick(Sender: TObject);
begin
  abrirModulos(Sender as TObject);
end;

procedure TfrmMenu.popItemExcluirBoto1Click(Sender: TObject);
var
  botaoAtalho: TButton;
  objMenu : TUMenu;
begin
  objMenu := TUMenu.create;
  botaoAtalho:= TButton(FindComponent(botaoAtalhoPrivate));
  if objMenu.excluirBotaoDeAtalhoEReordenalo(inttostr(botaoAtalho.Tag)) = 'Erro' then
     Application.MessageBox(Pchar('Erro na exclusão '+
      ' do botão de atalho '), 'Erro!',
      MB_OK+MB_ICONERROR + MB_TOPMOST);

  FreeAndNil(botaoAtalho);
  FreeAndNil(objMenu);
end;

procedure TfrmMenu.popItemFecharmdulosClick(Sender: TObject);
begin
  fecharModulos(Sender as TObject);
end;

end.
