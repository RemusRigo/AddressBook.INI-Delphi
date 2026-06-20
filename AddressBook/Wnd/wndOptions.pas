unit wndOptions;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, ExtCtrls, StdCtrls, Buttons;

//-------------------------------------------------------------------------------------------------

type TfrmOptions = class(TForm)
   pnlOptions       : TPanel;
   grpBoxLanguage   : TGroupBox;
   comboBoxLanguage : TComboBox;
   bbtnOk           : TBitBtn;
   procedure bbtnOkClick(Sender: TObject);
   procedure FormShow(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
   public
      path   : String;
      crtLng : String;
end;

//-------------------------------------------------------------------------------------------------

var
   frmOptions : TfrmOptions;

//-------------------------------------------------------------------------------------------------

implementation

uses
   IniFiles;

{$R *.dfm}

//-------------------------------------------------------------------------------------------------

procedure TfrmOptions.bbtnOkClick(Sender: TObject);
var
   iniCfg : TIniFile;
begin
   iniCfg:=TIniFile.Create(path+'AddressBook.cfg');
   iniCfg.WriteString('Main', 'Language', comboBoxLanguage.Items.Strings[comboBoxLanguage.ItemIndex]);
   iniCfg.Free;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmOptions.FormShow(Sender: TObject);
var
   iniCfg : TIniFile;
   sr     : TSearchRec;
begin
   comboBoxLanguage.Items.Add('English (default)');
   if FindFirst(path+'\Language\*.ini', faAnyFile-faDirectory, sr)=0 then
   begin
      repeat
         comboBoxLanguage.Items.Add(sr.Name);
      until FindNext(sr)<>0;
      FindClose(sr);
   end;
   comboBoxLanguage.ItemIndex:=comboBoxLanguage.Items.IndexOf(crtLng);
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmOptions.FormCreate(Sender: TObject);
begin

//   regKey:=TRegistry.Create;
//   regKey.RootKey:=HKEY_CURRENT_USER;
//   regKey.OpenKey('Software\Remus Rigo Software\Agenda', TRUE);
//   if regKey.ValueExists('Language') then
//      crtLng:=regKey.ReadString('Language')
//   else
//      crtLng:='';
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin

end;

//-------------------------------------------------------------------------------------------------

end.
