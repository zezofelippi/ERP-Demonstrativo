object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Login do usu'#225'rio'
  ClientHeight = 251
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gpb1: TGroupBox
    Left = 8
    Top = 106
    Width = 351
    Height = 137
    Caption = 'Entrar em modo Administrador do sistema'
    TabOrder = 0
    object btnGerarCodigo: TBitBtn
      Left = 3
      Top = 24
      Width = 106
      Height = 41
      Caption = 'Gerar c'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnGerarCodigoClick
    end
    object edtCodigo: TEdit
      Left = 3
      Top = 68
      Width = 106
      Height = 21
      BorderStyle = bsNone
      Color = 14737632
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object btnEntrarADMSistema: TBitBtn
      Left = 132
      Top = 77
      Width = 193
      Height = 36
      Caption = 'Entrar como ADM'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnEntrarADMSistemaClick
    end
    object leChaveAcesso: TLabeledEdit
      Left = 132
      Top = 44
      Width = 193
      Height = 27
      EditLabel.Width = 161
      EditLabel.Height = 16
      EditLabel.Caption = 'Digite a chave de acesso'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
    end
  end
  object gpb2: TGroupBox
    Left = 6
    Top = 3
    Width = 353
    Height = 94
    Caption = 'Entrar em modo usu'#225'rio'
    TabOrder = 1
    object btnEntrar: TBitBtn
      Left = 104
      Top = 20
      Width = 113
      Height = 60
      Caption = 'Entrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnEntrarClick
    end
    object btnSair: TBitBtn
      Left = 232
      Top = 20
      Width = 96
      Height = 60
      Caption = 'Sair'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
end
