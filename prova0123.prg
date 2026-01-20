//André Luiz Bunhak
Set date BRITISH
Set epoch to 1940
SetColor('N/W')

clear

cNomeAluno   := Space(30)
cDisciplina1 := Space(30)
cDisciplina2 := Space(30) 
cDisciplina3 := Space(30)
cCurso       := Space(30)
cStatusA     := Space(5)
cStatusB     := Space(5)
cStatusC     := Space(5)
cDpA         := Space(30)
cDpB         := Space(30)
cDpC         := Space(30)        
cCorNota     := 'G/W'


nSerie            := 0
nValorMensalidade := 0

nNotaB1 := 0
nNotaB2 := 0
nNotaB3 := 0
nNotaB4 := 0

nMediaB := 0
nMediaA := 0
nMediaC := 0

nFaltasB1 := 0
nFaltasB2 := 0
nFaltasB3 := 0
nFaltasB4 := 0

nMaxFaltas := 0
nMediaMin  := 0
nDpCont    := 0

@ 01,01 to 24,78

@ 02,33 say "ESCOLA SGSISTEMAS"
@ 04,03 say "ALUNO......:"
@ 05,03 say "CURSO......:"
@ 06,03 say "SERIE......:"
@ 07,03 say "MENSALIDADE:"

@ 04,16 get cNomeAluno        picture '@!'         valid !Empty(cNomeAluno)
@ 05,16 get cCurso            picture '@!'         valid !Empty(cCurso)
@ 05,16 get nSerie            picture '9'          valid nSerie >= 1 .and. nSerie <=8
@ 07,16 get nValorMensalidade picture '@E 9999.99' valid nValorMensalidade > 0
read

if nSerie <= 4
   nMediaMin := 60
else
   nMediaMin := 70
endif

if nSerie <= 3
   nMaxFaltas := 6
else
   nMaxFaltas := 8
endif

InKey(0)

@ 09,03 say "DISCIPLINAS:"
@ 09,17 say "1 BIMESTRE   2 BIMESTRE   3 BIMESTRE   4 BIMESTRE   STATUS" 
@ 10,17 say "NOTA FALTA   NOTA FALTA   NOTA FALTA   NOTA FALTA"

@ 12,03 get cDisciplina1 picture '@!'  valid !Empty(cDisciplina1)
@ 12,16 get nNotaB1      picture '999' valid nNotaB1   >= 0 .and. nNotaB1  <= 100
@ 12,23 get nFaltasB1    picture '999' valid nFaltasB1 >= 0 .and. nFaltasB1 <= 60
@ 12,29 get nNotaB2      picture '999' valid nNotaB2   >= 0 .and. nNotaB2  <= 100
@ 12,36 get nFaltasB2    picture '999' valid nFaltasB2 >= 0 .and. nFaltasB2 <= 60
@ 12,42 get nNotaB3      picture '999' valid nNotaB3   >= 0 .and. nNotaB3  <= 100
@ 12,49 get nFaltasB3    picture '999' valid nFaltasB3 >= 0 .and. nFaltasB3 <= 60
@ 12,55 get nNotaB4      picture '999' valid nNotaB4   >= 0 .and. nNotaB4  <= 100
@ 12,62 get nFaltasB4    picture '999' valid nFaltasB4 >= 0 .and. nFaltasB4 <= 60
read

nMediaA := (nNotaB1 + nNotaB2 + nNotaB3 + nNotaB4) / 4

If (nFaltasB1 > nMaxFaltas .OR. nFaltasB2 > nMaxFaltas .OR. nFaltasB3 > nMaxFaltas .OR. nFaltasB4 > nMaxFaltas) .OR. nMediaA < nMediaMin
   cStatusA := 'REPRO'
   cCorNota := 'R/W'
   nDpCont  ++
Else
   cStatusA := 'APROV'
endif

@ 12,69 say cStatusA Color(cCorNota)

nNotaB1 := 0
nNotaB2 := 0
nNotaB3 := 0
nNotaB4 := 0

nFaltasB1 := 0
nFaltasB2 := 0
nFaltasB3 := 0
nFaltasB4 := 0

@ 15,03 get cDisciplina2 picture '@!'  valid !Empty(cDisciplina2)
@ 15,16 get nNotaB1      picture '999' valid nNotaB1   >= 0 .and. nNotaB1  <= 100
@ 15,23 get nFaltasB1    picture '999' valid nFaltasB1 >= 0 .and. nFaltasB1 <= 60
@ 15,29 get nNotaB2      picture '999' valid nNotaB2   >= 0 .and. nNotaB2   <= 100
@ 15,36 get nFaltasB2    picture '999' valid nFaltasB2 >= 0 .and. nFaltasB2 <= 60
@ 15,42 get nNotaB3      picture '999' valid nNotaB3   >= 0 .and. nNotaB3   <= 100
@ 15,49 get nFaltasB3    picture '999' valid nFaltasB3 >= 0 .and. nFaltasB3 <= 60
@ 15,55 get nNotaB4      picture '999' valid nNotaB4   >= 0 .and. nNotaB4   <= 100
@ 15,62 get nFaltasB4    picture '999' valid nFaltasB4 >= 0 .and. nFaltasB4 <= 60
read

nMediaB := (nNotaB1 + nNotaB2 + nNotaB3 + nNotaB4) / 4

If (nFaltasB1 > nMaxFaltas .OR. nFaltasB2 > nMaxFaltas .OR. nFaltasB3 > nMaxFaltas .OR. nFaltasB4 > nMaxFaltas) .OR. nMediaA < nMediaMin
   cStatusB := 'REPRO'
   cCorNota := 'R/W'
   nDpCont  ++
Else
   cStatusB := 'APROV'
endif

@ 15,69 say cStatusB Color(cCorNota)

nNotaB1 := 0
nNotaB2 := 0
nNotaB3 := 0
nNotaB4 := 0

nFaltasB1 := 0
nFaltasB2 := 0
nFaltasB3 := 0
nFaltasB4 := 0

@ 18,03 get cDisciplina3 picture '@!'  valid !Empty(cDisciplina3)
@ 18,16 get nNotaB1      picture '999' valid nNotaB1   >= 0 .and. nNotaB1   <= 100
@ 18,23 get nFaltasB1    picture '999' valid nFaltasB1 >= 0 .and. nFaltasB1 <= 60
@ 18,29 get nNotaB2      picture '999' valid nNotaB2   >= 0 .and. nNotaB2   <= 100
@ 18,36 get nFaltasB2    picture '999' valid nFaltasB2 >= 0 .and. nFaltasB2 <= 60
@ 18,42 get nNotaB3      picture '999' valid nNotaB3   >= 0 .and. nNotaB3   <= 100
@ 18,49 get nFaltasB3    picture '999' valid nFaltasB3 >= 0 .and. nFaltasB3 <= 60
@ 18,55 get nNotaB4      picture '999' valid nNotaB4   >= 0 .and. nNotaB4   <= 100
@ 18,62 get nFaltasB4    picture '999' valid nFaltasB4 >= 0 .and. nFaltasB4 <= 60
read

nMediaC := (nNotaB1 + nNotaB2 + nNotaB3 + nNotaB4) / 4

If (nFaltasB1 > nMaxFaltas .OR. nFaltasB2 > nMaxFaltas .OR. nFaltasB3 > nMaxFaltas .OR. nFaltasB4 > nMaxFaltas) .OR. nMediaA < nMediaMin
   cStatusC := 'REPRO'
   cCorNota := 'R/W'
   nDpCont  ++
Else
   cStatusC := 'APROV'
endif

@ 18,69 say cStatusC Color(cCorNota)


Inkey(0)