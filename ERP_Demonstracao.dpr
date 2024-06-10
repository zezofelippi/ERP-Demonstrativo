program ERP_Demonstracao;

uses
  Vcl.Forms,
  untMenu in 'Estrutura de Montagem do Sistema\untMenu.pas' {frmMenu},
  untCadastroModuloClasse in 'Estrutura de Montagem do Sistema\untCadastroModuloClasse.pas' {frmCadastroModuloClasse},
  uConexao in 'Units-Classes Padrão e Montagem de Sistema\Banco de Dados\uConexao.pas',
  uFDQuery in 'Units-Classes Padrão e Montagem de Sistema\Banco de Dados\uFDQuery.pas',
  uTabelaCampos in 'Units-Classes Padrão e Montagem de Sistema\Tabelas e Campos\uTabelaCampos.pas',
  untTabelaCampo in 'Estrutura de Montagem do Sistema\untTabelaCampo.pas' {frmTabelaCampo},
  uMenu in 'Units-Classes Padrão e Montagem de Sistema\Menu\uMenu.pas',
  untCadastroForm in 'Estrutura de Montagem do Sistema\untCadastroForm.pas' {frmCadastroForms},
  uModulosClasses in 'Units-Classes Padrão e Montagem de Sistema\Modulos e classes\uModulosClasses.pas',
  untBase in 'Estrutura Padrão\untBase.pas' {frmBase},
  untCadastroCompleto in 'Estrutura Padrão\untCadastroCompleto.pas' {frmCadastroCompleto},
  untCadastrarGroupBox in 'Estrutura de Montagem do Sistema\untCadastrarGroupBox.pas' {frmCadastrarGroupBox},
  untBaseCadastro in 'Estrutura Padrão\untBaseCadastro.pas' {frmBaseCadastro},
  untCadastrarPageControl in 'Estrutura de Montagem do Sistema\untCadastrarPageControl.pas' {frmCadastrarPageControl},
  uComponentePageControl in 'Units-Classes Padrão e Montagem de Sistema\Componentes\uComponentePageControl.pas',
  uAuxiliar in 'Units-Classes Padrão e Montagem de Sistema\Auxiliar\uAuxiliar.pas',
  uComponenteGroupBox in 'Units-Classes Padrão e Montagem de Sistema\Componentes\uComponenteGroupBox.pas',
  untInserirCampo in 'Estrutura de Montagem do Sistema\untInserirCampo.pas' {frmInserirCampo},
  uComponenteDataControlsStandard in 'Units-Classes Padrão e Montagem de Sistema\Componentes\uComponenteDataControlsStandard.pas',
  uInserirCampos in 'Units-Classes Padrão e Montagem de Sistema\Inserir campo\uInserirCampos.pas',
  untBasePesquisa in 'Estrutura Padrão\untBasePesquisa.pas' {frmBasePesquisa},
  uComponenteStandard in 'Units-Classes Padrão e Montagem de Sistema\Componentes\uComponenteStandard.pas',
  uComponenteDBGrid in 'Units-Classes Padrão e Montagem de Sistema\Componentes\uComponenteDBGrid.pas',
  uPesquisa in 'Units-Classes Padrão e Montagem de Sistema\Pesquisa\uPesquisa.pas',
  untLogin in 'Estrutura de Montagem do Sistema\untLogin.pas' {frmLogin},
  untPesquisaConvencional in 'Estrutura Padrão\untPesquisaConvencional.pas' {frmPesquisaConvencional},
  untPesquisarCadastrar in 'Estrutura Padrão\untPesquisarCadastrar.pas' {frmPesquisarCadastrar},
  uPesquisarCadastrar in 'Units-Classes Padrão e Montagem de Sistema\Pesquisar e Cadastrar\uPesquisarCadastrar.pas',
  untCadastroProduto in 'Estrutura Padrão\Estrutura Específica\untCadastroProduto.pas' {frmCadastroProduto},
  untCadastroProdutoMadeireira in 'Estrutura Padrão\Estrutura Específica\Forms\Varejo\Madeireira\untCadastroProdutoMadeireira.pas' {frmCadastroProdutoMadeireira},
  untCadastroCliente in 'Estrutura Padrão\Estrutura Específica\untCadastroCliente.pas' {frmCadastroCliente},
  uCliente in 'Estrutura Padrão\Estrutura Específica\Units - Classes Específicas\Cliente\uCliente.pas',
  uMadeireiraCalculoVolume in 'Estrutura Padrão\Estrutura Específica\Forms\Varejo\Madeireira\Units - Classes\uMadeireiraCalculoVolume.pas',
  uCalculoProduto in 'Estrutura Padrão\Estrutura Específica\Units - Classes Específicas\Produto\uCalculoProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
