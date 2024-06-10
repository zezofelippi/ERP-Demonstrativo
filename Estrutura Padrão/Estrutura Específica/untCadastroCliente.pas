unit untCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untCadastroCompleto, Vcl.Menus,
  Vcl.ExtCtrls, Vcl.ImgList, JvExControls, JvButton, JvNavigationPane,
  Vcl.StdCtrls, uCliente, Data.DB, Datasnap.DBClient, Datasnap.Provider,
  Vcl.DBCtrls;

type
  TfrmCadastroCliente = class(TfrmCadastroCompleto)
  protected
    { Private declarations }
    procedure exitCampo(Sender: TObject); override;
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

{ TfrmCadastroCompletoCliente }

procedure TfrmCadastroCliente.exitCampo(Sender: TObject);
var
  objCliente: TCliente;
begin
  inherited;
  if compComboBox <> nil then
  begin
    if compComboBox.Name = 'dbEdtidestado_ESTADO_C' then
    begin
      if compComboBox.Text = '' then
        exit;

      objCliente:= TCliente.create;
      objCliente.pesquisarCidades(compComboBox.KeyValue);

      dspComboBox := TDataSetProvider(FindComponent('dsp' + self.Name + 'CIDADE'));
      dspComboBox.DataSet := objCliente.objQuery.FDQuery;

      cdsComboBox := TClientDataSet(FindComponent('cds' + self.Name + 'CIDADE'));
      cdsComboBox.ProviderName := dspComboBox.Name;

      dtsComboBox := TDataSource(FindComponent('dts' + self.Name + 'CIDADE'));
      dtsComboBox.DataSet := cdsComboBox;

      cdsComboBox.Close;
      cdsComboBox.FetchParams;
      cdsComboBox.Open;

      compComboBox := TDBLookupComboBox(FindComponent('dbEdtidcidade_CIDADE_C'));

      compComboBox.ListSource := dtsComboBox;

      compComboBox := TDBLookupComboBox(FindComponent('dbEdtidestado_ESTADO_C'));

      FreeAndNil(objCliente);
    end;
  end;

end;

initialization
  RegisterClass(TfrmCadastroCliente);

end.
