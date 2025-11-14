grammar Abismo;

/* ================= PARSER ================= */

inicio: comando* EOF;

//Comandos
comando
    : expressao FINAL
    | atribuicaoVar
    | declaracaoVar 
    | comandoSe
    | comandoEnquanto
    | comandoPara          
    | comandoFacaEnquanto  
    | bloco
    ;

//Inicialização e Atribuição direta da Variavel
declaracaoVar: tiposVar ID (ATRIBUICAO expressao)? FINAL;

//tipos de variaveis
tiposVar: CHAVE_INTEIRO | CHAVE_TEXTO | CHAVE_PROPOSICAO | CHAVE_DECIMAL;

//Bloco de comando
bloco: ABERTURACHAVE comando* FECHAMENTOCHAVE;

//Comando IF, aceitando outro if dentro
comandoSe: SE ABERTURAPARENTESES expressao FECHAMENTOPARENTESES comando (SENAO comando)?;

//Comando WHILE
comandoEnquanto: ENQUANTO ABERTURAPARENTESES expressao FECHAMENTOPARENTESES comando;

//Comando de atribuição da variavel pós declarada
atribuicaoVar: ID ATRIBUICAO expressao FINAL;

//Comando FOR
comandoPara: PARA ABERTURAPARENTESES expressao? FINAL expressao? FINAL expressao? FECHAMENTOPARENTESES comando;

//Comando DO-WHILE
comandoFacaEnquanto: FACA comando ENQUANTO ABERTURAPARENTESES expressao FECHAMENTOPARENTESES FINAL;

// Lista de argumento para PrintF
listaDeArgumentos: expressao (VIRGULA expressao)*;

//Terceira camada de prioridade de expressão.
expressao: term ( (OPSOMA | OPSUBTRAIR) term )*;
//Segunda camada de prioridade de expressão.
term: factor ( (OPMULTIPLICACAO | OPDIVISAO) factor )*;
//Primeira camada de prioridade e Dados primarios!
factor:
      INTEIRO
    | DECIMAL
    | TEXTO
    | VERDADEIRO
    | FALSO
    | ID (ABERTURAPARENTESES listaDeArgumentos? FECHAMENTOPARENTESES)?
    | ABERTURAPARENTESES expressao FECHAMENTOPARENTESES
    ;

/* ================= LEXER ================= */

// IDENTIFICADOR
ID: [§] [a-zA-Z0-9]*;

//LITERAL TEXTO(STRING)
TEXTO: '"' .*? '"';

// LITERAIS NUMERICOS
INTEIRO: [0-9]+;
DECIMAL: [0-9]+ ',' [0-9]+;

// LITERAIS BOOLEANOS
VERDADEIRO: 'verdadeiro';
FALSO: 'falso';

// =====PALAVRAS-CHAVE=====

//Palavras chave de comandos
SE: 'se';
SENAO: 'senao';
ENQUANTO: 'enquanto';
PARA: 'para';
FACA: 'faca';

//palavras chave de Tipificadores de variaveis
CHAVE_DECIMAL: 'qq';
CHAVE_INTEIRO: 'zz';
CHAVE_TEXTO: 'txt';
CHAVE_PROPOSICAO: 'proposicao';

// ======SÍMBOLOS=====

//Delimitadores
FINAL: ';';
VIRGULA: ',';
ABERTURAPARENTESES: '(';
FECHAMENTOPARENTESES: ')';
ABERTURACHAVE: '{';
FECHAMENTOCHAVE: '}';

//Operadores
ATRIBUICAO: '=';
OPSOMA: '+';
OPSUBTRAIR: '-';
OPMULTIPLICACAO: '*';
OPDIVISAO: '/';

// ESPAÇOS EM BRANCO
ESPACOEMBRANCO: [ \t\r\n]+ -> skip;
