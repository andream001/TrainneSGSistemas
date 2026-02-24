// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940

// Limpa a tela
clear

// Loop infinito para permitir multiplas inverses de nome
do while .t.
   
   // Inicializa as variaveis de nome a cada iteracao
   cNome          := Space(30)
   cNomeInvertido := Space(30)

   nCont := 0
   
   // Desenha uma caixa para organizar os campos
   @ 01,00 to 04,79

   // Solicita o nome do usuario
   @ 02,02 say "NOME:"

   // Leitura do nome em maiusculo, obrigatorio
   @ 02,07 get cNome picture "@!" valid !Empty(cNome)
   read

   // Se o usuario pressionou ESC, pergunta se deseja sair
   if lastkey() == 27
     cMensagem := 'DESEJA SAIR?'
     cCor   := 'W/R'
     nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
     if nOpcao == 1
        EXIT
     endif
     loop
   endif

   // Remove espacos extras e calcula o tamanho real do nome
   cNome        := AllTrim(cNome)
   nTamanhoNome := Len(cNome)

   // Constroi o nome invertido lendo os caracteres do fim para o inicio
   do while nCont < nTamanhoNome
      cNomeInvertido += SubStr(cNome, nTamanhoNome , 1)
      nTamanhoNome--
   enddo

   // Exibe o nome lido ao contrario
   @ 03,02 say "NOME INVERTIDO:" + AllTrim(cNomeInvertido)
  
   InKey(0)

enddo

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
