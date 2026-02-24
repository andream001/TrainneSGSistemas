// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis de genero, idade e peso
cSexo  := Space(1)
nIdade := 0
nPeso  := 0

// Desenha uma caixa na tela para entrada de dados
@ 01,01 to 05,26

// Solicita que o usuario informe o genero
@ 03,03 say "Digite o Genero:"

// Aceita apenas 'M' (masculino) ou 'F' (feminino), convertido para maiusculo
@ 03,20 get cSexo picture "@!" valid cSexo $ "MF"
read

InKey(0)

// Se o genero for masculino, solicita o peso
if cSexo = 'M'
   @ 03,03 clear to 03,25
   @ 03,03 say "Digite o Peso:"
   @ 03,19 get nPeso picture '999.99'  valid nPeso > 0
   read
   InKey(0)
   // Se o peso for maior que 100 kg, exibe o peso na tela
   if nPeso > 100
      @ 03,03 clear to 03,25
      @ 03,03 say "Peso:" + AllTrim(Str(nPeso))
   endif
endif

// Se o genero for feminino, solicita a idade
if cSexo = 'F'
   @ 03,03 clear to 03,25
   @ 03,03 say "Digite a Idade:"
   @ 03,19 get nIdade picture '999' valid nIdade > 0
   read
   InKey(0)
   // Se a idade for maior que 21, exibe a idade na tela
   if nIdade > 21
      @ 03,03 clear to 03,25
      @ 03,03 say "Idade: " + AllTrim(Str(nIdade))
   endif
endif

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
