template <class T>
class Node
{
public:
	Node(T value);
	~Node();
	bool addChild(Node c, bool r);
	Node* left;
	Node* right;
	T* val;
};