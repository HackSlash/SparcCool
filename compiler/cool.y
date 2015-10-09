%{
	#include "cool.h"
%}

%start program

%token id


%% {ID, exp, !}
		
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




term		: number                	{$$ = $1;}
			| ID						{$$ = symbolVal($1);}
			;




%%
