object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Menu de op'#231#245'es'
  ClientHeight = 448
  ClientWidth = 792
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tooBotaoAtalho: TToolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 48
    ButtonHeight = 50
    Caption = 'tooBotaoAtalho'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    Transparent = False
  end
  object ctbMenu: TCategoryButtons
    Left = 0
    Top = 48
    Width = 177
    Height = 379
    Align = alLeft
    BackgroundGradientDirection = gdVertical
    ButtonFlow = cbfVertical
    ButtonHeight = 32
    ButtonWidth = 140
    ButtonOptions = [boAllowCopyingButtons, boFullSize, boShowCaptions, boCaptionOnlyBorder]
    Categories = <>
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    HotButtonColor = 15724527
    Images = imgListaIconesMenu
    PopupMenu = popMenu
    RegularButtonColor = clWindow
    SelectedButtonColor = 16765650
    TabOrder = 1
    OnButtonClicked = ctbMenuButtonClicked
  end
  object stat1: TStatusBar
    Left = 0
    Top = 427
    Width = 792
    Height = 21
    Panels = <>
  end
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 680
    Top = 72
  end
  object imgListaIconesMenu: TImageList
    Left = 464
    Top = 128
  end
  object popMenu: TPopupMenu
    Left = 600
    Top = 72
    object popItemAbrirmdulos: TMenuItem
      Caption = 'Abrir m'#243'dulos'
      OnClick = popItemAbrirmdulosClick
    end
    object popItemFecharmdulos: TMenuItem
      Caption = 'Fechar m'#243'dulos'
      OnClick = popItemFecharmdulosClick
    end
  end
  object imgListaIconesBotaoAtalho: TImageList
    Height = 32
    Width = 32
    Left = 464
    Top = 72
  end
  object popBotaoAtalho: TPopupMenu
    Left = 600
    Top = 144
    object popItemExcluirBoto1: TMenuItem
      Caption = 'Excluir Bot'#227'o'
      OnClick = popItemExcluirBoto1Click
    end
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'D:\Inform'#225'tica\ERP Demonstrativo Delphi XE6 2020\ERP Demonstrati' +
      'vo\Win32\Debug\libmysql.dll'
    Left = 640
    Top = 312
  end
end
