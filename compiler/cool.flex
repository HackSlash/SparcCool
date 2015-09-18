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
FEATURE						[a-z][A-Za-z0-9]*
CHAR 						[a-zA-Z]
SIGN 						[+|-]
INT 						[0|{SIGN}?[1-9][0-9]*]
WS							[" "|"\t"|"\n"]


%s COMMENT
%%
<*>"class "+{CLASS_ID}		printToken(classname, yytext);//setFoundClass(yytext);
<*>{FEATURE}+"="+{INT}+";"	printToken(assignment, yytext);
<*>"/*"						{
								if(comIndent==0)
									BEGIN(COMMENT);
								comIndent++;
							}
<INITIAL>"//"+.*$			printf("Comment found\n");
<COMMENT>"*/"				{
								if(comIndent==1) {
									BEGIN(INITIAL);
									printf("Comment found\n");
								}
								else comIndent--;
							}
<COMMENT>.					;
<*>"{"						indent++;
<*>"}"						{
								if (indent > 0) indent--; 
								else genError(yylineno, "}");
							}
<*>"\n"						{}
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
