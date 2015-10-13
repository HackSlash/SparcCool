%{
	#define _GNU_SOURCE
	#include "cool.h"
%}

%define parse.error verbose

%start program

%token ID EXM THIS SUPER OVERRIDE NULLVAL NATIVE EXTENDS IF ELSE WHILE MATCH CASE STRING CHAR FLOAT INTEGER BOOL CLASS TYPE SEMICOLON COLON EQEQ GTEQ LTEQ LT GT NEQ EQ NEW DEF PAR_OPEN PAR_CLOSE BRACE_OPEN BRACE_CLOSE BRACK_OPEN BRACK_CLOSE VAR DOT COMMA ARROW

%left	EQ
%left	IF WHILE
%left	MATCH
%left	LTEQ LT
%left	EQEQ
%left	ADD SUB
%left	MULT DIV
%left	EXM UMIN
%left	DOT

%union {
	std::string Str;
	int Int;
}

/** TODO:
 * Create class "Node()", FILL ZEH FILEZ
 * %union, valid values ^^
 * Ilegal keywords in lexer, must generate errors
 * TOKEN "native", can only be used in basic.cool
 * Create tables (Vectors), id's; int's; string's;
 * Method to generate errors
 */

%%
		
program		:/* empty */													{}
        	| program classdecl												{}		
			;

classdecl  	: CLASS TYPE varformals classbody								{}
			| CLASS TYPE varformals EXTENDS TYPE actuals classbody			{}
			| CLASS TYPE varformals EXTENDS NATIVE classbody				{}
	        ;

varformals	: PAR_OPEN form PAR_CLOSE										{}
			;

form		: /* empty */													{}
			| VAR ID COLON TYPE												{}
			| VAR ID COLON TYPE COMMA form 									{}
			;

classbody	: BRACK_OPEN features BRACK_CLOSE								{}
			;

features	: /* empty */													{}
			| feature 														{}
			| feature features 												{}
			;

feature 	: DEF ID formals COLON TYPE EQ expr SEMICOLON					{}
			| OVERRIDE DEF ID formals COLON TYPE EQ expr SEMICOLON			{}
			| DEF ID formals COLON TYPE EQ NATIVE SEMICOLON					{}
			| OVERRIDE DEF ID formals COLON TYPE EQ NATIVE SEMICOLON		{}
			| VAR ID EQ NATIVE SEMICOLON									{}
			| VAR ID COLON TYPE COLON expr SEMICOLON						{}
			| BRACK_OPEN block BRACK_CLOSE SEMICOLON						{}
	
formals		: PAR_OPEN form PAR_CLOSE										{}
			;

form 		: /* empty */													{}
			| ID COLON TYPE													{}
			| ID COLON TYPE COMMA form 										{}
			;

actuals		: PAR_OPEN actual PAR_CLOSE										{}
			;

actual 		: /* empty */													{}
			| expr															{}
			| expr COMMA actual 											{}
			;

block 		: /* empty */													{}
			| blockpt expr													{}
			;

blockpt		: /* empty */													{}
			| expr SEMICOLON blockpt										{}
			| VAR ID COLON TYPE EQ expr SEMICOLON blockpt					{}
			;

expr		: ex primary exp 												{}
			;

ex 			: /* empty */													{}
			| ID EQ ex 														{$$ = $3}
			| EXM ex 														{$$ = !$2}
			| SUB ex %prec UMIN 											{$$ = -$2}
			| IF PAR_OPEN expr PAR_CLOSE expr ELSE ex 						{$$ = ($3)?$5:$7}
			| WHILE PAR_OPEN expr PAR_CLOSE ex 								{}
			;

exp			: /* empty */													{}
			| LTEQ expr exp 												{}
			| GTEQ expr exp 												{}
			| LT expr exp 													{}
			| GT expr exp 													{}
			| EQEQ expr exp 												{}
			| MULT expr exp 												{}
			| DIV expr exp 													{}
			| ADD expr exp 													{}
			| SUB expr exp 													{}
			| MATCH cases exp 												{}
			| DOT ID actuals 												{}
			;

primary		: ID actuals 													{}
			| SUPER DOT ID actuals											{}
			| NEW TYPE actuals												{}
			| BRACK_OPEN block BRACK_CLOSE 									{}
			| PAR_OPEN expr PAR_CLOSE										{}
			| NULLVAL														{}
			| PAR_OPEN PAR_CLOSE											{}
			| ID 															{}
			| INTEGER 														{}
			| STRING 														{}
			| BOOL	 														{}
			| THIS 															{}
			;

cases		: BRACK_OPEN ca cas BRACK_CLOSE 								{}
			;

cas 		: /* empty */													{}
			| ca cas 														{}
			;
		
ca			: CASE ID COLON TYPE ARROW block 								{}
			| CASE NULLVAL ARROW block 										{}
			;

term		: INTEGER                										{$$ = $1;}
			| ID															{$$ = symbolVal($1);}
			;

%%
