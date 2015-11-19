#include "compiler.h"
#include <string>

int filecount;
int currfile;
char const *args[128];
char path[1024];
int indent;
int identifierCount;
int comIndent;
std::string stringBuffer;
int stringBufferLoc;
char charbuff;
int warnCount;
char* filePath;

void strcopy(char* yytext) {
	/*strncpy(stringBuffer+stringBufferLoc,yytext,1);
	stringBufferLoc++;*/
	stringBuffer += yytext;
}
void strdone() {
	stringBufferLoc=0;
}

void yyerror(const char *s)
{
	fprintf(stderr, "%s\n", s);
}