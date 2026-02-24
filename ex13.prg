// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis de codigo, classe e cor
nCodProd := 0
cClasse  := Space(30)
cCor     := Space(5)

// Desenha duas caixas para organizar a tela
@ 01,01 to 03,59 color 'N/W'
@ 04,01 to 06,59 color 'N/W'

// Solicita o codigo do produto (de 1 a 15)
@ 02,10 say "Codigo do Produto:"

@ 02,28 get nCodProd picture "99" valid nCodProd >= 1 .and. nCodProd <= 15
read

// Determina a classe do produto e a cor de exibicao com base no codigo informado
if nCodProd == 1
   // Codigo 1: produto nao perecivel
   cClasse := "Alimento nao perecivel"
   cCor    := 'N/W'    

elseif nCodProd >= 2 .and. nCodProd <= 4
   // Codigos 2 a 4: produtos pereciveis
   cClasse := "Alimento perecivel"
   cCor    := 'B/W'

elseif nCodProd >= 5 .and. nCodProd <= 6
   // Codigos 5 e 6: roupas e acessorios
   cClasse := "Vestuario"
   cCor    := 'G/W'

elseif nCodProd == 7
   // Codigo 7: produtos de higiene pessoal
   cClasse := "Higiene pessoal"
   cCor    := 'R/W'

elseif nCodProd >= 8 .and. nCodProd <= 15
   // Codigos 8 a 15: produtos de limpeza e utensilios domesticos
   cClasse := "Limpeza e utensilios domesticos"
   cCor    := 'GR+/W'
endif

// Exibe a classe do produto com a cor correspondente
@ 05,10 say "Classe do Produto: " + cClasse Color(cCor)

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
