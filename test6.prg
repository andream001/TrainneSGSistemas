Set date BRITISH
Set epoch to 1940
SetColor('W/N')

clear

do while .t.
    
    nOpcao := 0

    @ 01,01 prompt "EXERCICIO 01" 
    @ 02,01 prompt "EXERCICIO 02"
    @ 03,01 PROMPT "EXERCICIO 03" 
    
    menu to nOpcao

    if nOpcao == 1
        @ 05,01 say "EXERCICIO 01"

    elseif nOpcao == 2
        @ 05,01 say "EXERCICIO 02"
    elseif nOpcao == 3
        @ 05,01 say "EXERCICIO 03"
    endif

        
    if lastkey() == 27
      cMensagem := 'DESEJA SAIR?'
      cCor   := 'G/N'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

enddo

InKey(0)
