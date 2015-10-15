class Node
{
public:
	Node();
	~Node();
	bool addChild(Node c);
	
private:
	std::vector<Node> children;
	
};