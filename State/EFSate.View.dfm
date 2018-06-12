object EFStateView: TEFStateView
  Left = 0
  Top = 0
  Caption = 'EFStateView'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 248
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object cxLabel1: TcxLabel
    Left = 168
    Top = 73
    Caption = 'Or'#231'amento'
  end
  object Button1: TButton
    Left = 152
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
end
