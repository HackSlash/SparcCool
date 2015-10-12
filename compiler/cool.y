%{
	#include "cool.h"

	int yyerror;
%}

%start program

%token ID
%token EXM
%token THIS
%token SUPER
%token OVERRIDE
%token NULLVAL
%token EXTENDS
%token IF
%token ELSE
%token WHILE
%token MATCH
%token CASE
%token STRING
%token CHAR
%token FLOAT
%token INTEGER
%token BOOL
%token CLASS
%token TYPE
%token SEMICOLON
%token COLON
%token ADD
%token SUB
%token DIV
%token MULT
%token EQEQ
%token GTEQ
%token LTEQ
%token LT
%token GT
%token NEQ
%token EQ
%token NEW
%token DEF
%token PAR_OPEN
%token PAR_CLOSE
%token BRACE_OPEN
%token BRACE_CLOSE
%token BRACK_OPEN
%token BRACK_CLOSE
%token VAR
%token DOT
%token COMMA
%token ARROW

%%
		
program:	:/* empty */				
        	| program line				
			;

classdecl  	: CLASS TYPE varformals classbody								
			| CLASS TYPE varformals EXTENDS TYPE actuals classbody			
			| CLASS TYPE varformals EXTENDS NATIVE classbody				
	        ;

varformals	: PAR_OPEN form PAR_CLOSE
			;

form		: /* empty */
			| VAR ID COLON TYPE
			| VAR ID COLON TYPE, form
			;

classbody	: BRACK_OPEN features BRACK_CLOSE
			;

features	: /* empty */
			| feature
			| feature features
			;

feature 	: DEF ID formals COLON TYPE EQ expr SEMICOLON
			| OVERRIDE DEF ID formals COLON TYPE EQ expr SEMICOLON
			| DEF ID formals COLON TYPE EQ NATIVE SEMICOLON
			| override DEF ID formals COLON TYPE EQ NATIVE SEMICOLON
			| VAR ID EQ NATIVE SEMICOLON
			| VAR ID COLON TYPE COLON expr SEMICOLON
			| BRACK_OPEN block BRACK_CLOSE SEMICOLON
	
formals		: PAR_OPEN form PAR_CLOSE
			;

form 		: /* empty */
			| ID COLON TYPE
			| ID COLON TYPE COMMA form
			;

actuals		: PAR_OPEN actual PAR_CLOSE
			;

actual 		: /* empty */
			| expr
			| expr COMMA actual
			;

block 		: /* empty */
			| blockpt expr
			;

blockpt		: /* empty */
			| expr SEMICOLON blockpt
			| VAR ID COLON TYPE EQ expr SEMICOLON blockpt
			;

expr		: ex primary exp
			;

ex 			: /* empty */
			| ID EQ ex
			| EXM ex
			| SUB ex
			| IF PAR_OPEN expr PAR_CLOSE expr ELSE ex
			| WHILE PAR_OPEN expr PAR_CLOSE ex
			;

exp			: /* empty */
			| LTEQ expr exp
			| GTEQ expr exp
			| LT expr exp
			| GT expr exp
			| EQEQ expr exp
			| MULT expr exp
			| DIV expr exp
			| ADD expr exp
			| SUB expr exp
			| MATCH cases exp
			| DOT ID actuals
			;

primary		: ID actuals
			| SUPER DOT ID actuals
			| NEW TYPE actuals
			| BRACK_OPEN block BRACK_CLOSE
			| PAR_OPEN expr PAR_CLOSE
			| NULLVAL
			| PAR_OPEN PAR_CLOSE
			| ID
			| INTEGER
			| STRING
			| BOOLEAN
			| THIS
			;

cases		: BRACK_OPEN ca cas BRACK_CLOSE
			;

cas 		: /* empty */
			| ca cas
			;
		
ca			: CASE ID COLON TYPE ARROW block
			| CASE NULLVAL ARROW block
			;

term		: NUMBER                	{$$ = $1;}
			| ID						{$$ = symbolVal($1);}
			;

%%
