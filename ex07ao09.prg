Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 11 Center

clear

do while .t.
   clear
   
   nOpcao             := 0
    
   @ 01,00 to 06,79

   @ 02,01 prompt "EXERCICIO 7" Message "FAZ A LEITURA DE 2 VALORES E RETORNA O RESULTADO DAS 4 OPERACOES BASICAS"
   @ 03,01 prompt "EXERCICIO 8" Message "MERCADO"
   @ 04,01 prompt "EXERCICIO 9" Message "LE 1 LETRA, 1 DATA, 1 NUMERO INTEIRO, 1 NUMERO COM CASAS DECIMAIS E 1 STRING"
   @ 05,01 prompt "SAIR"        Message "SAIR DO PROGRAMA"
    
   menu to nOpcao

   if nOpcao == 1
      do while .t.
         clear 
         Alert("EXERCICIO 7")
         
         nNum1      := 0
         nNum2      := 0
         nSoma      := 0
         nProduto   := 0
         nDivisao   := 0
         nSubtracao := 0

         @ 01,00 to 08,79
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
   
      if nOpcao == 2
         do while .t.
            clear
            
            nContProduto := 1
	         nLinha       := 05
   
            @ 01,01 to 04,79
            @ 04,01 to 18,79
            @ 18,01 to 24,79
            @ 04,01 to 06,79
            @ 04,01 to 18,11
            @ 04,11 to 18,35
            @ 04,35 to 18,52
            @ 04,52 to 18,60
            @ 04,60 to 18,79
            @ 04,01 to 06,79
            @ 06,01 to 08,79
            @ 08,01 to 10,79
            @ 10,01 to 12,79
            @ 12,01 to 14,79

            @ 02,43 say "DATA PEDIDO.:"
            @ 03,43 say "DATA ENTREGA:"
            @ 02,04 say "NOME..:"
            @ 03,04 say "LIMITE:"
            @ 05,04 say "ITEM"
            @ 05,21 say "PRODUTO"
            @ 05,40 say "QUANTIDADE"
            @ 05,54 say "VALOR"
            @ 05,63 say "SUB-TOTAL"
            @ 19,04 say "FORMA DE PAGAMENTO:"
            
            @ 02,13 get cNome        picture '@!'          valid !Empty(cNome)
            @ 03,12 get nLimite      picture '@E 9,999.99' valid nLimite > 0
            @ 02,57 get dDataPed                           valid !Empty(dDataPed) .AND. dDataPed == date()
            read

            if lastkey() == 27
               
               cMensagem  := 'DESEJA SAIR?'
               cCorAlerta := 'G/N'
               nOpcao     := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
               
               if nOpcao == 1
                  EXIT
               endif
               
               loop

            endif

            do while .t.
               
               nQuantidade  := 0
               nValorProd   := 0
               
               cProduto := Space(20)
               
               @ nLinha += 2,06 say AllTrim(Str(nContProduto++)) 
               
               @ nLinha,15 get cProduto    picture "@!"        valid !Empty(cProduto)
               @ nLinha,43 get nQuantidade picture '99.99'     valid nQuantidade > 0
               @ nLinha,53 get nValorProd  picture '@E 999.99' valid nValorProd  > 0
               read
               
               nSubTotal := nValorProd * nQuantidade
               nTotal    += nSubTotal
               
               if nTotal > nLimite
                  cCor := 'R/W'
               endif
                  
               @ nLinha,63 say AllTrim(Transform(nSubTotal , "@E 9,9999.99"))

               if nLinha > nLimiteLinha
                  InKey(0)
                  @ 06,01 clear to 18,79
                  nLinha := 05
               endif

               if lastkey() == 27
                  cMensagem := 'DESEJA?'
                  cCor   := 'G/N'
                  nOpcao := Alert(cMensagem, {'CONTINUAR' , 'ABANDONAR' , 'FATURAR'} , cCor)
                  
                  if     nOpcao == 1
                     loop
                  
                  elseif nOpcao == 2
                     EXIT
                  
                  elseif nOpcao == 3 .and. nTotal > 0
                     
                     @ 21,04 say "TOTAL.................: " + AllTrim(Transform(nTotal , "@E 9,999.99")) color (cCor)           
                     
                     @ 03,57 get dDataEntrega picture "99/99/9999" valid !Empty(dDataPed) .AND. dDataPed >= date()
                     @ 19,24 get cFormP       picture '@!'         valid cFormP $ "VP"
                     read
                     
                     if cFormP == 'P'
                        @ 19,33 say "QUANTIDADE DE PARCELAS:"
            
                        @ 19,57 get nParcelas picture '99' valid nParcelas > 0 .and. nParcelas <= 10
                        read	
                           
                        nValorP := nTotal / nParcelas
                              
                        if nParcelas > 0
                           @ 22,04 say "VALOR DA PARCELA......: " + AllTrim(Transform(nValorP , "@!E")) color (cCor)
                        endif
                     endif

                     if lastkey() == 27 
                        cMensagem := 'DESEJA?'
                        cCor   := 'G/N'
                        nOpcao := Alert(cMensagem, {'CONTINUAR' , 'ABANDONAR'} , cCor)
                        if nOpcao == 2
                           EXIT
                        endif
                     endif
                  InKey(0)
                  EXIT
                  endif
               InKey(0)
               endif	
            enddo
         enddo
   
      endif
   endif
   
enddo
InKey(0)
