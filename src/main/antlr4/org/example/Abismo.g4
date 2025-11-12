grammar Abismo;

/* ================= PARSER ================= */

inicio: comando* EOF;

comando
    : expressão FINAL
    | assignmentStatement FINAL
    | ifStatement
    | whileStatement
    | block
    ;

block: ABERTURACHAVE comando* FECHAMENTOCHAVE;
//Expressões PARSE
ifStatement: SE ABERTURAPARENTESES expressão FECHAMENTOPARENTESES comando (SENAO comando)?;
whileStatement: ENQUANTO ABERTURAPARENTESES expressão FECHAMENTOPARENTESES comando;
assignmentStatement: ID ATRIBUICAO expressão;


expressão: term ( (OPSOMA | OPSUBTRAIR) term )*;
term: factor ( (OPMULTIPLICACAO | OPDIVISAO) factor )*;
factor:
      INTEIRO
    | DECIMAL
    | TEXTO
    | VERDADEIRO
    | FALSO
    | ID
    | ABERTURAPARENTESES expressão FECHAMENTOPARENTESES
    ;

/* ================= LEXER ================= */

// PALAVRAS-CHAVE E TIPOS
SE: 'se';
SENAO: 'senao';
ENQUANTO: 'enquanto';
PARA: 'para';
FACA: 'faca';

KEY_DOUBLE: 'qq';
KEY_INT: 'zz';
KEY_STRING: 'txt';
KEY_BOOLEAN: 'proposicao';

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
OPSOMA: '+';
OPSUBTRAIR: '-';
OPMULTIPLICACAO: '*';
OPDIVISAO: '/';

// ESPAÇOS EM BRANCO
ESPACOEMBRANCO: [ \t\r\n]+ -> skip;
