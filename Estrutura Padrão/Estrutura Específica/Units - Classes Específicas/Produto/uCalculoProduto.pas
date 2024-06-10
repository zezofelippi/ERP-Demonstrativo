unit uCalculoProduto;

interface

type
  TCalculoProduto = class
    private
       class var venda: real;
       class var custo: real;

    public
      class function calcularLucro: real;

      class procedure setVenda(pVenda: real);
      class procedure setCusto(pCusto: real);

  end;

implementation

{ TCalculoProduto }

class function TCalculoProduto.calcularLucro: real;
begin
  result:= venda - custo;
end;

class procedure TCalculoProduto.setCusto(pCusto: real);
begin
  custo:= pCusto;
end;

class procedure TCalculoProduto.setVenda(pVenda: real);
begin
  venda:= pVenda;
end;

end.
