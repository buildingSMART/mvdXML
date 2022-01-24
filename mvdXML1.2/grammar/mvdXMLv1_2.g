grammar mvdXMLv1_2;

/*----------------
* PARSER RULES
*----------------*/
expression 
	:	boolean_expression ;
boolean_expression
    :	boolean_term (logical_interconnection boolean_term)*  ;
boolean_term
	:	NOT? ((( parameter ( metric )? | metric ) operator ( value | parameter ( metric )? ) )  |  ( LPAREN boolean_expression RPAREN ));
parameter 
	:	SIMPLEID | 'SELF' ;
metric 	
	:	'[Value]' | '[Size]' | '[Type]' | '[Unique]' | '[Exists]' ;
logical_interconnection 
	:	AND | OR | XOR | NAND | NOR | NXOR ;
operator 
	:	EQUAL | NOT_EQUAL | GREATER_THAN | GREATER_THAN_OR_EQUAL | LESS_THAN | LESS_THAN_OR_EQUAL;
value 	
	:	logical_literal | int_literal | real_literal | string_literal | regular_expression;
logical_literal	
	: 	FALSE | TRUE | UNKNOWN ;
int_literal
	:	INT;
real_literal 
	:	(sign)? ( DIGIT | INT ) ('.')? ( ( DIGIT | INT ) )? ( 'e' (sign)? ( DIGIT | INT ) )? ;
string_literal
	:	STRING ;
regular_expression
	:	'reg' STRING ;
sign 	
	:	'+' | '-' ;

/*----------------
* LEXER RULES
*----------------*/
AND
	:	'AND' | 'and' | '&' | ';' ;
OR
	:	'OR' | 'or' | '|' ;
XOR
	:	'XOR' | 'xor' ;
NAND
	:	'NAND' | 'nand' ;
NOR
	:	'NOR' | 'nor' ;
NXOR
	:	'NXOR' | 'nxor' ;
NOT
	:	'NOT' | 'not' | '!';
EQUAL
	:	'=' ;
NOT_EQUAL 
	:	'!=' ;
GREATER_THAN 
	:	'>' ; 
GREATER_THAN_OR_EQUAL 
	:	'>=' ;
LESS_THAN 
	:	'<' ;
LESS_THAN_OR_EQUAL 
	:	'<=' ;
FALSE 	
	:	'FALSE' | 'false' ;
TRUE 	
	:	'TRUE' | 'true' ;
UNKNOWN 
	:	'UNKNOWN' | 'unknown' ;
DIGIT 	
	:	'0'..'9' ;
INT 	
	:	'0'..'9'+;
HEX_DIGIT 
	:	DIGIT | ('a'..'f' | 'A'..'F') ;
LETTER 
	:	('a'..'z') | ('A'..'Z') ; 
SIMPLEID 
	:	LETTER ( LETTER | DIGIT | '_' )* ;    
LPAREN  
	:   '(';
RPAREN  
	:   ')';  
OCTAL_ESC
	:   '\\' ('0'..'3') ('0'..'7') ('0'..'7')   |   '\\' ('0'..'7') ('0'..'7')   |   '\\' ('0'..'7')  ;
UNICODE_ESC
	:   '\\' 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT ;
ESC_SEQ
    :   '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')  |   UNICODE_ESC  |   OCTAL_ESC ;
STRING	
	:  	'\'' ( ESC_SEQ | ~('\\'|'\'') )* '\'';
WS 	
	:	(' '|'\t'|'\n'|'\r')+ { $channel = HIDDEN; } ;
	
