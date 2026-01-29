//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

do while .t.

   nEmpregados  := 0
   nContador    := 0
   nTotHomens   := 0
   nTotMulheres := 0

   nHomensAposentados   := 0
   nMulheresAposentadas := 0
   nHomens91anos        := 0
   nMulheresAntes2013   := 0
   nMulheresPagamIRRF   := 0
   nTotRemuAposentados  := 0

   @ 01,00 to 03,79

   @ 01,33 say "CONTROLE INSS"
   @ 02,02 say "EMPREGADOS A SEREM ANALISADOS:"
   
   @ 02,33 get nEmpregados picture "999" valid nEmpregados > 0
   read

   if lastkey() == 27
      cMensagem := 'O QUE DESEJA FAZER'
      nOpcao := Alert(cMensagem, {'CANCELAR' , 'CONTINUAR'} )
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

   do while nEmpregados > nContador

      cNomeColaborador  := Space(30)
      cSexo             := Space(1)
      
      dDataNascimento   := CToD("")
      dDataAdmissao     := CToD("")
      dDataDemissao     := CToD("")
      
      nSalarioBase      := 0
      nLimiteIRRF       := 0
      nAdcNoturno       := 0
      nAdcInsalubridade := 0
      nRemuneracaoFinal := nSalarioBase

      @ 04,00 to 14,79 

      @ 04,31 say "DADOS DO EMPREGADO " + "N:" + AllTrim(Str(nContador+1))
      @ 05,02 say "NOME COLABORADOR.......:"
      @ 06,02 say "SEXO...................:  [M]ASCULINO [F]EMININO"
      @ 07,02 say "DATA DE NASCIMENTO.....:"
      @ 08,02 say "DATA DE ADMISSAO.......:"
      @ 09,02 say "DATA DE DEMISSAO.......:"
      @ 10,02 say "SALARIO BASE...........:"
      @ 11,02 say "VALOR LIMITE IRRF......:"
      @ 12,02 say "ADICIONAL NOTURNO...(%):"
      @ 13,02 say "ADICIONAL INSALUBRIDADE:"

      @ 05,27 get cNomeColaborador  picture '@!'           valid !Empty(cNomeColaborador)
      @ 06,27 get cSexo             picture '@!'           valid cSexo $ 'MF'
      @ 07,27 get dDataNascimento                          valid !Empty(dDataNascimento) .AND. dDataNascimento < date()
      @ 08,27 get dDataAdmissao                            valid !Empty(dDataAdmissao)   .AND. dDataAdmissao   > dDataNascimento
      @ 09,27 get dDataDemissao                            valid !Empty(dDataDemissao)   .AND. dDataDemissao   > dDataAdmissao

      @ 10,27 get nSalarioBase      picture '@E 99,999.99' valid nSalarioBase > 0
      @ 11,27 get nLimiteIRRF       picture '@E 99,999.99' valid nLimiteIRRF  >= 0
      @ 12,27 get nAdcNoturno       picture "99"           valid nAdcNoturno  >= 0
      @ 13,27 get nAdcInsalubridade picture "99"           valid nAdcInsalubridade >= 0
      read

      Inkey(0)

      if lastkey() == 27
         cMensagem := 'O QUE DESEJA FAZER?'
         cCor   := 'W/R'
         nOpcao := Alert(cMensagem, {'CANCELAR' , 'RETORNAR' , 'PROCESSAR'} , cCor)
         if nOpcao == 1
            EXIT
         elseif nOpcao == 2   
            loop
         endif
      endif
      
      nIdade             := Int((Date() - dDataNascimento) / 365.25)
      nTempoContribuicao := (dDataDemissao - dDataAdmissao) / 365.25
      
      Alert(AllTrim(str(nIdade)))

      if cSexo == "M"
         nTotHomens++
      else
         nTotMulheres++
      endif
      
      nRemuneracaoFinal += nSalarioBase * (nAdcNoturno / 100)
      nRemuneracaoFinal += nSalarioBase * (nAdcInsalubridade / 100)
      
      if dDataAdmissao <= CToD("31/12/2012") .and. dDataDemissao >= CToD("01/01/2009")
         nRemuneracaoFinal += nSalarioBase * 0.02
      endif
      
      if dDataAdmissao <= CToD("31/12/2018") .and. dDataDemissao >= CToD("01/01/2015")
         nRemuneracaoFinal -= nSalarioBase * 0.05
      endif
      
      lPagaIRRF      := .F.
      lAptoAposentar := .F.
      
      if nRemuneracaoFinal > nLimiteIRRF
         nRemuneracaoFinal -= nRemuneracaoFinal * 0.09
         lPagaIRRF := .T.
         if cSexo == "F"
            nMulheresPagamIRRF++
         endif
      endif
      
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
      
      if lAptoAposentar .AND. cSexo == "M"
         nHomensAposentados++
      elseif lAptoAposentar .AND. cSexo == "F"
         nMulheresAposentadas++
      endif
      
      Inkey(2)

      @ 16,01 clear to 24,79
      @ 15,00 to 22,79
      
      @ 15,32 say "RESULTADOS: "
      
      if nContador < nEmpregados
         @ 15,44 say "PARCIAL"
      else
         @ 15,44 say "COMPLETO"
      endif
      
      nPercHomensApos   := 0
      nPercMulheresApos := 0

      if nTotHomens > 0
         nPercHomensApos := (nHomensAposentados/nTotHomens) * 100
      endif
      
      if nTotMulheres > 0
         nPercMulheresApos := (nMulheresAposentadas/nTotMulheres) * 100
      endif

      @ 16,02 say "HOMENS PROCESSADOS..............: " + AllTrim(Str(nTotHomens))
      @ 16,42 say "APOSENTADOS: " + AllTrim(Str(nHomensAposentados)) + " = " + AllTrim(Str(nPercHomensApos,6,1)) + "%"
      @ 17,02 say "MULHERES PROCESSADAS............: " + AllTrim(Str(nTotMulheres))
      @ 17,42 say "APOSENTADAS: " + AllTrim(Str(nMulheresAposentadas)) + " = " + AllTrim(Str(nPercMulheresApos,6,1)) + "%" 
      @ 18,02 say "REMUNERACAO TOTAL(APOSENTADOS)..: R$ " + AllTrim(Transform(nTotRemuAposentados,"@E 999,999.99"))
      @ 19,02 say "HOMENS > 91 ANOS................: " + AllTrim(Str(nHomens91anos))
      @ 20,02 say "MULHERES ADMITIDAS ANTES DE 2013: " + AllTrim(Str(nMulheresAntes2013))
      @ 21,02 say "MULHERES QUE PAGAM IRRF(%)......: " + AllTrim(Str((nMulheresPagamIRRF / nTotMulheres) * 100)) + "%"

      Inkey(0)

      cMensagem := "NOVO PROCESSAMENTO?"
      nOpcao    := Alert(cMensagem, {'SIM' , 'NAO'} )
      
      if nOpcao == 2
         EXIT
      endif
      Inkey(0)
   enddo
enddo

Inkey(0)