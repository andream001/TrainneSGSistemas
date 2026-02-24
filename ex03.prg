// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Loop infinito para permitir multiplas operacoes
do while .t.

   // Inicializa as variaveis numericas e a mensagem a cada iteracao
   nNum1 := 0
   nNum2 := 0
   
   cMensagem := 'DESEJA SAIR?'

   // Desenha uma caixa para organizar os campos
   @ 01,01 to 05,40

   // Exibe os rotulos dos campos
   @ 02,10 say "Numero 1:"
   @ 03,10 say "Numero 2:"
   @ 04,10 say "Produto: "

   // Leitura dos dois numeros sem restricao de valor
   @ 02,20 get nNum1
   @ 03,20 get nNum2
   read
   
   // Se o usuario pressionou ESC, exibe alerta perguntando se deseja sair
   if lastkey() == 27
      cCor   := 'G/N'
      nOpcao := Alert(cMensagem, {'SIM' , 'NAO'} , cCor)
      // Se escolheu SIM, encerra o loop
      if nOpcao == 1
         EXIT
      endif
      // Se escolheu NAO, volta ao inicio do loop
      loop
   endif

   // Calcula o produto dos dois numeros
   nProduto := nNum1 * nNum2

   // Exibe o resultado do produto na tela
   @ 04,20 say nProduto
enddo

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)
