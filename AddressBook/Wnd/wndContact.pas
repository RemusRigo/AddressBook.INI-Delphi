unit wndContact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, ExtCtrls, IniFiles;

type TfrmContact = class(TForm)
   edFileName: TEdit;
   lblFileName: TLabel;
   sbtnSave: TSpeedButton;
    pnlContact: TPanel;
    pnlFile: TPanel;
    pgCtrlContact: TPageControl;
    tsMain: TTabSheet;
    tsFamily: TTabSheet;
    grpName: TGroupBox;
    lblFirstName: TLabel;
    lblBirthName: TLabel;
    lblLastName: TLabel;
    lblTitle: TLabel;
    lblSuffix: TLabel;
    lblNickname: TLabel;
    edFirstName: TEdit;
    edBirthName: TEdit;
    edLastName: TEdit;
    edTitle: TEdit;
    edSuffix: TEdit;
    edNickname: TEdit;
    grpBoxDeath: TGroupBox;
    lblDeathDate: TLabel;
    lblDeathCountry: TLabel;
    lblDeathCounty: TLabel;
    lblDeathCity: TLabel;
    lblDeathY: TLabel;
    lblDeathM: TLabel;
    lblDeathD: TLabel;
    edDeathCountry: TEdit;
    edDeathCounty: TEdit;
    edDeathCity: TEdit;
    edDeathD: TEdit;
    edDeathY: TEdit;
    edDeathM: TEdit;
    grpBirth: TGroupBox;
    lblBirthDate: TLabel;
    lblBirthCountry: TLabel;
    lblBirthCounty: TLabel;
    lblBirthCity: TLabel;
    lblBirthD: TLabel;
    lblBirthM: TLabel;
    lblBirthY: TLabel;
    lblSign: TLabel;
    lblGender: TLabel;
    edBirthY: TEdit;
    edBirthCountry: TEdit;
    edBirthCounty: TEdit;
    edBirthCity: TEdit;
    edBirthM: TEdit;
    edBirthD: TEdit;
    cbSign: TComboBox;
    cbGender: TComboBox;
    pnlImage: TPanel;
    imgProfile: TImage;
    grpID: TGroupBox;
    lblPNC: TLabel;
    lblIDC: TLabel;
    edPNC: TEdit;
    edIDC: TEdit;
    memoNotes: TMemo;
    tsNotes: TTabSheet;
    grpFather: TGroupBox;
    lblFFirstName: TLabel;
    lblFLastName: TLabel;
    lblFBirthName: TLabel;
    edFFirstName: TEdit;
    edFLastName: TEdit;
    edFBirthName: TEdit;
    grpMother: TGroupBox;
    lblMFirstName: TLabel;
    lblMLastName: TLabel;
    lblMBirthName: TLabel;
    edMFirstName: TEdit;
    edMLastName: TEdit;
    edMBirthName: TEdit;
    grpHome: TGroupBox;
    lblHACountry: TLabel;
    lblHACounty: TLabel;
    lblHACity: TLabel;
    lblHAAddress: TLabel;
    lblHAZip: TLabel;
    lblHAPhone2: TLabel;
    lblHAPhone1: TLabel;
    edHCountry: TEdit;
    edHCounty: TEdit;
    edHCity: TEdit;
    edHAddress: TEdit;
    edHZip: TEdit;
    edHPhone2: TEdit;
    edHPhone1: TEdit;
    grpMartialStatus: TGroupBox;
    cbMartialStatus: TComboBox;
    grpAnniv: TGroupBox;
    lblAnnivD: TLabel;
    lblAnnivM: TLabel;
    lblAnnivY: TLabel;
    edAnnivD: TEdit;
    edAnnivM: TEdit;
    edAnnivY: TEdit;
    grpPartner: TGroupBox;
    lblPFirstName: TLabel;
    lblPLastName: TLabel;
    lblPBirthName: TLabel;
    edPFirstName: TEdit;
    edPLastName: TEdit;
    edPBirthName: TEdit;
    grpPhone: TGroupBox;
    lblPhoneInfo: TLabel;
    lblPhone: TLabel;
    edPhone1: TEdit;
    edPhoneInfo1: TEdit;
    edPhoneInfo2: TEdit;
    edPhone2: TEdit;
    edPhoneInfo3: TEdit;
    edPhone3: TEdit;
    edPhoneInfo4: TEdit;
    edPhone4: TEdit;
    edPhoneInfo5: TEdit;
    edPhone5: TEdit;
    edPhoneInfo6: TEdit;
    edPhone6: TEdit;
    tsMisc: TTabSheet;
    lblCompany: TLabel;
    edAcquainted: TEdit;
    edCompany: TEdit;
    edCategory: TEdit;
    lblAcquainted: TLabel;
    lblCategory: TLabel;
    lblJobTitle: TLabel;
    edJobTitle: TEdit;
    grpWork: TGroupBox;
    grpMisc: TGroupBox;
    tsInternet: TTabSheet;
    lblWorkPhone: TLabel;
    edWorkPhone: TEdit;
    edMail1: TEdit;
    edWeb1: TEdit;
    pgCtrlInternet: TPageControl;
    tsMail: TTabSheet;
    tsWeb: TTabSheet;
    edID1: TEdit;
    lblMail: TLabel;
    lblID: TLabel;
    lblType: TLabel;
    cbType1: TComboBox;
    edMail2: TEdit;
    edID2: TEdit;
    cbType2: TComboBox;
    edMail3: TEdit;
    edID3: TEdit;
    cbType3: TComboBox;
    edMail4: TEdit;
    edID4: TEdit;
    cbType4: TComboBox;
    edWeb2: TEdit;
    edWeb3: TEdit;
    edWeb4: TEdit;
   procedure FormShow(Sender: TObject);
   procedure sbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pgCtrlInternet_DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure pgCtrlContact_DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
   private
   public
      newContact : Boolean;
      path       : String;
      inFile     : String;
      ini        : TIniFile;
      nfo        : String;
      pk         : String;
      crtLng     : String;
      procedure LoadLanguage;
end;

var
   frmContact : TfrmContact;

implementation

uses
   axCtrls, clsFiles, wndAgenda;

{$R *.dfm}

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.pgCtrlContact_DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
   begin
      Control.Canvas.Brush.Color:=$00A7A7A7;
      Control.Canvas.FillRect(Rect);
   end
   else
   begin
      Control.Canvas.Brush.Color:=$00626262;
      Control.Canvas.Font.Color:=clWhite;
      Control.Canvas.FillRect(Rect);
   end;
   Control.Canvas.TextOut(Rect.left+5, Rect.top+3, pgCtrlContact.Pages[tabindex].Caption);
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.pgCtrlInternet_DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
   if Active then
   begin
      Control.Canvas.Brush.Color:=$00A7A7A7;
      Control.Canvas.FillRect(Rect);
   end
   else
   begin
      Control.Canvas.Brush.Color:=$00626262;
      Control.Canvas.Font.Color:=clWhite;
      Control.Canvas.FillRect(Rect);
   end;
   Control.Canvas.TextOut(Rect.left+5, Rect.top+3, pgCtrlInternet.Pages[tabindex].Caption);
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.LoadLanguage;
var
   iniLng : TINIFile;
begin
   iniLng:=TiniFile.Create(path+'\Language\'+crtLng);
   lblSign.Caption:=iniLng.ReadString('Language', 'Sign', 'Sign');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign1', 'Capricorn')+
      '[December 23 : January 20]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign2', 'Aquarius')+
      '[January 21 : February 19]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign3', 'Pisces')+
      '[February 20 : March 20]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign4', 'Aries')+
      '[March 21 : April 20]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign5', 'Taurus')+
      '[April 21 : May 21]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign6', 'Gemini')+
      '[May 22 : June 21]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign7', 'Cancer')+
      '[June 22 : July 22]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign8', 'Leo')+
      '[July 23 : August 21]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign9', 'Virgo')+
      '[August 22 : September 23]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign10', 'Libra')+
      '[September 24 : October 23]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign11', 'Scorpio')+
      '[October 24 : November 22]');
   cbSign.Items.Add(iniLng.ReadString('Language', 'Sign12', 'Sagittarius')+
      '[November 23 : December 22]');
   lblGender.Caption:=iniLng.ReadString('Language', 'Gender', 'Gender');
   cbGender.Items.Add(iniLng.ReadString('Language', 'Male', 'Male'));
   cbGender.Items.Add(iniLng.ReadString('Language', 'Female', 'Female'));
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'Single', 'Single'));
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'Commited', 'Commited'));
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'Married', 'Married'));
   cbMartialStatus.Items.Add(iniLng.ReadString('Language', 'Divorced', 'Divorced'));
   iniLng.Free;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.sbtnSaveClick(Sender: TObject);
var
//   lst : TStringList;
   s   : String;
begin
   if newContact then
   begin
      if edFileName.Text='' then
      begin
         ShowMessage('Enter a file name');
      end
      else
      begin
         inFile:=path+'Contacts\'+edFileName.Text;
         inFile:=ChangeFileExt(inFile, '.ini');
      end;
   end
   else
   begin
//      infile:='';
   end;

   ini:=TIniFile.Create(inFile);

   // Name
   if (edFirstName.Text<>'') or (ini.ValueExists('Main', 'FirstName')) then
      ini.WriteString('Main', 'FirstName', edFirstName.Text);
   if (edLastName.Text<>'') or (ini.ValueExists('Main', 'LastName')) then
      ini.WriteString('Main', 'LastName', edLastName.Text);
   if (edBirthName.Text<>'') or (ini.ValueExists('Main', 'BirthName')) then
      ini.WriteString('Main', 'BirthName', edBirthName.Text);
   if (edTitle.Text<>'') or (ini.ValueExists('Main', 'Title')) then
      ini.WriteString('Main', 'Title', edTitle.Text);
   if (edSuffix.Text<>'') or (ini.ValueExists('Main', 'Suffix')) then
      ini.WriteString('Main', 'Suffix', edSuffix.Text);
   if (edNickname.Text<>'') or (ini.ValueExists('Main', 'Nickname')) then
      ini.WriteString('Main', 'Nickname', edNickname.Text);

   // Birth
   if (edBirthD.Text<>'') or (ini.ValueExists('Main', 'BirthD')) then
      ini.WriteInteger('Main', 'BirthD', StrToInt(edBirthD.Text));
   if (edBirthM.Text<>'') or (ini.ValueExists('Main', 'BirthM')) then
      ini.WriteInteger('Main', 'BirthM', StrToInt(edBirthM.Text));
   if (edBirthY.Text<>'') or (ini.ValueExists('Main', 'BirthY')) then
      ini.WriteInteger('Main', 'BirthY', StrToInt(edBirthY.Text));
   if (edBirthCountry.Text<>'') or (ini.ValueExists('Main', 'BirthCountry')) then
      ini.WriteString('Main', 'BirthCountry', edBirthCountry.Text);
   if (edBirthCounty.Text<>'') or (ini.ValueExists('Main', 'BirthCounty')) then
      ini.WriteString('Main', 'BirthCounty', edBirthCounty.Text);
   if (edBirthCity.Text<>'') or (ini.ValueExists('Main', 'BirthCity')) then
      ini.WriteString('Main', 'BirthCity', edBirthCity.Text);

   // Sign
   if (cbSign.Text<>'') or (ini.ValueExists('Main', 'Sign')) then
      ini.WriteInteger('Main', 'Sign', cbSign.ItemIndex);

   // Gender
   if (cbGender.Text<>'') or (ini.ValueExists('Main', 'Gender')) then
      ini.WriteInteger('Main', 'Gender', cbGender.ItemIndex);

   // Father
   if (edFFirstName.Text<>'') or (ini.ValueExists('Family', 'FFirstName')) then
      ini.WriteString('Family', 'FFirstName', edFFirstName.Text);
   if (edFBirthName.Text<>'') or (ini.ValueExists('Family', 'FBirthName')) then
      ini.WriteString('Family', 'FBirthName', edFBirthName.Text);
   if (edFLastName.Text<>'') or (ini.ValueExists('Family', 'FLastName')) then
      ini.WriteString('Family', 'FLastName', edFLastName.Text);

   // Mother
   if (edMFirstName.Text<>'') or (ini.ValueExists('Family', 'MFirstName')) then
      ini.WriteString('Family', 'MFirstName', edMFirstName.Text);
   if (edMBirthName.Text<>'') or (ini.ValueExists('Family', 'MBirthName')) then
      ini.WriteString('Family', 'MBirthName', edMBirthName.Text);
   if (edMLastName.Text<>'') or (ini.ValueExists('Family', 'MLastName')) then
      ini.WriteString('Family', 'MLastName', edMLastName.Text);

   // Martial Status & Anniversary
   if (cbMartialStatus.Text<>'') or (ini.ValueExists('Family', 'MartialStatus')) then
      ini.WriteInteger('Family', 'MartialStatus', cbMartialStatus.ItemIndex);
   if (edAnnivY.Text<>'') or (ini.ValueExists('Family', 'AnnivY')) then
      ini.WriteInteger('Family', 'AnnivY', StrToInt(edAnnivY.Text));
   if (edAnnivM.Text<>'') or (ini.ValueExists('Family', 'AnnivM')) then
      ini.WriteInteger('Family', 'AnnivM', StrToInt(edAnnivM.Text));
   if (edAnnivD.Text<>'') or (ini.ValueExists('Family', 'AnnivD')) then
      ini.WriteInteger('Family', 'AnnivD', StrToInt(edAnnivD.Text));

   // Partner
   if (edPFirstName.Text<>'') or (ini.ValueExists('Family', 'PFirstName')) then
      ini.WriteString('Family', 'PFirstName', edPFirstName.Text);
   if (edPBirthName.Text<>'') or (ini.ValueExists('Family', 'PBirthName')) then
      ini.WriteString('Family', 'PBirthName', edPBirthName.Text);
   if (edPLastName.Text<>'') or (ini.ValueExists('Family', 'PLastName')) then
      ini.WriteString('Family', 'PLastName', edPLastName.Text);

   // Home
   if (edHAddress.Text<>'') or (ini.ValueExists('Home', 'Address')) then
      ini.WriteString('Home', 'Address', edHAddress.Text);
   if (edHCountry.Text<>'') or (ini.ValueExists('Home', 'Country')) then
      ini.WriteString('Home', 'Country', edHCountry.Text);
   if (edHCounty.Text<>'') or (ini.ValueExists('Home', 'County')) then
      ini.WriteString('Home', 'County', edHCounty.Text);
   if (edHCity.Text<>'') or (ini.ValueExists('Home', 'City')) then
      ini.WriteString('Home', 'City', edHCity.Text);
   if (edHZip.Text<>'') or (ini.ValueExists('Home', 'Zip')) then
      ini.WriteString('Home', 'Zip', edHZip.Text);
   if (edHPhone1.Text<>'') or (ini.ValueExists('Home', 'Phone1')) then
      ini.WriteString('Home', 'Phone1', edHPhone1.Text);
   if (edHPhone2.Text<>'') or (ini.ValueExists('Home', 'Phone2')) then
      ini.WriteString('Home', 'Phone2', edHPhone2.Text);

   // Phone
   if (edPhone1.Text<>'') or (ini.ValueExists('Phone', 'Phone1')) then
      ini.WriteString('Phone', 'Phone1', edPhone1.Text);
   if (edPhoneInfo1.Text<>'') or (ini.ValueExists('Phone', 'Info1')) then
      ini.WriteString('Phone', 'Info1', edPhoneInfo1.Text);
   if (edPhone2.Text<>'') or (ini.ValueExists('Phone', 'Phone2')) then
      ini.WriteString('Phone', 'Phone2', edPhone2.Text);
   if (edPhoneInfo2.Text<>'') or (ini.ValueExists('Phone', 'Info2')) then
      ini.WriteString('Phone', 'Info2', edPhoneInfo2.Text);
   if (edPhone3.Text<>'') or (ini.ValueExists('Phone', 'Phone3')) then
      ini.WriteString('Phone', 'Phone3', edPhone3.Text);
   if (edPhoneInfo3.Text<>'') or (ini.ValueExists('Phone', 'Info3')) then
      ini.WriteString('Phone', 'Info3', edPhoneInfo3.Text);
   if (edPhone4.Text<>'') or (ini.ValueExists('Phone', 'Phone4')) then
      ini.WriteString('Phone', 'Phone4', edPhone4.Text);
   if (edPhoneInfo4.Text<>'') or (ini.ValueExists('Phone', 'Info4')) then
      ini.WriteString('Phone', 'Info4', edPhoneInfo4.Text);
   if (edPhone5.Text<>'') or (ini.ValueExists('Phone', 'Phone5')) then
      ini.WriteString('Phone', 'Phone5', edPhone5.Text);
   if (edPhoneInfo5.Text<>'') or (ini.ValueExists('Phone', 'Info5')) then
      ini.WriteString('Phone', 'Info5', edPhoneInfo5.Text);

   // Work
   if (edCompany.Text<>'') or (ini.ValueExists('Work', 'Company')) then
      ini.WriteString('Work', 'Company', edCompany.Text);
   if (edJobTitle.Text<>'') or (ini.ValueExists('Work', 'JobTitle')) then
      ini.WriteString('Work', 'JobTitle', edJobTitle.Text);
   if (edWorkPhone.Text<>'') or (ini.ValueExists('Work', 'Phone')) then
      ini.WriteString('Work', 'Phone', edWorkPhone.Text);

   // Internet
   if (edMail1.Text<>'') or (ini.ValueExists('Internet', 'Mail1')) then
      ini.WriteString('Internet', 'Mail1', edMail1.Text);
   if (edID1.Text<>'') or (ini.ValueExists('Internet', 'ID1')) then
      ini.WriteString('Internet', 'ID1', edID1.Text);
   if (cbType1.Text<>'') or (ini.ValueExists('Internet', 'Type1')) then
      ini.WriteString('Internet', 'Type1', cbType1.Text);
   if (edMail2.Text<>'') or (ini.ValueExists('Internet', 'Mail2')) then
      ini.WriteString('Internet', 'Mail2', edMail2.Text);
   if (edID2.Text<>'') or (ini.ValueExists('Internet', 'ID2')) then
      ini.WriteString('Internet', 'ID2', edID2.Text);
   if (cbType2.Text<>'') or (ini.ValueExists('Internet', 'Type2')) then
      ini.WriteString('Internet', 'Type2', cbType2.Text);
   if (edMail3.Text<>'') or (ini.ValueExists('Internet', 'Mail3')) then
      ini.WriteString('Internet', 'Mail3', edMail3.Text);
   if (edID3.Text<>'') or (ini.ValueExists('Internet', 'ID3')) then
      ini.WriteString('Internet', 'ID3', edID3.Text);
   if (cbType3.Text<>'') or (ini.ValueExists('Internet', 'Type3')) then
      ini.WriteString('Internet', 'Type3', cbType1.Text);
   if (edMail4.Text<>'') or (ini.ValueExists('Internet', 'Mail4')) then
      ini.WriteString('Internet', 'Mail4', edMail1.Text);
   if (edID4.Text<>'') or (ini.ValueExists('Internet', 'ID4')) then
      ini.WriteString('Internet', 'ID4', edID4.Text);
   if (cbType4.Text<>'') or (ini.ValueExists('Internet', 'Type4')) then
      ini.WriteString('Internet', 'Type4', cbType4.Text);

   if (edWeb1.Text<>'') or (ini.ValueExists('Internet', 'Web1')) then
      ini.WriteString('Internet', 'Web1', edWeb1.Text);
   if (edWeb2.Text<>'') or (ini.ValueExists('Internet', 'Web2')) then
      ini.WriteString('Internet', 'Web2', edWeb2.Text);
   if (edWeb3.Text<>'') or (ini.ValueExists('Internet', 'Web3')) then
      ini.WriteString('Internet', 'Web3', edWeb3.Text);
   if (edWeb4.Text<>'') or (ini.ValueExists('Internet', 'Web4')) then
      ini.WriteString('Internet', 'Web4', edWeb4.Text);

   // Misc
   if (edCategory.Text<>'') or (ini.ValueExists('Misc', 'Category')) then
      ini.WriteString('Misc', 'Category', edCategory.Text);
   if (edAcquainted.Text<>'') or (ini.ValueExists('Misc', 'Acquainted')) then
      ini.WriteString('Misc', 'Acquainted', edAcquainted.Text);

   ini.Free;
   Close;

   s:=ChangeFileExt(path+'Notes\'+ExtractFileName(inFile), '.txt');
   if (memoNotes.Lines.Count>0) or (FileExists(s)) then
   begin
      memoNotes.Lines.SaveToFile(s);
   end;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.FormShow(Sender: TObject);
var
   s : String;
   img : TOleGraphic;
   fs  : TFileStream;
begin
   if (newContact=False) then
   begin
      ini:=TIniFile.Create(inFile);
      edFileName.ReadOnly:=True;
      edFileName.Text:=ExtractFileName(inFile);

      // Name
      if ini.ValueExists('Main', 'FirstName') then
         edFirstName.Text:=ini.ReadString('Main', 'FirstName', '');
      if ini.ValueExists('Main', 'LastName') then
         edLastName.Text:=ini.ReadString('Main', 'LastName', '');
      if ini.ValueExists('Main', 'LastName') then
         edBirthName.Text:=ini.ReadString('Main', 'BirthName', '');
      if ini.ValueExists('Main', 'Title') then
         edTitle.Text:=ini.ReadString('Main', 'Title', '');
      if ini.ValueExists('Main', 'Suffix') then
         edSuffix.Text:=ini.ReadString('Main', 'Suffix', '');
      if ini.ValueExists('Main', 'Nickname') then
         edNickname.Text:=ini.ReadString('Main', 'Nickname', '');

      // Birth
      if ini.ValueExists('Main', 'BirthD') then
         edBirthD.Text:=ini.ReadString('Main', 'BirthD', '');
      if ini.ValueExists('Main', 'BirthM') then
         edBirthM.Text:=ini.ReadString('Main', 'BirthM', '');
      if ini.ValueExists('Main', 'BirthY') then
         edBirthY.Text:=ini.ReadString('Main', 'BirthY', '');
      if ini.ValueExists('Main', 'BirthCountry') then
         edBirthCountry.Text:=ini.ReadString('Main', 'BirthCountry', '');
      if ini.ValueExists('Main', 'BirthCounty') then
         edBirthCounty.Text:=ini.ReadString('Main', 'BirthCounty', '');
      if ini.ValueExists('Main', 'BirthCity') then
         edBirthCity.Text:=ini.ReadString('Main', 'BirthCity', '');

      // Sign
      if ini.ValueExists('Main', 'Sign') then
         cbSign.ItemIndex:=ini.ReadInteger('Main', 'Sign', -1);

      // Gender
      if ini.ValueExists('Main', 'Gender') then
         cbGender.ItemIndex:=ini.ReadInteger('Main', 'Gender', -1);

      // Father
      if ini.ValueExists('Family', 'FFirstName') then
         edFFirstName.Text:=ini.ReadString('Family', 'FFirstName', '');
      if ini.ValueExists('Family', 'FBirthName') then
         edFBirthName.Text:=ini.ReadString('Family', 'FBirthName', '');
      if ini.ValueExists('Family', 'FLastName') then
         edFLastName.Text:=ini.ReadString('Family', 'FLastName', '');

      // Mother
      if ini.ValueExists('Family', 'MFirstName') then
         edMFirstName.Text:=ini.ReadString('Family', 'MFirstName', '');
      if ini.ValueExists('Family', 'MBirthName') then
         edMBirthName.Text:=ini.ReadString('Family', 'MBirthName', '');
      if ini.ValueExists('Family', 'MLastName') then
         edMLastName.Text:=ini.ReadString('Family', 'MLastName', '');

      // Martial Status & Anniversary
      if ini.ValueExists('Family', 'MartialStatus') then
         cbMartialStatus.ItemIndex:=ini.ReadInteger('Family', 'MartialStatus', 0);
      if ini.ValueExists('Family', 'AnnivY') then
         edAnnivY.Text:=IntToStr(ini.ReadInteger('Family', 'AnnivY', 0));
      if ini.ValueExists('Family', 'AnnivM') then
         edAnnivM.Text:=IntToStr(ini.ReadInteger('Family', 'AnnivM', 0));
      if ini.ValueExists('Family', 'AnnivD') then
         edAnnivD.Text:=IntToStr(ini.ReadInteger('Family', 'AnnivD', 0));

      // Partner
      if ini.ValueExists('Family', 'PFirstName') then
         edPFirstName.Text:=ini.ReadString('Family', 'PFirstName', '');
      if ini.ValueExists('Family', 'PBirthName') then
         edPBirthName.Text:=ini.ReadString('Family', 'PBirthName', '');
      if ini.ValueExists('Family', 'PLastName') then
         edPLastName.Text:=ini.ReadString('Family', 'PLastName', '');

       // Home
      if ini.ValueExists('Home', 'Address') then
         edHAddress.Text:=ini.ReadString('Home', 'Address', '');
      if ini.ValueExists('Home', 'Country') then
         edHCountry.Text:=ini.ReadString('Home', 'Country', '');
      if ini.ValueExists('Home', 'County') then
         edHCounty.Text:=ini.ReadString('Home', 'County', '');
      if ini.ValueExists('Home', 'City') then
         edHCity.Text:=ini.ReadString('Home', 'City', '');
      if ini.ValueExists('Home', 'Zip') then
         edHZip.Text:=ini.ReadString('Home', 'Zip', '');
      if ini.ValueExists('Home', 'Phone1') then
         edHPhone1.Text:=ini.ReadString('Home', 'Phone1', '');
      if ini.ValueExists('Home', 'Phone2') then
         edHPhone2.Text:=ini.ReadString('Home', 'Phone2', '');

      // Phone
      if ini.ValueExists('Phone', 'Phone1') then
         edPhone1.Text:=ini.ReadString('Phone', 'Phone1', '');
      if ini.ValueExists('Phone', 'Info1') then
         edPhoneInfo1.Text:=ini.ReadString('Phone', 'Info1', '');
      if ini.ValueExists('Phone', 'Phone2') then
         edPhone2.Text:=ini.ReadString('Phone', 'Phone2', '');
      if ini.ValueExists('Phone', 'Info2') then
         edPhoneInfo2.Text:=ini.ReadString('Phone', 'Info2', '');
      if ini.ValueExists('Phone', 'Phone3') then
         edPhone3.Text:=ini.ReadString('Phone', 'Phone3', '');
      if ini.ValueExists('Phone', 'Info3') then
         edPhoneInfo3.Text:=ini.ReadString('Phone', 'Info3', '');
      if ini.ValueExists('Phone', 'Phone4') then
         edPhone4.Text:=ini.ReadString('Phone', 'Phone4', '');
      if ini.ValueExists('Phone', 'Info4') then
         edPhoneInfo4.Text:=ini.ReadString('Phone', 'Info4', '');
      if ini.ValueExists('Phone', 'Phone5') then
         edPhone5.Text:=ini.ReadString('Phone', 'Phone5', '');
      if ini.ValueExists('Phone', 'Info5') then
         edPhoneInfo5.Text:=ini.ReadString('Phone', 'Info5', '');

       // Work
      if ini.ValueExists('Work', 'Company') then
         edCompany.Text:=ini.ReadString('Work', 'Company', '');
      if ini.ValueExists('Work', 'JobTitle') then
         edJobTitle.Text:=ini.ReadString('Work', 'JobTitle', '');
      if ini.ValueExists('Work', 'Phone') then
         edWorkPhone.Text:=ini.ReadString('Work', 'Phone', '');

      // Internet
      if ini.ValueExists('Internet', 'Mail1') then
         edMail1.Text:=ini.ReadString('Internet', 'Mail1', '');
      if ini.ValueExists('Internet', 'ID1') then
         edID1.Text:=ini.ReadString('Internet', 'ID1', '');
      if ini.ValueExists('Internet', 'Type1') then
         cbType1.Text:=ini.ReadString('Internet', 'Type1', '');
      if ini.ValueExists('Internet', 'Mail2') then
         edMail2.Text:=ini.ReadString('Internet', 'Mail2', '');
      if ini.ValueExists('Internet', 'ID2') then
         edID2.Text:=ini.ReadString('Internet', 'ID2', '');
      if ini.ValueExists('Internet', 'Type2') then
         cbType2.Text:=ini.ReadString('Internet', 'Type2', '');
      if ini.ValueExists('Internet', 'Mail3') then
         edMail3.Text:=ini.ReadString('Internet', 'Mail3', '');
      if ini.ValueExists('Internet', 'ID3') then
         edID3.Text:=ini.ReadString('Internet', 'ID3', '');
      if ini.ValueExists('Internet', 'Type3') then
         cbType3.Text:=ini.ReadString('Internet', 'Type3', '');
      if ini.ValueExists('Internet', 'Mail4') then
         edMail4.Text:=ini.ReadString('Internet', 'Mail4', '');
      if ini.ValueExists('Internet', 'ID4') then
         edID4.Text:=ini.ReadString('Internet', 'ID4', '');
      if ini.ValueExists('Internet', 'Type4') then
         cbType4.Text:=ini.ReadString('Internet', 'Type4', '');

      if ini.ValueExists('Internet', 'Web1') then
         edWeb1.Text:=ini.ReadString('Internet', 'Web1', '');
      if ini.ValueExists('Internet', 'Web2') then
         edWeb2.Text:=ini.ReadString('Internet', 'Web2', '');
      if ini.ValueExists('Internet', 'Web3') then
         edWeb3.Text:=ini.ReadString('Internet', 'Web3', '');
      if ini.ValueExists('Internet', 'Web4') then
         edWeb4.Text:=ini.ReadString('Internet', 'Web4', '');

      // Misc
      if ini.ValueExists('Misc', 'Category') then
         edCategory.Text:=ini.ReadString('Misc', 'Category', '');
      if ini.ValueExists('Misc', 'Acquainted') then
         edAcquainted.Text:=ini.ReadString('Misc', 'Acquainted', '');

      ini.Free;//
   end
   else
   begin
      s:=ChangeFileExt(path+'Notes\'+ExtractFileName(inFile), '.txt');
      if FileExists(s) then
         memoNotes.Lines.LoadFromFile(s);
   end;
   s:=ChangeFileExt(path+'Media\'+ExtractFileName(inFile), '');
   s:=s+'_profile.jpg';
   if FileExists(s) then
   begin
      try
         img:=TOleGraphic.Create;
         fs:=TFileStream.Create(s, fmOpenRead or fmSharedenyNone);
         img.LoadFromStream(fs);
         imgProfile.Picture.Assign(img);
      finally
         img.Free;
         fs.Free;
      end;
   end;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   frmAgenda.LoadContacts;
end;

//-------------------------------------------------------------------------------------------------

procedure TfrmContact.FormCreate(Sender: TObject);
begin
   pgCtrlContact.ActivePageIndex:=0;
   pgCtrlInternet.ActivePageIndex:=0;
   LoadLanguage
end;

//-------------------------------------------------------------------------------------------------

end.
