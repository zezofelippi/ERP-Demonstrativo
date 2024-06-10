unit untCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untCadastroCompleto, Vcl.Menus,
  Vcl.ExtCtrls, Vcl.ImgList, JvExControls, JvButton, JvNavigationPane,
  Vcl.StdCtrls, JvExMask, JvToolEdit, JvDBControls, Vcl.Mask, JvBaseEdits,
  FireDAC.Stan.Intf, FireDAC.Comp.Client, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  {FireDAC.Phys.MySQLDef,} FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, uCalculoProduto;

type
  TfrmCadastroProduto = class(TfrmCadastroCompleto)
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  protected
    { Private declarations }
    procedure exitCampo(Sender: TObject); override;
  public
    { Public declarations }
  private
    procedure limparDados;
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

{$R *.dfm}

{ TfrmCadastroProduto }

procedure TfrmCadastroProduto.btnCancelarClick(Sender: TObject);
begin
  inherited;
  limparDados;
end;

procedure TfrmCadastroProduto.btnGravarClick(Sender: TObject);
begin
  inherited;
  limparDados;
end;

procedure TfrmCadastroProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  cdsCadastro.FieldByName('Lucro_PRODUTO').AsFloat:= 0;
end;

procedure TfrmCadastroProduto.exitCampo(Sender: TObject);
begin
  inherited;
  if calcDBEdit.Name = 'dbEdtPrecodecusto_PRODUTO' then
  begin
    TCalculoProduto.setCusto(calcDBEdit.Value);
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtLucro_PRODUTO'));
    calcDBEdit.Value:= TCalculoProduto.calcularLucro;
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtPrecodecusto_PRODUTO'));
  end
  else if calcDBEdit.Name = 'dbEdtPrecodevenda_PRODUTO' then
  begin
    TCalculoProduto.setVenda(calcDBEdit.Value);
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtLucro_PRODUTO'));
    calcDBEdit.Value:=TCalculoProduto.calcularLucro;
    calcDBEdit := TJvDBCalcEdit(findComponent('dbEdtPrecodevenda_PRODUTO'));
  end;

end;

procedure TfrmCadastroProduto.limparDados;
begin
  TCalculoProduto.setVenda(0);
  TCalculoProduto.setCusto(0);
end;

initialization
  RegisterClass(TfrmCadastroProduto);


end.
