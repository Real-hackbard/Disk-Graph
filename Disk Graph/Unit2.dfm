object Form2: TForm2
  Left = 567
  Top = 125
  AlphaBlend = True
  AlphaBlendValue = 220
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 565
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 545
    Caption = ' Chart '
    TabOrder = 0
    object Label1: TLabel
      Left = 265
      Top = 57
      Width = 33
      Height = 13
      Caption = 'Zoom :'
    end
    object Label2: TLabel
      Left = 264
      Top = 160
      Width = 34
      Height = 13
      Caption = 'Y-Pos :'
    end
    object Label3: TLabel
      Left = 264
      Top = 192
      Width = 34
      Height = 13
      Caption = 'X-Pos :'
    end
    object Label4: TLabel
      Left = 488
      Top = 162
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label5: TLabel
      Left = 488
      Top = 194
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label6: TLabel
      Left = 488
      Top = 256
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label7: TLabel
      Left = 244
      Top = 256
      Width = 54
      Height = 13
      Caption = 'Inclination :'
    end
    object Label8: TLabel
      Left = 236
      Top = 288
      Width = 62
      Height = 13
      Caption = 'Perspective :'
    end
    object Label9: TLabel
      Left = 488
      Top = 288
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label10: TLabel
      Left = 235
      Top = 332
      Width = 63
      Height = 13
      Caption = 'Bitmap Pixel :'
    end
    object Label11: TLabel
      Left = 32
      Top = 296
      Width = 91
      Height = 13
      Caption = 'Background Color :'
    end
    object Shape1: TShape
      Left = 96
      Top = 326
      Width = 17
      Height = 17
      Cursor = crHandPoint
      OnMouseDown = Shape1MouseDown
    end
    object Shape2: TShape
      Left = 96
      Top = 350
      Width = 17
      Height = 17
      Cursor = crHandPoint
      OnMouseDown = Shape2MouseDown
    end
    object Shape3: TShape
      Left = 120
      Top = 350
      Width = 17
      Height = 17
      Cursor = crHandPoint
      OnMouseDown = Shape3MouseDown
    end
    object Label12: TLabel
      Left = 72
      Top = 328
      Width = 18
      Height = 13
      Caption = 'Fill :'
    end
    object Label13: TLabel
      Left = 43
      Top = 352
      Width = 46
      Height = 13
      Caption = 'Gradient :'
    end
    object Label14: TLabel
      Left = 251
      Top = 92
      Width = 46
      Height = 13
      Caption = 'Rotation :'
    end
    object Label15: TLabel
      Left = 32
      Top = 400
      Width = 96
      Height = 13
      Caption = 'Background Image :'
    end
    object Bevel1: TBevel
      Left = 72
      Top = 432
      Width = 89
      Height = 89
      Shape = bsFrame
    end
    object Image1: TImage
      Left = 72
      Top = 432
      Width = 89
      Height = 89
      Stretch = True
    end
    object CheckBox1: TCheckBox
      Left = 32
      Top = 32
      Width = 60
      Height = 17
      Caption = 'View 3D'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object SpinEdit1: TSpinEdit
      Left = 48
      Top = 56
      Width = 65
      Height = 22
      MaxLength = 3
      MaxValue = 100
      MinValue = 1
      TabOrder = 1
      Value = 50
      OnChange = SpinEdit1Change
    end
    object CheckBox2: TCheckBox
      Left = 32
      Top = 104
      Width = 104
      Height = 17
      Caption = 'Scan Free Space'
      TabOrder = 2
    end
    object SpinEdit2: TSpinEdit
      Left = 304
      Top = 55
      Width = 65
      Height = 22
      MaxLength = 3
      MaxValue = 120
      MinValue = 1
      TabOrder = 3
      Value = 100
      OnChange = SpinEdit2Change
    end
    object CheckBox3: TCheckBox
      Left = 32
      Top = 128
      Width = 84
      Height = 17
      Caption = 'Zoom Text in'
      TabOrder = 4
      OnClick = CheckBox3Click
    end
    object ScrollBar1: TScrollBar
      Left = 304
      Top = 160
      Width = 177
      Height = 17
      Max = 500
      Min = -500
      PageSize = 0
      TabOrder = 5
      OnChange = ScrollBar1Change
    end
    object ScrollBar2: TScrollBar
      Left = 304
      Top = 192
      Width = 177
      Height = 17
      Max = 500
      Min = -500
      PageSize = 0
      TabOrder = 6
      OnChange = ScrollBar2Change
    end
    object ScrollBar3: TScrollBar
      Left = 304
      Top = 256
      Width = 177
      Height = 17
      PageSize = 0
      TabOrder = 7
      OnChange = ScrollBar3Change
    end
    object ScrollBar4: TScrollBar
      Left = 304
      Top = 288
      Width = 177
      Height = 17
      PageSize = 0
      TabOrder = 8
      OnChange = ScrollBar4Change
    end
    object CheckBox4: TCheckBox
      Left = 32
      Top = 152
      Width = 83
      Height = 17
      Caption = 'Monochrome'
      TabOrder = 9
      OnClick = CheckBox4Click
    end
    object CheckBox5: TCheckBox
      Left = 32
      Top = 176
      Width = 92
      Height = 17
      Caption = 'Show File Tree'
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CheckBox5Click
    end
    object SpinEdit3: TSpinEdit
      Left = 304
      Top = 88
      Width = 65
      Height = 22
      MaxLength = 3
      MaxValue = 360
      MinValue = 0
      TabOrder = 11
      Value = 360
      OnChange = SpinEdit3Change
    end
    object ComboBox1: TComboBox
      Left = 304
      Top = 328
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 12
      Text = '24'
      Items.Strings = (
        '24'
        '32')
    end
    object CheckBox6: TCheckBox
      Left = 32
      Top = 200
      Width = 137
      Height = 17
      TabStop = False
      Caption = 'Scan while File Browsing'
      TabOrder = 13
    end
    object CheckBox7: TCheckBox
      Left = 32
      Top = 224
      Width = 65
      Height = 17
      Caption = 'Auto Size'
      TabOrder = 14
      OnClick = CheckBox7Click
    end
    object CheckBox8: TCheckBox
      Left = 32
      Top = 248
      Width = 103
      Height = 17
      Caption = 'Show Folder Size'
      TabOrder = 15
      OnClick = CheckBox8Click
    end
    object Button1: TButton
      Left = 136
      Top = 398
      Width = 25
      Height = 20
      Caption = '...'
      TabOrder = 16
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 168
      Top = 398
      Width = 25
      Height = 20
      Caption = 'X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 424
      Top = 496
      Width = 75
      Height = 25
      Caption = 'Ok'
      TabOrder = 18
      OnClick = Button3Click
    end
  end
  object ColorDialog1: TColorDialog
    Left = 152
    Top = 40
  end
  object ColorDialog2: TColorDialog
    Left = 192
    Top = 40
  end
  object ColorDialog3: TColorDialog
    Left = 232
    Top = 40
  end
  object OpenDialog1: TOpenDialog
    Left = 272
    Top = 40
  end
end
