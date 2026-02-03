//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')

clear

do while .t.
   clear

   cCorAlerta := 'W/R'
   cUsuario   := 'JOSE'
   
   cLogin       := Space(30)
   cSenha       := Space(30)
   cNomeCliente := Space(40)
   cEquipamento := Space(40)
   cNomeTecnico := Space(30)
   cEntrega     := Space(1)
   
   cEnderecoEntrega := Space(30)
   cBairro          := Space(20)
   cReferencia      := Space(30)
   cTelefone        := Space(20)
   
   cTipo := Space(1)

   nTaxadeEntrega  := 2
   nOrdemdeServico := 1
   nLimiteCredito  := 0
   nControleLinha  := 8
   nValorTotal     := 0

   dDataOrdemServico := CToD("")
   dDataCompra       := CToD("")

   @ 01,00 to 24,79

   @ 01,30 say "ASSISTENCIA DO ANDRE"
   @ 11,22 say "USUARIO:"
   @ 12,22 say "SENHA..:"
    
   @ 11,31 get cLogin picture "@!" valid !Empty(cUsuario)
   @ 12,31 get cSenha              valid !Empty(cSenha)
   read
   
   if lastkey() == 27
      cMensagem := 'DESEJA SAIR?'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif
   
   if Alltrim(cSenha) != "432mudar123" .OR. Alltrim(cLogin) != cUsuario 
      Alert("USUARIO OU SENHA INCORRETOS", cCorAlerta)
      loop
   endif

   @ 02,01 clear to 23,78
   @ 02,19 to 23,19

   nOpcao := 0

   @ 03,02 prompt "EFETUAR PEDIDOS" message "CRIA UM NOVO PEDIDO"
   @ 04,02 prompt "SAIR..........." Message "SAIR DO PROGRAMA"
      
   menu to nOpcao

   if nOpcao == 1
      do while .T.
         @02,01 clear to 23,78
         
         @ 02,01 say "ORDEM DE SERVICO......:" + Alltrim(Transform(nOrdemdeServico, "00000009"))
         @ 02,55 say "TIPO:[P]RODUTO [S]ERVICO"
         @ 03,01 say "NOME DO CLIENTE.......:"
         @ 04,55 say "LIMITE........:R$ "
         @ 04,01 say "DATA(ORDEM DE SERVICO):"
         @ 05,01 say "NOME DO TECNICO.......:"
         @ 05,55 say "DATA DA COMPRA:"
         @ 06,01 say "DESCRICAO EQUIPAMENTO.:"
         @ 06,55 say "TIPO..........:"
         @ 06,01 say "ENTREGA A DOMICILIO...:   [S]IM [N]AO"
         
         @ 03,24 get cNomeCliente      picture "@!"           valid !Empty(cNomeCliente)
         @ 04,24 get dDataOrdemServico                        valid dDataOrdemServico >= Date()
         @ 04,70 get nLimiteCredito    picture "@E 99,999.99" valid nLimiteCredito    >= 0 
         @ 05,24 get cNomeTecnico      picture "@!"           valid !Empty(cNomeTecnico)
         @ 05,70 get dDataCompra                              valid !Empty(dDataCompra)
         @ 06,70 get cTipo             picture "@!"           valid cTipo    $ "PS" 
         @ 06,24 get cEntrega          picture "@!"           valid cEntrega $ "SN"
         read
         
         if lastkey() == 27
            cMensagem := 'DESEJA SAIR?'
            nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
            if nOpcao == 1
               EXIT
            endif
            loop
         endif
         
         if cEntrega == 'S'
            //adicionar 2% de taxa
            @ 22,01 clear to 23,78
            @ 07,01 to 07,78
            
            @ 08,01 say "ENDERECO..:"
            @ 08,45 say "BAIRRO..:"
            @ 09,01 say "REFERENCIA:"
            @ 09,45 say "TELEFONE:"

            @ 08,13 get cEnderecoEntrega picture "@!"               valid !Empty(cEnderecoEntrega)
            @ 08,55 get cBairro          picture "@!"               valid !Empty(cBairro)
            @ 09,13 get cReferencia      picture "@!"               valid !Empty(cReferencia)
            @ 09,55 get cTelefone        picture "(99) 9 9999-9999" valid !Empty(cTelefone)
            read
            
            if lastkey() == 27
               cMensagem := 'DESEJA SAIR?'
               nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
               if nOpcao == 1
                  EXIT
               endif
               loop
            endif
            
            @ 10,01 to 10,78
         
            if nValorTotal > nLimiteCredito
               
               cSupervisor      := Space(15)
               cSenhaSupervisor := Space(15)
               
               Alert("SUPERVISOR", {"SIM" , "CANCELAR" } cCorAlerta)
               @ 22,22 say "SUPERVISOR SOLICITADO:"
               @ 23,22 say "SENHA SUPERVISOR.....:"
               
               @ 22,48 get 
               @ 23,48 get cSenhaSupervisor picture "@!" valid !Empty(cSenhaSupervisor)
               read
               
               if lastkey() == 27
                  cMensagem := 'DESEJA SAIR?'
                  nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCorAlerta)
                  if nOpcao == 1
                     EXIT
                  endif
                  loop
               endif
               if cSenhaSupervisor != "AUTORIZA99"
                  Alert("SENHA INCORRETA",cCorAlerta)
                  loop
                  @ 22,01 clear to 23,78
               endif
            endif

            if cTipo == "P"
               @ 09,01 clear to 11,78

               @ 

               


         endif




         Inkey(0)
         exit
         
      enddo
   else
      Alert("Saindo...", cCorAlerta)
      exit
   endif
enddo

InKey(0)
