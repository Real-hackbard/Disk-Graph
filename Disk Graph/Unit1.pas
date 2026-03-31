{ Use :

  Select a folder on the left and click the 'Scan' button.
  or
  Right-click on a section of the pie chart to browse it.
  Right-click on the pie chart to go up one level in the directory hierarchy.

  The contents of the root directory (actually the entire disk) are stored
  (this takes quite a while the first time)
  which poses a problem if you switch disks (only the contents are stored)
  The free space checkbox, if selected, allows the free portion of the disk
  to be displayed when the root directory is examined
}

{ Principle :

  This program, like most programs that deal with the hard drive,
  uses a recursive algorithm. In this case, it's the FindRep procedure
  which calls itself.

  Indeed, to browse a hard drive (or a directory on that drive), you
  list the files and subdirectories, then for each of these,
  their files and subdirectories, and so on... until
  you reach the end of a branch, where there are no more subdirectories.

  Therefore, only one procedure is needed, listing the files and subdirectories
  of a directory, this procedure being re-executed for each of the subdirectories
  then considered as the base directory.

  There are a few precautions to take with this type of procedure.

  To execute correctly, the recursive procedure must not have its environment
  modified by a call to itself. It is necessary to declare all variables used
  by this procedure precisely.

  Here, in the FindRep procedure, the variable Sd (TSearchRec) is modified
  within the procedure and is used both before and after the recursive call.
  Therefore, it MUST be declared as a local variable. Each time the procedure
  is called, a new SD variable is created, specific to that execution.

  However, the variable R (String) could have been declared global. It
  is only used to pass the name of the directory to be explored, and its value
  upon return from the FindRep procedure is no longer important.

  "So why make this distinction? Just declare everything locally
  and we won't have any problems!" you might say. The problem is precisely
  that we might have problems. The local variables of a procedure or function
  are created on the stack (a specific memory area), and the number of nested calls
  of a recursive function is neither known nor controlled. While this number isn't
  very large when traversing a disk's directory tree (that's its greatest
  depth), it's a different story with the recursive sorting algorithm
  quicksort (see the Delphi Threads demo) when manipulating
  large sets. We then risk encountering the message "Stack Overflow".

  And then...
}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FileCtrl, ExtCtrls, Grids, Outline, DirOutln, ComCtrls,
  IniFiles, OleCtrls, Chart, TeeFunci, TeEngine, Series, TeeProcs, XPMan,
  Spin, ShellApi, Menus, ImgList, ComObj;

 Const
   Ech = 10;

type
   TDisk = record
     Compte : Int64;
     Rep : String;
   end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Edit1: TEdit;
    Chart1: TChart;
    Series1: TPieSeries;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    TeeFunction1: TAddTeeFunction;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    ComboBox1: TComboBox;
    Label3: TLabel;
    PopupMenu1: TPopupMenu;
    P1: TMenuItem;
    B1: TMenuItem;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure Chart1ClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure DirectoryListBox1Click(Sender: TObject);
    procedure Chart1Click(Sender: TObject);
  private
    { Declarations privates }
  public
    { Declarations public }
    List : TList;
    ListRoot : TList;
    ListRootDone : Boolean;
    MyPalette : Array [0..31] of TColor;
    Current : String;
    PosFree : Integer;
    PosLocation : Integer;
  end;

var
  Form1: TForm1;
  Computer : Int64;

implementation

uses Unit2;

{$R *.DFM}

Const
  Colors : Array[0..31] of TColor =
      ($FF0000,$FF8000,$FFFF00,$80FF00,$00FF00,$00FF80,$00FFFF,$0080FF,$0000FF,
      $8000FF,$800080,
      $C00000,$C08000,$C0C000,$80C000,$00C000,$00C080,$00C0C0,$0080C0,$0000C0,
      $8000C0,$400040,
      $800000,$806000,$808000,$608000,$008000,$008060,$008080,$006080,$000080,
      $600080);

procedure PropertiesDialog(const aFilename: string);
var
  sei: ShellExecuteInfo;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.lpFile := PChar(aFilename);
  sei.lpVerb := 'properties';
  sei.fMask  := SEE_MASK_INVOKEIDLIST;
  ShellExecuteEx(@sei);
end;

function FolderSize(FolderName: string): Int64;
var
  fldr, fso: OleVariant;
begin
  fso := CreateOleObject('Scripting.FileSystemObject');
  fldr := fso.GetFolder(FolderName);

  result := fldr.size;
end;

procedure findrep(nom:string);
var
  r:string;
  s,sd:Tsearchrec;
  Resultat:int64;
begin
  // Searching for subdirectories
  Resultat:=findfirst(nom+'*.',faDirectory+faReadOnly,sd);
  while (Resultat=0)  do
    begin
      if boolean(sd.attr and faDirectory) and (sd.name[1]<>'.') then
        begin
          r:=nom+sd.name+'\';
          findrep(r);  // Recursive call: traversing subdirectories
        end;
      Form1.ProgressBar1.Position:= (Form1.ProgressBar1.Position+1) mod 25;
      Form1.Label2.Caption := IntToStr(Form1.ProgressBar1.Position);
      //Application.ProcessMessages;  // This slows down the program, but makes it more accurate.
      Resultat:=findnext(sd);         // Following
    end;
  findClose(sd);

  // Searching for files
  case Form1.ComboBox1.ItemIndex of
  0 : Resultat:=findfirst(Nom+'*.*',$F,s);
  1 : Resultat:=findfirst(Nom+'*.exe',$F,s);
  2 : Resultat:=findfirst(Nom+'*.mp4',$F,s);
  3 : Resultat:=findfirst(Nom+'*.mp3',$F,s);
  4 : Resultat:=findfirst(Nom+'*.bmp',$F,s);
  5 : Resultat:=findfirst(Nom+'*.dll',$F,s);
  6 : Resultat:=findfirst(Nom+'*.txt',$F,s);
  7 : Resultat:=findfirst(Nom+'*.ini',$F,s);
  end;

    while Resultat=0 do
      begin
        // Total file sizes
        Computer:=Computer + (trunc(S.Size / 4096)+1)*4096;
        Resultat:=findnext(s); // Following
      end;
  findClose(s);
end;

// Browsing the home directory
procedure findRootRep(nom:string);
var
  r:string;
  s,sd:Tsearchrec;
  n,Resultat:int64;
  Ptr : ^TDisk;
  df : int64;
begin
  if length(nom)=3 then  // if root C:\ or D:\ or ...
    begin
      new(ptr);
      df:=DiskFree(0);          // Free space
      Ptr.Compte:=df div 1024 ; // in kb
      ptr.rep:='libre';         // Fake name
      Form1.List.Add(ptr);      // Free space
    end;

  // Search subdirectories
  Resultat:=findfirst(nom+'*.',faAnyFile,sd);
  while (Resultat=0)  do
    begin
      if boolean(sd.attr and faDirectory) and (sd.name[1]<>'.') then
        begin
          Computer :=0;
          r:=nom+sd.name+'\';
          findrep(r);  // subdirectory browse
          new(ptr);
          Ptr.Compte:=Computer div 1024;  // Size (ko)
          ptr.rep:=sd.name;               // Subdirectory name
          Form1.List.Add(ptr);            // Added to list
          Form1.ProgressBar1.Position:= (Form1.ProgressBar1.Position+1) mod 25;
        end;
      Resultat:=findnext(sd); // Next
    end;
  findClose(sd);
  n:=0;
  // Search files
    case Form1.ComboBox1.ItemIndex of
  0 : Resultat:=findfirst(Nom+'*.*',$F,s);
  1 : Resultat:=findfirst(Nom+'*.exe',$F,s);
  2 : Resultat:=findfirst(Nom+'*.mp4',$F,s);
  3 : Resultat:=findfirst(Nom+'*.mp3',$F,s);
  4 : Resultat:=findfirst(Nom+'*.bmp',$F,s);
  5 : Resultat:=findfirst(Nom+'*.dll',$F,s);
  6 : Resultat:=findfirst(Nom+'*.txt',$F,s);
  7 : Resultat:=findfirst(Nom+'*.ini',$F,s);
  end;

     while Resultat=0 do
      begin
          begin
            Computer:=Computer + (trunc(S.Size / 4096)+1)*4096;
            n:=n + (trunc(S.Size / 4096)+1)*4096; // Rounded up
          end;
        Resultat:=findnext(s);
      end;
  findClose(s);
  New(ptr);
  Ptr.Compte:=n div 1024;              //  Size
  ptr.rep:=Nom;                        //  Directory name
  Form1.List.Add(Ptr);
  Form1.ProgressBar1.Position:= 0;
end;

Procedure Cherche;
var
  s : string;
begin
  Computer :=0;
  s:=Form1.Edit1.Text;
  if s[length(s)]<>'\' then
    s:=s+'\';
  findRootrep(s);  // Directory tour
end;

Function Folder (a,b : pointer) : Integer; // To sort the list by size
var
  p1,p2 : ^TDisk;
begin
  p1:=a;p2:=b;
  if p1^.Compte<p2^.Compte then result := 1;
  if p1^.Compte=p2^.Compte then result :=  0;
  if p1^.Compte>p2^.Compte then result := -1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : integer;
begin

  DoubleBuffered := true;
  Chart1.Title.Font.Color := clBlack;
  Chart1.Title.Font.Name := 'Verdana';
  Chart1.Title.Font.Color := clSilver;
  Chart1.Title.Font.Size := 18;

  for i:=0 to 31 do
    MyPalette[i]:=ColorPalette[i+1];

  MyPalette[13]:=$00404040;
  Edit1.Text:= DirectoryListBox1.Directory;
  Current:= Edit1.Text;

  if Current[length(Current)]='\' then
    delete(Current,length(Current),1);

  // Adjust 3D depth (thickness of bars/pies)
  Chart1.Chart3DPercent := 50; // Percentage value

  List:=TList.Create;
  ListRoot:=TList.Create;

  Edit1.Text:=GetCurrentDir;
  Edit1.Text:= DirectoryListBox1.Directory;

  Chart1.View3DOptions.Zoom:= Chart1.width div ech;
  ListRootDone:=False;
  Button1Click(Self);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Chart1.View3DOptions.Zoom:= Chart1.width div ech;
end;

// Browse button
procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
  Edit1.Text:= DirectoryListBox1.Directory;
end;

procedure TForm1.DriveComboBox1Change(Sender: TObject);
var
  BuffNom : Array[0..255]of Char; // Buffer for GetVolumeInformation
  BuffSys : Array[0..255]of Char; // Buffer for GetVolumeInformation
  Serie, Long, Flags : DWord;     // for GetVolumeInformation
  TDrive  : String;               // To store volume types
  FreeBytesAvailable, TotalNumberofBytes, TotalNumberofFreeBytes : TLargeInteger;

  // This procedure will be automatically executed each time
  // the component is changed.
  // TDriveComboBox.
begin
  DirectoryListBox1.Directory:=DriveComboBox1.Drive+':\';
  ListRootDone := False;

  // We retrieve the information from the selected volume in the TDriveComboBox
  GetVolumeInformation(PChar(DriveComboBox1.Drive+':\')
                         ,@BuffNom,SizeOf(BuffNom) // will contain the name
                         ,@Serie                   // will contain the serial number
                         ,Long
                         ,Flags
                         ,@BuffSys,SizeOf(BuffSys)); // and the file type

  // We retrieve the information about the type of volume
  // selected in the TDriveComboBox
  case GetDriveType(PChar(DriveComboBox1.Drive+':\')) of
    DRIVE_UNKNOWN     : TDrive := 'Unknown reader'; // puts the result into a String
    DRIVE_NO_ROOT_DIR : TDrive := 'Invalid root path';
    DRIVE_REMOVABLE   : TDrive := 'Removable Disk';
    DRIVE_FIXED       : TDrive := 'Hard Drive';
    DRIVE_REMOTE      : TDrive := 'Internet disk';
    DRIVE_CDROM       : TDrive := 'CD player';
    DRIVE_RAMDISK     : TDrive := 'RAM disk';
  end;


  // The name of the selected volume is displayed.
  StatusBar1.Panels[1].Text := BuffNom;

  // The file system (NTFS, FAT32) is displayed.
  StatusBar1.Panels[3].Text := BuffSys;

  // The serial number of the volume is displayed.
  StatusBar1.Panels[5].Text := IntToStr(Serie);

  // Determine drive type
  StatusBar1.Panels[7].Text := TDrive;

  // If the string is not NULL, then the volume exists.
  if TDrive <>'' then
  // GetDiskFreeSpaceEx is used to process volumes larger than 2GB.
  GetDiskFreeSpaceEx(PChar(DriveComboBox1.Drive+':\'),
                           FreeBytesAvailable,
                           TotalNumberofBytes,
                           @TotalNumberofFreeBytes);


  // The number of free bytes is displayed.
  StatusBar1.Panels[9].Text := IntToStr(FreeBytesAvailable div 1000000000)+' GB';

  // The total volume capacity is displayed in bytes.
  StatusBar1.Panels[11].Text := IntToStr(TotalNumberOfBytes div 1000000000)+' GB';
end;

procedure TForm1.Chart1ClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  L : Integer;
  s : string;
begin
  // If left button browse subdirectory clicked
  if Button=mbLeft then
    begin
      l:=Series.Clicked(x,y);
      s:=TDisk(List.Items[l]^).Rep;
      if (Form2.CheckBox2.checked) and (s='libre') then
        exit;
      if (PosFree>=0) and (l>=PosFree) and (not Form2.CheckBox2.checked) then
        Inc(l);
      if (l=PosLocation) then
        exit;
      if (l<List.Count) then
        begin
          s:=TDisk(List.Items[l]^).Rep;
          if (copy(s,2,2)<>':\') and (s<>'libre') then
             begin
               DirectoryListBox1.Directory:=Current+'\'+s;
               Button1Click(Self);
             end;
        end;
    end;
  // If you right-click, you go up one level in the tree structure.
  if Button=mbRight then
    begin
      if pos('\',Current)>1 then
        begin
          repeat
            delete(Current,length(Current),1);
          until Current[length(Current)]='\';
          if Current<>'C:\' then
            delete(Current,length(Current),1);
          DirectoryListBox1.Directory:=Current;
          Button1Click(Self);
        end;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 i, size : InTeger;
 x : int64;
 Ptr:^TDisk;
 Racine : boolean;
begin
  Screen.Cursor := crHourGlass;
  Chart1.Title.Text[0]:= 'searching, please wait..';
  Application.ProcessMessages;

  PosFree:=-1;
  Current:= Edit1.Text;
  if Current[length(Current)]='\' then
    delete(Current,length(Current),1);
  if not ListRootDone or (length(Current)>2) then
    begin
      List.Clear;           // Clear the results list
      Racine:=False;
      Cherche;              // Course
      List.Sort(Folder);    // Sort by size
      if (length(Current)=2) and (pos(':',Current)=2) then
        begin               // Root C:, D: or X:
          ListRoot.Clear;   // We erase
          for i:=0 to List.Count-1 do   // We're copying this for our records.
            begin
              New(Ptr);
              Ptr^:=TDisk(List.Items[i]^);
              ListRoot.Add(Ptr);
            end;
          ListRootDone:=True;  // That's it, we've got the root memorized.
          Racine:=True;
        end;
    end
  else
    begin
      List.Clear;                // We retrieve the stored results for the root
      for i:=0 to ListRoot.Count-1 do
        begin
          New(Ptr);
          Ptr^:=TDisk(ListRoot.Items[i]^);
          List.Add(Ptr);
          Racine:=True;
        end;
    end;
  // Camembert drawing preparation - series 1
  series1.Clear;
  for i:=0 to List.Count-1 do
    begin
      With Series1 do
        if TDisk(List.Items[i]^).rep<>'free' then
          begin
           add(TDisk(List.Items[i]^).Compte /1024,
               TDisk(List.Items[i]^).rep,MyPalette[i]);
           if pos(':\',TDisk(List.Items[i]^).rep)>0 then
             PosLocation:=i;
          end
       else
        begin
          if Form2.CheckBox2.Checked and Racine then
               add(TDisk(List.Items[i]^).Compte /1024,
                          TDisk(List.Items[i]^).rep,clSilver);
             PosFree:=i;
           end;
    end;
  x:=0;
  for i:=0 to list.Count-1 do
    x:=x+ TDisk(List.Items[i]^).Compte;
  Chart1.Title.Text[0]:= IntToStr(x div 1024  )+' Mb';
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  try
    if SaveDialog1.Execute then
    begin
      bmp := TBitmap.Create;
      bmp.Height := Chart1.Height;
      bmp.Width := Chart1.Width;
      Chart1.Draw(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));

      case Form2.ComboBox1.ItemIndex of
      0 : bmp.PixelFormat := pf24bit;
      1 : bmp.PixelFormat := pf32bit;
      end;

      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    end;
  finally
    bmp.Free;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  DriveComboBox1.OnChange(sender);
  StatusBar1.SetFocus;
end;

procedure TForm1.P1Click(Sender: TObject);
begin
  PropertiesDialog(Edit1.Text);
end;

procedure TForm1.B1Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar('explorer'),
        // For higher-level compilers, use PAnsiChar.
        PChar(Edit1.Text), nil, SW_SHOWNORMAL);
end;

procedure TForm1.DirectoryListBox1Click(Sender: TObject);
begin
  DirectoryListBox1.Directory := DirectoryListBox1.GetItemPath(DirectoryListBox1.ItemIndex);

  if Form2.CheckBox6.Checked = true then
  begin
    Button1Click(self);
  end;
end;

procedure TForm1.Chart1Click(Sender: TObject);
var
  size : integer;

begin
  if Form2.CheckBox8.Checked = true then
  begin
    Chart1.Foot.Text.Clear;
    Chart1.Foot.Text.Append(IntToStr(FolderSize(Edit1.Text))+' Byte');
    Chart1.Foot.Text.Append('');
  end;
end;

end.
