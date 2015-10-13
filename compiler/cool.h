typedef char bool;
#define true 1
#define false 0

#include <vector>

int filecount;
int currfile;
char const *args[128];
char path[1024];
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
int yywrap();
void nextFile();

typedef struct {
	int id,
	char* data
} stringTableEntry;

typedef struct {
	int id,
	char* name,
	void* data
} varTableEntry;

std::vector<stringTableEntry> stringTable;
std::vector<varTableEntry> varTable;