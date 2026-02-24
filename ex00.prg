// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis numericas com zero
nNum1    := 0
nNum2    := 0
nNum3    := 0
nNum4    := 0
nProduto := 0

// Desenha uma caixa na tela para organizar a entrada de dados
@ 01,01 to 06,60

// Exibe os rotulos dos campos na tela
@ 02,10 say "Numero 1:"
@ 03,10 say "Numero 2:"
@ 04,10 say "Numero 3:"
@ 05,10 say "Numero 4:"

// Leitura dos tres primeiros numeros com validacao:
@ 02,20 get nNum1 picture '@E      99.99'       valid nNum1 <= 28.28 .and. nNum1 >= 15.25 //1 numero deve se encontrar nessa faixa
@ 03,20 get nNum2 picture '@E      99.99'       valid nNum2 < nNum1                       //2 numero deve ser menor que o primeiro
@ 04,20 get nNum3 picture '@E 9999999.99'       valid nNum3 < nNum2                       //3 numero deve ser menor que o segundo
read

// Se o usuario pressionou ESC, encerra o programa
if lastkey() == 27
   EXIT
endif

// Exibe o valor do produto (ainda zero antes do calculo)
@ 05,40 say nProduto

// Calcula o produto dos tres numeros
nProduto := nNum1 * nNum2 * nNum3

// Leitura do quarto numero, que deve ser igual ao produto calculado
@ 06,20 get nNum4 picture '@E 9999.99   '       valid nNum4 == nNum1 * nNum2 * nNum3      //4 numero deve ser o resultado identico ao produto dos 3 numeros anteriores
read

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
