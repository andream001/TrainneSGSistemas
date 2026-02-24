// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis de nome, idade e categoria
nIdade      := 0
cNome       := Space(30)
cCategorias := Space(30)

// Desenha uma caixa para organizar os campos
@ 01,01 to 06,44

// Exibe os rotulos dos campos
@ 03,05 say "Nome:"
@ 04,05 say "Idade:"

// Leitura do nome (obrigatorio) e da idade (maior que zero)
@ 03,12 get cNome  picture '@! ' valid !Empty(cNome)
@ 04,12 get nIdade picture '999' valid nIdade > 0
read

// Limpa a area para exibir o resultado da categoria
@ 03,05 clear to 04,43

// Determina a categoria com base na idade do atleta
if nIdade >= 18
   // Adulto: 18 anos ou mais
   cCategorias := "Senior"

elseif nIdade <= 7
   // Crianca: ate 7 anos
   cCategorias := "Infantil A"

elseif nIdade <= 10
   // Crianca: de 8 a 10 anos
   cCategorias := "Infantil B"

elseif nIdade <= 13
   // Pre-adolescente: de 11 a 13 anos
   cCategorias := "Juvenil A"

elseif nIdade <= 17
   // Adolescente: de 14 a 17 anos
   cCategorias := "Juvenil B"

endif

// Exibe a categoria determinada para o atleta
@ 03,10 say "Categoria: " + cCategorias

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
