object frmCadastroForms: TfrmCadastroForms
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Telas'
  ClientHeight = 392
  ClientWidth = 910
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object rpbDadosGerais: TGroupBox
    Left = 0
    Top = 0
    Width = 910
    Height = 194
    Align = alTop
    Color = 16053492
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object imgIcone: TImage
      Left = 406
      Top = 162
      Width = 44
      Height = 26
      Center = True
      ParentShowHint = False
      ShowHint = False
      Stretch = True
    end
    object lbl3: TLabel
      Left = 8
      Top = 113
      Width = 247
      Height = 18
      AutoSize = False
      Caption = 'Selecione a classe'
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
    object imgIconeGrid: TImage
      Left = 251
      Top = 161
      Width = 41
      Height = 27
      Visible = False
    end
    object lblModulo: TLabel
      Left = 2
      Top = 15
      Width = 906
      Height = 23
      Align = alTop
      Alignment = taCenter
      Color = 4868646
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      ExplicitWidth = 6
    end
    object lbl2: TLabel
      Left = 8
      Top = 58
      Width = 247
      Height = 18
      AutoSize = False
      Caption = 'Nome da tela'
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
      Left = 263
      Top = 58
      Width = 248
      Height = 18
      AutoSize = False
      Caption = 'Nome do form'
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
      Left = 522
      Top = 58
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
    object lbl5: TLabel
      Left = 263
      Top = 113
      Width = 317
      Height = 18
      AutoSize = False
      Caption = 'Caminho do '#237'cone'
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
    object btnLimparIcone: TJvNavPanelButton
      Left = 456
      Top = 161
      Width = 98
      Alignment = taCenter
      Caption = 'Limpar '#237'cone'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Tahoma'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      Colors.ButtonColorFrom = clWhite
      Colors.ButtonColorTo = clWhite
      Colors.ButtonHotColorFrom = 16771818
      Colors.ButtonHotColorTo = 16771818
      Colors.ButtonSelectedColorTo = 16771818
      ImageIndex = 0
      OnClick = btnLimparIconeClick
    end
    object btnIcone: TJvNavPanelButton
      Left = 558
      Top = 161
      Width = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Colors.ButtonColorFrom = clWhite
      Colors.ButtonColorTo = clWhite
      Colors.ButtonHotColorFrom = 16771818
      Colors.ButtonHotColorTo = 16771818
      Colors.ButtonSelectedColorTo = 16771818
      ImageIndex = 0
      OnClick = btnIconeClick
    end
    object btnGravar: TJvNavPanelButton
      Left = 585
      Top = 108
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
      OnClick = btnGravarClick
    end
    object cboTabela: TDBLookupComboBox
      Left = 522
      Top = 76
      Width = 228
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnEnter = cboTabelaEnter
      OnExit = cboTabelaExit
      OnKeyPress = cboTabelaKeyPress
    end
    object cboClasse: TDBLookupComboBox
      Left = 8
      Top = 132
      Width = 247
      Height = 26
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnEnter = cboClasseEnter
      OnExit = cboClasseExit
      OnKeyPress = cboClasseKeyPress
    end
    object edtNomeTela: TEdit
      Left = 8
      Top = 79
      Width = 247
      Height = 21
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnEnter = edtNomeTelaEnter
      OnExit = edtNomeTelaExit
      OnKeyPress = edtNomeTelaKeyPress
    end
    object edtNomeForm: TEdit
      Left = 261
      Top = 79
      Width = 250
      Height = 21
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnEnter = edtNomeFormEnter
      OnExit = edtNomeFormExit
      OnKeyPress = edtNomeFormKeyPress
    end
    object edtCaminhoIcone: TEdit
      Left = 261
      Top = 132
      Width = 319
      Height = 24
      Color = 14737632
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
  end
  object grdTela: TDBGrid
    Left = 0
    Top = 194
    Width = 910
    Height = 198
    Align = alClient
    Color = clBtnHighlight
    DrawingStyle = gdsClassic
    FixedColor = 4868646
    GradientEndColor = 4868646
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = pop1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grdTelaDrawColumnCell
    OnTitleClick = grdTelaTitleClick
    Columns = <
      item
        Color = clWhite
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
        Color = clWhite
        Expanded = False
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Color = clWhite
        Expanded = False
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Color = clWhite
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
        Color = clWhite
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
        Color = clWhite
        Expanded = False
        Title.Color = clMoneyGreen
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -15
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object dlgIcone: TOpenPictureDialog
    Filter = 'Icones (*.ico)|*.ico'
    Left = 136
    Top = 152
  end
  object pop1: TPopupMenu
    Images = imgListIcone
    Left = 179
    Top = 154
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      SubMenuImages = imgListIcone
      ImageIndex = 0
      OnClick = Alterar1Click
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      ImageIndex = 1
      OnClick = Excluir1Click
    end
  end
  object imgListIcone: TImageList
    Left = 64
    Top = 152
    Bitmap = {
      494C010102009800EC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
