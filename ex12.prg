// Define cor de fundo branco com texto preto
SetColor ('N/W')

// Limpa a tela
clear

// Inicializa as variaveis dos quatro numeros e o maior valor
nNum1  := 0
nNum2  := 0
nNum3  := 0
nNum4  := 0
nMaior := 0
cMaior := Space(3)

// Desenha uma caixa para organizar os campos de entrada
@ 01,01 to 12,59 color 'N/W' 

// Exibe o titulo e os rotulos de cada campo
@ 02,20 say "Digite 4 numeros inteiros:" color 'N/W'
@ 03,20 say "Numero 1:"                     color 'N/W'
@ 04,20 say "Numero 2:"                     color 'N/W'
@ 05,20 say "Numero 3:"                     color 'N/W'
@ 06,20 say "Numero 4:"                     color 'N/W'

// Leitura dos quatro numeros; todos devem ser maiores ou iguais a zero
@ 03,30 get nNum1  valid nNum1 >= 0
@ 04,30 get nNum2  valid nNum2 >= 0
@ 05,30 get nNum3  valid nNum3 >= 0
@ 06,30 get nNum4  valid nNum4 >= 0
read

// Assume o primeiro numero como maior inicialmente
nMaior := nNum1

// Compara cada numero subsequente para encontrar o maior
if nNum2 > nMaior
    nMaior := nNum2
endif

if nNum3 > nMaior 
    nMaior := nNum3
endif

if nNum4 > nMaior
    nMaior := nNum4
endif

// Converte o maior valor para string para exibicao
cMaior := Str(nMaior)

// Exibe o maior numero de formas diferentes (com e sem formatacao)
@ 08,20 say "maior numero:" + cMaior               Color('W/N')
@ 09,20 say "maior numero:" + Str(nMaior)          Color('W/N')
@ 10,20 say "maior numero:" + AllTrim(Str(nMaior)) Color('W/N')
@ 11,20 say "maior numero:" + AllTrim(cMaior)      Color('W/N')

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)

