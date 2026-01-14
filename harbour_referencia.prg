/*
================================================================================
GUIA DE REFERÊNCIA HARBOUR - DO BÁSICO AO AVANÇADO
================================================================================
Autor: Guia de Revisão
Data: Janeiro 2026
Descrição: Arquivo de referência com comandos Harbour comentados
================================================================================
*/

/*
================================================================================
1. COMANDOS BÁSICOS E DECLARAÇÕES
================================================================================
*/

// COMENTÁRIOS
// Comentário de linha única com //
/* Comentário de múltiplas linhas */
* Comentário no estilo xBase/Clipper
&& Comentário no estilo Clipper

// ESTRUTURA BÁSICA DE UM PROGRAMA
FUNCTION Main()
    ? "Olá, Mundo!"  // ? é usado para imprimir na tela
    RETURN NIL

// DECLARAÇÃO DE VARIÁVEIS
LOCAL nNumero := 10           // Variável local (escopo de função)
LOCAL cString := "Texto"      // Prefixo 'c' para Character
LOCAL lLogico := .T.          // Prefixo 'l' para Logical (.T. ou .F.)
LOCAL dData := Date()         // Prefixo 'd' para Date
LOCAL aArray := {}            // Prefixo 'a' para Array
LOCAL bBloco := {|| .T.}      // Prefixo 'b' para Block
LOCAL nValor                  // Variável sem inicialização (NIL)

PRIVATE xVariavel := "Private" // Variável privada (visível em toda pilha de chamadas)
PUBLIC xGlobal := "Pública"    // Variável pública (visível em todo programa)
STATIC sStatica := 0           // Variável estática (mantém valor entre chamadas)

MEMVAR xMemVar                 // Declara variável de memória (PRIVATE/PUBLIC)
FIELD cNome, nIdade            // Declara campos de tabela

/*
================================================================================
2. TIPOS DE DADOS
================================================================================
*/

// NUMERIC (Numérico)
LOCAL nInteiro := 100
LOCAL nDecimal := 123.45
LOCAL nCientifico := 1.5e10

// CHARACTER (String/Texto)
LOCAL cTexto := "Texto simples"
LOCAL cAspas := 'Com aspas simples'
LOCAL cLongo := "Texto " + "concatenado"
LOCAL cMultiLinha := "Linha1" + CRLF + "Linha2"  // CRLF = Chr(13)+Chr(10)

// LOGICAL (Lógico/Booleano)
LOCAL lVerdadeiro := .T.       // TRUE
LOCAL lFalso := .F.            // FALSE

// DATE (Data)
LOCAL dHoje := Date()          // Data atual
LOCAL dEspecifica := CToD("31/12/2025")  // Converte string para data
LOCAL dStrf := SToD("20251231")  // String formato AAAAMMDD para data

// ARRAY (Vetor/Matriz)
LOCAL aSimples := {1, 2, 3}
LOCAL aMisto := {100, "Texto", .T., Date()}
LOCAL aVazio := {}
LOCAL aMulti := {{1,2}, {3,4}}  // Array multidimensional

// CODEBLOCK (Bloco de Código)
LOCAL bSoma := {|x, y| x + y}
LOCAL bCondicao := {|| lVerdadeiro}

// OBJECT (Objeto)
LOCAL oObjeto := TClass():New()

// NIL (Nulo/Indefinido)
LOCAL xNulo := NIL

// HASH (Tabela Hash - Harbour específico)
LOCAL hTabela := {=>}
hTabela["chave"] := "valor"

/*
================================================================================
3. OPERADORES
================================================================================
*/

// OPERADORES ARITMÉTICOS
LOCAL nA := 10, nB := 3
nA + nB    // Adição (13)
nA - nB    // Subtração (7)
nA * nB    // Multiplicação (30)
nA / nB    // Divisão (3.33...)
nA % nB    // Módulo/Resto (1)
nA ^ nB    // Potenciação (1000)
nA ** nB   // Potenciação alternativa (1000)
++nA       // Pré-incremento
nA++       // Pós-incremento
--nA       // Pré-decremento
nA--       // Pós-decremento

// OPERADORES DE COMPARAÇÃO
nA == nB   // Igual a
nA = nB    // Igual a (alternativo)
nA != nB   // Diferente de
nA <> nB   // Diferente de (alternativo)
nA # nB    // Diferente de (alternativo)
nA > nB    // Maior que
nA < nB    // Menor que
nA >= nB   // Maior ou igual
nA <= nB   // Menor ou igual

// OPERADORES LÓGICOS
.T. .AND. .F.   // E lógico (retorna .F.)
.T. .OR. .F.    // OU lógico (retorna .T.)
.NOT. .T.       // NÃO lógico (retorna .F.)
!.T.            // NÃO lógico alternativo

// OPERADORES DE STRING
"AB" + "CD"     // Concatenação ("ABCD")
"AB" - "CD"     // Concatenação com trim ("ABCD")
"AB" $ "ABCD"   // Contido em (retorna .T.)

// OPERADOR DE ATRIBUIÇÃO
nA := 10        // Atribuição inline
nA += 5         // nA := nA + 5
nA -= 5         // nA := nA - 5
nA *= 5         // nA := nA * 5
nA /= 5         // nA := nA / 5

// OPERADOR MACRO
cVar := "nNumero"
&cVar := 100    // Expande para: nNumero := 100
?&cVar          // Imprime valor de nNumero

/*
================================================================================
4. ESTRUTURAS DE CONTROLE DE FLUXO
================================================================================
*/

// IF / ELSE / ELSEIF
IF nA > 10
    ? "Maior que 10"
ELSEIF nA == 10
    ? "Igual a 10"
ELSE
    ? "Menor que 10"
ENDIF

// IF inline (IIF - Immediate IF)
cResultado := IIF(nA > 10, "Maior", "Menor ou igual")

// DO CASE (Switch/Case)
DO CASE
CASE nA < 10
    ? "Menor que 10"
CASE nA == 10
    ? "Igual a 10"
CASE nA > 10
    ? "Maior que 10"
OTHERWISE
    ? "Outro caso"
ENDCASE

// FOR - Loop com contador
FOR nI := 1 TO 10
    ? "Iteração:", nI
NEXT nI

// FOR com STEP
FOR nI := 0 TO 100 STEP 10
    ? nI
NEXT

// WHILE - Loop com condição no início
nContador := 1
WHILE nContador <= 10
    ? nContador
    nContador++
ENDDO

// DO WHILE - Loop com condição no final (executa pelo menos uma vez)
nContador := 1
DO WHILE nContador <= 10
    ? nContador
    nContador++
ENDDO

// FOR EACH - Itera sobre elementos de array
LOCAL aLista := {1, 2, 3, 4, 5}
FOR EACH xItem IN aLista
    ? "Item:", xItem
    ? "Índice:", xItem:__enumIndex()
NEXT

// EXIT - Sai do loop
FOR nI := 1 TO 100
    IF nI == 50
        EXIT  // Sai do loop
    ENDIF
NEXT

// LOOP - Pula para próxima iteração
FOR nI := 1 TO 10
    IF nI == 5
        LOOP  // Pula para próxima iteração
    ENDIF
    ? nI
NEXT

// BEGIN SEQUENCE / RECOVER - Tratamento de erros
BEGIN SEQUENCE
    // Código que pode gerar erro
    nResultado := 10 / 0
RECOVER
    ? "Erro capturado!"
END SEQUENCE

/*
================================================================================
5. FUNÇÕES DE STRING (CARACTERES)
================================================================================
*/

// FUNÇÕES BÁSICAS
LOCAL cTexto := "  Harbour Programming  "

Len(cTexto)              // Retorna tamanho da string (24)
Upper(cTexto)            // Converte para MAIÚSCULAS
Lower(cTexto)            // Converte para minúsculas
AllTrim(cTexto)          // Remove espaços início e fim
LTrim(cTexto)            // Remove espaços à esquerda
RTrim(cTexto)            // Remove espaços à direita
Trim(cTexto)             // Equivalente a RTrim()

// BUSCA E SUBSTITUIÇÃO
At("Pro", cTexto)        // Retorna posição da substring (primeira ocorrência)
RAt("r", cTexto)         // Busca da direita para esquerda (última ocorrência)
SubStr(cTexto, 1, 5)     // Extrai substring (posição, tamanho)
Left(cTexto, 5)          // Retorna N caracteres à esquerda
Right(cTexto, 5)         // Retorna N caracteres à direita
StrTran(cTexto, "a", "X") // Substitui todas ocorrências ("a" por "X")
Stuff(cTexto, 3, 2, "XX") // Insere/substitui em posição específica

// PREENCHIMENTO
Space(10)                // Retorna string com N espaços
Replicate("*", 10)       // Repete caractere N vezes ("**********")
PadL(cTexto, 30)         // Preenche à esquerda até tamanho N
PadR(cTexto, 30)         // Preenche à direita até tamanho N
PadC(cTexto, 30)         // Centraliza preenchendo ambos lados

// CONVERSÃO
Val("123.45")            // String para número (123.45)
Str(123.45, 8, 2)        // Número para string (largura, decimais)
Transform(123.45, "@E 999,999.99")  // Formata número com máscara
Chr(65)                  // Código ASCII para caractere ("A")
Asc("A")                 // Caractere para código ASCII (65)

// VERIFICAÇÃO
IsAlpha(cTexto)          // Verifica se é alfabético
IsDigit(cTexto)          // Verifica se é dígito
IsUpper(cTexto)          // Verifica se está em maiúsculas
IsLower(cTexto)          // Verifica se está em minúsculas
Empty(cTexto)            // Verifica se está vazio

/*
================================================================================
6. FUNÇÕES DE DATA E HORA
================================================================================
*/

// FUNÇÕES DE DATA
LOCAL dData := Date()

Date()                   // Data atual do sistema
Year(dData)              // Retorna ano (2026)
Month(dData)             // Retorna mês (1-12)
Day(dData)               // Retorna dia (1-31)
DoW(dData)               // Dia da semana (1=Domingo, 7=Sábado)
CDoW(dData)              // Nome do dia da semana ("Monday")
CMonth(dData)            // Nome do mês ("January")

// CONVERSÃO DE DATA
DToS(dData)              // Data para string AAAAMMDD
SToD("20260113")         // String AAAAMMDD para data
DToC(dData)              // Data para string formato local (DD/MM/AAAA)
CToD("13/01/2026")       // String formato local para data

// OPERAÇÕES COM DATA
dData + 7                // Adiciona 7 dias
dData - 7                // Subtrai 7 dias
dData2 - dData1          // Diferença em dias entre duas datas

// FUNÇÕES DE HORA/TIMESTAMP
Time()                   // Hora atual "HH:MM:SS"
Seconds()                // Segundos desde meia-noite
DateTime()               // Data e hora atual (timestamp)
hb_DateTime()            // Data/hora atual (Harbour específico)
hb_TToC(tTimeStamp)      // Timestamp para string
hb_CToT("2026-01-13 10:30:00")  // String para timestamp
hb_Hour(tTimeStamp)      // Extrai hora
hb_Minute(tTimeStamp)    // Extrai minuto
hb_Second(tTimeStamp)    // Extrai segundo

/*
================================================================================
7. FUNÇÕES MATEMÁTICAS
================================================================================
*/

// FUNÇÕES BÁSICAS
Abs(-10)                 // Valor absoluto (10)
Int(123.45)              // Parte inteira (123)
Round(123.456, 2)        // Arredonda (123.46)
Sqrt(16)                 // Raiz quadrada (4)
Exp(2)                   // Exponencial e^2
Log(10)                  // Logaritmo natural
Max(10, 20, 30)          // Retorna maior valor (30)
Min(10, 20, 30)          // Retorna menor valor (10)

// TRIGONOMETRIA (em radianos)
Sin(1.5708)              // Seno
Cos(0)                   // Cosseno
Tan(0.7854)              // Tangente
ATan(1)                  // Arco tangente
hb_DToR(90)              // Graus para radianos
hb_RToD(1.5708)          // Radianos para graus

// FUNÇÕES ESPECIAIS
Mod(10, 3)               // Módulo (resto da divisão) (1)
hb_Random()              // Número aleatório entre 0 e 1
hb_RandomInt(1, 100)     // Inteiro aleatório no intervalo

/*
================================================================================
8. FUNÇÕES DE ARRAY
================================================================================
*/

LOCAL aArray := {10, 20, 30, 40, 50}

// CRIAÇÃO E ACESSO
Array(10)                // Cria array com 10 elementos NIL
aArray[1]                // Acessa primeiro elemento (base 1)
Len(aArray)              // Retorna tamanho do array (5)

// MANIPULAÇÃO
AAdd(aArray, 60)         // Adiciona elemento no final
AIns(aArray, 2)          // Insere posição (desloca demais)
ADel(aArray, 2)          // Marca para deletar (desloca para fim)
ASize(aArray, 10)        // Redimensiona array

// ORDENAÇÃO E BUSCA
ASort(aArray)            // Ordena array crescente
ASort(aArray, , , {|x,y| x > y})  // Ordena decrescente com bloco
AScan(aArray, 30)        // Busca valor, retorna posição
AScan(aArray, {|x| x > 25})  // Busca com condição (bloco)

// OPERAÇÕES
AEval(aArray, {|x| QOut(x)})  // Executa bloco para cada elemento
AClone(aArray)           // Copia array (clone raso)
AFill(aArray, 0)         // Preenche todos elementos com valor
ACopy(aSrc, aDest)       // Copia elementos de um array para outro

// ARRAYS MULTIDIMENSIONAIS
LOCAL aMatriz := Array(3, 4)  // Cria matriz 3x4
aMatriz[1][2] := 100          // Acessa elemento linha 1, coluna 2

// FUNÇÕES AVANÇADAS
hb_ATokens("a,b,c", ",") // Divide string em array {"a","b","c"}
hb_ValToExp(aArray)      // Converte array para string legível

/*
================================================================================
9. FUNÇÕES DE CONVERSÃO E TIPO
================================================================================
*/

// VERIFICAÇÃO DE TIPO
ValType(xVar)            // Retorna tipo: "C","N","L","D","A","B","O","U"
Type("cVariavel")        // Retorna tipo de variável por nome (string)

// VERIFICAÇÃO LÓGICA
IsNil(xVar)              // Verifica se é NIL
IsArray(xVar)            // Verifica se é array
IsBlock(xVar)            // Verifica se é codeblock
IsCharacter(xVar)        // Verifica se é string
IsDate(xVar)             // Verifica se é data
IsLogical(xVar)          // Verifica se é lógico
IsNumeric(xVar)          // Verifica se é número
IsObject(xVar)           // Verifica se é objeto
IsHash(xVar)             // Verifica se é hash

// CONVERSÃO
hb_NToS(123)             // Número para string
hb_SToN("123")           // String para número
hb_ValToStr(xVar)        // Qualquer tipo para string
hb_CStr(xVar)            // Converte para string (mais simples)

/*
================================================================================
10. ENTRADA E SAÍDA (I/O)
================================================================================
*/

// SAÍDA NA TELA
? "Texto"                // Imprime e pula linha (QOut)
?? "Texto"               // Imprime sem pular linha (QQOut)
QOut("Texto")            // Igual a ?
QQOut("Texto")           // Igual a ??
OutStd("Texto")          // Saída padrão (stdout)
OutErr("Erro")           // Saída de erro (stderr)

// ENTRADA DO USUÁRIO (Console)
cNome := Space(50)
@ 10, 10 SAY "Nome:" GET cNome
READ                     // Ativa leitura dos GETs

// ACEITAR ENTRADA SIMPLES
ACCEPT "Digite algo: " TO cVariavel
INPUT "Digite número: " TO nNumero
WAIT "Pressione tecla..."           // Espera tecla
cTecla := Inkey(0)                  // Aguarda e retorna código da tecla

// CONTROLE DE TELA
CLS                      // Limpa tela (Clear Screen)
SetPos(10, 20)           // Posiciona cursor (linha, coluna)
SetColor("W/B")          // Define cor (texto/fundo)
@ 5, 10 SAY "Texto"      // Imprime em posição específica
DevPos(10, 20)           // Posiciona cursor (alternativo)
DevOut("Texto")          // Imprime na posição atual

/*
================================================================================
11. PICTURE CLAUSES (MÁSCARAS DE FORMATAÇÃO)
================================================================================
*/

// PICTURE é usado em GETs para validação/formatação de entrada
// E com TRANSFORM() para formatação de saída

// MÁSCARAS NUMÉRICAS
@ 1, 1 SAY "Valor:" GET nValor PICTURE "999"        // 3 dígitos
@ 2, 1 SAY "Valor:" GET nValor PICTURE "999.99"     // Com decimais
@ 3, 1 SAY "Valor:" GET nValor PICTURE "9,999.99"   // Com separadores
@ 4, 1 SAY "Valor:" GET nValor PICTURE "9,999,999.99"  // Milhões

// MÁSCARAS COM SÍMBOLOS ESPECIAIS
@ 5, 1 SAY "Valor:" GET nValor PICTURE "$9,999.99"  // Com dólar
@ 6, 1 SAY "Valor:" GET nValor PICTURE "999.99 %"   // Porcentagem
@ 7, 1 SAY "Valor:" GET nValor PICTURE "-999.99"    // Sinal

// MÁSCARAS DE CARACTERES
@ 8, 1 SAY "Nome:" GET cNome PICTURE "XXXXXXXXXXXXX"  // Força maiúsculas
@ 9, 1 SAY "Email:" GET cEmail PICTURE "x"            // Minúsculas
@ 10, 1 SAY "Texto:" GET cTexto PICTURE "!"           // Força maiúsculas (alt)

// MÁSCARAS DE DATA
@ 11, 1 SAY "Data:" GET dData  "99/99/99"     // DD/MM/AA
@ 12, 1 SAY "Data:" GET dData PICTURE "99/99/9999"   // DD/MM/AAAA

// MÁSCARAS DE TELEFONE/CPF/CNPJ
@ 13, 1 SAY "Telefone:" GET cTelefone PICTURE "(99) 9999-9999"
@ 14, 1 SAY "CPF:" GET cCPF PICTURE "999.999.999-99"
@ 15, 1 SAY "CNPJ:" GET cCNPJ PICTURE "99.999.999/9999-99"

// MÁSCARAS MISTAS
@ 16, 1 SAY "Placa:" GET cPlaca PICTURE "AAA-9999"   // Letras e números
@ 17, 1 SAY "CEP:" GET cCEP PICTURE "99999-999"      // CEP formato

// PICTURE TEMPLATE CHARACTERS (caracteres de template)
// 9 - Apenas dígito (obrigatório)
// 0 - Dígito (preenche com 0 se espaço)
// # - Dígito ou espaço
// X - Qualquer caractere (força maiúscula)
// x - Qualquer caractere (força minúscula)
// A - Apenas letra (força maiúscula)
// a - Apenas letra (força minúscula)
// ! - Força maiúscula no caractere seguinte
// . , : - Separadores literais (inseridos automaticamente)
// ( ) [ ] - Parênteses/colchetes literais
// * - Preenchimento com asterisco
// - - Sinal de negativo

// USANDO COM TRANSFORM()
LOCAL nValor := 1234.56
LOCAL cTexto := "João Silva"
LOCAL dData := Date()

? Transform(nValor, "999.99")           // "234.56"
? Transform(nValor, "9,999.99")         // "1,234.56"
? Transform(nValor, "$9,999.99")        // "$1,234.56"
? Transform(cTexto, "XXXXXXXXXXXXX")    // "JOÃO SILVA"
? Transform(dData, "99/99/9999")        // "13/01/2026"

// USANDO COM @ SAY (formatação de saída)
@ 1, 1 SAY nValor PICTURE "9,999.99"   // Formata na tela
@ 2, 1 SAY cTexto PICTURE "XXXXXXXXXXXXX"
@ 3, 1 SAY dData PICTURE "99/99/9999"

// FUNÇÕES DE FORMATAÇÃO (alternativas)
Str(nValor, 8, 2)                      // Alternativa para números
PadR(cTexto, 30)                       // Alternativa para strings

// OPERADORES DE PICTURE (Harbour específico)
// @ prefix para funções especiais
// @ E para notação científica
// @ R para Roman numerals
// @ B para valores em branco (zero é branco)

? Transform(123.45, "@E 999,999.99")   // Notação científica
? Transform(1999, "@R")                // Número romano (MCMXCIX)
? Transform(0, "@B 9,999.99")          // Branco quando zero

// VALIDAÇÃO COM PICTURE EM GET
@ 20, 1 SAY "CPF (válido):" GET cCPF ;
   PICTURE "999.999.999-99" ;
   VALID ValidaCPF(cCPF) ;
   ERROR "CPF inválido"

FUNCTION ValidaCPF(cCPF)
   // Remove formatação
   LOCAL c := StrTran(StrTran(cCPF, ".", ""), "-", "")
   // Validação aqui...
   RETURN .T.

// PICTURE COM LÓGICO (CHECKBOX style)
@ 25, 1 SAY "Ativo:" GET lAtivo PICTURE "S/N"       // Sim/Não
@ 26, 1 SAY "Ativo:" GET lAtivo PICTURE "Y/N"       // Yes/No
@ 27, 1 SAY "Ativo:" GET lAtivo PICTURE "*"         // * para verdadeiro

// COMBINANDO MÚLTIPLAS OPÇÕES
@ 30, 1 SAY "Código:" GET nCodigo ;
   PICTURE "999999" ;
   RANGE 1, 999999 ;
   VALID nCodigo > 0 ;
   ERROR "Código deve ser entre 1 e 999999"

// PICTURE PRÉ-DEFINIDAS (alguns SETTs)
SET CURRENCY LEFT "R$ "   // Símbolo de moeda
SET THOUSANDSEP ","       // Separador de milhares
SET DECIMALSEP "."        // Separador decimal

/*
================================================================================
12. MANIPULAÇÃO DE ARQUIVOS TEXTO
================================================================================
*/

// ABERTURA E FECHAMENTO
LOCAL nHandle
nHandle := FOpen("arquivo.txt", FO_READ)  // Abre para leitura
nHandle := FCreate("novo.txt")             // Cria arquivo
FClose(nHandle)                            // Fecha arquivo

// MODOS DE ABERTURA (constantes)
// FO_READ      - Somente leitura
// FO_WRITE     - Somente escrita
// FO_READWRITE - Leitura e escrita
// FC_NORMAL    - Arquivo normal
// FC_READONLY  - Somente leitura

// LEITURA
cBuffer := Space(1024)
nBytes := FRead(nHandle, @cBuffer, 1024)   // Lê N bytes
cLinha := FReadStr(nHandle, 100)            // Lê até encontrar CR/LF

// ESCRITA
FWrite(nHandle, "Texto para gravar")       // Escreve no arquivo
FWrite(nHandle, cBuffer, Len(cBuffer))     // Escreve buffer

// POSICIONAMENTO
FSeek(nHandle, 0, FS_SET)      // Início (FS_SET = 0)
FSeek(nHandle, 0, FS_RELATIVE) // Relativo (FS_RELATIVE = 1)
FSeek(nHandle, 0, FS_END)      // Fim (FS_END = 2)

// INFORMAÇÕES
FError()                 // Código do último erro
FEof(nHandle)            // Verifica fim de arquivo
File("arquivo.txt")      // Verifica se arquivo existe
hb_FileExists("arq.txt") // Verifica existência (Harbour)

// OPERAÇÕES DE ARQUIVO
FErase("arquivo.txt")    // Apaga arquivo
FRename("old.txt", "new.txt")  // Renomeia arquivo
hb_FileDelete("arq.txt") // Apaga arquivo (Harbour)

// FUNÇÕES DE ALTO NÍVEL
MemoRead("arquivo.txt")  // Lê arquivo inteiro para string
MemoWrit("arq.txt", cConteudo)  // Grava string em arquivo

// DIRETÓRIOS
Directory("*.prg")       // Lista arquivos (retorna array)
DirChange("C:\pasta")    // Muda diretório atual
MakeDir("novapasta")     // Cria diretório
CurDir()                 // Diretório atual
hb_DirSepAdd("C:\pasta") // Adiciona separador se necessário

/*
================================================================================
12. BANCO DE DADOS (DBF/RDD)
================================================================================
*/

// ABERTURA E FECHAMENTO
USE clientes             // Abre tabela (área atual)
USE clientes NEW         // Abre em nova área
USE clientes ALIAS cli   // Abre com alias
USE clientes SHARED      // Abre compartilhado
USE clientes EXCLUSIVE   // Abre exclusivo
USE                      // Fecha tabela da área atual
CLOSE ALL                // Fecha todas tabelas

// SELEÇÃO DE ÁREA
SELECT 1                 // Seleciona área de trabalho
SELECT clientes          // Seleciona por alias
SELECT(0)                // Retorna próxima área livre

// NAVEGAÇÃO
GO TOP                   // Vai para primeiro registro
GO BOTTOM                // Vai para último registro
GO 100                   // Vai para registro número 100
SKIP                     // Avança um registro
SKIP -1                  // Retrocede um registro
SKIP 5                   // Avança 5 registros

// INFORMAÇÕES
RecNo()                  // Número do registro atual
RecCount()               // Total de registros
Eof()                    // Fim do arquivo (End Of File)
Bof()                    // Início do arquivo (Begin Of File)
Deleted()                // Verifica se registro está deletado
DbInfo(DBI_ISDBF)        // Informações do banco

// CAMPOS
FieldName(1)             // Nome do campo 1
FieldPos("NOME")         // Posição do campo NOME
FieldGet(1)              // Valor do campo 1
FieldPut(1, "Valor")     // Atribui valor ao campo 1
FCount()                 // Número de campos

// ACESSO A DADOS
clientes->nome           // Acessa campo da área clientes
FIELD->nome              // Acessa campo da área atual
M->nome                  // Acessa variável memória

// MODIFICAÇÃO
APPEND BLANK             // Adiciona registro vazio
DbAppend()               // Adiciona registro (função)
REPLACE nome WITH "João" // Substitui valor do campo
DbDelete()               // Marca registro para deleção
DELETE                   // Marca registro para deleção
RECALL                   // Desmarca deleção
DbRecall()               // Desmarca deleção (função)
PACK                     // Remove registros deletados fisicamente
ZAP                      // Apaga todos registros

// BUSCA E FILTRO
LOCATE FOR idade > 18    // Localiza primeiro registro
CONTINUE                 // Continua localização
SEEK "João"              // Busca em índice
DbSeek("João")           // Busca em índice (função)
SET FILTER TO idade > 18 // Define filtro
DbSetFilter({|| idade > 18})  // Define filtro (função)

// ÍNDICES
INDEX ON nome TO idx_nome              // Cria índice
SET INDEX TO idx_nome                  // Ativa índice
SET ORDER TO 1                         // Define ordem de índice
OrdListAdd("indice.ntx")              // Adiciona índice à lista
OrdSetFocus(1)                        // Define índice ativo
OrdKey()                              // Expressão de índice
OrdFor()                              // Condição FOR do índice

// ESTRUTURA
DbStruct()               // Retorna estrutura (array)
DbCreate("nova.dbf", aStruct)  // Cria nova tabela

// BLOQUEIO (Multi-usuário)
RLock()                  // Trava registro
FLock()                  // Trava arquivo inteiro
DbUnlock()               // Destrava
DbCommit()               // Força gravação em disco

// RELAÇÕES
SET RELATION TO codigo INTO pedidos  // Define relação

// LOOPS EM BANCO
DO WHILE !Eof()
    ? clientes->nome
    SKIP
ENDDO

DbEval({|| QOut(nome)})  // Executa bloco para cada registro

/*
================================================================================
13. HASH (TABELAS HASH - Harbour)
================================================================================
*/

// CRIAÇÃO
LOCAL hDados := {=>}                     // Hash vazio
LOCAL hPessoa := {"nome"=>"João", "idade"=>30}  // Com dados

// ACESSO
hPessoa["nome"]          // Acessa valor pela chave
hPessoa["idade"] := 31   // Atribui valor

// MANIPULAÇÃO
hb_HSet(hDados, "chave", "valor")  // Define par chave/valor
hb_HGet(hDados, "chave")           // Obtém valor
hb_HDel(hDados, "chave")           // Remove chave
hb_HHasKey(hDados, "chave")        // Verifica se chave existe
hb_HKeys(hDados)                   // Array com todas chaves
hb_HValues(hDados)                 // Array com todos valores
hb_HPos(hDados, "chave")           // Posição da chave

// ITERAÇÃO
FOR EACH cKey IN hb_HKeys(hDados)
    ? cKey, hDados[cKey]
NEXT

hb_HEval(hDados, {|k,v| QOut(k,v)})  // Executa bloco para cada par

// FUNÇÕES ÚTEIS
Len(hDados)              // Número de elementos
hb_HClone(hDados)        // Clona hash
hb_HMerge(hDest, hSrc)   // Mescla dois hashes

/*
================================================================================
14. CODEBLOCKS (BLOCOS DE CÓDIGO)
================================================================================
*/

// CRIAÇÃO
LOCAL bSoma := {|x, y| x + y}           // Com parâmetros
LOCAL bMsg := {|| Alert("Olá")}         // Sem parâmetros
LOCAL bMulti := {|x| x := x * 2, x + 5} // Múltiplas expressões

// EXECUÇÃO
Eval(bSoma, 10, 20)      // Executa bloco (retorna 30)
bSoma:Eval(10, 20)       // Sintaxe alternativa
&("{|| Alert('Macro')}")  // Executa via macro

// DETACHED LOCALS (variáveis locais persistentes)
LOCAL bContador := (LOCAL n := 0, {|| n++})
Eval(bContador)          // 0
Eval(bContador)          // 1
Eval(bContador)          // 2

// APLICAÇÕES COMUNS
ASort(aArray, , , {|x,y| x > y})       // Ordenação customizada
DbEval({|| Replace nome WITH Upper(nome)})  // Operação em registros
AEval(aArray, {|x,i| aArray[i] *= 2})  // Modificação de array

/*
================================================================================
15. PROGRAMAÇÃO ORIENTADA A OBJETOS (POO)
================================================================================
*/

// DEFINIÇÃO DE CLASSE (estilo Harbour)
CLASS Pessoa

   DATA nome              // Atributo público
   DATA idade
   PROTECTED:
   DATA cpf              // Atributo protegido
   
   METHOD New(cNome, nIdade)  CONSTRUCTOR  // Construtor
   METHOD Aniversario()                     // Método
   METHOD GetIdade() INLINE ::idade        // Método inline
   
ENDCLASS

// IMPLEMENTAÇÃO DOS MÉTODOS
METHOD New(cNome, nIdade) CLASS Pessoa
   ::nome := cNome
   ::idade := nIdade
   RETURN Self

METHOD Aniversario() CLASS Pessoa
   ::idade++
   RETURN ::idade

// USO DA CLASSE
LOCAL oPessoa := Pessoa():New("João", 30)
? oPessoa:nome           // Acessa atributo
? oPessoa:idade
oPessoa:Aniversario()    // Chama método
? oPessoa:GetIdade()     // Método inline

// HERANÇA
CLASS Funcionario FROM Pessoa
   DATA salario
   DATA cargo
   METHOD New(cNome, nIdade, nSalario, cCargo)
   METHOD AumentarSalario(nPercentual)
ENDCLASS

METHOD New(cNome, nIdade, nSalario, cCargo) CLASS Funcionario
   ::Super:New(cNome, nIdade)  // Chama construtor da classe pai
   ::salario := nSalario
   ::cargo := cCargo
   RETURN Self

METHOD AumentarSalario(nPercentual) CLASS Funcionario
   ::salario *= (1 + nPercentual/100)
   RETURN ::salario

// CLASSE COM DADOS DE CLASSE (compartilhados)
CLASS Empresa
   CLASSDATA aFuncionarios INIT {}  // Compartilhado entre instâncias
   DATA nome
ENDCLASS

// OPERADOR WITH OBJECT
WITH OBJECT oPessoa
   :nome := "Maria"
   :idade := 25
   :Aniversario()
END

/*
================================================================================
16. FUNÇÕES DEFINIDAS PELO USUÁRIO
================================================================================
*/

// FUNÇÃO SIMPLES
FUNCTION MinhaFuncao()
   RETURN "Resultado"

// FUNÇÃO COM PARÂMETROS
FUNCTION Somar(nA, nB)
   RETURN nA + nB

// FUNÇÃO COM PARÂMETROS OPCIONAIS
FUNCTION Calcular(nA, nB, cOp)
   LOCAL nResultado
   
   IF cOp == NIL          // Parâmetro opcional
      cOp := "+"
   ENDIF
   
   DO CASE
   CASE cOp == "+"
      nResultado := nA + nB
   CASE cOp == "-"
      nResultado := nA - nB
   CASE cOp == "*"
      nResultado := nA * nB
   CASE cOp == "/"
      nResultado := nA / nB
   ENDCASE
   
   RETURN nResultado

// FUNÇÃO COM PARÂMETROS POR REFERÊNCIA
FUNCTION Trocar(cVar1, cVar2)
   LOCAL cTemp := cVar1
   cVar1 := cVar2
   cVar2 := cTemp
   RETURN NIL

// Uso:
cA := "A"
cB := "B"
Trocar(@cA, @cB)  // @ passa por referência

// PARÂMETROS VARIÁVEIS
FUNCTION Somar2(...)
   LOCAL nSoma := 0
   LOCAL xParam
   
   FOR EACH xParam IN hb_AParams()  // Array com todos parâmetros
      nSoma += xParam
   NEXT
   
   RETURN nSoma

? Somar2(1, 2, 3, 4, 5)  // Retorna 15

// PROCEDURE (não retorna valor)
PROCEDURE MostraMensagem(cMsg)
   Alert(cMsg)
   RETURN

// FUNÇÕES ESTÁTICAS (privadas ao arquivo)
STATIC FUNCTION FuncaoPrivada()
   RETURN "Só visível neste arquivo"

// PARÂMETROS
PCount()                 // Retorna número de parâmetros recebidos
hb_PValue(1)             // Retorna valor do parâmetro N
hb_AParams()             // Array com todos parâmetros

/*
================================================================================
17. TRATAMENTO DE ERROS
================================================================================
*/

// BEGIN SEQUENCE (tratamento estruturado)
BEGIN SEQUENCE
   nResultado := 10 / 0
   Break("Erro de divisão")  // Dispara erro
RECOVER
   ? "Erro capturado!"
END SEQUENCE

// TRY/CATCH (Harbour)
TRY
   nResultado := 10 / 0
CATCH oError
   ? "Erro:", oError:Description
   ? "Operação:", oError:Operation
END

// ERRORBLOCK (manipulador global de erros)
ErrorBlock({|oErr| MinhaFuncaoErro(oErr)})

FUNCTION MinhaFuncaoErro(oErr)
   ? "ERRO!"
   ? "Descrição:", oErr:Description
   ? "Operação:", oErr:Operation
   ? "Subsistema:", oErr:SubSystem
   QUIT
   RETURN NIL

// CRIANDO ERRO PERSONALIZADO
LOCAL oErr := ErrorNew()
oErr:SubSystem   := "MYAPP"
oErr:Description := "Erro personalizado"
oErr:Operation   := "MinhaFuncao"
Eval(ErrorBlock(), oErr)  // Dispara erro

/*
================================================================================
18. PRÉ-PROCESSADOR E DIRETIVAS
================================================================================
*/

// DEFINIÇÃO DE CONSTANTES
#define VERSAO "1.0.0"
#define PI 3.14159
#define MAX_REGISTROS 1000

// USO
? "Versão:", VERSAO

// MACROS COM PARÂMETROS
#define MAIOR(x,y) IIF((x)>(y), (x), (y))
? MAIOR(10, 20)  // Expande para: IIF((10)>(20), (10), (20))

// COMANDOS PERSONALIZADOS
#command PRINT <msg> => QOut(<msg>)
PRINT "Olá"  // Expande para: QOut("Olá")

// TRADUÇÕES
#xtranslate RGB(<r>,<g>,<b>) => ((<r>)*65536 + (<g>)*256 + (<b>))

// INCLUSÃO DE ARQUIVOS
#include "comum.ch"      // Inclui arquivo de header
#include "setcurs.ch"    // Headers do sistema

// COMPILAÇÃO CONDICIONAL
#ifdef __PLATFORM__WINDOWS
   ? "Windows"
#else
   ? "Outro SO"
#endif

#ifndef VERSAO
   #define VERSAO "0.0.1"
#endif

// DIRETIVAS DE CONTROLE
#pragma __cstream | __streaminclude  // Controla streams
#pragma __binarystreaminclude        // Binary streams

/*
================================================================================
19. COMANDOS DE SISTEMA E AMBIENTE
================================================================================
*/

// SISTEMA OPERACIONAL
OS()                     // Retorna nome do SO
hb_OSNewLine()           // Retorna separador de linha do SO
Version()                // Versão do Harbour

// AMBIENTE
GetEnv("PATH")           // Obtém variável de ambiente
hb_GetEnv("HOME")        // Harbour específico
SetEnv("VAR", "valor")   // Define variável (nem todos SOs)

// EXECUTAR PROGRAMAS EXTERNOS
__Run("dir")             // Executa comando do SO
hb_Run("programa.exe")   // Executa programa
hb_ProcessRun("cmd.exe") // Mais controle sobre processo

// MEMÓRIA
Memory(0)                // Memória disponível
Memory(1)                // Memória usada
hb_GCAll()               // Força garbage collection

// TEMPO
hb_MilliSeconds()        // Milissegundos desde boot
hb_IdleState()           // Estado idle do sistema
hb_IdleSleep(1)          // Pausa por N segundos

// INFORMAÇÕES DO PROGRAMA
ProcName()               // Nome da função atual
ProcLine()               // Linha atual
ProcFile()               // Arquivo atual

/*
================================================================================
20. FUNÇÕES DE REDE E MULTI-USUÁRIO
================================================================================
*/

// CONTROLE DE REDE
NetUse("clientes", .T., 10, "cli")  // Abre com tentativas
NetAppend()              // Append com bloqueio
NetErr()                 // Verifica erro de rede
IsLocked()               // Verifica se está bloqueado

// BLOQUEIO COM TIMEOUT
IF !RLock()
   ? "Não foi possível bloquear"
ENDIF

// NOME DO USUÁRIO/ESTAÇÃO
NetName()                // Nome da estação

/*
================================================================================
21. CONVERSÕES ESPECIAIS E UTILITÁRIOS
================================================================================
*/

// BIT OPERATIONS (Harbour)
hb_BitAnd(255, 128)      // E binário
hb_BitOr(128, 64)        // OU binário
hb_BitXor(255, 128)      // XOR binário
hb_BitNot(255)           // NOT binário
hb_BitShift(16, 2)       // Deslocamento de bits

// BASE64
hb_Base64Encode(cData)   // Codifica para Base64
hb_Base64Decode(cBase64) // Decodifica de Base64

// CRC E HASH
hb_CRC32(cData)          // Calcula CRC32
hb_MD5(cData)            // Hash MD5
hb_SHA1(cData)           // Hash SHA1
hb_SHA256(cData)         // Hash SHA256

// COMPRESSÃO
hb_ZCompress(cData)      // Comprime com zlib
hb_ZUncompress(cComp)    // Descomprime

// JSON
hb_JsonEncode(xValue)    // Converte para JSON
hb_JsonDecode(cJson)     // Converte de JSON

// XML (com biblioteca apropriada)
// Requer #include "hbxml.ch" e linking apropriado

/*
================================================================================
22. EXPRESSÕES REGULARES (Harbour)
================================================================================
*/

// USANDO PCRE
LOCAL cTexto := "Email: teste@exemplo.com"
LOCAL cPadrao := "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b"

// Verifica se há match
IF hb_RegExMatch(cPadrao, cTexto, .T.)  // .T. = case insensitive
   ? "Email encontrado!"
ENDIF

// Extrai matches
aMatches := hb_RegExAll(cPadrao, cTexto, .T.)

// Substitui
cNovo := hb_RegExReplace(cPadrao, cTexto, "***@***.***")

/*
================================================================================
23. INTERFACE GRÁFICA (GUI)
================================================================================
*/

// Harbour suporta várias bibliotecas GUI:
// - GTWVG (Windows)
// - HBQT (Qt)
// - HWGUI
// - MiniGUI
// - FiveWin

// Exemplo conceitual (sintaxe varia por biblioteca):
/*
#include "hwgui.ch"

FUNCTION Main()
   LOCAL oMainWindow
   
   INIT WINDOW oMainWindow MAIN ;
      TITLE "Minha Aplicação" ;
      AT 0,0 SIZE 800,600
   
   @ 20, 20 BUTTON "Clique Aqui" SIZE 100, 30 ;
      ON CLICK {|| MsgInfo("Botão clicado!")}
   
   ACTIVATE WINDOW oMainWindow
   
   RETURN NIL
*/

/*
================================================================================
24. SQL E BANCO DE DADOS MODERNOS
================================================================================
*/

// Com RDD apropriado (ex: SQLRDD, ADORDD)
/*
#include "sqlrdd.ch"

FUNCTION Main()
   LOCAL nConnection
   
   // Conecta ao banco
   nConnection := SR_AddConnection(CONNECT_ODBC, ;
      "DSN=MeuBanco;UID=usuario;PWD=senha")
   
   IF nConnection < 0
      ? "Erro na conexão"
      RETURN NIL
   ENDIF
   
   SR_SetActiveConnection(nConnection)
   
   // Executa SQL
   USE "SELECT * FROM clientes WHERE idade > 18" VIA "SQLRDD" ALIAS qry
   
   DO WHILE !Eof()
      ? qry->nome, qry->idade
      SKIP
   ENDDO
   
   CLOSE ALL
   SR_EndConnection(nConnection)
   
   RETURN NIL
*/

/*
================================================================================
25. THREADS E PROCESSAMENTO PARALELO (Harbour)
================================================================================
*/

// Harbour suporta threads nativas
/*
LOCAL hThread
LOCAL xResult

// Cria thread
hThread := hb_ThreadStart(@MinhaFuncao(), "parametro")

// Aguarda thread terminar
hb_ThreadWait(hThread, @xResult)

? "Resultado:", xResult

// FUNÇÃO QUE RODA NA THREAD
FUNCTION MinhaFuncao(cParam)
   // Processamento...
   RETURN "Resultado do processamento"
*/

// MUTEX (controle de concorrência)
/*
LOCAL hMutex := hb_MutexCreate()

hb_MutexLock(hMutex)
// Seção crítica
hb_MutexUnlock(hMutex)
*/

/*
================================================================================
26. COMUNICAÇÃO DE REDE
================================================================================
*/

// SOCKETS TCP/IP
/*
#include "hbsocket.ch"

LOCAL hSocket

// Cliente TCP
hSocket := hb_socketOpen()
IF hb_socketConnect(hSocket, "servidor.com", 8080)
   hb_socketSend(hSocket, "GET / HTTP/1.0" + CRLF + CRLF)
   cResposta := hb_socketRecv(hSocket)
   ? cResposta
ENDIF
hb_socketClose(hSocket)

// Servidor TCP
hSocket := hb_socketOpen()
hb_socketBind(hSocket, "0.0.0.0", 8080)
hb_socketListen(hSocket)
hClient := hb_socketAccept(hSocket)
// Processa cliente...
*/

// HTTP CLIENT (simples)
/*
#include "hbcurl.ch"

LOCAL cURL := "https://api.exemplo.com/dados"
LOCAL cResponse := hb_UrlGetStr(cURL)
? cResponse
*/

/*
================================================================================
27. COMANDOS SET (CONFIGURAÇÕES)
================================================================================
*/

SET ALTERNATE ON           // Ativa log alternativo
SET ALTERNATE TO "log.txt" // Define arquivo de log
SET BELL OFF               // Desliga beep
SET CENTURY ON             // Mostra século em datas (4 dígitos)
SET COLOR TO "W/B"         // Define cores
// CORES (COLOR / SetColor)
// Formato básico: "FG/BG" onde FG=cor do texto (foreground) e BG=cor do fundo (background)
// Cores comuns: N=Preto, W=Branco, R=Vermelho, G=Verde, B=Azul, Y=Amarelo, C=Ciano, M=Magenta
// Intensidade (quando suportado): use "+" para brilho no texto, ex.: "W+/B", "R+/N" (depende da GT/terminal)
// Paleta: SET COLOR TO também aceita uma lista separada por vírgulas para definir uma paleta
// Ex.: SET COLOR TO "W/N, N/W, G/N, R+/N"  // pares 1..4 da paleta
// Uso dinâmico: SetColor("FG/BG") altera a cor atual e retorna a cor anterior
// Exemplo de alternância de cor em tempo de execução:
// LOCAL cOld := SetColor("N/W")
// @ 1, 1 SAY "Preto sobre branco"
// SetColor("G/N")
// @ 2, 1 SAY "Verde sobre preto"
// SetColor(cOld)  // Restaura a cor anterior
SET CONFIRM ON             // Confirma saída de GET
SET CONSOLE OFF            // Desliga output no console
SET DATE BRITISH           // Formato DD/MM/YYYY
SET DECIMALS TO 2          // Casas decimais padrão
SET DELETED ON             // Ignora registros deletados
SET DEVICE TO PRINTER      // Direciona output para impressora
SET EXACT ON               // Comparação exata de strings
SET EXCLUSIVE OFF          // Abre arquivos compartilhados
SET FILTER TO idade > 18   // Filtro de registros
SET INDEX TO idx1, idx2    // Define índices ativos
SET PATH TO "C:\dados"     // Path de busca
SET PRINTER TO "LPT1"      // Define impressora
SET RELATION TO...         // Define relações entre tabelas
SET SOFTSEEK ON            // Seek parcial

// OBTER CONFIGURAÇÕES
? Set(_SET_CENTURY)        // Retorna configuração
? Set(_SET_DATE)

/*
================================================================================
28. DEBUGGING E PROFILING
================================================================================
*/

// ALTD() - Ativa debugger
ALTD()                     // Break point manual

// DEBUGGING CONDICIONAL
#ifdef DEBUG
   ? "Modo debug"
#endif

// TRACER
SET TRACE ON               // Ativa trace
__TraceLog("Mensagem")     // Log de trace

// ASSERT
#ifdef DEBUG
   hb_Assert(nValor > 0, "Valor deve ser positivo")
#endif

// PROFILING
// Compilar com flags apropriadas

/*
================================================================================
29. RECURSOS AVANÇADOS HARBOUR
================================================================================
*/

// DYNAMIC SYMBOLS (símbolos dinâmicos)
xResult := &("MinhaFuncao")(param1, param2)  // Chama função por nome
xResult := hb_DynCall("MinhaFuncao", param1) // Alternativa

// GARBAGE COLLECTOR
hb_GCAll()                 // Força coleta
hb_GCStep()                // Um passo de coleta

// VALORES DEFAULT
hb_Default(@xVar, valorDefault)  // Se xVar for NIL, atribui default

// SWITCH/CASE (Harbour)
SWITCH nOpcao
CASE 1
   ? "Um"
   EXIT
CASE 2
   ? "Dois"
   EXIT
OTHERWISE
   ? "Outro"
END

// HB_SYMBOL_UNUSED - Evita warning de variável não usada
FUNCTION Test(xParam)
   HB_SYMBOL_UNUSED(xParam)
   RETURN NIL

/*
================================================================================
30. BOAS PRÁTICAS E CONVENÇÕES
================================================================================
*/

/*
NOMENCLATURA (Convenção Húngara):
- cPrefix para Character/String  (cNome, cEndereco)
- n Prefix para Numeric           (nIdade, nSalario)
- l Prefix para Logical           (lAtivo, lConfirma)
- d Prefix para Date              (dNascimento, dCadastro)
- a Prefix para Array             (aLista, aDados)
- b Prefix para codeBlock         (bAcao, bFiltro)
- o Prefix para Object            (oCliente, oJanela)
- h Prefix para Hash              (hDados, hConfig)
- x Prefix para tipo variável     (xValor, xParam)
- m-> ou M-> para variáveis mem   (m->nome)

ESCOPO:
- Prefira LOCAL sempre que possível
- Evite PUBLIC (poluição global)
- Use STATIC para funções/vars privadas ao módulo
- Use PRIVATE apenas quando necessário (pilha)

ESTILO:
- Indentação consistente (3 ou 4 espaços)
- Comentários em português ou inglês (consistente)
- Nomes descritivos
- Funções pequenas e focadas
- DRY - Don't Repeat Yourself

PERFORMANCE:
- Use índices apropriados
- Evite LOCATE/FOR sem necessidade (use SEEK)
- Feche arquivos/conexões
- Libere recursos
- Use codeblocks para operações repetitivas

SEGURANÇA:
- Valide inputs
- Trate erros apropriadamente
- Bloqueie registros antes de alterar
- Use transações quando disponível
*/

/*
================================================================================
31. EXEMPLOS PRÁTICOS COMPLETOS
================================================================================
*/

// EXEMPLO 1: CRUD SIMPLES
FUNCTION ExemploCRUD()
   LOCAL nOpcao := 0
   
   // Cria tabela se não existe
   IF !File("cadastro.dbf")
      DbCreate("cadastro.dbf", {;
         {"CODIGO",   "N",  6, 0},;
         {"NOME",     "C", 50, 0},;
         {"EMAIL",    "C", 50, 0},;
         {"ATIVO",    "L",  1, 0},;
         {"CADASTRO", "D",  8, 0}})
   ENDIF
   
   USE cadastro EXCLUSIVE
   
   DO WHILE nOpcao != 5
      CLS
      ? "1 - Incluir"
      ? "2 - Alterar"
      ? "3 - Excluir"
      ? "4 - Listar"
      ? "5 - Sair"
      ?
      nOpcao := 0
      @ 10, 0 SAY "Opção:" GET nOpcao PICTURE "9"
      READ
      
      DO CASE
      CASE nOpcao == 1
         Incluir()
      CASE nOpcao == 2
         Alterar()
      CASE nOpcao == 3
         Excluir()
      CASE nOpcao == 4
         Listar()
      ENDCASE
   ENDDO
   
   CLOSE ALL
   RETURN NIL

STATIC FUNCTION Incluir()
   LOCAL nCodigo := 0, cNome := Space(50), cEmail := Space(50)
   LOCAL lAtivo := .T.
   
   DbGoBottom()
   nCodigo := IIF(Eof(), 1, CODIGO + 1)
   
   @ 2, 0 SAY "Código:" GET nCodigo PICTURE "999999" WHEN .F.
   @ 3, 0 SAY "Nome..:" GET cNome
   @ 4, 0 SAY "Email.:" GET cEmail
   @ 5, 0 SAY "Ativo.:" GET lAtivo
   READ
   
   IF !Empty(cNome)
      APPEND BLANK
      REPLACE CODIGO   WITH nCodigo,;
              NOME     WITH cNome,;
              EMAIL    WITH cEmail,;
              ATIVO    WITH lAtivo,;
              CADASTRO WITH Date()
      ? "Registro incluído!"
   ENDIF
   
   WAIT
   RETURN NIL

STATIC FUNCTION Listar()
   GO TOP
   DO WHILE !Eof()
      ? CODIGO, NOME, EMAIL, IIF(ATIVO, "Sim", "Não")
      SKIP
   ENDDO
   WAIT
   RETURN NIL

// EXEMPLO 2: PROCESSAMENTO DE ARQUIVO TEXTO
FUNCTION ProcessarArquivo()
   LOCAL cArquivo := "dados.txt"
   LOCAL cConteudo, aLinhas, cLinha
   LOCAL nTotal := 0
   
   IF !File(cArquivo)
      ? "Arquivo não encontrado"
      RETURN NIL
   ENDIF
   
   cConteudo := MemoRead(cArquivo)
   aLinhas := hb_ATokens(cConteudo, CRLF)
   
   FOR EACH cLinha IN aLinhas
      IF !Empty(cLinha)
         ? "Linha", cLinha:__enumIndex(), ":", cLinha
         nTotal++
      ENDIF
   NEXT
   
   ? "Total de linhas:", nTotal
   RETURN NIL

// EXEMPLO 3: CLASSE COM HERANÇA
CLASS Veiculo
   DATA marca
   DATA modelo
   DATA ano
   
   METHOD New(c1, c2, n1) CONSTRUCTOR
   METHOD Descricao()
ENDCLASS

METHOD New(cMarca, cModelo, nAno) CLASS Veiculo
   ::marca := cMarca
   ::modelo := cModelo
   ::ano := nAno
   RETURN Self

METHOD Descricao() CLASS Veiculo
   RETURN ::marca + " " + ::modelo + " (" + Str(::ano) + ")"

CLASS Carro FROM Veiculo
   DATA portas
   METHOD New(c1, c2, n1, n2)
ENDCLASS

METHOD New(cMarca, cModelo, nAno, nPortas) CLASS Carro
   ::Super:New(cMarca, cModelo, nAno)
   ::portas := nPortas
   RETURN Self

/*
================================================================================
FIM DO GUIA DE REFERÊNCIA HARBOUR
================================================================================
Este arquivo contém os principais comandos e conceitos do Harbour.
Para mais informações, consulte a documentação oficial em:
https://harbour.github.io/

COMPILAÇÃO:
hbmk2 arquivo.prg     - Compila e gera executável
harbour arquivo.prg   - Apenas compila para C
hbmk2 -gh arquivo.prg - Gera arquivo .ppo (preprocessado)

RECURSOS ADICIONAIS:
- Harbour Wiki: https://github.com/harbour/core/wiki
- Forum: https://groups.google.com/g/harbour-users
- Exemplos: pasta tests/ no repositório do Harbour
================================================================================
*/
