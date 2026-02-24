// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa as variaveis de data, nome, forma de pagamento e valores
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

// Loop principal: permite realizar multiplas compras no mercado
do while .t.
	clear

	nContProduto := 1
	nLinha       := 05
   
	@ 01,01 to 04,79
	
	// Exibe o cabecalho do pedido
	@ 02,04 say "NOME..:"
	@ 03,04 say "LIMITE:"
	@ 03,43 say "DATA ENTREGA:"
	@ 02,43 say "DATA PEDIDO.:"
	
	// Leitura dos dados do cliente e validacao da data do pedido
	@ 02,13 get cNome        picture '@!'          valid !Empty(cNome)
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
		loop
	endif
	
	do while .t.
		@ 04,01 to 18,79
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
		
		nQuantidade  := 0
		nValorProd   := 0
		
		cProduto := Space(20)
		
		@ nLinha += 2,06 say AllTrim(Str(nContProduto++)) 
		
		// Exibe o cabecalho da tabela de produtos
		@ 05,04 say "ITEM"
		@ 05,21 say "PRODUTO"
		@ 05,40 say "QUANTIDADE"
		@ 05,54 say "VALOR"
		@ 05,63 say "SUB-TOTAL"
		
		// Leitura dos dados de cada produto do carrinho
		@ nLinha,15 get cProduto    picture "@!"        valid !Empty(cProduto)
		@ nLinha,43 get nQuantidade picture '99.99'     valid nQuantidade > 0
		@ nLinha,53 get nValorProd  picture '@E 999.99' valid nValorProd  > 0
		read
		
		// Calcula o subtotal e acumula no total geral
		nSubTotal := nValorProd * nQuantidade
		nTotal    += nSubTotal
		
		
		@ nLinha,63 say AllTrim(Transform(nSubTotal , "@E 9,9999.99"))
		
		// Se a lista esta cheia, aguarda tecla e limpa para novos itens
		if nLinha > nLimiteLinha
			InKey(0)
			@ 07,01 clear to 18,79
			nLinha := 06
		endif
		
		if lastkey() == 27
			cMensagem  := 'DESEJA?'
			cCorAlerta := 'W/R'
			
			// Opcoes ao pressionar ESC: continuar comprando, abandonar ou faturar
			nOpcao := Alert(cMensagem, {'CONTINUAR' , 'ABANDONAR' , 'FATURAR'} , cCorAlerta)
			
			if     nOpcao == 1
				loop
			elseif nOpcao == 2
				EXIT
			elseif Opcao == 3 .and. nTotal > 0
				@ 18,01 to 24,79
				
				// Se o total exceder o limite, destaca em vermelho
				if nTotal > nLimite
					cCor := 'R/W'
				endif
				
				// Exibe o formulario de faturamento
				@ 20,04 say "FORMA DE PAGAMENTO:"
				@ 21,04 say "TOTAL.................: " + AllTrim(Transform(nTotal , "@E 9,999.99")) color (cCor)           
				
				@ 03,57 get dDataEntrega picture "99/99/9999" valid !Empty(dDataPed) .AND. dDataPed >= date()
				@ 20,24 get cFormP       picture '@!'         valid cFormP $ "VP"
				read
				
				// Se pagamento parcelado, calcula o valor de cada parcela
				if cFormP == 'P'
					@ 20,33 say "QUANTIDADE DE PARCELAS:"
	
					@ 20,57 get nParcelas picture '99' valid nParcelas > 0 .and. nParcelas <= 10
					read	
						
					nValorP := nTotal / nParcelas
							
					if nParcelas > 0
						@ 22,04 say "VALOR DA PARCELA......: " + AllTrim(Transform(nValorP , "@!E")) color (cCor)
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
			endif
		endif	
	enddo
enddo
InKey(0)




