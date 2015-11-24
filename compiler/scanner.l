/*
 * Main FLEX file
 */

 /** FLEX Imports **/
%pointer
%option yylineno

%top{
	/** C/C++ Imports && Headers **/
	#ifndef COOL_H
	#include "compiler.h"
	#endif
	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
	#include "parser.hpp"
	#include "error.h"
	extern YYSTYPE yylval;

	#define SAVE_STRING (yylval.string = new StringNode(stringBuffer))
	#define SAVE_INT (yylval.Int = new IntNode(atoi(yytext)))
	#define TOKEN(t) t
}

/** FLEX Declarations **/
CLASS_ID							[A-Z][_A-Za-z0-9]*
ID									[_a-z][_A-Za-z0-9]*
SIGN 								[+|-]
INT 								0|[1-9][0-9]*
WS									[" "|"\t"|"\n"|"\r"]

/** Declaration of all States **/
%s COMMENT STRING STRESCAPE CHAR CHARESCAPE TRSTRING

/** FLEX LEXICON LOGIC **/
%%
<INITIAL,COMMENT>"/*"				{
										if(comIndent==0)
											BEGIN(COMMENT);
										comIndent++;
									}
<INITIAL,COMMENT>"//"+.*$			;
<COMMENT>[^"*/"]						{}
<COMMENT>"*/"						{
										comIndent--;
										if(comIndent==0) {
											BEGIN(INITIAL);
										}
									}
<COMMENT>.
<INITIAL>"this"						return TOKEN(THIS);
<INITIAL>"super"					return TOKEN(SUPER);
<INITIAL>"override"					return TOKEN(OVERRIDE);
<INITIAL>"null"						return TOKEN(NULLVAL);
<INITIAL>"extends"					return TOKEN(EXTENDS);
<INITIAL>"if"						return TOKEN(IF);
<INITIAL>"else"						return TOKEN(ELSE);
<INITIAL>"while"					return TOKEN(WHILE);
<INITIAL>"match"					return TOKEN(MATCH);
<INITIAL>"case"						return TOKEN(CASE);
<INITIAL>","						return TOKEN(COMMA);
<INITIAL>"."						return TOKEN(DOT);
<INITIAL>"\"\"\""					BEGIN(TRSTRING);
<TRSTRING>"\"\"\""					SAVE_STRING;strdone();BEGIN(INITIAL);return TOKEN(STRING);
<TRSTRING>.							strcopy(yytext);
<INITIAL>"\""						BEGIN(STRING);
<STRING>"\""						SAVE_STRING;strdone();BEGIN(INITIAL);return TOKEN(STRING);
<STRING>"\n"						genError(ill_nln, NULL, yylineno);
<STRING>"\\"						BEGIN(STRESCAPE);
<STRESCAPE>"n"						strcopy((char*)"\n");BEGIN(STRING);
<STRESCAPE>"0"						strcopy((char*)"\0");BEGIN(STRING);
<STRESCAPE>"b"						strcopy((char*)"\b");BEGIN(STRING);
<STRESCAPE>"t"						strcopy((char*)"\t");BEGIN(STRING);
<STRESCAPE>"r"						strcopy((char*)"\r");BEGIN(STRING);
<STRESCAPE>"f"						strcopy((char*)"\f");BEGIN(STRING);
<STRESCAPE>"\""						strcopy((char*)"\"");BEGIN(STRING);
<STRESCAPE>"\\"						strcopy((char*)"\\");BEGIN(STRING);
<STRESCAPE>.						genError(inv_syn, yytext, yylineno);BEGIN(STRING);
<STRING>.							strcopy(yytext);
<INITIAL>{INT}						SAVE_INT;return TOKEN(INTEGER);
<INITIAL>"true"|"false"				return TOKEN(BOOL);
<INITIAL>"class"					return TOKEN(CLASS);
<INITIAL>{CLASS_ID}					return TOKEN(TYPE);
<INITIAL>";" 						return TOKEN(SEMICOLON);
<INITIAL>":"						return TOKEN(COLON);
<INITIAL>"+"						return TOKEN(ADD);
<INITIAL>"-"						return TOKEN(SUB);
<INITIAL>"/"						return TOKEN(DIV);
<INITIAL>"*"						return TOKEN(MULT);
<INITIAL>"=="						return TOKEN(EQEQ);
<INITIAL>"=>"						return TOKEN(ARROW);
<INITIAL>"<="						return TOKEN(LTEQ);
<INITIAL>"<"						return TOKEN(LT);
<INITIAL>"="						return TOKEN(EQ);
<INITIAL>"!"						return TOKEN(EXM);
<INITIAL>"new"						return TOKEN(NEW);
<INITIAL>"def"						return TOKEN(DEF);
<INITIAL>"("						return TOKEN(PAR_OPEN);
<INITIAL>")"						return TOKEN(PAR_CLOSE);
<INITIAL>"{"						indent++;return TOKEN(BRACE_OPEN);
<INITIAL>"}"						{
										if (indent > 0) {indent--; return TOKEN(BRACE_CLOSE);}
										else genError(ill_chr, (char*)"}", yylineno);
									}
<INITIAL>"var"						return TOKEN(VAR);
<INITIAL>"native"					{
										if (strcmp(filePath, "$CLASSHOME/lib/basic.cool")) return TOKEN(NATIVE);
										else genError(ill_nat, yytext, yylineno);
									}
<INITIAL>"abstract"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"catch"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"do"						genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"final"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"finally"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"for"						genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"forsome"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"implicit"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"import"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"lazy"						genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"object"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"package"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"private"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"protected"				genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"requires"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"return"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"sealed"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"throw"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"trait"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"try"						genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"type"						genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"val"						genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"with"						genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>"yield"					genError(ill_key, yytext, yylineno); //Ilegal keyword
<INITIAL>{ID}						return TOKEN(ID);
<*>{WS}								{}
<*>.								genError(ill_chr, yytext, yylineno); //Generates correct and incorrect errors.

%%
/** C/C++ Functions **/

/* Grabs the next file to process */
void nextFile() {
	getcwd(path, sizeof(path));
	strcat(path,"/");
	strcat(path,args[currfile]);
	currfile++;
	FILE* yyin = fopen(path,"r");
	filePath = path;
}
