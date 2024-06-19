grammar Expressions;

program: (branch NEWLINE?)*;
branch: (expression | assignment | writeStatement);

expression: value OPERATOR value;
assignment: identifier ':=' (expression | value);
writeStatement: 'write' identifier SEMICOLON;

identifier: CHAR (CHAR | INT)*;
value: identifier | INT+;

SEMICOLON : ';';
CHAR : [a-zA-Z];
INT : [0-9];
KEYWORD : ('if' | 'else');
OPERATOR : ('*' | '/' | '+' | '-' | '^');
NEWLINE : [\r\n]+ ;

WS : [ \t\r]+ -> skip;