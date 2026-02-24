//ANDRE LUIZ BUNHAK

// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo preto com texto branco
SetColor('W/N')

// Limpa a tela
clear

// Loop principal: controla o ciclo de login e ordens de servico
do while .t.
   clear

   cCorAlerta := 'W/R'
   cUsuario   := 'JOSE'   // usuario autorizado a acessar o sistema
   
   // Inicializa todas as variaveis a cada nova sessao
   cLogin       := Space(30)
   cSenha       := Space(30)
   cNomeCliente := Space(40)
   cEquipamento := Space(40)
   cNomeTecnico := Space(30)
   cEntrega     := Space(1)
   
   cFormaPagamento := Space(1)

   cEnderecoEntrega  := Space(30)
   cBairro           := Space(20)
   cReferencia       := Space(30)
   cTelefone         := Space(20)
   cDescricaoProduto := Space(30)
   cDescricaoServico := Space(25)
   
   cTipo := Space(1)   // P = Produto, S = Servico

   nQuantidadePagamento := 0
   
   nDesconto := 0

   nTaxadeEntrega    := 0
   nOrdemdeServico   := 1000   // numero inicial das ordens de servico
   nLimiteCredito    := 0
   nControleLinha    := 8
   nValorTotal       := 0
   nValorComGarantia := 0
   nPrecoUnitario    := 0
   nPrecoTotal       := 0
   nQuantidade       := 0
   nComissaoTecnico  := 0
   nDesconto         := 0
  
   dDataOrdemServico := CToD("")
   dDataCompra       := CToD("")

   // Exibe a tela de login
   @ 01,00 to 24,79

   @ 01,30 say "ASSISTENCIA DO ANDRE"
   @ 11,22 say "USUARIO:"
   @ 12,22 say "SENHA..:"
    
   // Leitura das credenciais de acesso
   @ 11,31 get cLogin picture "@!" valid !Empty(cUsuario)
   @ 12,31 get cSenha              valid !Empty(cSenha)
   read
   
   // Se pressionou ESC, pergunta se deseja sair
   if lastkey() == 27
      cMensagem := 'DESEJA SAIR?'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif
   
   // Valida as credenciais: login deve ser JOSE e senha 432mudar123
   if Alltrim(cSenha) != "432mudar123" .OR. Alltrim(cLogin) != cUsuario 
      Alert("USUARIO OU SENHA INCORRETOS", cCorAlerta)
      loop
   endif

   // Limpa a area de conteudo e exibe o menu lateral
   @ 02,01 clear to 23,78
   @ 02,19 to 23,19

   nOpcao := 0

   // Opcoes do menu: efetuar pedidos ou sair
   @ 03,02 prompt "EFETUAR PEDIDOS" message "CRIA UM NOVO PEDIDO"
   @ 04,02 prompt "SAIR..........." Message "SAIR DO PROGRAMA"
      
   menu to nOpcao

   // Opcao 1: Criar nova ordem de servico
   if nOpcao == 1
      do while .T.
         @02,01 clear to 23,78
         
         // Exibe os campos do cabecalho da ordem de servico
         @ 02,01 say "ORDEM DE SERVICO......:" + Alltrim(Transform(nOrdemdeServico, "00000009"))
         @ 02,55 say "TIPO:[P]RODUTO [S]ERVICO"
         @ 03,01 say "NOME DO CLIENTE.......:"
         @ 04,55 say "LIMITE........:R$ "
         @ 04,01 say "DATA(ORDEM DE SERVICO):"
         @ 05,01 say "NOME DO TECNICO.......:"
         @ 05,55 say "DATA DA COMPRA:"
         @ 06,01 say "DESCRICAO EQUIPAMENTO.:"
         @ 07,55 say "TIPO..........:"
         @ 07,01 say "ENTREGA A DOMICILIO...:   [S]IM [N]AO"
         
         // Leitura dos dados do cabecalho da ordem de servico
         @ 03,24 get cNomeCliente      picture "@!"           valid !Empty(cNomeCliente)
         @ 04,24 get dDataOrdemServico                        valid dDataOrdemServico >= Date()
         @ 04,70 get nLimiteCredito    picture "@E 99,999.99" valid nLimiteCredito    >= 0 
         @ 05,24 get cNomeTecnico      picture "@!"           valid !Empty(cNomeTecnico)
         @ 05,70 get dDataCompra                              valid !Empty(dDataCompra)
         @ 06,24 get cEquipamento      picture "@!"           valid !Empty(cEquipamento)
         @ 07,24 get cEntrega          picture "@!"           valid cEntrega $ "SN"
         @ 07,70 get cTipo             picture "@!"           valid cTipo    $ "PS" 
         read
         
         // Se pressionou ESC, pergunta se deseja sair
         if lastkey() == 27
            cMensagem := 'DESEJA SAIR?'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
            if nOpcao == 1
               EXIT
            endif
            loop
         endif
         
         // Se a entrega e a domicilio, coleta os dados de endereco e aplica taxa de 20%
         if cEntrega == 'S'
            nTaxadeEntrega := 0.2
            @ 22,01 clear to 23,78
            @ 08,01 to 08,78
            
            @ 09,01 say "ENDERECO..:"
            @ 09,45 say "BAIRRO..:"
            @ 10,01 say "REFERENCIA:"
            @ 10,45 say "TELEFONE:"

            // Leitura dos dados de endereco para entrega
            @ 09,13 get cEnderecoEntrega picture "@!"               valid !Empty(cEnderecoEntrega)
            @ 09,55 get cBairro          picture "@!"               valid !Empty(cBairro)
            @ 10,13 get cReferencia      picture "@!"               valid !Empty(cReferencia)
            @ 10,55 get cTelefone        picture "(99) 9 9999-9999" valid !Empty(cTelefone)
            read
            
            // Se pressionou ESC no endereco, pergunta se deseja sair
            if lastkey() == 27
               cMensagem := 'DESEJA SAIR?'
               nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
               if nOpcao == 1
                  EXIT
               endif
               loop
            endif
            
            @ 11,01 to 11,78
          
// Verifica se o valor com garantia ultrapassa o limite de credito do cliente
if nValorComGarantia > nLimiteCredito
               
               cSupervisor      := Space(15)
               cSenhaSupervisor := Space(15)
               
               // Notifica que o supervisor precisa autorizar a operacao
               Alert("LIMITE EXCEDIDO - SUPERVISOR", {"SIM" , "CANCELAR" } , cCorAlerta)
               @ 22,22 say "SUPERVISOR SOLICITADO:"
               @ 23,22 say "SENHA SUPERVISOR.....:"
               
               @ 22,48 get cSupervisor      picture "@!" valid !Empty(cSupervisor)
               @ 23,48 get cSenhaSupervisor picture "@!" valid !Empty(cSenhaSupervisor)
               read
               
               if lastkey() == 27
                  cMensagem := 'DESEJA SAIR?'
                  nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
                  if nOpcao == 1
                     EXIT
                  endif
                  loop
               endif
               // Valida a senha do supervisor
               if cSenhaSupervisor != "AUTORIZA99"
                  Alert("SENHA INCORRETA",cCorAlerta)
                  loop
               endif
            endif
            
            // Processa de acordo com o tipo: P = Produto, S = Servico
            if cTipo == "P"
               // Loop de lancamento de produtos
               do while .T.
                  @ 09,01 clear to 11,78

                  @ 09,01 say "DESCRICAO PRODUTO:"
                  @ 09,50 say 'QUANTIDADE.:' 
                  @ 10,01 say "PRECO UNITARIO:R$ "
                  @ 10,50 say "DESCONTO(%):"
                  
                  @ 11,01 to 11,78

                  // Leitura dos dados do produto
                  @ 09,22 get cDescricaoProduto picture "@!"              valid !Empty(cDescricaoProduto)
                  @ 09,62 get nQuantidade       picture "999"             valid nQuantidade    >  0
                  @ 10,22 get nPrecoUnitario    picture "@E 9,999,999.99" valid nPrecoUnitario >  0
                  @ 10,62 get nDesconto         picture "99.99"           valid nDesconto      >= 0
                  read
                  
                  if lastkey() == 27
                     cMensagem := 'DESEJA FINALIZAR?'
                     nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
                     if nOpcao == 1
                        EXIT
                     endif
                     loop
                  endif
            
                  // Calcula o valor total do produto com desconto
                  nValorTotal := (nPrecoUnitario * nQuantidade) - ((nPrecoUnitario * nQuantidade) * (nDesconto / 100))
                  
                  // Verifica se o produto ainda esta na garantia (ate 2 anos da data de compra)
                  nIdadeProduto := Year(dDataCompra) 
                  nIdadeAtual := Year(Date())
                  nDiferencaAnos := nIdadeAtual - nIdadeProduto
                  
                  if nDiferencaAnos <= 2
                     nValorComGarantia := 0   // produto na garantia: sem custo para o cliente
                  else
                     nValorComGarantia := nValorTotal   // fora da garantia: cliente paga
                  endif
                  
                  // Exibe o valor total e o valor considerando garantia
                  @ 22,01 say "VALOR TOTAL: R$ " + Alltrim(Transform(nValorTotal, "@E 9,999,999.99")) + "  |  COM GARANTIA: R$ " + Alltrim(Transform(nValorComGarantia, "@E 9,999,999.99"))
                  nOrdemdeServico++
               enddo
            elseif cTipo == "S"
               // Loop de lancamento de servicos
               do while .t.
                  
                  @ 09,01 clear to 11,78
                  
                  @ 09,01 say "DESCRICAO DO SERVICO:"
                  @ 09,50 say "PRECO:R$ "
                  @ 10,01 say "DESCONTO(%):"
                  @ 10,50 say "COMISSAO TECNICO(%):"
                  
                  // Leitura dos dados do servico
                  @ 09,25 get cDescricaoServico picture "@!"    valid !Empty(cDescricaoServico)
                  @ 09,59 get nPrecoTotal       picture "@E 9,999,999.99" valid nPrecoTotal > 0
                  @ 10,25 get nDesconto         picture "99.99" valid nDesconto        >= 0
                  @ 10,65 get nComissaoTecnico  picture "99.99" valid nComissaoTecnico >= 0
                  read
                  
                  // Calcula o valor total do servico com desconto
                  nValorTotal := nPrecoTotal - (nPrecoTotal * (nDesconto / 100))
                  
                  // Verifica se o servico esta na garantia (ate 12 meses da data de compra)
                  nIdadeServico := MONTH(Date()) - MONTH(dDataCompra)
                  
                  if nIdadeServico <= 12
                     nValorComGarantia := 0   // servico na garantia: sem custo
                  else
                     nValorComGarantia := nValorTotal   // fora da garantia: cliente paga
                  endif

                  @ 11,01 to 11,78

                  if lastkey() == 27
                     cMensagem := 'O QUE DESEJA FAZER'
                     nOpcao := Alert(cMensagem, {'SAIR' , 'FATURAR' , 'CONTINUAR'} , cCorAlerta)
                     if nOpcao == 1
                        EXIT
                     elseif nOpcao == 2
                        // Fatura o servico
                        if nValorComGarantia == 0
                           // Servico coberto pela garantia: exige nota fiscal
                           @ 12,01 clear to 23,78
                           @ 12,01 say "GARANTIA COBRE TODO O CONSERTO - NOTA FISCAL NECESSARIA"
                           @ 14,01 say "CNPJ EMPRESA.:"
                           @ 15,01 say "NUMERO NOTA.:"
                           @ 16,01 say "DATA NOTA...:"
                           
                           cCNPJ := Space(14)
                           cNumeroNota := Space(10)
                           dDataNota := CToD("")
                           
                           // Leitura dos dados da nota fiscal
                           @ 14,20 get cCNPJ       picture "99.999.999/0001-99" valid !Empty(cCNPJ)
                           @ 15,20 get cNumeroNota picture "9999999999" valid !Empty(cNumeroNota)
                           @ 16,20 get dDataNota                     valid dDataNota >= Date()
                           read
                           
                           Alert("NOTA FISCAL REGISTRADA", {"OK"}, cCorAlerta)
                        else
                           // Servico fora da garantia: coleta forma de pagamento
                           @ 12,01 clear to 13,78
                           @ 12,01 say "FORMA DE PAGAMENTO: (D)INHEIRO, (C)HEQUE OU (T)CARTAO"
                           
                           cFormaPagamento := Space(1)
                           @ 12,51 get cFormaPagamento picture "@!" valid cFormaPagamento $ "DCT"
                           read
                           
                           nTotalPago := 0
                           
                           // Loop de recebimento de pagamentos ate completar o valor
                           do while nTotalPago < nValorComGarantia
                              nValorPago := 0
                              @ 13,01 clear to 13,78
                              @ 13,01 say "VALOR A PAGAR: R$ " + Alltrim(Transform(nValorComGarantia - nTotalPago, "@E 9,999,999.99")) + "  |  VALOR: R$ "
                              @ 13,51 get nValorPago picture "@E 9,999,999.99" valid nValorPago > 0
                              read
                              
                              nTotalPago += nValorPago
                           enddo
                        endif
      
                        // Calcula e exibe a comissao do tecnico
                        nComissaoTotal := nValorTotal * (nComissaoTecnico / 100)
                        @ 17,01 say "COMISSAO DO TECNICO: R$ " + Alltrim(Transform(nComissaoTotal, "@E 9,999,999.99"))
                        
                        Inkey(0)
                        EXIT
                     endif
                  endif
                  
                  // Exibe o resumo de valores calculados
                  @ 22,01 say "VALOR TOTAL: R$ " + Alltrim(Transform(nValorTotal, "@E 9,999,999.99")) + "  |  COM GARANTIA: R$ " + Alltrim(Transform(nValorComGarantia, "@E 9,999,999.99"))
                  nOrdemdeServico++
                  
               enddo
            endif
         endif
         Inkey(0)
      enddo
   else
      // Opcao 2 ou invalida: encerra o programa
      Alert("Saindo...", cCorAlerta)
      exit
   endif
enddo
