object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'All Info About Network'
  ClientHeight = 468
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    690
    468)
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
    Width = 674
    Height = 402
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitWidth = 683
    ExplicitHeight = 457
  end
  object btnGetInfo: TButton
    Left = 543
    Top = 27
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Get Info'
    TabOrder = 1
    OnClick = btnGetInfoClick
    ExplicitLeft = 562
  end
  object loading: TActivityIndicator
    Left = 640
    Top = 20
    Anchors = [akTop, akRight]
    ExplicitLeft = 659
  end
end
