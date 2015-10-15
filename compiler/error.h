#include <stdarg.h>

#define RED "\x1B[31m"
#define WHITE "\x1B[37m"

int nrErrors = 0;

typedef enum {
	ill_chr,// Illegal character error
	ill_key,// Ilegal keyword error
	ill_nln,// Ilegal newline error
	inv_syn,// Invalid syntax error
	typ_err // Type error
	ill_nat // Ilegal native error
} errorType;

/** TODO:
 *	Add word/char where the error is
 *	
 */


void genError(errorType er, char* text, int lineNr, int colNr, ...)
{
	switch (er)
	{
	case ill_chr:
		printf("[%sError%s: Ilegal character \'%s\', in line  %d, colom %d.\n", RED, WHITE, text, lineNr, colNr);
		break;
	case ill_key:
		printf("%sError%s: Ilegal keyword \"%s\", in line  %d, colom %d.\n", RED, WHITE, text, lineNr, colNr);
		break;
	case ill_nln:
		printf("[%sError%s: Ilegal newline found in string, in line %d, colom %d.\n", RED, WHITE, lineNr, colNr);
		break;
	case inv_syn:
		printf("%sError%s: Ilegal syntax \"%s\", in line %d, colom %d.\n", RED, WHITE, text, lineNr, colNr);
		break;
	case typ_err:
		va_list args;
		va_start(args, 2);
		printf("%sError%s: Incorrect type, expected \"%s\" but got \"%s\", at word \"%s\", in line %d, colom %d.", RED, WHITE, va_arg(args, char*), va_arg(args, char*), text, lineNr, colNr);
		va_end(args);
		break;
	case ill_nat:
		printf("%sError%s: Found keyword \"native\" outside basic.cool, in line %d, colom %d", RED, WHITE, lineNr, colNr);
		break;
	default:
		printf("%sAn unexpected error occured!%s\n", RED, WHITE);
		break;
	}
	++nrErrors;
}