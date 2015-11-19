#ifndef COOL_H
#define COOL_H

#include <string.h>
#include "tree.h"
#include "tree_gen.h"
#include <stdio.h>
#include <string>

extern "C" int yylex (void);

extern int filecount;
extern int currfile;
extern char const *args[128];
extern char path[1024];
extern int indent;
extern int identifierCount;
extern int comIndent;
extern std::string stringBuffer;
extern int stringBufferLoc;
extern char charbuff;
extern int warnCount;
extern char* filePath;

void strcopy(char* yytext);

void strdone();

void nextFile();

void yyerror(const char *s);

#endif //COOL_H
