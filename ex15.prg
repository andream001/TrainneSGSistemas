Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

cNome := Space(30)
nCont := 4

nContLinhas := 1

@ 01,01 to 03,79
@ 03,01 to 14,79

@ 02,02 say "NOME:"

@ 02,08 get cNome picture '@!' valid !Empty(cNome)
read

do WHILE nCont < 14 
   @ nCont,02 say AllTrim(Str(nContLinhas))
   @ nCont,04 say "." + AllTrim(cNome)
   nCont ++
   nContLinhas ++
ENDDO

InKey(0)