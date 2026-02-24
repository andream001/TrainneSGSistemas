// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Inicializa a variavel de texto com espacos em branco nas bordas
cTexto := '    Alo Mundo!   ' 

// Desenha uma caixa na tela
@ 01,01 to 04,30

// Exibe o texto original com cor invertida (fundo preto, texto branco)
@ 02,05 say cTexto Color('W/N')
// Exibe o texto sem espacos nas bordas, concatenado com outra mensagem
@ 03,05 say AllTrim(cTexto) + " Tchau Mundo!" Color('W/N') // retira os espaços em branco da direita e esquerda

// Aguarda o usuario pressionar qualquer tecla para encerrar
InKey(0)