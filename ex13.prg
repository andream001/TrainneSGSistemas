SetColor('N/W')

clear

nCodProd := 0
cClasse  := Space(30)
cCor     := Space(5)

@ 01,01 to 03,59 color 'N/W'
@ 04,01 to 06,59 color 'N/W'

@ 02,10 say "Codigo do Produto:"

@ 02,28 get nCodProd picture "99" valid nCodProd >= 1 .and. nCodProd <= 15
read

if nCodProd == 1

    cClasse := "Alimento nao perecivel"
    cCor    := 'N/W'    

elseif nCodProd >= 2 .and. nCodProd <= 4

    cClasse := "Alimento perecivel"
    cCor    := 'B/W'

elseif nCodProd >= 5 .and. nCodProd <= 6

    cClasse := "Vestuario"
    cCor    := 'G/W'

elseif nCodProd == 7

    cClasse := "Higiene pessoal"
    cCor    := 'R/W'

elseif nCodProd >= 8 .and. nCodProd <= 15

    cClasse := "Limpeza e utensilios domesticos"
    cCor    := 'GR+/W'
endif

@ 05,10 say "Classe do Produto: " + cClasse Color(cCor)

InKey(0)
