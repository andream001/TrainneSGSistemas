Set date BRITISH
Set epoch to 1940
SetColor('W/N')

clear

do while .t.
    if lastkey() == 27
      cMensagem := 'DESEJA SAIR?'
      cCor   := 'R/W'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

enddo

InKey(0)
