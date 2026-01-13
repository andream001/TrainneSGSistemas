clear

cProdA  := Space(20)
cProdB  := Space(20)
cProdC  := Space(20)

nValorA := 0
nValorB := 0
nValorC := 0

nQtdA   := 0
nQtdB   := 0
nQtdC   := 0
nTotal  := 0

nSubA   := 0
nSubB   := 0
nSubC   := 0

@01,01 to 20,09
@01,01 to 20,34
@01,01 to 20,49
@01,01 to 20,61
@01,01 to 20,79
@01,49 to 25,79
@01,49 to 25,61

@03,04 say "ITEM"
@03,18 say "PRODUTO"
@03,37 say "QUANTIDADE"
@03,53 say "VALOR"
@03,68 say "SUBTOTAL"
@08,05 say "1"
@13,05 say "2"
@18,05 say "3"
@22,53 say "TOTAL"

@08,12 get cProdA  picture '@!'        valid !Empty(cProdA)
@08,40 get nQtdA   picture '99.99'     valid nQtdA   > 0
@08,52 get nValorA picture '@E 999.99' valid nValorA > 0
@13,12 get cProdB  picture '@!'        valid !Empty(cProdB)
@13,40 get nQtdB   picture '99.99'     valid nQtdB   > 0
@13,52 get nValorB picture '@E 999.99' valid nValorB > 0
@18,12 get cProdC  picture '@!'        valid !Empty(cProdC)
@18,40 get nQtdC   picture '99.99'     valid nQtdC   > 0
@18,52 get nValorC picture '@E 999.99' valid nValorC > 0
read

nSubA  := nQtdA * nValorA
nSubB  := nQtdB * nValorB
nSubC  := nQtdC * nValorC
nTotal := nSubA + nSubB + nSubC

@08,65 say nSubA  picture '@E 99999.99'
@13,65 say nSubB  picture '@E 99999.99'
@18,65 say nSubC  picture '@E 99999.99'
@22,63 say nTotal picture '@E 9999999.99'

InKey(0)


