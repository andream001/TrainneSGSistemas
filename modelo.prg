// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo preto com texto branco
SetColor('W/N')

// Limpa a tela
clear

// Loop principal do programa
do while .t.
    // Se o usuario pressionou ESC, pergunta se deseja sair
    if lastkey() == 27
      cMensagem := 'DESEJA SAIR?'
      cCor   := 'W/R'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      if nOpcao == 1
         EXIT
      endif
      loop
   endif

enddo

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
