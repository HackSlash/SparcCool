%{
	#include "cool.h"
%}

%define parse.error verbose

%start program

%token UMIN MULT DIV ADD SUB ID EXM THIS SUPER OVERRIDE NULLVAL NATIVE EXTENDS IF ELSE WHILE MATCH CASE STRING INTEGER BOOL CLASS TYPE SEMICOLON COLON EQEQ LTEQ LT NEQ EQ NEW DEF PAR_OPEN PAR_CLOSE BRACE_OPEN BRACE_CLOSE BRACK_OPEN BRACK_CLOSE VAR DOT COMMA ARROW

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
	StringNode* string;
	IntNode* Int;
	BoolNode* Bool;
	Node* node;
	programNode* program;
	classdeclNode* classdecl;
	varformalsNode* varformals;
	varformNode* varform;
	classbodyNode* classbody;
	featuresNode* features;
	featureNode* feature;
	formalsNode* formals;
	formNode* form;
	actualsNode* actuals;
	actualNode* actual;
	blockNode* block;
	blockptNode* blockpt;
	exprNode* expr;
	exNode* ex;
	expNode* exp;
	primaryNode* primary;
	casesNode* cases;
	casNode* cas;
	caNode* ca;
}

%type <program> program
%type <classdecl> classdecl
%type <varformals> varformals
%type <varform> varform
%type <classbody> classbody
%type <features> features
%type <feature> feature
%type <formals> formals
%type <form> form
%type <actuals> actuals
%type <actual> actual
%type <block> block
%type <blockpt> blockpt
%type <expr> expr
%type <ex> ex
%type <exp> exp
%type <primary> primary
%type <cases> cases
%type <cas> cas
%type <ca> ca


/** TODO:
 * Create class "Node()", FILL ZEH FILEZ
 * %union, valid values ^^
 * Create tables (Vectors), id's; int's; string's.
 */

%%
		
program		:/* empty */													{}
        	| program classdecl												{}
			;

classdecl  	: CLASS TYPE varformals classbody								{}
			| CLASS TYPE varformals EXTENDS TYPE actuals classbody			{}
			| CLASS TYPE varformals EXTENDS NATIVE classbody				{}
	        ;

varformals	: PAR_OPEN varform PAR_CLOSE									{}
			;

varform		: /* empty */													{}
			| VAR ID COLON TYPE												{}
			| VAR ID COLON TYPE COMMA varform 								{}
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
			| ID EQ ex 														{}
			| EXM ex 														{}
			| SUB ex %prec UMIN 											{}
			| IF PAR_OPEN expr PAR_CLOSE expr ELSE ex 						{}
			| WHILE PAR_OPEN expr PAR_CLOSE ex 								{}
			;

exp			: /* empty */													{}
			| LTEQ expr exp 												{}
			| LT expr exp 													{}
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

%%
