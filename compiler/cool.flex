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
	#include <unistd.h>
	#include <string.h>

	extern YYSTYPE yylval;

	#define SAVE_STRING strcpy(yylval.string,stringBuffer)
	#define SAVE_CHAR strcpy(yylval.string,charbuff)
	#define TOKEN(t) (yylval.token = t)
	#define RED "\x1B[31m"
	#define WHITE "\x1B[37m"
}

CLASS_ID							[A-Z][A-Za-z0-9]*
ID									[a-z][A-Za-z0-9]*
SIGN 								[+|-]
INT 								0|[1-9][0-9]*
WS									[" "|"\t"|"\n"]

%s COMMENT STRING STRESCAPE CHAR CHARESCAPE TRSTRING
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
<INITIAL>"!"						return TOKEN(EXM_S);
<INITIAL>"this"						return TOKEN(THIS);
<INITIAL>"super"					return TOKEN(SUPER);
<INITIAL>"override"					return TOKEN(OVERRIDE);
<INITIAL>"null"						return TOKEN(NULLVAL);
<INITIAL>"extends"					return TOKEN(EXTENDS);
<INITIAL>"if"						return TOKEN(IF_S);
<INITIAL>"else"						return TOKEN(ELSE_S);
<INITIAL>"while"					return TOKEN(WHILE_S);
<INITIAL>"match"					return TOKEN(MATCH_S);
<INITIAL>"case"						return TOKEN(CASE_S);
<INITIAL>","						return TOKEN(COMMA);
<INITIAL>"."						return TOKEN(DOT);
<INITIAL>"\"\"\""					BEGIN(TRSTRING);
<TRSTRING>"\"\"\""					SAVE_STRING;strdone();BEGIN(INITIAL);return TOKEN(STRING);
<TRSTRING>.							strcopy(yytext);
<INITIAL>"'"						BEGIN(CHAR);
<CHAR>"'"							SAVE_CHAR;BEGIN(INITIAL);return TOKEN(CHAR);
<CHAR>"\\"							BEGIN(CHARESCAPE);
<CHAR>.								charbuff=*yytext;
<CHARESCAPE>"n"						charbuff='\n';BEGIN(CHAR);
<CHARESCAPE>"0"						charbuff="\0";BEGIN(CHAR);
<CHARESCAPE>"b"						charbuff="\b";BEGIN(CHAR);
<CHARESCAPE>"t"						charbuff="\t";BEGIN(CHAR);
<CHARESCAPE>"r"						charbuff="\r";BEGIN(CHAR);
<CHARESCAPE>"f"						charbuff="\f";BEGIN(CHAR);
<CHARESCAPE>"\""						charbuff="\"";BEGIN(CHAR);
<CHARESCAPE>"\\"						charbuff="\\";BEGIN(CHAR);
<CHARESCAPE>.						generror(yylineno,yytext);BEGIN(CHAR);
<INITIAL>"\""						BEGIN(STRING);
<STRING>"\""							SAVE_STRING;strdone();BEGIN(INITIAL);return TOKEN(STRING);
<STRING>"\n"							genError(yylineno,"LF");//printf(RED "\n\nFatal error: Newline in String literal!\n");yyterminate();
<STRING>"\\"							BEGIN(STRESCAPE);
<STRESCAPE>"n"						strcopy("\n");BEGIN(STRING);
<STRESCAPE>"0"						strcopy("\0");BEGIN(STRING);
<STRESCAPE>"b"						strcopy("\b");BEGIN(STRING);
<STRESCAPE>"t"						strcopy("\t");BEGIN(STRING);
<STRESCAPE>"r"						strcopy("\r");BEGIN(STRING);
<STRESCAPE>"f"						strcopy("\f");BEGIN(STRING);
<STRESCAPE>"\""						strcopy("\"");BEGIN(STRING);
<STRESCAPE>"\\"						strcopy("\\");BEGIN(STRING);
<STRESCAPE>.						generror(yylineno,yytext);BEGIN(STRING);
<STRING>.							strcopy(yytext);
<INITIAL>{INT}+"."+{INT}+"f"		return TOKEN(FLOAT);
<INITIAL>{INT}						return TOKEN(INTEGER);
<INITIAL>"true"|"false"				return TOKEN(BOOL);
<INITIAL>"class"					return TOKEN(CLASS);
<INITIAL>{CLASS_ID}					return TOKEN(TYPE);
<INITIAL>";" 						return TOKEN(SEMICOLON);
<INITIAL>":"						return TOKEN(COLON);
<INITIAL>"+"						return TOKEN(ADD);
<INITIAL>"-"						return TOKEN(SUB);
<INITIAL>"/"						return TOKEN(DIV);
<INITIAL>"*"						return TOKEN(MULT);
<INITIAL>"=="						return TOKEN(DOUBLE_EQ);
<INITIAL>">="						return TOKEN(GTEQ);
<INITIAL>"<="						return TOKEN(LTEQ);
<INITIAL>"<"						return TOKEN(LT);
<INITIAL>">"						return TOKEN(GT);
<INITIAL>"!="						return TOKEN(NEQ);
<INITIAL>"="						return TOKEN(EQ);
<INITIAL>"new"						return TOKEN(NEW_KW);
<INITIAL>"def"						return TOKEN(DEF);
<INITIAL>"("						return TOKEN(PAR_OPEN);
<INITIAL>")"						return TOKEN(PAR_CLOSE);
<INITIAL>"{"						return TOKEN(BRACE_OPEN);
<INITIAL>"}"						return TOKEN(BRACE_CLOSE);
<INITIAL>"["						return TOKEN(BRACK_OPEN);
<INITIAL>"]"						return TOKEN(BRACK_CLOSE);
<INITIAL>"var"						return TOKEN(VAR);
<INITIAL>{ID}						return TOKEN(ID);
<INITIAL>"{"						indent++;
<INITIAL>"}"						{
										if (indent > 0) indent--; 
										else genError(yylineno, "}");
									}
<*>"\n"								printf("\n");
<*>{WS}								{}
<*>.									genError(yylineno, yytext);
%%

int main(int argc, char const *argv[])
{
	if (argc > 1) {
		memcpy(args,argv,128*1024);
		filecount = argc-1;
		currfile = 1;
		nextFile();
	}
	printf(WHITE);
	stringBuffer = (char*)calloc(1000, sizeof(char));
	savedTokens = (token*)calloc(1000000, (sizeof(token)));
	indent = 0;
	identifierCount = 0;
	printf("%d",yylex());
	free(savedTokens);
	return 0;
}

void nextFile() {
	getcwd(path, sizeof(path));
	strcat(path,"/");
	strcat(path,args[currfile]);
	currfile++;
	FILE* yyin = fopen(path,"r");
}

int yywrap() {

}

void genError(int line, char* characters) {
	printf(RED "\n Error in line %d, got \'%s\'\n",line, characters );
	printf(WHITE);
}
