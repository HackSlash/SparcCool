typedef char bool;
#define true 1
#define false 0

typedef enum {id = 0, var, Int, String, Float, Bool, Char, semicolon, colon, add, sub, divide, mult, eq, classname, type, if_s, else_s, while_s, match_s, case_s} token;

bool classFound;
char * className;
int indent;
int identifierCount;
int comIndent=0;
token* savedTokens;
char* stringBuffer;
int stringBufferLoc=0;
char charbuff;

void strcopy(char* yytext) {
	strncpy(stringBuffer+stringBufferLoc,yytext,1);
	stringBufferLoc++;
}
void strdone() {
	stringBufferLoc=0;
}
void setFoundClass(char* in);
int getIntValue(char* in);
void printToken(token type);
void getClassName(char* in, char* out);
void printClassName(char* text);
void genError(int line, char* characters);
void getNextToken();