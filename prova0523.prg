//ANDRE LUIZ BUNHAK

// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo preto com texto branco
SetColor('W/N')
// Exibe mensagem de status na linha 23, centralizada
Set Message to 23 center

// Limpa a tela
clear

// Contador de pedidos, inicializado em 1
nContadorPedido := 1

// Loop principal: controla o ciclo de login e pedidos
do while .t. 
   clear
   
   cCorAlerta := 'W/R'   // cor padrao para alertas de erro
   
   // Inicializa as credenciais e os dados de estoque a cada iteracao
   cSenha   := Space(30)
   cUsuario := Space(30)
   
   // Estoque inicial de cada fruta
   nEstoqueJaca      := 7100
   nEstoqueUva       := 448.50
   nEstoqueTangerina := 145
   nEstoqueAbacate   := 280
   
   // Desenha a borda da tela e exibe o titulo
   @ 01,00 to 24,79
   
   @ 00,32 say "FRUTARIA DO ANDRE"
   @ 11,22 say "USUARIO:"
   @ 12,22 say "SENHA..:"
   
   // Leitura das credenciais de acesso
   @ 11,31 get cUsuario picture "@!" valid !Empty(cUsuario)
   @ 12,31 get cSenha   picture "@!" valid !Empty(cSenha)
   read
   
   // Se pressionou ESC, pergunta se deseja sair do sistema
   if lastkey() == 27
      cMensagem  := 'DESEJA SAIR?'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif
   
   // Valida as credenciais: usuario deve ser ANDREAM e senha SENHA1234
   if Alltrim(cSenha) != "SENHA1234" .OR. Alltrim(cUsuario) != "ANDREAM" 
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

   // Inicializa as variaveis do pedido
   cProduto := ""
   cCliente := Space(20)
   
   dDataPedido := CToD("")

   nLimite := 0
   
   // Precos unitarios das frutas
   nPrecoJaca      := 3.50
   nPrecoUva       := 15
   nPrecoTangerina := 21.90
   nPrecoAbacate   := 15.49

   // Codigos dos produtos
   nCODProduto   := 0
   nCODJaca      := 1100
   nCODUva       := 4544
   nCODTangerina := 3515
   nCodAbacate   := 7215

   // Percentuais maximos de desconto permitidos por produto
   nDescMaxJaca      := 12
   nDescMasUva       := 11
   nDescMaxTangerina := 10
   nDescMaxAbacate   := 3

   // Inicializa variaveis de calculo do pedido
   nQuantidadeProd := 0
   nPrecoUnitario  := 0
   nSubtotal       := 0
   nDesconto       := 0
   nTotal          := 0
   nDescontoMaximo := 0
   nEstoque        := 0

   // Controle de linhas para exibicao dos itens do pedido
   nLimiteLinha := 20
   nLinhaGet    := 9

   // Opcao 1: Efetuar pedidos
   if nOpcao == 1
      do while .T.
         clear
         
         @ 00,32 say "FRUTARIA DO ANDRE"

         // Desenha as bordas da tela do pedido
         @ 01,00 to 06,79
         @ 01,00 to 24,79

         // Exibe o numero do pedido atual e os campos do cabecalho
         @ 02,02 say "NUMERO DO PEDIDO.: " + Alltrim(Transform(nContadorPedido , "9"))
         @ 03,02 say "NOME CLIENTE.....: "
         @ 04,02 say "LIMITE DE CREDITO:R$ "
         @ 05,02 say "DATA DO PEDIDO...: "

         // Leitura dos dados do cabecalho do pedido
         @ 03,22 get cCliente picture "@!"            valid !Empty(cCliente)
         @ 04,22 get nLimite  picture "@E 99,9999.99" valid nLimite > 0
         @ 05,22 get dDataPedido                      valid !Empty(dDataPedido) .AND. dDataPedido >= Date()
         read

         // Se pressionou ESC no cabecalho, pergunta se deseja sair
         if lastkey() == 27
            cMensagem  := 'DESEJA SAIR?'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
            if nOpcao == 1
               EXIT
            endif
            loop
         endif
         
         // Loop de lancamento de itens do pedido
         do while .T.
            
            // Exibe o cabecalho da tabela de itens e os codigos disponiveis
            @ 07,02 say "CODIGO" + Space(3) + "PRODUTO" + Space(3) + "QUANTIDADE" + Space(3) + "UNIT.(R$)" + Space(3) + "DESCONTO(%)" + Space(5) + "SUB-TOTAL(R$)"
            @ 03,44 say "UVA   JACA  TANGERINA  ABACATE"
            @ 04,44 say "4544  1100     3515      7515"

            // Bordas de separacao da tabela
            @ 02,43 to 05,75 
            @ 08,01 to 08,78
            @ 20,01 to 20,78

            // Limpa as linhas se ultrapassou o limite de exibicao
            if nLinhaGet >= nLimiteLinha
               @ 10,01 clear to 19,78
               nLinhaGet    := 9
            endif

            // Leitura do codigo do produto
            @ nLinhaGet,03 get nCODProduto picture "9999" valid !Empty(nCODProduto)
            read
            
            // Se pressionou ESC, exibe opcoes de sair, faturar ou continuar
            if lastkey() == 27
               cMensagem  := 'O QUE DESEJA FAZER'
               nOpcao := Alert(cMensagem, {'SAIR' , 'FATURAR' , 'CONTINUAR'} , "G/W")
               if nOpcao == 1
                  EXIT
               elseif nOpcao == 3
                  loop
               elseif nOpcao == 2
                  // Fatura o pedido: exibe o total e incrementa o contador
                  @ 23,02 say "TOTAL:R$ " + Alltrim(Transform(nTotal, "@E 99,999.99")) 
                  nContadorPedido++
                  exit
               endif
            endif
            
            // Identifica o produto pelo codigo e define preco, desconto maximo e estoque
            if nCODProduto == 1100   
               cProduto := "JACA"
               
               nPrecoUnitario  := nPrecoJaca
               nDescontoMaximo := nDescMaxJaca
               nEstoque        := nEstoqueJaca
            elseif nCODProduto == 4544
               cProduto := "UVA" 
               
               nPrecoUnitario  := nPrecoUva
               nDescontoMaximo := nDescMasUva
               nEstoque        := nEstoqueUva
            elseif nCODProduto == 3515
               cProduto := "TANGERINA"
               
               nPrecoUnitario  := nPrecoTangerina
               nDescontoMaximo := nDescMaxTangerina
               nEstoque        := nEstoqueTangerina
            elseif nCODProduto == 7215
               cProduto := "ABACATE"

               nPrecoUnitario  := nPrecoAbacate
               nDescontoMaximo := nDescMaxAbacate
               nEstoque        := nEstoqueAbacate
            else
               // Codigo invalido: exibe alerta e limpa a linha
               Alert("CODIGO INVALIDO", cCorAlerta)
               @ nLinhaGet,02 clear to nLinhaGet,78
               loop
            endif

            // Exibe o nome do produto identificado
            @ nLinhaGet,12 say cProduto 

            // Leitura da quantidade desejada
            @ nLinhaGet,22 get nQuantidadeProd picture "9999.99" valid nQuantidadeProd > 0
            read
          
            
            // Se pressionou ESC apos informar a quantidade
            if lastkey() == 27
               cMensagem  := 'O QUE DESEJA FAZER'
               nOpcao := Alert(cMensagem, {'SAIR' , 'FATURAR' , 'CONTINUAR'} , "G/W")
               if nOpcao == 1
                  EXIT
               elseif nOpcao == 3
                  loop
               elseif nOpcao == 2
                  @ 23,02 say "TOTAL:R$ " + Alltrim(Transform(nTotal, "@E 99,999.99")) 
                  Inkey(0)
                  nContadorPedido++
                  nLinhaGet    := 9
                  exit
               endif
            endif
            
            // Valida se a quantidade solicitada nao excede o estoque disponivel
            if nQuantidadeProd > nEstoque
               Alert("QUANTIDADE MAIOR QUE ESTOQUE ATUAL", cCorAlerta)
               @ nLinhaGet,02 clear to nLinhaGet,78
               loop
            endif
            
            // Exibe o preco unitario do produto
            @ nLinhaGet,35 say "R$ " + Alltrim(Transform(nPrecoUnitario, "@E 99.99"))
            
            
            // Leitura do percentual de desconto do item
            @ nLinhaGet,50 get nDesconto       picture "99.99"   valid nDesconto       > 0
            read
            
            // Se pressionou ESC apos informar o desconto
            if lastkey() == 27
               cMensagem  := 'O QUE DESEJA FAZER'
               nOpcao := Alert(cMensagem, {'SAIR' , 'FATURAR' , 'CONTINUAR'} , "G/W")
               if nOpcao == 1
                  EXIT
               elseif nOpcao == 3
                  loop
               elseif nOpcao == 2
                  @ 23,02 say "TOTAL:R$ " + Alltrim(Transform(nTotal, "@E 99,999.99")) 
                  nContadorPedido++
                  loop
               endif
            endif
            
            // Valida se o desconto nao ultrapassa o maximo permitido para o produto
            if nDesconto > nDescontoMaximo
               Alert("DESCONTO MAIOR QUE O PERMITIDO PARA O PRODUTO", cCorAlerta)
               @ nLinhaGet,02 clear to nLinhaGet,78
               loop
            endif
            
            // Calcula o subtotal do item e acumula no total do pedido
            nSubtotal := nPrecoUnitario * nQuantidadeProd
            nTotal    += nSubtotal
            
            // Verifica se o subtotal ou o total excede o limite de credito do cliente
            if nSubtotal > nLimite .OR. nTotal > nLimite
               Alert("LIMITE EXCEDIDO, ULTIMO PRODUTO NAO FOI REGISTRADO", cCorAlerta)
               @ nLinhaGet,02 clear to nLinhaGet,78
               loop
            endif
            
            // Exibe o subtotal do item e o total acumulado do pedido
            @ nLinhaGet,62 say "R$ " + Alltrim(Transform(nSubtotal, "@E 99,999.99"))
            @ 21,60 say "TOTAL: R$ " + Alltrim(Transform(nTotal, "@E 99,999.99"))
            

            // Avanca para a proxima linha e zera as variaveis do item atual
            nLinhaGet       += 2
            nCODProduto     := 0
            nDesconto       := 0
            nQuantidadeProd := 0
            
            // Atualiza o estoque da fruta vendida
            // Obs: as variaveis ja foram zeradas acima, entao esta logica nao funciona como esperado
            if nCODProduto == 1100
               nEstoqueJaca -= nQuantidadeProd
            elseif nCODProduto == 4544
               nEstoqueUva -= nQuantidadeProd
               Alert(nEstoqueUva)
            elseif nCODProduto == 3515
               nEstoqueTangerina -= nQuantidadeProd
            else
               nEstoqueAbacate -= nQuantidadeProd
            endif
         enddo
      enddo
   endif

   
   // Opcao 2: Sair do sistema
   if nOpcao == 2
      Alert("SAINDO...", cCorAlerta)
   endif
   
enddo

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
