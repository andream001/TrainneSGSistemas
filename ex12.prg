SetColor ('N/W')

clear

nNum1  := 0
nNum2  := 0
nNum3  := 0
nNum4  := 0
nMaior := 0
cMaior := Space(3)

@ 01,01 to 12,59 color 'N/W' 

@ 02,20 say "Digite 4 numeros inteiros:" color 'N/W'
@ 03,20 say "Numero 1:"                     color 'N/W'
@ 04,20 say "Numero 2:"                     color 'N/W'
@ 05,20 say "Numero 3:"                     color 'N/W'
@ 06,20 say "Numero 4:"                     color 'N/W'

@ 03,30 get nNum1  valid nNum1 >= 0
@ 04,30 get nNum2  valid nNum2 >= 0
@ 05,30 get nNum3  valid nNum3 >= 0
@ 06,30 get nNum4  valid nNum4 >= 0
read

nMaior := nNum1

if nNum2 > nMaior
    nMaior := nNum2
endif

if nNum3 > nMaior 
    nMaior := nNum3
endif

if nNum4 > nMaior
    nMaior := nNum4
endif

cMaior := Str(nMaior)

@ 08,20 say "maior numero:" + cMaior               Color('W/N')
@ 09,20 say "maior numero:" + Str(nMaior)          Color('W/N')
@ 10,20 say "maior numero:" + AllTrim(Str(nMaior)) Color('W/N')
@ 11,20 say "maior numero:" + AllTrim(cMaior)      Color('W/N')

InKey(0)

