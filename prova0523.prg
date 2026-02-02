//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 23 center

clear

do while .t. 
   cCorAlerta := 'W/R'
   
   cSenha   := Space(30)
   cUsuario := Space(30)

   @ 01,00 to 24,79

   @ 00,30 say "FRUTARIA DO ANDRE"
   @ 11,22 say "USUARIO:"
   @ 12,22 say "SENHA..:"
   
   @ 11,31 get cUsuario picture "@!" valid !Empty(cUsuario)
   @ 12,31 get cSenha   picture "@!" valid !Empty(cSenha)
   read
   
   if lastkey() == 27
      cMensagem  := 'DESEJA SAIR?'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif
   
   if Alltrim(cSenha) != "SENHA1234" .AND. Alltrim(cUsuario) != "ANDREAM" 
      Alert("USUARIO OU SENHA INCORRETOS", cCorAlerta)
      loop
   endif

   @ 02,01 clear to 23,78

   nOpcao := 0

   @ 03,02 prompt "EFETUAR PEDIDOS" message "CRIA UM NOVO PEDIDO"
   @ 04,02 prompt "SAIR..........." 
      
   menu to nOpcao

   if nOpcao == 1

   endif
   if nOpcao 
   
enddo

InKey(0)
