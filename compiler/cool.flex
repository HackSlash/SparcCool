/*
 * Main FLEX file
 * TODO: define COOL language based on documentation
 * Start point: recognise classes as such
 */
%pointer

%top{
	#include "cool.h"
	#include <stdio.h>
	#include <string.h>
}
	
CLASS_ID				[A-Z][A-Za-z0-9]*
ID 						[a-zA-Z][A-Za-z0-9]*
CHAR 					[a-zA-Z]
SIGN 					[+|-]
INT 					{SIGN}?0?[0-9]*

%%
"class "+{CLASS_ID}		printToken(classname, yytext);//setFoundClass(yytext);
{ID}+"="+{INT}+";"		printToken(assignment, yytext);
"{"						indent++;
"}"						indent--;
%%

int main(int argc, char const *argv[])
{
	indent = 0;
	identifierCount = 0;
	classFound = false;
	className = (char*)malloc(sizeof(char) * 15);
	yylex();
	//printf("\n\nClass found: %s\n\n", classFound?className:"Nothing");
	//printf("%s\n", (indent==0)?"No syntax errors!":(indent>0)?"Missing \"}\"":"Missing \"{\"");
	return 0;
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