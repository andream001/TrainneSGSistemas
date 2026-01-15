SetColor('N/W')

clear


cSexo  := Space(1)
nIdade := 0
nPeso  := 0

@ 01,01 to 05,26

@ 03,03 say "Digite o Genero:"

@ 03,20 get cSexo picture "@!" valid cSexo $ "MF"
read

InKey(0)

if cSexo = 'M'
   @ 03,03 clear to 03,25
   @ 03,03 say "Digite o Peso:"
   @ 03,19 get nPeso picture '999.99'  valid nPeso > 0
   read
   InKey(0)
   if nPeso > 100
      @ 03,03 clear to 03,25
      @ 03,03 say "Peso:" + AllTrim(Str(nPeso))
   endif
endif

if cSexo = 'F'
   @ 03,03 clear to 03,25
   @ 03,03 say "Digite a Idade:"
   @ 03,19 get nIdade picture '999' valid nIdade > 0
   read
   InKey(0)
   if nIdade > 21
      @ 03,03 clear to 03,25
      @ 03,03 say "Idade: " + AllTrim(Str(nIdade))
   endif
endif

InKey(0)
