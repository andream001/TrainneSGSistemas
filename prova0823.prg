//ANDRE LUIZ BUNHAK

Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 23 center

clear

xBancodeDados := ""

@ 01,00 to 24,79
@ 03,01 to 03,78

@ 02,30 say "CADASTRO DE FUNCIONARIOS"

nOpcao := 0

@ 05,03 prompt "CADASTRAR"  message "Permite o cadastro de funcionarios"
@ 06,03 prompt "CONSULTAR"  message "Exibe os funcionario cadastrados com paginacao e ordenacao"
@ 07,03 prompt "CONFIGURAR" message "Define criterios de exibicao e ordenao"
@ 08,03 prompt "SAIR"       message "Encerra o programa" 

menu to nOpcao 

if nOpcao

do while .t.
   
   if lastkey() == 27
      exit
   endif

enddo

InKey(0)
