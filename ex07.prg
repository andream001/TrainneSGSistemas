clear

nNum1      := 0
nNum2      := 0
nSoma      := 0
nProduto   := 0
nDivisao   := 0
nSubtracao := 0


@ 01,10 say "Digite um N�mero:"
@ 02,10 say "Digite um N�mero:"
@ 03,10 say "Soma:     "
@ 04,10 say "Produto:  "
@ 05,10 say "Divis�o:  "
@ 06,10 say "Subtra��o:"

@ 01,28 get nNum1
@ 02,28 get nNum2 valid nNum2 > 0
read

nSoma := nNum1 + nNum2
nProduto := nNum1 * nNum2
nDivisao := nNum1 / nNum2
nSubtracao := nNum1 - nNum2

@ 03,21 say nSoma
@ 04,21 say nProduto
@ 05,21 say nDivisao
@ 06,21 say nSubtracao

Inkey(0)

