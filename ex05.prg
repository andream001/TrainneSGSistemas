SetColor('N/W')

clear

nNumA := 0
nNumB := 0
nNumT := 0

@ 01,01 to 06,44
@ 02,10 say "Numero 1:"
@ 03,10 say "Numero 2:"

@ 02,20 get nNumA
@ 02,20 get nNumT
@ 03,20 get nNumB
read

nNumA := nNumB
nNumB := nNumT

@ 04,10 say "Numero 1:"
@ 04,20 say nNumA
@ 05,10 say "Numero 2:"
@ 05,20 say nNumB

Inkey(0)
