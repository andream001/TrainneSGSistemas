Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

do while .t.

   nEmpregados := 0
   nContador   := 0
   nTotHomens  := 0
   nTotMulheres:= 0
   nHomensAposentados   := 0
   nMulheresAposentadas := 0
   nHomens91anos        := 0
   nMulheresAntes2013   := 0
   nMulheresPagamIRRF   := 0
   nTotRemuAposentados  := 0

   @ 01,01 to 03,79
   @ 01,33 say "CONTROLE INSS"
   @ 02,02 say "EMPREGADOS A SEREM ANALISADOS:"
   @ 02,33 get nEmpregados picture "999" valid nEmpregados > 0
   read

   if lastkey() == 27
      cMensagem := 'O QUE DESEJA FAZER'
      nOpcao := Alert(cMensagem, {'CANCELAR' , 'RETORNAR'} )
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

   do while nEmpregados > nContador

      cNomeColaborador := Space(30)
      cSexo            := Space(1)
      dDataNascimento  := CToD("")
      dDataAdmissao    := CToD("")
      dDataDemissao    := CToD("")
      nSalarioBase     := 0
      nLimiteIRRF      := 0
      nAdcNoturno      := 0
      nAdcInsalubridade:= 0
      nRemuneracaoFinal:= 0

      @ 04,01 to 14,79 clear
      @ 04,31 say "DADOS DO EMPREGADO "+AllTrim(Str(nContador+1))
      @ 05,02 say "NOME COLABORADOR.......:"
      @ 06,02 say "SEXO...................:  [M]ASCULINO [F]EMININO"
      @ 07,02 say "DATA DE NASCIMENTO.....:"
      @ 08,02 say "DATA DE ADMISSAO.......:"
      @ 09,02 say "DATA DE DEMISSAO.......:"
      @ 10,02 say "SALARIO BASE...........:"
      @ 11,02 say "VALOR LIMITE IRRF......:"
      @ 12,02 say "ADICIONAL NOTURNO...(%):"
      @ 13,02 say "ADICIONAL INSALUBRIDADE:"

      @ 05,27 get cNomeColaborador  picture '@!' valid !Empty(cNomeColaborador)
      @ 06,27 get cSexo             picture '@!' valid cSexo $ 'MF'
      @ 07,27 get dDataNascimento
      @ 08,27 get dDataAdmissao
      @ 09,27 get dDataDemissao
      @ 10,27 get nSalarioBase      picture '@E 99,999.99' valid nSalarioBase > 0
      @ 11,27 get nLimiteIRRF       picture '@E 99,999.99' valid nLimiteIRRF > 0
      @ 12,27 get nAdcNoturno       picture "99"
      @ 13,27 get nAdcInsalubridade picture "99"
      read

      // PROCESSAMENTO
      nIdade := (Date() - dDataNascimento) / 365.25
      nTempoContribuicao := (dDataDemissao - dDataAdmissao) / 365.25

      if cSexo == "M"
         nTotHomens++
      else
         nTotMulheres++
      endif

      // 1º PASSO: REMUNERAÇÃO BASE + ADICIONAIS
      nRemuneracaoFinal := nSalarioBase
      nRemuneracaoFinal += nSalarioBase * (nAdcNoturno / 100)
      nRemuneracaoFinal += nSalarioBase * (nAdcInsalubridade / 100)

      // 2º PASSO: FATORES TEMPORAIS
      if dDataAdmissao <= CToD("31/12/2012") .and. dDataDemissao >= CToD("01/01/2009")
         nRemuneracaoFinal += nSalarioBase * 0.02
      endif
      if dDataAdmissao <= CToD("31/12/2018") .and. dDataDemissao >= CToD("01/01/2015")
         nRemuneracaoFinal -= nSalarioBase * 0.05
      endif

      // *** 3º PASSO: IRRF SOBRE REMUNERAÇÃO FINAL (CORRIGIDO) ***
      lPagaIRRF := .F.
      if nRemuneracaoFinal > nLimiteIRRF
         nRemuneracaoFinal -= nRemuneracaoFinal * 0.09  // 9% da REMUNERAÇÃO FINAL
         lPagaIRRF := .T.
         if cSexo == "F"
            nMulheresPagamIRRF++
         endif
      endif

      // APTO À APOSENTADORIA (após todos os cálculos)
      lAptoAposentar := .F.
      if cSexo == "M" 
         if nTempoContribuicao >= 30 .and. nIdade >= 61
            lAptoAposentar := .T.
            nHomensAposentados++
            nTotRemuAposentados += nRemuneracaoFinal
            if nIdade > 91
               nHomens91anos++
            endif
         endif
      else
         if nTempoContribuicao >= 20 .and. nIdade >= 58
            lAptoAposentar := .T.
            nMulheresAposentadas++
            nTotRemuAposentados += nRemuneracaoFinal
            if dDataAdmissao < CToD("01/01/2013")
               nMulheresAntes2013++
            endif
         endif
      endif

      // RESULTADO NA TELA
      @ 15,01 say "IDADE: "+Str(nIdade,8,1)+" ANOS"
      @ 15,40 say "TEMPO CONTRIB: "+Str(nTempoContribuicao,8,1)+" ANOS"
      @ 16,01 say "REMUNERACAO FINAL: "+Transform(nRemuneracaoFinal,"@E 99,999.99")
      @ 16,50 say iif(lPagaIRRF,"IRRF=9%","")
      
      if lAptoAposentar
         @ 17,10 say PadC("*** APTO A APOSENTAR ***",60,'*')
         @ 18,20 say "Homens: 61+30 | Mulheres: 58+20"
      else
         @ 17,20 say PadC("NAO APTO A APOSENTAR",38)
      endif

      Inkey(2)
      if lastkey() == 27
         cMensagem := "PROCESSADO "+AllTrim(Str(nContador+1))
         nOpcao := Alert(cMensagem, {'CONTINUAR' , 'SAIR (parcial)'} )
         if nOpcao == 2
            EXIT
         endif
      endif

      nContador++
   enddo

   // RESULTADOS FINAIS COM PERCENTUAIS
   @ 16,01 clear to 24,79
   @ 16,01 say PadC("RESULTADOS "+iif(nContador<nEmpregados,"PARCIAL","COMPLETO"),78)
   
   nPercHomensApos := iif(nTotHomens>0, (nHomensAposentados/nTotHomens)*100, 0)
   nPercMulheresApos := iif(nTotMulheres>0, (nMulheresAposentadas/nTotMulheres)*100, 0)
   
   @ 17,02 say "Homens: "+Str(nTotHomens)+" (Apos: "+Str(nHomensAposentados)+" = "+Str(nPercHomensApos,6,1)+"%)"
   @ 18,02 say "Mulheres: "+Str(nTotMulheres)+" (Apos: "+Str(nMulheresAposentadas)+" = "+Str(nPercMulheresApos,6,1)+"%)"
   @ 19,02 say "Tot. remun. aptos: "+Transform(nTotRemuAposentados,"@E 999,999.99")
   @ 20,02 say "Homens >91 anos: "+Str(nHomens91anos)
   @ 21,02 say "Mulheres adm. <2013: "+Str(nMulheresAntes2013)
   @ 22,02 say "Mulheres pagam IRRF: "+Str(nMulheresPagamIRRF)

   cMensagem := "NOVO PROCESSAMENTO?"
   nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} )
   if nOpcao == 2
      EXIT
   endif

enddo

Inkey(0)