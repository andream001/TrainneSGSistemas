SetColor('N/W')

clear

nNum1      := 0
nNum2      := 0
nSoma      := 0
nProduto   := 0
nDivisao   := 0
nSubtracao := 0


@ 01,10 say "Digite um Numero:"
@ 02,10 say "Digite um Numero:"

@ 01,28 get nNum1
@ 02,28 get nNum2 valid nNum2 > 0
read

nSoma      := nNum1 + nNum2
nProduto   := nNum1 * nNum2
nDivisao   := nNum1 / nNum2
nSubtracao := nNum1 - nNum2

@ 03,10 say "Soma:"      + AllTrim(Str(nSoma))
@ 04,10 say "Produto:"   + AllTrim(Str(nProduto))
@ 05,10 say "Divisao:"   + AllTrim(Str(nDivisao))
@ 06,10 say "Subtracao:" + AllTrim(Str(nSubtracao))

Inkey(0)

