grammar Webpage;

htmlDocument: htmlDoctype element* ;

element: (startTag content* CLOSE_TAG) | elementWithSelfCloseTag ;

elementWithSelfCloseTag: OPEN_TAG attribute* TAG_SELF_CLOSE;

startTag: OPEN_TAG attribute* TAG_END ;

content: element | TEXT ;

htmlDoctype: '<!DOCTYPE html>';

attribute: ATTRIBUTE ;

OPEN_TAG: '<' [a-zA-Z0-9]+ ;  // Opening tag
CLOSE_TAG: '</' [a-zA-Z0-9]+ '>' ;  // Closing tag
TAG_END: '>' ;  // End of tag
TAG_SELF_CLOSE: '/>' ;  // Self-closing tag
ATTRIBUTE: [a-zA-Z]+ '=' '"' .*? '"' ;  // Attribute with double quotes
TEXT: ~[<>\r\n]+ ;  // Text not containing tags
WS: [ \t\r\n]+ -> skip ;  // Whitespace (ignored)