// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis de operacoes aritmeticas
nNum1      := 0
nNum2      := 0
nSoma      := 0
nProduto   := 0
nDivisao   := 0
nSubtracao := 0


// Exibe os rotulos de entrada dos numeros
@ 01,10 say "Digite um Numero:"
@ 02,10 say "Digite um Numero:"

// Leitura dos dois numeros; o segundo nao pode ser zero (evita divisao por zero)
@ 01,28 get nNum1
@ 02,28 get nNum2 valid nNum2 > 0
read

// Calcula as quatro operacoes aritmeticas basicas
nSoma      := nNum1 + nNum2
nProduto   := nNum1 * nNum2
nDivisao   := nNum1 / nNum2
nSubtracao := nNum1 - nNum2

// Exibe os resultados de cada operacao na tela
@ 03,10 say "Soma:"      + AllTrim(Str(nSoma))
@ 04,10 say "Produto:"   + AllTrim(Str(nProduto))
@ 05,10 say "Divisao:"   + AllTrim(Str(nDivisao))
@ 06,10 say "Subtracao:" + AllTrim(Str(nSubtracao))

// Aguarda o usuario pressionar qualquer tecla para encerrar
Inkey(0)

