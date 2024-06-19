grammar Condition;

program: (branch | condition)*;
branch: (expression | assignment | writeStatement);

expression: value OPERATOR value;
assignment: identifier ':=' (expression | value);
writeStatement: 'write' value SEMICOLON;
conditionStart: 'if' '(' (expression | value) ')' '{';
conditionElse: '}' 'else' '{';
codeBlock: (branch | condition)*;
condition: conditionStart codeBlock (conditionElse codeBlock)? '}';

identifier: CHAR (CHAR | INT)*;
value: identifier | string | INT+ ;
string : '"' .*? '"';

SEMICOLON : ';';
CHAR : [a-zA-Z];
INT : [0-9];
OPERATOR : ('*' | '/' | '+' | '-' | '^');

WS : [ \t\r\n]+ -> skip;