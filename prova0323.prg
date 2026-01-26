Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

do while .t.
   
   nEmpregados    := 0
   nContador      := 0
   nTotalHomens   := 0
   nTotalMulheres := 0
   nHomens91anos  := 0
   
   nMulherespagamIRRF    := 0
   nTotalRemuAposentados := 0
   nMulheresantes2013    := 0
   nMulheresAposentadas  := 0
   nHomensAposentados    := 0

   @ 01,01 to 03,79

   @ 01,33 say "CONTROLE INSS"
   @ 02,02 say "EMPREGADOS A SEREM ANALISADOS:"
   @ 02,33 get nEmpregados valid nEmpregados > 0
   read

   if lastkey() == 27
         cMensagem := 'O QUE DESEJA FAZER'
         cCor   := 'W/R'
         nOpcao := Alert(cMensagem, {'CANCELAR' , 'RETORNAR'} , cCor)
         if nOpcao == 1
            EXIT
         endif
         loop
   endif

   do while nEmpregados > nContador
      
      cNomeColaborador := Space(30)
      cSexo            := Space(1)
      
      dDataNascimento  := CToD("")
      dDataAdmissao    := CTod("")
      dDataDemissao    := CToD("")
      
      nSalarioBase         := 0
      nLimiteIRRF          := 0
      nAdcNoturno          := 0
      nAdcInsalubridade    := 0
      nRemuneracaoFinal    := 0

      lAptoAposentadoria   := .f.

      @ 04,01 to 14,79

      @ 04,31 say "DADOS DO EMPREGADO" + AllTrim(Str(nContador + 1))
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
      @ 07,27 get dDataNascimento                          //valid dDataNascimento <  dData
      @ 08,27 get dDataAdmissao  
      @ 09,27 get dDataDemissao                            //valid dDataDemissao   <= dData
      @ 10,27 get nSalarioBase      picture '@E 99,999.99' valid nSalarioBase > 0
      @ 11,27 get nLimiteIRRF       picture '@E  9,999.99' valid nLimiteIRRF  > 0
      @ 12,27 get nAdcNoturno       picture "99"           valid !Empty(nAdcNoturno)
      @ 13,27 get nAdcInsalubridade picture "99"           valid !Empty(nAdcInsalubridade)
      read
      
      //calculos

      nIdade := (Date() - dDataNascimento) / 365.25

      nTempoContruibuicao := (dDataDemissao - dDataAdmissao) / 365.25
      
      if cSexo == "M"
         nTotalHomens++
      else
         nTotalMulheres++
      endif

      nRemuneracaoFinal := nSalarioBase
      nRemuneracaoFinal += nSalarioBase * (nAdcNoturno / 100)
      nRemuneracaoFinal += nSalarioBase * (nAdcInsalubridade / 100)

      if dDataAdmissao <= CToD("31/12/2012") .AND. dDataDemissao >= cTod("01/01/2009")
         nRemuneracaoFinal += nSalarioBase * 0.02
      endif

      if dDataAdmissao <= CToD("31/12/2018") .AND. dDataDemissao >=cTod("01/01/2015")
         nRemuneracaoFinal -= nSalarioBase * 0.05
      endif

      lPagaIRRF := .F.

      if nRemuneracaoFinal > nLimiteIRRF
         nRemuneracaoFinal -= nRemuneracaoFinal * 0.09
         lPagaIRRF := .T.
         if cSexo == "F"
            nMulherespagamIRRF++
         endif
      endif

      if cSexo == "M"
         if nTempoContruibuicao >= 30 .AND. nIdade >= 61
            lAptoAposentadoria    := .t.
            nHomensAposentados    ++
            nTotalRemuAposentados += nRemuneracaoFinal
            if nIdade > 91
               nHomens91anos++
            endif
         endif
      else
         if nTempoContruibuicao >= 20 .AND. nIdade >=58
            lAptoAposentadoria    := .t.
            nMulheresAposentadas  ++
            nTotalRemuAposentados += nRemuneracaoFinal
            if dDataAdmissao < cTod("01/01/2013")
               nMulheresantes2013++
            endif
         endif
      endif
      
      @ 15,02 say nTempoContruibuicao
      @ 16,02 say nIdade

      if lastkey() == 27
         cMensagem := 'PROCESSAR EMPREGADO N: ' + AllTrim(Str(nContador + 1))
         cCor   := 'W/R'
         nOpcao := Alert(cMensagem, {'CANCELAR' , 'RETORNAR' , 'PROCESSAR'} , cCor)
         if nOpcao == 1
            EXIT
         elseif nOpcao == 2
            Loop
         
         elseif nOpcao == 3 .OR. nContador == nEmpregados


      endif
      

      nContador++
      do while .t.
         if cSexo == M .AND. nTempoContruibuicao >= 30 .AND. nIdade > 61
            nAposentadoriaFinal := nSalarioBase
            nHomensAposentados++
            
            if dDataAdmissao < CToD(01)
               nAposentadoriaFinal += nSalarioBase * 0.02
            endif

            if dDataAdmissao >= CToD("01/01/")

         elseif cSexo == F .AND. nTempoContruibuicao >=20 .AND. nIdade > 58
            nMulheresAposentadas++
         endif
      enddo
   
   enddo



enddo

InKey(0)
