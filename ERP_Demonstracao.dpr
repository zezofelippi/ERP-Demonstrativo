program ERP_Demonstracao;

uses
  Vcl.Forms,
  untMenu in 'Estrutura de Montagem do Sistema\untMenu.pas' {frmMenu},
  untCadastroModuloClasse in 'Estrutura de Montagem do Sistema\untCadastroModuloClasse.pas' {frmCadastroModuloClasse},
  uConexao in 'Units-Classes Padr�o e Montagem de Sistema\Banco de Dados\uConexao.pas',
  uFDQuery in 'Units-Classes Padr�o e Montagem de Sistema\Banco de Dados\uFDQuery.pas',
  uTabelaCampos in 'Units-Classes Padr�o e Montagem de Sistema\Tabelas e Campos\uTabelaCampos.pas',
  untTabelaCampo in 'Estrutura de Montagem do Sistema\untTabelaCampo.pas' {frmTabelaCampo},
  uMenu in 'Units-Classes Padr�o e Montagem de Sistema\Menu\uMenu.pas',
  untCadastroForm in 'Estrutura de Montagem do Sistema\untCadastroForm.pas' {frmCadastroForms},
  uModulosClasses in 'Units-Classes Padr�o e Montagem de Sistema\Modulos e classes\uModulosClasses.pas',
  untBase in 'Estrutura Padr�o\untBase.pas' {frmBase},
  untCadastroCompleto in 'Estrutura Padr�o\untCadastroCompleto.pas' {frmCadastroCompleto},
  untCadastrarGroupBox in 'Estrutura de Montagem do Sistema\untCadastrarGroupBox.pas' {frmCadastrarGroupBox},
  untBaseCadastro in 'Estrutura Padr�o\untBaseCadastro.pas' {frmBaseCadastro},
  untCadastrarPageControl in 'Estrutura de Montagem do Sistema\untCadastrarPageControl.pas' {frmCadastrarPageControl},
  uComponentePageControl in 'Units-Classes Padr�o e Montagem de Sistema\Componentes\uComponentePageControl.pas',
  uAuxiliar in 'Units-Classes Padr�o e Montagem de Sistema\Auxiliar\uAuxiliar.pas',
  uComponenteGroupBox in 'Units-Classes Padr�o e Montagem de Sistema\Componentes\uComponenteGroupBox.pas',
  untInserirCampo in 'Estrutura de Montagem do Sistema\untInserirCampo.pas' {frmInserirCampo},
  uComponenteDataControlsStandard in 'Units-Classes Padr�o e Montagem de Sistema\Componentes\uComponenteDataControlsStandard.pas',
  uInserirCampos in 'Units-Classes Padr�o e Montagem de Sistema\Inserir campo\uInserirCampos.pas',
  untBasePesquisa in 'Estrutura Padr�o\untBasePesquisa.pas' {frmBasePesquisa},
  uComponenteStandard in 'Units-Classes Padr�o e Montagem de Sistema\Componentes\uComponenteStandard.pas',
  uComponenteDBGrid in 'Units-Classes Padr�o e Montagem de Sistema\Componentes\uComponenteDBGrid.pas',
  uPesquisa in 'Units-Classes Padr�o e Montagem de Sistema\Pesquisa\uPesquisa.pas',
  untLogin in 'Estrutura de Montagem do Sistema\untLogin.pas' {frmLogin},
  untPesquisaConvencional in 'Estrutura Padr�o\untPesquisaConvencional.pas' {frmPesquisaConvencional},
  untPesquisarCadastrar in 'Estrutura Padr�o\untPesquisarCadastrar.pas' {frmPesquisarCadastrar},
  uPesquisarCadastrar in 'Units-Classes Padr�o e Montagem de Sistema\Pesquisar e Cadastrar\uPesquisarCadastrar.pas',
  untCadastroProduto in 'Estrutura Padr�o\Estrutura Espec�fica\untCadastroProduto.pas' {frmCadastroProduto},
  untCadastroProdutoMadeireira in 'Estrutura Padr�o\Estrutura Espec�fica\Forms\Varejo\Madeireira\untCadastroProdutoMadeireira.pas' {frmCadastroProdutoMadeireira},
  untCadastroCliente in 'Estrutura Padr�o\Estrutura Espec�fica\untCadastroCliente.pas' {frmCadastroCliente},
  uCliente in 'Estrutura Padr�o\Estrutura Espec�fica\Units - Classes Espec�ficas\Cliente\uCliente.pas',
  uMadeireiraCalculoVolume in 'Estrutura Padr�o\Estrutura Espec�fica\Forms\Varejo\Madeireira\Units - Classes\uMadeireiraCalculoVolume.pas',
  uCalculoProduto in 'Estrutura Padr�o\Estrutura Espec�fica\Units - Classes Espec�ficas\Produto\uCalculoProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
