clear

nNumA := 0
nNumB := 0
nNumT := 0

@01,10 say "Numero 1:"
@02,10 say "Numero 2:"

@01,20 get nNumA
@01,20 get nNumT
@02,20 get nNumB
read

nNumA := nNumB
nNumB := nNumT

@03,10 say"Numero 1:"
@03,20 say nNumA
@04,10 say"Numero 2:"
@04,20 say nNumB

