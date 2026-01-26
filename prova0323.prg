Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

do while .t.
   
   nEmpregados := 0
   nContador   := 0

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
   endif

   do while nEmpregados > nContador
      
      cNomeColaborador := Space(30)
      cSexo            := Space(1)
      
      dData            := Date()
      dDataNascimento  := CToD("")
      dDataAdmissao    := CTod("")
      dDataDemissao    := CToD("")
      
      nSalarioBase         := 0
      nLimiteIRRF          := 0
      nAdcNoturno          := 0
      nAdcInsalubridade    := 0
      nAposentadoriaFinal  := 0
      
      nMulheresAposentadas := 0
      nHomensAposentados   := 0

      @ 04,01 to 14,79

      @ 04,31 say "DADOS DO EMPREGADO"
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
      
      nIdade := (dData - dDataNascimento) / 365

      nTempoContruibuicao := (dDataDemissao - dDataAdmissao) / 365
      
      
      @ 15,02 say nTempoContruibuicao
      @ 16,02 say nIdade

      if lastkey() == 27
         cMensagem := 'PROCESSAR EMPREGADO N: ' + AllTrim(Str(nContador))
         cCor   := 'W/R'
         nOpcao := Alert(cMensagem, {'CANCELAR' , 'RETORNAR' , 'PROCESSAR'} , cCor)
         if nOpcao == 1
            EXIT
         elseif nOpcao == 3
            Loop
         endif
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
