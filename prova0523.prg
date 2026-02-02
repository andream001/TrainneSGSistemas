//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')

clear

do while 
   cSenha   := Space(20)
   cUsuario := Space(30)

   @ 01,00 to 24,79

   @ 11,33 say "USUARIO:"
   @ 12,33 say "SENHA..:"
   
   @ 11,42 get cUsuario picture "@!" valid !Empty(cUsuario)
   @ 12,42 get cSenha   picture "@!" valid !Empty(cSenha)

   if Alltrim(cSenha) == "SENHA1234" .AND. cUsuario

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
enddo

InKey(0)
