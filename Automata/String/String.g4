grammar String;

sentence : name 'is' age EOF ;
name : firstName lastName ;

age : NUMBER ;
firstName : STRING ;
lastName : STRING ;

NUMBER : [0-9]+ ;
STRING : [A-Za-z]+ ;
