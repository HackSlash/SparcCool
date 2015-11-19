/* $Id: parser.yy 48 2009-09-05 08:07:10Z tb $ -*- mode: c++ -*- */
/** \file parser.yy Contains the coolspace Bison parser source */

%{ /*** C/C++ Declarations ***/

#include <stdio.h>
#include <string>
#include <vector>
#include "ParseContext.h"
#include "Context.h"
#include "Nodes.h"
#include <stack>
%}

/*** yacc/bison Declarations ***/

/* Require bison 2.3 or later */
%require "2.3"

/* add debug output code to generated parser. disable this for release
 * versions. */
%debug

/* start symbol is named "start" */
%start start

/* write out a header file containing the token defines */
%defines "Parser.h"

/* use newer C++ skeleton file */
%skeleton "lalr1.cc"

/* namespace to enclose parser in */
%name-prefix "coolspace"

/* set the parser's class identifier */
%define parser_class_name {Parser}

/* keep track of the current position within the input */
%locations
%initial-action
{
    // initialize the initial location object
    @$.begin.filename = @$.end.filename = &driver.streamname;
};

/* The driver is passed by reference to the parser and to the scanner. This
 * provides a simple but effective pure interface, not relying on global
 * variables. */
%parse-param { class Driver& driver }

/* verbose error messages */
%error-verbose

 /*** BEGIN EXAMPLE - Change the coolspace grammar's tokens below ***/

%union {
    int  			intVal;
    std::string*		strVal;
    bool                        boolVal;
    class Node*                 node;
    class IdNode*               idNode;
    class TypeNode*             typeNode;
    class FsNode*               fsNode;
    class AcNode*               acNode;
    class ClNode*               clNode;
    class ClbNode*              clbNode;
    class BlNode*               blNode;
}

%token			        EOF	     0	"end of file"
%token			        EOL		"end of line"
%token                  ADD             "+"
%token                  SUB             "-"
%token                  MULT            "*"
%token                  DIV             "/"
%token                  LT              "<"
%token                  LTEQ            "<="
%token                  ARROW           "=>"
%token                  EQEQ            "=="
%token                  BRACK_OPEN           "{"
%token                  BRACK_CLOSE          "}"
%token                  PAR_OPEN           "("
%token                  PAR_CLOSE          ")"
%token                  DOT          "."
%token                  COMMA           ","
%token                  COLON           ":"
%token                  SEMICOLON          ";"
%token                  EQ           "="
%token                  EXC            "!"
%token                  CASE           "case"
%token                  CLASS          "class definition"
%token                  DEF            "def"
%token                  ELSE           "else"
%token                  EXTEND            "extend"
%token                  IF             "if"
%token                  MATCH          "match"
%token                  NATIVE            "native"
%token                  NEW            "new"
%token                  NULLVAL           "null"
%token                  OVERRIDE           "override"
%token                  SUPER          "super"
%token                  THIS           "this"
%token                  VAR            "var"
%token                  WHILE          "while"
%token <boolVal>        BOOL           "Boolean"
%token <strVal>         ID           "id"
%token <strVal>         TYPEID          "type id"
%token <strVal>         TCSTR           "three-quote-string"
%token <strVal>         STRING            "string"
%token <intVal>         INT            "Int"
%token                  UNDEF           "undefined"


%left EQ
%left IF WHILE
%left MATCH
%left LTEQ LT
%left EQEQ
%left ADD SUB
%left MULT DIV
%left EXC UNARY
%left DOT
%left ELSE
%left W

%type <typeNode>  type
%type <idNode>   id
%type <fsNode>  fm varforms
%type <acNode> ac
%type <blNode> bl
%type <clNode> cd
%type <clbNode> classbody
%type <node>   ac2 ac3 bl2 ca ca2 classbody2 ex ft3

%{

#include "driver.h"
#include "scanner.h"

/* this "connects" the bison parser in the driver to the flex scanner class
 * object. it defines the yylex() function call to pull the next token from the
 * current lexer object of the driver context. */
#undef yylex
#define yylex driver.lexer->lex

#define bl_stack    driver.pContext.block_stack
#define varforms_vec   driver.pContext.varFormals_vector
#define ft_vec   driver.pContext.feature_vector
#define fo_vec   driver.pContext.formals_vector
#define ac_stack    driver.pContext.actual_stack
#define ca_stack    driver.pContext.case_stack
#define ft_func_vec driver.pContext.ft_func_vec
#define ft_var_vec  driver.pContext.ft_var_vec
#define ft_block_vec   driver.pContext.ft_block_vec
#define cur_file   driver.streamname
#define ca_top  driver.pContext.case_stack.top()
#define bl_top  driver.pContext.block_stack.top()
#define ac_top  driver.pContext.actual_stack.top()

%}

%% /*** Grammar Rules ***/

/*var formals*/
varforms      : PAR_OPEN PAR_CLOSE  {$$ = new FsNode(@1,varforms_vec);}
        | PAR_OPEN varform PAR_CLOSE  {$$ = new FsNode(@1,varforms_vec); varforms_vec.clear(); }


varform     : varform COMMA VAR id COLON type {varforms_vec.push_back(new FNode(@2,$4,$6));}
            | VAR id COLON type   {varforms_vec.push_back(new FNode(@1,$2,$4));}

/*class declaration*/
classdecl      : CLASS type varforms classbody  {$$ = new ClNode(@1,cur_file,$2,$3,new ExtNode(@1,new TypeNode(@1,"Any"), new AcNode(@1)),$4);}
            | CLASS type varforms EXTEND type ac classbody   {$$ = new ClNode(@1,cur_file,$2,$3,new ExtNode(@4,$5,$6),$7);}
            | CLASS type varforms EXTEND NATIVE classbody  {$$ = new ClNode(@1,cur_file,$2,$3,new ExtNode(@4,new NatNode(@5)),$6);}
            | CLASS error '{' {std::cout<<"Must start with keyword \'class\'."<<std::endl; yyerrok;}

/*class body*/
classbody      : BRACK_OPEN classbody2 BRACK_CLOSE  {$$ = new ClbNode(@1,ft_vec,ft_var_vec,ft_func_vec,ft_block_vec);ft_vec.clear();ft_var_vec.clear();ft_func_vec.clear();ft_block_vec.clear();}

classbody2     : features   {}

/*features*/
features      : /*empty*/{}
        | features DEF ID fm COLON type EQ features SEMICOLON  {FuncNode * n =  new FuncNode(@2,false,new IdNode(@3,$3,false),$4,$6,$8); features_vec.push_back(n); features_func_vec.push_back(n);}
        | features OVERRIDE DEF ID fm COLON type EQ features SEMICOLON  {FuncNode * n = new FuncNode(@2,true,new IdNode(@4,$4,false),$5,$7,$9); features_vec.push_back(n); features_func_vec.push_back(n);}
        | features VAR ID EQ NATIVE SEMICOLON {  ClVarNode * n = new ClVarNode(@2,new IdNode(@3,$3,false),new NatNode(@5)); features_vec.push_back(n); features_var_vec.push_back(n);}
        | features VAR ID COLON type EQ ex SEMICOLON {ClVarNode * n = new ClVarNode(@2,new IdNode(@3,$3,false),$5,$7); features_vec.push_back(n); features_var_vec.push_back(n);}
        | features BRACK_OPEN bl BRACK_CLOSE SEMICOLON {features_vec.push_back($3); features_block_vec.push_back($3);}

feature     : expr    { $$ = $1;}
            | NATIVE  { $$ = new NatNode(@1);} 


/*formals*/
fm      : PAR_OPEN fm2 PAR_CLOSE  {$$ = new FsNode(@1,fo_vec); fo_vec.clear();}

fm2     : /*empty*/ {}
        | fm3   {}

fm3     : fm3 COMMA id COLON type {fo_vec.push_back(new FNode(@3,$3,$5));}
        | id COLON type    {fo_vec.push_back(new FNode(@1,$1,$3));}

/*actuals*/
ac      : PAR_OPEN ac2 PAR_CLOSE {$$ = new AcNode(@1,ac_top); ac_stack.pop();std::vector<Node*>act; ac_stack.push(act);}

ac2     : /*empty*/ {}
        | ac3   {}

ac3     : ac3 COMMA ex {ac_top.push_back($3);}
        | ex {ac_top.push_back($1);}

/*block*/
bl      : /*empty*/   {coolspace::location loc; $$ = new BlNode(loc,bl_top); bl_stack.pop(); std::vector<Node*>bl; bl_stack.push(bl);}
        | ex {bl_top.insert(bl_top.begin(),$1);$$ = new BlNode(@1,bl_top); bl_stack.pop(); std::vector<Node*>bl; bl_stack.push(bl);}
        | bl2 {$$ = new BlNode(@1,bl_top); bl_stack.pop(); std::vector<Node*>bl; bl_stack.push(bl);}
        
bl2     : ex SEMICOLON ex { bl_top.insert(bl_top.begin(),$1);bl_top.push_back($3);}
        | ex SEMICOLON bl2 {bl_top.insert(bl_top.begin(),$1);}
        | VAR ID COLON type EQ ex SEMICOLON ex {$$ = new DAssNode(@1,new IdNode(@2,$2,false),$4,$6);bl_top.insert(bl_top.begin(),$$); bl_top.push_back($8);}
        | VAR ID COLON type EQ ex SEMICOLON bl2 { $$ = new DAssNode(@1,new IdNode(@2,$2,false),$4,$6);bl_top.insert(bl_top.begin(),$$);}


id   : ID {$$ = new IdNode(@1,$1);}
type  : TYPEID {$$ = new TypeNode(@1,$1);}

/*expression*/
ex   : id EQ ex {$$ = new AssNode(@1,$1, $3);}
     | EXC ex { $$ = new NegNode(@1,$2);}
     | SUB ex %prec UNARY {$$ = new UMinNode(@1,$2);}
     | IF PAR_OPEN ex PAR_CLOSE ex ELSE ex {$$ = new IfNode(@1,$3,$5,$7);}
     | WHILE PAR_OPEN ex PAR_CLOSE ex %prec W {$$ = new WhileNode(@1,$3,$5);}
     | SUPER DOT ID ac {$$ = new SupNode(@1,new IdNode(@3,$3,false),$4);}
     | ID ac {$$ = new FCallNode(@1,new IdNode(@1,$1,false),$2);} /***function name and parameters***/
     | NEW type ac {$$ = new NewNode(@1,$2,$3);}
     | BRACK_OPEN bl BRACK_CLOSE {$$ = $2;}
     | PAR_OPEN ex PAR_CLOSE {$$ = new EncExNode(@1,$2);}
     | ex DOT ID ac { $$ = new OFCallNode(@1,$1,new IdNode(@3,$3,false),$4);}
     | ex MATCH ca {$$ = new MaNode(@1,$1,ca_top);ca_stack.pop();std::vector<CaNode*>vec; ca_stack.push(vec);}
     | ex LTEQ ex {$$ = new LtEqNode(@1,$1,$3);}
     | ex LT ex { $$ = new LtNode(@1,$1,$3);}
     | ex EQEQ ex {$$ = new EqEQNode(@1,$1,$3);}
     | ex MULT ex {$$ = new MulNode(@1,$1,$3);}
     | ex DIV ex {$$ = new DivNode(@1,$1,$3);}
     | ex ADD ex {$$ = new AddNode(@1,$1,$3);}
     | ex SUB ex {$$ = new MinNode(@1,$1,$3);}
     | NULLVAL {$$ = new NullNode(@1);}
     | PAR_OPEN PAR_CLOSE {$$ = new UnitNode(@1);}
     | id {$$ = $1;}
     | INT { $$ = new IntNode(@1,$1); }
     | STRING { $$ = new StrNode(@1,$1);}
     | TCSTR { $$ = new StrNode(@1,$1);}
     | BOOL {$$ = new BoolNode(@1,$1);}
     | THIS {$$ = new ThisNode(@1);}

/*cases*/
ca      : BRACK_OPEN ca2 BRACK_CLOSE {}

ca2     : ca2 CASE id COLON type ARROW bl {ca_top.push_back(new CaNode(@2,$3,$5,$7));}
        | ca2 CASE NULLVAL ARROW bl {ca_top.push_back(new CaNode(@2,new IdNode(@3,"null",false),new TypeNode(@3,"Null"),$5));}
        | CASE ID COLON type ARROW bl {ca_top.push_back(new CaNode(@1,new IdNode(@2,$2,false),$4,$6));}
        | CASE NULLVAL ARROW bl {ca_top.push_back(new CaNode(@1,new IdNode(@2,"null",false),new TypeNode(@2,"Null"),$4));}

start	: /* empty */
        | start cd  {    if(!Error::hasErrors()){
                                driver.context.addClass($2,driver.streamname);}
                              }

 /*** END COOL GRAMMAR RULES ***/


%% /*** Additional Code ***/
#include "driver.h"

void coolspace::Parser::error(const Parser::location_type& l,
			    const std::string& m)
{
    driver.error(l, m);
}
