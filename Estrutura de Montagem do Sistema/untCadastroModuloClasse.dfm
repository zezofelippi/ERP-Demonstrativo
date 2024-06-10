object frmCadastroModuloClasse: TfrmCadastroModuloClasse
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Modulos'
  ClientHeight = 601
  ClientWidth = 896
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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object rpbModulo: TGroupBox
    Left = 0
    Top = 0
    Width = 425
    Height = 88
    Caption = 'Cadastrar m'#243'dulo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbl4: TLabel
      Left = 7
      Top = 28
      Width = 248
      Height = 18
      AutoSize = False
      Caption = 'Nome do m'#243'dulo'
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
    object btnGravarModulo: TJvNavPanelButton
      Left = 261
      Top = 27
      Width = 158
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
      OnClick = btnGravarModuloClick
    end
    object edtNomeModulo: TEdit
      Left = 5
      Top = 49
      Width = 250
      Height = 21
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = edtNomeModuloEnter
      OnExit = edtNomeModuloExit
    end
  end
  object grdModulo: TDBGrid
    Left = 0
    Top = 90
    Width = 425
    Height = 216
    DrawingStyle = gdsClassic
    FixedColor = 4868646
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = popModulo
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grdModuloDrawColumnCell
    OnDblClick = grdModuloDblClick
    Columns = <
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
      end>
  end
  object rpbClasse: TGroupBox
    Left = 0
    Top = 312
    Width = 865
    Height = 137
    Caption = 'Inserir classe no m'#243'dulo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object lbl5: TLabel
      Left = 9
      Top = 25
      Width = 410
      Height = 18
      AutoSize = False
      Caption = 'M'#243'dulo'
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
      Left = 436
      Top = 25
      Width = 419
      Height = 18
      AutoSize = False
      Caption = 'Classe'
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
    object lbl1: TLabel
      Left = 9
      Top = 79
      Width = 317
      Height = 18
      AutoSize = False
      Caption = 'M'#243'dulo'
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
    object btnGravarModuloClasse: TJvNavPanelButton
      Left = 691
      Top = 86
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
      OnClick = btnGravarModuloClasseClick
    end
    object cboModulo: TDBLookupComboBox
      Left = 9
      Top = 99
      Width = 317
      Height = 26
      TabOrder = 0
      OnCloseUp = cboModuloCloseUp
      OnEnter = cboModuloEnter
      OnExit = cboModuloExit
      OnKeyDown = cboModuloKeyDown
      OnKeyUp = cboModuloKeyUp
    end
    object edtModulo: TEdit
      Left = 7
      Top = 44
      Width = 412
      Height = 27
      Color = 14737632
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtClasse: TEdit
      Left = 435
      Top = 43
      Width = 420
      Height = 27
      Color = 14737632
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object grdModuloClasse: TDBGrid
    Left = 0
    Top = 455
    Width = 865
    Height = 134
    DrawingStyle = gdsClassic
    FixedColor = 4868646
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = popModuloClasse
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grdModuloClasseDrawColumnCell
    Columns = <
      item
        Expanded = False
        Title.Caption = 'M'#243'dulo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 420
        Visible = True
      end
      item
        Expanded = False
        Title.Caption = 'Classe'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 412
        Visible = True
      end>
  end
  object rpbCadastro: TGroupBox
    Left = 435
    Top = 3
    Width = 430
    Height = 85
    Caption = 'Cadastrar classe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object lbl2: TLabel
      Left = 5
      Top = 23
      Width = 247
      Height = 18
      AutoSize = False
      Caption = 'Nome da classe'
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
    object btnGravarClasse: TJvNavPanelButton
      Left = 256
      Top = 21
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
      OnClick = btnGravarClasseClick
    end
    object edtNomeClasse: TEdit
      Left = 5
      Top = 43
      Width = 247
      Height = 21
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = edtNomeClasseEnter
      OnExit = edtNomeClasseExit
    end
  end
  object grdCadClasse: TDBGrid
    Left = 434
    Top = 90
    Width = 431
    Height = 216
    Color = clWhite
    DrawingStyle = gdsClassic
    FixedColor = 4868646
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = popClasse
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grdCadClasseDrawColumnCell
    OnDblClick = grdCadClasseDblClick
    Columns = <
      item
        Expanded = False
        Title.Caption = 'Classe'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 160
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
      end>
  end
  object popModulo: TPopupMenu
    Images = imgLista
    Left = 112
    Top = 168
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      ImageIndex = 0
      OnClick = Alterar1Click
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      ImageIndex = 1
      OnClick = Excluir1Click
    end
  end
  object popModuloClasse: TPopupMenu
    Images = imgLista
    Left = 662
    Top = 485
    object Excluir2: TMenuItem
      Caption = 'Excluir'
      ImageIndex = 1
      OnClick = Excluir2Click
    end
  end
  object popClasse: TPopupMenu
    Images = imgLista
    Left = 480
    Top = 177
    object Excluir3: TMenuItem
      Caption = 'Excluir'
      ImageIndex = 1
      OnClick = Excluir3Click
    end
  end
  object imgLista: TImageList
    Left = 368
    Top = 192
    Bitmap = {
      494C010102000800340010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000A2B95FF011B7DFB0008233C071B
      3A45020D1B210000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000140EAEFF1711B8FF100B
      A1FF000000000000000000000000000000000000000000000000000000000000
      0000100BA1FF1711B8FF140EAEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000414467B000058FF4E9FDFFF4CBF
      F8FF1467D4FF072178B200000000000000000000000000000000000000000000
      0000000000000000000000000000000000001F1AB5FF2522E9FF2723F1FF1F1B
      D1FF130EA6FF000000000000000000000000000000000000000000000000130E
      A6FF1F1BD1FF2723F1FF2522E9FF1F1AB5FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000219338AADDCFFC3FFFFFF95EB
      FFFF58D0FDFF0773D9FF092A91D4000000000000000000000000000000000000
      0000000000000000000000000000000000003D3AC8FF4648F6FF2425F1FF2A2B
      F3FF2121D4FF140FADFF00000000000000000000000000000000140FADFF2121
      D4FF2A2BF3FF2425F1FF4648F6FF3D3AC8FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000312304692BAE5FFFFFFFFFF79DF
      FFFF0EA4EEFF0B6DD5FF0E7FE0FF0D3B9FDA0000000000000000000000000000
      000000000000000000000000000000000000221CB6FF6262E1FF444BF3FF262D
      EFFF2C33F2FF2326D7FF1812B3FF00000000000000001812B3FF2326D7FF2C33
      F2FF262DEFFF474DF4FF6262E1FF221CB6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000143586B7DBFFFFFF06DF
      FAFF00C3FCFF119EEAFF1272D7FF0D80E1FF0F3E9ED300000000000000000000
      00000000000000000000000000000000000000000000241DBBFF6566E3FF4853
      F3FF2934EFFF2F3BF2FF262BD9FF1A13BAFF1A13BAFF262BD9FF2F3BF2FF2834
      EFFF4752F3FF5F61DFFF241DBAFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000F77B535B9E4FF0AFF
      FFFF00D8F6FF00C8FEFF119CEAFF1271D6FF0D7FDFFF1141A5DA000000000000
      00000000000000000000000000000000000000000000000000002621C2FF656A
      E5FF4756F3FF2C3DF0FF3041F1FF2B36E4FF2B36E4FF3041F1FF2D3DF0FF4A59
      F3FF5D5FE0FF2119BFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000092799DA3AD2
      ECFF12FFFFFF00D9F6FF00C8FEFF119CEAFF1271D5FF0D80DEFF1142A2D30000
      0000000000000000000000000000000000000000000000000000000000002721
      C6FF6267E6FF4356F2FF3044F0FF3448F2FF3448F2FF3044EFFF4255F2FF6166
      E5FF221AC4FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000D25
      96D339D4EDFF12FFFFFF00D8F6FF00C8FEFF119CEAFF1271D5FF0D7FDFFF1245
      ABDA000000000000000000000000000000000000000000000000000000000000
      00002C23CCFF4551E9FF354DF1FF364CEFFF364CEFFF354DF0FF4251EAFF2B23
      CDFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000F2B9DDA3AD1ECFF0CFFFDFF00D9F6FF00C8FEFF119CEAFF126FD5FF0C80
      DFFF154BA7D30000000000000000000000000000000000000000000000000000
      00001D14CEFF3240E6FF3C54F2FF3850F0FF384FF0FF3B54F2FF3445E9FF1D15
      CEFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000122D9CD359F0F6FF07FFFBFF00D8F6FF00C8FEFF119CEAFF1371
      D6FF0B7FE3FF003CACDA00000000000000000000000000000000000000001F17
      D4FF313EE4FF3E58F1FF3953F0FF455EF2FF455FF2FF3A53F0FF3E57F0FF303A
      E3FF1F15D3FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002340A7DA67F6F8FF03FFFAFF00D8F6FF00C8FEFF0EA9
      F7FF0052BEFF627590FF476DAED30000000000000000000000002018D9FF3542
      E7FF425FF3FF3D59F1FF556EF3FF737FF2FF737EF2FF566EF3FF3D59F1FF425E
      F3FF313AE4FF1F16D9FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002541A5D368F8F9FF05FFFAFF00E6FFFF00A4
      E9FF627992FFFFFFE9FF7976B8FF0027A1CB000000002018DEFF3744E9FF4663
      F2FF405DF1FF5C77F3FF6E76EFFF3028DFFF2E25DFFF7078F0FF5D77F4FF405D
      F1FF4562F2FF333DE8FF2117DDFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002746ACDA66FFFFFF00E9E1FF639A
      A3FFFFFFFCFF6B6FAAFF0000DDFF0D27EFFF221BE2FF3947ECFF4A69F3FF4462
      F2FF5F7AF3FF686EF0FF271FE2FF00000000000000002C23E2FF717AF1FF607B
      F4FF4362F2FF4A69F3FF3846EBFF2019E2FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001849ABD380B6BCFFFFFF
      FCFF6D7CADFF0000DAFF0007FFFF0D26E8FF4144ECFF5372F4FF4464F2FF6481
      F4FF6E76F2FF271EE6FF000000000000000000000000000000002D25E7FF747C
      F2FF6480F4FF4564F2FF5270F3FF3D41EBFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003A63C2DA84A6
      BCFF0C6CE2FF1458FFFF0B21EDFF020721264441EDFF7B8FF5FF7A94F6FF737B
      F3FF2D24EAFF0000000000000000000000000000000000000000000000002D24
      EAFF737CF3FF7A93F6FF7A8FF6FF4441EDFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000063F
      9FC43DA8F1F92679DDEE01071C1F00000000000000004845F0FF5A59F2FF2D24
      EDFF000000000000000000000000000000000000000000000000000000000000
      00002D24EDFF5959F2FF4844F0FF000000000000000000000000000000000000
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
