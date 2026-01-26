//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940

clear

do while .t.
   SetColor('W/N')
   cls

   cVendedor    := Space(30)
   cNomeCliente := Space(30)
   cSexo        := Space(1)
   cFumante     := Space(1)
   cTipodePlano := Space(1)
   cAbrangencia := Space(1)
   cCorCuidar   := 'G/N'
   cCorVital    := 'G/N'

   nValorBaseVital   := 350
   nValorBaseCuidar  := 400
   nValorFinalVital  := nValorBaseVital
   nValorFinalCuidar := nValorBaseCuidar
   nIdade            := 0
   nPeso             := 0
   nAltura           := 0

   dDataCotacao := date()
   dValidade    := date()
   
   @ 01,01 to 03,79

   @ 01,26 say "COTACAO DE PLANO DE SAUDE"
   @ 02,02 say "VENDEDOR:"
   @ 02,50 say "DATA DA COTACAO:"

   @ 02,12 get cVendedor picture "@!" valid !Empty(cVendedor)
   @ 02,67 get dDataCotacao           valid dDataCotacao >= date()
   read
   
   if lastkey() == 27
      cMensagem := 'DESEJA SAIR?'
      cCor   := 'W/R'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      if nOpcao == 1
         EXIT
      endif
   endif
   
   nMes := Month(dDataCotacao)
   
   if nMes == 6
      nValorFinalCuidar -= nValorBaseCuidar * 0.15
   endif

   if nMes == 11
      nValorFinalVital -= nValorBaseVital * 0.20
   endif
   
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

   @ 05,16 get cNomeCliente picture "@!"        valid !Empty(cNomeCliente)
   @ 05,57 get nIdade       picture '999'       valid nIdade > 0 .AND. nIdade < 150
   @ 06,16 get cSexo        picture '@!'        valid !Empty(cSexo) .AND. cSexo $ 'MF'
   @ 07,16 get nPeso        picture "@E 999.99" valid nPeso > 0.AND. nPeso < 500
   @ 08,16 get nAltura      picture "@E 9.99"   valid nAltura > 0 .AND. nAltura < 3
   @ 09,16 get cFumante     picture '@!'        valid !Empty(cFumante) .AND. cFumante $ 'SN'
   read
   
   @ 11,01 to 14,79
   @ 11,33 say "DADOS DO PLANO"
   @ 12,02 say "TIPO DE PLANO...:" + "   " + "[E]NFERMARIA [A]PARTAMENTO [V]IP"
   @ 13,02 say "ABRANGENCIA.....:" + "   " + "[R]EGIONAL [N]ACIONAL"


   @ 12,20 get cTipodePlano picture "@!" valid !Empty(cTipodePlano) .AND. cTipodePlano $ 'EAV'
   @ 13,20 get cAbrangencia PICTURE "@!" valid !Empty(cAbrangencia) .AND. cAbrangencia $ 'RN'
   read

   if lastkey() == 27
      cMensagem := 'ABANDONAR COTACAO'
      cCor   := 'W/R'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      if nOpcao == 1
         EXIT
      endif
   endif

   @ 15,01 to 17,79

   InKey(1)
   @ 16,02 say "XXXXXXXXX"
   InKey(1)
   @ 16,10 say "XXXXXXXXX"
   InKey(1)
   @ 16,18 say "XXXXXXXXX"   
   InKey(1)
   @ 16,27 say "XXXXXXXXX"
   InKey(1)
   @ 16,35 say "XXXXXXXXX"
   InKey(1)
   @ 16,43 say "XXXXXXXXX"
   InKey(1)
   @ 16,51 say "XXXXXXXXX"
   InKey(1)
   @ 16,60 say "XXXXXXXXX"
   InKey(1)
   @ 16,69 say "XXXXXXXXXX"
   InKey(1)

   @ 15,01 clear to 17,79

   if nIdade < 35 
      nValorFinalCuidar -= nValorBaseCuidar * 0.15
   endif

   if nIdade > 55
      nValorFinalCuidar += nValorBaseCuidar * 0.25
   endif

   if nIdade < 28
      nValorFinalVital -= nValorBaseVital * 0.20
   endif   

   if nIdade > 62
      nValorFinalVital += nValorBaseVital * 0.30
   endif

   if cSexo == 'M'
      nValorFinalCuidar += nValorBaseCuidar * 0.10
      nValorFinalVital  -= nValorBaseVital  * 0.10
   else
      nValorFinalCuidar -= nValorBaseCuidar * 0.10
      nValorFinalVital  += nValorBaseVital  * 0.15
   endif
   
   nImc              := nPeso / (nAltura * nAltura) 

   if nImc > 28
      nValorFinalCuidar += nValorBaseCuidar * 0.20
      nValorFinalVital  += nValorBaseVital  * 0.15
   elseif nImc > 26
      nValorFinalVital  += nValorBaseVital * 0.15   
   endif

   if cFumante == 'S'
      nValorFinalCuidar += nValorBaseCuidar * 0.30
      nValorFinalVital  += nValorBaseVital  * 0.35
   endif


   if cTipodePlano == 'A'
      nValorFinalCuidar += nValorBaseCuidar * 0.35
      nValorFinalVital  += nValorBaseVital  * 0.30
   elseif cTipodePlano == 'V'
      nValorFinalCuidar += nValorBaseCuidar * 0.60
      nValorFinalVital  += nValorBaseVital  * 0.50
   endif

   if cAbrangencia == 'N'
      nValorFinalCuidar += nValorBaseCuidar * 0.20
      nValorFinalVital  += nValorBaseVital  * 0.15
   endif

   if nValorFinalVital > nValorFinalCuidar
      cCorVital := 'W/R'
   else
      cCorCuidar := "W/R"
   endif

   @ 16,01 to 24,38 
   @ 16,39 to 24,80 

   @ 17,02 say "CUIDAR"
   @ 19,02 say "MENSAL.....:" + AllTrim(TRANSFORM(nValorFinalCuidar, '@E 9,999.99'))       color(cCorCuidar)
   @ 20,02 say "TRIMESTRAL.:" + AllTrim(TRANSFORM(nValorFinalCuidar * 3 , '@E 9,999.99'))  color(cCorCuidar)
   @ 21,02 say "ANUAL......:" + AllTrim(TRANSFORM(nValorFinalCuidar * 12, '@E 99,999.99')) color(cCorCuidar)

   @ 17,40 say "VITAL"
   @ 19,40 say "MENSAL.....:" + AllTrim(TRANSFORM(nValorFinalVital, '@E 9,999.99'))       color(cCorVital)
   @ 20,40 say "TRIMESTRAL.:" + AllTrim(TRANSFORM(nValorFinalVital * 3 , '@E 9,999.99'))  color(cCorVital)
   @ 21,40 say "ANUAL......:" + AllTrim(TRANSFORM(nValorFinalVital * 12, '@E 99,999.99')) color(cCorVital)
   
   nAno      := Year(dDataCotacao)
   dFinalCot := Month(dDataCotacao) - 1
   
   @ 15,27 say "OFERTA VALIDA ATE:" + dDia

   InKey(0)
enddo   

   

InKey(0)
