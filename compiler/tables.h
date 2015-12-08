#include <vector>
#include <string>
#include <cstdlib>

enum types { Int, Bool, String, Unit, Null, Nothing, Any };

addSymbol() {}

class symbol
{
public:
	//symbol() {}
	symbol(std::string sid, types stype) : id(sid), type(stype) {}
	symbol(std::string sid, types stype, std::string val) : id(sid), type(stype), stringVal(val) {}
	symbol(std::string sid, types stype, int val) : id(sid), type(stype), intVal(val) {}
	symbol(std::string sid, types stype, bool val) : id(sid), type(stype), boolVal(val) {}
	~symbol();
	std::string id;
	types type;
	std::string stringVal;
	int intVal;
	bool boolVal;
	
};

class strEntry
{
public:
	strEntry(std::string v) : val(v) {}
	~strEntry();
	std::string val;
};

class intEntry
{
public:
	intEntry(std::string v) {val = std::stoi(v, NULL)}
	~intEntry();
	int val;
};

extern std::vector<strTableEntry> stringTable;
extern std::vector<intTableEntry> intTable;
extern std::vector<symbol> symbolTable;
