//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 23 center

clear

nContadorPedido := 1

do while .t. 
   clear
   
   cCorAlerta := 'W/R'
   
   cSenha   := Space(30)
   cUsuario := Space(30)
   
   nEstoqueJaca      := 7100
   nEstoqueUva       := 448.50
   nEstoqueTangerina := 145
   nEstoqueAbacate   := 280
   
   @ 01,00 to 24,79
   
   @ 00,32 say "FRUTARIA DO ANDRE"
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
   
   if Alltrim(cSenha) != "SENHA1234" .OR. Alltrim(cUsuario) != "ANDREAM" 
      Alert("USUARIO OU SENHA INCORRETOS", cCorAlerta)
      loop
   endif

   @ 02,01 clear to 23,78
   @ 02,19 to 23,19

   nOpcao := 0

   @ 03,02 prompt "EFETUAR PEDIDOS" message "CRIA UM NOVO PEDIDO"
   @ 04,02 prompt "SAIR..........." Message "SAIR DO PROGRAMA"
      
   menu to nOpcao

   cProduto := ""
   cCliente := Space(20)
   
   dDataPedido := CToD("")

   nLimite := 0
   
   nPrecoJaca      := 3.50
   nPrecoUva       := 15
   nPrecoTangerina := 21.90
   nPrecoAbacate   := 15.49

   nCODProduto   := 0
   nCODJaca      := 1100
   nCODUva       := 4544
   nCODTangerina := 3515
   nCodAbacate   := 7215

   nDescMaxJaca      := 12
   nDescMasUva       := 11
   nDescMaxTangerina := 10
   nDescMaxAbacate   := 3

   nQuantidadeProd := 0
   nPrecoUnitario  := 0
   nSubtotal       := 0
   nDesconto       := 0
   nTotal          := 0
   nDescontoMaximo := 0
   nEstoque        := 0

   nLimiteLinha := 20
   nLinhaGet    := 9

   if nOpcao == 1
      do while .T.
         clear
         
         @ 00,32 say "FRUTARIA DO ANDRE"

         @ 01,00 to 06,79
         @ 01,00 to 24,79

         @ 02,02 say "NUMERO DO PEDIDO.: " + Alltrim(Transform(nContadorPedido , "9"))
         @ 03,02 say "NOME CLIENTE.....: "
         @ 04,02 say "LIMITE DE CREDITO:R$ "
         @ 05,02 say "DATA DO PEDIDO...: "

         @ 03,22 get cCliente picture "@!"            valid !Empty(cCliente)
         @ 04,22 get nLimite  picture "@E 99,9999.99" valid nLimite > 0
         @ 05,22 get dDataPedido                      valid !Empty(dDataPedido) .AND. dDataPedido >= Date()
         read

         if lastkey() == 27
            cMensagem  := 'DESEJA SAIR?'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
            if nOpcao == 1
               EXIT
            endif
            loop
         endif
         
         do while .T.
            
            @ 07,02 say "CODIGO" + Space(3) + "PRODUTO" + Space(3) + "QUANTIDADE" + Space(3) + "UNIT.(R$)" + Space(3) + "DESCONTO(%)" + Space(5) + "SUB-TOTAL(R$)"
            @ 03,44 say "UVA   JACA  TANGERINA  ABACATE"
            @ 04,44 say "4544  1100     3515      7515"

            @ 02,43 to 05,75 
            @ 08,01 to 08,78
            @ 20,01 to 20,78

            if nLinhaGet >= nLimiteLinha
               @ 10,01 clear to 19,78
               nLinhaGet    := 9
            endif

            @ nLinhaGet,03 get nCODProduto picture "9999" valid !Empty(nCODProduto)
            read
            
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
                  exit
               endif
            endif
            
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
               Alert("CODIGO INVALIDO", cCorAlerta)
               @ nLinhaGet,02 clear to nLinhaGet,78
               loop
            endif

            @ nLinhaGet,12 say cProduto 

            @ nLinhaGet,22 get nQuantidadeProd picture "9999.99" valid nQuantidadeProd > 0
            read
         
            
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
            
            if nQuantidadeProd > nEstoque
               Alert("QUANTIDADE MAIOR QUE ESTOQUE ATUAL", cCorAlerta)
               @ nLinhaGet,02 clear to nLinhaGet,78
               loop
            endif
            
            @ nLinhaGet,35 say "R$ " + Alltrim(Transform(nPrecoUnitario, "@E 99.99"))
            
            
            @ nLinhaGet,50 get nDesconto       picture "99.99"   valid nDesconto       > 0
            read
            
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
            
            if nDesconto > nDescontoMaximo
               Alert("DESCONTO MAIOR QUE O PERMITIDO PARA O PRODUTO", cCorAlerta)
               @ nLinhaGet,02 clear to nLinhaGet,78
               loop
            endif
            
            nSubtotal := nPrecoUnitario * nQuantidadeProd
            nTotal    += nSubtotal
            
            if nSubtotal > nLimite .OR. nTotal > nLimite
               Alert("LIMITE EXCEDIDO, ULTIMO PRODUTO NAO FOI REGISTRADO", cCorAlerta)
               @ nLinhaGet,02 clear to nLinhaGet,78
               loop
            endif
            
            @ nLinhaGet,62 say "R$ " + Alltrim(Transform(nSubtotal, "@E 99,999.99"))
            @ 21,60 say "TOTAL: R$ " + Alltrim(Transform(nTotal, "@E 99,999.99"))
            

            nLinhaGet       += 2
            nCODProduto     := 0
            nDesconto       := 0
            nQuantidadeProd := 0
            
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

   
   if nOpcao == 2
      Alert("SAINDO...", cCorAlerta)
   endif
   
enddo

InKey(0)
