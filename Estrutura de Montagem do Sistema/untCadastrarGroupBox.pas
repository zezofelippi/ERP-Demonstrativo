unit untCadastrarGroupBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untBase, JvExControls, JvButton,
  JvNavigationPane, Vcl.StdCtrls, uComponenteGroupBox, uAuxiliar, Vcl.Menus;

type
  TfrmCadastrarGroupBox = class(TfrmBase)
    lbl2: TLabel;
    edtNomeTela: TEdit;
    btnGravar: TJvNavPanelButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    objAuxiliar : TAuxiliar;
  public
    codigoGroupBox: string;
    codigoTabSheet, codigoMenu: string;
    { Public declarations }
  end;

var
  frmCadastrarGroupBox: TfrmCadastrarGroupBox;

implementation

{$R *.dfm}

procedure TfrmCadastrarGroupBox.btnGravarClick(Sender: TObject);
var
  objGroupBox: TComponenteGroupBox;

begin
  objGroupBox:= TComponenteGroupBox.Create;
  objAuxiliar := TAuxiliar.GetInstancia;

  if btnGravar.Tag = 0 then
  begin
    if objGroupBox.cadastrarGroupBox(codigoMenu,
      codigoTabSheet, edtNomeTela.Text, 20, 20, 50, 50) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro no cadastro '+
        'do GroupBox.'), 'Erro!',
        MB_OK+MB_ICONERROR + MB_TOPMOST);
    end;
  end
  else if btnGravar.Tag = 1 then
  begin
    if objGroupBox.alterarCaptionGroupBox(
      codigoGroupBox, edtNomeTela.Text) = 'Erro' then
    begin
      Application.MessageBox(Pchar('Erro no cadastro '+
        'do GroupBox.'), 'Erro!',
        MB_OK+MB_ICONERROR + MB_TOPMOST);
    end;
  end;
  FreeAndNil(objGroupBox);
  objAuxiliar := TAuxiliar.GetInstancia;
  objAuxiliar.recriarComponentes := true;
  if objAuxiliar.remetentePesquisarCadastrar = true then
  begin
    objAuxiliar.criarGroupBoxPesquisarCadastrar:= true;
    objAuxiliar.remetentePesquisarCadastrar := false;
  end;

  close;
end;

procedure TfrmCadastrarGroupBox.FormCreate(Sender: TObject);
begin
  width := 500;
  Height := 100;

end;

end.
