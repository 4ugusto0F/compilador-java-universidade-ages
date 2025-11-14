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

// Regra para declaração de variável
declaracaoVar: tiposVar ID (ATRIBUICAO expressao)? FINAL;

// Regra TYPES
tiposVar: CHAVE_INTEIRO | CHAVE_TEXTO | CHAVE_PROPOSICAO | CHAVE_DECIMAL;

bloco: ABERTURACHAVE comando* FECHAMENTOCHAVE;
comandoSe: SE ABERTURAPARENTESES expressao FECHAMENTOPARENTESES comando (SENAO comando)?;
comandoEnquanto: ENQUANTO ABERTURAPARENTESES expressao FECHAMENTOPARENTESES comando;
atribuicaoVar: ID ATRIBUICAO expressao FINAL;

// Regra FOR
comandoPara: PARA ABERTURAPARENTESES expressao? FINAL expressao? FINAL expressao? FECHAMENTOPARENTESES comando;

// Regra DO WHILE
comandoFacaEnquanto: FACA comando ENQUANTO ABERTURAPARENTESES expressao FECHAMENTOPARENTESES FINAL;

expressao: term ( (OPSOMA | OPSUBTRAIR) term )*;
term: factor ( (OPMULTIPLICACAO | OPDIVISAO) factor )*;
factor:
      INTEIRO
    | DECIMAL
    | TEXTO
    | VERDADEIRO
    | FALSO
    | ID
    | ABERTURAPARENTESES expressao FECHAMENTOPARENTESES
    ;

/* ================= LEXER ================= */

// PALAVRAS-CHAVE E TIPOS
SE: 'se';
SENAO: 'senao';
ENQUANTO: 'enquanto';
PARA: 'para';
FACA: 'faca';

CHAVE_DECIMAL: 'qq';
CHAVE_INTEIRO: 'zz';
CHAVE_TEXTO: 'txt';
CHAVE_PROPOSICAO: 'proposicao';

// LITERAIS BOOLEANOS
VERDADEIRO: 'verdadeiro';
FALSO: 'falso';

// IDENTIFICADORES
ID: [§] [a-zA-Z0-9]*;

// LITERAIS
INTEIRO: [0-9]+;
DECIMAL: [0-9]+ ',' [0-9]+;
TEXTO: '"' .*? '"';

// SÍMBOLOS
FINAL: ';';
ATRIBUICAO: '=';
ABERTURAPARENTESES: '(';
FECHAMENTOPARENTESES: ')';
ABERTURACHAVE: '{';
FECHAMENTOCHAVE: '}';

//OPERADORES
OPSOMA: '+';
OPSUBTRAIR: '-';
OPMULTIPLICACAO: '*';
OPDIVISAO: '/';

// ESPAÇOS EM BRANCO
ESPACOEMBRANCO: [ \t\r\n]+ -> skip;
