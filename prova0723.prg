//ANDRE LUIZ BUNHAK

// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo preto com texto branco
SetColor('W/N')
// Exibe mensagem de status na linha 21, centralizada
Set Message to 21 Center 

// Limpa a tela
clear

// Cores para feedback visual ao jogador
cCorVerde  := 'W/G'   // cor para acertos e mensagens de sucesso
cCorAlerta := 'W/R'   // cor para erros e alertas
cRecord    := ""      // armazena o historico de jogadas em memoria

// Loop principal do menu do jogo
do while .t.
   clear
   
   nOpcao := 0 

   // Desenha a borda da tela e exibe o titulo
   @ 02,00 TO 24,79

   @ 01,26 say "JOGO DA MEMORIA DE SEQUENCIAS"
   @ 04,32 say "MENU PRINCIPAL"
   
   // Opcoes do menu principal
   @ 10,33 Prompt "1 - JOGAR"     Message "Inicia uma nova partida"
   @ 12,33 prompt "2 - HISTORICO" Message "Exibe o historico de jogadas"
   @ 14,33 prompt "3 - SAIR"      Message "ENCERRA O PROGRAMA"

   menu to nOpcao 

   // Opcao 1: Iniciar uma nova partida
   if nOpcao == 1
      @ 03,01 clear to 23,78

      // Inicializa as variaveis da partida
      nPontuacao      := 0
      nControleLinha  := 6
      nControleColuna := 5
      
      cJogador := Space(30)
      
      lAbandon  := .f.   // indica se o jogador abandonou a partida
      
      // Solicita o nome do jogador
      @ 03,02 say "NOME: "

      @ 03,08 get cJogador picture "@!" valid !Empty(cJogador)
      read

      // Se pressionou ESC no nome, pergunta se deseja abandonar
      if lastkey() == 27
        cMensagem  := \'DESEJA ABANDONAR(SEU PROGRESSO NAO SERA SALVO)?\'
        nOpcao     := Alert(cMensagem, {\'SIM\' , \'NAO\'} , cCorAlerta)
        if nOpcao == 1
           lAbandon := .t.
        endif
        if lAbandon
           loop
        endif
      endif

      Alert("O JOGO VAI COMECAR. FIQUE ATENTO!" , cCorAlerta)

      // Inicializa a sequencia e o estado do jogo
      cSequencia       := ""
      nTamanhoMaximo   := 10   // quantidade maxima de numeros na sequencia
      lErro            := .f.  // indica se o jogador cometeu um erro

      // Loop de rodadas: cada rodada adiciona um numero a sequencia
      do while Len(cSequencia) < nTamanhoMaximo .and. !lErro
         
         // Adiciona um numero aleatorio de 1 a 4 a sequencia
         cSequencia += AllTrim(Str(hb_RandomInt(1,4)))

         nControleColuna := 5

         nIndice := 1
         
         // Exibe a sequencia completa por um momento para o jogador memorizar
         do while nIndice <= Len(cSequencia)
            nControleColuna += 5
            
            @ nControleLinha, nControleColuna say "[" + SubStr(cSequencia, nIndice, 1) + "]"
            
            InKey(1)   // aguarda 1 segundo entre cada numero exibido
            
            nIndice++
         enddo

         // Limpa a linha para o jogador digitar sua resposta
         @ nControleLinha, 02 clear to nControleLinha, 78

         nControleColuna := 05

         nIndice := 1
         
         // Loop de entrada: o jogador deve repetir a sequencia
         do while nIndice <= Len(cSequencia)
            nControleColuna += 5
            
            // Exibe os espacos em branco onde o jogador deve digitar
            @ nControleLinha, nControleColuna say "[ ]"
            
            nJogada := 0
            
            // Leitura da jogada do usuario (deve ser entre 1 e 4)
            @ nControleLinha, nControleColuna+1 get nJogada picture "9" valid (nJogada >= 1 .and. nJogada <= 4)
            read

            // Se pressionou ESC durante a jogada, pergunta se deseja abandonar
            if lastkey() == 27
               cMensagem  := \'DESEJA ABANDONAR(SEU PROGRESSO NAO SERA SALVO)?\'
               nOpcao := Alert(cMensagem, {\'SIM\' , \'NAO\'} , cCorAlerta)
               if nOpcao == 1
                  lAbandon := .t.
                  lErro := .t.
                  exit
               endif
               nIndice--
               loop
            endif

            // Verifica se o numero digitado corresponde ao da sequencia
            if nJogada == Val(SubStr(cSequencia, nIndice, 1))
               nPontuacao += 10   // acerto: soma 10 pontos
            else
               lErro := .t.       // erro: encerra a rodada
               exit
            endif
            nIndice++
         enddo

         // Se houve erro e nao foi abandono voluntario, registra no historico
         if lErro .and. !lAbandon
            Alert("VOCE ERROU! PONTUACAO FINAL: " + AllTrim(Str(nPontuacao)) , cCorAlerta)
            
            // Formata e armazena o registro: nome (30 chars) + pontos (6 chars)
            cNomeFix   := SubStr(AllTrim(cJogador) + Space(30), 1, 30)
            cPontosTmp := Space(6) + AllTrim(Str(nPontuacao))
            cPontosFix := SubStr(cPontosTmp, Len(cPontosTmp) - 5, 6)
            cRecord    += cNomeFix + cPontosFix
         else
            Alert("CERTA RESPOSTA! PONTUACAO: " + AllTrim(Str(nPontuacao)) , cCorVerde)
         endif
      enddo

      // Se o jogador completou a sequencia maxima sem erros
      if !lErro .and. Len(cSequencia) == nTamanhoMaximo
         Alert("PARABENS! VOCE COMPLETOU A SEQUENCIA. PONTUACAO FINAL: " + AllTrim(Str(nPontuacao)) , cCorVerde)
         
         // Registra a pontuacao maxima no historico
         cNomeFix   := SubStr(AllTrim(cJogador) + Space(30), 1, 30)
         cPontosTmp := Space(6) + AllTrim(Str(nPontuacao))
         cPontosFix := SubStr(cPontosTmp, Len(cPontosTmp) - 5, 6)
         cRecord    += cNomeFix + cPontosFix
      endif
      if lAbandon
         loop
      endif

   // Opcao 3: Sair do programa
   elseif nOpcao == 3
      Alert("SAINDO..." , "W/R")
      
      EXIT

   // Opcao 2: Exibir o historico de jogadas
   elseif nOpcao == 2
      @ 03,01 clear to 23,78

      @ 03,31 say "HISTORICO DE JOGADAS"
      @ 05,05 say "NOME" 
      @ 05,67 say "PONTOS"
      
      // Cria uma linha separadora com 77 hifens
      cLinha := ""
      
      nContLinha := 1
      
      do while nContLinha <= 77
         cLinha += "-"
         
         nContLinha++
      enddo
      
      @ 06,02 say cLinha

      // Verifica se ha registros para exibir
      if Empty(cRecord)
         Alert("SEM JOGADAS REGISTRADAS." , cCorAlerta)
      else
         nLinha           := 7
         nIndice          := 1
         nTamanhoRegistro := 36   // cada registro ocupa 36 caracteres (30 nome + 6 pontos)
         
         // Exibe cada registro do historico, paginando se necessario
         do while nIndice <= Len(cRecord)
            cNome   := SubStr(cRecord, nIndice, 30)
            cPontos := SubStr(cRecord, nIndice + 30, 6)
            
            @ nLinha, 02 say cNome
            @ nLinha, 65 say cPontos
            
            nLinha++
            // Se a pagina estiver cheia, aguarda tecla e exibe nova pagina
            if nLinha > 22
               InKey(0)
               
               @ 03,01 clear to 23,78
               
               @ 03,31 say "HISTORICO DE JOGADAS"
               @ 05,05 say "NOME" 
               @ 05,67 say "PONTOS"
               
               cLinha := ""
               
               nContLinha := 0
               
               do while nContLinha <= 77
                  cLinha += "-"
                  nContLinha++
               enddo
               
               @ 06,02 say cLinha
               
               nLinha := 7
            endif
            nIndice += nTamanhoRegistro
         enddo
         InKey(0)
      endif
   ENDIF
enddo

