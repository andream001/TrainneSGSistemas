clear

nNum1 := 0
nNum2 := 0

@01,10 say "Numero 1:"
@02,10 say "Numero 2:"
@03,10 say "Produto: "

@01,20 get nNum1
@02,20 get nNum2
read

nProduto := nNum1 * nNum2

@03,20 say nProduto

