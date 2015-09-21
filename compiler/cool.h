typedef char bool;
#define true 1
#define false 0

typedef enum {id = 0, Int, String, Float, Bool, Char, semicolon, colon, add, sub, divide, mult, classname} token;

bool classFound;
char * className;
int indent;
int identifierCount;
int comIndent=0;

void setFoundClass(char* in);
int getIntValue(char* in);
void printToken(token type, char*);
void getClassName(char* in, char* out);
void printClassName(char* text);
void genError(int line, char* characters);