// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis de nome e contadores
cNome := Space(30)
nCont := 4          // contador de linha, inicia na linha 4

nContLinhas := 1    // contador de itens da lista, exibido na frente de cada nome

// Desenha duas caixas para organizar a tela
@ 01,01 to 03,79
@ 03,01 to 14,79

// Solicita o nome que sera listado
@ 02,02 say "NOME:"

// Leitura do nome obrigatorio, convertido para maiusculo
@ 02,08 get cNome picture '@!' valid !Empty(cNome)
read

// Imprime o nome repetidamente ate a linha 14 (cada iteracao incrementa a linha)
do WHILE nCont < 14 
   @ nCont,02 say AllTrim(Str(nContLinhas))   // exibe o numero do item
   @ nCont,04 say "." + AllTrim(cNome)        // exibe ponto seguido do nome
   nCont ++
   nContLinhas ++
ENDDO

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)