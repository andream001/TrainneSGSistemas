SetColor('N/W')

clear

nNum1 := 0
nNum2 := 0
nNum3 := 0

@ 01,10 say "N�mero 1:"
@ 02,10 say "Numero 2:"
@ 03,10 say "Numero 3:"
@ 04,10 say "Media:   "

@ 01,20 get nNum1
@ 02,20 get nNum2
@ 03,20 get nNum3
read

nMedia := nNum1 + nNum2 + nNum3
nMedia := nMedia / 3

@ 04,17 say nMedia

Inkey(0)