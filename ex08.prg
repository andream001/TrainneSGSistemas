Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

dDataPed     := date()
dDataEntrega := cTod(" ")

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

do while .t.
	
	cls
	nContProduto := 1
	nLinha       := 05
    	
	@ 02,43 say "DATA PEDIDO.:"
	@ 03,43 say "DATA ENTREGA:"
	@ 02,04 say "NOME:"
	@ 03,04 say "LIMITE:"
	@ 05,07 say "ITEM"
	@ 05,21 say "PRODUTO"
	@ 05,40 say "QUANTIDADE"
	@ 05,54 say "VALOR"
	@ 05,63 say "SUB-TOTAL"
	@ 19,04 say "FORMA DE PAGAMENTO:"
	
	@ 02,10 get cNome        picture '@!'          valid !Empty(cNome)
	@ 03,12 get nLimite      picture '@E 9,999.99' valid nLimite > 0
	@ 02,57 get dDataPed                           valid !Empty(dDataPed) .AND. dDataPed == date()
	read

	if lastkey() == 27
		cMensagem := 'DESEJA SAIR?'
		cCor   := 'G/N'
		nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
		if nOpcao == 1
			EXIT
		endif
		loop
	endif

	do while .t.
		
		nQuantidade  := 0
		nValorProd   := 0
		
		cProduto := Space(30)
		
		@ nLinha += 2,08 say AllTrim(Str(nContProduto++)) 
		
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
		endif	
	enddo
enddo
InKey(0)




