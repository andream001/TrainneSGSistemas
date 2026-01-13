clear

cNome  := Space(30)
nIdade := 0
nPeso  := 0

@01,01 to 05,55
@02,10 say "Nome: "
@03,10 say "Peso: "
@04,10 say "Idade:"

@02,17 get cNome  picture '@!'        valid !Empty  (cNome)                 //recebe nome
@03,17 get nPeso  picture '@E 999.99' valid  nPeso  > 0                     //recebe peso
@04,17 get nIdade picture '999'       valid  nIdade > 0 .and. nIdade <= 145 //recebe idade
read

@02,05 clear to 04,45
@02,17 say cNome  picture '@!'
@03,16 say nPeso  picture '@E 999.99'
@04,16 say nIdade picture '999'

InKey(0)
