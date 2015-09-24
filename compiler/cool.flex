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
<INITIAL>"!"						printToken(exm_s);
<INITIAL>"this"						printToken(this);
<INITIAL>"super"					printToken(super);
<INITIAL>"override"					printToken(override);
<INITIAL>"null"						printToken(null);
<INITIAL>"extends"					printToken(extends);
<INITIAL>"if"						printToken(if_s);
<INITIAL>"else"						printToken(else_s);
<INITIAL>"while"					printToken(while_s);
<INITIAL>"match"					printToken(match_s);
<INITIAL>"case"						printToken(case_s);
<INITIAL>"\"\"\""					BEGIN(TRSTRING);
<TRSTRING>"\"\"\""					printToken(String);strdone();BEGIN(INITIAL);
<TRSTRING>.							strcopy(yytext);
<INITIAL>"'"						BEGIN(CHAR);
<CHAR>"'"							printToken(Char);BEGIN(INITIAL);
<CHAR>"\\"							BEGIN(CHARESCAPE);
<CHAR>.								charbuff=*yytext;
<CHARESCAPE>"n"						charbuff='\n';BEGIN(CHAR);
<CHARESCAPE>.						BEGIN(CHAR);
<INITIAL>"\""						BEGIN(STRING);
<STRING>"\""							printToken(String);strdone();BEGIN(INITIAL);
<STRING>"\n"							genError(yylineno,"LF");//printf(RED "\n\nFatal error: Newline in String literal!\n");yyterminate();
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
<INITIAL>"=="						printToken(double_eq);
<INITIAL>">="						printToken(gteq);
<INITIAL>"<="						printToken(lteq);
<INITIAL>"<"						printToken(lt);
<INITIAL>">"						printToken(gt);
<INITIAL>"!="						printToken(neq);
<INITIAL>"="						printToken(eq);
<INITIAL>"new"						printToken(new_kw);
<INITIAL>"def"						printToken(def);
<INITIAL>"("						printToken(par_open);
<INITIAL>")"						printToken(par_close);
<INITIAL>"{"						printToken(brace_open);
<INITIAL>"}"						printToken(brace_close);
<INITIAL>"["						printToken(brack_open);
<INITIAL>"]"						printToken(brack_close);
<INITIAL>"var"						printToken(var);
<INITIAL>{ID}						printToken(id);
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
	printf(WHITE);
	stringBuffer = (char*)calloc(1000, sizeof(char));
	savedTokens = (token*)calloc(1000000, (sizeof(token)));
	indent = 0;
	identifierCount = 0;
	yylex();
	free(savedTokens);
	return 0;
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
