//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
Set Message to 23 Center

clear

nQuantidadedeProdutos := 0

cItem        := ""
cProdutos    := ""
cDescricoes  := ""
cQuantidades := ""


cDATACADASTRO := ""

do while .t.

   nOpcao    := 0

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

         @ 04,34 get cIDPRODUTO   picture "@!"   valid !Empty(cIDPRODUTO) .AND. Len(cIDPRODUTO) == 8 //.AND. cIDPRODUTO !$ " "
         @ 05,34 get cDescricao   picture "@!"   //valid !Empty(cDescricao)
         @ 06,34 get nQuantidade  picture "9999" //valid nQuantidade > 0
         @ 07,34 get dDataCadastro               //valid !Empty(dDataCadastro) .AND. dDataCadastro >= date()
         read

         cDescricoes   += ALLTRIM(cDescricao) + " "
         cQuantidades  += ALLTRIM(TRANSFORM(nQuantidade, "9999")) + " "
         cDATACADASTRO += Dtoc(dDataCadastro) + " "

         if lastkey() == 27
            cMensagem := 'DESEJA SAIR?'
            cCor   := 'W/R'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
            if nOpcao == 1
               EXIT
            endif
         endif

         if Len(Alltrim(cIDPRODUTO)) != 8
            Alert("O ID DEVE CONTER EXATAMENTE 8 CARACTERES", "W/R")
            loop
         endif

         if " " $ cIDPRODUTO
            Alert("NAO PODE CONTER ESPACOS EM BRANCO", "W/R")
            loop
         endif

         nLetras   := 0
         nNums     := 0
         nContador := 0

         lInvalido := .f.

         do while nContador < Len(cIDPRODUTO)
            cChar := SubStr(cIDPRODUTO, nContador++,1)
            if cChar >= "A" .AND. cChar <= "Z"
               nLetras += 1
            elseif cChar >= "0" .AND. cChar <= "9"
               nNums += 1
            else
               lInvalido := .t.
            endif
         enddo

         if lInvalido
            Alert("PERMITIDO APENAS LETRAS E NUMEROS" , "W/R")
            loop
         endif

         if nLetras < 5 .OR. nNums < 2
            Alert("O ID DEVE CONTER NO MINIMO 4 LETRAS E 2 NUMEROS")
            loop
         endif

         if cIDPRODUTO $ cProdutos
            Alert("ID JA CADASTRADO" , "W/R")
            loop
         endif

         cProdutos += cIDPRODUTO
         cItem     += " " + nQuantidadedeProdutos
         nQuantidadedeProdutos++

         Alert("PRODUTO CADASTRADO COM SUCESSO", "W/G")
         Alert(cProdutos + " " + cItem + ' ' + cQuantidades + " " + cDATACADASTRO + cDescricoes)
      enddo
   elseif nOpcao == 2
      @ 04,15 clear to 23,25
      do while .t.
         nLinha      := 4
         nBuscadorID := 1

         do while .t.
            @ 04,25 to 23,25

            nMenu := 0

            @ nLinha,15 prompt SubStr(cProdutos,nBuscadorID,8)

            menu to nMenu

            nLinha++
            nBuscadorID += 8

            if nMenu $ cItem
               @ 04,25 clear to 23,79

               @ 04,27 say "ID (8 CARACTERES): " + SubStr(cProdutos,nBuscadorID,8)
               @ 05,27 say "DESCRICAO........: " + AllTrim(SubStr(cDescricoes,1,30))
               @ 06,27 say "QUANTIDADE.......: " + AllTRIM(SubStr(cQuantidade,1,4))
               @ 07,27 say "DATA DE CADASTRO.: " + Dtoc(dDataCadastro)

               if lastkey() == 27
               cMensagem := 'DESEJA SAIR?'
               cCor   := 'W/R'
               nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
                  if nOpcao == 1
                     EXIT
                  endif

               endif
            endif
         enddo
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
