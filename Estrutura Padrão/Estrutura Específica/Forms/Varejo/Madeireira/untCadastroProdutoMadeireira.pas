unit untCadastroProdutoMadeireira;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untCadastroProduto, Vcl.Menus,
  Vcl.ExtCtrls, Vcl.ImgList, JvExControls, JvButton, JvNavigationPane,
  Vcl.StdCtrls, JvDBControls, uMadeireiraCalculoVolume;

type
  TfrmCadastroProdutoMadeireira = class(TfrmCadastroProduto)
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    procedure exitCampo(Sender: TObject); override;
    procedure limparDados;
  public
    { Public declarations }
  end;

var
  frmCadastroProdutoMadeireira: TfrmCadastroProdutoMadeireira;

implementation

{$R *.dfm}

{ TfrmCadastroProdutoMadeireira }

procedure TfrmCadastroProdutoMadeireira.btnCancelarClick(Sender: TObject);
begin
  inherited;
  limparDados;
end;

procedure TfrmCadastroProdutoMadeireira.btnGravarClick(Sender: TObject);
begin
  inherited;
  limparDados;
end;

procedure TfrmCadastroProdutoMadeireira.btnNovoClick(Sender: TObject);
begin
  inherited;
  cdsCadastro.FieldByName('Volume_PRODUTO').AsFloat:= 0;
end;

procedure TfrmCadastroProdutoMadeireira.exitCampo(Sender: TObject);
begin
  inherited;
  if calcDBEdit.Name = 'dbEdtEspessura_PRODUTO' then
  begin
    TMadeireiraCalculoVolume.setEspessura(calcDBEdit.Value);
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtVolume_PRODUTO'));
    calcDBEdit.Value:= TMadeireiraCalculoVolume.calcularVolume();
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtEspessura_PRODUTO'));
  end
  else if calcDBEdit.Name = 'dbEdtLargura_PRODUTO' then
  begin
    TMadeireiraCalculoVolume.setLargura(calcDBEdit.Value);
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtVolume_PRODUTO'));
    calcDBEdit.Value:= TMadeireiraCalculoVolume.calcularVolume();
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtLargura_PRODUTO'))
  end
  else if calcDBEdit.Name = 'dbEdtComprimento_PRODUTO' then
  begin
    TMadeireiraCalculoVolume.setComprimento(calcDBEdit.Value);
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtVolume_PRODUTO'));
    calcDBEdit.Value:= TMadeireiraCalculoVolume.calcularVolume();
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtComprimento_PRODUTO'));
  end;
end;

procedure TfrmCadastroProdutoMadeireira.limparDados;
begin
  TMadeireiraCalculoVolume.setEspessura(0);
  TMadeireiraCalculoVolume.setLargura(0);
  TMadeireiraCalculoVolume.setComprimento(0);
end;

initialization
  RegisterClass(TfrmCadastroProdutoMadeireira);

end.
