//André Luiz Bunhak
// Define o formato de data para o padrao britanico (DD/MM/AAAA)
Set date BRITISH
// Define o ano base para interpretacao de anos com 2 digitos
Set epoch to 1940
// Define cor de fundo branco com texto preto
SetColor('N/W')

// Limpa a tela
clear

// Obtem a data atual do sistema
dData := date()

// Extrai os componentes da data atual
nAno         := Year(dData)
nDia         := Day(dData)
nDiadeSemana := DoW(dData)   // dia da semana como numero (1=Domingo, 7=Sabado)
nMes         := Month(dData)

// Inicializa variaveis de texto para os dados do aluno e disciplinas
cDiadeSemana := Space(20)
cMes         := Space(20)
cNomeAluno   := Space(20)
cDisciplina1 := Space(20)
cDisciplina2 := Space(20) 
cDisciplina3 := Space(20)
cCurso       := Space(20)
cStatusA     := Space(5)
cStatusB     := Space(5)
cStatusC     := Space(5)
cDpA         := Space(20)
cDpB         := Space(20)
cDpC         := Space(20)        
cStatusGeral := Space(17)
cCorNota     := 'G/W'
cCor         := 'G/W'

// Inicializa data de nascimento como vazia
dDataNascimento := cTod(" ")

// Inicializa variaveis numericas de serie, mensalidade e notas
nSerie                 := 0
nValorMensalidade      := 0
nValorMensalidadeAtual := 0

nNotaB1 := 0
nNotaB2 := 0
nNotaB3 := 0
nNotaB4 := 0
nMediaB := 0
nMediaA := 0
nMediaC := 0

// Inicializa contadores de faltas e limites
nFaltasB1  := 0
nFaltasB2  := 0
nFaltasB3  := 0
nFaltasB4  := 0
nMaxFaltas := 0
nMediaMin  := 0
nDpCont    := 0  // contador de dependencias (materias reprovadas)

// Determina o nome do mes por extenso com base no numero do mes
if nMes == 1
   cMes := 'JANEIRO'
elseif nMes == 2
   cMes := 'FEVEREIRO'
elseif nMes == 3
   cMes := 'MARCO'
elseif nMes == 4
   cMes := 'ABRIL'
elseif nMes == 5
   cMes := 'MAIO'
elseif nMes == 6
   cMes := 'JUNHO'
elseif nMes == 7
   cMes := 'JULHO'
elseif nMes == 8
   cMes := 'AGOSTO'
elseif nMes == 9
   cMes := 'SETEMBRO'
elseif nMes == 10
   cMes := 'OUTUBRO'
elseif nMes == 11
   cMes := 'NOVEMBRO'
else
   cMes := 'DEZEMBRO'
endif

// Determina o nome do dia da semana por extenso
if nDiadeSemana == 1
   cDiadeSemana := "DOMINGO"
elseif nDiadeSemana == 2
   cDiadeSemana := "SEGUNDA-FEIRA"
elseif nDiadeSemana == 3
   cDiadeSemana := "TERCA-FEIRA"
elseif nDiadeSemana == 4
   cDiadeSemana := "QUARTA-FEIRA"
elseif nDiadeSemana == 5
   cDiadeSemana := "QUINTA-FEIRA"
elseif nDiadeSemana == 6
   cDiadeSemana := "SEXTA-FEIRA"
else
   cDiadeSemana := "SABADO"
endif

// Desenha a borda da tela e exibe a data e o cabecalho
@ 01,01 to 24,78

@ 02,03 say "MARINGA, " + AllTrim(Str(nDia))
@ 02,15 say "de "       + AllTrim(cMes)
@ 02,27 say "de "       + AllTrim(Str(nAno))
@ 02,35 say "("         + AllTrim(cDiadeSemana) + ")" 
@ 02,60 say "ESCOLA SGSISTEMAS"

// Exibe os rotulos dos dados do aluno
@ 04,03 say "ALUNO......:"
@ 05,03 say "CURSO......:"
@ 06,03 say "SERIE......:"
@ 07,03 say "MENSALIDADE:"
@ 08,03 say "DATA NASC..:"

// Leitura dos dados do aluno com validacoes
@ 04,16 get cNomeAluno        picture '@!'         valid !Empty(cNomeAluno)
@ 05,16 get cCurso            picture '@!'         valid !Empty(cCurso)
@ 06,16 get nSerie            picture '9'          valid nSerie >= 1 .and. nSerie <=8 .AND. !Empty(nSerie)
@ 07,16 get nValorMensalidade picture '@E 9999.99' valid nValorMensalidade > 0
@ 08,16 get dDataNascimento                        valid !Empty(dDataNascimento)
read

// Define a media minima para aprovacao com base na serie
if nSerie <= 4
   nMediaMin := 60    // series iniciais: media minima 60
else
   nMediaMin := 70    // series finais: media minima 70
endif

// Define o numero maximo de faltas permitido por bimestre
if nSerie <= 3
   nMaxFaltas := 6
else
   nMaxFaltas := 8
endif

InKey(0)

// Exibe o cabecalho da tabela de notas e faltas por bimestre
@ 11,03 say "DISCIPLINAS:"
@ 11,17 say "1 BIMESTRE   2 BIMESTRE   3 BIMESTRE   4 BIMESTRE   MEDIA " 
@ 12,17 say "NOTA FALTA   NOTA FALTA   NOTA FALTA   NOTA FALTA"

// Leitura das notas e faltas da primeira disciplina (4 bimestres)
@ 14,03 get cDisciplina1 picture '@!'  valid !Empty(cDisciplina1)
@ 14,17 get nNotaB1      picture '999' valid nNotaB1   >= 0 .and. nNotaB1  <= 100
@ 14,23 get nFaltasB1    picture '999' valid nFaltasB1 >= 0 .and. nFaltasB1 <= 60
@ 14,30 get nNotaB2      picture '999' valid nNotaB2   >= 0 .and. nNotaB2  <= 100
@ 14,36 get nFaltasB2    picture '999' valid nFaltasB2 >= 0 .and. nFaltasB2 <= 60
@ 14,43 get nNotaB3      picture '999' valid nNotaB3   >= 0 .and. nNotaB3  <= 100
@ 14,49 get nFaltasB3    picture '999' valid nFaltasB3 >= 0 .and. nFaltasB3 <= 60
@ 14,56 get nNotaB4      picture '999' valid nNotaB4   >= 0 .and. nNotaB4  <= 100
@ 14,62 get nFaltasB4    picture '999' valid nFaltasB4 >= 0 .and. nFaltasB4 <= 60
read

// Calcula a media da primeira disciplina
nMediaA := (nNotaB1 + nNotaB2 + nNotaB3 + nNotaB4) / 4

// Verifica o status da primeira disciplina (aprovado/reprovado por falta ou nota)
If (nFaltasB1 > nMaxFaltas .OR. nFaltasB2 > nMaxFaltas .OR. nFaltasB3 > nMaxFaltas .OR. nFaltasB4 > nMaxFaltas)
   cCor     := 'R/W'
   cStatusA := 'REPROVADO FALTA'
   nDpCont  ++
   cDpA     := " " + cDisciplina1
elseif nMediaMin > nMediaA
      cStatusA := 'REPROVADO NOTA'
      cCor     := 'R/W'
      cCorNota := 'R/W'
      nDpCont  ++
      cDpA     := " " + cDisciplina1
Else
   cCorNota := 'G/W'
   cStatusA := 'APROVADO'
endif

// Exibe o status e a media da primeira disciplina
@ 04,43 say "STATUS:"
@ 14,69 say AllTrim(Transform(nMediaA, "999.99")) Color(cCorNota)
@ 05,43 say AllTrim(cDisciplina1) + ":"
@ 05,60 say cStatusA Color(cCor)

// Zera as notas e faltas para reutilizar as variaveis na proxima disciplina
nNotaB1 := 0
nNotaB2 := 0
nNotaB3 := 0
nNotaB4 := 0

nFaltasB1 := 0
nFaltasB2 := 0
nFaltasB3 := 0
nFaltasB4 := 0

// Leitura das notas e faltas da segunda disciplina (4 bimestres)
@ 17,03 get cDisciplina2 picture '@!'  valid !Empty(cDisciplina2)
@ 17,17 get nNotaB1      picture '999' valid nNotaB1   >= 0 .and. nNotaB1  <= 100
@ 17,23 get nFaltasB1    picture '999' valid nFaltasB1 >= 0 .and. nFaltasB1 <= 60
@ 17,30 get nNotaB2      picture '999' valid nNotaB2   >= 0 .and. nNotaB2   <= 100
@ 17,36 get nFaltasB2    picture '999' valid nFaltasB2 >= 0 .and. nFaltasB2 <= 60
@ 17,43 get nNotaB3      picture '999' valid nNotaB3   >= 0 .and. nNotaB3   <= 100
@ 17,49 get nFaltasB3    picture '999' valid nFaltasB3 >= 0 .and. nFaltasB3 <= 60
@ 17,56 get nNotaB4      picture '999' valid nNotaB4   >= 0 .and. nNotaB4   <= 100
@ 17,62 get nFaltasB4    picture '999' valid nFaltasB4 >= 0 .and. nFaltasB4 <= 60
read

// Calcula a media da segunda disciplina
nMediaB := (nNotaB1 + nNotaB2 + nNotaB3 + nNotaB4) / 4

// Verifica o status da segunda disciplina
If (nFaltasB1 > nMaxFaltas .OR. nFaltasB2 > nMaxFaltas .OR. nFaltasB3 > nMaxFaltas .OR. nFaltasB4 > nMaxFaltas)
   cCor     := 'R/W'
   cStatusB := 'REPROVADO FALTA'
   nDpCont  ++
   cDpB     := " " + cDisciplina2
elseif nMediaMin > nMediaB
      cStatusB := 'REPROVADO NOTA'
      cCor     := 'R/W'
      cCorNota := 'R/W'
      nDpCont  ++
      cDpB     := " " + cDisciplina2
Else
   cCor     := 'G/W'
   cCorNota := 'G/W'
   cStatusB := 'APROVADO'
endif

// Exibe o status e a media da segunda disciplina
@ 17,69 say AllTrim(Transform(nMediaB, "999.99")) Color(cCorNota)
@ 06,43 say AllTrim(cDisciplina2) + ":"
@ 06,60 say cStatusB Color(cCor)

// Zera as notas e faltas para reutilizar as variaveis na terceira disciplina
nNotaB1 := 0
nNotaB2 := 0
nNotaB3 := 0
nNotaB4 := 0

nFaltasB1 := 0
nFaltasB2 := 0
nFaltasB3 := 0
nFaltasB4 := 0

// Leitura das notas e faltas da terceira disciplina (4 bimestres)
@ 20,03 get cDisciplina3 picture '@!'  valid !Empty(cDisciplina3)
@ 20,17 get nNotaB1      picture '999' valid nNotaB1   >= 0 .and. nNotaB1   <= 100
@ 20,23 get nFaltasB1    picture '999' valid nFaltasB1 >= 0 .and. nFaltasB1 <= 60
@ 20,30 get nNotaB2      picture '999' valid nNotaB2   >= 0 .and. nNotaB2   <= 100
@ 20,36 get nFaltasB2    picture '999' valid nFaltasB2 >= 0 .and. nFaltasB2 <= 60
@ 20,43 get nNotaB3      picture '999' valid nNotaB3   >= 0 .and. nNotaB3   <= 100
@ 20,49 get nFaltasB3    picture '999' valid nFaltasB3 >= 0 .and. nFaltasB3 <= 60
@ 20,56 get nNotaB4      picture '999' valid nNotaB4   >= 0 .and. nNotaB4   <= 100
@ 20,62 get nFaltasB4    picture '999' valid nFaltasB4 >= 0 .and. nFaltasB4 <= 60
read

// Calcula a media da terceira disciplina
nMediaC := (nNotaB1 + nNotaB2 + nNotaB3 + nNotaB4) / 4

// Verifica o status da terceira disciplina
If (nFaltasB1 > nMaxFaltas .OR. nFaltasB2 > nMaxFaltas .OR. nFaltasB3 > nMaxFaltas .OR. nFaltasB4 > nMaxFaltas)
   cCor     := 'R/W'
   cStatusC := 'REPROVADO FALTA'
   nDpCont  ++
   cDpC     := " " + cDisciplina3
elseif nMediaMin > nMediaC
      cStatusC := 'REPROVADO NOTA'
      cCor     := 'R/W'
      cCorNota := 'R/W'
      nDpCont  ++
      cDpC     := " " + cDisciplina3
Else
   cCorNota := 'G/W'
   cCor     := 'G/W'
   cStatusC := 'APROVADO'
endif


// Exibe o status e a media da terceira disciplina
@ 20,69 say AllTrim(Transform(nMediaC, "999.99")) Color(cCorNota)
@ 07,43 say AllTrim(cDisciplina3) + ":"
@ 07,60 say cStatusC Color(cCor)

// Determina o status geral do aluno com base no numero de dependencias
if Empty(nDpCont)
   // Nenhuma dependencia: aprovado
   cStatusGeral := 'APROVADO'
elseif nDpCont > 0 .AND. nDpCont <= 2
      // 1 ou 2 dependencias: aprovado com DP, mensalidade acrescida 20% por DP
      cStatusGeral := "APROVADO COM DP(S)"
      nValorMensalidadeAtual := nValorMensalidade * ((0.20 * nDpCont) + 1)
      @ 23,03 say "MENSALIDADE ATUAL: " + AllTrim(TRANSFORM(nValorMensalidadeAtual, '@E 9,9999.99'))
    else
      // Mais de 2 dependencias: reprovado
      cStatusGeral := "REPROVADO"
endif

// Exibe o total de dependencias e o status geral
@ 08,43 say "DEPENDENCIAS: " + AllTrim(Str(nDpCont))
@ 04,50 say AllTrim(cStatusGeral)

// Aguarda o usuario pressionar qualquer tecla para encerrar
Inkey(0)