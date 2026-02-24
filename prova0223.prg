//ANDRE LUIZ BUNHAK

// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940

// Limpa a tela
clear

// Loop principal: permite realizar multiplas cotacoes
do while .t.
   // Define a cor padrao e inicializa as variaveis a cada nova cotacao
   SetColor('W/N')
   cls

   cVendedor    := Space(30)
   cNomeCliente := Space(30)
   cSexo        := Space(1)
   cFumante     := Space(1)
   cTipodePlano := Space(1)
   cAbrangencia := Space(1)
   cCorCuidar   := 'G/N'  // cor inicial para o plano Cuidar (verde = melhor preco)
   cCorVital    := 'G/N'  // cor inicial para o plano Vital

   // Valores base de cada plano antes dos ajustes
   nValorBaseVital  := 350
   nValorBaseCuidar := 400
   nDescontoVital   := 0   // acumulador de percentuais de ajuste do plano Vital
   nDescontoCuidar  := 0   // acumulador de percentuais de ajuste do plano Cuidar
   nIdade           := 0
   nPeso            := 0
   nAltura          := 0

   dDataCotacao := date()
   dValidade    := date()
   
   // Exibe o cabecalho da cotacao e solicita os dados do vendedor
   @ 01,01 to 03,79

   @ 01,26 say "COTACAO DE PLANO DE SAUDE"
   @ 02,02 say "VENDEDOR:"
   @ 02,50 say "DATA DA COTACAO:"

   // Leitura do nome do vendedor e da data da cotacao (deve ser hoje ou futura)
   @ 02,12 get cVendedor    picture "@!" valid !Empty(cVendedor)
   @ 02,67 get dDataCotacao              valid dDataCotacao >= date()
   read
   
   // Se o usuario pressionou ESC, pergunta se deseja sair
   if lastkey() == 27
      cMensagem := 'DESEJA SAIR?'
      cCor   := 'W/R'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      if nOpcao == 1
         EXIT
      endif
   endif
   
   nMes := Month(dDataCotacao)
   
   // Desconto especial em junho (-15%) e novembro (-20%) para o plano Cuidar
   if nMes == 6
      nDescontoCuidar -= 0.15
   endif

   if nMes == 11
      nDescontoCuidar -= 0.20
   endif
   
   // Exibe a secao de dados pessoais do cliente
   @ 04,01 to 10,79

   @ 04,30 say "DADOS PESSOAIS"
   @ 05,50 say "IDADE:"
   @ 05,02 say "NOME........:"
   @ 06,02 say "SEXO........:"
   @ 06,20 say "[M]ASCULINO [F]EMININO"
   @ 07,02 say "PESO (KG)...:" 
   @ 08,02 say "ALTURA (M)..:"
   @ 09,02 say "FUMANTE?....:"
   @ 09,20 say "[S]IM [N]AO"

   // Leitura dos dados pessoais do cliente com validacoes
   @ 05,16 get cNomeCliente picture "@!"        valid !Empty(cNomeCliente)
   @ 05,57 get nIdade       picture '999'       valid nIdade > 0 .AND. nIdade < 150
   @ 06,16 get cSexo        picture '@!'        valid !Empty(cSexo) .AND. cSexo $ 'MF'
   @ 07,16 get nPeso        picture "@E 999.99" valid nPeso > 0.AND. nPeso < 500
   @ 08,16 get nAltura      picture "@E 9.99"   valid nAltura > 0 .AND. nAltura < 3
   @ 09,16 get cFumante     picture '@!'        valid !Empty(cFumante) .AND. cFumante $ 'SN'
   read
   
   // Exibe a secao de dados do plano escolhido
   @ 11,01 to 14,79
   @ 11,33 say "DADOS DO PLANO"
   @ 12,02 say "TIPO DE PLANO...:" + "   " + "[E]NFERMARIA [A]PARTAMENTO [V]IP"
   @ 13,02 say "ABRANGENCIA.....:" + "   " + "[R]EGIONAL [N]ACIONAL"


   // Leitura do tipo de plano (E/A/V) e da abrangencia (R/N)
   @ 12,20 get cTipodePlano picture "@!" valid !Empty(cTipodePlano) .AND. cTipodePlano $ 'EAV'
   @ 13,20 get cAbrangencia PICTURE "@!" valid !Empty(cAbrangencia) .AND. cAbrangencia $ 'RN'
   read

   // Se o usuario pressionou ESC apos preencher o plano, pergunta se deseja abandonar a cotacao
   if lastkey() == 27
      cMensagem := 'ABANDONAR COTACAO'
      cCor   := 'W/R'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      if nOpcao == 1
         EXIT
      endif
   endif

   // Exibe uma barra de carregamento animada enquanto processa os calculos
   @ 15,01 to 17,79

   nCont          := 0
   nBarraCarregar := 2
   
   do while nCont < 11
      @ 16,nBarraCarregar  say "XXXXXXX"
      nBarraCarregar += 7
      nCont++
      InKey(1)
   enddo 

   @ 15,01 clear to 17,79

   // Aplica ajustes de preco com base na idade do cliente
   if nIdade < 35 
      nDescontoCuidar -= 0.15    // jovens tem desconto no Cuidar
   endif

   if nIdade > 55
      nDescontoCuidar += 0.25    // idosos pagam mais no Cuidar
   endif

   if nIdade < 28
      nDescontoVital -= 0.20     // jovens tem desconto no Vital
   endif   

   if nIdade > 62
      nDescontoVital += 0.30     // idosos pagam mais no Vital
   endif

   // Aplica ajustes com base no sexo do cliente
   if cSexo == 'M'
      nDescontoCuidar += 0.10    // homens pagam mais no Cuidar
      nDescontoVital  -= 0.10    // homens tem desconto no Vital
   else
      nDescontoCuidar -= 0.10    // mulheres tem desconto no Cuidar
      nDescontoVital  += 0.15    // mulheres pagam mais no Vital
   endif
   
   // Calcula o IMC para ajuste de risco
   nImc := nPeso / (nAltura * nAltura) 

   // Aplica ajustes com base no IMC (sobrepeso aumenta o custo)
   if nImc > 28
      nDescontoCuidar += 0.20
      nDescontoVital  += 0.15
   elseif nImc > 26
      nDescontoVital += 0.15   
   endif

   // Fumantes pagam mais em ambos os planos
   if cFumante == 'S'
      nDescontoCuidar += 0.30
      nDescontoVital  += 0.35
   endif

   // Aplica ajustes com base no tipo de acomodacao escolhida
   if cTipodePlano == 'A'
      nDescontoCuidar += 0.35    // apartamento e mais caro
      nDescontoVital  += 0.30
   elseif cTipodePlano == 'V'
      nDescontoCuidar += 0.60    // VIP e ainda mais caro
      nDescontoVital  += 0.50
   endif

   // Plano nacional e mais caro que regional
   if cAbrangencia == 'N'
      nDescontoCuidar += 0.20
      nDescontoVital  += 0.15
   endif

   // Calcula os valores finais de cada plano aplicando os percentuais acumulados
   nValorFinalCuidar := nValorBaseCuidar * (nDescontoCuidar + 1)
   nValorFinalVital  := nValorBaseVital  * (nDescontoVital  + 1)

   // Destaca em vermelho o plano mais caro
   if nValorFinalVital > nValorFinalCuidar
      cCorVital := 'W/R'
   else
      cCorCuidar := "W/R"
   endif

   // Exibe os valores mensais, trimestrais e anuais de cada plano lado a lado
   @ 16,01 to 24,38 
   @ 16,39 to 24,79

   @ 17,02 say "CUIDAR"
   @ 19,02 say "MENSAL.....:" + AllTrim(TRANSFORM(nValorFinalCuidar,      '@E  9,999.99')) color(cCorCuidar)
   @ 20,02 say "TRIMESTRAL.:" + AllTrim(TRANSFORM(nValorFinalCuidar * 3 , '@E  9,999.99')) color(cCorCuidar)
   @ 21,02 say "ANUAL......:" + AllTrim(TRANSFORM(nValorFinalCuidar * 12, '@E 99,999.99')) color(cCorCuidar)

   @ 17,40 say "VITAL"
   @ 19,40 say "MENSAL.....:" + AllTrim(TRANSFORM(nValorFinalVital,      '@E  9,999.99')) color(cCorVital)
   @ 20,40 say "TRIMESTRAL.:" + AllTrim(TRANSFORM(nValorFinalVital * 3 , '@E  9,999.99')) color(cCorVital)
   @ 21,40 say "ANUAL......:" + AllTrim(TRANSFORM(nValorFinalVital * 12, '@E 99,999.99')) color(cCorVital)
   
   // Calcula a data de validade da cotacao (ate o ultimo dia do mes seguinte)
   nAno      := Year(dDataCotacao)
   nMes      := Month(dDataCotacao)

   if nMes == 12
      nMes := 01
      nAno += 1
   else
      nMes += 1
   endif

   dDiaFinal := CToD("01/" + AllTrim(Str(nMes)) + "/" + AllTrim(Str(nAno)))

   // Exibe a data limite de validade da oferta
   @ 15,27 say "OFERTA VALIDA ATE: " + AllTrim(Dtoc(dDiaFinal - 1))

   InKey(0)

enddo   

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
