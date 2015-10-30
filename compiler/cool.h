#include <string.h>
#include "tree.h"
#include "tree_gen.h"

//typedef Node<void*> YYSTYPE;

int yylex (void);

int filecount;
int currfile;
char const *args[128];
char path[1024];
int indent;
int identifierCount;
int comIndent=0;
//token* savedTokens;
char* stringBuffer;
int stringBufferLoc=0;
char charbuff;
int warnCount;
char* filePath;

void strcopy(char* yytext) {
	strncpy(stringBuffer+stringBufferLoc,yytext,1);
	stringBufferLoc++;
}
void strdone() {
	stringBufferLoc=0;
}

void nextFile();
