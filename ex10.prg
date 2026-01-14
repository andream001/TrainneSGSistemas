clear

nIdade := 0

@ 01,10 say "Idade:"

@ 01,20 get nIdade picture '999' valid nIdade > 0 .and. nIdade < 199
read

if nIdade == 21

   @ 02,10 say "Usu�rio com 21 anos."

   if nIdade < 21

      @ 02,10 say "Usu�rio com menos de 21 anos."
   else

      @ 02,10 say "Usu�rio com mais de 21 anos."

   endif
endif

InKey(0)

