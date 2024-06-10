unit uMadeireiraCalculoVolume;

interface

type

  TMadeireiraCalculoVolume = Class

    private

      class var espessura: real;
      class var largura: real;
      class var comprimento: real;

    public

      class function calcularVolume(): real;

      class procedure setEspessura(pEspessura: real);
      class procedure setLargura(pLargura: real);
      class procedure setComprimento(pComprimento: real);

  end;

implementation

{ TMadeireiraCalculoVolume }

class function TMadeireiraCalculoVolume.calcularVolume: real;
begin
  result := espessura * largura * comprimento;
end;

class procedure TMadeireiraCalculoVolume.setComprimento(pComprimento: real);
begin
  comprimento:= pComprimento;
end;

class procedure TMadeireiraCalculoVolume.setEspessura(pEspessura: real);
begin
  espessura:= pEspessura;
end;

class procedure TMadeireiraCalculoVolume.setLargura(pLargura: real);
begin
  largura:= pLargura;
end;

end.
