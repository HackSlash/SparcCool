/*
 * Main FLEX file
 * TODO: define COOL language based on documentation
 * Start point: recognise classes as such
 */
%array

%top{
	#include "cool.h"
	#include <stdio.h>
	#include <string.h>
}
	
CLASS_ID				[A-Z][A-Za-z0-9]*
ID 						[a-zA-Z][A-Za-z0-9]*
CHAR 					[a-zA-Z]

%%
"class "+{CLASS_ID}		setFoundClass(yytext);
"{"						indent++;
"}"						indent--;
%%

int main(int argc, char const *argv[])
{
	indent = 0;
	classFound = false;
	className = (char*)malloc(sizeof(char) * 15);
	yylex();
	printf("\n\nClass found: %s\n\n", classFound?className:"Nothing");
	printf("%s\n", (indent==0)?"No syntax errors!":(indent>0)?"Missing \"}\"":"Missing \"{\"");
	return 0;
}

void setFoundClass(char* in) {
	classFound = true;
	strcpy(className,in+6);
	//printf("\n%s\n", className);
}