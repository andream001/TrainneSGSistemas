//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')

clear

do while .t.
    
    cCorAlerta := 'W/R'
    cLogin     := 'JOSE'
    cSenha     := '432mudar123'

    @ 01,00 to 
    
    if lastkey() == 27
      cMensagem := 'DESEJA SAIR?'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

enddo

InKey(0)
