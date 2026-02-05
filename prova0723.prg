//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 21 Center 

clear

cCorVerde  := 'W/G'
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
      nControleLinha  := 6
      nControleColuna := 5
      
      cJogador := Space(30)
      
      lAbandon  := .f.
      
      @ 03,02 say "NOME: "

      @ 03,08 get cJogador picture "@!" valid !Empty(cJogador)
      read

      if lastkey() == 27
        cMensagem  := 'DESEJA ABANDONAR(SEU PROGRESSO NAO SERA SALVO)?'
        nOpcao     := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
        if nOpcao == 1
           lAbandon := .t.
        endif
        if lAbandon
           loop
        endif
      endif

      Alert("O JOGO VAI COMECAR. FIQUE ATENTO!" , cCorAlerta)

      cSequencia       := ""
      nTamanhoMaximo   := 10
      lErro            := .f.

      do while Len(cSequencia) < nTamanhoMaximo .and. !lErro
         
         cSequencia += AllTrim(Str(hb_RandomInt(1,4)))

         nControleColuna := 5

         nIndice := 1
         
         do while nIndice <= Len(cSequencia)
            nControleColuna += 5
            
            @ nControleLinha, nControleColuna say "[" + SubStr(cSequencia, nIndice, 1) + "]"
            
            InKey(1)
            
            nIndice++
         enddo

         @ nControleLinha, 02 clear to nControleLinha, 78

         nControleColuna := 05

         nIndice := 1
         
         do while nIndice <= Len(cSequencia)
            nControleColuna += 5
            
            @ nControleLinha, nControleColuna say "[ ]"
            
            nJogada := 0
            
            @ nControleLinha, nControleColuna+1 get nJogada picture "9" valid (nJogada >= 1 .and. nJogada <= 4)
            read

            if lastkey() == 27
               cMensagem  := 'DESEJA ABANDONAR(SEU PROGRESSO NAO SERA SALVO)?'
               nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
               if nOpcao == 1
                  lAbandon := .t.
                  lErro := .t.
                  exit
               endif
               nIndice--
               loop
            endif

            if nJogada == Val(SubStr(cSequencia, nIndice, 1))
               nPontuacao += 10
            else
               lErro := .t.
               exit
            endif
            nIndice++
         enddo

         if lErro .and. !lAbandon
            Alert("VOCE ERROU! PONTUACAO FINAL: " + AllTrim(Str(nPontuacao)) , cCorAlerta)
            
            cNomeFix   := SubStr(AllTrim(cJogador) + Space(30), 1, 30)
            cPontosTmp := Space(6) + AllTrim(Str(nPontuacao))
            cPontosFix := SubStr(cPontosTmp, Len(cPontosTmp) - 5, 6)
            cRecord    += cNomeFix + cPontosFix
         else
            Alert("CERTA RESPOSTA! PONTUACAO: " + AllTrim(Str(nPontuacao)) , cCorVerde)
         endif
      enddo

      if !lErro .and. Len(cSequencia) == nTamanhoMaximo
         Alert("PARABENS! VOCE COMPLETOU A SEQUENCIA. PONTUACAO FINAL: " + AllTrim(Str(nPontuacao)) , cCorVerde)
         
         cNomeFix   := SubStr(AllTrim(cJogador) + Space(30), 1, 30)
         cPontosTmp := Space(6) + AllTrim(Str(nPontuacao))
         cPontosFix := SubStr(cPontosTmp, Len(cPontosTmp) - 5, 6)
         cRecord    += cNomeFix + cPontosFix
      endif
      if lAbandon
         loop
      endif
   elseif nOpcao == 3
      Alert("SAINDO..." , "W/R")
      
      EXIT
   elseif nOpcao == 2
      @ 03,01 clear to 23,78

      @ 03,31 say "HISTORICO DE JOGADAS"
      @ 05,05 say "NOME" 
      @ 05,67 say "PONTOS"
      
      cLinha := ""
      
      nContLinha := 1
      
      do while nContLinha <= 77
         cLinha += "-"
         
         nContLinha++
      enddo
      
      @ 06,02 say cLinha

      if Empty(cRecord)
         Alert("SEM JOGADAS REGISTRADAS." , cCorAlerta)
      else
         nLinha           := 7
         nIndice          := 1
         nTamanhoRegistro := 36
         
         do while nIndice <= Len(cRecord)
            cNome   := SubStr(cRecord, nIndice, 30)
            cPontos := SubStr(cRecord, nIndice + 30, 6)
            
            @ nLinha, 02 say cNome
            @ nLinha, 65 say cPontos
            
            nLinha++
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


