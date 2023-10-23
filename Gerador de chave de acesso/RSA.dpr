program RSA;

uses
  Vcl.Forms,
  untCriptografiaRSA in 'untCriptografiaRSA.pas' {frmCriptografiaRSA};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCriptografiaRSA, frmCriptografiaRSA);
  Application.Run;
end.
