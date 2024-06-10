object frmCriptografiaRSA: TfrmCriptografiaRSA
  Left = 0
  Top = 0
  Caption = 'frmCriptografiaRSA'
  ClientHeight = 283
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 10
    Top = 140
    Width = 33
    Height = 13
    Caption = 'Codigo'
  end
  object lbl2: TLabel
    Left = 8
    Top = 17
    Width = 164
    Height = 19
    Caption = 'Computador P'#250'blico'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 8
    Top = 48
    Width = 257
    Height = 16
    Caption = 'Este PC pertence ao usu'#225'rio do sistema'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnGerarCodigo: TBitBtn
    Left = 8
    Top = 109
    Width = 137
    Height = 25
    Caption = 'Gerar C'#243'digo'
    TabOrder = 0
    OnClick = btnGerarCodigoClick
  end
  object edtGerarCodigo: TEdit
    Left = 8
    Top = 158
    Width = 136
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object leSenha: TLabeledEdit
    Left = 8
    Top = 217
    Width = 234
    Height = 21
    EditLabel.Width = 69
    EditLabel.Height = 13
    EditLabel.Caption = 'Digite a Senha'
    TabOrder = 2
  end
  object btnOk: TBitBtn
    Left = 8
    Top = 244
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = btnOkClick
  end
end
