Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

cCor      := 'G/N'
cMensagem := 'DESEJA SAIR?'

do while .t.
   if lastkey() == 27
      nOpcao    := Alert(cMensagem, {'SIM' , 'NAO', cCor})
      if nOpcao == 1
         EXIT
      endif
      loop
   endif
enddo

InKey(0)
