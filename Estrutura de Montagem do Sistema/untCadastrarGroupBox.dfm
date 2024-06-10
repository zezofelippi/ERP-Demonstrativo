inherited frmCadastrarGroupBox: TfrmCadastrarGroupBox
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastrar GroupBox'
  ClientHeight = 75
  ClientWidth = 495
  Position = poDesktopCenter
  ExplicitWidth = 501
  ExplicitHeight = 103
  PixelsPerInch = 96
  TextHeight = 13
  object lbl2: TLabel [0]
    Left = 8
    Top = 18
    Width = 303
    Height = 18
    AutoSize = False
    Caption = 'Nome do groupbox (opcional)'
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
  object btnGravar: TJvNavPanelButton [1]
    Left = 315
    Top = 17
    Width = 172
    Height = 43
    Alignment = taCenter
    Caption = 'Criar GroupBox'
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
  object edtNomeTela: TEdit [2]
    Left = 8
    Top = 39
    Width = 303
    Height = 21
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
end
