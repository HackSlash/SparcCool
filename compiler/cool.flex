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
<INITIAL,COMMENT>"//"+.*$			;//printf("Comment found\n");
<COMMENT>[^"*/"]						{}
<COMMENT>"*/"						{
										comIndent--;
										if(comIndent==0) {
											BEGIN(INITIAL);
											//printf("Comment found\n");
										}
									}
<COMMENT>.
<INITIAL>"!"						return TOKEN(exm_s);
<INITIAL>"this"						return TOKEN(this);
<INITIAL>"super"					return TOKEN(super);
<INITIAL>"override"					return TOKEN(override);
<INITIAL>"null"						return TOKEN(null);
<INITIAL>"extends"					return TOKEN(extends);
<INITIAL>"if"						return TOKEN(if_s);
<INITIAL>"else"						return TOKEN(else_s);
<INITIAL>"while"					return TOKEN(while_s);
<INITIAL>"match"					return TOKEN(match_s);
<INITIAL>"case"						return TOKEN(case_s);
<INITIAL>"\"\"\""					BEGIN(TRSTRING);
<TRSTRING>"\"\"\""					SAVE_STRING;strdone();BEGIN(INITIAL);return TOKEN(String);
<TRSTRING>.							strcopy(yytext);
<INITIAL>"'"						BEGIN(CHAR);
<CHAR>"'"							SAVE_CHAR;BEGIN(INITIAL);return TOKEN(Char);
<CHAR>"\\"							BEGIN(CHARESCAPE);
<CHAR>.								charbuff=*yytext;
<CHARESCAPE>"n"						charbuff='\n';BEGIN(CHAR);
<CHARESCAPE>.						BEGIN(CHAR);
<INITIAL>"\""						BEGIN(STRING);
<STRING>"\""							SAVE_STRING;strdone();BEGIN(INITIAL);return TOKEN(String);
<STRING>"\n"							genError(yylineno,"LF");//printf(RED "\n\nFatal error: Newline in String literal!\n");yyterminate();
<STRING>"\\"							BEGIN(STRESCAPE);
<STRESCAPE>"n"						strcopy("\n");BEGIN(STRING);
<STRESCAPE>.						BEGIN(STRING);
<STRING>.							strcopy(yytext);
<INITIAL>{INT}+"."+{INT}+"f"		return TOKEN(Float);
<INITIAL>{INT}						return TOKEN(Int);
<INITIAL>"true"|"false"				return TOKEN(Bool);
<INITIAL>"class "+{CLASS_ID}		return TOKEN(classname);
<INITIAL>{CLASS_ID}					return TOKEN(type);
<INITIAL>";" 						return TOKEN(semicolon);
<INITIAL>":"						return TOKEN(colon);
<INITIAL>"+"						return TOKEN(add);
<INITIAL>"-"						return TOKEN(sub);
<INITIAL>"/"						return TOKEN(divide);
<INITIAL>"*"							return TOKEN(mult);
<INITIAL>"=="						return TOKEN(double_eq);
<INITIAL>">="						return TOKEN(gteq);
<INITIAL>"<="						return TOKEN(lteq);
<INITIAL>"<"						return TOKEN(lt);
<INITIAL>">"						return TOKEN(gt);
<INITIAL>"!="						return TOKEN(neq);
<INITIAL>"="						return TOKEN(eq);
<INITIAL>"new"						return TOKEN(new_kw);
<INITIAL>"def"						return TOKEN(def);
<INITIAL>"("						return TOKEN(par_open);
<INITIAL>")"						return TOKEN(par_close);
<INITIAL>"{"						return TOKEN(brace_open);
<INITIAL>"}"						return TOKEN(brace_close);
<INITIAL>"["						return TOKEN(brack_open);
<INITIAL>"]"						return TOKEN(brack_close);
<INITIAL>"var"						return TOKEN(var);
<INITIAL>{ID}						return TOKEN(id);
<INITIAL>"{"						indent++;
<INITIAL>"}"						{
										if (indent > 0) indent--; 
										else genError(yylineno, "}");
									}
<*>"\n"								printf("\n");
<*>{WS}								{}
<*>.									genError(yylineno, yytext);//printf(RED "\n\nFatal error: unexpected input: %s\n", yytext);yyterminate();
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

void printToken(token t_type) {
	switch(t_type){
		case if_s:
			printf("{if}");
			break;
		case extends:
			printf("{extends}");
			break;
		case null:
			printf("{null}");
			break;
		case override:
			printf("{override}");
			break;
		case super:
			printf("{super}");
			break;
		case this:
			printf("{this}");
			break;
		case exm_s:
			printf("{exm_s}");
			break;
		case else_s:
			printf("{else}");
			break;
		case while_s:
			printf("{while}");
			break;
		case match_s:
			printf("{match}");
			break;
		case case_s:
			printf("{case}");
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
		case brace_close:
			printf("{brace_close}");
			break;
		case brace_open:
			printf("{brace_open}");
			break;
		case par_open:
			printf("{par_open}");
			break;
		case par_close:
			printf("{par_close}");
			break;
		case lt:
			printf("{lt}");
			break;
		default:
			printf(RED "FAIL: %d", t_type);
			break;
	}
}
