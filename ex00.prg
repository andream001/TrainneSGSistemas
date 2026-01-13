

clear

nNum1    := 0
nNum2    := 0
nNum3    := 0
nNum4    := 0
nProduto := 0

@01,10 say "Numero 1:"
@02,10 say "Numero 2:"
@03,10 say "Numero 3:"
@04,10 say "Numero 4:"
@05,10 say "Numero 4 deve ser igual a:"

@01,20 get nNum1 picture '@E 99.99     '       valid nNum1 <= 28.28 .and. nNum1 >= 15.25 //1 numero deve se encontrar nessa faixa
@02,20 get nNum2 picture '@E 99.99     '       valid nNum2 < nNum1                       //2 numero deve ser menor que o primeiro
@03,20 get nNum3 picture '@E 9999999.99'       valid nNum3 < nNum2                       //3 numero deve ser menor que o segundo
read

@05,40 say nProduto


nProduto := nNum1 * nNum2 * nNum3

@04,20 get nNum4 picture '@E 9999.99   '       valid nNum4 == nNum1 * nNum2 * nNum3      //4 numero deve ser o resultado identico ao produto dos 3 numeros anteriores
read

InKey(0)
