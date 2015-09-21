/*
 * Main FLEX file
 * TODO: define COOL language based on documentation
 * Start point: recognise classes as such
 */
%pointer
%option yylineno

%top{
	#include "cool.h"
	#include <stdio.h>
	#include <string.h>
}
	
CLASS_ID					[A-Z][A-Za-z0-9]*
ID							[a-z][A-Za-z0-9]*
CHAR 						[a-zA-Z]
SIGN 						[+|-]
INT 						[0|[1-9][0-9]*]
WS							[" "|"\t"|"\n"]

tokens: String, Char

%s COMMENT
%%
<INITIAL>{INT}+"."+{INT}		printToken(Float, yytext);
<INITIAL>{INT}					printToken(Int, yytext);
<INITIAL>{ID}					printToken(id, yytext);
<INITIAL>["true"|"false"]		printToken(Bool, yytext);
<INITIAL>{CHAR}					printToken(Char, yytext);NIET AF
<INITIAL>"class "+{CLASS_ID}	printToken(classname, yytext);
<INITIAL>";" 					printToken(semicolon, yytext);
<INITIAL>":"					printToken(colon, yytext);
<INITIAL>"+"					printToken(add, yytext);
<INITIAL>"-"					printToken(sub, yytext);
<INITIAL>"/"					printToken(divide, yytext);
<INITIAL>"*"					printToken(mult, yytext);



<INITIAL>"/*"					{
									if(comIndent==0)
										BEGIN(COMMENT);
									comIndent++;
								}
<COMMENT>"*/"					if(comIndent==1) BEGIN(INITIAL); else comIndent--;flex single line comments
								
<COMMENT>.						;
<INITIAL>"{"					indent++;
<INITIAL>"}"					{
									if (indent > 0) indent--; 
									else genError(yylineno, "}");
								}
<INITIAL>"\n"					{}
%%

int main(int argc, char const *argv[])
{
	indent = 0;
	identifierCount = 0;
	classFound = false;
	className = (char*)malloc(sizeof(char) * 15);
	yylex();
	return 0;
}

void genError(int line, char* characters) {
	printf("\n Error in line %d, got \'%s\'\n",line, characters );
}

void setFoundClass(char* in) {
	classFound = true;
	strcpy(className,in+6);
	//printf("\n%s\n", className);
}

int getIntValue(char* in) {
	char* buff = (char*)malloc(sizeof(char) * 15);
	strcpy(buff, in+6);
	buff[strlen(buff)-1] = 0;
	int ret = atoi(buff);
	free(buff);
	return ret;
}

void printClassName(char* text) {
	char* name = (char*)malloc(sizeof(char) * 15);
	strcpy(name, text+6);
	printf("{class,%s}\n", name);
	free(name);
}

void printToken(token type, char* text) {
	switch(type){
		case id:
			printf("{ID,%d}", ++identifierCount);
			break;
		case val:
			printf("{val,...}");
			break;
		case classname:
			printClassName(text);
			break;
		case assignment:
			printf("{int,%d}", getIntValue(text));
			break;
		default:
			printf("EOF");
			break;
	}
}
