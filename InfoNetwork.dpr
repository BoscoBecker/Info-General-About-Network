program InfoNetwork;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  NETWORKLIST_TLB in 'TBLIST\NETWORKLIST_TLB.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Dark');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
