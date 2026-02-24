//ANDRE LUIZ BUNHAK

// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
//Set epoch to 1940
// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Loop principal: permite processar multiplos lotes de empregados
do while .t.

   // Inicializa os contadores e totalizadores a cada novo lote
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

   // Exibe o cabecalho e solicita a quantidade de empregados a analisar
   @ 01,00 to 03,79

   @ 01,33 say "CONTROLE INSS"
   @ 02,02 say "EMPREGADOS A SEREM ANALISADOS:"
   
   @ 02,33 get nEmpregados picture "999" valid nEmpregados > 0
   read

   // Se pressionou ESC, pergunta se deseja cancelar ou continuar
   if lastkey() == 27
      cMensagem := 'O QUE DESEJA FAZER'
      nOpcao := Alert(cMensagem, {'CANCELAR' , 'CONTINUAR'} )
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

   // Loop para processar cada empregado do lote
   do while nEmpregados > nContador

      // Inicializa os dados de cada empregado
      cNomeColaborador  := Space(30)
      cSexo             := Space(1)
      
      dDataNascimento   := CToD("29/01/0568")   // data padrao invalida para forcar preenchimento
      dDataAdmissao     := CToD("")
      dDataDemissao     := CToD("")
      
      nSalarioBase      := 0
      nLimiteIRRF       := 0
      nAdcNoturno       := 0
      nAdcInsalubridade := 0
      nRemuneracaoFinal := nSalarioBase   // remuneracao começa igual ao salario base

      // Exibe o formulario de dados do empregado atual
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

      // Leitura dos dados do empregado (datas comentadas por problemas de validacao)
      @ 05,27 get cNomeColaborador  picture '@!'           valid !Empty(cNomeColaborador)
      @ 06,27 get cSexo             picture '@!'           valid cSexo $ 'MF'
     // @ 07,27 get dDataNascimento                         // valid !Empty(dDataNascimento) .AND. dDataNascimento < date()
     // @ 08,27 get dDataAdmissao                           // valid !Empty(dDataAdmissao)   .AND. dDataAdmissao   > dDataNascimento
     // @ 09,27 get dDataDemissao                           // valid !Empty(dDataDemissao)   .AND. dDataDemissao   > dDataAdmissao

      @ 10,27 get nSalarioBase      picture '@E 99,999.99' valid nSalarioBase > 0
      @ 11,27 get nLimiteIRRF       picture '@E 99,999.99' valid nLimiteIRRF  >= 0
      @ 12,27 get nAdcNoturno       picture "99"           valid nAdcNoturno  >= 0
      @ 13,27 get nAdcInsalubridade picture "99"           valid nAdcInsalubridade >= 0
      read

      Inkey(0)

      // Se pressionou ESC, permite cancelar, voltar ou processar o empregado
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
      
      // Calcula a idade e o tempo de contribuicao do empregado
      nIdade             := Int((Date() - dDataNascimento) / 365.25)
      nTempoContribuicao := (dDataDemissao - dDataAdmissao) / 365.25
      
      Alert(AllTrim(str(nIdade)))   // exibe a idade calculada para conferencia

      // Contabiliza o genero do empregado
      if cSexo == "M"
         nTotHomens++
      else
         nTotMulheres++
      endif
      
      // Calcula a remuneracao final com adicionais noturno e de insalubridade
      nRemuneracaoFinal += nSalarioBase * (nAdcNoturno / 100)
      nRemuneracaoFinal += nSalarioBase * (nAdcInsalubridade / 100)
      
      // Aplica bonificacao de 2% para admissoes no periodo 2009-2012
      if dDataAdmissao <= CToD("31/12/2012") .and. dDataDemissao >= CToD("01/01/2009")
         nRemuneracaoFinal += nSalarioBase * 0.02
      endif
      
      // Aplica reducao de 5% para admissoes no periodo 2015-2018
      if dDataAdmissao <= CToD("31/12/2018") .and. dDataDemissao >= CToD("01/01/2015")
         nRemuneracaoFinal -= nSalarioBase * 0.05
      endif
      
      lPagaIRRF      := .F.
      lAptoAposentar := .F.
      
      // Verifica se o empregado paga IRRF (remuneracao acima do limite)
      if nRemuneracaoFinal > nLimiteIRRF
         nRemuneracaoFinal -= nRemuneracaoFinal * 0.09   // desconta 9% de IRRF
         lPagaIRRF := .T.
         if cSexo == "F"
            nMulheresPagamIRRF++
         endif
      endif
      
      // Verifica se o empregado esta apto para se aposentar
      if cSexo == "M" 
         // Homens: 30 anos de contribuicao e 61 anos de idade
         if nTempoContribuicao >= 30 .and. nIdade >= 61
            lAptoAposentar := .T.
            nHomensAposentados++
            nTotRemuAposentados += nRemuneracaoFinal
            if nIdade > 91
               nHomens91anos++   // conta homens com mais de 91 anos
            endif
         endif
      else
         // Mulheres: 20 anos de contribuicao e 58 anos de idade
         if nTempoContribuicao >= 20 .and. nIdade >= 58
            lAptoAposentar := .T.
            nMulheresAposentadas++
            nTotRemuAposentados += nRemuneracaoFinal
            if dDataAdmissao < CToD("01/01/2013")
               nMulheresAntes2013++   // conta mulheres admitidas antes de 2013
            endif
         endif
      endif
      
      // Recontagem de aposentados (logica duplicada - ja contada acima)
      if lAptoAposentar .AND. cSexo == "M"
         nHomensAposentados++
      elseif lAptoAposentar .AND. cSexo == "F"
         nMulheresAposentadas++
      endif
      
      Inkey(2)

      // Exibe a area de resultados parciais ou completos
      @ 16,01 clear to 24,79
      @ 15,00 to 22,79
      
      @ 15,32 say "RESULTADOS: "
      
      // Indica se o resultado e parcial ou completo
      if nContador < nEmpregados
         @ 15,44 say "PARCIAL"
      else
         @ 15,44 say "COMPLETO"
      endif
      
      // Calcula percentuais de aposentados por genero
      nPercHomensApos   := 0
      nPercMulheresApos := 0

      if nTotHomens > 0
         nPercHomensApos := (nHomensAposentados/nTotHomens) * 100
      endif
      
      if nTotMulheres > 0
         nPercMulheresApos := (nMulheresAposentadas/nTotMulheres) * 100
      endif

      // Exibe o relatorio de resultados
      @ 16,02 say "HOMENS PROCESSADOS..............: " + AllTrim(Str(nTotHomens))
      @ 16,42 say "APOSENTADOS: " + AllTrim(Str(nHomensAposentados)) + " = " + AllTrim(Str(nPercHomensApos,6,1)) + "%"
      @ 17,02 say "MULHERES PROCESSADAS............: " + AllTrim(Str(nTotMulheres))
      @ 17,42 say "APOSENTADAS: " + AllTrim(Str(nMulheresAposentadas)) + " = " + AllTrim(Str(nPercMulheresApos,6,1)) + "%" 
      @ 18,02 say "REMUNERACAO TOTAL(APOSENTADOS)..: R$ " + AllTrim(Transform(nTotRemuAposentados,"@E 999,999.99"))
      @ 19,02 say "HOMENS > 91 ANOS................: " + AllTrim(Str(nHomens91anos))
      @ 20,02 say "MULHERES ADMITIDAS ANTES DE 2013: " + AllTrim(Str(nMulheresAntes2013))
      @ 21,02 say "MULHERES QUE PAGAM IRRF(%)......: " + AllTrim(Str((nMulheresPagamIRRF / nTotMulheres) * 100)) + "%"

      Inkey(0)

      // Pergunta se deseja iniciar um novo processamento ou encerrar
      cMensagem := "NOVO PROCESSAMENTO?"
      nOpcao    := Alert(cMensagem, {'SIM' , 'NAO'} )
      
      if nOpcao == 2
         EXIT
      endif
      Inkey(0)
   enddo
enddo

// Aguarda o usuario pressionar qualquer tecla para encerrar
Inkey(0)