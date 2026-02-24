// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Leitura da idade com validacao: deve ser maior que 0 e menor que 199
nIdade := 0

@ 01,10 say "Idade:"

@ 01,20 get nIdade picture '999' valid nIdade > 0 .and. nIdade < 199
read

// Verifica se o usuario tem exatamente 21 anos
if nIdade == 21

   @ 02,10 say "Usuario com 21 anos."

   // Verifica se tem menos de 21 (nunca sera executado pois ja sabemos que e igual a 21)
   if nIdade < 21

      @ 02,10 say "Usuario com menos de 21 anos."
   else

      @ 02,10 say "Usuario com mais de 21 anos."

   endif
endif

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)

