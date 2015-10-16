#include <cstdarg>

#define RED "\x1B[31m"
#define WHITE "\x1B[37m"

int nrErrors = 0;

typedef enum {
	ill_chr,// Illegal character error
	ill_key,// Ilegal keyword error
	ill_nln,// Ilegal newline error
	inv_syn,// Invalid syntax error
	typ_err, // Type error
	ill_nat // Ilegal native error
} errorType;


void genError(errorType er, char* text, int lineNr, ...)
{
	switch (er)
	{
	case ill_chr:
		printf("[%sError%s: Ilegal character \'%s\', in line %d.\n", RED, WHITE, text, lineNr);
		break;
	case ill_key:
		printf("%sError%s: Ilegal keyword \"%s\", in line  %d.\n", RED, WHITE, text, lineNr);
		break;
	case ill_nln:
		printf("[%sError%s: Ilegal newline found in string, in line %d.\n", RED, WHITE, lineNr);
		break;
	case inv_syn:
		printf("%sError%s: Ilegal syntax \"%s\", in line %d.\n", RED, WHITE, text, lineNr);
		break;
	case typ_err:
		va_list args;
		va_start(args, lineNr);
		printf("%sError%s: Incorrect type, expected \"%s\" but got \"%s\", at word \"%s\", in line %d.", RED, WHITE, va_arg(args, char*), va_arg(args, char*), text, lineNr);
		va_end(args);
		break;
	case ill_nat:
		printf("%sError%s: Found keyword \"native\" outside basic.cool, in line %d.", RED, WHITE, lineNr);
		break;
	default:
		printf("%sAn unexpected error occured!%s\n", RED, WHITE);
		break;
	}
	++nrErrors;
}