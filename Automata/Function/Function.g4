grammar Function;

program: (branch | conditionStatement | whileStatement)*;
branch: (expression | assignment | writeStatement);

value: identifier | string | INT+ ;
expression: value | value (OPERATOR value)*;

writeStatement: 'write' value SEMICOLON;
assignment: identifier ':=' expression;
conditionBlock: '(' expression (CONDITION_OPERATOR expression)* ')';
condition: '('
  (expression | conditionBlock)
  (CONDITION_OPERATOR (expression | conditionBlock))*
')';

codeBlock: (branch | condition)*;
conditionStatement: 'if' condition '{' codeBlock ('}' 'else' '{' codeBlock)? '}';
whileStatement: 'while' ;
function: 'func' '{' codeBlock '}';


identifier: CHAR (CHAR | INT)*;
string : '"' .*? '"';

SEMICOLON : ';';
CHAR : [a-zA-Z];
INT : [0-9];
OPERATOR : ('*' | '/' | '+' | '-' | '^' | '>' | '<' | '<=' | '>=' | '==');
CONDITION_OPERATOR : ('&' | '|');

WS : [ \t\r\n]+ -> skip;