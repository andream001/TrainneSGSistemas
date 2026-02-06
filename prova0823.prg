//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 23 center

clear

cBancodeNomes    := ""
cBancodeDatas    := ""
cBancodeSalarios := ""

nTotalRegistros     := 0
nRegistrosporpagina := 5

cOrdenacao          := "C"
cOrdernarpor        := "N"

@ 01,00 to 24,79
@ 03,01 to 03,78
@ 04,17 to 23,17

@ 02,30 say "CADASTRO DE FUNCIONARIOS"

nOpcao := 0

do while .t.
   @ 04,18 clear to 23,78
   
   @ 05,03 prompt "CADASTRAR"  message "Permite o cadastro de funcionarios"
   @ 06,03 prompt "CONSULTAR"  message "Exibe os funcionario cadastrados com paginacao e ordenacao"
   @ 07,03 prompt "CONFIGURAR" message "Define criterios de exibicao e ordenao"
   @ 08,03 prompt "SAIR"       message "Encerra o programa" 

   menu to nOpcao 

   @ 23,02 clear to 23,78
   
   if nOpcao == 1
      do while .t.
         @ 04,18 clear to 23,78
         
         cNome := Space(25)
         
         dDatadeAdmissao := CToD("")
         
         nSalario := 0

         @ 05,19 say "NOME............:"
         @ 06,19 say "DATA DE ADMISSAO:"
         @ 07,19 say "SALARIO......:R$ "

         @ 05,36 get cNome           picture "@!"           valid !Empty(cNome)
         @ 06,36 get dDatadeAdmissao                        valid !Empty(dDatadeAdmissao) .and. dDatadeAdmissao <= date()
         @ 07,36 get nSalario        picture "@E 99,999.99" valid nSalario > 0 
         read
         
         if lastkey() == 27
            exit
         endif
         
         cBancodeNomes    += cNome
         cBancodeDatas    += DToS(dDatadeAdmissao)
         cBancodeSalarios += Str(nSalario, 10, 2)
         
         nTotalRegistros++
      enddo
      
   elseif nOpcao == 2      
      
      @ 02,01 clear to 02,78

      @ 02,30 say "CONSULTAR FUNCIONARIOS"

      if nTotalRegistros == 0
         Alert("NENHUM REGISTRO ENCONTRADO")
         loop
      endif
      
      cNomesOrdenados    := cBancodeNomes
      cDatasOrdenadas    := cBancodeDatas
      cSalariosOrdenados := cBancodeSalarios
      
      nRegistros := 1
      do while nRegistros < nTotalRegistros
         nProximo := nRegistros + 1
         do while nProximo <= nTotalRegistros
            lTrocar := .F.
            
            cNome1     := SubStr(cNomesOrdenados, (nRegistros-1)*25+1, 25)
            cNome2     := SubStr(cNomesOrdenados, (nProximo-1)*25+1, 25)
            cData1     := SubStr(cDatasOrdenadas, (nRegistros-1)*8+1, 8)
            cData2     := SubStr(cDatasOrdenadas, (nProximo-1)*8+1, 8)
            cSalario1  := SubStr(cSalariosOrdenados, (nRegistros-1)*10+1, 10)
            cSalario2  := SubStr(cSalariosOrdenados, (nProximo-1)*10+1, 10)
            
            if cOrdernarpor == "N"
               if cOrdenacao == "C"
                  lTrocar := cNome1 > cNome2
               else
                  lTrocar := cNome1 < cNome2
               endif
            elseif cOrdernarpor == "D"
               if cOrdenacao == "C"
                  lTrocar := cData1 > cData2
               else
                  lTrocar := cData1 < cData2
               endif
            else  
               if cOrdenacao == "C"
                  lTrocar := Val(cSalario1) > Val(cSalario2)
               else
                  lTrocar := Val(cSalario1) < Val(cSalario2)
               endif
            endif
            
            if lTrocar
               cNomesOrdenados    := SubStr(cNomesOrdenados, 1, (nRegistros-1)*25) + cNome2 + SubStr(cNomesOrdenados, nRegistros*25+1, (nProximo-1-nRegistros)*25) + cNome1 + SubStr(cNomesOrdenados, nProximo*25+1)
               cDatasOrdenadas    := SubStr(cDatasOrdenadas, 1, (nRegistros-1)*8) + cData2 + SubStr(cDatasOrdenadas, nRegistros*8+1, (nProximo-1-nRegistros)*8) + cData1 + SubStr(cDatasOrdenadas, nProximo*8+1)
               cSalariosOrdenados := SubStr(cSalariosOrdenados, 1, (nRegistros-1)*10) + cSalario2 + SubStr(cSalariosOrdenados, nRegistros*10+1, (nProximo-1-nRegistros)*10) + cSalario1 + SubStr(cSalariosOrdenados, nProximo*10+1)
            endif
            
            nProximo++
         enddo
         nRegistros++
      enddo
      
      nPaginaAtual := 1
      nTotalPaginas := Int(nTotalRegistros / nRegistrosporpagina)
      
      if nTotalRegistros % nRegistrosporpagina > 0
         nTotalPaginas++
      endif
      
      do while .t.
         
         @ 04,18 clear to 21,78
         
         @ 06,19 to 06,78
         
         @ 05,19 say "NOME" + Space(22) + "ADMISSAO" + Space(15) + "   SALARIO"
         
         
         nPrimeiroRegistro := (nPaginaAtual - 1) * nRegistrosporpagina + 1
         nUltimoRegistro   := nPaginaAtual       * nRegistrosporpagina
         
         if nUltimoRegistro > nTotalRegistros
            nUltimoRegistro := nTotalRegistros
         endif
         
         nLinha := 07
         nRegistros := nPrimeiroRegistro
         
         do while nRegistros <= nUltimoRegistro
            cNomeExibir    := SubStr(cNomesOrdenados, (nRegistros-1)*25+1, 25)
            cDataExibir    := SubStr(cDatasOrdenadas, (nRegistros-1)*8+1, 8)
            cSalarioExibir := SubStr(cSalariosOrdenados, (nRegistros-1)*10+1, 10)
            
            nSalarioExibir := Val(cSalarioExibir)
            
            dDataExibir    := SToD(cDataExibir)

            @ nLinha,19 say cNomeExibir + " " + DToC(dDataExibir) + Space(13) + "R$ " + Transform(nSalarioExibir, "@E 99,999.99")

            nLinha++
            nRegistros++
         enddo
         
         @ 22,01 to 22,78
         
         @ 22,35 say AllTrim(Str(nPaginaAtual)) + " / " + AllTrim(Str(nTotalPaginas))
         
         @ 23,03 prompt "<" message "Pagina anterior"
         @ 23,76 prompt ">" message "Proxima pagina"
         
         menu to nOpcaoNav
         
         if nOpcaoNav == 1
            if nPaginaAtual > 1
               nPaginaAtual--
            endif
         elseif nOpcaoNav == 2
            if nPaginaAtual < nTotalPaginas
               nPaginaAtual++
            endif
         else
            exit
         endif
      enddo

   elseif nOpcao == 3
      
      @ 02,01 clear to 02,78
      @ 04,18 clear to 23,78

      @ 02,30 say "COONFIGURAR PAGINACAO"
      
      do while .t.
         @ 05,19 say "REGISTROS POR PAGINA: " + "   [1 a 10]"
         @ 06,19 say "ORDENAR POR.........: " + "   [N]OME [D]ATA DE ADMISSAO [S]ALARIO"
         @ 07,19 say "ORDEM...............: " + "   [C]RESCENTE [D]ECRESCENTE"
         
         @ 05,41 get nRegistrosporpagina picture "99" valid nRegistrosporpagina > 0 .and. nRegistrosporpagina <= 10
         @ 06,41 get cOrdernarpor        picture "@!" valid cOrdernarpor $ 'NDS'
         @ 07,41 get cOrdenacao          picture "@!" valid cOrdenacao   $ 'CD'
         read

         if lastkey() == 27
            exit
         endif
         
         exit
      enddo
   else
      exit
   endif
enddo