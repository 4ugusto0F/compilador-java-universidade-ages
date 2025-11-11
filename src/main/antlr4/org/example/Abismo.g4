grammar Abismo;

/*
 * =============================================================================
 * SEÇÃO DO PARSER (Regras em minúsculas)
 * Define a ESTRUTURA da linguagem.
 * =============================================================================
 */

// Um programa e um conjuto de Comandos com final em EOF= apos o ultimo comando deve estár vazia!
prog: statement* EOF;


/** 1. Comandos = statements o ":" Siginifica a atribuição do que e o statements valido,
 o "|" siginifica OU, que statemente pode significar qualquer uma destas expressões,
 e ";" e delimitador o marcador do final.
**/
statement
    : expression SEMI
    | assignmentStatement SEMI
    | ifStatement
    | whileStatement
    | block
    ;

// BLOCK = bloco de codigo
block: LBRACE statement* RBRACE;


// IF = Comando if
// Um 'if' geralmente tem a forma: 'if' '(' expressão ')' statement ('else' statement)?
ifStatement: IF LPAREN expression RPAREN statement (ELSE statement)?;



// WHILE = Comando while
whileStatement: WHILE LPAREN expression RPAREN statement;



// 5. CRIE A REGRA PARA ATRIBUIÇÃO
// Uma atribuição geralmente tem a forma: ID '=' expressão
assignmentStatement: ID ASSIGN expression;
// (Você precisará definir ASSIGN na seção do Lexer)


// 6. MELHORE AS EXPRESSÕES
// Atualmente, uma expressão é apenas um número ou um ID.
// Para suportar matemática, use regras de precedência.
// Exemplo:
// expression: term ( (ADD | SUB) term )*;
// term: factor ( (MUL | DIV) factor )*;
// factor: INT | ID | LPAREN expression RPAREN;
expression: INT | ID;


/*
 * =============================================================================
 * SEÇÃO DO LEXER (Regras em MAIÚSCULAS)
 * Define os TOKENS (átomos) da linguagem.
 * ORDEM IMPORTA: Palavras-chave devem vir ANTES de ID.
 * =============================================================================
 */

// 7. ADICIONE AS PALAVRAS-CHAVE
// Defina as palavras reservadas. Elas devem vir antes da regra 'ID'.
//
IF: 'if';
ELSE: 'else';
WHILE: 'while';
FOR: 'for';
DO: 'do';
KEY_DOUBLE: 'qq';
KEY_INT: 'zz';
KEY_STRING: 'txt';
KEY_BOOLEAN: 'proposicao';
// IDENTIFICADORES (Nomes de variáveis) - Mantenha esta regra DEPOIS das palavras-chave.
ID: [§] [a-zA-Z0-9]*;


// NÚMEROS
INT: [0-9]+;
DECIMAL: [0-9]+ , [0-9]+:

// 8. ADICIONE OS OPERADORES E SÍMBOLOS
// Adicione os novos símbolos que você usará nas regras do parser.
SEMI: ';';
ASSIGN: '=';
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';


// ESPAÇOS EM BRANCO (Ignorados pelo parser)
WS: [ \t\r\n]+ -> skip;
