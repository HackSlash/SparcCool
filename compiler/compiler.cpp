#include "compiler.h"

int filecount;
int currfile;
char const *args[128];
char path[1024];
int indent;
int identifierCount;
int comIndent;
char* stringBuffer;
int stringBufferLoc;
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

void yyerror(const char *s)
{
	fprintf(stderr, "%s\n", s);
}