SetColor('N/W')

clear

cTexto := '    Alo Mundo!   ' 

@ 01,01 to 04,30

@ 02,05 say cTexto Color('W/N')
@ 03,05 say AllTrim(cTexto) + " Tchau Mundo!" Color('W/N') // retira os espaços em branco da direita e esquerda

InKey(0)