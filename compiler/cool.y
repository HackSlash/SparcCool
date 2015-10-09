%{
	#include "cool.h"

	int yyerror;
%}

%start program

%token id


%%
		
program:	:/* empty */				
        	| program line				
			;

classdecl  	: class TYPE varformals classbody								
			| class TYPE varformals extends TYPE actuals classbody			
			| class TYPE varformals extends native classbody				
	        ;

varformals	: ( form )
			;

form	: /* empty */
		| var ID : TYPE
		| var ID : TYPE, form
		;

classbody	: { features }
			;

features	: /* empty */
			| feature
			| feature features
			;

feature 	: def ID formals : TYPE = expr ;
			| override def ID formals : TYPE = expr ;
			| def ID formals : TYPE = native ;
			| override def ID formals : TYPE = native ;
			| var ID = native ;
			| var ID : TYPE = expr ;
			| { block } ;
	
formals	: ( form )
		;

form 	: /* empty */
		| ID : TYPE
		| ID : TYPE, form
		;

actuals	: ( actual )
		;

actual 	: /* empty */
		| expr
		| expr, actual
		;

block 	: /* empty */
		| blockpt expr
		;

blockpt	: /* empty */
		| expr ; blockpt
		| var ID : TYPE = expr ; blockpt
		;

expr	: ex primary exp
		;

ex 		: /* empty */
		| ID = ex
		| ! ex
		| - ex
		| if ( expr ) expr else ex
		| while ( expr ) ex
		;

exp		: /* empty */
		| <= expr exp
		| >= expr exp
		| < expr exp
		| > expr exp
		| == expr exp
		| * expr exp
		| / expr exp
		| + expr exp
		| - expr exp
		| match cases exp
		| . ID actuals
		;

primary	: ID actuals
		| super . ID actuals
		| new TYPE actuals
		| { block }
		| ( expr )
		| null
		| ()
		| ID
		| INTEGER
		| STRING
		| BOOLEAN
		| this
		;

cases	: { ca cas }
		;

cas 	: /* empty */
		| ca cas
		;
		
ca		: case ID : TYPE => block
		| case null => block
		;

term		: number                	{$$ = $1;}
			| ID						{$$ = symbolVal($1);}
			;

%%
