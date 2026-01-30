//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
Set Message to 23 Center

clear

do while .t.

   nOpcao := 0
   
   
   @ 03,00 to 03,79
   @ 04,13 to 25,13
   @ 01,00 to 24,79
   
   @ 02,25 say "PRODUTOS TRAINNE SG SISTEMAS"
   
   @ 04,02 prompt "CADASTRAR" Message "CADASTRA UM NOVO PRODUTO"
   @ 05,02 prompt "DELETAR"   Message "DELETA UM PRODUTO EXISTENTE"
   @ 06,02 prompt "SAIR"      Message "SAIR DO PROGRAMA"
   
   menu to nOpcao
   
   if nOpcao == 1
      do while .t.
         @ 04,14 clear to 23,78
         
         cIDPRODUTO := Space(8)
         cDescricao := Space(30)
      
         nQuantidade := 0
      
         dData         := date()
         dDataCadastro := Ctod(" ")

         @ 04,15 say "ID (8 CARACTERES):"
         @ 05,15 say "DESCRICAO........:"
         @ 06,15 say "QUANTIDADE.......:"
         @ 07,15 say "DATA DE CADASTRO.:"

         @ 04,34 get cIDPRODUTO   picture "@!"   valid !Empty(cIDPRODUTO) .AND. Len(cIDPRODUTO) == 8
         @ 05,34 get cDescricao   picture "@!"   valid !Empty(cDescricao)
         @ 06,34 get nQuantidade  picture "9999" valid nQuantidade > 0 
         @ 07,34 get dDataCadastro               valid !Empty(dDataCadastro) .AND. dDataCadastro >= date() 
         read

         if lastkey() == 27
            cMensagem := 'DESEJA SAIR?'
            cCor   := 'W/R'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
            if nOpcao == 1
               EXIT
            endif
         endif
      enddo
   elseif nOpcao == 2
      do while .t.
         @ 04,14 clear to 23,78
         @ 04,25 to 23,25
      
         nLinha := 4

         @ nLinha + 2,27 say Alltrim(cIDPRODUTO)
         
         if lastkey() == 27
            cMensagem := 'DESEJA SAIR?'
            cCor   := 'W/R'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
            if nOpcao == 1
               EXIT
            endif
         endif
      enddo

   
   elseif nOpcao == 3
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
