SetColor('N/W')

clear

nIdade      := 0
cNome       := Space(30)
cCategorias := Space(30)

@ 01,01 to 06,44

@ 03,05 say "Nome:"
@ 04,05 say "Idade:"

@ 03,12 get cNome  picture '@! ' valid !Empty(cNome)
@ 04,12 get nIdade picture '999' valid nIdade > 0
read

@ 03,05 clear to 04,43

if nIdade >= 18

   cCategorias := "Senior"

elseif nIdade <= 7

   cCategorias := "Infantil A"

elseif nIdade <= 10

   cCategorias := "Infantil B"

elseif nIdade <= 13

   cCategorias := "Juvenil A"

elseif nIdade <= 17

   cCategorias := "Juvenil B"

endif

@ 03,10 say "Categoria: " + cCategorias

InKey(0)
