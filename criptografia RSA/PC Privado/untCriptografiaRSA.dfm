object frmCriptografiaRSA: TfrmCriptografiaRSA
  Left = 0
  Top = 0
  Caption = 'frmCriptografiaRSA'
  ClientHeight = 283
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
    Width = 167
    Height = 19
    Caption = 'Computador Privado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 10
    Top = 48
    Width = 220
    Height = 16
    Caption = 'Este PC pertence ao programador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object leCodigoNE: TLabeledEdit
    Left = 23
    Top = 125
    Width = 185
    Height = 21
    EditLabel.Width = 72
    EditLabel.Height = 13
    EditLabel.Caption = 'Digite o C'#243'digo'
    MaxLength = 4
    TabOrder = 0
  end
  object btnGerarSenha: TBitBtn
    Left = 23
    Top = 155
    Width = 121
    Height = 25
    Caption = 'Gerar senha'
    TabOrder = 1
    OnClick = btnGerarSenhaClick
  end
  object leResultadoNECifrado: TLabeledEdit
    Left = 23
    Top = 199
    Width = 234
    Height = 21
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Senha'
    TabOrder = 2
  end
end
