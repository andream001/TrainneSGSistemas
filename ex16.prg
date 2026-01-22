Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

cNome := Space(30)

nColuna       := 2
nLinha        := 4
nContNome     := 1
nLimiteLinha  := 23
nImpressoes   := 0
nLimiteColuna := 78

@ 01,01 to 03,79
@ 03,01 to 24,79

@ 02,02 say "NOME:"
@ 02,33 say "QUANTIDADE DE IMPRESSOES:"

@ 02,08 get cNome       picture '@!'  valid !Empty(cNome)
@ 02,60 get nImpressoes picture '999' valid !Empty(nImpressoes)
read

do while nContNome <= nImpressoes

   if nLinha > nLimiteLinha
      nColuna += 20
      nLinha  := 4
   endif

   if nColuna > nLimiteColuna
      nColuna := 2
      InKey(0)
      @ nLinha,nColuna clear to nLimiteLinha,nLimiteColuna
   endif
   
   @ nLinha ++,nColuna say AllTrim(Str(nContNome++)) + ":" + AllTrim(cNome)

ENDDO


InKey(0)