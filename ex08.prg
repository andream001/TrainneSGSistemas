SetColor('N/W')

clear

cCor      := 'G/W'
cNome     := Space(30)
cProdA    := Space(20)
cProdB    := Space(20)
cProdC    := Space(20)
cFormP    := Space(1)
nParcelas := 0
nValorP   := 0
nLimite   := 0
nValorA   := 0
nValorB   := 0
nValorC   := 0
nQtdA     := 0
nQtdB     := 0
nQtdC     := 0
nTotal    := 0
nSubA     := 0
nSubB     := 0
nSubC     := 0

@ 01,09 to 04,70
@ 04,09 to 18,18
@ 04,09 to 18,43
@ 04,09 to 18,58
@ 04,09 to 18,70
@ 04,09 to 06,70
@ 18,09 to 23,70

@ 02,10 say "NOME:"
@ 03,10 say "LIMITE:"
@ 05,13 say "ITEM"
@ 05,27 say "PRODUTO"
@ 05,46 say "QUANTIDADE"
@ 05,62 say "VALOR"
@ 08,14 say "1"
@ 12,14 say "2"
@ 16,14 say "3"
@ 20,10 say "FORMA DE PAGAMENTO:"

@ 02,16 get cNome   picture '@!'         valid !Empty(cNome)
@ 03,18 get nLimite picture '@E 9999.99' valid nLimite > 0
@ 08,21 get cProdA  picture '@!'         valid !Empty(cProdA)
@ 08,49 get nQtdA   picture '99.99'      valid nQtdA   > 0
@ 08,61 get nValorA picture '@E 999.99'  valid nValorA > 0
@ 12,21 get cProdB  picture '@!'         valid !Empty(cProdB)
@ 12,49 get nQtdB   picture '99.99'      valid nQtdB   > 0
@ 12,61 get nValorB picture '@E 999.99'  valid nValorB > 0
@ 16,21 get cProdC  picture '@!'         valid !Empty(cProdC)
@ 16,49 get nQtdC   picture '99.99'      valid nQtdC   > 0
@ 16,61 get nValorC picture '@E 999.99'  valid nValorC > 0
@ 20,30 get cFormP  picture '@!'         valid cFormP $ "VP"
read

InKey(0)

if cFormP == 'P'
    @ 21,10 say "QUANTIDADE DE PARCELAS:"
    
    @ 21,34 get nParcelas picture '99' valid nParcelas > 0 .and. nParcelas <= 10
    read
    endif

nSubA   := nQtdA  * nValorA
nSubB   := nQtdB  * nValorB
nSubC   := nQtdC  * nValorC
nTotal  := nSubA  + nSubB + nSubC
nValorP := nTotal / nParcelas

if nTotal > nLimite
    cCor := 'R/W'
endif

Inkey(0)

cls
InKey(1)
@ 13,33 say "PROCESSANDO COMPRAS..." Color('N/W')
Inkey(3)
cls

SetColor('W/GR+')

@ 02,03 clear to 23,77
@ 01,03 to 23,77  

@ 02,33 say "SUPERMERCADO" 
@ 04,10 say "ITEM          DESCRICAO         QUANTIDADE          SUBTOTAL"
@ 06,11 say "1        " + AllTrim(cProdA)
@ 08,11 say "2        " + AllTrim(cProdB)
@ 10,11 say "3        " + AllTrim(cProdC)

@ 06,45 say AllTrim(Str(nQtdA))
@ 08,45 say AllTrim(Str(nQtdB))
@ 10,45 say AllTrim(Str(nQtdC))
@ 06,62 say AllTrim(Transform(nSubA, '@E'))
@ 08,62 say AllTrim(Transform(nSubB, '@E'))
@ 10,62 say AllTrim(Transform(nSubC, '@E'))

@ 13,33 say "TOTAL:"               
@ 13,40 say AllTrim(Transform(nTotal, '@E 999999.99')) Color(cCor)
@ 17,10 say "CLIENTE...............: " + AllTrim(cNome)

if nParcelas > 0
    @ 18,10 say "QUANTIDADE DE PARCELAS: " + AllTrim(Str(nParcelas))
    @ 19,10 say "VALOR DA PARCELA......: " + AllTrim(Transform(nValorP , "@!E"))
    endif

InKey(0)




