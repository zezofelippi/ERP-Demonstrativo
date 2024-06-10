object frmBase: TfrmBase
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'frmBase'
  ClientHeight = 150
  ClientWidth = 406
  Color = 16514043
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object popExcluirDBEdit: TPopupMenu
    OwnerDraw = True
    Left = 208
    Top = 16
    object popItemExcluirDBEdit1: TMenuItem
      Caption = 'Excluir componente'
      OnClick = popItemExcluirDBEdit1Click
    end
  end
end
