#include <cstdarg>
#include <string>
#include <iostream>

#define RED "\x1B[31m"
#define WHITE "\x1B[37m"

const std::string error = "[\x1B[31mERROR\x1B[37m]";
int nrErrors = 0;

typedef enum {
	ill_chr,// Illegal character error
	ill_key,// Illegal keyword error
	ill_nln,// Illegal newline error
	inv_syn,// Invalid syntax error
	typ_err,// Type error
	ill_nat // Illegal native error
} errorType;

void genError(errorType er, char* text, int lineNr/*, char* fileName*/)
{
	//std::string location = "@\"" + fileName + "\", line " + lineNr + ": ";
	std::string location = "@\"" + ".." "\", line " + lineNr + ": ";

	nrErrors++;
	switch(er)
	{
		case ill_chr:
			std::cerr << error << location << "Ilegal character \"" << text << "\"." << std::endl;
			break;
		case ill_nat:
			std::cerr << error << location << "Use of \"native\" keyword only allowed in cool.basic!" << std::endl;
			break;
		case ill_nln:
			std::cerr << error << location << "Ilegal use of newline character, newline characters are not allowed in strings!" << std::endl;
			break;
		case typ_err:
			va_list args;
			va_start(args, NULL)
			std::cerr << error << location << "Illegal type detected, expected \"" << va_arg(args, char*) << "\" but found \"" << text << "\"." << std::endl;
			va_end(args);
			break;
		case inv_syn:
			std::cerr << error << location << "Incorrect syntax detected, at or near \"" << text << "\"." << std::endl;
			break;
		case ill_key:
			std::cerr << error << location << "Illegal keyword detected, at or near \"" << text << "\"." << std::endl;
			break;
		default:
			std::cerr << error << "An unknown error occured!" << std::endl;
	}
}