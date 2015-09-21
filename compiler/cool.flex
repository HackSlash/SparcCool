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
	#define SAVE_TOKEN strcpy(yylval.string,yytext)
	#define TOKEN(t) (yylval.token = t)
}

CLASS_ID							[A-Z][A-Za-z0-9]*
ID									[a-z][A-Za-z0-9]*
SIGN 								[+|-]
INT 								0|[1-9][0-9]*
WS									[" "|"\t"|"\n"]

%s COMMENT STRING STRESCAPE CHAR CHARESCAPE
%%
<INITIAL,COMMENT>"/*"				{
										if(comIndent==0)
											BEGIN(COMMENT);
										comIndent++;
									}
<INITIAL,COMMENT>"//"+.*$			;//printf("Comment found\n");
<COMMENT>[^"*/"]						{}
<COMMENT>"*/"						{
										comIndent--;
										if(comIndent==0) {
											BEGIN(INITIAL);
											//printf("Comment found\n");
										}
									}
<COMMENT>.							;
<INITIAL>"'"						BEGIN(CHAR);
<CHAR>.								charbuff=*yytext;//strncpy(charbuff,yytext,1);
<CHAR>"\\"							BEGIN(CHARESCAPE);
<CHARESCAPE>"n"						charbuff='\n';BEGIN(CHAR);
<CHARESCAPE>.						BEGIN(CHAR);
<CHAR>"'"							printToken(Char);BEGIN(INITIAL);
<INITIAL>"\""						BEGIN(STRING);
<STRING>"\""							printToken(String);strdone();BEGIN(INITIAL);
<STRING>"\\"							BEGIN(STRESCAPE);
<STRESCAPE>"n"						strcopy("\n");BEGIN(STRING);
<STRESCAPE>.						BEGIN(STRING);
<STRING>.							strcopy(yytext);
<INITIAL>{INT}+"."+{INT}+"f"		printToken(Float);
<INITIAL>{INT}						printToken(Int);
<INITIAL>"true"|"false"				printToken(Bool);
<INITIAL>"class "+{CLASS_ID}		printToken(classname);
<INITIAL>{CLASS_ID}					printToken(type);
<INITIAL>";" 						printToken(semicolon);
<INITIAL>":"						printToken(colon);
<INITIAL>"+"						printToken(add);
<INITIAL>"-"						printToken(sub);
<INITIAL>"/"						printToken(divide);
<INITIAL>"*"							printToken(mult);
<INITIAL>"="						printToken(eq);
<INITIAL>"var"						printToken(var);
<INITIAL>{ID}						printToken(id);
<INITIAL>"{"						indent++;
<INITIAL>"}"						{
										if (indent > 0) indent--; 
										else genError(yylineno, "}");
									}
<*>"\n"								printf("\n");
%%

int main(int argc, char const *argv[])
{
	stringBuffer = (char*)calloc(1000, sizeof(char));
	savedTokens = (token*)calloc(1000000, (sizeof(token)));
	indent = 0;
	identifierCount = 0;
	classFound = false;
	className = (char*)malloc(sizeof(char) * 15);
	yylex();
	free(savedTokens);
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

// id = 0, var, Int, String, Float, Bool, Char, semicolon, colon, add, sub, divide, mult, eq, classname

void printToken(token t_type) {
	switch(t_type){
		case id:
			printf("{ID,%s}", yytext);
			break;
		case Int:
			printf("{Int,%s}", yytext);
			break;
		case String:
			printf("{String,%s}", stringBuffer);
			break;
		case Bool:
			printf("{Bool,%s}", yytext);
			break;
		case Char:
			printf("{Char,%c}", charbuff);
			break;
		case semicolon:
			printf("{semicolon}");
			break;
		case colon:
			printf("{colon}");
			break;
		case add:
			printf("{add}");
			break;
		case sub:
			printf("{sub}");
			break;
		case divide:
			printf("{divide}");
			break;
		case mult:
			printf("{mult}");
			break;
		case classname:
			printf("{classname,%s}", yytext+6);
			break;
		case eq:
			printf("{eq}");
			break;
		case var:
			printf("{var}");
			break;
		case Float:
			printf("{Float,%s}", yytext);
			break;
		case type:
			printf("{type,%s}", yytext);
			break;
		default:
			//printf("FAIL");
			break;
	}
}
