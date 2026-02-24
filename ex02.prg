// Define cor de fundo branco com texto preto
SetColor('N/W')
// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940

// Limpa a tela
clear

// Loop infinito para permitir multiplas entradas
do while .t.

    // Inicializa as variaveis a cada iteracao do loop
    cNome  := Space(30)
    nIdade := 0
    nPeso  := 0

    // Desenha uma caixa para organizar os campos na tela
    @ 01,01 to 05,55

    // Exibe os rotulos dos campos
    @ 02,10 say "Nome: "
    @ 03,10 say "Peso: "
    @ 04,10 say "Idade:"

    // Leitura dos dados com validacao:
    @ 02,17 get cNome  picture '@!'        valid !Empty  (cNome)                 //recebe nome
    @ 03,17 get nPeso  picture '@E 999.99' valid  nPeso  > 0                     //recebe peso
    @ 04,17 get nIdade picture '999'       valid  nIdade > 0 .and. nIdade <= 145 //recebe idade
    read

    // Se o usuario pressionou ESC, sai do loop
    if lastkey() == 27
        EXIT
    endif

    // Limpa a area dos dados para exibir os valores lidos
    @ 02,05 clear to 04,45

    // Exibe os valores informados pelo usuario
    @ 02,17 say cNome  picture '@!'
    @ 03,16 say nPeso  picture '@E 999.99'
    @ 04,16 say nIdade picture '999'
enddo

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
