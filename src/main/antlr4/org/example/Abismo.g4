grammar Abismo;

/* ================= PARSER ================= */

inicio: comando* EOF;

comando
    : expressao FINAL
    | inicializacaoVar 
    | declaracaoVar 
    | comandoSe
    | comandoEnquanto
    | comandoPara          
    | comandoFacaEnquanto  
    | bloco
    ;

declaracaoVar: tiposVar ID (ATRIBUICAO expressao)? FINAL;
tiposVar: CHAVE_INTEIRO | CHAVE_TEXTO | CHAVE_PROPOSICAO | CHAVE_DECIMAL;

bloco: ABERTURACHAVE comando* FECHAMENTOCHAVE;
comandoSe: SE ABERTURAPARENTESES expressao FECHAMENTOPARENTESES comando (SENAO comando)?;
comandoEnquanto: ENQUANTO ABERTURAPARENTESES expressao FECHAMENTOPARENTESES comando;
inicializacaoVar: ID ATRIBUICAO expressao FINAL;
comandoPara: PARA ABERTURAPARENTESES expressao? FINAL expressao? FINAL expressao? FECHAMENTOPARENTESES comando;
comandoFacaEnquanto: FACA comando ENQUANTO ABERTURAPARENTESES expressao FECHAMENTOPARENTESES FINAL;

// NOVA REGRA: Define uma lista de argumentos para as funções
listaDeArgumentos: expressao (PONTO expressao)*;

expressao: term ( (OPSOMA | OPSUBTRAIR) term )*;
term: factor ( (OPMULTIPLICACAO | OPDIVISAO) factor )*;

// ATUALIZADO: A regra factor agora entende variáveis E chamadas de função
factor:
      INTEIRO
    | DECIMAL
    | TEXTO
    | VERDADEIRO
    | FALSO
    | ID (ABERTURAPARENTESES listaDeArgumentos? FECHAMENTOPARENTESES)? // ID pode ser uma variável ou uma função
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
PONTO: '.'; // NOVO TOKEN
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
