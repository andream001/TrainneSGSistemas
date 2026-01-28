Set date BRITISH
Set epoch to 1940

clear

do while .t.
   
   cNome          := Space(30)
   cNomeInvertido := Space(30)

   nCont := 0
   
   @ 01,00 to 04,79

   @ 02,02 say "NOME:"

   @ 02,07 get cNome picture "@!" valid !Empty(cNome)
   read

   if lastkey() == 27
     cMensagem := 'DESEJA SAIR?'
     cCor   := 'W/R'
     nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
     if nOpcao == 1
        EXIT
     endif
     loop
   endif

   cNome        := AllTrim(cNome)
   nTamanhoNome := Len(cNome)

   do while nCont < nTamanhoNome
      cNomeInvertido += SubStr(cNome, nTamanhoNome , 1)
      nTamanhoNome--
   enddo

   @ 03,02 say "NOME INVERTIDO:" + AllTrim(cNomeInvertido)
  
   InKey(0)

enddo

InKey(0)
