//André Luiz Bunhak

SetColor('N/W')

clear

cNomeAluno        := Space(30)
cDisciplina1      := Space(30)
cDisciplina2      := Space(30)
cDisciplina3      := Space(30)
cCurso            := Space(30)
cCorN             := 'G/W'
cCorF             := 'G/W'

nSerie            := 0
nValorMensalidade := 0
nNota1            := 0
nNota2            := 0
nNota3            := 0
nNota4            := 0
nMediaA           := 0
nMediaB           := 0
nMediaA           := 0
nFaltas1          := 0
nFaltas2          := 0
nFaltas3          := 0
nFaltas4          := 0
nFaltasA          := 0
nFaltasB          := 0
nFaltasC          := 0
nFaltasT          := 0 
nFalta            := 0

@ 01,01 to 23,78

@ 02,33 say "ESCOLA SGSISTEMAS"
@ 04,33 say "BOLETIM ESCOLAR"

@ 06,03 say "ALUNO......:"
@ 06,16 get cNomeAluno        picture '@!'         valid !Empty(cNomeAluno)
read
@ 07,03 say "CURSO......:"
@ 07,16 get cCurso            picture '@!'         valid !Empty(cCurso)
read
@ 08,03 say "SERIE......:"
@ 08,16 get nSerie            picture '9'          valid nSerie >= 1 .and. nSerie <=8
read

InKey(0)

@ 09,03 say "MENSALIDADE:"
@ 09,16 get nValorMensalidade picture '@E 9999.99' valid nValorMensalidade > 0
read
@ 11,03 say "DISCIPLINA .....1:"
@ 11,21 get cDisciplina1      picture '@!'         valid !Empty(cDisciplina1)
read
@ 14,03 say "NOTA BIMESTRE...1:" 
@ 14,21 get nNota1            picture '999'        valid nNota1 >= 0 .and. nNota1 <= 100
read
@ 14,40 say "FALTAS BIMESTRE 1:"
@ 14,68 get nFalta          picture '999'        valid nFaltas1 >= 0 .and. nFaltas1 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF := 'R/W'
elseif nSerie <= 8 .and. nFalta >= 8
    cCorF := 'R/W'
    endif

@ 16,03 say "NOTA BIMESTRE...2:" 
@ 16,21 get nNota2            picture '999'        valid nNota2 >= 0 .and. nNota2 <= 100
read
@ 16,40 say "FALTAS BIMESTRE 2:"
@ 16,68 get nFalta         picture '999'        valid nFaltas2 >= 0 .and. nFaltas2 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF := 'R/W'
elseif nSerie <= 8 .and. nFalta >= 8
    cCorF := 'R/W'
    endif

@ 18,03 say "NOTA BIMESTRE...3:" 
@ 18,21 get nNota3 picture '999'        valid nNota3 >= 0 .and. nNota3 <= 100
read
@ 18,40 say "FALTAS BIMESTRE 3:"
@ 18,68 get nFalta picture '999'        valid nFaltas3 >= 0 .and. nFaltas3 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF := 'R/W'
elseif nSerie <= 8 .and. nFalta >= 8
    cCorF := 'R/W'
    endif

@ 20,03 say "NOTA BIMESTRE...4:" 
@ 20,21 get nNota4 picture '999' valid nNota4 >= 0 .and. nNota4 <= 100
read
@ 20,40 say "FALTAS BIMESTRE 4:"
@ 20,68 get nFalta picture '999' valid nFaltas4 >= 0 .and. nFaltas4 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF := 'R/W'
    endif

@ 10,45 say "MEDIA                FALTAS"
nMediaA := (nNota1 + nNota2 + nNota3 + nNota4) / 4

if nSerie <= 4 .and. nMediaA < 60
    cCorN := 'R/W'

elseif nSerie <= 8 .and. nMediaA < 70
    cCorN := 'R/W'
    endif

 if cCorN == 'R/W'
    @ 11,45 say "REPROVADO:" + AllTrim(Transform(nMediaA , "999.99")) Color(cCorN)
else
    @ 11,45 say "APROVADO:"  + AllTrim(Transform(nMediaA , "999.99")) Color(cCorN)
    endif

if cCorF == 'R/W'
     @ 11,50 say "REPROVADO:" + AllTrim(Transform(nFaltasT , "999")) Color(cCorF)
else
    @ 11,50 say "APROVADO:"   + AllTrim(Transform(nFaltasT , "999"))  Color(cCorF)
    endif

cCorN             := 'G/W'
cCorF             := 'G/W'

@10,03 clear to 21,76

@ 11,03 say "DISCIPLINA .....2:"
@ 11,21 get cDisciplina2 picture '@!'  valid !Empty(cDisciplina1)
read
@ 14,03 say "NOTA BIMESTRE...1:" 
@ 14,21 get nNota1       picture '999' valid nNota1 >= 0 .and. nNota1 <= 100
read
@ 14,40 say "FALTAS BIMESTRE 1:"
@ 14,68 get nFalta       picture '999' valid nFaltas1 >= 0 .and. nFaltas1 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF := 'R/W'
    endif

@ 16,03 say "NOTA BIMESTRE...2:" 
@ 16,21 get nNota2 picture '999' valid nNota2 >= 0 .and. nNota2 <= 100
read
@ 16,40 say "FALTAS BIMESTRE 2:"
@ 16,68 get nFalta picture '999' valid nFaltas2 >= 0 .and. nFaltas2 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF := 'R/W'
    endif

@ 18,03 say "NOTA BIMESTRE...3:" 
@ 18,21 get nNota3 picture '999' valid nNota3 >= 0 .and. nNota3 <= 100
read
@ 18,40 say "FALTAS BIMESTRE 3:"
@ 18,68 get nFalta picture '999' valid nFaltas3 >= 0 .and. nFaltas3 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF    := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF    := 'R/W'
    endif

@ 20,03 say "NOTA BIMESTRE...4:" 
@ 20,21 get nNota4 picture '999' valid nNota4 >= 0 .and. nNota4 <= 100
read
@ 20,40 say "FALTAS BIMESTRE 4:"
@ 20,68 get nFalta picture '999' valid nFaltas4 >= 0 .and. nFaltas4 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF := 'R/W'
    endif

nMediaB  := (nNota1 + nNota2 + nNota3 + nNota4) / 4

if nSerie <= 4 .and. nMediaB < 60
    cCorN := 'R/W'

elseif nSerie <= 8 .and. nMediaB < 70
    cCorN := 'R/W'
    endif

if cCorN == 'R/W'
    @ 11,45 say "REPROVADO:" + AllTrim(Transform(nMediaA , "999.99")) Color(cCorN)
else
    @ 11,45 say "APROVADO:" + AllTrim(Transform(nMediaA , "999.99")) Color(cCorN)
    endif

if nFaltasB >= 1
    
    @ 11,50 say "REPROVADO:" + AllTrim(Transform(nFaltasT , "999")) Color(cCorF)
else
    
    @ 11,50 say "APROVADO:" + AllTrim(Transform(nFaltasT , "999"))  Color(cCorF)
    endif

Inkey(0)

cCorN := 'G/W'
cCorF := 'G/W'

@10,03 clear to 21,76

@ 11,03 say "DISCIPLINA .....3:"
@ 11,21 get cDisciplina3      picture '@!'         valid !Empty(cDisciplina1)
read
@ 14,03 say "NOTA BIMESTRE...1:" 
@ 14,21 get nNota1            picture '999'        valid nNota1 >= 0 .and. nNota1 <= 100
read
@ 14,40 say "FALTAS BIMESTRE 1:"
@ 14,68 get nFalta            picture '999'        valid nFaltas1 >= 0 .and. nFaltas1 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF    := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF    := 'R/W'
    endif

@ 16,03 say "NOTA BIMESTRE...2:" 
@ 16,21 get nNota2            picture '999'        valid nNota2 >= 0 .and. nNota2 <= 100
read
@ 16,40 say "FALTAS BIMESTRE 2:"
@ 16,68 get nFalta            picture '999'        valid nFaltas2 >= 0 .and. nFaltas2 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF    := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF    := 'R/W'
    endif


@ 18,03 say "NOTA BIMESTRE...3:" 
@ 18,21 get nNota3            picture '999'        valid nNota3 >= 0 .and. nNota3 <= 100
read
@ 18,40 say "FALTAS BIMESTRE 3:"
@ 18,68 get nFalta         picture '999'        valid nFaltas3 >= 0 .and. nFaltas3 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF := 'R/W'
    endif

@ 20,03 say "NOTA BIMESTRE...4:" 
@ 20,21 get nNota4            picture '999'        valid nNota4 >= 0 .and. nNota4 <= 100
read
@ 20,40 say "FALTAS BIMESTRE 4:"
@ 20,68 get nFalta       picture '999'        valid nFaltas4 >= 0 .and. nFaltas4 <= 200
read

nFaltasT += nFalta

if nSerie <= 3 .and. nFalta >= 7
    cCorF    := 'R/W'

elseif nSerie <= 8 .and. nFalta >= 8
    cCorF    := 'R/W'
    endif

nMediaC  := (nNota1 + nNota2 + nNota3 + nNota4) / 4

if nSerie <= 4 .and. nMediaC < 60
    cCorN := 'R/W'

elseif nSerie <= 8 .and. nMediaC < 70
    cCorN := 'R/W'
    endif

if nMediaC <= 70 .and. nSerie > 4
    @ 11,45 say "REPROVADO:" + AllTrim(Transform(nMediaC , "999.99")) Color(cCorN)
else
    @ 11,45 say "APROVADO:" + AllTrim(Transform(nMediaC , "999.99")) Color(cCorN)
    endif

if nFaltasC >= 1
    
    @ 11,50 say "REPROVADO:" + AllTrim(Transform(nFaltasT , "999")) Color(cCorF)
else
    
    @ 11,50 say "APROVADO:" + AllTrim(Transform(nFaltasT , "999"))  Color(cCorF)
    endif

Inkey(0)

@10,03 clear to 21,76



