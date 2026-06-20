unit wndAgenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, ComCtrls, ToolWin, ActnList, ImgList, Menus;

type TfrmAgenda = class(TForm)
    lvContacts: TListView;
    tbMain: TToolBar;
    StatusBar: TStatusBar;
    tbMain_New: TToolButton;
    ActionList: TActionList;
    dlgSave: TSaveDialog;
    dlgOpen: TOpenDialog;
    acNew: TAction;
    mnuMain: TMainMenu;
    mnuMain_File: TMenuItem;
    mnuMain_File_Exit: TMenuItem;
    imgLst: TImageList;
    ToolButton1: TToolButton;
    acExit: TAction;
    mnuMain_File_New: TMenuItem;
    mnuMain_File_Sep1: TMenuItem;
    acOptions: TAction;
    ToolButton2: TToolButton;
    imgUpDown: TImageList;
   procedure FormCreate(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure lvContactsDblClick(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acOptionsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure lvContactsColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormResize(Sender: TObject);
   private
   public
      path   : String;
      crtLng : String;
      procedure ResizeColumns;
      procedure LoadSettings;
      procedure LoadLanguage;
      procedure CountContacts;
      procedure LoadContacts;
end;

var
   frmAgenda : TfrmAgenda;

implementation

uses
   clsFiles, wndContact, wndOptions, wndAlarm;

var
   srtAsc         : Boolean;
   lastSortCol    : Integer;

{$R *.dfm}

//-------------------------------------------------------------------------------------------------

function SortByColumn(Item1, Item2: TListItem; Data: integer): integer; stdcall;
begin
   if Data = 0 then
      Result:=AnsiCompareText(Item1.Caption, Item2.Caption)
   else
      Result:=AnsiCompareText(Item1.SubItems[Data-1], Item2.SubItems[Data-1]);
   if not srtAsc then
      Result:=-Result;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.ResizeColumns;
var
   colW : Integer;
begin
   colW:=frmAgenda.ClientWidth div 3 - 1;
   lvContacts.Columns[0].Width:=colW;
   lvContacts.Columns[1].Width:=colW;
   lvContacts.Columns[2].Width:=colW;
   lvContacts.Columns[3].Width:=0;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.LoadSettings;
var
   cfgIni : TIniFile;
begin
   cfgIni:=TIniFile.Create(path+'AddressBook.cfg');
   crtLng:=cfgIni.ReadString('Main', 'Language', 'English');
   cfgIni.Free;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.LoadLanguage;
begin

end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.CountContacts;
var
   cnt : Integer;
   sr  : TSearchRec;
begin
   cnt:=0;
   if FindFirst(path+'\Contacts\*.ini', faAnyFile-faDirectory, sr)=0 then
   begin
      repeat
         cnt:=cnt+1;
      until FindNext(sr)<>0;
      FindClose(sr);
   end;
   StatusBar.Panels[0].Text:='Contacts Found : '+IntToStr(cnt);
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.LoadContacts;
var
   sr  : TSearchRec;
   ini : TIniFile;
   li  : TListItem;
   s   : String;
begin
   lvContacts.Clear;
   CountContacts;
   if FindFirst(path+'\Contacts\*.ini', faAnyFile-faDirectory, sr)=0 then
   begin
      repeat
         ini:=TIniFile.Create(path+'Contacts\'+sr.Name);
         li:=lvContacts.Items.Add;
         li.ImageIndex:=-1;
         if ini.ValueExists('Main', 'FirstName') then
            li.Caption:=ini.ReadString('Main', 'FirstName', '')
         else
            li.Caption:='';
         if ini.ValueExists('Main', 'LastName') then
            li.SubItems.Add(ini.ReadString('Main', 'LastName', ''))
         else
            li.SubItems.Add('');
         if ini.ValueExists('Main', 'BirthY') then
            s:=IntToStr(ini.ReadInteger('Main', 'BirthY', 0))
         else
            s:='-';
         if ini.ValueExists('Main', 'BirthM') then
            s:=s+'.'+IntToStr(ini.ReadInteger('Main', 'BirthM', 0))
         else
            s:=s+'.'+'-';
         if ini.ValueExists('Main', 'BirthD') then
            s:=s+'.'+IntToStr(ini.ReadInteger('Main', 'BirthD', 0))
         else
            s:=s+'.'+'-';
         li.SubItems.Add(s);

         li.SubItems.Add(ini.FileName);

         ini.Free;
//         Files.DeleteAll(path+'Temp\', False);
      until FindNext(sr)<>0;
      FindClose(sr);
   end;
   lvContacts.CustomSort(@SortByColumn, 0);
   lvContacts.CustomSort(@SortByColumn, 1);
   ResizeColumns;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.lvContactsColumnClick(Sender: TObject; Column: TListColumn);
begin
   if lvContacts.Columns[Column.ID].ImageIndex=-1  then
      lvContacts.Columns[Column.ID].ImageIndex:=0
   else if lvContacts.Columns[Column.ID].ImageIndex=0 then
      lvContacts.Columns[Column.ID].ImageIndex:=1
   else if lvContacts.Columns[Column.ID].ImageIndex=1 then
      lvContacts.Columns[Column.ID].ImageIndex:=0;

   case Column.ID of

      0:
      begin
         lvContacts.Columns[1].ImageIndex:=-1;
         lvContacts.Columns[2].ImageIndex:=-1;
         lvContacts.Columns[3].ImageIndex:=-1;
      end;

      1:
      begin
         lvContacts.Columns[0].ImageIndex:=-1;
         lvContacts.Columns[2].ImageIndex:=-1;
         lvContacts.Columns[3].ImageIndex:=-1;
      end;

      2:
      begin
         lvContacts.Columns[0].ImageIndex:=-1;
         lvContacts.Columns[1].ImageIndex:=-1;
         lvContacts.Columns[3].ImageIndex:=-1;
      end;

      3:
      begin
         lvContacts.Columns[0].ImageIndex:=-1;
         lvContacts.Columns[1].ImageIndex:=-1;
         lvContacts.Columns[2].ImageIndex:=-1;
      end;
   end;
   if Column.Index=lastSortCol then
      srtAsc:=not srtAsc
   else
      lastSortCol:=Column.Index;
   TListView(Sender).CustomSort(@SortByColumn, Column.Index);
end;

procedure TfrmAgenda.lvContactsDblClick(Sender: TObject);
begin
   frmContact:=TFrmContact.Create(Self);
   frmContact.newContact:=False;
   frmContact.path:=path;
   frmContact.crtLng:=crtLng;
   frmContact.inFile:=lvContacts.Items.Item[lvContacts.ItemIndex].SubItems[2];
   frmContact.Show;
end;

procedure TfrmAgenda.ToolButton2Click(Sender: TObject);
begin
   frmAlarm:=TfrmAlarm.Create(Self);
   frmAlarm.ShowModal;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.acOptionsExecute(Sender: TObject);
begin
   frmOptions:=TfrmOptions.Create(Self);
   frmOptions.path:=path;
   frmOptions.crtLng:=crtLng;
   frmOptions.Show;
end;

procedure TfrmAgenda.acExitExecute(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TfrmAgenda.acNewExecute(Sender: TObject);
begin
   frmContact:=TFrmContact.Create(Self);
   frmContact.newContact:=True;
   frmContact.path:=path;
   frmContact.crtLng:=crtLng;
   frmContact.Show;
end;


//-------------------------------------------------------------------------------------------------

procedure TfrmAgenda.FormCreate(Sender: TObject);

begin
   if LowerCase(ParamStr(1))='/alarm' then
   begin
      frmAlarm:=TfrmAlarm.Create(Self);
      frmAlarm.ShowModal;
      Application.Terminate;
   end
   else
   begin
      path:=ExtractFilePath(ParamStr(0));
      if not (DirectoryExists(path+'Contacts')) then
         MkDir(path+'Contacts');
      if not (DirectoryExists(path+'Notes')) then
         MkDir(path+'Notes');
      if not (DirectoryExists(path+'Media')) then
         MkDir(path+'Media');
      frmAgenda.Caption:='Address Book v'+Files.Version.Full(ParamStr(0));
      LoadSettings;
      LoadLanguage;
      LoadContacts;
   end;
end;

procedure TfrmAgenda.FormResize(Sender: TObject);
begin
   ResizeColumns;
end;

procedure TfrmAgenda.FormShow(Sender: TObject);
begin

end;

//-------------------------------------------------------------------------------------------------

end.
