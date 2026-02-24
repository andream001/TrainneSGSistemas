// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis numericas
nNumA := 0
nNumB := 0
nNumT := 0

// Desenha uma caixa para organizar os campos
@ 01,01 to 06,44
@ 02,10 say "Numero 1:"
@ 03,10 say "Numero 2:"

// Leitura do primeiro numero e armazenamento temporario para troca
@ 02,20 get nNumA
@ 02,20 get nNumT  // armazena o valor original de nNumA em nNumT
@ 03,20 get nNumB
read

// Realiza a troca dos valores entre nNumA e nNumB usando a variavel temporaria nNumT
nNumA := nNumB
nNumB := nNumT

// Exibe os valores apos a troca
@ 04,10 say "Numero 1:"
@ 04,20 say nNumA
@ 05,10 say "Numero 2:"
@ 05,20 say nNumB

// Aguarda o usuario pressionar qualquer tecla para encerrar
Inkey(0)
