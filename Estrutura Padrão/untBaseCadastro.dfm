object frmBaseCadastro: TfrmBaseCadastro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmBaseCadastro'
  ClientHeight = 399
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tmMostrarComponentes: TTimer
    Interval = 100
    OnTimer = tmMostrarComponentesTimer
    Left = 136
    Top = 104
  end
  object popOpcoesTelaCadastro: TPopupMenu
    OnPopup = popOpcoesTelaCadastroPopup
    Left = 136
    Top = 16
    object popItemInseriratalho: TMenuItem
      Caption = 'Inserir atalho'
      OnClick = popItemInseriratalhoClick
    end
    object InserirPageControl1: TMenuItem
      Caption = 'Inserir PageControl...'
      OnClick = InserirPageControl1Click
    end
    object InserirGroupBox1: TMenuItem
      Caption = 'Inserir GroupBox...'
      OnClick = InserirGroupBox1Click
    end
    object ExcluirGroupBox1: TMenuItem
      Caption = 'Excluir GroupBox'
      OnClick = ExcluirGroupBox1Click
    end
    object popItemAlterarcaptionGroupBox1: TMenuItem
      Caption = 'Alterar caption GroupBox...'
      OnClick = popItemAlterarcaptionGroupBox1Click
    end
    object popItemInserircampos1: TMenuItem
      Caption = 'Inserir campos...'
      OnClick = popItemInserircampos1Click
    end
    object popItemOrdenarcampos1: TMenuItem
      Caption = 'Ordenar campos'
      OnClick = popItemOrdenarcampos1Click
    end
  end
end
