object frmTabelaCampo: TfrmTabelaCampo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Tabela e Campo'
  ClientHeight = 444
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcBancoDados: TPageControl
    Left = 0
    Top = 0
    Width = 900
    Height = 444
    ActivePage = tshCriacaoCampos
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object tshCriacaoTabelas: TTabSheet
      Caption = 'Tabelas/Chave prim'#225'ria/Chave estrangeira'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object rpb1: TGroupBox
        Left = 0
        Top = 0
        Width = 892
        Height = 81
        Align = alTop
        Caption = 'Criar tabela/chave prim'#225'ria'
        Color = 15066597
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        object lbl1: TLabel
          Left = 4
          Top = 25
          Width = 247
          Height = 18
          AutoSize = False
          Caption = 'Nome da tabela'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object lbl9: TLabel
          Left = 258
          Top = 25
          Width = 248
          Height = 18
          AutoSize = False
          Caption = 'Nome do campo chave'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object btnGravarTabelas: TJvNavPanelButton
          Left = 512
          Top = 25
          Width = 164
          Height = 43
          Alignment = taCenter
          Caption = 'Gravar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -21
          HotTrackFont.Name = 'Tahoma'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          Colors.ButtonColorFrom = clWhite
          Colors.ButtonColorTo = clWhite
          Colors.ButtonHotColorFrom = 16771818
          Colors.ButtonHotColorTo = 16771818
          Colors.ButtonSelectedColorTo = 16771818
          ImageIndex = 0
          OnClick = btnGravarTabelasClick
        end
        object edtNomeTabela: TEdit
          Left = 3
          Top = 47
          Width = 247
          Height = 21
          BorderStyle = bsNone
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnEnter = edtNomeTabelaEnter
          OnExit = edtNomeTabelaExit
          OnKeyPress = edtNomeTabelaKeyPress
        end
        object edtCampoChave: TEdit
          Left = 256
          Top = 47
          Width = 250
          Height = 21
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnEnter = edtCampoChaveEnter
          OnExit = edtCampoChaveExit
          OnKeyPress = edtCampoChaveKeyPress
        end
      end
      object rpb2: TGroupBox
        Left = 0
        Top = 81
        Width = 892
        Height = 295
        Align = alTop
        Caption = 'Criar chave estrangeira'
        Color = 15066597
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        object imgIcone: TImage
          Left = 356
          Top = 13
          Width = 40
          Height = 19
          Visible = False
        end
        object lbl10: TLabel
          Left = 5
          Top = 38
          Width = 232
          Height = 18
          AutoSize = False
          Caption = 'Nome da tabela'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object lbl11: TLabel
          Left = 6
          Top = 91
          Width = 231
          Height = 18
          AutoSize = False
          Caption = 'Chave estrangeira'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object btnInserirTabRel: TJvNavPanelButton
          Left = 6
          Top = 197
          Width = 231
          Height = 43
          Alignment = taCenter
          Caption = 'Gravar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -21
          HotTrackFont.Name = 'Tahoma'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          Colors.ButtonColorFrom = clWhite
          Colors.ButtonColorTo = clWhite
          Colors.ButtonHotColorFrom = 16771818
          Colors.ButtonHotColorTo = 16771818
          Colors.ButtonSelectedColorTo = 16771818
          ImageIndex = 0
          OnClick = btnInserirTabRelClick
        end
        object rdgChaveEstrangeiraObrigatoria: TRadioGroup
          Left = 6
          Top = 147
          Width = 231
          Height = 44
          Caption = 'Chave estrangeira obrigat'#243'ria?'
          Columns = 2
          Items.Strings = (
            'Sim'
            'N'#227'o')
          TabOrder = 0
        end
        object grdTabelasRelacionadas: TDBGrid
          Left = 243
          Top = 38
          Width = 551
          Height = 202
          DrawingStyle = gdsClassic
          FixedColor = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grdTabelasRelacionadasDrawColumnCell
          Columns = <
            item
              Expanded = False
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -15
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 20
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = 'Tabela'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -15
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 220
              Visible = True
            end
            item
              Expanded = False
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -15
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 20
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = 'Chave estrangeira'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -15
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 220
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = '*'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -15
              Title.Font.Name = 'Tahoma'
              Title.Font.Style = [fsBold]
              Width = 20
              Visible = True
            end>
        end
        object cboTabelas: TDBLookupComboBox
          Left = 5
          Top = 56
          Width = 232
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnCloseUp = cboTabelasCloseUp
          OnEnter = cboTabelasEnter
          OnExit = cboTabelasExit
          OnKeyDown = cboTabelasKeyDown
          OnKeyUp = cboTabelasKeyUp
        end
        object cboTabelasRelacionadas: TDBLookupComboBox
          Left = 6
          Top = 110
          Width = 231
          Height = 26
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnEnter = cboTabelasRelacionadasEnter
          OnExit = cboTabelasRelacionadasExit
        end
      end
    end
    object tshCriacaoCampos: TTabSheet
      Caption = 'Cria'#231#227'o dos campos'
      object rpbDadosGerais: TGroupBox
        Left = 0
        Top = 0
        Width = 892
        Height = 196
        Align = alTop
        Color = 15066597
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        object lbl2: TLabel
          Left = 10
          Top = 11
          Width = 228
          Height = 18
          AutoSize = False
          Caption = 'Nome da tabela'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object lbl3: TLabel
          Left = 10
          Top = 75
          Width = 228
          Height = 18
          AutoSize = False
          Caption = 'Nome do campo'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object lbl4: TLabel
          Left = 246
          Top = 75
          Width = 521
          Height = 18
          AutoSize = False
          Caption = 'Descri'#231#227'o sobre o campo'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object lbl5: TLabel
          Left = 10
          Top = 130
          Width = 228
          Height = 18
          AutoSize = False
          Caption = 'Formato do campo'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object btnGravarCampo: TJvNavPanelButton
          Left = 415
          Top = 130
          Width = 164
          Height = 43
          Alignment = taCenter
          Caption = 'Gravar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -21
          HotTrackFont.Name = 'Tahoma'
          HotTrackFont.Style = [fsBold]
          ParentFont = False
          Colors.ButtonColorFrom = clWhite
          Colors.ButtonColorTo = clWhite
          Colors.ButtonHotColorFrom = 16771818
          Colors.ButtonHotColorTo = 16771818
          Colors.ButtonSelectedColorTo = 16771818
          ImageIndex = 0
          OnClick = btnGravarCampoClick
        end
        object rdgCampoObrigatorio: TRadioGroup
          Left = 252
          Top = 130
          Width = 157
          Height = 44
          Caption = 'Campo obrigat'#243'rio'
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          Items.Strings = (
            'Sim'
            'N'#227'o')
          ParentFont = False
          TabOrder = 0
        end
        object cboTabelaCampo: TDBLookupComboBox
          Left = 10
          Top = 30
          Width = 228
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnCloseUp = cboTabelaCampoCloseUp
          OnEnter = cboTabelaCampoEnter
          OnExit = cboTabelaCampoExit
          OnKeyPress = cboTabelaCampoKeyPress
          OnKeyUp = cboTabelaCampoKeyUp
        end
        object edtNomeCampo: TEdit
          Left = 10
          Top = 95
          Width = 228
          Height = 21
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = edtNomeCampoChange
          OnEnter = edtNomeCampoEnter
          OnExit = edtNomeCampoExit
          OnKeyPress = edtNomeCampoKeyPress
        end
        object edtDescricaoCampo: TEdit
          Left = 246
          Top = 95
          Width = 523
          Height = 21
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = edtDescricaoCampoChange
          OnEnter = edtDescricaoCampoEnter
          OnExit = edtDescricaoCampoExit
          OnKeyPress = edtDescricaoCampoKeyPress
        end
        object cboFormatoCampo: TDBLookupComboBox
          Left = 9
          Top = 150
          Width = 229
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnEnter = cboFormatoCampoEnter
          OnExit = cboFormatoCampoExit
        end
      end
      object grdCampos: TDBGrid
        Left = 0
        Top = 196
        Width = 892
        Height = 217
        Align = alClient
        DrawingStyle = gdsClassic
        FixedColor = 4868646
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        PopupMenu = popCampo
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = grdCamposDrawColumnCell
        OnTitleClick = grdCamposTitleClick
        Columns = <
          item
            Expanded = False
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Width = 20
            Visible = True
          end
          item
            Expanded = False
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            Title.Alignment = taCenter
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWhite
            Title.Font.Height = -15
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end>
      end
    end
    object tshModelagemBD: TTabSheet
      Caption = 'Modelagem do banco de dados'
      ImageIndex = 2
      object rpb3: TGroupBox
        Left = 0
        Top = 65
        Width = 892
        Height = 348
        Align = alClient
        TabOrder = 0
        object tvTabelas: TTreeView
          Left = 2
          Top = 18
          Width = 888
          Height = 328
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          HideSelection = False
          Images = imgIconesLista
          Indent = 19
          ParentFont = False
          ParentShowHint = False
          PopupMenu = popAbrirFechar
          ShowHint = False
          TabOrder = 0
          OnCustomDrawItem = tvTabelasCustomDrawItem
          OnGetImageIndex = tvTabelasGetImageIndex
          OnGetSelectedIndex = tvTabelasGetSelectedIndex
        end
      end
      object rpb4: TGroupBox
        Left = 0
        Top = 0
        Width = 892
        Height = 65
        Align = alTop
        Color = 15066597
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        object lbl6: TLabel
          Left = 13
          Top = 12
          Width = 253
          Height = 18
          AutoSize = False
          Caption = 'Nome da tabela'
          Color = 4868646
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object cboTabelaModelagem: TDBLookupComboBox
          Left = 2
          Top = 35
          Width = 252
          Height = 24
          Color = clWhite
          TabOrder = 0
          OnCloseUp = cboTabelaModelagemCloseUp
          OnEnter = cboTabelaModelagemEnter
          OnExit = cboTabelaModelagemExit
          OnKeyUp = cboTabelaModelagemKeyUp
        end
      end
    end
  end
  object popAbrirFechar: TPopupMenu
    Left = 628
    Top = 289
    object Abrirrvore1: TMenuItem
      Caption = 'Abrir '#225'rvore'
      OnClick = Abrirrvore1Click
    end
    object Fecharrvore1: TMenuItem
      Caption = 'Fechar '#225'rvore'
      OnClick = Fecharrvore1Click
    end
  end
  object imgIconesLista: TImageList
    Left = 556
    Top = 209
    Bitmap = {
      494C0101040008006C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B0B0B00222222002020
      20001E1E1E001B1B1B001919190016161600121212000F0F0F000B0B0B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000030303000B0B0B00151515001C1C
      1C0022222200232323003030300030303000303030002D2D2D00222222002222
      2200171717000F0F0F0006060600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000044444400F8F8F800F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F6F600F5F3F200EDEBEB00F7F6
      F600F8F8F8003C3C3C0000000000000000000000000000000000000000000000
      00000000000000000000000000002A91D9000000000000000000000000000000
      000000000000000000000000000000000000212121003F3F3F00515151006161
      6100676767007171710071717100717171007171710071717100848484009696
      96005E5E5E004B4B4B0031313100060606000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003E3E3E00EFEFEF00F0F0
      F000DEDEDE00F1F1F100E1E1E100F1F1F100E9E9E900F3F2F200F3F0F000EDEB
      EB00F6F6F600E7E7E70000000000000000000000000000000000000000000000
      000000000000000000002B80B20039ABF000074F9B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000032323200CFCFCF00C3C3
      C300B4B4B4002929290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000038383800E0E0E000E0E0
      E000DCDCDC00E0E0E000DCDCDC00E0E0E000DDDDDD00E1E1E100E2E1E100E1E0
      DF00DDDBDB00F4F4F40000000000000000000000000000000000000000000000
      000000000000000000002D83B20049C1F4000114260000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DFDFDF00CCCCCC00BEBE
      BE00AEAEAE008181810000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000032323200ECECEC00ECEC
      EC00DBDBDB00ECECEC00DDDDDD00EDEDED00E5E5E500EFEFEF00F0F0F000F0F0
      F000F1EFEF00EFEDED0000000000000000000000000000000000000000000000
      000000000000000000003D8BB30064C9F500073F750000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000019191900D1D1D100C7C7C700B8B8
      B800010101000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002E2E2E00E2E2E200E2E2
      E200D8D8D800E3E3E300D9D9D900E3E3E300DEDEDE00E4E4E400E5E5E500E6E6
      E600E7E7E700F4F2F20000000000000000000000000000000000000000000000
      000000000000000000003A8BB30052C4F4000A50910000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECECE00CECECE00C2C2C200B2B2
      B2002A2A2A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002D2D2D00E8E8E800E8E8
      E800D8D8D800E9E9E900DADADA00E9E9E900E1E1E100EBEBEB00ECECEC00EDED
      ED00EEEEEE00F3F3F30000000000000000000000000000000000000000000000
      00000000000000000000318BB70042BFF2000949850000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000010100007F6220009F7B29006E551B00CEC9BF00CBCBCB00BDBDBD003838
      3800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002B2B2B00E7E7E700E7E7
      E700D7D7D700E7E7E700D9D9D900E8E8E800E0E0E000E9E9E900EAEAEA00EBEB
      EB00ECECEC00F2F2F20000000000000000000000000000000000000000000000
      000000000000000000002E8CBA003DB8EF000E61A90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000A07
      0200A5802E00A27E2C009F7B29009F7B29009F7B29009F7B2900A99669000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029292900DFDFDF00DFDF
      DF00D3D3D300DFDFDF00D4D4D400E0E0E000D9D9D900E1E1E100E2E2E200E3E3
      E300E4E4E400F2F2F20000000000000000000000000000000000000000000000
      000000000000000000002E87BA003CB0EC000D63B40000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B089
      3800AD873600AA843300A7823000A47F2E00A17D2B009F7B29009F7B29009F7B
      2900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000026262600E4E4E400E4E4
      E400D5D5D500E5E5E500D6D6D600E5E5E500DDDDDD00E6E6E600E7E7E700E8E8
      E800E9E9E900F0F0F00000000000000000000000000000000000000000000000
      000000000000000000003495CB0046D2FF004FD8FF0000050C00000000000000
      00000000000000000000000000000000000000000000000000008A6C3000B790
      3F00B58E3D00B28B3A00C8A85F00B7944600A9843200A6813000A47F2D00A17C
      2A00594416000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000021212100D9D9D900D8D8
      D800D4D4D400D7D7D700D3D3D300D6D6D600D4D4D400D8D8D800D9D9D900DADA
      DA00DBDBDB00EFEFEF0000000000000000000000000000000000000000000000
      000000000000297FE00077DEFE0065DBFF0065D5FF0054A0F100001126000000
      0000000000000000000000000000000000000000000000000000C2994900BF97
      4600BC944400A3844400000000000000000030271300B8944700AB863400A883
      32009D7A2C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001B1B1B00E2E2E200E3E3
      E300D3D3D300E3E3E300D4D4D400E3E3E300DBDBDB00E4E4E400E5E5E500E6E6
      E600E7E7E700EEEEEE0000000000000000000000000000000000000000000000
      000006294A0069C2F7005AC8FB005AC5FB005AC4FB005AC3FB002F75DB000000
      0000000000000000000000000000000000000000000034281400CBA05000C89E
      4E00C49B4B001A1408000000000000000000000000009B7F4400B38C3B00B08A
      3900A68133000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000017171700D5D5D500D5D5
      D500D1D1D100D4D4D400D0D0D000D3D3D300D1D1D100D4D4D400D6D6D600D7D7
      D700D8D8D800EDEDED0000000000000000000000000000000000000000000000
      00001860A8004BB8F700BFEBFF00A1E0FF0082D6FF006FCEFE003699FB000000
      0000000000000000000000000000000000000000000000000000D7AF6200D0A4
      5500CDA25200CAA05000896C35000403010000000000B58E4200BB934300B891
      4000927231000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014141400E2E2E200E2E2
      E200D2D2D200E2E2E200D4D4D400E2E2E200DADADA00E3E3E300E3E3E300E4E4
      E400E5E5E500ECECEC0000000000000000000000000000000000000000000000
      00000C40700048AFF4000000000000000000000000000E5BA9003BA0FE000000
      000000000000000000000000000000000000000000000000000044361E00E2BE
      7600D5A95900D2A65700CFA45400CCA15200C99F4F00C69C4C00C39A4A00C098
      470057441F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000101010004B64CC004B64
      CC004B64CB004A63CB004A63CB004A63CA004A63CB004C65CB00697DD0008797
      D600A6B0DC00D9DAE10000000000000000000000000000000000000000000000
      0000000000004FB3FD002696F100105B97001373D10052A5F7000A396C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000856E4400E5C17A00D7AA5B00D4A85900D1A65600CEA35400CBA15100C99E
      4E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000008080800BCBCBC00BDBD
      BD00BDBDBE00BEBEBE00BDBEBE00BEBEBE00BDBDBD00BDBDBD00BBBCBC00BBBB
      BB00BABABA00B7B7B80000000000000000000000000000000000000000000000
      000000000000000001003B9CE1006BCDFF0058BDF90009325B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000029201100BAA06900E6C47E00DCB36700DEB86F00846B
      3B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000008003FE7F0000FFFF8001FC3F0000FFFF
      8001FC3FFF83CFFF8001FC3FFF83C3FF8001FC3FFF07E1FF8001FC3FFD07E0FF
      8001FC3FF00FF07F8001FC3FE007F83F8001FC3FC007FC1F8001F81FC007FE0F
      8001F00F8107FF078001F00F8187FF838001F00FC007FFC18001F00FC007FFE1
      8001F80FF007FFF38001F81FFC07FFFF00000000000000000000000000000000
      000000000000}
  end
  object popCampo: TPopupMenu
    Images = imgIconesAltExcluir
    Left = 532
    Top = 288
    object Alterarcampo1: TMenuItem
      Caption = 'Alterar campo'
      SubMenuImages = imgIconesAltExcluir
      ImageIndex = 0
      OnClick = Alterarcampo1Click
    end
    object popItemExcluircampo1: TMenuItem
      Caption = 'Excluir campo'
      SubMenuImages = imgIconesAltExcluir
      ImageIndex = 1
      OnClick = popItemExcluircampo1Click
    end
  end
  object imgIconesAltExcluir: TImageList
    Left = 656
    Top = 160
    Bitmap = {
      494C010102009800380110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000A2B9500011B7D0000082300071B
      3A00020D1B000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000140EAE001711B800100B
      A100000000000000000000000000000000000000000000000000000000000000
      0000100BA1001711B800140EAE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000004144600000058004E9FDF004CBF
      F8001467D4000721780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F1AB5002522E9002723F1001F1B
      D100130EA600000000000000000000000000000000000000000000000000130E
      A6001F1BD1002723F1002522E9001F1AB5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000219008AADDC00C3FFFF0095EB
      FF0058D0FD000773D900092A9100000000000000000000000000000000000000
      0000000000000000000000000000000000003D3AC8004648F6002425F1002A2B
      F3002121D400140FAD0000000000000000000000000000000000140FAD002121
      D4002A2BF3002425F1004648F6003D3AC8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000312300092BAE500FFFFFF0079DF
      FF000EA4EE000B6DD5000E7FE0000D3B9F000000000000000000000000000000
      000000000000000000000000000000000000221CB6006262E100444BF300262D
      EF002C33F2002326D7001812B30000000000000000001812B3002326D7002C33
      F200262DEF00474DF4006262E100221CB6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000014358600DBFFFF0006DF
      FA0000C3FC00119EEA001272D7000D80E1000F3E9E0000000000000000000000
      00000000000000000000000000000000000000000000241DBB006566E3004853
      F3002934EF002F3BF200262BD9001A13BA001A13BA00262BD9002F3BF2002834
      EF004752F3005F61DF00241DBA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000F770035B9E4000AFF
      FF0000D8F60000C8FE00119CEA001271D6000D7FDF001141A500000000000000
      00000000000000000000000000000000000000000000000000002621C200656A
      E5004756F3002C3DF0003041F1002B36E4002B36E4003041F1002D3DF0004A59
      F3005D5FE0002119BF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000092799003AD2
      EC0012FFFF0000D9F60000C8FE00119CEA001271D5000D80DE001142A2000000
      0000000000000000000000000000000000000000000000000000000000002721
      C6006267E6004356F2003044F0003448F2003448F2003044EF004255F2006166
      E500221AC4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000D25
      960039D4ED0012FFFF0000D8F60000C8FE00119CEA001271D5000D7FDF001245
      AB00000000000000000000000000000000000000000000000000000000000000
      00002C23CC004551E900354DF100364CEF00364CEF00354DF0004251EA002B23
      CD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000F2B9D003AD1EC000CFFFD0000D9F60000C8FE00119CEA00126FD5000C80
      DF00154BA7000000000000000000000000000000000000000000000000000000
      00001D14CE003240E6003C54F2003850F000384FF0003B54F2003445E9001D15
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000122D9C0059F0F60007FFFB0000D8F60000C8FE00119CEA001371
      D6000B7FE300003CAC0000000000000000000000000000000000000000001F17
      D400313EE4003E58F1003953F000455EF200455FF2003A53F0003E57F000303A
      E3001F15D3000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002340A70067F6F80003FFFA0000D8F60000C8FE000EA9
      F7000052BE0062759000476DAE000000000000000000000000002018D9003542
      E700425FF3003D59F100556EF300737FF200737EF200566EF3003D59F100425E
      F300313AE4001F16D90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002541A50068F8F90005FFFA0000E6FF0000A4
      E90062799200FFFFE9007976B8000027A100000000002018DE003744E9004663
      F200405DF1005C77F3006E76EF003028DF002E25DF007078F0005D77F400405D
      F1004562F200333DE8002117DD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002746AC0066FFFF0000E9E100639A
      A300FFFFFC006B6FAA000000DD000D27EF00221BE2003947EC004A69F3004462
      F2005F7AF300686EF000271FE20000000000000000002C23E200717AF100607B
      F4004362F2004A69F3003846EB002019E2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001849AB0080B6BC00FFFF
      FC006D7CAD000000DA000007FF000D26E8004144EC005372F4004464F2006481
      F4006E76F200271EE600000000000000000000000000000000002D25E700747C
      F2006480F4004564F2005270F3003D41EB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003A63C20084A6
      BC000C6CE2001458FF000B21ED00020721004441ED007B8FF5007A94F600737B
      F3002D24EA000000000000000000000000000000000000000000000000002D24
      EA00737CF3007A93F6007A8FF6004441ED000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000063F
      9F003DA8F1002679DD0001071C0000000000000000004845F0005A59F2002D24
      ED00000000000000000000000000000000000000000000000000000000000000
      00002D24ED005959F2004844F000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0007FF8FF10000000003FF07E000000000
      01FF03C00000000000FF018000000000807F800100000000803FC00300000000
      C01FE00700000000E00FF00F00000000F007F00F00000000F803E00700000000
      FC01C00300000000FE00800100000000FF00018000000000FF8003C000000000
      FFC007E000000000FFE18FF10000000000000000000000000000000000000000
      000000000000}
  end
end
