%{
	#include "cool.h"
%}

%start input

%token id


%%

input:		/* empty */
			| exp	{ cout << "Result: " << $1 << endl; }
			;

exp:		INTEGER_LITERAL	{ $$ = $1; }
			| exp PLUS exp	{ $$ = $1 + $3; }
			| exp MULT exp	{ $$ = $1 * $3; }
			;

%%
