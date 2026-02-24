// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa variaveis de nome, posicao e contagem
cNome := Space(30)

nColuna       := 2    // coluna inicial de impressao
nLinha        := 4    // linha inicial de impressao
nContNome     := 1    // contador do numero de impressoes realizadas
nLimiteLinha  := 23   // linha maxima antes de mudar de coluna
nImpressoes   := 0    // quantidade de impressoes desejada pelo usuario
nLimiteColuna := 78   // coluna maxima antes de limpar a tela e reiniciar

// Desenha a estrutura de cabecalho e area de conteudo
@ 01,01 to 03,79
@ 03,01 to 24,79

// Solicita o nome e a quantidade de impressoes
@ 02,02 say "NOME:"
@ 02,33 say "QUANTIDADE DE IMPRESSOES:"

// Leitura do nome (obrigatorio) e da quantidade de impressoes (campo nao vazio)
@ 02,08 get cNome       picture '@!'  valid !Empty(cNome)
@ 02,60 get nImpressoes picture '999' valid !Empty(nImpressoes)
read

// Imprime o nome o numero de vezes solicitado, organizando em colunas
do while nContNome <= nImpressoes

   // Se ultrapassou o limite de linhas, move para a proxima coluna
   if nLinha > nLimiteLinha
      nColuna += 20
      nLinha  := 4
   endif

   // Se ultrapassou o limite de colunas, reinicia na coluna inicial e limpa a area
   if nColuna > nLimiteColuna
      nColuna := 2
      InKey(0)
      @ nLinha,nColuna clear to nLimiteLinha,nLimiteColuna
   endif
   
   // Imprime o numero sequencial seguido do nome na posicao atual
   @ nLinha ++,nColuna say AllTrim(Str(nContNome++)) + ":" + AllTrim(cNome)

ENDDO


// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)