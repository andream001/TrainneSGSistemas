//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 21 Center 

clear

cRecord := ""

do while .t.

   nOpcao := 0 

   @ 02,00 TO 24,79

   @ 01,30 say "JOGO DA MEMORIA DE SEQUENCIAS"
   @ 04,30 say "MENU PRINCIPAL"
   
   @ 10,30 Prompt "1 - JOGAR"     Message "Inicia uma nova partida"
   @ 12,30 prompt "2 - HISTORICO" Message "Exibe o historico de jogadas"
   @ 14,30 prompt "3 - SAIR"      Message "ENCERRA O PROGRAMA"

   menu to nOpcao 

   if nOpcao == 1
      @ 03,01 clear to 23,78

      nPontuação := 0
      
      cJogador := Space(30)
      
      @ 02,02 say "NOME: "

      @ 02,08 get cjOGA

   
   elseif nOpcao == 3
      Alert("SAINDO..." , "W/R")
      EXIT
   ENDIF
do while .t.
    if lastkey() == 27
      cMensagem  := 'DESEJA ABANDONAR(SEU PROGRESSO NAO SERA SALVO)?'
      cCorAlerta := 'W/R'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

enddo

InKey(0)
