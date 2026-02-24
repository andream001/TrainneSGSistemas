//ANDRE LUIZ BUNHAK 

// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Exibe mensagem de status na linha 23, centralizada
Set Message to 23 Center

// Limpa a tela
clear

// Inicializa o contador de produtos e os bancos de dados em memoria (strings concatenadas)
nQuantidadedeProdutos := 0

cProdutos     := ""   // armazena IDs dos produtos separados por espaco
cDescricoes   := ""   // armazena descricoes dos produtos
cQuantidades  := ""   // armazena quantidades dos produtos
cDATACADASTRO := ""   // armazena datas de cadastro
cItem         := ""   // armazena numeros sequenciais dos itens

// Loop principal do menu
do while .t.
  
   nOpcao := 0

   // Desenha a estrutura da tela com bordas e cabecalho
   @ 03,00 to 03,79
   @ 04,13 to 25,13
   @ 01,00 to 24,79

   @ 02,25 say "PRODUTOS TRAINEE SG SISTEMAS"

   // Exibe as opcoes do menu principal
   @ 04,02 prompt "CADASTRAR" Message "CADASTRA UM NOVO PRODUTO"
   @ 05,02 prompt "DELETAR"   Message "DELETA UM PRODUTO EXISTENTE"
   @ 06,02 prompt "SAIR"      Message "SAIR DO PROGRAMA"

   menu to nOpcao

   // Opcao 1: Cadastrar novo produto
   if nOpcao == 1
      do while .t.
         @ 04,14 clear to 23,78

         // Inicializa as variaveis do formulario de cadastro
         cIDPRODUTO := Space(8)
         cDescricao := Space(30)
         nQuantidade := 0
         dDataCadastro := Ctod("  /  /  ")

         // Exibe os rotulos dos campos de cadastro
         @ 04,15 say "ID (8 CARACTERES):"
         @ 05,15 say "DESCRICAO........:"
         @ 06,15 say "QUANTIDADE.......:"
         @ 07,15 say "DATA DE CADASTRO.:"

         // Leitura dos dados do produto com validacoes
         @ 04,34 get cIDPRODUTO    picture "@!"   valid !Empty(cIDPRODUTO) .AND. Len(cIDPRODUTO) == 8
         @ 05,34 get cDescricao    picture "@!"   valid !Empty(cDescricao)
         @ 06,34 get nQuantidade   picture "9999" valid nQuantidade > 0
         @ 07,34 get dDataCadastro                valid !Empty(dDataCadastro) .AND. dDataCadastro >= date()
         read

         // Se pressionou ESC, pergunta se deseja sair do cadastro
         if LastKEY() == 27
            cMensagem := 'DESEJA SAIR?'
            nOpcaoSair := Alert(cMensagem, {'SIM','NAO'}, 'W/R')
            if nOpcaoSair == 1
               EXIT
            endif
            loop
         endif

         // Valida se todos os campos foram preenchidos
         if Empty(AllTrim(cIDPRODUTO)) .or. Empty(AllTrim(cDescricao)) .or. nQuantidade < 1 .or. Empty(dDataCadastro)
            Alert("TODOS OS CAMPOS SAO OBRIGATORIOS!", "W/R")
            loop
         endif

         // Valida o tamanho do ID do produto (exatamente 8 caracteres)
         if Len(AllTrim(cIDPRODUTO)) != 8
            Alert("ID DEVE TER EXATAMENTE 8 CARACTERES", "W/R")
            loop
         endif
         // Nao permite espacos no ID do produto
         if " " $ cIDPRODUTO
            Alert("NAO PODE ESPAÇOS EM BRANCO", "W/R")
            loop
         endif
         // Valida que o ID contenha apenas letras maiusculas e numeros
         nLetras := 0
         nNums := 0
         nContador := 0
         lInvalido := .f.
         do while nContador < Len(cIDPRODUTO)
            cChar := SubStr(cIDPRODUTO, nContador++, 1)
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
         // Valida o minimo de 4 letras e 2 numeros no ID
         if nLetras < 4 .OR. nNums < 2
            Alert("MINIMO: 4 LETRAS MAIÚSCULAS + 2 NÚMEROS", "W/R")
            loop
         endif

         // Verifica se o produto ja esta cadastrado (ID duplicado)
         if cIDPRODUTO $ cProdutos
            Alert("PRODUTO JÁ CADASTRADO!", "W/R")
            loop
         endif

         // Adiciona o produto ao banco de dados em memoria
         cProdutos     += cIDPRODUTO + " "
         cDescricoes   += AllTrim(cDescricao) + " "
         cQuantidades  += AllTrim(Str(nQuantidade)) + " "
         cDATACADASTRO += DToC(dDataCadastro) + " "
         cItem         += Str(nQuantidadedeProdutos + 1) + " "
         nQuantidadedeProdutos++

         Alert("PRODUTO CADASTRADO!", "W/G")
         
      enddo

   // Opcao 2: Deletar produto existente
   elseif nOpcao == 2
      // Verifica se ha produtos cadastrados antes de tentar deletar
      if nQuantidadedeProdutos == 0
         Alert("NENHUM PRODUTO CADASTRADO!", "W/R")
         loop
      endif

      do while .t.
         @ 04,14 clear to 23,78
         @ 05,15 say "LISTA PRODUTOS (escolha para DELETAR):"

         nEscolhido := 0
         nPosID := 1
         
         // Exibe a lista de produtos para selecao
         do while .t.
            nContador := 1
            cLinhaLista := SubStr(cProdutos, nPosID, 8) 
                          SubStr(cDescricoes, 1, 20) 
                          SubStr(cQuantidades, 1, 4)
            @ 07 + ncONTADOR, 16 PROMPT cLinhaLista
            nPosID := nPosID + 9  
         menu to nEscolhido
         enddo
         
         // Se nenhum produto foi escolhido ou pressionou ESC, sai do loop de delecao
         if nEscolhido == 0 .or. LastKey() == 27
            EXIT
         endif


         @ 04,14 clear to 23,78
        
         // Calcula a posicao do produto selecionado na string de dados
         nPosID := (nEscolhido - 1) * 9 + 1
        
         // Exibe os dados do produto selecionado para confirmacao
         @ 05,20 say "PRODUTO SELECIONADO:"
         @ 07,20 say "ID...........: " + SubStr(cProdutos, nPosID, 8)
         @ 08,20 say "DESCRICAO....: " + AllTrim(SubStr(cDescricoes, (nEscolhido-1) * 31 + 1, 30))
         @ 09,20 say "QUANTIDADE...: " + SubStr(cQuantidades, (nEscolhido-1) * 6 + 1, 4)
         @ 10,20 say "DATA CADASTRO: " + SubStr(cDATACADASTRO, (nEscolhido-1) * 11 + 1, 10)
         @ 12,15 say "CALENDARIO DO MES:"
         @ 13,15 say "DOM SEG TER QUA QUI SEX SAB"
         
         // Obtem a data de cadastro do produto para exibicao do calendario
         dDataSel := Ctod(SubStr(cDATACADASTRO, (nEscolhido - 1) * 11 + 1, 10))
         nMes     := Month(dDataSel)
         nDiaSel  := Day(dDataSel)
         
        
         
         // Confirma a exclusao do produto selecionado
         cMsgDelete := "DELETAR " + SubStr(cProdutos, nPosID, 8) + "?"
         nConf := Alert(cMsgDelete, {'SIM','NAO'}, 'W/R')
         if nConf == 1
            // Reconstroi os bancos de dados sem o produto deletado
            cNovosProdutos := ""
            cNovasDesc     := ""
            cNovasQtd      := ""
            cNovasData     := ""
            nNovaQtde      := 0
            nPosNova       := 1
               if k != nEscolhido
                  nNovaQtde++
                  cNovosProdutos += SubStr(cProdutos, nPosNova, 8) + " "
                  cNovasDesc += SubStr(cDescricoes, nPosNova, 30) + " "
                  cNovasQtd += SubStr(cQuantidades, nPosNova, 6) + " "
                  cNovasData += SubStr(cDATACADASTRO, nPosNova, 11) + " "
               endif
               nPosNova := nPosNova + 9

            // Atualiza os bancos de dados com os produtos restantes
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

   // Opcao 3: Sair do programa
   elseif nOpcao == 3
      cMensagem := 'DESEJA SAIR?'
      nSair := Alert(cMensagem, {'SIM','NAO'}, 'R/W')
      if nSair == 1
         EXIT
      endif
      loop
   endif
enddo
// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)