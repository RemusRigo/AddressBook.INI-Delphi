program AddressBook;

uses
  Forms,
  Dialogs,
  wndAgenda in 'Wnd\wndAgenda.pas' {frmAgenda},
  wndContact in 'Wnd\wndContact.pas' {frmContact},
  wndOptions in 'Wnd\wndOptions.pas' {frmOptions},
  clsFiles in '..\~\clsFiles.pas',
  wndAlarm in 'Wnd\wndAlarm.pas' {frmAlarm};

{$R *.res}

begin
   Application.Initialize;
   Application.MainFormOnTaskbar:=True;
   Application.Title:='AddressBook';
   Application.CreateForm(TfrmAgenda, frmAgenda);
  Application.Run;
end.
