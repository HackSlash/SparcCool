#include <vector>
#include <string>

enum types { Int, Bool, String, Unit, Null, Nothing, Any };

class symbol
{
public:
	symbol(std::string id, types type, unsigned int ref)
	{
		this->id = id;
		this->type = type;
		this->ref = ref;
	}
	~symbol();
	std::string id;
	types type;
	unsigned int ref;
};

std::vector<std::string> stringList;
std::vector<int> idList;
bool True = true;
bool False = false;