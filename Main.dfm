object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'All Info About Network'
  ClientHeight = 523
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    699
    523)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 270
    Height = 33
    Caption = 'All Info About Network'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object mmInfoWifi: TMemo
    Left = 8
    Top = 58
    Width = 683
    Height = 457
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnGetInfo: TButton
    Left = 552
    Top = 20
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Get Info'
    TabOrder = 1
    OnClick = btnGetInfoClick
  end
  object loading: TActivityIndicator
    Left = 659
    Top = 20
  end
end
