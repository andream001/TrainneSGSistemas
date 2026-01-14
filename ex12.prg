SetMode (25,80)
SetColor ('N/W')

clear

nNum1  := 0
nNum2  := 0
nNum3  := 0
nNum4  := 0
nMaior := 0

@ 01,01 to 10,59 color 'N/W' 

@ 02,20 say "Digite tres numeros inteiros:" color 'N/W'
@ 03,20 say "Numero 1:"                     color 'N/W'
@ 04,20 say "Numero 2:"                     color 'N/W'
@ 05,20 say "Numero 3:"                     color 'N/W'
@ 06,20 say "Numero 4:"                     color 'N/W'

@ 03,30 get nNum1 picture "999" valid nNum1 >= 0
@ 04,30 get nNum2 picture "999" valid nNum2 >= 0
@ 05,30 get nNum3 picture "999" valid nNum3 >= 0
@ 06,30 get nNum4 picture "999" valid nNum4 >= 0
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

@ 08,20 say "O maior numero digitado foi: " color 'N/W'
@ 08,50 say nMaior picture "999" color 'N/W'

InKey(0)

