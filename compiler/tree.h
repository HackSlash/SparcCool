/** C/C++ Imports **/
#include <string>

/** A Node, used to build the GrammarTree **/
class Node
{
public:
	/** Constructor & Destructor **/
	Node() : left(NULL), right(NULL) {}
	~Node() {}
	
	/** Add a left child Node **/
	bool addLeft(Node c) {
		if (left!=NULL) return left->addLeft(c);
		left = &c;
		return true;
	}
	/** Add right child Node **/
	bool addRight(Node c) {
		if (right!=NULL) return right->addRight(c);
		right = &c;
		return true;
	}
	/** Declarations of child nodes **/
	Node* left;
	Node* right;
};
/** A node with a string value, used to build the GrammarTree **/
class StringNode : Node
{
public:
	/** Constructor & Destructor **/
	StringNode(std::string s) : val(s) {}
	~StringNode(){}

private:
	/** Declaration of the string value **/
	std::string val;
};
/** A node with an int value, used to build the GrammarTree **/
class IntNode : Node
{
public:
	/** Constructor & Destructor **/
	IntNode(int i) : val(i) {}
	~IntNode() {}
private:
	/** Declaration of the int value **/
	int val;
};
/** A node with a bool value, used to build the GrammarTree **/
class BoolNode : Node
{
public:
	/** Constructor & Destructor **/
	BoolNode(bool b) : val(b) {}
	~BoolNode() {}
private:
	/** Declaration of the bool value **/
	bool val;
};
/** A node for when an error occurs, used to build the GrammarTree **/
class ErrorNode : Node
{
public:
	/** Constructor & Destructor **/
	ErrorNode(std::string txt, int line) : text(txt), lineno(line) {}
	~ErrorNode() {}
private:
	/** Declaration of the Text and LineNumber needed to generate the error message **/
	std::string text;
	int lineno;
};