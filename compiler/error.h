#include <cstdarg>
#include <string>
#include <iostream>

#define RED "\x1B[31m"
#define WHITE "\x1B[37m"

const std::string error = " [\x1B[31mERROR\x1B[37m]";
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
		std::cerr << error << " Ilegal character '" << text << "', in line "<<  lineNr << "." << std::endl;// Used by flex if an unknown character is detected.
		break;
	case ill_key:
		std::cerr << error << " Ilegal keyword \"" << text << "\", in line  " << lineNr << "." << std::endl;// Used by bison
		break;
	case ill_nln:
		std::cerr << error + " Ilegal newline found in string, in line " << lineNr << "." << std::endl;
		break;
	case inv_syn:
		std::cerr << error << " Ilegal syntax \"" << text << "\", in line " << lineNr << "." << std::endl;
		break;
	case typ_err:
		va_list args;
		va_start(args, lineNr);
		std::cerr << error << " Incorrect type, expected \"" << va_arg(args, char*) << "\" but got \"" << va_arg(args, char*) << "\", at word \"" << text << "\", in line " << lineNr << "." << std::endl;
		break;
	case ill_nat:
		std::cerr << error << " Found keyword \"native\" outside basic.cool, in line " << lineNr << "." << std::endl;
		break;
	default:
		std::cerr << error << " An unexpected error occured!" << std::endl;
		break;
	}
	++nrErrors;
}
