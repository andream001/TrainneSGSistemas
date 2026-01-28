Set date BRITISH
Set epoch to 1940
SetColor('W/N')

clear

do while .t.
    
   cNome  := Space(30)

   dDataNascimento := CToD("")
    
   nPeso := 0

   @ 02,02 say "NOME..............:"
   @ 03,02 say "DATA DE NASCIMENTO:"        
   @ 04,02 say "PESO..............:"
    
   @ 02,22 get cNome picture "@!"  valid !Empty(cNome)
   @ 03,22 get dDataNascimento     valid !Empty(dDataNascimento)
   @ 04,22 get nPeso picture "999" valid nPeso > 0
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

   cDados := (cNome + " " + Dtoc(dDataNascimento)) + " " + AllTrim(Str(nPeso))

   @ 06,02 say cDados
   @ 08,02 say "NOME..............:" + SubStr(cDados, 1,30)
   @ 09,02 say "DATA DE NASCIMENTO:" + SubStr(cDados, 32,8)
   @ 10,02 say "PESO..............:" + SubStr(cDados, 41)

enddo

InKey(0)
