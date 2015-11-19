#include <vector>
#include <string>

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

extern std::vector<strTableEntry> stringList;

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

typedef struct
{
	int id;
	std::string val;
} strTableEntry;

int addStrEntry(std::string v) {

}

std::vector<int> idList;
bool True = true;
bool False = false;
