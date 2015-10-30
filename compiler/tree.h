#include <string>

class Node
{
public:
	Node() {
		left = right = NULL;
	}
	~Node() {
	}
	bool addChild(Node c, bool r) {
		if (r) {
			if (right!=NULL) return right->addChild(c,r);
			right = &c;
		}
		else {
			if (left!=NULL) return left->addChild(c,r);
			left = &c;
		}
		return true;
	}
	Node* left;
	Node* right;
};

class StringNode : Node
{
public:
	StringNode(char* s){
		val = s;
	}
	~StringNode(){
	}

private:
	std::string val;
};

class IntNode : Node
{
public:
	IntNode(int i) {
		val = i;
	}
	~IntNode() {
	}
private:
	int val;	
};

class BoolNode : Node
{
public:
	BoolNode(bool i) {
		val = i;
	}
	~BoolNode() {
	}
private:
	bool val;	
};