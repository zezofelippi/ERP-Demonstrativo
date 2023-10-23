object frmCriptografiaRSA: TfrmCriptografiaRSA
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Gerar c'#243'digo de acesso'
  ClientHeight = 236
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl3: TLabel
    Left = 18
    Top = 17
    Width = 227
    Height = 19
    Caption = 'Gerador de chave de acesso'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 21
    Top = 42
    Width = 227
    Height = 16
    Caption = 'Este exe pertence ao programador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object leCodigoNE: TLabeledEdit
    Left = 23
    Top = 102
    Width = 185
    Height = 21
    EditLabel.Width = 110
    EditLabel.Height = 19
    EditLabel.Caption = 'Digite o C'#243'digo'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    MaxLength = 4
    TabOrder = 0
  end
  object btnGerarSenha: TBitBtn
    Left = 23
    Top = 136
    Width = 185
    Height = 41
    Caption = 'Gerar chave de acesso'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnGerarSenhaClick
  end
  object leResultadoNECifrado: TLabeledEdit
    Left = 23
    Top = 200
    Width = 185
    Height = 21
    EditLabel.Width = 113
    EditLabel.Height = 19
    EditLabel.Caption = 'chave de acesso'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    TabOrder = 2
  end
end
