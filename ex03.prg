clear

nNum1 := 0
nNum2 := 0

@ 01,01 to 05,40

@ 02,10 say "Numero 1:"
@ 03,10 say "Numero 2:"
@ 04,10 say "Produto: "

@ 02,20 get nNum1
@ 03,20 get nNum2
read

nProduto := nNum1 * nNum2

@ 04,20 say nProduto

InKey(0)
