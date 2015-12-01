#include <vector>
#include <string>
#include <cstdlib>

enum types { Int, Bool, String, Unit, Null, Nothing, Any };

class symbol
{
public:
	symbol(std::string sid, types stype, unsigned int sref) : id(sid), type(stype), ref(sref) {

	}
	~symbol();
	std::string id;
	types type;
	unsigned int ref;
};

extern std::vector<strTableEntry> stringTable;
extern std::vector<intTableEntry> intTable;
extern std::vector<symbol> idTable;

class strTableEntry
{
public:
	strTableEntry(std::string v) {
		bool foundInTable = false;
		for (std::vector<strTableEntry>::iterator i = stringList.begin(); i != stringList.end(); ++i)
		{
			if (stringList[i] == v)
			{
				foundInTable = true;
				break;
			}
		}
	}
	~strTableEntry();
	int id;
	std::string val;
};

class intTableEntry
{
public:
	intTableEntry(std::string v) {
		bool foundInTable = false;
		for (std::vector<strTableEntry>::iterator i = stringList.begin(); i != stringList.end(); ++i)
		{
			if (stringList[i] == v)
			{
				foundInTable = true;
				break;
			}
		}
	}
	~intTableEntry();
	int id;
	int val;
};