Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

do while .t.

   nNum1 := 0
   nNum2 := 0
  
   cMensagem := 'DESEJA SAIR?'

   @ 01,01 to 05,40

   @ 02,10 say "Numero 1:"
   @ 03,10 say "Numero 2:"
   @ 04,10 say "Produto: "

   @ 02,20 get nNum1
   @ 03,20 get nNum2
   read
   
   if lastkey() == 27
      cCor   := 'G/N'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

   nProduto := nNum1 * nNum2

   @ 04,20 say nProduto
enddo

InKey(0)
