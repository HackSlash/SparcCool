%{
	#include "cool.h"

	int yyerror;
%}

%start input

%token id


%%

input		: /* empty */ { /* empty file */ }
			| classdecl { /* accept */ }
			;

classdecl	: "class" type varformals classbody { /* basic class def detected */ }
			| "class" type varformals extends "native" { /* now it extends native! */ }
			;
varformals	: '(' ')' { /* empty */ }
			| '('  ')' {}
			;
classbody	: '{' '}' { /* empty class */ }
			| '{' feature '}' {}

%%
