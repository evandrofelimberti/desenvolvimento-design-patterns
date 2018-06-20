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
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 299
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = cxTabSheet2
    Properties.CustomButtons.Buttons = <>
    ExplicitLeft = 224
    ExplicitTop = 64
    ExplicitWidth = 321
    ExplicitHeight = 193
    ClientRectBottom = 295
    ClientRectLeft = 4
    ClientRectRight = 631
    ClientRectTop = 24
    object cxTabSheet1: TcxTabSheet
      Caption = 'Or'#231'amento'
      ImageIndex = 0
      ExplicitLeft = 5
      ExplicitTop = 25
      object GroupBox1: TGroupBox
        Left = 56
        Top = 35
        Width = 481
        Height = 193
        Caption = 'GroupBox1'
        TabOrder = 0
        object Button1: TButton
          Left = 247
          Top = 26
          Width = 75
          Height = 25
          Caption = 'Aprovar'
          TabOrder = 0
          OnClick = Button1Click
        end
        object cxLabel1: TcxLabel
          Left = 16
          Top = 32
          Caption = 'Or'#231'amento'
        end
        object Edit1: TEdit
          Left = 79
          Top = 28
          Width = 121
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
        end
      end
    end
    object cxTabSheet2: TcxTabSheet
      Caption = 'Conta Corrente'
      ImageIndex = 1
      OnShow = cxTabSheet2Show
      ExplicitLeft = 5
      ExplicitTop = 25
      object GroupBox2: TGroupBox
        Left = 72
        Top = 32
        Width = 497
        Height = 169
        Caption = 'GroupBox2'
        TabOrder = 0
        object Label1: TLabel
          Left = 280
          Top = 74
          Width = 34
          Height = 14
          Caption = 'Saldo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Edit2: TEdit
          Left = 136
          Top = 72
          Width = 105
          Height = 21
          TabOrder = 0
        end
        object cxLabel2: TcxLabel
          Left = 88
          Top = 73
          Caption = 'Valor'
        end
        object Button2: TButton
          Left = 112
          Top = 115
          Width = 75
          Height = 25
          Caption = 'Saque'
          TabOrder = 2
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 208
          Top = 115
          Width = 75
          Height = 25
          Caption = 'Deposito'
          TabOrder = 3
          OnClick = Button3Click
        end
        object cxTextEditSaldo: TcxTextEdit
          Left = 320
          Top = 71
          ParentFont = False
          Style.BorderStyle = ebsUltraFlat
          Style.Edges = []
          Style.TextStyle = []
          Style.TransparentBorder = False
          TabOrder = 4
          Width = 121
        end
      end
    end
  end
end
