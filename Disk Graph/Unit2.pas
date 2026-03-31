unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    CheckBox2: TCheckBox;
    SpinEdit2: TSpinEdit;
    Label1: TLabel;
    CheckBox3: TCheckBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ScrollBar3: TScrollBar;
    Label6: TLabel;
    Label7: TLabel;
    ScrollBar4: TScrollBar;
    Label8: TLabel;
    Label9: TLabel;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    SpinEdit3: TSpinEdit;
    ComboBox1: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    ColorDialog3: TColorDialog;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Label15: TLabel;
    Button2: TButton;
    Bevel1: TBevel;
    Image1: TImage;
    Button3: TButton;
    procedure CheckBox1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpinEdit3Change(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  Form1.Chart1.View3D := CheckBox1.Checked;
end;

procedure TForm2.SpinEdit1Change(Sender: TObject);
begin
  // Adjust 3D depth (thickness of bars/pies)
  Form1.Chart1.Chart3DPercent := SpinEdit1.Value; // Percentage value
  Form1.Chart1.Repaint;
end;

procedure TForm2.SpinEdit2Change(Sender: TObject);
begin
  Form1.Chart1.View3DOptions.Zoom := SpinEdit2.Value;
  Form1.Chart1.Repaint;
end;

procedure TForm2.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked = true then
  begin
    Form1.Chart1.View3DOptions.ZoomText := false;
  end else begin
    Form1.Chart1.View3DOptions.ZoomText := true;
  end;
  Form1.Chart1.Repaint;
end;

procedure TForm2.ScrollBar1Change(Sender: TObject);
begin
  Form1.Chart1.View3DOptions.VertOffset := ScrollBar1.Position;
  Label4.Caption := IntToStr(ScrollBar1.Position);
  Form1.Chart1.Repaint;
end;

procedure TForm2.ScrollBar2Change(Sender: TObject);
begin
  Form1.Chart1.View3DOptions.HorizOffset := ScrollBar2.Position;
  Label5.Caption := IntToStr(ScrollBar2.Position);
  Form1.Chart1.Repaint;
end;

procedure TForm2.ScrollBar3Change(Sender: TObject);
begin
  Form1.Chart1.View3DOptions.Elevation := ScrollBar3.Position;
  Label6.Caption := IntToStr(ScrollBar3.Position);
  Form1.Chart1.Repaint;
end;

procedure TForm2.ScrollBar4Change(Sender: TObject);
begin
  Form1.Chart1.View3DOptions.Perspective := ScrollBar4.Position;
  Label9.Caption := IntToStr(ScrollBar4.Position);
  Form1.Chart1.Repaint;
end;

procedure TForm2.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked = true then
  begin
    Form1.Chart1.Monochrome := true;
  end else begin
    Form1.Chart1.Monochrome := false;
  end;
  Form1.Chart1.Repaint;
end;

procedure TForm2.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
  begin
    Shape1.Brush.Color := ColorDialog1.Color;
    Form1.Chart1.Gradient.StartColor := Shape1.Brush.Color;
    Form1.Chart1.Gradient.EndColor := Shape1.Brush.Color;
  end;
end;

procedure TForm2.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog2.Execute then
  begin
    Shape2.Brush.Color := ColorDialog2.Color;
    Form1.Chart1.Gradient.StartColor := Shape2.Brush.Color;
    Form1.Chart1.Gradient.EndColor := Shape3.Brush.Color;
  end;
end;

procedure TForm2.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog3.Execute then
  begin
    Shape3.Brush.Color := ColorDialog3.Color;
    Form1.Chart1.Gradient.StartColor := Shape2.Brush.Color;
    Form1.Chart1.Gradient.EndColor := Shape3.Brush.Color;
  end;
end;

procedure TForm2.SpinEdit3Change(Sender: TObject);
begin
  Form1.Chart1.View3DOptions.Rotation := SpinEdit3.Value;
end;

procedure TForm2.CheckBox5Click(Sender: TObject);
begin
  Form1.DirectoryListBox1.Visible := CheckBox5.Checked;
end;

procedure TForm2.CheckBox7Click(Sender: TObject);
begin
  Form1.Chart1.AutoSize := CheckBox7.Checked;
end;

procedure TForm2.CheckBox8Click(Sender: TObject);
begin
  Form1.Chart1.Foot.Visible := CheckBox8.Checked;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Form1.Chart1.BackImage.LoadFromFile(OpenDialog1.FileName);
    Image1.Picture.Bitmap.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Image1.Picture.Graphic := nil;
  Form1.Chart1.BackImage := nil;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Close;
end;

end.
