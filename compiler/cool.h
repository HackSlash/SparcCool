typedef char bool;
#define true 1
#define false 0

typedef enum {id = 0, 
				var, 
				Int, 
				String, 
				Float, 
				Bool, 
				Char, 
				semicolon, 
				colon, 
				add, 
				sub, 
				divide, 
				mult, 
				eq, 
				classname, 
				type, 
				if_s, 
				else_s, 
				while_s, 
				match_s, 
				case_s, 
				comma, 
				par_open, 
				par_close,
				brack_open,
				brack_close,
				brace_open,
				brace_close,
				double_eq,
				lt,
				gt,
				gteq,
				lteq,
				neq,
				new_kw,
				def,

			} token;

int indent;
int identifierCount;
int comIndent=0;
token* savedTokens;
char* stringBuffer;
int stringBufferLoc=0;
char charbuff;

int errCount;
int warnCount;

void strcopy(char* yytext) {
	strncpy(stringBuffer+stringBufferLoc,yytext,1);
	stringBufferLoc++;
}
void strdone() {
	stringBufferLoc=0;
}

void printToken(token type);
void genError(int line, char* characters);
void getNextToken();