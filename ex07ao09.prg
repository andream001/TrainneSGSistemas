Set date BRITISH
Set epoch to 1940
SetColor('W/N')
Set Message to 11 Center

clear

do while .t.
    
    nOpcao             := 0
    nContadorExercicio := 1
    
    cMessage           := "ABRE O EXERCICIO " + AllTrim(Str(nContadorExercicio))
    
    @ 01,00 to 05,79

    @ 02,01 prompt "EXERCICIO 7" Message "FAZ A LEITURA DE 2 VALORES E RETORNA O RESULTADO DAS 4 OPERACOES BASICAS"
    @ 03,01 prompt "EXERCICIO 8" Message "MERCADO"
    @ 04,01 prompt "EXERCICIO 9" Message "LE 1 LETRA, 1 DATA, 1 NUMERO INTEIRO, 1 NUMERO COM CASAS DECIMAIS E 1 STRING"
    
    menu to nOpcao
    
    do while .t.
        if nOpcao == 1
            clear 

    if nOpcao == 1
        cls
        cTexto := '    Alo Mundo!   ' 
        @ 10,01 to 13,79
        @ 11,05 say cTexto Color('W/N')
        @ 12,05 say AllTrim(cTexto) + " Tchau Mundo!" Color('W/N') // retira os espaços em branco da direita e esquerda
    endif

    
enddo

InKey(0)
