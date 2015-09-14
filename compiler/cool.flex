/*
 * Main FLEX file
 * TODO: define COOL language based on documentation
 * Start point: recognise classes as such
 */

bool classFound = false;

%%
class 			classFound=true;
%%

int main(int argc, char const *argv[])
{
	yylex();
	printf("%s\n", (classFound?"Found a class!":"No class found!"));
	return 0;
}