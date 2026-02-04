//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 21 Center 

clear

cCorAlerta := 'W/R'
cRecord    := ""

do while .t.
   clear
   
   nOpcao := 0 

   @ 02,00 TO 24,79

   @ 01,26 say "JOGO DA MEMORIA DE SEQUENCIAS"
   @ 04,32 say "MENU PRINCIPAL"
   
   @ 10,33 Prompt "1 - JOGAR"     Message "Inicia uma nova partida"
   @ 12,33 prompt "2 - HISTORICO" Message "Exibe o historico de jogadas"
   @ 14,33 prompt "3 - SAIR"      Message "ENCERRA O PROGRAMA"

   menu to nOpcao 

   if nOpcao == 1
      @ 03,01 clear to 23,78

      nPontuacao      := 0
      nControleLinha  := 5
      nControleColuna := 0
      cJogador := Space(30)
      
      @ 03,02 say "NOME: "

      @ 03,08 get cJogador picture "@!" valid !Empty(cJogador)
      read

      if lastkey() == 27
        cMensagem  := 'DESEJA ABANDONAR(SEU PROGRESSO NAO SERA SALVO)?'
        nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
        if nOpcao == 1
           EXIT
        endif
        loop
      endif

      Alert("O JOGO VAI COMECAR. FIQUE ATENTO!" , cCorAlerta)
   
      nJogada          := 0
      nControleJogadas := 10
      
      do while nControleJogadas > 0
         nNumeroAleatorio := hb_RandomInt(1,4)
         
         nControleColuna += 5

         @ nControleLinha,nControleColuna   say "[" + AllTrim(Transform(nNumeroAleatorio, "9")) + "]" 
         InKey(1)
         @ nControleLinha,nControleColuna clear to @ nControleLinha,nControleColuna

         @ nControleLinha,nControleColuna   say "[ " + "]" 

         nControleColuna++

         @ nControleLinha,nControleColuna get nJogada picture "9" valid !Empty(nJogada)
         read

         if lastkey() == 27
            cMensagem  := 'DESEJA ABANDONAR(SEU PROGRESSO NAO SERA SALVO)?'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
            if nOpcao == 1
               EXIT
            endif
         
            @ nControleLinha,nControleColuna   say "[" + AllTrim(Transform(nNumeroAleatorio, "9")) + "]" 
            loop

         endif

         if nJogada == nNumeroAleatorio
            nPontuacao += 10
            Alert("CERTA RESPOSTA! PONTUACAO: " + AllTrim(Str(nPontuacao)))
            nControleJogadas--
            loop
            
         else
            Alert("VOCE ERROU! PONTUACAO FINAL : " + AllTrim(Str(nPontuacao)))
            cRecord += cJogador
            cRecord += AllTrim(Str(nPontuacao))
            nControleJogadas--
         endif
      enddo
   elseif nOpcao == 3
      Alert("SAINDO..." , "W/R")
      EXIT
   ENDIF


enddo

InKey(0)
