Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

dDataPed     := date()
dDataEntrega := cTod(" ")

cCor   := 'G/W'
cNome  := Space(30)
cProdA := Space(20)
cProdB := Space(20)
cProdC := Space(20)
cFormP := Space(1)

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


@ 02,43 say "DATA PEDIDO.:"
@ 03,43 say "DATA ENTREGA:"
@ 02,04 say "NOME:"
@ 03,04 say "LIMITE:"
@ 05,07 say "ITEM"
@ 05,21 say "PRODUTO"
@ 05,40 say "QUANTIDADE"
@ 05,56 say "VALOR"
@ 05,63 say "SUB-TOTAL"
@ 08,08 say "1"
@ 12,08 say "2"
@ 16,08 say "3"
@ 20,04 say "FORMA DE PAGAMENTO:"

@ 02,10 get cNome        picture '@!'         valid !Empty(cNome)
@ 03,12 get nLimite      picture '@E 9999.99' valid nLimite > 0
@ 02,57 get dDataPed     picture "99/99/9999" valid !Empty(dDataPed) .AND. dDataPed == date()
@ 03,58 get dDataEntrega picture "99/99/9999" valid !Empty(dDataPed) .AND. dDataPed >= date()
@ 08,43 get nQtdA        picture '99.99'      valid nQtdA   > 0
@ 08,55 get nValorA      picture '@E 999.99'  valid nValorA > 0
read

nSubA := nValorA * nQtdA

@ 08,63 say nSubA    picture '@E 9,999.99'

@ 12,15 get cProdB   picture '@!'         valid !Empty(cProdB)
@ 12,43 get nQtdB    picture '99.99'      valid nQtdB   > 0
@ 12,55 get nValorB  picture '@E 999.99'  valid nValorB > 0
read

nSubB := nValorB * nQtdB

@ 12,63 say nSubB    picture '@E 9,999.99'

@ 16,15 get cProdC   picture '@!'         valid !Empty(cProdC)
@ 16,43 get nQtdC    picture '99.99'      valid nQtdC   > 0
@ 16,55 get nValorC  picture '@E 999.99'  valid nValorC > 0
read

nSubC := nValorC * nQtdC

@ 08,63 say nSubC    picture '@E 9,999.99'

@ 20,24 get cFormP   picture '@!'         valid cFormP $ "VP"
read

InKey(0)

if cFormP == 'P'
    @ 21,04 say "QUANTIDADE DE PARCELAS:"
    
    @ 21,28 get nParcelas picture '99' valid nParcelas > 0 .and. nParcelas <= 10
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
@ 13,40 say AllTrim(Transform(nTotal, '@E 999999.99')) Color(cCor)

@ 13,33 say "TOTAL:"               
@ 17,10 say "CLIENTE...............: " + AllTrim(cNome)
@ 18,10 say "DATA DE PEDIDO........: " + dTOC(dDataPed)     picture "99/99/9999"
@ 19,10 say "DATA DE ENTREGA.......: " + dTOC(dDataEntrega) picture "99/99/9999"

if nParcelas > 0
    @ 20,10 say "QUANTIDADE DE PARCELAS: " + AllTrim(Str(nParcelas))
    @ 21,10 say "VALOR DA PARCELA......: " + AllTrim(Transform(nValorP , "@!E"))
    endif

InKey(0)




