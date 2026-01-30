Set date BRITISH
Set epoch to 1940
Set Message to 11 Center

do while .t.
   clear
   
   nOpcao := 0
   
   @ 01,00 to 06,79
   
   @ 01,38 say "MENU"
   
   @ 02,01 prompt "EXERCICIO 7" Message "FAZ A LEITURA DE 2 VALORES E RETORNA O RESULTADO DAS 4 OPERACOES BASICAS"
   @ 03,01 prompt "EXERCICIO 8" Message "MERCADO"
   @ 04,01 prompt "EXERCICIO 9" Message "LE 1 LETRA, 1 DATA, 1 NUMERO INTEIRO, 1 NUMERO COM CASAS DECIMAIS E 1 STRING"
   @ 05,01 prompt "SAIR"        Message "SAIR DO PROGRAMA"
    
   menu to nOpcao

   if nOpcao == 1
      Alert("EXERCICIO 7")
      do while .t.
         clear 
         
         nNum1      := 0
         nNum2      := 0
         nSoma      := 0
         nProduto   := 0
         nDivisao   := 0
         nSubtracao := 0

         @ 01,00 to 08,79
         
         @ 01,33 say "EXERCICIO 7"
         @ 02,01 say "PRIMEIRO NUMERO:"
         @ 03,01 say "SEGUNDO NUMERO.:"

         @ 02,18 get nNum1
         @ 03,18 get nNum2 valid nNum2 > 0
         read

         if lastkey() == 27
            cMensagem := 'DESEJA SAIR?'
            cCor   := 'W/R'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
            if nOpcao == 1
               EXIT
            endif
         endif
         
         nSoma      := nNum1 + nNum2
         nProduto   := nNum1 * nNum2
         nDivisao   := nNum1 / nNum2
         nSubtracao := nNum1 - nNum2

         @ 04,01 say "Soma.....:" + AllTrim(Str(nSoma))
         @ 05,01 say "Produto..:" + AllTrim(Str(nProduto))
         @ 06,01 say "Divisao..:" + AllTrim(Str(nDivisao))
         @ 07,01 say "Subtracao:" + AllTrim(Str(nSubtracao))
         
         InKey(0)
      
      enddo
   elseif nOpcao == 2
      Alert("EXERCICIO MERCADO")
      do while .t.         
         clear

         dDataPed     := date()
         dDataEntrega := cTod("")
   
         cCor     := 'G/W'
         cNome    := Space(30)
         cFormP   := Space(1)
   
         nColuna      := 15
         nParcelas    := 0
         nValorP      := 0
         nLimite      := 0
         nTotal       := 0
         nSubTotal    := 0
         nLimiteLinha := 15
         nContProduto := 1
         nLinha       := 06
         
         @ 01,01 to 04,79
         
         @ 01,33 say "MERCADO"
         @ 02,43 say "DATA PEDIDO.:"
         @ 03,43 say "DATA ENTREGA:"
         @ 02,04 say "NOME..:"
         @ 03,04 say "LIMITE:"
         
         @ 02,12 get cNome        picture '@!'          valid !Empty(cNome)
         @ 03,12 get nLimite      picture '@E 9,999.99' valid nLimite > 0
         @ 02,57 get dDataPed                           valid !Empty(dDataPed) .AND. dDataPed == date()
         read

         if lastkey() == 27
            cMensagem  := 'DESEJA SAIR?'
            cCorAlerta := 'W/R'
            nOpcao     := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
            if nOpcao == 1
               EXIT
            endif
         endif
         
         do while .t.
            nQuantidade  := 0
            nValorProd   := 0
            
            cProduto := Space(20)
            
            @ 05,01 to 18,11
            @ 05,11 to 18,37
            @ 05,37 to 18,52
            @ 05,52 to 18,60
            @ 05,60 to 18,79
            @ 05,01 to 18,79
            @ 05,01 to 07,79
            
            @ 06,04 say "ITEM"
            @ 06,22 say "PRODUTO"
            @ 06,40 say "QUANTIDADE"
            @ 06,54 say "VALOR"
            @ 06,63 say "SUB-TOTAL"
            
            @ nLinha += 2,06 say AllTrim(Str(nContProduto++)) 
            
            @ nLinha,15 get cProduto    picture "@!"        valid !Empty(cProduto)
            @ nLinha,43 get nQuantidade picture '99.99'     valid nQuantidade > 0
            @ nLinha,53 get nValorProd  picture '@E 999.99' valid nValorProd  > 0
            read
            
            nSubTotal := nValorProd * nQuantidade
            nTotal    += nSubTotal
            
            @ nLinha,63 say AllTrim(Transform(nSubTotal , "@E 9,9999.99"))
            
            if nLinha > nLimiteLinha
               InKey(0)
               @ 08,01 clear to 18,79
               nLinha := 06
            endif
            
            if lastkey() == 27
               cMensagem  := 'DESEJA?'
               cCorAlerta := 'G/N'
               
               nOpcao := Alert(cMensagem, {'CONTINUAR' , 'ABANDONAR' , 'FATURAR'} , cCorAlerta)
               
               if     nOpcao == 1
                  loop
               elseif nOpcao == 2
                  EXIT
               elseif nOpcao == 3 .and. nTotal > 0
                  @ 19,01 to 24,79
                  
                  if nTotal > nLimite
                     cCor := 'R/W'
                  endif
                  
                  @ 20,04 say "FORMA DE PAGAMENTO....:"
                  @ 22,04 say "TOTAL.................: R$ " + AllTrim(Transform(nTotal , "@E 9,999.99")) color (cCor)           
                  
                  @ 03,57 get dDataEntrega picture "99/99/9999" valid !Empty(dDataPed) .AND. dDataPed >= date()
                  @ 20,28 get cFormP       picture '@!'         valid cFormP $ "VP"
                  read
                  
                  InKey(0)
                  if cFormP == 'P'
                     @ 21,04 say "QUANTIDADE DE PARCELAS:"
                     
                     @ 21,27 get nParcelas picture '99' valid nParcelas > 0 .and. nParcelas <= 10
                     read	
                        
                     nValorP := nTotal / nParcelas
                           
                     if nParcelas > 0
                        @ 23,04 say "VALOR DA PARCELA......: R$ " + AllTrim(Transform(nValorP , "@!E")) color (cCor)
                        InKey(0)
                     endif
                  endif

                  if lastkey() == 27 
                     cMensagem  := 'DESEJA?'
                     cCorAlerta := 'W/R'

                     nOpcao := Alert(cMensagem, {'CONTINUAR' , 'ABANDONAR'} , cCorAlerta)
                     if nOpcao == 2
                        EXIT
                     endif
                  endif
               InKey(0)
               EXIT
               endif
            endif	
         enddo
      enddo
   elseif nOpcao == 3 
      Alert("EXERCICIO 9")
      do while .t.
         clear

         cLetra  := Space(1)
         cString := Space(30)
         
         dData := CToD("")

         nInteiro           := 0
         nNumerocomDecimais := 0

         @ 01,00 to 12,79

         @ 01,33 say "EXERCICIO 9"
         @ 02,01 say "LETRA.........:"
         @ 03,01 say "DATA..........:"
         @ 04,01 say "NUMERO INTEIRO:"
         @ 05,01 say "NUMERO DECIMAL:"
         @ 06,01 say "STRING........:"

         @ 02,17 get cLetra             picture "@!"     valid !Empty(cLetra)
         @ 03,17 get dData                               valid !Empty(dData)
         @ 04,17 get Int(nInteiro)      picture "999"    valid !Empty(nInteiro)
         @ 05,17 get nNumerocomDecimais picture "999.99" valid !Empty(nNumerocomDecimais)
         @ 06,17 get AllTrim(cString)   picture "@!"     valid !Empty(cString)
         read

         if lastkey() == 27
         cMensagem := 'DESEJA SAIR?'
         cCor   := 'R/W'
         nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
         if nOpcao == 1
            EXIT
         endif
         loop
         endif

         InKey(2)

         clear

         @ 02,01 say "LETRA.........: " + cLetra
         @ 03,01 say "DATA..........: " + DToC(dData)
         @ 04,01 say "NUMERO INTEIRO: " + AllTrim(Str(nInteiro)) 
         @ 05,01 say "NUMERO DECIMAL: " + AllTrim(Str(nNumerocomDecimais))
         @ 06,01 say "STRING........: " + cString
         
         InKey(0)
      enddo
   else
      Alert("SAINDO...")
      exit
   endif 
enddo

InKey(0)
