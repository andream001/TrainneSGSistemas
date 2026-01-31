//ANDRE LUIZ BUNHAK - SISTEMA FINAL COMPLETO

Set date BRITISH
Set epoch to 1940
Set Message to 23 Center

clear

nQuantidadedeProdutos := 0
cProdutos    := ""
cDescricoes  := ""
cQuantidades := ""
cDATACADASTRO := ""
cItem        := ""

do while .t.
   nOpcao := 0

   @ 03,00 to 03,79
   @ 04,13 to 25,13
   @ 01,00 to 24,79

   @ 02,25 say "PRODUTOS TRAINEE SG SISTEMAS"

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
         dDataCadastro := Ctod("  /  /  ")

         @ 04,15 say "ID (8 MAIÚSC >=4LET >=2NUM):"
         @ 05,15 say "DESCRICAO........:"
         @ 06,15 say "QUANTIDADE.......:"
         @ 07,15 say "DATA DE CADASTRO.:"

         @ 04,34 get cIDPRODUTO picture "@!"  
         @ 05,34 get cDescricao picture "@S30"  
         @ 06,34 get nQuantidade picture "9999"  
         @ 07,34 get dDataCadastro picture "@D" 
         read

         if LastRec() == 27
            cMensagem := 'DESEJA SAIR?'
            nOpcaoSair := Alert(cMensagem, {'SIM','NAO'}, 'W/R')
            if nOpcaoSair == 1
               EXIT
            endif
            loop
         endif

         // VALIDA CAMPOS OBRIGATÓRIOS
         if Empty(AllTrim(cIDPRODUTO)) .or. Empty(AllTrim(cDescricao)) .or. nQuantidade < 1 .or. Empty(dDataCadastro)
            Alert("TODOS OS CAMPOS SAO OBRIGATORIOS!", "W/R")
            loop
         endif

         // SUAS VALIDAÇÕES ID (PERFEITAS)
         if Len(AllTrim(cIDPRODUTO)) != 8
            Alert("ID DEVE TER EXATAMENTE 8 CARACTERES", "W/R")
            loop
         endif
         if " " $ cIDPRODUTO
            Alert("NAO PODE ESPAÇOS EM BRANCO", "W/R")
            loop
         endif
         nLetras := 0
         nNums := 0
         nContador := 0
         lInvalido := .f.
         do while nContador < Len(cIDPRODUTO)
            cChar := SubStr(cIDPRODUTO, nContador++ + 1, 1)
            if cChar >= "A" .AND. cChar <= "Z"
               nLetras += 1
            elseif cChar >= "0" .AND. cChar <= "9"
               nNums += 1
            else
               lInvalido := .t.
            endif
         enddo
         if lInvalido
            Alert("APENAS LETRAS MAIÚSCULAS E NÚMEROS", "W/R")
            loop
         endif
         if nLetras < 4 .OR. nNums < 2
            Alert("MINIMO: 4 LETRAS MAIÚSCULAS + 2 NÚMEROS", "W/R")
            loop
         endif

         // VERIFICA DUPLICATA
         if cIDPRODUTO $ cProdutos
            Alert("PRODUTO JÁ CADASTRADO!", "W/R")
            loop
         endif

         // ARMAZENA
         cProdutos += cIDPRODUTO + " "
         cDescricoes += AllTrim(cDescricao) + " "
         cQuantidades += AllTrim(Str(nQuantidade)) + " "
         cDATACADASTRO += DToC(dDataCadastro) + " "
         cItem += Str(nQuantidadedeProdutos + 1) + " "
         nQuantidadedeProdutos++

         Alert("PRODUTO CADASTRADO!", "W/G")
         EXIT  // SAI APÓS SUCESSO
      enddo

   elseif nOpcao == 2
      // DELETAR - LISTA + CALENDÁRIO + CONFIRMAÇÃO
      if nQuantidadedeProdutos == 0
         Alert("NENHUM PRODUTO CADASTRADO!", "W/R")
         loop
      endif

      do while .t.
         @ 04,14 clear to 23,78
         ? @ 05,15 say "LISTA PRODUTOS (escolha para DELETAR):"

         // MENU COM TODOS PRODUTOS
         nEscolhido := 0
         nPosID := 1
         for i := 1 to nQuantidadedeProdutos
            cLinhaLista := SubStr(cProdutos, nPosID, 8) + " - " + ;
                          SubStr(cDescricoes, 1, 20) + " Q:" + ;
                          SubStr(cQuantidades, 1, 4)
            @ 07 + i, 16 PROMPT cLinhaLista
            nPosID := nPosID + 9  // Pula espaço
         next
         menu to nEscolhido
         
         if nEscolhido == 0 .or. LastKey() == 27
            EXIT
         endif

         // MOSTRA DETALHES DO ESCOLHIDO
         @ 04,14 clear to 23,78
         nPosID := (nEscolhido - 1) * 9 + 1
         @ 05,20 say "PRODUTO SELECIONADO:"
         @ 07,20 say "ID: " + SubStr(cProdutos, nPosID, 8)
         @ 08,20 say "DESC: " + AllTrim(SubStr(cDescricoes, (nEscolhido-1)*31 + 1, 30))
         @ 09,20 say "QTD: " + SubStr(cQuantidades, (nEscolhido-1)*6 + 1, 4)
         @ 10,20 say "DATA: " + SubStr(cDATACADASTRO, (nEscolhido-1)*11 + 1, 10)

         // CALENDÁRIO SIMPLES DO MÊS
         @ 12,15 say "CALENDARIO DO MES:"
         @ 13,15 say "DOM SEG TER QUA QUI SEX SAB"
         dDataSel := Ctod(SubStr(cDATACADASTRO, (nEscolhido-1)*11 + 1, 10))
         nMes := Month(dDataSel)
         nDiaSel := Day(dDataSel)
         for j := 1 to 30  // 30 dias genérico
            cDia := iif(j == nDiaSel, "[" + StrZero(j,2) + "]", StrZero(j,2))
            @ 14 + Int((j-1)/7), 15 + Mod((j-1),7)*5 say cDia
         next

         // CONFIRMA DELETE
         cMsgDelete := "DELETAR " + SubStr(cProdutos, nPosID, 8) + "?"
         nConf := Alert(cMsgDelete, {'SIM','NAO'}, 'W/R')
         if nConf == 1
            // REMOVE DA STRING (SIMULA DELETE)
            cNovosProdutos := ""
            cNovasDesc := ""
            cNovasQtd := ""
            cNovasData := ""
            nNovaQtde := 0
            nPosNova := 1
            for k := 1 to nQuantidadedeProdutos
               if k != nEscolhido
                  nNovaQtde++
                  cNovosProdutos += SubStr(cProdutos, nPosNova, 8) + " "
                  cNovasDesc += SubStr(cDescricoes, nPosNova, 30) + " "
                  cNovasQtd += SubStr(cQuantidades, nPosNova, 6) + " "
                  cNovasData += SubStr(cDATACADASTRO, nPosNova, 11) + " "
               endif
               nPosNova := nPosNova + 9
            next
            cProdutos := cNovosProdutos
            cDescricoes := cNovasDesc
            cQuantidades := cNovasQtd
            cDATACADASTRO := cNovasData
            nQuantidadedeProdutos := nNovaQtde
            Alert("PRODUTO DELETADO!", "W/G")
         else
            Alert("CANCELADO", "W/BG")
         endif
         Inkey(2)
         EXIT
      enddo

   elseif nOpcao == 3
      cMensagem := 'DESEJA SAIR?'
      nSair := Alert(cMensagem, {'SIM','NAO'}, 'R/W')
      if nSair == 1
         EXIT
      endif
      loop
   endif
enddo
InKey(0)