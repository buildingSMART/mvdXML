grammar mvdXMLv1_2;

/*----------------
* PARSER RULES
*----------------*/
expression 
    :    boolean_expression EOF;
boolean_expression
    :    ( NOT ) boolean_term (logical_interconnection ( NOT ) boolean_term)*  ;
boolean_term
    :    ( leftside operator rightside )  |  ( LPAREN boolean_expression RPAREN );
leftside
    :    parameter_metric | metric;
rightside
    :    parameter_metric | value;
parameter_metric
    :    parameter (metric)?;
parameter 
    :    simple_id | SELF ;
simple_id 
    :    letter ( letter | ZERO | DIGITNONZERO | '_' )* ;
metric
    :    VALUE | SIZE | TYPE | UNIQUE | EXISTS;
logical_interconnection 
    :    AND | OR | XOR | NAND | NOR | NXOR;
operator 
    :    EQUAL | NOT_EQUAL | GREATER_THAN_OR_EQUAL | GREATER_THAN | LESS_THAN_OR_EQUAL | LESS_THAN;
value
    :    logical_literal | real_literal | regular_expression | string_literal;
logical_literal    
    :    FALSE | TRUE | UNKNOWN ;
real_literal 
    :    sign? (trailing | int) (DOT decimal_part)? exp? ;
string_literal
    :    STRING ;
regular_expression
    :    REG STRING ;
int
    :    DIGITNONZERO (digit)*;
decimal_part
    :    trailing? int?;
exp
    :    EXP sign int;
sign
    :    PLUS | MINUS ;
digit
    :    ZERO | DIGITNONZERO;
trailing
    :    ZERO+;
letter
    :    EXP | LOWER | UPPER;

/*----------------
* LEXER RULES
*----------------*/
AND
    :    'AND' | 'and' | '&' | ';' ;
OR
    :    'OR' | 'or' | '|' ;
XOR
    :    'XOR' | 'xor' ;
NAND
    :    'NAND' | 'nand' ;
NOR
    :    'NOR' | 'nor' ;
NXOR
    :    'NXOR' | 'nxor' ;
NOT
    :    'NOT' | 'not' | '!' ;
VALUE
    :    '[' ('V'|'v') ('alue'|'ALUE') ']' ;
SIZE
    :    '[' ('S'|'s') ('ize'|'IZE') ']' ;
TYPE
    :    '[' ('T'|'t') ('ype'|'YPE') ']' ;
UNIQUE
    :    '[' ('U'|'u') ('nique'|'NIQUE') ']' ;
EXISTS
    :    '[' ('E'|'e') ('xists'|'XISTS') ']' ;
EQUAL
    :    '=' ;
NOT_EQUAL 
    :    '!=' ;
GREATER_THAN_OR_EQUAL 
    :    '>=' ;
GREATER_THAN 
    :    '>' ; 
LESS_THAN_OR_EQUAL 
    :    '<=' ;
LESS_THAN 
    :    '<' ;
FALSE
    :    'FALSE' | 'false' ;
TRUE
    :    'TRUE' | 'true' ;
UNKNOWN 
    :    'UNKNOWN' | 'unknown' ;
REG
    :    'reg';
SELF
    :    ( 'S' | 's' ) ( 'ELF' | 'elf' ) ;
EXP
    :    'e' | 'E';
PLUS
    :    '+';
MINUS
    :    '-';
DOT
    :    '.';
LPAREN  
    :    '(';
RPAREN  
    :    ')'; 
ZERO
    :    '0';
DIGITNONZERO
    :    '1'..'9';
LOWER 
    :    'a'..'z';
UPPER
    :    'A'..'Z'; 
ESC_SEQ
    :    '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\') ;
STRING    
    :    '\'' ( ESC_SEQ | ~('\\'|'\'') )* '\'';
WS
    :    (' '|'\t'|'\n'|'\r')+ -> skip;
    
