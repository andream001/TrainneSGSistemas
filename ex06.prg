// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis numericas
nNum1 := 0
nNum2 := 0
nNum3 := 0

// Exibe os rotulos dos campos na tela
@ 01,10 say "N�mero 1:"
@ 02,10 say "Numero 2:"
@ 03,10 say "Numero 3:"
@ 04,10 say "Media:   "

// Leitura dos tres numeros sem restricao de valor
@ 01,20 get nNum1
@ 02,20 get nNum2
@ 03,20 get nNum3
read

// Calcula a soma dos tres numeros
nMedia := nNum1 + nNum2 + nNum3
// Divide a soma por 3 para obter a media aritmetica
nMedia := nMedia / 3

// Exibe o resultado da media na tela
@ 04,17 say nMedia

// Aguarda o usuario pressionar qualquer tecla para encerrar
Inkey(0)